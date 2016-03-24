---
title: Azure AD Graph API Entity and Complex Type Reference
author: JimacoMS
ms.TocTitle: Entity and complex type reference
ms.ContentId: 88f6e187-70db-4d90-b3b6-b8702bad1220
ms.topic: reference (API)
ms.date: 02/18/2016
---


# Entity and complex type reference | Graph API reference 

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
This topic discusses the entities and complex types that are exposed by the Graph API.

The Graph API is an OData 3.0 compliant REST API that provides programmatic access to directory objects in Azure Active Directory, such as users, groups, organizational contacts, and applications. 

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

## Entity reference

### Application Entity <a id="ApplicationEntity"> </a>
Represents an application. Any application that outsources authentication to Azure AD must be registered in a directory. This involves telling Azure AD about your application, including the URL where it's located, the URL to send replies after authentication, the URI to identify your application, and more.  For more information, see [Basics of Registering an Application in Azure AD](https://azure.microsoft.com/en-us/documentation/articles/active-directory-authentication-scenarios/#basics-of-registering-an-application-in-azure-ad). Inherits from [DirectoryObject].

#### Properties
**Declared Properties**

|  Name |  Type |  Supports |  Description |
|:-------|:-------|:-------|:-------|
| appId | Edm.String in version 1.5<br/><br/> Edm.Guid in previous versions | GET ($filter) | The unique identifier for the application. |
| appRoles | Collection([AppRole]) | POST, GET, PATCH | The collection of application roles that an application may declare. These roles can be assigned to users, groups or service principals.<br/><br/> **Notes**: Requires version 1.5, not nullable. |
| availableToOtherTenants | Edm.Boolean | POST, GET ($filter), PATCH | **true** if the application is shared with other tenants; otherwise, **false**. |
| deletionTimestamp | Edm.DateTime | GET | The time at which the application was deleted from the tenant. If the application has not been deleted, returns **null**. Deleted applications can be read from the `/deletedApplications` resource collection. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer.  |
| displayName | Edm.String | POST (Required), GET, PATCH | The display name for the application. |
| errorUrl | Edm.String | POST, GET, PATCH |  |
| groupMembershipClaims | Edm.String | POST, GET, PATCH | A bitmask that configures the "groups" claim issued in a user or OAuth 2.0 access token that the application expects. The bitmask values are: 0: None, 1: Security groups and Azure AD roles, 2: Reserved, and 4: Reserved. Setting the bitmask to 7 will get all of the security groups, distribution groups, and Azure AD directory roles that the signed-in user is a member of.<br/><br/> **Notes**: Requires version 1.5. |
| homepage | Edm.String | POST, GET, PATCH | The URL to the application's homepage. |
| identifierUris | Collection(Edm.String) | POST, GET ($filter), PATCH | The URIs that identify the application. For more information see, [Application Objects and Service Principal Objects](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-objects/).<br/><br/> **Notes**: not nullable, the **any** operator is required for filter expressions on multi-valued properties; for more information, see [Supported Queries, Filters, and Paging Options]. |
| keyCredentials | Collection([KeyCredential]) | POST, GET, PATCH | The collection of key credentials associated with the application<br/><br/> **Notes**: not nullable |
| knownClientApplications | Collection(Edm.Guid) | POST, GET, PATCH |  Client applications that are tied to this resource application. Consent to any of the known client applications will result in implicit consent to the resource application through a combined consent dialog (showing the OAuth permission scopes required by the client and the resource).<br/><br/> **Notes**: Requires version 1.5, not nullable. |
| logoutUrl | Edm.String | POST, GET, PATCH |  |
| mainLogo | Edm.Stream | POST, GET, PATCH | The main logo for the application.<br/><br/> **Notes**: not nullable |
| oauth2AllowImplicitFlow | Edm.Boolean | POST, GET, PATCH | Specifies whether this web application can request OAuth2.0 implicit flow tokens. The default is **false**.<br/><br/> **Notes**: Requires version 1.5, not nullable. |
| oauth2AllowUrlPathMatching | Edm.Boolean | POST, GET, PATCH | Specifies whether, as part of OAuth 2.0 token requests, Azure AD will allow path matching of the redirect URI against the application's **replyUrls**. The default is **false**.<br/><br/> **Notes**: Requires version 1.5, not nullable. |
| oauth2Permissions | Collection([OAuth2Permission]) | POST, GET, PATCH | The collection of OAuth 2.0 permission scopes that the web API (resource) application exposes to client applications. These permission scopes may be granted to client applications during consent.<br/><br/> **Notes**: Requires version 1.5, not nullable. |
| oauth2RequiredPostResponse | Edm.Guid | POST, GET, PATCH | Specifies whether, as part of OAuth 2.0 token requests, Azure AD will allow POST requests, as opposed to GET requests. The default is false, which specifies that only GET requests will be allowed.<br/><br/> **Notes**: Requires version 1.5, not nullable. |
| objectId | Edm.Guid | GET | The unique identifier for the application. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique |
| objectType | Edm.String | GET | A string that identifies the object type. For applications the value is always "Application". Inherited from [DirectoryObject]. |
| passwordCredentials | Collection([PasswordCredential]) | POST, GET, PATCH | The collection of password credentials associated with the application.<br/><br/> **Notes**: not nullable |
| publicClient | Edm.Boolean | POST, GET | Specifies whether this application is a public client (such as an installed application running on a mobile device). Default is **false**. |
| replyUrls | Collection(Edm.String) | POST, GET, PATCH | Specifies the URLs that user tokens are sent to for sign in, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to.<br/><br/> **Notes**: not nullable |
| requiredResourceAccess | Collection([RequiredResourceAccess]) | POST, GET, PATCH  | Specifies resources that this application requires access to and the set of OAuth permission scopes and application roles that it needs under each of those resources. This pre-configuration of required resource access drives the consent experience.<br/><br/> **Notes**: Requires version 1.5, not nullable. |
| samlMetadataUrl | Edm.String | POST, GET, PATCH | The URL to the SAML metadata for the application. |

**Navigation Properties**   

|  Name |  To |  Multiplicity <br/> (From/To) |  Description |
|:-------|:-------|:-------|:-------|
| extensionProperties | [ExtensionProperty] | \*/\* | The extension properties associated with the application. Requires 1.5 or newer. |
| owners | [DirectoryObject] | \*/\* | Directory objects that are owners of the application. The owners are a set of non-admin users who are allowed to modify this object. Requires version 2013-11-08 or newer. Inherited from [DirectoryObject]. |
**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on applications (HTTP methods are listed in parentheses):

- create (POST)
- read (READ)
- update (PATCH)
- delete (DELETE)

The following operations are supported on application navigation properties. Not all operations may be supported on every navigation property.

- read (READ)
- update (POST)
- delete (DELETE)

The following action may be called on applications.

- [restore] to restore a deleted application. Requires version 1.5 or newer.

---

### AppRoleAssignment Entity <a id="AppRoleAssignmentEntity"> </a>
Used to record when a user or group is assigned to an application. In this case, the role assignment will result in an application tile showing up on the user's app access panel. This entity may also be used to grant another application (modeled as a service principal) access to a resource application in a particular role. You can create, read, update, and delete role assignments. Inherits from [DirectoryObject].

**Important**: Introduced in version 1.5.
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| creationTimestamp | Edm.DateTime | GET | The time when the grant was created. |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for app role assignment and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| id | Edm.Guid | POST (Required), GET, PATCH | The role id that was assigned to the principal. This role must be declared by the target resource application **resourceId** in its **appRoles** property. Where the resource does not declare any permissions, a default id (zero GUID) must be specified.<br/><br/> **Notes**: not nullable. |
| principalDisplayName | Edm.String | GET | The display name of the principal that was granted the access. |
| objectId | Edm.String | GET | The unique identifier for the application role assignment. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For application role assignments the value is always "AppRoleAssignment". Inherited from [DirectoryObject]. |
| principalId | Edm.Guid | POST (Required), GET, PATCH | The unique identifier (**objectId**) for the principal being granted the access.<br/><br/> **Notes**: required. |
| principalType | Edm.String | GET | The type of principal. This can either be "User", "Group" or "ServicePrincipal". |
| resourceDisplayName | Edm.String | GET | The display name of the resource to which the assignment was made. |
| resourceId | Edm.Guid | POST (Required), GET, PATCH | The unique identifier (**objectId**) for the target resource (service principal) for which the assignment was made. |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

---

### Contact Entity <a id="ContactEntity"> </a>
Represents an organizational contact. Inherits from [DirectoryObject].

Organizational contacts represent users that are not in your company directory. They are mail-enabled entities and typically represent individuals who are external to your company or organization. Organizational contacts cannot be authenticated using Azure AD, nor can they be assigned licenses. 

Organizational contacts can be created in your tenant through syncing with an on-premises directory using Azure AD Connect, or they can be created through one of the Exchange Online management portals or the Exchange Online PowerShell cmdlets. For more information about Azure AD Connect, see [Integrating your on-premises identities with Azure Active Directory](https://azure.microsoft.com/en-us/documentation/articles/active-directory-aadconnect/). For more information about Exchange Online management tools, see [Exchange Online Setup and Administration](https://technet.microsoft.com/en-us/library/exchange-online-administration-and-management.aspx#BKMK_ExchangeAdministrationCenter). 

You cannot create organizational contacts with the Graph API. You can, however, update and delete contacts that are not currently synced from an on-premises directory; that is, contacts for which the **dirSyncEnabled** property is **null** or **false**. You cannot update or delete contacts for which the **dirSyncEnabled** property is **true**.

**Note**: Organizational contacts are directory entities, which represent external users. They should not be confused with O365 Outlook Personal contacts. 
 
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| city | Edm.String | GET ($filter), PATCH | The city in which the contact is located. |
| country | Edm.String | GET ($filter), PATCH | The country/region in which the contact is located. |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for contacts and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| department | Edm.String | GET ($filter), PATCH | The name for the department in which the contact works. |
| dirSyncEnabled | Edm.Boolean | GET ($filter) | **true** if this object is synced from an on-premises directory; **false** if this object was originally synced from an on-premises directory but is no longer synced; **null** if this object has never been synced from an on-premises directory (default). |
| displayName | Edm.String | GET ($filter), PATCH | The display name for the contact. |
| facsimileTelephoneNumber | Edm.String | GET, PATCH | The telephone number of the contact's business fax machine. |
| givenName | Edm.String | GET ($filter), PATCH | The given name (first name) of the contact. |
| jobTitle | Edm.String | GET ($filter), PATCH | The contact's job title. |
| lastDirSyncTime | Edm.DateTime | GET ($filter) | Indicates the last time at which the object was synced with the on-premises directory. |
| mail | Edm.String | GET ($filter) | The SMTP address for the contact, for example, "jeff@contoso.onmicrosoft.com". |
| mailNickname | Edm.String | GET ($filter), PATCH | The mail alias for the contact. |
| mobile | Edm.String | GET, PATCH | The primary cellular telephone number for the contact. |
| objectId | Edm.String | GET | The unique identifier for the contact. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For contacts the value is always "Contact". Inherited from [DirectoryObject]. |
| physicalDeliveryOfficeName | Edm.String | GET, PATCH | The office location in the contact's place of business. |
| postalCode | Edm.String | GET, PATCH | The postal code for the contact's postal address. The postal code is specific to the contact's country/region. In the United States of America, this attribute contains the ZIP code. |
| provisioningErrors | Collection([ProvisioningError]) | GET, PATCH | A collection of error details that are preventing this contact from being provisioned successfully.<br/><br/> **Note:** not nullable |
| proxyAddresses | Collection(Edm.String) | GET ($filter) | **Note:** unique, not nullable, the **any** operator is required for filter expressions on multi-valued properties; for more information, see [Supported Queries, Filters, and Paging Options]. |
| sipProxyAddress | Edm.String | GET | Specifies the voice over IP (VOIP) session initiation protocol (SIP) address for the contact.<br/><br/> **Notes**: Requires version 1.5 or newer. |
| state | Edm.String | GET ($filter), PATCH | The state or province in the contact's address. |
| streetAddress | Edm.String | GET, PATCH | The street address of the contact's place of business. |
| surname | Edm.String | GET ($filter), PATCH | The contact's surname (family name or last name). |
| telephoneNumber | Edm.String | GET, PATCH | The primary telephone number of the contact's place of business. |
| thumbnailPhoto | Edm.Stream | GET, PATCH | A thumbnail photo to be displayed for the contact.<br/><br/> **Note:** not nullable |

**Navigation Properties**  
 
| Name | To | Multiplicity <br/>(From/To) | Description |
|:-----|:---|:----------------------------|:------------|
| manager | [DirectoryObject]<br/><br/> (Only [User] and [Contact] objects are supported.) | \*/0..1 | The user or contact that is this contact's manager. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET, PUT, DELETE |
| directReports | [DirectoryObject]<br/><br/> (Only [User] and [Contact] objects are supported.) | \*/\* | The contact's direct reports. (The users and contacts that have their manager property set to this contact.) Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET |
| memberOf | [DirectoryObject]<br/><br/> (Only [Group] objects are supported.) | \*/\* | Groups that this contact is a member of. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET |
**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on contacts (the HTTP method used for each is in parentheses): 

- Read (GET)
- Update (PATCH): only contacts that are not synced from an on-premises directory (**dirSyncEnabled** is **null** or **false**).
- Delete (DELETE)

The following operations are supported on contact navigation properties; not all operations may be supported on every navigation property.

- Read (GET)
- Update (PUT): **manager** property, only on contacts that are not synced from an on-premises directory (**dirSyncEnabled** is **null** or **false**).
- Delete (DELETE): **manager** property, only on contacts that are not synced from an on-premises directory (**dirSyncEnabled** is **null** or  **false**).

The following actions and functions may be called on contacts:

- [checkMemberGroups] to check a contact’s membership in a list of groups. The check is transitive.
- [getMemberGroups] to return a list of the groups that a contact is a member of. The check is transitive.
- [isMemberOf] to check whether a contact is a member of a specified group. The check is transitive.

#### Remarks
Contacts are mail-enabled entities and cannot be created by using the Graph API. They can be updated; however, update is only supported for contacts with the **dirSyncEnabled** property set **null** or **false**. Contacts can be deleted.

---

### Contract Entity <a id="ContractEntity"> </a>
Exists in Partner Tenants only. Partner Tenants are Azure AD tenants that belong to Microsoft Partners who are either part of Office 365 Syndication, Microsoft Cloud Solution Provider, or Microsoft Advisor partner programs. Represents an existing partnership that the Partner Tenant has with a Customer Tenant. Read-only. Inherits from [DirectoryObject].

**Important**: Introduced in version 1.5.
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| customerContextId | Edm.Guid | GET ($filter) | The unique identifier for the customer tenant referenced by this partnership. Corresponds to the **objectId** property of the customer tenant's [TenantDetail] object. |
| defaultDomainName | Edm.String | GET ($filter) | A copy of the customer tenant's default domain name. The copy is made when the partnership with the customer is established. It is not automatically updated if the customer tenant's default domain name changes. |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for contracts and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| displayName | Edm.String | GET ($filter) | A copy of the customer tenant's display name. The copy is made when the partnership with the customer is established. It is not automatically updated if the customer tenant's display name changes. |
| objectType | Edm.String | GET | A string that identifies the object type. The value is always “Contract”. Inherited from [DirectoryObject]. |
| objectId | Edm.String | GET | The unique identifier for the partnership. Inherited from [DirectoryObject]. <br/> <br/> **Notes**: **key**, immutable, not nullable, unique. |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on contracts (the HTTP method used for each is in parentheses): 

- Read (GET)


---

### Device Entity <a id="DeviceEntity"> </a>
Represents a device registered in the directory. Inherits from [DirectoryObject].


#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| accountEnabled | Edm.Boolean | POST, GET ($filter), PATCH |  |
| alternativeSecurityIds | Collection([AlternativeSecurityId]) | POST, GET ($filter), PATCH | **Notes**: not nullable, the **any** operator is required for filter expressions on multi-valued properties; for more information, see [Supported Queries, Filters, and Paging Options]. |
| approximateLastLogonTimeStamp | Edm.DateTime | POST, GET, PATCH |  |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for devices and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| deviceId | Edm.Guid | POST (Required), GET ($filter), PATCH |  |
| deviceObjectVersion | Edm.Int32 | POST, GET, PATCH |  |
| deviceOSType | Edm.String | POST (Required), GET, PATCH | The type of operating system on the device. |
| deviceOSVersion | Edm.String | POST (Required), GET, PATCH | The version of the operating system on the device |
| devicePhysicalIds | Collection(Edm.String) | POST, GET ($filter), PATCH | **Notes**: not nullable |
| dirSyncEnabled | Edm.Boolean | GET ($filter) | **true** if this object is synced from an on-premises directory; **false** if this object was originally synced from an on-premises directory but is no longer synced; **null** if this object has never been synced from an on-premises directory (default). |
| displayName | Edm.String | POST (Required), GET ($filter), PATCH | The display name for the device. |
| isCompliant | Edm.Boolean | POST, GET, PATCH | **true** if the device complies with Mobile Device Management (MDM) policies; otherwise, **false**. |
| IsManaged | Edm.Boolean | POST, GET, PATCH | **true** if the device is managed by a Mobile Device Management (MDM) app such as Intune; otherwise, **false**. |
| lastDirSyncTime | Edm.DateTime | GET ($filter) | The last time at which the object was synced with the on-premises directory. |
| objectId | Edm.String | GET | The unique identifier for the device. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique |
| objectType | Edm.String | GET | A string that identifies the object type. For devices the value is always "Device". Inherited from [DirectoryObject] |

**Navigation Properties**
  
| Name | To | Multiplicity<br/>(From/To) | Description |
|:-----|:---|:---------------------------|:------------|
| registeredOwners | [User] | \*/\* | Users that are registered owners of the device. |
| registeredUsers | [User] | \*/\* | Users that are registered users of the device. |

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on devices (HTTP methods are listed in parentheses):

- Create (CREATE)
- Read (READ)
- Update (PATCH)
- Delete (DELETE)

The following operations are supported on device navigation properties. Not all operations may be supported on every navigation property.

- Read (READ)
- Update (PUT)
- Delete (DELETE)

No functions or actions are supported on devices.

---

### DirectoryLinkChange Entity <a id="DirectoryLinkChangeEntity"> </a>
A **DirectoryLinkChange** object is returned in the result set of a differential query to indicate that a property of a contact, a user, or a group that is represented by a link has changed since the last differential query. The **DirectoryLinkChange** object will represent a change to a user’s or contact’s **manager** property or a change to a group’s **members** property. For more information about differential queries, see [Differential Query]. Inherits from [DirectoryObject].
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| associationType | Edm.String | GET | A string that identifies the association type to which the change applies. The value is either "Member" or "Manager". |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for directory link change objects and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| objectId | Edm.String | GET | The unique identifier for the directory link change object. For **DirectoryLinkChange** objects, the value is always 00000000-0000-0000-0000-000000000000. Inherited from [DirectoryObject].<br/><br/> **Note: key** immutable, not nullable, unique |
| objectType | Edm.String | GET | A string that identifies the object type. For **DirectoryLinkChange** objects, the value is always "DirectoryLinkChange". [DirectoryObject] |
| sourceObjectId | Edm.String | GET | The object ID for the source object; for example, "7373b0af-d462-406e-ad26-f2bc96d823d8". |
| sourceObjectType | Edm.String | GET | A string that identifies the source object type; this will be one of the following: "Group", "User", or "Contact". |
| sourceObjectUri | Edm.String | GET | The URI for the source object; for example, `"https://graph.windows.net/contoso.com/groups/7373b0af-d462-406e-ad26-f2bc96d823d8"`. |
| targetObjectId | Edm.String | GET | The object ID for the target object; for example, "dca803ab-bf26-4753-bf20-e1c56a9c34e2". |
| targetObjectType | Edm.String | GET | A string that identifies the source object type; this will be one of the following: "Group", "User", or "Contact". |
| targetObjectUri | Edm.String | GET | The URI for the target object; for example, `"https://graph.windows.net/contoso.com/users/dca803ab-bf26-4753-bf20-e1c56a9c34e2"`. |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

---

### DirectoryObject Entity <a id="DirectoryObjectEntity"> </a>
Represents an Azure Active Directory object. The **DirectoryObject** type is the base type for most of the other directory entity types.
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:----|:----|:----------|:----------|
| deletionTimestamp | Edm.DateTime | GET | The time at which the directory object was deleted. It only applies to those directory objects which can be restored. Currently it is only supported for deleted [Application] objects; all other entities return **null** for this property.<br/><br/> **Notes**: Requires version 1.5 or newer. |
| objectId | Edm.String | GET | A Guid that is the unique identifier for the object; for example, 12345678-9abc-def0-1234-56789abcde.<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For example, for groups the value is always "Group". |
**Navigation Properties**   

| Name | To | Multiplicity<br/>(From/To) | Description |
|:-----|:---|:---------------------------|:------------|
| createdObjects | DirectoryObject | \*/\* | The directory objects that were created by the current object. Read only. Requires version 2013-11-08 or newer. |
| createdOnBehalfOf | DirectoryObject | \*/0..1 | The directory object that that this object was created on behalf of. Read only. Requires version 2013-11-08 or newer. |
| manager | DirectoryObject | \*/0..1 | This object's manager. Valid on users and contacts. Returns a user or a contact. |
| directReports | DirectoryObject | \*/\* | Users and contacts that report to this object. Valid on users and contacts. Returns users and contacts. Read only. |
| members | DirectoryObject | \*/\* | Objects that are members of this object. Valid on groups and roles. On groups, returns contacts, users, and groups. On roles, returns users and service principals. |
| memberOf | DirectoryObject | \*/\* | Objects that this object is a member of. Valid on contacts, groups, service principals, and users. On contacts, returns groups. On groups, returns groups. On users, returns groups and roles. On service principals, returns roles. Read only.<br/><br/> The property is not transitive. For example, if User A is a member of Group B and Group B is a member of Group C, the memberOf property on User A will not return Group C. |
| ownedObjects | DirectoryObject | \*/\* | The directory objects that are owned by the current object. Read only. Requires version 2013-11-08 or newer. |
| owners | DirectoryObject | \*/\* | The directory objects that are owners of the current object. The owners are a set of non-admin users who are allowed to modify this object. Requires version 2013-11-08 or newer. |

**Note:** Not all navigation properties are necessarily valid on the entity types that inherit from **DirectoryObject**. If a request for a property that is not valid for a specific entity is sent, a **400 Bad Request** response is returned. For more information about which navigation properties are valid on specific entities, consult the documentation for that entity type. 

#### Supported Operations
The full set of operations that are supported on directory objects are the following (the HTTP method used for each is in parentheses): Create (POST), Read (GET), Update (PATCH), and Delete (DELETE). However, not all of these operations are supported on every entity type. The declared properties of directory object are read-only; they cannot be specified in create or update operations.

The potential set of operations supported on each of the navigation properties are: 

- **createdObjects**: Read (GET).
- **createdOnBehalfOf**: Read (GET).
- **manager**: Read (GET), Update (PUT), and Delete (DELETE).
- **directReports**: Read (GET). 
- **members**: Read (GET), Update (POST), and Delete (DELETE).
- **memberOf**: Read (GET).
- **ownedObjects**: Read (GET).
- **owners**: Read (GET), Update (POST), and Delete (DELETE).

Not all navigation properties are necessarily supported on every entity type, nor are the set of potential operations for a navigation property necessarily supported on every entity type.

Whether a particular directory object supports a particular action or function, depends on the type of the directory object (the **objectType** property). For information about which object types support which functions or actions, see the documentation of the particular object, for example, user, group, etc., or of a particular function.

Consult the documentation for the specific entity type for information about operations supported for an entity.

---

### DirectoryRole Entity <a id="DirectoryRoleEntity"> </a>
Represents an Azure AD directory role. Azure AD directory roles are also known as *administrator roles*. For more information about directory (administrator) roles, see [Assigning administrator roles in Azure AD](http://azure.microsoft.com/documentation/articles/active-directory-assign-admin-roles/).

With the Graph API, you can assign users and service principals to directory roles to grant them the permissions of the target role. You can read directory role objects and update the **members** navigation property of directory roles, but you cannot delete directory roles or update their declared properties. Inherits from [DirectoryObject]. 

To read a directory role or update its members, it must first be activated in the tenant. In versions prior to 1.5, all directory roles are activated by default. Beginning with version 1.5, only the **Company Administrators** directory role is activated by default. To activate other available directory roles you send a POST request with the **objectId** of the [DirectoryRoleTemplate] on which the directory role is based. See **Supported Operations** and **Remarks** for more information.

**Important**: Beginning with version 1.5, the **Role** entity type is renamed to **DirectoryRole**.
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for directory roles and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| description | Edm.String | GET | The description for the directory role. |
| displayName | Edm.String | GET | The display name for the directory role. |
| isSystem | Edm.Boolean | GET | **true** if the role is a system role; otherwise, **false**. |
| objectId | Edm.String | GET | The unique identifier for the directory role. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For directory roles the value is always "DirectoryRole". Inherited from [DirectoryObject].<br/><br/> **Note**: In versions prior to 1.5, the value will be "Role". |
| roleDisabled | Edm.Boolean | GET | **true** if the directory role is disabled; otherwise, **false**. |
| roleTemplateId | String | POST (Required), GET | The **objectId** of the [DirectoryRoleTemplate] that this role is based on. <br/><br/> **Notes**: In versions prior to version 1.5, the property is read only. In version 1.5 and later, the property must be specified when activating a directory role in a tenant with a POST operation. After the directory role has been activated, the property is read only. |

**Navigation Properties**   

|  Name |  To |  Multiplicity<br/>(From/To) |  Description |
|:-------|:-------|:-------|:-------|:-------|
| members | [DirectoryObject]<br/><br/> ([User] and [ServicePrincipal] are supported.) | \*/\* | Users and service principals that are members of this directory role. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET, POST, DELETE |

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on directory roles (the HTTP method used for each is in parentheses): 

- Create (POST): Supported in version 1.5 and later. Activates a directory role in the tenant using the [DirectoryRoleTemplate] specified by the **roleTemplateId** property in the request. After the directory role is activated, you can add and delete users and service principals from the role.
- Read (GET)

The following operations are supported on directory role navigation properties: 

- Read (GET)
- Update (POST)
- Delete (DELETE)

No functions or actions may be called on directory roles; however, you can call [getMemberObjects] on a [User] or [ServicePrincipal] to determine its directory role memberships. Note that for users, this function also returns its direct and transitive group memberships.

#### Remarks
- In version 1.5 and later, only the **Company Adminstrators** role is activated (and visible) in a tenant by default. Use the Create (POST) operation to activate additional directory roles. The operation specifies the **roleTemplateId** property in the request. This property contains the **objectId** of the [DirectoryRoleTemplate] instance that corresponds to the role you want to activate. After the directory role is activated you can add and delete users and service principals from it with the Graph API. In versions prior to 1.5, all directory roles (represented by the **Role** entity) are activated by default and the Create (POST) operation is not supported.
- Directory roles cannot be deleted using the Graph API. Updates are supported on the **members** navigation property only. Both add and remove are supported on this property.
- Query filter expressions are not supported on directory roles.

---

### DirectoryRoleTemplate Entity <a id="DirectoryRoleTemplateEntity"> </a>
Represents a directory role template. A directory role template specifies the property values of a directory role ([DirectoryRole]). There is an associated directory role template object for each of the directory roles that may be activated in a tenant. Inherits from [DirectoryObject].

To read a directory role or update its members, it must first be activated in the tenant. In versions prior to 1.5, all directory roles are activated by default. Beginning with version 1.5, only the **Company Administrators** directory role is activated by default. To activate other available directory roles you send a POST request to the /directoryRoles endpoint with the **objectId** of the directory role template on which the directory role is based specified in the **roleTemplateId** parameter of the request. For more information, see [DirectoryRole].

**Note**: A directory role template is exposed for the **Users** directory role. The **Users** directory role is implicit and is not visible to directory clients. Every [User] in the tenant is assigned to this role by the infrastructure. The role is already activated. Do not use this template.

**Important**: Introduced in version 1.5.

#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| description | Edm.String | GET | The description to set for the directory role. |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for directory role templates and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| displayName | Edm.String | GET | The display name to set for the directory role. |
| objectId | Edm.String | GET | The unique identifier for the template. Inherited from [DirectoryObject]. In version 1.5 and later, you specify the **objectId** of the directory role template for the **roleTemplateId** property in the POST request activate a [DirectoryRole] in a tenant. <br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For role templates the value is always "RoleTemplate". Inherited from [DirectoryObject]. |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on directory role templates (HTTP methods are listed in parentheses):

- read (GET)

---

###Domain Entity (preview) <a id="DomainEntity"> </a>
Represents a domain associated with the tenant.

**Important**: Only available in version beta.
####Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| authenticationType | Edm.String | GET | Indicates what authentication type the domain is configured for. The value is either "Managed" or "Federated". |
| availabilityStatus | Edm.String | GET | This property is always null except when the [verify] action is used. When the [verify] action is used, a **Domain** entity is returned in the response. The **availabilityStatus** property of the **Domain** entity in the response is either "AvailableImmediately" or "EmailVerifiedDomainTakeoverScheduled". |
| isAdminManaged | Edm.Boolean | GET | **false**, if the DNS record management of the domain has been delegated to Office 365. Otherwise, **true**.<br/><br/>**Notes**: not nullable |
| isDefault | Edm.Boolean | GET, PATCH | Indicates whether or not this is the default domain that is used for user creation. There is only one default domain per company.<br/><br/>**Notes**: not nullable |
| isInitial | Edm.Boolean | GET | Indicates whether or not this is the initial domain created by Microsoft Online Services (companyname.onmicrosoft.com). There is only one initial domain per company.<br/><br/>**Notes**: not nullable |
| isRoot | Edm.Boolean | GET | For subdomains, this represents the root domain. Only root domains need to be verified, and all subdomains will be automatically verified.<br/><br/>**Notes**: not nullable |
| isVerified | Edm.Boolean | GET | Indicates whether this domain has completed domain ownership verification or not.<br/><br/>**Notes**: not nullable |
| name | Edm.String | POST (Required), GET ($filter) | The fully qualified name of the domain.<br/><br/>**Notes**: key, immutable, not nullable, unique |
| supportedServices | Collection(Edm.String) | GET, PATCH | The capabilities assigned to the domain. Can include 0, 1 or more of following values:<ul><li>"Email"</li><li>"Sharepoint"</li><li>"EmailInternalRelayOnly"</li><li>"OfficeCommunicationsOnline"</li><li>"SharePointDefaultDomain"</li><li>"FullRedelegation"</li><li>"SharePointPublic"</li><li>"OrgIdAuthentication"</li><li>"Yammer"</li><li>"Intune"</li></ul><br/><br/>Most of these values are read-only. The values which you can add/remove using Graph API includes:<ul><li>"Email"</li><li>"OfficeCommunicationsOnline"</li><li>"Yammer"</li></ul><br/><br/>**Notes**: not nullable |

**Navigation Properties**

| Name | To | Multiplicity<br/>(From/To) | Description |
|:-----|:---|:---------------------------|:------------|
| serviceConfigurationRecords | [DomainDnsRecord] | \*/\* | DNS records that the customer has to add to the DNS zone file of the domain before the domain can be used by Microsoft Online services. |
| verificationDnsRecords | [DomainDnsRecord] | \*/\* | DNS records that the customer has to add to the DNS zone file of the domain before the customer can complete domain ownership verification with Azure AD. |

---
 
###DomainDnsRecord Entity (preview) <a id="DomainDnsRecordEntity"> </a>
For each domain in the tenant, you may be required to add DNS record(s) to the DNS zone file of the domain before the domain can be used by Microsoft Online Services.  The **DomainDnsRecord** entity is used to present such DNS records. Base entity for [DomainDnsCnameRecord], [DomainDnsMxRecord], [DomainDnsSrvRecord] and [DomainDnsSrvRecord] entities.

**Important**: Only available in version beta.
####Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| dnsRecordId | Edm.Guid | GET | Unique identifier assigned to this entity.<br/><br/>**Notes**: not nullable |
| isOptional | Edm.Boolean | GET | Indicates whether this record must be configured by the customer at the DNS host for Microsoft Online Services to operate correctly with the domain.<br/><br/>**Notes**: not nullable |
| label | Edm.String | GET | Indicates the value to use when configuring the name of the DNS record at the DNS host. |
| recordType | Edm.String | GET | Indicates what type of DNS record this entity represents. The value can be one of the following:<ul><li>"CName"</li><li>"Mx"</li><li>"Srv"</li><li>"Txt"</li></ul><br/><br/>**Notes**: key |
| supportedService | Edm.String | GET | Indicates which Microsoft Online Service or feature has a dependency on this DNS record. Can be one of the following values:<ul><li>**null**</li><li>"Email"</li><li>"Sharepoint"</li><li>"EmailInternalRelayOnly"</li><li>"OfficeCommunicationsOnline"</li><li>"SharePointDefaultDomain"</li><li>"FullRedelegation"</li><li>"SharePointPublic"</li><li>"OrgIdAuthentication"</li><li>"Yammer"</li><li>"Intune"</li></ul> |
| ttl | Edm.Int32 | GET | Indicates the value to use when configuring the time-to-live (ttl) property of the DNS record at the DNS host.<br/><br/>**Notes**: not nullable |

---
 
###DomainDnsCnameRecord Entity (preview) <a id="DomainDnsCnameRecordEntity"> </a>
Represents a CNAME record which needs to be added to the DNS zone file of a particular domain in the tenant. Inherited from [DomainDnsRecord] entity.

**Important**: Only available in version beta.
####Properties
**Declared Properties**

Name | Type | Supports | Description
-----|-----|-----|-----
canonicalName | Edm.String | GET | Indicates the value to use when configuring the canonical name of the CNAME record at the DNS host.
dnsRecordId | Edm.Guid | GET | Unique identifier assigned to this entity.<br/><br/>**Notes**: not nullable
isOptional | Edm.Boolean | GET | Indicates whether this CNAME record must be configured by the customer at the DNS host for Microsoft Online Services to operate correctly with the domain.<br/><br/>**Notes**: not nullable
label | Edm.String | GET | Indicates the value to use when configuring the name of the CNAME record at the DNS host.
recordType | Edm.String | GET | Indicates what type of DNS record this entity represents. The value is always "CName".<br/><br/>**Notes**: key
supportedService | Edm.String | GET | Indicates which Microsoft Online Service or feature has a dependency on this CNAME record. Can be one of the following values:<ul><li>**null**</li><li>"Email"</li><li>"Sharepoint"</li><li>"EmailInternalRelayOnly"</li><li>"OfficeCommunicationsOnline"</li><li>"SharePointDefaultDomain"</li><li>"FullRedelegation"</li><li>"SharePointPublic"</li><li>"OrgIdAuthentication"</li><li>"Yammer"</li><li>"Intune"</li></ul>
ttl | Edm.Int32 | GET | Indicates the value to use when configuring the time-to-live (ttl) property of the CNAME record at the DNS host.<br/><br/>**Notes**: not nullable

---
 
###DomainDnsMxRecord Entity (preview) <a id="DomainDnsMxRecordEntity"> </a>
Represents an MX record which needs to be added to the DNS zone file of a particular domain in the tenant. Inherited from [DomainDnsRecord] entity.

**Important**: Only available in version beta.
####Properties
**Declared Properties**

Name | Type | Supports | Description
-----|-----|-----|-----
dnsRecordId | Edm.Guid | GET | Unique identifier assigned to this entity.<br/><br/>**Notes**: not nullable
isOptional | Edm.Boolean | GET | Indicates whether this MX record must be configured by the customer at the DNS host for Microsoft Online Services to operate correctly with the domain.<br/><br/>**Notes**: not nullable
label | Edm.String | GET | Value to use when configuring the Alias/Host/Name property of the MX record at the DNS host.
mailExchange | Edm.String | GET | Value to use when configuring the Answer/Destination/Value of the MX record at the DNS host.
recordType | Edm.String | GET | Indicates what type of DNS record this entity represents. The value is always "Mx".<br/><br/>**Notes**: key
preference | Edm.Int32 | GET | Value to use when configuring the Preference/Priority property of the MX record at the DNS host.
supportedService | Edm.String | GET | Indicates which Microsoft Online Service or feature has a dependency on this CNAME record. Can be one of the following values:<ul><li>**null**</li><li>"Email"</li><li>"Sharepoint"</li><li>"EmailInternalRelayOnly"</li><li>"OfficeCommunicationsOnline"</li><li>"SharePointDefaultDomain"</li><li>"FullRedelegation"</li><li>"SharePointPublic"</li><li>"OrgIdAuthentication"</li><li>"Yammer"</li><li>"Intune"</li></ul>
ttl | Edm.Int32 | GET | Value to use when configuring the time-to-live (ttl) property of the MX record at the DNS host.<br/><br/>**Notes**: not nullable

---
 
###DomainDnsSrvRecord Entity (preview) <a id="DomainDnsSrvRecordEntity"> </a>
Represents an SRV record which needs to be added to the DNS zone file of a particular domain in the tenant. Inherited from [DomainDnsRecord] entity.

**Important**: Only available in version beta.
####Properties
**Declared Properties**

Name | Type | Supports | Description
-----|-----|-----|-----
dnsRecordId | Edm.Guid | GET | Unique identifier assigned to this entity.<br/><br/>**Notes**: not nullable
isOptional | Edm.Boolean | GET | Indicates whether this SRV record must be configured by the customer at the DNS host for Microsoft Online Services to operate correctly with the domain.<br/><br/>**Notes**: not nullable
label | Edm.String | GET | Value to use when configuring the **Name** property of the SRV record at the DNS host.
nameTarget | Edm.String | GET | Value to use when configuring the **Target** property of the SRV record at the DNS host.
port | Edm.Int32 | GET | Value to use when configuring the **Port** property of the SRV record at the DNS host.
priority | Edm.Int32 | GET | Value to use when configuring the **Priority** property of the SRV record at the DNS host.
protocol | Edm.String | GET | Value to use when configuring the **Protocol** property of the SRV record at the DNS host.
recordType | Edm.String | GET | Indicates what type of DNS record this entity represents. The value is always "Srv".<br/><br/>**Notes**: key
Service | Edm.String | GET | Value to use when configuring the **Service** property of the SRV record at the DNS host.
supportedService | Edm.String | GET | Indicates which Microsoft Online Service or feature has a dependency on this SRV record. Can be one of the following values:<ul><li>**null**</li><li>"Email"</li><li>"Sharepoint"</li><li>"EmailInternalRelayOnly"</li><li>"OfficeCommunicationsOnline"</li><li>"SharePointDefaultDomain"</li><li>"FullRedelegation"</li><li>"SharePointPublic"</li><li>"OrgIdAuthentication"</li><li>"Yammer"</li><li>"Intune"</li></ul>
ttl | Edm.Int32 | GET | Value to use when configuring the **Time-To-Live** property of the SRV record at the DNS host.<br/><br/>**Notes**: not nullable
weight | Edm.Int32 | GET | Value to use when configuring the **Weight** property of the SRV record at the DNS host.

---
 
###DomainDnsTxtRecord Entity (preview) <a id="DomainDnsTxtRecordEntity"> </a>
Represents a TXT record which needs to be added to the DNS zone file of a particular domain in the tenant. Inherited from [DomainDnsRecord] entity.

**Important**: Only available in version beta.
####Properties
**Declared Properties**

Name | Type | Supports | Description
-----|-----|-----|-----
dnsRecordId | Edm.Guid | GET | Unique identifier assigned to this entity.<br/><br/>**Notes**: not nullable
isOptional | Edm.Boolean | GET | Indicates whether this MX record must be configured by the customer at the DNS host for Microsoft Online Services to operate correctly with the domain.<br/><br/>**Notes**: not nullable
label | Edm.String | GET | Value to use when configuring the Alias/Host/Name property of the MX record at the DNS host.
recordType | Edm.String | GET | Indicates what type of DNS record this entity represents. The value is always "Mx".<br/><br/>**Notes**: key
supportedService | Edm.String | GET | Indicates which Microsoft Online Service or feature has a dependency on this CNAME record. Can be one of the following values:<ul><li>**null**</li><li>"Email"</li><li>"Sharepoint"</li><li>"EmailInternalRelayOnly"</li><li>"OfficeCommunicationsOnline"</li><li>"SharePointDefaultDomain"</li><li>"FullRedelegation"</li><li>"SharePointPublic"</li><li>"OrgIdAuthentication"</li><li>"Yammer"</li><li>"Intune"</li></ul>
text | Edm.String | GET |  | 		
ttl | Edm.Int32 | GET | Value (in seconds) to use when configuring the Time-To-Live property of the TXT record at the DNS host.<br/><br/>**Notes**: not nullable


---
 
###DomainDnsUnavailableRecord Entity (preview) <a id="DomainDnsUnavailableRecordEntity"> </a>
Inherited from [DomainDnsRecord] entity. When you query for the navigation property **serviceConfigurationRecords** for a [Domain] entity, you may get back one or more [DomainDnsCnameRecord], [DomainDnsMxRecord], [DomainDnsSrvRecord] and/or [DomainDnsTxtRecord] entities. These entities indicate what DNS records you must add to the zone file of the domain, before the domain can be used by Microsoft Online Services. When it is not possible to generate such entities, a **DomainDnsUnavailableRecord** Entity is returned instead. 

**Important**: Only available in version beta.
####Properties
**Declared Properties**

Name | Type | Supports | Description
-----|-----|-----|-----
description | Edm.String | GET | Provides the reason why the **DomainDnsUnavailableRecord** entity is returned.

---

### ExtensionProperty Entity <a id="ExtensionPropertyEntity"> </a>
Allows an application to define and use a set of additional properties that can be added to directory objects (users, groups, tenant details, devices, applications, and service principals) without the application requiring an external data store. For more information about extension properties, see [Directory Schema Extensions]. Inherits from [DirectoryObject].

**Important**: **ExtensionProperty** is introduced in version 1.5.

#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| appDisplayName | Edm.String | GET |  |
| dataType | Edm.String | POST, GET, PATCH | Specifies the type of the directory extension property being added. Supported types are: Integer, LargeInteger, DateTime (must be specified in ISO 8601 - DateTime is stored in UTC), Binary, Boolean, and String. |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for extension properties and always returns **null**. Inherited from [DirectoryObject]. |
| objectId | Edm.String | GET | The unique identifier for the permission scope. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For extension properties the value is always "ExtensionProperty". Inherited from [DirectoryObject]. |
| name | Edm.String | POST, GET, PATCH | Specifies the display name for the directory extension property.<br/><br/> **Notes**: not nullable. |
| isSyncedFromOnPremises | Edm.Boolean | GET | Indicates whether the extension property is synced from the on premises directory.<br/><br/> **Notes**: not nullable. |
| targetObjects | Collection(Edm.String) | POST, GET, PATCH | The directory objects to which the directory extension property is being added. Supported directory entities that can be extended are: "User", "Group", "TenantDetail", "Device", "Application" and "ServicePrincipal"<br/><br/> **Notes**: not nullable. |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

---

### Group Entity <a id="GroupEntity"> </a>
Represents an Azure Active Directory Group. Inherits from [DirectoryObject].
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for groups and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| description | Edm.String | POST, GET, PATCH | An optional description for the group. |
| dirSyncEnabled | Edm.Boolean | GET ($filter) | **true** if this object is synced from an on-premises directory; **false** if this object was originally synced from an on-premises directory but is no longer synced; **null** if this object has never been synced from an on-premises directory (default). |
| displayName | Edm.String | POST (Required), GET ($filter), PATCH | The display name for the group. This property is required when a group is created and it cannot be cleared during updates. |
| lastDirSyncTime | Edm.DateTime | GET ($filter) | Indicates the last time at which the object was synced with the on-premises directory. |
| mail | Edm.String | GET ($filter) | The SMTP address for the group, for example, "serviceadmins@contoso.onmicrosoft.com". |
| mailEnabled | Edm.Boolean | POST (Required), GET, PATCH | Specifies whether the group is mail-enabled. If the **securityEnabled** property is also **true**, the group is a mail-enabled security group; otherwise, the group is a Microsoft Exchange distribution group. Only (pure) security groups can be created using Azure AD Graph. For this reason, the property must be set **false** when creating a group and it cannot be updated using Azure AD Graph. |
| mailNickname | Edm.String | POST (Required), GET ($filter), PATCH | The mail alias for the group. This property must be specified when a group is created. |
| objectId | Edm.String | GET | The unique identifier for the group. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For groups the value is always "Group". Inherited from [DirectoryObject]. |
| onPremisesSecurityIdentifier | String | GET | Contains the on-premises security identifier (SID) for the group that was synchronized from on-premises to the cloud.<br/><br/> **Notes**: Requires version 1.5 or newer. |
| provisioningErrors | Collection([ProvisioningError]) | GET | A collection of error details that are preventing this group from being provisioned successfully.<br/><br/> **Notes**: not nullable. |
| proxyAddresses | Collection(Edm.String) | GET ($filter) | <br/><br/> **Notes**: not nullable, the **any** operator is required for filter expressions on multi-valued properties; for more information, see [Supported Queries, Filters, and Paging Options]. |
| securityEnabled | Edm.Boolean | POST (Required), GET ($filter), PATCH | Specifies whether the group is a security group. If the mailEnabled property is also true, the group is a mail-enabled security group; otherwise it is a security group. Only (pure) security groups can be created using Azure AD Graph. For this reason, the property must be set **true** when creating a group. |

**Navigation Properties**   

| Name | To | To Multiplicity | Description |
|:-----|:---|:----------------|:------------|
| members | [DirectoryObject]<br/><br/> (Only [Contact], [Group], [ServicePrincipal], and [User] objects are supported) | \*/\* | Users, contacts, groups, and service principals that are members of this group. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET (supported for all groups), POST (supported for security groups and mail-enabled security groups), DELETE (supported only for security groups) |
| memberOf | [DirectoryObject]<br/><br/> (Only [Group] objects are supported) | \*/\* | Groups that this group is a member of. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET (supported for all groups) |
| owners | [DirectoryObject] | \*/\* | The owners of the group. The owners are a set of non-admin users who are allowed to modify this object. Requires version 2013-11-08 or newer. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET (supported for all groups), POST (supported for security groups and mail-enabled security groups), DELETE (supported only for security groups) |
| appRoleAssignments | [DirectoryObject] | \*/\* | Contains the set of applications that a group is assigned to.<br/><br/> **Notes**: Requires version 1.5 or newer. |
| extensionProperties | [DirectoryObject] | \*/\* | Contains the extension properties associated with the application. <br/><br/> **Notes**: Requires version 1.5 or newer. |

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on users (the HTTP method used for each is in parentheses): 

- Create (POST): Supported only for security groups.
- Read (GET): Supported for all groups.
- Update (PATCH): Supported only for security groups and mail-enabled security groups. Not all properties can be updated.
- Delete (DELETE): Supported only for security groups.

The following operations are supported on group navigation properties: 

- Read (GET): Supported for all groups.
- Update (POST): Supported only for security groups and mail-enabled security groups. (members and owners only.)
- Delete (DELETE): Supported only for security groups. (members and owners only.)

The following actions and functions may be called on groups:

- [checkMemberGroups] to check a group’s membership in a list of groups. The check is transitive.
- [getAvailableExtensionProperties] to return a list of the extension properties that have been registered for a group. Requires version 1.5 or newer.
- [getMemberGroups] to return a list of the groups that a group is a member of. The check is transitive.
- [isMemberOf] to check whether a group is a member of a specified group. The check is transitive.

#### Remarks

- There are three kinds of groups: mail distribution groups (**mailEnabled** property **true** and **securityEnabled** property **false**); mail-enabled security groups (**mailEnabled** property **true** and **securityEnabled** property **true**); and, (pure) security groups (**mailEnabled** property **false** and **securityEnabled** property **true**).
- You can only create security groups using the Graph API (you cannot create mail-enabled security groups or mail distribution groups). For this reason the **mailEnabled** property must be set **false** and the **securityEnabled** property must be set **true** when creating a group.
- All properties marked required must be specified when creating a security group using the Graph API. These properties are: **displayName**, **mailNickname**, **mailEnabled** (**false**), **securityEnabled** (**true**).
- You cannot update a group from a security group to a mail-enabled security group or to a mail distribution group using the Graph API.

---

### OAuth2PermissionGrant Entity <a id="OAuth2PermissionGrantEntity"> </a>
Represents the OAuth 2.0 delegated permission scopes that have been granted to an application (represented by a service principal) as part of the user or admin consent process. 

**Important**: Beginning with version 1.5, the **Permission** entity type is renamed to **OAuth2PermissionGrant**. In versions prior to 1.5, permissions created during consent were added to the **permissions** property of a user or service principal.
#### Properties
**Declared Properties**

| Property | Type | Supports | Description |
|:---------|:-----|:---------|:------------|
| clientId | Edm.String | POST, GET | Specifies the **objectId** of the service principal granted consent to impersonate the user when accessing the resource (represented by the **resourceId**). |
| consentType | Edm.String | POST, GET | Specifies whether consent was provided by the administrator on behalf of the organization or whether consent was provided by an individual. The possible values are "AllPrincipals" or "Principal". |
| expiryTime | Edm.DateTime | POST, GET, PATCH | Reserved. Returns **null**. Do not use. |
| objectId | Edm.String | GET | The unique identifier for the permission scope.<br/><br/> **Notes**: **key**, not nullable. |
| principalId | Edm.String | POST, GET | If **consentType** is "AllPrincipals" this value is null, and the consent applies to all users in the organization. If **consentType** is "Principal" then this property specifies the **objectId** of the user that granted consent, and applies only for that user. |
| resourceId | Edm.String | POST, GET | Specifies the **objectId** of the resource service principal to which access has been granted. |
| scope | Edm.String | POST, GET, PATCH | Specifies the value of the scope claim that the resource application should expect in the OAuth 2.0 access token. |
| startTime | Edm.DateTime | POST, GET | Reserved. Returns **null**. Do not use. |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on permission scopes (the HTTP method used for each is in parentheses): 

- Create (POST)
- Read (GET)
- Update (PATCH): **scope** property only.
- Delete (DELETE)

No functions or actions may be called on permission scopes.
####Remarks
- In version 1.5 and newer, the **oauth2PermissionGrants** navigation property of the **User** entity and of the **ServicePrincipal** entity returns the **OAuth2PermissionGrant** objects associated with the user or service principal.
- Prior to version 1.5, the **permissions** navigation property of the **User** entity and of the **ServicePrincipal** entity returns the **Permission** objects associated with the user or service principal.

---

### ServicePrincipal Entity <a id="ServicePrincipalEntity"> </a>
Represents an instance of an application in a directory. Inherits from [DirectoryObject].
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| accountEnabled | Edm.Boolean | POST, GET ($filter), PATCH | **true** if the service principal account is enabled; otherwise, **false**. |
| appDisplayName | Edm.String | GET | The display name exposed by the associated application. |
| appId | Edm.Guid | POST (Required), GET ($filter), PATCH | The unique identifier for the associated application (its **appId** property). |
| appOwnerTenantId | Edm.Guid | GET |  |
| appRoleAssignmentRequired | Edm.Boolean | POST, GET, PATCH | Specifies whether an **AppRoleAssignment** to a user or group is required before Azure AD will issue a user or access token to the application.<br/><br/> **Notes**: Requires version 1.5 or newer, not nullable. |
| appRoles | Collection([AppRole]) | GET | The application roles exposed by the associated application. For more information see the **appRoles** property definition on the [Application] entity<br/><br/> **Notes**: Requires version 1.5 or newer, not nullable. |
| authenticationPolicy | [ServicePrincipalAuthenticationPolicy] | GET | Reserved for internal use only. Do not use. Removed in version 1.5.<br/><br/> **Notes**: Available in version 2013-11-08 only. |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for service principals and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| displayName | Edm.String | POST, GET ($filter), PATCH | The display name for the service principal. |
| errorUrl | Edm.String | POST, GET, PATCH |  |
| homepage | Edm.String | POST, GET, PATCH | The URL to the homepage of the associated application. |
| keyCredentials | Collection([KeyCredential]) | POST, GET, PATCH | The collection of key credentials associated with the service principal.<br/><br/> **Notes**: not nullable. |
| logoutUrl | Edm.String | POST, GET, PATCH |  |
| oauth2Permissions | Collection([OAuth2Permission]) | GET | The OAuth 2.0 permissions exposed by the associated application. For more information see the **oauth2Permissions** property definition on the [Application] entity.<br/><br/> **Notes**: Requires version 1.5 or newer, not nullable. |
| objectId | Edm.String | GET | The unique identifier for the service principal. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For service principals the value is always "ServicePrincipal". Inherited from [DirectoryObject]. |
| passwordCredentials | Collection([PasswordCredential]) | POST, GET, PATCH | The collection of password credentials associated with the service principal.<br/><br/> **Notes**: not nullable. |
| preferredTokenSigningKeyThumbprint | Edm.String | GET | Reserved for internal use only. Do not write or otherwise rely on this property. May be removed in future versions.<br/><br/> **Notes**: Requires version 1.5 or newer. |
| publisherName | Edm.String | POST, GET ($filter), PATCH | The display name of the tenant in which the associated application is specified. |
| replyUrls | Collection(Edm.String) | POST, GET, PATCH | The URLs that user tokens are sent to for sign in with the associated application, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to for the associated application.<br/><br/> **Notes**: not nullable. |
| samlMetadataUrl | Edm.String | POST, GET, PATCH |  |
| servicePrincipalNames | Collection(Edm.String) | POST, GET ($filter), PATCH | The URIs that identify the associated application. For more information see, [Application Objects and Service Principal Objects](https://msdn.microsoft.com/en-us/library/azure/dn132633.aspx).<br/><br/> **Notes**: not nullable, the **any** operator is required for filter expressions on multi-valued properties; for more information, see [Supported Queries, Filters, and Paging Options]. |
| tags | Collection(Edm.String) | POST, GET ($filter), PATCH | <br/><br/> **Notes**: not nullable. |

**Navigation Properties**   

| Name | To | Multiplicity<br/>(From/To) | Description |
|:-----|:---|:---------------------------|:------------|
| appRoleAssignedTo | [AppRoleAssignment] | \*/\* | Principals (users, groups, and service principals) that are assigned to this service principal. Requires version 1.5 or newer. |
| appRoleAssignments | [AppRoleAssignment] | \*/\* | Applications that the service principal is assigned to. Requires version 1.5 or newer. |
| createdObjects | [DirectoryObject] | \*/\* | Directory objects created by this service principal. Inherited from [DirectoryObject]. Requires version 2013-11-08 or newer. |
| memberOf | [DirectoryObject]<br/><br/> (Only [DirectoryRole] and [Group] objects are supported) | \*/\* | Roles and groups that this service principal is a direct member of. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET |
| oauth2PermissionGrants | [OAuth2PermissionGrant] | \*/\* | User impersonation grants associated with this service principal. Requires version 1.5 or newer. |
| ownedObjects | [DirectoryObject] | \*/\* | Directory objects that are owned by this service principal. Inherited from [DirectoryObject]. Requires version 2013-11-08 or newer. |
| owners | [DirectoryObject] | \*/\* | Directory objects that are owners of this service principal. The owners are a set of non-admin users who are allowed to modify this object. Inherited from [DirectoryObject]. Requires version 2013-11-08 or newer. |
| permissions | **Permission** | \*/\* | Renamed to **oauth2PermissionGrants** in version 1.5 and newer. In previous versions pointed to the permissions associated with the service principal. For information about the **Permission** entity type, see [OAuth2PermissionGrant]. |

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on service principals (the HTTP method used for each is in parentheses): 

- Create (POST)
- Read (GET)
- Update (PATCH)
- Delete (DELETE)

The following operation is supported on navigation properties:

- Read (GET)

The following actions and functions may be called on groups:

- [checkMemberGroups] to check a service principal’s membership in a list of groups. The check is transitive.
- [getMemberGroups] to return a list of the groups that a service principal is a member of. The check is transitive.
- [getMemberObjects] to return a list of the groups and directory roles that a service principal is a member of. The check is transitive.

A principal must be in the Company Administrator role to perform operations on service principals. 
####Remarks
You must set the **appId** property to the ID of an application in the directory when you create a service principal.

---

### SubscribedSku Entity <a id="SubscribedSkuEntity"> </a>
Only the read operation is supported on subscribed SKUs; create, update, and delete are not supported. Query filter expressions are not supported. Inherits from [DirectoryObject].
#### Properties
**Declared Properties**

| Property | Type | Supports | Description |
|:-----|:-----|:-----|
| capabilityStatus | Edm.String | GET |  |
| consumedUnits | Edm.Int32 | GET |  |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for subscribed SKUs and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer.  |
| objectId | Edm.String | GET | <br/><br/> **Notes**: **key**, not nullable  |
| prepaidUnits |  [LicenseUnitsDetail]  | GET |  |
| servicePlans | Collection([ServicePlanInfo]) | GET | <br/><br/> **Notes**: not nullable  |
| skuId | Edm.Guid | GET |  |
| skuPartNumber | Edm.String | GET |  |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on subscribed SKUs (the HTTP method used for each is in parentheses):

- Read (GET)

Subscribed SKUs do not expose any navigation properties. 

No functions or actions may be called on subscribed SKUs.

---

### TenantDetail Entity <a id="TenantDetailEntity"> </a>
Represents an Azure Active Directory tenant. Only the read and update operations are supported on tenants; create and delete are not supported. Inherits from [DirectoryOjbect].
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| assignedPlans | Collection([AssignedPlan]) | GET | The collection of service plans associated with the tenant.<br/><br/> **Notes**: not nullable. |
| city | Edm.String | GET |  |
| companyLastDirSyncTime | Edm.DateTime | GET | The time and date at which the tenant was last synced with the on-premise directory. |
| country | Edm.String | GET |  |
| countryLetterCode | Edm.String | GET |  |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for tenants and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| dirSyncEnabled | Edm.Boolean | GET | **true** if this object is synced from an on-premises directory; **false** if this object was originally synced from an on-premises directory but is no longer synced; **null** if this object has never been synced from an on-premises directory (default). |
| displayName | Edm.String | GET | The display name for the tenant. |
| marketingNotificationEmails | Collection(Edm.String) | GET, PATCH | <br/><br/> **Notes**: not nullable. |
| objectId | Edm.String | GET | The unique identifier for the tenant. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For tenants the value is always "Company". Inherited from [DirectoryObject]. |
| postalCode | Edm.String | GET |  |
| preferredLanguage | Edm.String | GET |  |
| provisionedPlans | Collection([ProvisionedPlan]) | GET | <br/><br/> **Notes**: not nullable. |
| provisioningErrors | Collection([ProvisioningError]) | GET | <br/><br/> **Notes**: not nullable. |
| state | Edm.String | GET |  |
| street | Edm.String | GET |  |
| technicalNotificationMails | Collection(Edm.String) | GET, PATCH | <br/><br/> **Notes**: not nullable. |
| telephoneNumber | Edm.String | GET |  |
| tenantType | Edm.String | GET | <br/><br/> **Notes**: removed in version 1.5 and newer. |
| verifiedDomains | Collection([VerifiedDomain]) | GET | The collection of domains associated with this tenant.<br/><br/> **Notes**: not nullable. |

**Navigation Properties**   
None.

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on tenants (the HTTP method used for each is in parentheses): 

- Read (GET)
- Update (PATCH); only the **marketingNotificationMails** and **technicalNotificationMails** properties can be updated using the Graph API.

Tenants do not expose any navigation properties. 

No functions or actions may be called on tenants.
####Remarks

- You cannot create or delete tenants using the Graph API.
- Only the **marketingNotificationMails** and **technicalNotificationMails** properties can be updated using the Graph API.
- Query filter expressions are not supported on tenants.

---

### User Entity <a id="UserEntity"> </a>
Represents an Azure AD user account. Inherits from [DirectoryObject].
#### Properties
**Declared Properties**

| Name | Type | Supports | Description |
|:-----|:-----|:---------|:------------|
| accountEnabled | Edm.Boolean | POST (Required), GET ($filter), PATCH | **true** if the account is enabled; otherwise, **false**. This property is required when a user is created. |
| assignedLicenses | Collection([AssignedLicense]) | POST, GET, PATCH | The licenses that are assigned to the user.<br/><br/> **Notes**: not nullable. |
| assignedPlans | Collection([AssignedPlan]) | GET | The plans that are assigned to the user.<br/><br/> **Notes**: not nullable. |
| city | Edm.String | POST, GET ($filter), PATCH | The city in which the user is located. |
| country | Edm.String | POST, GET ($filter), PATCH | The country/region in which the user is located; for example, "US" or "UK". |
| creationType | Edm.String | POST (Required for local accounts), GET ($filter) | Indicates whether the user account is a local account for an Azure Active Directory B2C tenant. Possible values are "LocalAccount" and **null**. When creating a local account, the property is required and you must set it to "LocalAccount". When creating a work or school account, do not specify the property or set it to **null**. For more information about Azure Active Directory B2C, see the [Azure Active Directory B2C documentation](https://azure.microsoft.com/documentation/services/active-directory-b2c/). <br/><br/>**Notes**: Requires version 1.6 or newer. In beta, specify  value as "NameCoexistence" rather than "LocalAccount". |
| deletionTimestamp | Edm.DateTime | GET | This property is not valid for users and always returns **null**. Inherited from [DirectoryObject].<br/><br/> **Notes**: Requires version 1.5 or newer. |
| department | Edm.String | POST, GET ($filter), PATCH | The name for the department in which the user works. |
| dirSyncEnabled | Edm.Boolean | GET ($filter) | **true** if this object is synced from an on-premises directory; **false** if this object was originally synced from an on-premises directory but is no longer synced; **null** if this object has never been synced from an on-premises directory (default). |
| displayName | Edm.String | POST (Required), GET ($filter), PATCH (but cannot be cleared) | The name displayed in the address book for the user. This is usually the combination of the user's first name, middle initial and last name. This property is required when a user is created and it cannot be cleared during updates. |
| facsimileTelephoneNumber | Edm.String | POST, GET, PATCH | The telephone number of the user's business fax machine. |
| givenName | Edm.String | POST, GET ($filter), PATCH | The given name (first name) of the user. |
| immutableId | Edm.String | POST (Required if using a federated domain for the UPN), GET ($filter), PATCH | This property is used to associate an on-premises Active Directory user account to their Azure AD user object. This property must be specified when creating a new user account in the Graph if you are using a federated domain for the user's **userPrincipalName** (UPN) property.<br/><br/> **Important:** The **$** and **_** characters cannot be used when specifying this property. <br/><br/> **Notes**: Requires version 2013-11-08 or newer. |
| jobTitle | Edm.String | POST, GET ($filter), PATCH | The user's job title. |
| lastDirSyncTime | Edm.DateTime | GET ($filter) | Indicates the last time at which the object was synced with the on-premises directory; for example: "2013-02-16T03:04:54Z" |
| mail | Edm.String | POST, GET ($filter) | The SMTP address for the user, for example, "jeff@contoso.onmicrosoft.com". |
| mailNickname | Edm.String | POST (Required for work or school accounts), GET ($filter), PATCH | The mail alias for the user. This property is required  when you create a work or school account; it is optional for a local account. |
| mobile | Edm.String | POST, GET, PATCH | The primary cellular telephone number for the user. |
| objectId | Edm.Guid | GET | The unique identifier for the user. Inherited from [DirectoryObject].<br/><br/> **Notes**: **key**, immutable, not nullable, unique. |
| objectType | Edm.String | GET | A string that identifies the object type. For users the value is always "User". Inherited from [DirectoryObject]. |
| onPremisesSecurityIdentifier | Edm.String | GET | Contains the on-premises security identifier (SID) for the user that was synchronized from on-premises to the cloud.<br/><br/> **Notes**: Requires version 1.5 or newer. |
| otherMails | Collection(Edm.String) | POST, GET ($filter), PATCH | A list of additional email addresses for the user; for example: ["bob@contoso.com", "Robert@fabrikam.com"].<br/><br/> **Notes**: not nullable, the **any** operator is required for filter expressions on multi-valued properties; for more information, see [Supported Queries, Filters, and Paging Options]. |
| passwordPolicies | Edm.String | POST, GET, PATCH | Specifies password policies for the user. This value is an enumeration with one possible value being "DisableStrongPassword", which allows weaker passwords than the default policy to be specified. "DisablePasswordExpiration" can also be specified. The two may be specified together; for example: "DisablePasswordExpiration, DisableStrongPassword". |
| passwordProfile | [PasswordProfile] | POST (Required), GET, PATCH | Specifies the password profile for the user. The profile contains the user's password. This property is required when a user is created.<br/><br/> The password in the profile must satisfy minimum requirements as specified by the **passwordPolicies** property. By default, a strong password is required. For information about the constraints that must be satisfied for a strong password, see **Password policy** under [Change your password](http://onlinehelp.microsoft.com/office365-enterprises/ff637578.aspx) in the Microsoft Office 365 help pages. |
| physicalDeliveryOfficeName | Edm.String | POST, GET, PATCH | The office location in the user's place of business. |
| postalCode | Edm.String | POST, GET, PATCH | The postal code for the user's postal address. The postal code is specific to the user's country/region. In the United States of America, this attribute contains the ZIP code. |
| preferredLanguage | Edm.String | POST, GET, PATCH | The preferred language for the user. Should follow ISO 639-1 Code; for example "en-US". |
| provisionedPlans | Collection([ProvisionedPlan]) | GET | The plans that are provisioned for the user.<br/><br/> **Notes**: not nullable. |
| provisioningErrors | Collection([ProvisioningError]) | GET | A collection of error details that are preventing this user from being provisioned successfully. |
| proxyAddresses | Collection(Edm.String) | GET ($filter) | Fpr example: ["SMTP: bob@contoso.com", "smtp: bob@sales.contoso.com"]<br/><br/> **Notes**: unique, not nullable, the **any** operator is required for filter expressions on multi-valued properties; for more information, see [Supported Queries, Filters, and Paging Options]. |
| signInNames | Collection([SignInName]) | POST (Required for local accounts), GET ($filter) | Specifies the collection of sign-in names for a local account in an Azure Active Directory B2C tenant. Each sign-in name must be unique across the company/tenant. The property must be specified when you create a local account user; do not specify it when you create a work or school account. For more information about Azure Active Directory B2C, see the [Azure Active Directory B2C documentation](https://azure.microsoft.com/documentation/services/active-directory-b2c/). <br/><br/> **Notes**: Requires version 1.6 or newer. Renamed from **alternativeSignInNameInfo** in beta. |
| sipProxyAddress | Edm.String | GET | Specifies the voice over IP (VOIP) session initiation protocol (SIP) address for the user.<br/><br/> **Notes**: Requires version 1.5 or newer. |
| state | Edm.String | POST, GET ($filter), PATCH | The state or province in the user's address. |
| streetAddress | Edm.String | POST, GET, PATCH | The street address of the user's place of business. |
| surname | Edm.String | POST, GET ($filter), PATCH | The user's surname (family name or last name).<br/><br/> **Notes**: filterable. |
| telephoneNumber | Edm.String | POST, GET, PATCH | The primary telephone number of the user's place of business. |
| thumbnailPhoto | Edm.Stream | POST, GET, PATCH | A thumbnail photo to be displayed for the user.<br/><br/> **Notes**: not nullable. |
| usageLocation | Edm.String | POST, GET ($filter), PATCH | A two letter country code (ISO standard 3166). Required for users that will be assigned licenses due to legal requirement to check for availability of services in countries. Examples include: "US", "JP", and "GB".<br/><br/> **Notes**: not nullable. |
| userPrincipalName | Edm.String | POST (Reqiired for work or school acounts), GET ($filter), PATCH | The user principal name (UPN) of the user. The UPN is an Internet-style login name for the user based on the Internet standard RFC 822. By convention, this should map to the user's email name. The general format is "alias@domain". For work or school accounts, the domain must be present in the tenant's collection of verified domains. This property is required when a work or school account is created; it is optional for local accounts. <br/><br/> The verified domains for the tenant can be accessed from the **VerifiedDomains** property of [TenantDetail]. <br/><br/> **Notes**: **key**, unique. |
| userType | Edm.String | POST, GET ($filter), PATCH | A string value that can be used to classify user types in your directory, such as "Member" and "Guest".<br/><br/> **Notes**: Requires version 2013-11-08 or newer. |

**Navigation Properties**   

| Name | To | Multiplicity<br/>(From/To) | Description |
|:-----|:---|:---------------------------|:------------|
| manager | [DirectoryObject]<br/><br/> (Only User and [Contact] objects are supported.) | \*/0..1 | The user or contact that is this user's manager. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET, PUT, DELETE |
| directReports | [DirectoryObject]<br/><br/> (Only User and [Contact] objects are supported.) | \*/\* | The users and contacts that report to the user. (The users and contacts that have their manager property set to this user.) Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET |
| memberOf | [DirectoryObject]<br/><br/> (Only [Group] and [DirectoryRole] objects are supported.) | \*/\* | The groups and directory roles that the user is a member of. Inherited from [DirectoryObject].<br/><br/> HTTP Methods: GET |
| ownedDevices | [Device] | \*/\* | Devices that are owned by the user. |
| permissions | **Permission** | \*/\* | The permissions associated with the user. The property is renamed to **oauth2PermissionGrants** and the **Permission** entity is renamed to [OAuth2PermissionGrant] in version 1.5 and newer. See the documentation for **OAuth2PermssionGrant** for documentation of the **Permission** entity type.<br/><br/> |
| registeredDevices | [Device] | \*/\* | Devices that are registered for the user. |
| createdObjects | [DirectoryObject] | \*/\* | Directory objects that were created by the user. Requires version 2013-11-08 or newer. |
| ownedObjects | [DirectoryObject] | \*/\* | Directory objects that are owned by the user. Requires version 2013-11-08 or newer. |
| appRoleAssignments | [AppRoleAssignment] | \*/\* | The set of applications that this user is assigned to. Requires version 1.5 or newer.<br/><br/> HTTP Methods: GET, POST, DELETE |
| oauth2PermissionGrants | [OAuth2PermissionGrant] | \*/\* | The set of applications that are granted consent to impersonate this user. Requires version 1.5 or newer.<br/><br/> HTTP Methods: GET, POST, DELETE |

**Note:** Inherited navigation properties that are not listed are not supported. Requests addressed to unsupported navigation properties return **400 Bad Request**. 

#### Supported Operations
The following operations are supported on users (the HTTP method used for each is in parentheses): 

- Create (POST)
- Read (GET)
- Update (PATCH)
- Delete (DELETE)

The following operations are supported on user navigation properties; not all operations are supported on every navigation property.

- Read (GET)
- Update (PUT)
- Delete (DELETE)

The following actions and functions may be called on users:

- [assignLicense] to assign and/or remove a specified list of licenses from a user. Requires version 2013-11-08 or newer.
- [checkMemberGroups] to check the user’s membership in a list of groups. The check is transitive.
- [getAvailableExtensionProperties] to return a list of the extension properties that have been registered for a user. Requires version 1.5 or newer.
- [getMemberGroups] to return a list of the groups that a user is a member of. The check is transitive.
- [getMemberObjects] to return a list of the groups and directory roles that a user is a member of. The check is transitive.
- [isMemberOf] to check whether a user is a member of a specified group. The check is transitive.

####Remarks

- To create a work or school account, the required properties are: **accountEnabled**, **displayName**, **mailNickname**, **passwordProfile**, and **userPrincipalName**. The password specified in the **passwordProfile** property must meet the tenant’s password complexity requirements. For more information, see the **passwordPolicies** property.
- To create a local account, the required properties are: **accountEnabled**, **creationType** (must be set to “LocalAccount”), **displayName**, **passwordProfile**, and **signInNames**. The password specified in the **passwordProfile** property must meet the tenant’s password complexity requirements. For more information, see the **passwordPolicies** property.
- In version 2013-11-08 and newer, the **immutableId** property must be specified when creating a new user account in the Graph if you are using a federated domain for the user’s **userPrincipalName** (UPN) property.
- The **displayName** property cannot be cleared on updates.
- The **passwordProfile** property always returns **null**. This is to prevent the user’s password from being displayed. You can reset the user’s password by updating the **passwordProfile** property.
- In addition to the standard addressing available for all directory entities, users may be addressed by using the **userPrincipalName** property; for example, `https://graph.windows.net/contoso.onmicrosoft.com/users/john@contoso.onmicrosoft.com?api-version=1.5`.

---

## Complex type reference

### AlternativeSecurityId Type <a id="AlternativeSecurityIdType"> </a>
Contains an alternative security ID associated with a device. The **alternativeSecurityIds** property of the [Device] entity is a collection of **AlternativeSecurityId**.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| identityProvider | Edm.String |  |  |
| key | Edm.Binary |  |  |
| type | Edm.Int32 |  |  |

---

### AppRole Type <a id="AppRoleType"> </a>
Represents an application role that may be requested by a client application calling another application or that may be used to assign an application to users or groups in a specified application role. The **appRoles** property of the [ServicePrincipal] entity and of the [Application] entity is a collection of **AppRole**.

**Important**: Requires version 1.5 or newer.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:------|:------|:------------|:-------------|
| allowedMemberTypes | Collection(Edm.String) | RW | Specifies whether this app role definition can be assigned to users and groups by setting to "User", or to other applications (that are accessing this application in daemon service scenarios) by setting to "Application", or to both. <br/><br/>**Notes**: not nullable. |
| description | Edm.String | RW | Permission help text that appears in the admin app assignment and consent experiences. |
| displayName | Edm.String | RW | Display name for the permission that appears in the admin consent and app assignment experiences. |
| id | Edm.Guid | RW | Unique role identifier inside the **appRoles** collection. |
| isEnabled | Edm.Boolean | RW | When creating or updating a role definition, this must be set to **true** (which is the default). To delete a role, this must first be set to **false**. At that point, in a subsequent call, this role may be removed. |
| value | Edm.String | RW | Specifies the value of the roles claim that the application should expect in the authentication and access tokens. |

---

### AssignedLicense Type <a id="AssignedLicenseType"> </a>
Represents a license assigned to a user. The **assignedLicenses** property of the [User] entity is a collection of **AssignedLicense**.
####Properties

|  Name |  Type | Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| disabledPlans | Collection(Edm.Guid) | R | A collection of the unique identifiers for plans that have been disabled.  <br/><br/>**Notes**: not nullable. |
| skuId | Edm.Guid | R | The unique identifier for the SKU. |

---

### AssignedPlan Type <a id="AssignedPlanType"> </a>
The **assignedPlans** property of both the [User] entity and the [TenantDetail] entity is a collection of **AssignedPlan**.
####Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| assignedTimestamp | Edm.DateTime | R | The date and time at which the plan was assigned; for example: 2013-01-02T19:32:30Z. |
| capabilityStatus | Edm.String | R | For example, "Enabled". |
| service | Edm.String | R | The name of the service; for example, "AccessControlServiceS2S". |
| servicePlanId | Edm.Guid | R | A GUID that identifies the service plan. |

---

### KeyCredential Type <a id="KeyCredentialType"> </a>
Contains a key credential associated with an application or a service principal. The **keyCredentials** property of the [Application] and [ServicePrincipal] entities is a collection of **KeyCredential**.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| customKeyIdentifier | Edm.Binary |  |  |
| endDate | Edm.DateTime |  | The date and time at which the credential expires. |
| keyId | Edm.Guid |  | The unique identifier (GUID) for the key. |
| startDate | Edm.DateTime |  | The date and time at which the credential becomes valid. |
| type | Edm.String |  | The type of key credential; for example, "Symmetric". |
| usage | Edm.String |  | A string that describes the purpose for which the key can be used; for example, "Verify". |
| value | Edm.String |  |  |

---

### LicenseUnitsDetail Type <a id="LicenseUnitsDetailType"> </a>
The **prepaidUnits** property of the [SubscribedSku] entity is of type **LicenseUnitsDetail**.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| enabled | Edm.Int32 |  |  |
| suspended | Edm.Int32 |  |  |
| warning | Edm.Int32 |  |  |

---

### OAuth2Permission Type <a id="OAuth2PermissionType"> </a>
Represents an OAuth 2.0 delegated permission scope. The specified OAuth 2.0 delegated permission scopes may be requested by client applications (through the **requiredResourceAccess** collection on the [Application] object) when calling a resource application. The **oauth2Permissions** property of the [ServicePrincipal] entity and of the [Application] entity is a collection of **OAuth2Permission**.

**Important**: Requires version 1.5 or newer.
#### Properties
|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| adminConsentDescription | Edm.String | RW | Permission help text that appears in the admin consent and app assignment experiences. |
| adminConsentDisplayName | Edm.String | RW | Display name for the permission that appears in the admin consent and app assignment experiences. |
| id | Edm. Guid | RW | Unique scope permission identifier inside the oauth2Permissions collection. |
| isEnabled | Edm.Boolean | RW | When creating or updating a permission, this property must be set to **true** (which is the default). To delete a permission, this property must first be set to **false**. At that point, in a subsequent call, the permission may be removed. <br/><br/>**Notes**: not nullable. |
| type | Edm.String | RW | Specifies whether this scope permission can be consented to by an end user, or whether it is a tenant-wide permission that must be consented to by a Company Administrator. Possible values are "User" or "Admin". |
| userConsentDescription | Edm.String | RW | Permission help text that appears in the end user consent experience. |
| userConsentDisplayName | Edm.String | RW | Display name for the permission that appears in the end user consent experience. |
| value | Edm.String | RW | The value of the scope claim that the resource application should expect in the OAuth 2.0 access token. |

---

### PasswordCredential Type <a id="PasswordCredentialType"> </a>
Contains a password credential associated with an application or a service principal. The **passwordCredentials** property of the [ServicePrincipal] entity and of the [Application] entity is a collection of **PasswordCredential**.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| customKeyIdentifier | Edm.Binary |  |  |
| endDate | Edm.DateTime |  | The date and time at which the password expires. |
| keyId | Edm.Guid |  |  |
| startDate | Edm.DateTime |  | The date and time at which the password becomes valid. |
| value | Edm.String |  |  |

---

### PasswordProfile Type <a id="PasswordProfileType"> </a>
Contains the password profile associated with a user. The **passwordProfile** property of the [User] entity is a **PasswordProfile** object.
####Properties

|  Name |  Type |  Notes |  Description |
|:-------|:-------|:-------|:-------|
| password | Edm.String | RW | The password for the user. This property is required when a user is created. It can be updated, but the user will be required to change the password on the next login. <br/><br/> The password must satisfy minimum requirements as specified by the user's **PasswordPolicies** property. By default, a strong password is required. |
| forceChangePasswordNextLogin | Edm.Boolean | RW | **true** if the user must change her password on the next login; otherwise **false**.  |

---

### ProvisionedPlan Type <a id="ProvisionedPlanType"> </a>
The **provisionedPlans** property of the [User] entity and the [TenantDetail] entity is a collection of **ProvisionedPlan**.
#### Properties
|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| capabilityStatus | Edm.String | R | For example, "Enabled". |
| provisioningStatus | Edm.String | R | For example, "Success". |
| service | Edm.String | R | The name of the service; for example, "AccessControlS2S" |

---

### ProvisioningError Type <a id="ProvisioningErrorType"> </a>
The **provisioningErrors** property of the [Contact], [User], and [Group] entities is a collection of **ProvisioningError**.
#### Properties

|  Name |  Type |    Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| errorDetail | Edm.String | R | A description of the error. |
| resolved | Edm.Boolean | R | **true** if the error was resolved; otherwise, **false**.  |
| serviceInstance | Edm.String | R | The service instance for which the error occurred.  |
| timestamp | Edm.DateTime | R | The date and time at which the error occurred. |

---

### RequiredResourceAccess Type <a id="RequiredResourceAccessType"> </a>
Specifies the set of OAuth 2.0 permission scopes and app roles under the specified resource that an application requires access to. The specified OAuth 2.0 permission scopes may be requested by client applications (through the **requiredResourceAccess** collection) when calling a resource application. The **requiredResourceAccess** property of the [Application] entity is a collection of **ReqiredResourceAccess**.

**Important**: Requires version 1.5 or newer.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| resourceAppId | Edm.String | RW | The unique identifier for the resource that the application requires access to. This should be equal to the **appId** declared on the target resource application. |
| resourceAccess | Collection([ResourceAccess]) | RW | The list of OAuth2.0 permission scopes and app roles that the application requires from the specified resource. <br/><br/>**Notes**: not nullable.  |

---

### ResourceAccess Type <a id="ResourceAccessType"> </a>
Specifies an OAuth 2.0 permission scope or an app role that an application requires. The **resourceAccess** property of the [RequiredResourceAccess] type is a collection of **ResourceAccess**.

**Important**: Requires version 1.5 or newer.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| id | Edm.Guid | RW | The unique identifier for one of the [OAuth2Permission] or [AppRole] instances that the resource application exposes.  <br/><br/>**Notes**: not nullable. |
| type | Edm.String  | RW | Specifies whether the **id** property references an [OAuth2Permission] or an [AppRole]. Possible values are "scope" or "role". |

---

### ServicePlanInfo Type <a id="ServicePlanInfoType"> </a>
Contains information about a service plan associated with a subscribed SKU. The **servicePlans** property of the [SubscribedSku] entity is a collection of **ServicePlanInfo**.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| servicePlanId | Edm.Guid |  | The unique identifier of the service plan. |
| servicePlanName | Edm.String |  | The name of the service plan. |

---

### ServicePrincipalAuthenticationPolicy Type <a id="ServicePrincipalAuthenticationPolicyType"> </a>
Contains the authentication policy of a service principal.

**Important**: Available only in version 2013-11-08; however it is reserved for internal use only and is removed in version 1.5 and newer.
#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| defaultPolicy | Edm.String | RW | Reserved for internal use only. Do not use. Removed in version 1.5. |
| allowedPolicies | Collection(Edm.String) | RW | Reserved for internal use only. Do not use. Removed in version 1.5.  <br/><br/>**Notes**: not nullable. |

---

### SignInName Type <a id="SignInNameType"> </a>
Contains information about a sign-in name of a local account user in an Azure Active Directory B2C tenant. The **signInNames** property of the [User] entity is a collection of **SignInName**. For more information about Azure Active Directory B2C, see the [Azure Active Directory B2C documentation](https://azure.microsoft.com/documentation/services/active-directory-b2c/).

**Important**: Requires version 1.6 or newer. Renamed from **LogonIdentifier** in beta.

#### Properties

|  Name |  Type |  Read/Write |  Description |
|:-------|:-------|:-------|:-------|
| type | Edm.String | RW | A string value that can be used to classify user sign-in types in your directory, such as "emailAddress" or "userName".|
| value | Edm.String | RW | The sign-in used by the local account. Must be unique across the company/tenant. For example, "johnc@example.com". |

---

### VerifiedDomain Type <a id="VerifiedDomainType"> </a>
Specifies a domain for a tenant. The **verifiedDomains** property of the [TenantDetail] entity is a collection of **VerifiedDomain**.
####Properties

|  Name |  Type |  Read/Write |  Description |
|:------|:------|:------------|:-------------|
| capabilities | Edm.String | R | For example, "Email", "OfficeCommunicationsOnline". |
| default | Edm.Boolean | R | **true** if this is the default domain associated with the tenant; otherwise, **false**.  |
| id | Edm.String | R | For example, "00057FFE80187238". |
| initial | Edm.Boolean | R |  |
| name | Edm.String | R | The domain name; for example, "contoso.onmicrosoft.com" |
| type | Edm.String | R | For example, "Managed". |

##Additional Resources

- Learn more about Graph API supported features, capabilities, and preview features in [Graph API concepts](../howto/azure-ad-graph-api-operations-overview.md)


[Application]: #ApplicationEntity
[AppRoleAssignment]: #AppRoleAssignmentEntity
[Contact]: #ContactEntity
[Contract]: #ContractEntity
[Device]: #DeviceEntity
[DirectoryLinkChange]: #DirectoryLinkChangeEntity
[DirectoryObject]: #DirectoryObjectEntity
[DirectoryRole]: #DirectoryRoleEntity
[DirectoryRoleTemplate]: #DirectoryRoleTemplateEntity
[Domain]: #DomainEntity
[DomainDnsRecord]: #DomainDnsRecordEntity
[DomainDnsCnameRecord]: #DomainDnsCnameRecordEntity
[DomainDnsMxRecord]: #DomainDnsMxRecordEntity
[DomainDnsSrvRecord]: #DomainDnsSrvRecordEntity
[DomainDnsTxtRecord]: #DomainDnsTxtRecordEntity
[DomainDnsUnavailableRecord]: #DomainDnsUnavailableRecordEntity
[ExtensionProperty]: #ExtensionPropertyEntity
[Group]: #GroupEntity
[OAuth2PermissionGrant]: #OAuth2PermissionGrantEntity
[ServicePrincipal]: #ServicePrincipalEntity
[SubscribedSku]: #SubscribedSkuEntity
[TenantDetail]: #TenantDetailEntity
[User]: #UserEntity

[AlternativeSecurityId]: #AlternativeSecurityIdType
[AppRole]: #AppRoleType
[AssignedLicense]: #AssignedLicenseType
[AssignedPlan]: #AssignedPlanType
[KeyCredential]: #KeyCredentialType
[LicenseUnitsDetail]: #LicenseUnitsDetailType
[OAuth2Permission]: #OAuth2PermissionType
[PasswordCredential]: #PasswordCredentialType
[PasswordProfile]: #PasswordProfileType
[ProvisionedPlan]: #ProvisionedPlanType
[ProvisioningError]: #ProvisioningErrorType
[RequiredResourceAccess]: #RequiredResourceAccessType
[ResourceAccess]: #ResourceAccessType
[ServicePlanInfo]: #ServicePlanInfoType
[ServicePrincipalAuthenticationPolicy]: #ServicePrincipalAuthenticationPolicyType
[SignInName]: #SignInNameType
[VerifiedDomain]: #VerifiedDomainType

[assignLicense]: ./functions-and-actions.md#assignLicense
[checkMemberGroups]: ./functions-and-actions.md#checkMemberGroups
[getAvailableExtensionProperties]: ./functions-and-actions.md#getAvailableExtensionProperties
[getMemberGroups]: ./functions-and-actions.md#getMemberGroups
[getMemberObjects]: ./functions-and-actions.md#getMemberObjects
[getObjectsByObjectIds]: ./functions-and-actions.md#getObjectsByObjectIds
[isMemberOf]: ./functions-and-actions.md#isMemberOf
[restore]: ./functions-and-actions.md#restore
[verify]: ./functions-and-actions.md#verify
    
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
