---
title: Azure AD Administrative Units (Preview)
author: JimacoMS
ms.TocTitle: Administrative units (preview)
ms.ContentId: 6ade7364-42b3-4585-8704-0ff0795a5228
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Administrative units (preview) | Graph API concepts

Applies To: Azure AD Graph API

## Overview and prerequisites <a id="Overview"></a>

An Administrative Unit provides a conceptual container for User and Group directory objects, enabling permissions to be delegated at a finer granularity (ie: departmental, regional, etc.), to administrative roles scoped to the Administrative Unit.  This topic provides descriptions of the declared properties and navigation properties exposed by the **AdministrativeUnit** entity, as well as the operations and functions that can be called on the **administrativeUnits** OData resource.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token. Note that administrative units are not currently supported in Microsoft Graph; you will need to use Azure AD Graph API for this feature.

Familiarity with Azure AD authentication and application configuration is necessary before using the Administrative Unit Preview.  If you are unfamiliar with the concepts associated with Azure AD authentication, and/or the configuration steps required to allow an application to access your tenant, please review [Authentication Scenarios for Azure AD](http://azure.microsoft.com/documentation/articles/active-directory-authentication-scenarios/), particularly the section titled [Basics of Registering an Application in Azure AD](http://azure.microsoft.com/documentation/articles/active-directory-authentication-scenarios/#basics-of-registering-an-application-in-azure-ad) which links to a more detailed [Integrating Applications with Azure Active Directory](https://azure.microsoft.com/documentation/articles/active-directory-integrating-applications/) article.

Please refer to the main [Azure Active Directory Graph API](https://azure.microsoft.com/documentation/articles/active-directory-graph-api/) article on Azure.com and the following list of Graph API articles for additional important and helpful information before proceeding to the sections below:

1. [Azure AD Graph API Versioning](./azure-ad-graph-api-versioning.md)

    **Important**: The Administrative Unit feature is available in Preview only at this time.  In order to use preview features, please be sure to set the api-version query string parameter to “beta”, ie: `https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits?api-version=beta`<br/><br/>You can create and use administrative units only if you enable Azure Active Directory Premium. For more information, see [Getting started with Azure Active Directory Premium](https://msdn.microsoft.com/library/azure/dn499825.aspx)



2. [Quickstart for the Azure AD Graph API](https://azure.microsoft.com/documentation/articles/active-directory-graph-api-quickstart/) on Azure.com

3. [Graph API Operations overview](./azure-ad-graph-api-operations-overview.md)

4. [Supported queries, filters, and paging options](./azure-ad-graph-api-supported-queries-filters-and-paging-options.md)


## Namespace and Inheritance

**Namespace**: Microsoft.DirectoryServices

**Base type**: [DirectoryObject]

## Properties

The **AdministrativeUnit** entity supports the following properties:

### Declared Properties

|Name|Type|Create(POST)|Read(GET)|Update(PATCH)|Description|
|---|---|---|---|---|---|
|description|Edm.String|Optional||Optional|An optional description for the administrative unit.|
|displayName|Edm.String|Required|Filterable|Optional|Display name for the administrative unit.|

### Navigation Properties

|Name|From Multiplicity|To|To Multiplicity|Description|
|---|---|---|---|---|
|members|*|User or Group|*|Members assigned to the Administrative Unit, which can be Users or Groups.  Inherited from DirectoryObject.|
|scopedAdministrators|*|ScopedRoleMembership|*|Administrators assigned to given Role(s), which are scoped to an Administrative Unit.|

**Note**: Although the [DirectoryObject] entity also supports other navigation properties, including **memberOf**, **owners**, and **ownedObjects**, these properties are not valid for Administrative Unit. If a request for any of these properties is sent, a **400 Bad Request** response is returned with a corresponding error message.

## Addressing

Addressing can span a collection of administrative units in the directory, an individual administrative unit, or related resources available via the supported navigation properties of an administrative unit. The examples in the table use the tenant domain to address the tenant. For other ways of addressing the tenant, see [Addressing Entities and Operations in the Graph API](./azure-ad-graph-api-addressing-entities-and-operations.md).

|Artifact|URL fragment|Example|
|---|---|---|
|Resource set (all administrative units)|/administrativeUnits|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits?api-version=beta`|
|Single resource (ie: one administrative unit)|/administrativeUnits/{objectId}|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/12345678-9abc-def0-1234-56789abcde?api-version=beta`|
|Related resources via a Navigation property|/administrativeUnits/{objectId}/$links/{property-name}|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/12345678-9abc-def0-1234-56789abcde/$links/members?api-version=beta`|

**Note**: See the Navigation Properties section above for the list of valid navigation properties that can be used in place of {property-name}. Remove the “$links” segment from the resource path portion of the URI, to return the actual objects referenced by a navigation property rather than links to them. You may also address an administrative unit using generic directory objects, by replacing “administrativeUnits” with “directoryObjects” in the resource path portion of the URI.

For more comprehensive information about querying directory objects, see [Azure AD Graph API Common Queries](./azure-ad-graph-api-common-queries.md) and [Azure AD Graph API Differential Query](./azure-ad-graph-api-differential-query.md).

## Supported Operations – administrativeUnits

This section defines the operations supported on an **administrativeUnits** resource set. As mentioned earlier, it’s important to review the topics in the [Overview and Prerequisites](#Overview) section first to understand some of the Graph API basics that apply to all entities, such as correctly formatting URLs, addressing entities and operations, using versioning, and more.

For each of the operations listed below:

- The principal that performs the operation must be in an administrator role that has privileges to modify **administrativeUnits** resources using PATCH, POST, or DELETE requests, and privileges to read objects using GET requests.

- As appropriate, replace the placeholder strings “contoso.onmicrosoft.com” with the domain of your Azure Active Directory tenant, and {**objectId**} with the ID of the resource type as determined in the URL.

- Each request must include the following HTTP Request headers in the table below.

|Request Header|Description|
|---|---|
|Authorization|Required. A bearer token issued by Azure Active Directory. See [Authentication Scenarios for Azure AD](https://azure.microsoft.com/documentation/articles/active-directory-authentication-scenarios/) for more information.|
|Content-Type|Required. The media type of the content in the request body, e.g.: application/json.|
|Content-Length|Required. The length of the request in bytes.|
<br/>
The first four operations listed below are used to manage the creation, retrieval, updating, and deletion of **AdministrativeUnit** entities.  The operations following these use the **members** and **scopedAdministrators** navigation properties, to manage the User/Group members of the **AdminstrativeUnit**, and the set of scoped administrators (via the **ScopedRoleMembership** entity) that have administrative control of the **AdministrativeUnit**, respectively.

### Create an administrative unit

Used to create a new **AdministrativeUnit**.

|HTTP Method|Request URI|
|---|---|
|POST|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits?api-version=beta`|

The request body specifies the required **displayName** and optional **description** properties:

```json
{
  "displayName":"Central Region",
  "description":"Administrators responsible for the Central region."
}
```
See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The response body will appear similar to the one below.

```json
{
   "odata.metadata":https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/Microsoft.DirectoryServices.AdministrativeUnit/@Element",
   "odata.type":"Microsoft.DirectoryServices.AdministrativeUnit",
   "objectType":"AdministrativeUnit",
   "objectId":"ca1a80f3-ac25-429b-a1e9-0f1eb87cc30b",
   "deletionTimestamp":null,
   "displayName":"Central Region",
   "description":"Administrators responsible for the Central region."
}
```
### Get administrative unit(s)

Used to retrieve a specific **AdministrativeUnit** by {objectId}, a subset by filtering on the **displayName** property (see [Supported Queries, Filters, and Paging Options in Azure AD Graph API](./azure-ad-graph-api-supported-queries-filters-and-paging-options.md)), or the list of all available ones. The Request/Response examples below show queries for a specific administrative unit and for all administrative units, respectively.

|HTTP Method|Request URI|
|---|---|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}?api-version=beta`|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The response body will appear similar to one of the ones below.

```json
{
   "odata.metadata":https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/Microsoft.DirectoryServices.AdministrativeUnit/@Element",
   "odata.type":"Microsoft.DirectoryServices.AdministrativeUnit",
   "objectType":"AdministrativeUnit",
   "objectId":"ca1a80f3-ac25-429b-a1e9-0f1eb87cc30b",
   "deletionTimestamp":null,
   "displayName":"Central Region",
   "description":"Administrators responsible for the Central region."
}
```

```json
{
   "odata.metadata":https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/Microsoft.DirectoryServices.AdministrativeUnit/",
   "value":
   [
      {
      "odata.type":"Microsoft.DirectoryServices.AdministrativeUnit",
      "objectType":"AdministrativeUnit",
      "objectId":"ca1a80f3-ac25-429b-a1e9-0f1eb87cc30b",
      "deletionTimestamp":null,
      "displayName":"Central Region",
      "description":"Administrators responsible for the Central region."
      },
      {
      "odata.type":"Microsoft.DirectoryServices.AdministrativeUnit",
      "objectType":"AdministrativeUnit",
      "objectId":"455b7304-b245-4d58-95c4-1797c32c80db",
      "deletionTimestamp":null,
      "displayName":"East Coast Region",
      "description":"East Coast Two"
      }
   ]
}
```
### Update an administrative unit

Used to update one or more of the properties in an **AdministrativeUnit**.

|HTTP Method|Request URI|
|---|---|
|PATCH|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}?api-version=beta`|

The request body specifies one or both of the **AdministrativeUnit** properties:

```json
{ 
  "displayName":"Central Region Administrators"
}
```
See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. There is no OData response in the response body.

### Delete an administrative unit

Used to delete an **AdministrativeUnit**, as specified by the {objectId}.

|HTTP Method|Request URI|
|---|---|
|DELETE|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions.  There is no OData response in the response body.

The following operations are implemented via the **members** navigation property, which provides management of the user/group members of an **AdminstrativeUnit**.  Recall from earlier, the $links resource segment allows you to traverse or modify the association (aka: link) between two resources, such as between an **administrativeUnit** and a [User] or [Group] resource.

### Add member(s) to an administrative unit

Used to add **user** or **group** resource members to an **AdministrativeUnit**.

|HTTP Method|Request URI|
|---|---|
|POST|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}/$links/members/?api-version=beta`|

In this example the request body specifies the URL to the desired member that we want to add to the **administrativeUnit**, which is a **users** resource in this example.  It’s also valid to use **directoryObjects** as the type resource segment, in place of **users**, as the [User] entity is inherited from the [DirectoryObject] entity. The same is true when using the **groups** resource segment.

```json
{
  "url":" https://graph.windows.net/contoso.onmicrosoft.com/users/a1daa894-ff32-4839-bb6a-d7a4210fc96a"
}
```
See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. There is no OData response in the response body.

### Get member(s) of an administrative unit

Used to retrieve **user** or **group** resource members from an **administrativeUnit**. Note that you can retrieve members using either form of the GET operations listed below.  The first returns the URL/link to the member(s), the second returns the properties for the member(s). In both cases, the {memberObjectId} segment is optional, depending on whether you want the set of members returned, or a specific one.

|HTTP Method|Request URI|
|---|---|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}/$links/members/{memberObjectId}?api-version=beta`|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}/members/{memberObjectId}?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The first example below shows the response body for an operation using the $links segment for all members (ie: {memberObjectId} is not specified), where there are two types of resources, a **User** and a **Group**. The second shows the response for the same example, without the $links segment.

```json
{
   "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/$links/members",
   "value":
   [
      {
      "url":"https://graph.windows.net/contoso.onmicrosoft.com/directoryObjects/a1daa894-ff32-4839-bb6a-d7a4210fc96a/Microsoft.DirectoryServices.User"
      },
      {
      "url":"https://graph.windows.net/contoso.onmicrosoft.com/directoryObjects/a0ab9340-2b20-4b3f-8672-bf1a2f141f91/Microsoft.DirectoryServices.Group"
      }
   ]
}
```

```json
{
   "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects",
   "value":
   [
      {
      "odata.type":"Microsoft.DirectoryServices.User",
      "objectType":"User",
      "objectId":"a1daa894-ff32-4839-bb6a-d7a4210fc96a",
      "deletionTimestamp":null,
      "acceptedAs":null,
      "acceptedOn":null,
      "accountEnabled":true,
      "alternativeSecurityIds":[],
      "alternativeSignInNames":[admin@contoso.com],
      "alternativeSignInNamesInfo":[],
      "appMetadata":null,
      "assignedLicenses":[],
      "assignedPlans":[],
      "city":"Redmond",
      "cloudSecurityIdentifier":"S-1-12-6-2715461780-1211760434-2765580987-1791561505",
      "companyName":null,
      "country":null,
      "creationType":null,
      "department":null,
      "dirSyncEnabled":null,
      "displayName":"Jon Doe",
      "extensionAttribute1":null,
      "extensionAttribute2":null,
      "extensionAttribute3":null,
      "extensionAttribute4":null,
      "extensionAttribute5":null,
      "extensionAttribute6":null,
      "extensionAttribute7":null,
      "extensionAttribute8":null,
      "extensionAttribute9":null,
      "extensionAttribute10":null,
      "extensionAttribute11":null,
      "extensionAttribute12":null,
      "extensionAttribute13":null,
      "extensionAttribute14":null,
      "extensionAttribute15":null,
      "facsimileTelephoneNumber":null,
      "givenName":"Jon",
      "immutableId":null,
      "invitedOn":null,
      "inviteReplyUrl":[],
      "inviteResources":[],
      "inviteTicket":[],
      "isCompromised":null,
      "jobTitle":null,
      "jrnlProxyAddress":null,
      "lastDirSyncTime":null,
      "mail":null,
      "mailNickname":"admin",
      "mobile":null,
      "netId":"100300008001EE6E",
      "onPremisesSecurityIdentifier":null,
      "otherMails":[jon@doe.com],
      "passwordPolicies":null,
      "passwordProfile":null,
      "physicalDeliveryOfficeName":null,
      "postalCode":"98052",
      "preferredLanguage":"en-US",
      "primarySMTPAddress":null,
      "provisionedPlans":[],
      "provisioningErrors":[],
      "proxyAddresses":[],
      "releaseTrack":null,
      "searchableDeviceKey":[],
      "selfServePasswordResetData":null,
      "sipProxyAddress":null,
      "smtpAddresses":[],
      "state":"WA",
      "streetAddress":
      "One Microsoft Way",
      "surname":"Doe",
      "telephoneNumber":"(123) 456-7890",
      "usageLocation":"US",
      "userPrincipalName":admin@constoso.com,
      "userState":null,
      "userStateChangedOn":null,
      "userType":"Member"      
      },
      { 
      "odata.type":"Microsoft.DirectoryServices.Group",
      "objectType":"Group",
      "objectId":"a0ab9340-2b20-4b3f-8672-bf1a2f141f91",
      "deletionTimestamp":null,
      "appMetadata":null,
      "cloudSecurityIdentifier":"S-1-12-6-2695598912-1262431008-448754310-2434733103",
      "description":null,
      "dirSyncEnabled":null,
      "displayName":"Group for users in Central Region Administrative Unit",
      "exchangeResources":[],
      "groupType":null,
      "isPublic":null,
      "lastDirSyncTime":null,
      "licenseAssignment":[],
      "mail":null,
      "mailEnabled":false,
      "mailNickname":"CentralUsers",
      "onPremisesSecurityIdentifier":null,
      "provisioningErrors":[],
      "proxyAddresses":[],
      "securityEnabled":true,
      "sharepointResources":[],
      "targetAddress":null,
      "wellKnownObject":null     
      }
   ]
}
```

### Delete member(s) from an administrative unit

Used to delete **user** or **group** resource members from an **administrativeGroup** resource. Because **members** is a multi-value navigation property, you must include the {objectId} of the member/link in the request URL, which you wish to delete.

|HTTP Method|Request URI|
|---|---|
|DELETE|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}/$links/members/{objectId}?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions.  There is no OData response in the response body.

Administrators are assigned to an administrative unit by placing them in a role that has been scoped to that administrative unit. The remaining operations in this section are implemented via the **scopedAdministrators** navigation property, which provides management of the set administrators that have administrative control of an **AdministrativeUnit**, via a scoped role.

### Add a scoped-role administrator to an administrative unit

Used to add an administrator to a role that will be scoped to an **administrativeUnit**, via the **ScopedRoleMembership** entity and the **scopedAdministrators** navigation property. In this example, the operation does two things:

1. Populates a new **ScopedRoleMembership** item (which is NOT an addressable OData resource), which establishes a relationship between an **AdministrativeUnit**, a **DirectoryRole** scoped to the administrative unit, and an administrator **User**.

2. Establishes a navigation property association/link between the **AdministrativeUnit** and the new **ScopedRoleMembership** item.

|HTTP Method|Request URI|
|---|---|
|POST|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}/scopedAdministrators?api-version=beta`|

The request body specifies the following properties from the ScopedRoleMembership entity:

- roleObjectId – objectId of the desired DirectoryRole. Note: currently only the HelpDeskAdministrators and UserAccountAdministrator roles are valid.

- roleMemberInfo – a structure which identifies the administrative User:objectId – objectId of the administrative User.

- objectId – objectId of the administrative User.


```json
{
   "roleObjectId":"4bae1c93-ef8c-4907-83c8-1e1c1fd2e2c1",
   "roleMemberInfo":{
      "objectId":"a142bb2d-df81-4066-af91-f63e4aba9e5f"}
}

```

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The response body will appear similar to the one below.

```json
{
   "odata.metadata":https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/Microsoft.DirectoryServices.AdministrativeUnit/@Element",
   "id":"kxyuS4zvB0mDyB4cH9Liwf2cwDwjVAJAhbgHDWCmP-Itu0Khgd9mQK-R9j5Kup5fU",
   "roleObjectId":"4bae1c93-ef8c-4907-83c8-1e1c1fd2e2c1",
   "administrativeUnitObjectId":"3cc09cfd-5423-4002-85b8-070d60a63fe2",
   "roleMemberInfo":{"objectId":"a142bb2d-df81-4066-af91-f63e4aba9e5f",
      "displayName":"Bryan",
      "userPrincipalName":BryanL@contoso.com
      }
}
```

### Get a scoped-role administrator of an administrative unit

Used to get the list of administrators in scoped roles for an **administrativeUnit** resource, as **ScopedRoleMembership** entities.  Note that the {scopedRoleMemberId} segment is optional, depending on whether you want the set of members, or a specific one.

|HTTP Method|Request URI|
|---|---|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}/scopedAdministrators/{scopedRoleMemberId}?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The response body below is for a query for all members.

```json
{ 
   "odata.metadata":https://graph.windows.net/contoso.onmicrosoft.com /$metadata#scopedRoleMemberships,
   "value":
   [
      {
      "id":"kxyuS4zvB0mDyB4cH9Liwf2cwDwjVAJAhbgHDWCmP-Itu0Khgd9mQK-R9j5Kup5fU",
      "roleObjectId":"4bae1c93-ef8c-4907-83c8-1e1c1fd2e2c1",
      "administrativeUnitObjectId":"3cc09cfd-5423-4002-85b8-070d60a63fe2",
      "roleMemberInfo":
         {
         "objectId":"a142bb2d-df81-4066-af91-f63e4aba9e5f",
         "displayName":"Bryan",
         "userPrincipalName":BryanL@contoso.com
         }
      }            
   ]
}
```

### Delete a scoped-role administrator from an administrative unit.

Used to delete a **ScopedRoleMembership** from an **administrativeUnit** resource, specified by the {scopedRoleMemberId} segment.

|HTTP Method|Request URI|
|---|---|
|DELETE|`https://graph.windows.net/contoso.onmicrosoft.com/administrativeUnits/{objectId}/scopedAdministrators/{scopedRoleMemberId}?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. There is no OData response in the response body.

## Supported Operations – users and groups

This section defines the newly supported operations on **users** and **groups** resources, which provide support for **administrativeUnit** resources.

You can check the full GA documentation for the [User] and [Group] entities and for operations on [users](../api/users-operations.md) and [groups](../api/groups-operations.md).

For each of the operations listed below:

- The principal that performs the operation must have privileges to read objects using GET requests.

- As appropriate, replace the placeholder strings “contoso.onmicrosoft.com” with the domain of your Azure Active Directory tenant, and {objectId} with the ID of the resource type as determined in the URL.

- Each request must include the following HTTP Request headers:

    |Request Header|Description|
|---|---|
|Authorization|Required. A bearer token issued by Azure Active Directory. See Authentication Scenarios for Azure AD for more information.|
|Content-Type|Required. The media type of the content in the request body, e.g.: application/json.|
|Content-Length|Required. The length of the request in bytes.|

### Get administrative unit(s) to which a user or group belongs

The Preview enables retrieval of **administrativeUnits** membership for **users** and **groups** resources, via the **memberOf** navigation property on the **DirectoryObject** entity. Specify the “users” resource segment to retrieve membership for **users** resources, or “groups” for **groups** resources. Specify the “$links” resource segment to retrieve the resource URLs/links, or omit to retrieve the properties.

|HTTP Method|Request URI|
|---|---|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/users/{objectID}/$links/memberOf?api-version=beta`|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/users/{objectID}/memberOf?api-version=beta`|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/groups/{objectID}/$links/memberOf?api-version=beta`|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/groups/{objectID}/memberOf?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The first example below shows the response body for a **users** resource with the $links segment, which has membership in two types of resources: a **DirectoryRole** and an **AdministrativeUnit**. The second shows the response for the same example, without the $links segment.

```json
{
   "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/$links/memberOf",
   "value":
   [
      {
      "url":"https://graph.windows.net/contoso.onmicrosoft.com/directoryObjects/cbf54c29-6184-484d-92d6-d6af32f896a2/Microsoft.DirectoryServices.DirectoryRole"
      },
      {
      "url":"https://graph.windows.net/contoso.onmicrosoft.com/directoryObjects/3cc09cfd-5423-4002-85b8-070d60a63fe2/Microsoft.DirectoryServices.AdministrativeUnit"
      }
   ]
}
```

```json
{
   "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects",
   "value":
   [
      {
      "odata.type":"Microsoft.DirectoryServices.DirectoryRole",
      "objectType":"Role",
      "objectId":"cbf54c29-6184-484d-92d6-d6af32f896a2",
      "deletionTimestamp":null,
      "cloudSecurityIdentifier":"S-1-12-6-3421850665-1213030788-2950092434-2727802930",
      "description":"Company Administrator role has full access to perform any operation in the company scope.",
      "displayName":"Company Administrator",
      "isSystem":true,
      "roleDisabled":false,
      "roleTemplateId":"62e90394-69f5-4237-9190-012177145e10"
      },
      {
      "odata.type":"Microsoft.DirectoryServices.AdministrativeUnit",
      "objectType":"AdministrativeUnit",
      "objectId":"3cc09cfd-5423-4002-85b8-070d60a63fe2",
      "deletionTimestamp":null,
      "displayName":"Central Region Administrators",
      "description":"Administrators responsible for the Central Region"
      }    
   ]  
}
```

### Get administrative unit(s) of which a user is an administrator

Used to retrieve the **adminstrativeUnits** resource(s) of which a user is an administrator, via the **scopedAdministratorOf** navigation property on the **User** entity. Note that you can use either form of the GET operations listed below. The first retrieves the resource URLs/link, the second returns the properties.

|HTTP Method|Request URI|
|---|---|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/users/{objectId}/$links/scopedAdministratorOf?api-version=beta`|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/users/{objectId}/scopedAdministratorOf?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The first example below shows the response body for an operation using the $links segment. The second shows the response for the same example, without the $links segment.

```json
{
   "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/$links/scopedAdministratorOf",
   "value":
   [
      {
      "url":"https://graph.windows.net/contoso.onmicrosoft.com/scopedRoleMemberships/kxyuS4zvB0mDyB4cH9Liwf2cwDwjVAJAhbgHDWCmP-Itu0Khgd9mQK-R9j5Kup5fU"
      }
   ]
}```

```json
{
   "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#scopedRoleMemberships",
   "value":
   [
      {
      "id":"kxyuS4zvB0mDyB4cH9Liwf2cwDwjVAJAhbgHDWCmP-Itu0Khgd9mQK-R9j5Kup5fU",
      "roleObjectId":"4bae1c93-ef8c-4907-83c8-1e1c1fd2e2c1",
      "administrativeUnitObjectId":"3cc09cfd-5423-4002-85b8-070d60a63fe2",
      "roleMemberInfo":
         {
         "objectId":"a142bb2d-df81-4066-af91-f63e4aba9e5f",
         "displayName":"Bryan",
         "userPrincipalName":BryanL@contoso.com
         }
      }
   ]  
}
```

## Supported Operations – directoryRoles

This section defines the newly supported operations on **directoryRoles** resources that provide specific support for **administrativeUnits** resources.

You can check the full GA documentation for more information about the [DirectoryRole] entity and related [operations****](../api/directoryroles-operations.md).

For each of the operations listed below:

- The principal that performs the operation must have privileges to read objects using GET requests.

- As appropriate, replace the placeholder strings “contoso.onmicrosoft.com” with the domain of your Azure Active Directory tenant, and {objectId} with the ID of the resource type as determined in the URL.

- Each request must include the following HTTP Request headers:Request HeaderDescriptionAuthorizationRequired. A bearer token issued by Azure Active Directory. See Authentication Scenarios for Azure AD for more information.Content-TypeRequired. The media type of the content in the request body, e.g.: application/json.Content-LengthRequired. The length of the request in bytes.

|Request Header|Description|
|---|---|
|Authorization|Required. A bearer token issued by Azure Active Directory. See Authentication Scenarios for Azure AD for more information.|
|Content-Type|Required. The media type of the content in the request body, e.g.: application/json.|
|Content-Length|Required. The length of the request in bytes.|

### Get administrative unit administrators scoped to a specific role

Administrators are assigned to an administrative unit by placing them in a role that has been scoped to that administrative unit.  This operation allows you to retrieve those “scoped role membership(s)” for an administrator, as a set of  **scopedRoleMemberships** resources. Note that only a” HelpDeskAdministrators” or “UserAccountAdministrator” role {objectId} is valid. Also note that the {scopedRoleMemberId} segment is optional, depending on whether you want all **scopedRoleMembership** resources for a specific role, or a specific one.

|HTTP Method|Request URI|
|---|---|
|GET|`https://graph.windows.net/contoso.onmicrosoft.com/directoryRoles/{objectId}/scopedAdministrators/{scopedRoleMemberId}?api-version=beta`|

There is no request body.

See the [HTTP Response Reference](#HttpResponseReference) section below for response code definitions. The response body below is for a query for all administrators of a particular administrative unit, scoped to the Helpdesk Administrator role.

```json
{ 
   "odata.metadata":https://graph.windows.net/contoso.onmicrosoft.com /$metadata#scopedRoleMemberships,
   "value":[
   {
      "id":"kxyuS4zvB0mDyB4cH9Liwf2cwDwjVAJAhbgHDWCmP-Itu0Khgd9mQK-R9j5Kup5fU",
      "roleObjectId":"4bae1c93-ef8c-4907-83c8-1e1c1fd2e2c1",
      "administrativeUnitObjectId":"3cc09cfd-5423-4002-85b8-070d60a63fe2",
      "roleMemberInfo":
      {
         "objectId":"a142bb2d-df81-4066-af91-f63e4aba9e5f",
         "displayName":"Bryan",
         "userPrincipalName":BryanL@contoso.com
      }
   ]
}
```

## HTTP Response Reference <a id="HttpResponseReference"></a>

Below is the list of possible HTTP response codes:

|HTTP Status Code|OData Error Code|Description|
|---|---|---|
|200/OK|n/a|Normal response for a successful query.  The response body will contain the data that matches the filters specified in the query parameters.|
|201/Created|n/a|Normal response for a successful POST/create operation.  The response body will contain the data as populated in the new resource.|
|204/No Content|n/a|Normal response for a successful PATCH/update or DELETE operation on a resource, or POST on a linked resource.  The response body will not contain an OData response.|
|400/BadRequest|Request_BadRequest|This is a generic error message for an invalid or missing header, parameter, or request body data.  You will also see this error if attempting to add a linked resource that already exists.|
|401/Unauthorized|AuthorizationError|This will be displayed when the user is not authorized to view the content.  Please see the main AD Graph REST article for additional details on securing your calls, and obtaining and specifying a secure access token.|
|404/Not Found|Request_ResourceNotFound|This will be displayed when the resource you are attempting to access does not exist.|
|405/Method not allowed|Request_BadRequest|This will be displayed when you are attempting an operation meant for a specific resource, but are not providing the correct resource ID in the request URL.|

## Additional resources

- To learn about managing Administrative Units using PowerShell, visit the [Administrative units management in Azure AD - Public Preview](https://msdn.microsoft.com/library/azure/dn832057.aspx) article.
- For more information on the OData primitive date types exposed by the EDM, see [Entity Data Model: Primitive Data Types](https://msdn.microsoft.com/library/ee382832.aspx).
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


