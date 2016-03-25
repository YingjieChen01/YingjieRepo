---
title: Azure AD Graph API Functions and Actions
author: JimacoMS
ms.TocTitle: Functions and actions
ms.ContentId: d1e7a7b1-62bb-41da-83cb-03c8e4ff8d31
ms.topic: reference (API)
ms.date: 01/26/2016
---


# Functions and actions | Graph API reference

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
This topic discusses the functions and actions that are exposed by Azure AD Graph API and how you can call them. 

The Graph API is an OData 3.0 compliant REST API that provides programmatic access to directory objects in Azure Active Directory, such as users, groups, organizational contacts, and applications. 

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

## Using the Graph API to call actions and functions

To call an action or a function with the Graph API, you send POST requests to the appropriate endpoint.

Graph API requests use the following basic URL:
```no-highlight
https://graph.windows.net/{tenant_id}/{resource_path}?{api_version}[odata_query_parameters]
```

> [!IMPORTANT]
> Requests sent to the Graph API must be well-formed, target a valid endpoint and version of the Graph API, and carry a valid access token obtained from Azure AD in their `Authorization` header. For more detailed information about creating requests and receiving responses with the Graph API, see [Operations Overview].

Functions or actions that are called on the directory service itself do not require a resource path. For functions or operations that are called on a specific resource, you will specify the `{resource_path}` differently depending on the resource that you are targeting. The resource path will have the following parts:

- `(resource_collection}` specifies the resource collection, such as users, contacts, or groups.
-  `{resource_id}` identifies the specific resource to target in the resource collection. Typically an object ID (GUID), but, in the case of a user, you can also use the user principal name (UPN).

You can use the `me` alias to target the signed-in user. This alias replaces the following URL path segments: `{tenant_id}/users/{user_id}`. When you use this alias, the Graph API gets the user and tenant from the bearer token attached to the request. 

For example, the following POST request can be used to assign a license to the signed-in user (you must also include an appropriate request body) :

```no-highlight
POST https://graph.windows.net/me/assignLicense?api-version=1.6
```

For more information  about performing operations using the `me` alias, see [REST operations on the signed-in user](./signed-in-user-operations.md).
 
## Functions <a id="Functions"> </a>
Functions have no side effects in the directory. That is, when you call a function, it only returns data, it does not modify any data in the directory. The following topics show you how to call functions with the Graph API.

****

### checkMemberGroups: Check for membership in a list of groups <a id="checkMemberGroups"> </a>
Call **checkMemberGroups** to check the membership of a user, contact, group, or service principal in a list of groups. The operation is transitive. 
 
You can check up to a maximum of 20 groups per request.

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "checkMemberGroups" 
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|isSyncedFromOnPremises | Collection(Edm.String)|Yes|A collection that contains the object IDs of the groups in which to check membership. Up to 20 groups may be specified. 
#### Response Body
| Property Name | Type | Description
|:--------------|:-----|:-----------
| value | Collection(Edm.String) | A collection that contains the object IDs of the groups specified in the request that the contact, user, group, or service principal is a member of.

****

### getAvailableExtensionProperties: Get the registered extension properties in a directory <a id="getAvailableExtensionProperties"> </a>
Call the **getAvailableExtensionProperties** function to return all or a filtered list of the extension properties that have been registered in a directory. The following entities support extension properties: [User], [Group], [TenantDetail], [Device], [Application], and [ServicePrincipal]. To learn more about how extension properties are registered and unregistered in a directory and how you can modify their values, see [Directory Schema Extensions].

**Important**: Requires version 1.5 or newer.

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "getAvailableExtensionProperties" 
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|isSyncedFromOnPremises | Edm.Boolean|No|**true** to specify that only extension properties that are synced from the on-premises directory should be returned; **false** to specify that only extension properties that are not synced from the on-premises directory should be returned. If the parameter is omitted then all extension properties (both synced and non-synced) are returned. 
#### Response Body
| Property Name | Type | Description
|:--------------|:-----|:-----------
| value | Collection([ExtensionProperty]) | A collection that contains the extension properties registered with the directory filtered according to the request.

****

### getMemberGroups: Get group memberships (transitive) <a id="getMemberGroups"> </a>
Call the **getMemberGroups** function on a user, contact, group, or service principal to get the groups that it is a member of. The function is transitive. 

**Note**: The maximum number of groups that can be returned is 2046. If the target object has direct or transitive membership in more than 2046 groups, the function returns an HTTP error response with an error code of **Directory_ResultSizeLimitExceeded**.


```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "getMemberGroups",
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|securityEnabledOnly | Edm.Boolean|Yes|**true** to specify that only security groups that the entity is a member of should be returned; **false** to specify that all groups that the entity is a member of should be returned. **Note**: The function can only be called on a user if the parameter is **true**. 
#### Response Body
| Property Name | Type | Description
|:--------------|:-----|:-----------
| value | Collection(Edm.String) | A collection that contains the object IDs of the groups that the contact, user, group, or service principal is a member of.

****

### getMemberObjects: Get group and directory role memberships (transitive) <a id="getMemberObjects"> </a>
Call the **getMemberObjects** function on a user, contact, group, or service principal to get the groups and directory roles that it is a member of. The function is transitive. 

**Note**: The maximum number of groups and directory roles that can be returned is 2046. If the target object has direct or transitive membership in more than 2046 groups and directory roles, the function returns an HTTP error response with an error code of **Directory_ResultSizeLimitExceeded**.

**Important**: Requires version 1.5 or newer.

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "getMemberObjects" 
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|securityEnabledOnly | Edm.Boolean|Yes|**true** to specify that only security groups that the entity is a member of should be returned; **false** to specify that all groups and directory roles that the entity is a member of should be returned. **Note**: The function can only be called on a user if the parameter is **true**. 
#### Response Body
| Property Name | Type | Description
|:--------------|:-----|:-----------
| value | Collection(Edm.String) | A collection that contains the object IDs of the groups and directory roles that the contact, user, group, or service principal is a member of.

****

### getObjectsByObjectIds: Get objects from a list of object IDs <a id="getObjectsByObjectId"> </a>
Call the **getObjectsByObjectIds** function on the directory service to return the directory objects specified in a list of object IDs. You can also specify which resource collections (users, groups, etc.) should be searched by specifying the optional **types** parameter.

Some common uses for this function are to:

- Resolve the object IDs returned by functions that return collections of object IDs such as [getMemberObjects] or [getMemberGroups] to their backing directory objects.
- Resolve object IDs persisted in an external store by the application to their backing directory objects.

**Important**: Requires version 1.5 or newer. 

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "getObjectsByObjectIds" 
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|objectIds | Collection(Edm.String)|Yes|The collection of object IDs for which to return objects. You can specify up to 1000 object IDs. 
|types | Collection(Edm.String)|No|A collection of object types that specifies the set of resource collections (entity sets) to search. If not specified, the default is [DirectoryObject], which contains all of the objects in the directory. Any object that derives from [DirectoryObject] may be specified in the collection; for example: [User], [Group], [ServicePrincipal], and so on. The values are not case sensitive. 
#### Response Body
| Property Name | Type | Description
|:--------------|:-----|:-----------
| value | Collection([DirectoryObject]) | A collection of objects found for the specified Object IDs and resource collections.

****

### isMemberOf: Check membership in a specific group (transitive) <a id="isMemberOf"> </a>
Call the **isMemberOf** function on the directory service to check whether a specified user, group, contact, or service principal is a member of a specified group. The operation is transitive, 

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "isMemberOf" 
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|groupId | Edm.String|Yes|The object ID of the group to check. 
|memberId | Edm.String|Yes|The object ID of the contact, group, user, or service principal to check for membership in the specified group. 
#### Response Body
| Property Name | Type | Description
|:--------------|:-----|:-----------
| value | Edm.Boolean | **true** if the specified user, group, contact, or service principal has either direct or transitive membership in the specified group; otherwise, **false**.

****

## Actions <a id="Actions"> </a>

Actions have side effects in the directory. That is, when you call an action, it may alter data in the directory. For example, it may assign a license to a user or restore an application that has previously been deleted.

### assignLicense: Add or remove licenses from a user <a id="assignLicense"> </a>
Call the **assignLicense** action on a user to add or remove subscriptions for the user. You can also enable and disable specific plans associated with a subscription.

**Important**: Requires version 2013-11-08 or newer. 

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "assignLicense" 
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|addLicenses | Collection([AssinedPlan])|Yes|A collection of [AssignedLicense] objects that specify the licenses to add. You can disable plans associated with a license by setting the **disabledPlans** property on an [AssignedLicense] object. 
|removeLicenses | Collection(Edm.Guid)|Yes|A collection of GUIDs that identify the licenses to remove. 

**Note**: Subscription SKU IDs and plan IDs can be read from the tenant object. For example, performing a GET request to `https://graph.windows.net/myorganization/subscribedSkus` returns the subscriptions available for the tenant of the signed-in user. These are returned as [SubscribedSku] entities and the SKU ID can be read from the **skuId** property. You can get the plan IDs associated with the subscription from the **servicePlans** collection. Availability of subscriptions can be calculated from the **consumedUnits** property and values from the **prepaidUnits** property, which includes counts of units that are “enabled”, “suspended” and in “warning” states. 
#### Addtitional Examples
This request shows an initial license assignment of the Enterprise Office SKU, which contains SharePoint Online, Lync Online and the Exchange Online service plans.

```no-highlight
POST https://graph.windows.net/myorganization/users/alexd@a830edad9050849NDA1.onmicrosoft.com/assignLicense?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eX ... FWSXfwtQ
Content-Type: application/json
Host: graph.windows.net
Content-Length: 35

{
  "addLicenses":[{"disabledPlans":[ ],"skuId":"6fd2c87f-b296-42f0-b197-1e91e994b900"}],
  "removeLicenses":[ ]
}
```
This request updates the user’s license by disabling specific plans. In this example, there are two disabledPlans (SharePointOnline and LyncOnline"), leaving only the Exchange Service Plan enabled.

```no-highlight
POST https://graph.windows.net/myorganization/users/alexd@a830edad9050849NDA1.onmicrosoft.com/assignLicense?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eX ... FWSXfwtQ
Content-Type: application/json
Host: graph.windows.net
Content-Length: 35

{ 
  "addLicenses":[  { "disabledPlans":  [”5dbe027f-2339-4123-9542-606e4d348a72”,
                                        “0feaeb32-d00e-4d66-bd5a-43b5b83db82c” ], 

                      "skuId":"6fd2c87f-b296-42f0-b197-1e91e994b900"
                   }  

                 ],
   "removeLicenses":[ ]

 }
```
This final request shows how to remove the license from the user.

```no-highlight
POST https://graph.windows.net/myorganization/users/alexd@a830edad9050849NDA1.onmicrosoft.com/assignLicense?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eX ... FWSXfwtQ
Content-Type: application/json
Host: graph.windows.net
Content-Length: 35

{
  "addLicenses":[ ],

  "removeLicenses":["6fd2c87f-b296-42f0-b197-1e91e994b900"]
}
```

****

### restore: Restore a deleted application <a id="restore"> </a>
Call the **restore** action on a deleted application to restore it to the directory. 

**Note**: You can find deleted applications by reading the deletedApplications resource collection. For example, performing a GET to the following URL returns the deleted applications associated with the organization: `https://graph.windows.net/myorganization/deletedApplications?api-version=1.5`.

**Important**: Requires version 1.5 or newer.

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "restore" 
}
```
#### Request Body
| Property Name | Type | Required | Description 
|:--------------|:-----|:---------|:-----------
|identifierUris | Collection(Edm.String)|No|The collection of identifier URIs for the application. These will be set in the **identifierUris** property in the restored [Application]. If the parameter is omitted, the **identifierUris** property will retain its original value. 
#### Response Body
| Type | Description
|:-----|:-----------
| [Application] | The restored application.

****

### verify: Verify ownership of a domain (preview) <a id="verify"> </a>
Call the **verify** action on a domain to validate the ownership of the domain.

**Important**: Only applies to an unverified domain (the **isVerified** property of the [Domain] is **false**). Only supported in version beta.

```RESTAPIdocs
{
    "api":  "Functions",
    "operation":    "verify" 
}
```
#### Request Body
None. 
#### Response Body
| Type | Description
|:-----|:-----------
| [Domain] | The domain being verified. The **isVerified** property indicates whether the ownership of the domain has been verified successfully.

****

##Additional Resources

- Learn more about Graph API supported features, capabilities, and preview features in [Graph API concepts](../howto/azure-ad-graph-api-operations-overview.md)
  
[Application]: ./entity-and-complex-type-reference.md#ApplicationEntity
[AppRoleAssignment]: ./entity-and-complex-type-reference.md#AppRoleAssignmentEntity
[Contact]: ./entity-and-complex-type-reference.md#ContactEntity
[Contract]: ./entity-and-complex-type-reference.md#ContractEntity
[Device]: ./entity-and-complex-type-reference.md#DeviceEntity
[DirectoryLinkChange]: ./entity-and-complex-type-reference.md#DirectoryLinkChangeEntity
[DirectoryObject]: ./entity-and-complex-type-reference.md#DirectoryObjectEntity
[DirectoryRole]: ./entity-and-complex-type-reference.md#DirectoryRoleEntity
[DirectoryRoleTemplate]: ./entity-and-complex-type-reference.md#DirectoryRoleTemplateEntity
[Domain (preview)]: ./entity-and-complex-type-reference.md#DomainEntity
[DomainDnsRecord]: ./entity-and-complex-type-reference.md#DomainDnsRecordEntity
[DomainDnsCnameRecord]: ./entity-and-complex-type-reference.md#DomainDnsCnameRecordEntity
[DomainDnsMxRecord]: ./entity-and-complex-type-reference.md#DomainDnsMxRecordEntity
[DomainDnsSrvRecord]: ./entity-and-complex-type-reference.md#DomainDnsSrvRecordEntity
[DomainDnsTxtRecord]: ./entity-and-complex-type-reference.md#DomainDnsTxtRecordEntity
[DomainDnsUnavailableRecord]: ./entity-and-complex-type-reference.md#DomainDnsUnavailableRecordEntity
[ExtensionProperty]: ./entity-and-complex-type-reference.md#ExtensionPropertyEntity
[Group]: ./entity-and-complex-type-reference.md#GroupEntity
[OAuth2PermissionGrant]: ./entity-and-complex-type-reference.md#OAuth2PermissionGrantEntity
[ServicePrincipal]: ./entity-and-complex-type-reference.md#ServicePrincipalEntity
[SubscribedSku]: ./entity-and-complex-type-reference.md#SubscribedSkuEntity
[TenantDetail]: ./entity-and-complex-type-reference.md#TenantDetailEntity
[User]: ./entity-and-complex-type-reference.md#UserEntity

[AlternativeSecurityId]: ./entity-and-complex-type-reference.md#AlternativeSecurityIdType
[AppRole]: ./entity-and-complex-type-reference.md#AppRoleType
[AssignedLicense]: ./entity-and-complex-type-reference.md#AssignedLicenseType
[AssignedPlan]: ./entity-and-complex-type-reference.md#AssignedPlanType
[KeyCredential]: ./entity-and-complex-type-reference.md#KeyCredentialType
[LicenseUnitsDetail]: ./entity-and-complex-type-reference.md#LicenseUnitsDetailType
[OAuth2Permission]: ./entity-and-complex-type-reference.md#OAuth2PermissionType
[PasswordCredential]: ./entity-and-complex-type-reference.md#PasswordCredentialType
[PasswordProfile]: ./entity-and-complex-type-reference.md#PasswordProfileType
[ProvisionedPlan]: ./entity-and-complex-type-reference.md#ProvisionedPlanType
[ProvisioningError]: ./entity-and-complex-type-reference.md#ProvisioningErrorType
[RequiredResourceAccess]: ./entity-and-complex-type-reference.md#RequiredResourceAccessType
[ResourceAccess]: ./entity-and-complex-type-reference.md#ResourceAccessType
[ServicePlanInfo]: ./entity-and-complex-type-reference.md#ServicePlanInfoType
[ServicePrincipalAuthenticationPolicy]: ./entity-and-complex-type-reference.md#ServicePrincipalAuthenticationPolicyType
[VerifiedDomain]: ./entity-and-complex-type-reference.md#VerifiedDomainType

[assignLicense]: #assignLicense
[checkMemberGroups]: #checkMemberGroups
[getAvailableExtensionProperties]: #getAvailableExtensionProperties
[getMemberGroups]: #getMemberGroups
[getMemberObjects]: #getMemberObjects
[getObjectsByObjectIds]: #getObjectsByObjectIds
[isMemberOf]: #isMemberOf
[restore]: #restore

[Graph API QuickStart on Azure on Azure.com]: https://azure.microsoft.com/documentation/articles/active-directory-graph-api-quickstart/
[Operations Overview]: ../howto/azure-ad-graph-api-operations-overview.md
[Graph API Versioning]: ../howto/azure-ad-graph-api-versioning.md
[Graph API Permission Scopes]: ../howto/azure-ad-graph-api-permission-scopes.md
[Supported Queries, Filters, and Paging Options]: ../howto/azure-ad-graph-api-supported-queries-filters-and-paging-options.md
[Differential Query]: ../howto/azure-ad-graph-api-differential-query.md
[Batch Processing]: ../howto/azure-ad-graph-api-batch-processing.md
[Directory Schema Extensions]: ../howto/azure-ad-graph-api-directory-schema-extensions.md
[Error Codes and Error Handling]: ../howto/azure-ad-graph-api-error-codes-and-error-handling.md
[Azure AD Administrative Units Preview]: ../howto/azure-ad-administrative-units-preview.md
[Azure AD Reports and Events Preview]: ../howto/azure-ad-reports-and-events-preview.md

[!CODE-RESTAPI_Swagger [functions_swagger2](./functions_swagger2.json)]
