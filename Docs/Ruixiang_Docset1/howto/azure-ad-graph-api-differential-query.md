---
title: Azure AD Graph API Differential Query
author: JimacoMS
ms.TocTitle: Differential query
ms.ContentId: 893b0d6c-0c03-4108-94f5-30566d3e0df9
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Differential query | Graph API concepts
    
 _**Applies to:** Graph API | Azure Active Directory_


This topic discusses the differential query feature of Azure AD Graph API. A differential query request returns all changes made to specified entities during the time between two consecutive requests. For example, if you make a differential query request an hour after the previous differential query request, only the changes made during that hour will be returned. This functionality is especially useful when synchronizing tenant directory data with an application’s data store.

To make a differential query request to a tenant’s directory, your application must be authorized by the tenant. For more information, see [Integrating Applications with Azure Active Directory](https://azure.microsoft.com/en-us/documentation/articles/active-directory-integrating-applications/).

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token. Note that differential query is not currently supported in Microsoft Graph; you will need to use Azure AD Graph API for this feature.


## Differential query requests <a id="DifferentialQueryRequests"></a>

This section describes differential query requests. All requests require the following components:

- A valid request URL, including the Graph endpoint for the tenant and applicable query string parameters.

- An authorization header, including a valid access token issued by Azure Active Directory. For more information on authenticating to the Graph API, see [Authentication Scenarios for Azure AD](https://azure.microsoft.com/en-us/documentation/articles/active-directory-authentication-scenarios/).

### Differential query request URL

The following shows the format of the URL for differential query request; square brackets [] indicate optional elements.

```no-highlight
https://graph.windows.net/<tenantId>/<resourceSet>?api-version=<SupportedApiVersion>&deltaLink=<token>&[$filter=isof(<entityType>)]&[$select=<PropertyList>]
```

The URL is made up of a hierarchical segments followed by a series of query string parameters expressed as key-value pairs.

### URL: Hierarchical segments

|Segment|Description|
|---|---|
|tenantId|The unique identifier of the tenant that the query should be executed against. This is typically one of the verified domains (**verifiedDomains** property) of the tenant, but it can also be the tenant’s object ID (**objectId** property). Not case-sensitive.|
|resourceSet|The specific set of tenant resources this query should be executed against. Determines what resources are returned in the query response. Supported values are: “directoryObjects”, “users”, “contacts” or “groups”. Values are case-sensitive.|

### URL: Query string parameters

|Parameter|Description|
|---|---|
|api-version|Specifies the version of the Graph API against which the request is issued. Required. Beginning with version 1.5, the value is expressed as a numeric version number; for example, api-version=1.5. For previous versions, the value is a string of the form YYYY-MM-DD; for example, api-version=2013-04-05.<br/> <br/>(Replaces the use of **x-ms-dirapi-data-contract-version** header in the preview version of Graph API.)|
|deltaLink|The token returned in either the **deltaLink** property or the **nextLink** property in the last response. Required, but will be empty on the first request. <br/> <br/>(Replaces the *skipToken* query string parameter in the preview version of Graph API.)|
|$filter|Indicates which entity types should be included in the response. Optional. The supported entity types are: User, Group and Contact. Only valid when &ltresourceSet&gt is “directoryObjects”; otherwise, &ltresourceSet&gt overrides the filter. For example, if &ltresourceSet&gt is “users”, and the *$filter* parameter is also specified, only changes for users will be returned regardless of what is specified in the filter value. If &ltresourceSet&gt is “directoryObjects” and *$filter* is not specified, changes for all of the supported entity types (User, Group, and Contact) are returned.<br/><br/>To specify a single entity type, use one of the following:<ul><li>`$filter=isof('Microsoft.WindowsAzure.ActiveDirectory.Contact')`</li><li>`$filter=isof('Microsoft.WindowsAzure.ActiveDirectory.User')`</li><li>`$filter=isof('Microsoft.WindowsAzure.ActiveDirectory.Group')`</li></ul>To specify multiple entity types, use the **or** operator; for example, `$filter=isof('Microsoft.WindowsAzure.ActiveDirectory.User')%20or%20isof('Microsoft.WindowsAzure.ActiveDirectory.Group')`. <br/> <br/>(Replaces  the *objectScope* query string parameter in the preview version of Graph API.)<br/> <br/>**Important** Beginning with version 1.5, the Graph API namespace is changed from Microsoft.WindowsAzure.ActiveDirectory to Microsoft.DirectoryServices. Earlier versions of the Graph API continue to use the previous namespace; for example, `$filter=isof('Microsoft.WindowsAzure.ActiveDirectory.Contact')`.|
|$select|Specifies which properties should be included in the response. If *$select^ is not specified, all properties are included.<br/><br/>Properties can be specified either fully qualified or non-qualified. Multiple properties are delimited by commas.<ul><li>Fully qualified properties have the entity type specified; for example, `User/displayName`. Fully qualified properties MUST be used if &ltresourceSet&gt is specified as “directoryObjects”; for example, `https://graph.windows.net/contoso.com/directoryObjects?api-version=2013-04-05&deltaLink=&$select=User/displayName,Group/description`.</li><li>Non-qualified properties do not have the entity type specified; for example, `displayName`. They can only be used when &ltresourceSet&gt is specified as a value other than “directoryObjects”; for example, `https://graph.windows.net/contoso.com/users?api-version=2013-04-05&deltaLink=&$select=displayName,jobTitle`.</li></ul>

**Note**: The key-value pairs in the query string are case-sensitive, but their order is not significant.

The following is an example of the simplest differential query. This is used during initial sync.

```no-highlight
https://graph.windows.net/contoso.com/directoryObjects?api-version=2013-04-05&deltaLink=
```

The following is an example of a subsequent request.

```no-highlight
https://graph.windows.net/contoso.com/directoryObjects?api-version=2013-04-05&deltaLink=AAABAGCL8z4m%2bc9IJGIzYjFmYzU5LTg0YjgtNDQwMC1hNzE1LWVhOGE3ZTQwZjRmZQBuvX43ACZQT4LRVPug8An6AAABAANIABAfGgAQwAMAJDCHA5AAABAATCkAA44TADQnhAQAIAAAgAHAAwAQAAAA8rLSTyfq5U`
```

## Differential query responses <a id="DifferentialQueryResponses"></a>

This section describes the contents of a differential query response that is returned when a differential query request is made. The following list describes the contents of a response:

- Zero to 200 [DirectoryObject] entities, each of which contains changes for a specific [User], [Group], or [Contact] object.

- Zero to 3000 [DirectoryLinkChange] entities, each of which contains changes for a specific **member** or **manager** link.

- Either a **deltaLink** or a **nextLink** property. In either case, its value is a case-sensitive, URL-encoded string that embeds state information about the set of directory changes that have been returned to the client, with respect to remaining changes that have occurred in the directory. This string (or token) should be included in the **deltaLink** query string parameter in the next differential query request.

  - If the **deltaLink** property is returned, there are no more directory changes left for the application to synchronize after this response. The application can wait for some predetermined time according to its own requirements to issue the next differential query request.

  - If the **nextLink** property is returned, there are directory changes remaining for the application to synchronize after this response. The application should issue the next differential query request at its earliest convenience.

Responses are always returned in JSON format.

## Considerations when using differential query <a id="ConsiderationsWhenUsingDq"></a>

The following list highlights important considerations for applications that use differential query:

- Changes returned by differential query represent the state of the directory objects at the time of the response. Your application must not treat these changes as transaction logs for replay.

- Changes appear in the order in which they occurred. The most-recently changed objects appear last even if the object was updated multiple times. Their order is also not affected by when the client received the changes. As a result, it is possible for changes to be presented out of order compared to how they initially occurred in the directory.

- Your application must be prepared for replays, which occur when the same change appears in subsequent responses. While differential query makes a best effort to reduce replays, they are still possible.

- Your application must be prepared to handle a deletion change for an object it was not aware of.

- Differential query can return a link to a source or target object that has not yet been returned by other responses.

- See the [Additional differential query features](#AdditionalDifferentialQueryFeatures) section below for more information on using request headers to constrain your queries to improve performance.

## Request and response examples <a id="ReqeustAndResponseExamples"></a>

The following is an example of an initial differential query request:

```no-highlight
GET https://graph.windows.net/contoso.com/directoryObjects?api-version=2013-04-05&$filter=isof('Microsoft.WindowsAzure.ActiveDirectory.User')%20or%20isof('Microsoft.WindowsAzure.ActiveDirectory.Group')%20or%20isof('Microsoft.WindowsAzure.ActiveDirectory.Contact')&deltaLink= HTTP /1.1
Authorization: Bearer eyJ0eXAiOiJKV . . . KUAe1EQ
Host: graph.windows.net
```
The following is an example of an incremental differential query request:

```no-highlight
https://graph.windows.net/contoso.com/directoryObjects?api-version=2013-04-05&$filter=isof('Microsoft.WindowsAzure.ActiveDirectory.User')%20or%20isof('Microsoft.WindowsAzure.ActiveDirectory.Group')%20or%20isof('Microsoft.WindowsAzure.ActiveDirectory.Contact')&deltaLink=AAABAGCL8z4m%2bc9IJGIzYjFmYzU5LTg0YjgtNDQwMC1hNzE1LWVhOGE3ZTQwZjRmZQBuvX43ACZQT4LRVPug8An6AAABAANIABAfGgAQwAMAJDCHA5AAABAATCkAA44TADQnhAQAIAAAgAHAAwAQAAAA8rLSTyfq5U
 HTTP /1.1
Authorization: Bearer eyJ0eXAiOiJKV . . . KUAe1EQ
Host: graph.windows.net
```

**Note**: In both of these sample requests, the *$filter* query parameter is shown for demonstration purposes only. Because the filter specifies all of the possible target types for the differential query (User, Group, and Contact), it could be omitted and the query would return changes for all of these entity types by default.

The following example response demonstrates the returned JSON:

```no-highlight
{
  "odata.metadata": "https://graph.windows.net/contoso.com/$metadata#directoryObjects",


  # This is the deltaLink to be used for the next query
  "aad.deltaLink": "https://graph.windows.net/contoso.com/directoryObjects?deltaLink=XARBN7ivjcS6QIhSZDQR3OkT15SO1eeY-01BZSS0sOct6sh5oEyqOLLKRVhRmBMLHhePUF... [Truncated]",
  "value": [

    # User object for John Smith
    {
      "odata.type": "Microsoft.WindowsAzure.ActiveDirectory.User",
      "objectType": "User",
      "objectId": "dca803ab-bf26-4753-bf20-e1c56a9c34e2",
      "accountEnabled": true,
      "displayName": "John Smith",
      "givenName": "John",
      "mailNickname": "johnsmith",
      "passwordPolicies": "None",
      "surname": "Smith",
      "usageLocation": "US",
      "userPrincipalName": "johnsmith@contoso.com"
    },

    # Group object for IT Administrators
    {
      "odata.type": "Microsoft.WindowsAzure.ActiveDirectory.Group",
      "objectType": "Group",
      "objectId": "7373b0af-d462-406e-ad26-f2bc96d823d8",
      "description": "IT Administrators",
      "displayName": "Administrators",
      "mailNickname": "Administrators",
      "mailEnabled": false,
      "securityEnabled": true
    },

    # Contact object for Jane Smith
    {
      "odata.type": "Microsoft.WindowsAzure.ActiveDirectory.Contact",
      "objectType": "Contact",
      "objectId": "d711a1f8-21cf-4dc0-834a-5583e5324c44",
      "displayName": "Jane Smith",
      "givenName": "Jane",
      "mail": "johnsmith@contoso.com",
      "mailNickname": "johnsmith",
      "proxyAddresses": [
        "SMTP:janesmith@fabrikam.com"
      ],
      "surname": "Smith"
    },

    # Member link indicating John Smith is a member of IT Admin Group
    {
      "odata.type": "Microsoft.WindowsAzure.ActiveDirectory.DirectoryLinkChange",
      "objectType": "DirectoryLinkChange",
      "objectId": "00000000-0000-0000-0000-000000000000",
      "associationType": "Member",
      "sourceObjectId": "7373b0af-d462-406e-ad26-f2bc96d823d8",
      "sourceObjectType": "Group",
      "sourceObjectUri": "https://graph.windows.net/contoso.com/groups/7373b0af-d462-406e-ad26-f2bc96d823d8",
      "targetObjectId": "dca803ab-bf26-4753-bf20-e1c56a9c34e2",
      "targetObjectType": "User",
      "targetObjectUri": "https://graph.windows.net/contoso.com/users/dca803ab-bf26-4753-bf20-e1c56a9c34e2"
    }
  ]
}
```
## Additional differential query features <a id="AdditionalDifferentialQueryFeatures"></a>

Differential Queries can now return only updated properties and links – this allows faster processing and reduced payloads for Differential Query calls. This option is enabled by setting the header **ocp-aad-dq-include-only-changed-properties** to true as shown in this example.

```no-highlight
GET https://graph.windows.net/contoso.com/users?api-version=2013-11-08&deltaLink= furK18V1T….
HTTP /1.1
ocp-aad-dq-include-only-changed-properties : true
Content-Type: application/json
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik5nl0aEV1T….
Response: 200 OK
```

For example if only the “displayName” property of user has changed.  The returned object would be similar to this:

```no-highlight
{     
          "displayName" : "AnUpdatedDisplayName",
         "objectId" :  "c1bf5c59-7974-4aff-a59a-f8dfe9809b18",
         "objectType" :  "User",
          "odata.type" :  "Microsoft.WindowsAzure.ActiveDirectory.User"
},

```

**Differential Sync support to sync from “now”** - a special header can be specified, requesting to only get an up-to-date deltaToken, this token can be used in subsequent queries, which will
return only changes from “now”.  Here’s the example call:

```no-highlight
GET https://graph.windows.net/contoso.com/users?api-version=2013-11-08&deltaLink= smLYT8V1T…
HTTP /1.1
ocp-aad-dq-include-only-delta-token: true
Content-Type: application/json
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik5nl0aEV1T….
Response: 200 OK
```

The response will contain the **deltaLink**, but will not have the changed object(s), similar to this:

```no-highlight
{   …  "aad.deltaLink":https://graph.windows.net/contoso.com/users?deltaLink=MRa43......   }
```

**Detecting a deleted item** – the response can also be used to detect a deleted item.  Deleted objects and deleted links are indicated by the "aad.isDeleted" property with a value set to true; this is necessary to make sure applications can learn about the deletion of previously created objects and links.

##Additional resources <a id="AdditionalResources"></a>

- [Azure AD Graph API reference](../api/api-catalog.md)

[Application]: ../api/entity-and-complex-type-reference.md#ApplicationEntity
[AppRoleAssignment]: ../api/entity-and-complex-type-reference.md#AppRoleAssignmentEntity
[Contact]: ../api/entity-and-complex-type-reference.md#ContactEntity
[Contract]: ../api/entity-and-complex-type-reference.md#ContractEntity
[Device]: ../api/entity-and-complex-type-reference.md#DeviceEntity
[DirectoryLinkChange]: ../api/entity-and-complex-type-reference.md#DirectoryLinkChangeEntity
[DirectoryObject]: ../api/entity-and-complex-type-reference.md#DirectoryObjectEntity
[DirectoryRole]: ../api/entity-and-complex-type-reference.md#DirectoryRoleEntity
[DirectoryRoleTemplate]: ../api/entity-and-complex-type-reference.md#DirectoryRoleTemplateEntity
[ExtensionProperty]: ../api/entity-and-complex-type-reference.md#ExtensionPropertyEntity
[Group]: ../api/entity-and-complex-type-reference.md#GroupEntity
[OAuth2PermissionGrant]: ../api/entity-and-complex-type-reference.md#OAuth2PermissionGrantEntity
[ServicePrincipal]: ../api/entity-and-complex-type-reference.md#ServicePrincipalEntity
[SubscribedSku]: ../api/entity-and-complex-type-reference.md#SubscribedSkuEntity
[TenantDetail]: ../api/entity-and-complex-type-reference.md#TenantDetailEntity
[User]: ../api/entity-and-complex-type-reference.md#UserEntity

[AlternativeSecurityId]: ../api/entity-and-complex-type-reference.md#AlternativeSecurityIdType
[AppRole]: ../api/entity-and-complex-type-reference.md#AppRoleType
[AssignedLicense]: ../api/entity-and-complex-type-reference.md#AssignedLicenseType
[AssignedPlan]: ../api/entity-and-complex-type-reference.md#AssignedPlanType
[KeyCredential]: ../api/entity-and-complex-type-reference.md#KeyCredentialType
[LicenseUnitsDetail]: ../api/entity-and-complex-type-reference.md#LicenseUnitsDetailType
[OAuth2Permission]: ../api/entity-and-complex-type-reference.md#OAuth2PermissionType
[PasswordCredential]: ./entity-and-complex-type-reference.md#PasswordCredentialType
[PasswordProfile]: ../api/entity-and-complex-type-reference.md#PasswordProfileType
[ProvisionedPlan]: ../api/entity-and-complex-type-reference.md#ProvisionedPlanType
[ProvisioningError]: ../api/entity-and-complex-type-reference.md#ProvisioningErrorType
[RequiredResourceAccess]: ../api/entity-and-complex-type-reference.md#RequiredResourceAccessType
[ResourceAccess]: ../api/entity-and-complex-type-reference.md#ResourceAccessType
[ServicePlanInfo]: ../api/entity-and-complex-type-reference.md#ServicePlanInfoType
[ServicePrincipalAuthenticationPolicy]: ../api/entity-and-complex-type-reference.md#ServicePrincipalAuthenticationPolicyType
[VerifiedDomain]: ../api/entity-and-complex-type-reference.md#VerifiedDomainType

[assignLicense]: ../api/functions-and-actions.md#assignLicense
[checkMemberGroups]: ../api/functions-and-actions.md#checkMemberGroups
[getAvailableExtensionProperties]: ../api/functions-and-actions.md#getAvailableExtensionProperties
[getMemberGroups]: ../api/functions-and-actions.md#getMemberGroups
[getMemberObjects]: ../api/functions-and-actions.md#getMemberObjects
[getObjectsByObjectIds]: ../api/functions-and-actions.md#getObjectsByObjectIds
[isMemberOf]: ../api/functions-and-actions.md#isMemberOf
[restore]: ../api/functions-and-actions.md#restore

