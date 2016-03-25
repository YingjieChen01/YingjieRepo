---
title: Azure AD Graph API Versioning
author: JimacoMS
ms.TocTitle: Versioning
ms.ContentId: 52fec4d4-c4fa-461d-bc6e-620ca5aed1db
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Versioning | Graph API concepts

This topic summarizes the version differences for Azure Active Directory (AD) Graph API entities and operations. You must specify the version of an operation that you want to use by including the `api-version` query string parameter in your request. Requests without an `api-version` parameter will be rejected and return a **(400) Bad Request** response. If your service calls an older version of an operation, you can choose to continue calling the older version, or modify your code to call a newer version. Any differences in functionality between versions are outlined in the documentation for the entity upon which you are performing the call.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

Beginning with Azure AD Graph API version 1.5, the `api-version` parameter value for General Availability (GA) versions is specified as a numeric value. The following URL shows how to query the top-level resources for tenant domain contoso.com using Graph API version 1.5: `https://graph.windows.net/contoso.com?api-version=1.5`. For previous versions of Graph API, the `api-version` parameter value is specified as a date string in the following format: YYYY-MM-DD. The following URL shows how to query the top-level resources of the same tenant using the 2013-11-08 version of the Graph API: `https://graph.windows.net/contoso.com?api-version=2013-11-08`. For preview features, the `api-version` parameter value is specified using the string “beta” as follows: `https://graph.windows.net/contoso.com?api-version=beta`.

## API contract, versioning and breaking changes

We will increment the API version number for any breaking changes to the API, in order to protect client applications. We may choose to increment the API version for non-breaking changes too (for example, if we add some significantly large new capabilities).

So, what constitutes a breaking change?

- Removing or renaming APIs or API parameters
- Changes in behavior for an existing API
- Changes in Error Codes & Fault Contracts
- Anything that would violate the Principle of Least Astonishment

**Note**:The addition of new JSON fields to responses does not constitute a breaking change.  For developers who generate their own client proxies (like WCF clients) our guidance is your client applications should be prepared to receive properties and derived types not previously defined by the Graph API service.  Although Graph API is not yet OData V4 compliant at the time of this writing, it still follows the guidance described in the [Model Versioning section in the OData V4 spec](http://docs.oasis-open.org/odata/odata/v4.0/errata02/os/complete/part1-protocol/odata-v4.0-errata02-os-part1-protocol-complete.html#_Toc406398209).

When we increment the major version of the API (for example from 1.5 to 2.0), we are signaling that all support for existing clients using previous 1.x or earlier versions will be deprecated and no longer supported after 12 months.  Please see the [Microsoft Online Services Support Lifecycle Policy](https://support.microsoft.com/en-us/gp/lifecycle#gp/osslpolicy) for more details.

## Supported versions

The following versions have been released for the Graph API.

- [Version beta](#beta)
- [Version 1.6](#1dot6)
- [Version 1.5](#1dot5)
- [Version 2013-11-08](#2013-11-08)
- [Version 2013-04-05](#2013-04-05)

## Version beta <a id="beta"></a>

The Graph API features currently in preview can be found in either the [Preview Features](./azure-ad-administrative-units-preview.md) section in Graph API concepts, or on the [Graph Team Blog](http://blogs.msdn.com/b/aadgraphteam/archive/2015/03/15/full-text-search-capabilities-in-azure-ad-graph-api-preview.aspx). Beta features require the “api-version=beta” query string parameter.  When the Graph API team believes that a preview feature is ready for GA, we will add that feature to the latest GA version (or if it constitutes a breaking change this would result in an incremented new version number).  We make no guarantees that a preview feature will be promoted to GA.

For the beta version, we will try to avoid any breaking changes as much as possible, but we will not guarantee it.  Client applications using the beta version should expect breaking changes from time to time.  Please see [Supplemental Terms of Use for Microsoft Azure Previews](http://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/).

## Version 1.6 <a id="1dot6"></a>

This section lists the changes for Graph API version 1.6.

Graph API version 1.6 introduces the following feature changes:

- Added support for Azure Active Directory B2C local account users. This involves new properties on the [User] entity and a new complex type [SignInName] to support local account sign-in to Azure Active Directory B2C tenants. For more information about Azure Active Directory B2C, see the [Azure Active Directory B2C documentation](https://azure.microsoft.com/documentation/services/active-directory-b2c/).

- At release, the client-facing interface (entities, complex types, functions, and actions) has not changed; however, changes will occur as features are added or updated.

- Graph Client versions 2.1.x require Graph API version 1.6; Graph Client versions 2.0.x require Graph API 1.5.

 
### Entity changes

|Entity|Change Description|
|---|---|
| [User] | Added the **creationType** property, which is used to indicate that the user is a local account. <br/><br/> Added the **signInNames** property, which contains the collection of sign-in names used by a local account user to sign in to an Azure Active Directory B2C tenant. This property is renamed from **alternativeSignInNamesInfo** in beta.| 

### Complex type changes

|Type|Change Description|
|---|---|
| [SignInName] | New type to hold information about a sign-in name that can be used by a local account user to sign in to an Azure Active Directory B2C tenant. This type is renamed from **LogonIdentifier** in beta. |

## Version 1.5 <a id="1dot5"></a>

This section lists the changes for Graph API version 1.5.

Graph API version 1.5 introduces the following feature changes:

- The schema namespace of Graph API has changed from **Microsoft.WindowsAzure.ActiveDirectory** to **Microsoft.DirectoryServices**. This affects all entities and complex types exposed by Graph API.

- Support for directory schema extensions has been added. This allows you to add properties that are required by your application to directory objects. The following entities support schema extensions: [User], [Group], [TenantDetail], [Device], [Application], and [ServicePrincipal]. To support directory schema extensions: the [ExtensionProperty] entity has been added, the **extensionProperties** navigation property has been added to the [Application] entity, and a new function, [getAvailableExtensionProperties], has been added to return the registered extension properties of supported directory objects. For more information about extending the directory schema, see [Directory schema extensions](./azure-ad-graph-api-directory-schema-extensions.md).

- The way in which permissions are represented has changed and is more tightly aligned with OAuth 2.0 concepts as well as with the way permissions are represented in other Azure components. The **Permission** entity has been removed and has been replaced with the [OAuth2PermissionGrant] entity. This entity represents delegated OAuth 2.0 permissions scopes that arrive in an OAuth 2.0 access token scope claim. Additionally, the new [AppRoleAssignment] entity represents application roles that can be assigned to users, groups and service principals. Two related complex types have also been added: [AppRole] and [OAuth2Permission]. This change has precipitated renaming some properties and adding others in the following entities: [Application], [Group], [ServicePrincipal], and [User].

- The **Role** entity is renamed to [DirectoryRole].

- The **RoleTemplate** entity is renamed to [DirectoryRoleTemplate].

The following tables list the entities, complex types, and functions that have been added, changed, or removed for this release.

### Entity changes

|Entity|Change Description|
|---|---|
|[Application]|Updated the **appId** property from Edm.Guid to Edm.String.<br/><br/>Added the **appRoles** property, which contains the collection of application roles that an application may declare.  These roles can be assigned to users, groups or service principals.<br/><br/>Added the **groupMembershipClaims** property, which is a bitmask that configures the "groups" claim issued in a user or OAuth 2.0 access token that your application expects.  The bitmask values are: 0: None, 1: Security groups and Azure AD roles, 2: Reserved, and 4: Reserved. Setting the bitmask to 7 will get all of the security groups, distribution groups, and Azure AD roles that the signed-in user is a member of.<br/><br/>Added the **knownClientApplications** property, which contains a list of client applications that are tied to this resource application.  Consent to any of the known client applications will result in implicit consent to the resource application through a combined consent dialog (showing the OAuth permission scopes required by the client and the resource).<br/><br/>Added the **oauth2AllowImplicitFlow** property, which specifies whether this web application can request OAuth2.0 implicit flow tokens. The default is false.<br/><br/>Added the **oauth2AllowUrlPathMatching** property, which specifies whether, as part of OAuth 2.0 token requests, Azure AD will allow path matching of the redirect URI against the application's replyUrls.  The default is **false**.<br/><br/>Added the **oauth2Permissions** property, which contains the collection of OAuth 2.0 permission scopes that the web API (resource) application exposes to client applications.  These permission scopes may be granted to client applications during consent.<br/><br/>Added the **oauth2RequiredPostResponse** property, which specifies whether, as part of OAuth 2.0 token requests, Azure AD will allow POST requests, as opposed to GET requests.  Default is **false**, which specifies that only GET requests will be allowed.<br/><br/>Added the **requiredResourceAccess** property, which specifies resources that this application requires access to and the set of OAuth permission scopes and application roles that it needs under each of those resources.  This pre-configuration of required resource access drives the end-user consent experience.<br/><br/>Added the **extensionProperties** navigation property, which contains the extension properties associated with the application.|
|[AppRoleAssignment]|New entity that is used to record when a user or group is assigned to an application.  In this case it will result in an application tile showing up on the user's app access panel. This entity may also be used to grant another application (modeled as a service principal) access to a resource application in a particular role.|
|[Contact]|Added the **sipProxyAddress** property, which specifies the voice over IP (VOIP) session initiation protocol (SIP) address for the contact.|
|[DirectoryObject]|Added the **deletionTimestamp** property, which indicates the time at which a directory object was deleted. It only applies to those directory objects which can be restored. Currently this is only supported for [Application].|
|[DirectoryRole]|Renamed from **Role**. <br/><br/>Added the **roleTemplateId** property|
|[DirectoryRoleTemplate]|Renamed from **RoleTemplate**.|
|[ExtensionProperty]|New entity that allows an application to define and use a set of additional properties that can be added to directory objects (users, groups, tenant details, devices, applications, and service principals) without the application requiring an external data store.|
|[Group]|Added the **onPremisesSecurityIdentifier** property, which contains the on-premises security identifier (SID) for the group that was synchronized from on-premises to the cloud.<br/><br/>Added the **appRoleAssignments** navigation property, which points to the set of applications (service principals) that this group is assigned to.|
|[OAuth2PermissionGrant]|New entity that specifies an OAuth2.0 delegated permission scope.  The specified OAuth delegated permission scope may be requested by client applications (through the **requiredResourceAccess** collection) calling this resource application. Replaces the **Permission** entity which is removed from this version.|
|**Permission**|Renamed to  [OAuth2PermissionGrant].|
|**Role**|Renamed to [DirectoryRole].|
|**RoleTemplate**|Renamed to [DirectoryRoleTemplate].|
|[ServicePrincipal]|Added the **appDisplayName** property, which specifies the display name exposed by the associated application.<br/><br/>Added the **appRoleAssignmentRequired** property, which specifies whether an [AppRoleAssignment] to a user or group is required before Azure AD will issue a user or access token to the application.<br/><br/>Added the **appRoles** property, which contains the application roles exposed by the associated application.  For more information see the **appRoles** property definition on the [Application] entity.<br/><br/>Added the **oauth2Permissions** property, which contains the OAuth 2.0 permissions exposed by the associated application.  For more information see the **oauth2Permisions** property definition on the [Application] entity.<br/><br/>Added the **preferredTokenSigningKeyThumbprint** property. Reserved for internal use only. Do not write or otherwise rely on this property. May be removed in future versions.<br/><br/>Added the **appRoleAssignedTo** navigation property, which points to the set of applications that the service principal is assigned to. <br/><br/>Added the **appRoleAssignments** navigation property, which points to the set of principals (users, groups, and service principals) that are assigned to this service principal.<br/><br/>Added the **oauth2PermissionGrants** navigation property, which points to the set of user impersonation grants associated with this service principal.<br/><br/>Removed the **permissions** navigation property|
|[TenantDetail]|Removed the tenantType property.|
|[User]|Added the **onPremisesSecurityIdentifier** property, which contains the on-premises security identifier (SID) for the user that was synchronized from on-premises to the cloud.<br/><br/>Added the **sipProxyAddress** property, which specifies the voice over IP (VOIP) session initiation protocol (SIP) address for the user.<br/><br/>Added the **appRoleAssignments** navigation property, which points to the set of applications (service principals) that this user is assigned to.<br/><br/>Added the **oauth2PermissionGrants** navigation property, which points to the set of OAuth 2.0 user impersonation grants associated with this user.<br/><br/>Removed the **permissions** navigation property.|

### Complex type changes

|Type|Change Description|
|---|---|
|[AppRole]|New type that specifies application roles that may be requested by client applications calling this application, or that may be used to assign the application to users or groups in one of the specified application roles.|
|[OAuth2Permission]|New type that represents an OAuth 2.0 permission scope.  The specified OAuth 2.0 permission scope may be requested by client applications (through the **requiredResourceAccess** collection) calling this resource application.|
|[RequiredResourceAccess]|New type that specifies the set of OAuth 2.0 permission scopes and app roles under the specified resource that this application requires access to.|
|[ResourceAccess]|New type that represents a permission that this application requires.|

### Action and function changes

|Function|Change Description|
|---|---|
|[getAvailableExtensionProperties]|New function that returns the full list of extension properties that have been registered in a directory. Extension properties can be registered for the following entities: [User], [Group], [Device], [TenantDetail], [Application], and [ServicePrincipal].|
|[getMemberObjects]|New function that returns all of the [Group] and [DirectoryRole] objects that a user, contact, group, or service principal is transitively a member of.|
|[getObjectsByObjectIds]|New function that returns the directory objects specified in a list of object IDs. You can also specify which resource collections (users, groups, etc.) should be searched by specifying the optional *types* parameter.|
|[restore]|New service action that allows a deleted application to be restored.|

## Version 2013-11-08 <a id="2013-11-08"></a>

This section lists the changes for Graph API version 2013-11-08.

The following tables list the entities, complex types, and functions that have been added, changed, or removed for this release.

### Entity changes

|Entity|Change Description|
|---|---|
|[Application]|Added the **owners** navigation property, which points to the set of directory objects that are owners of the application. The owners are a set of non-admin users who are allowed to modify this object. Inherited from [DirectoryObject].|
|**DeviceConfiguration**|New entity that represents the configuration for a device.|
|[DirectoryObject]|Added the **createdOnBehalfOf** navigation property, which points to directory object that that this object was created on behalf of.<br/><br/>Added the **createdObjects** navigation property, which points to the set of directory objects that were created by the current object.<br/><br/>Added the **owners** navigation property, which points to the set of directory objects that are owners of the current object. The owners are a set of non-admin users who are allowed to modify this object.<br/><br/>Added the **ownedObjects** navigation property, which points to the set of directory objects that are owned by the current object.<br/><br/>**Important**: Entities that derive from [DirectoryObject] inherit its properties and may inherit its navigation properties.|
|[Group]|Added the **owners** navigation property, which points to the set of directory objects that are owners of the group. The owners are a set of non-admin users who are allowed to modify this object. Inherited from [DirectoryObject].
|**Role**|Added the **ownedObjects** navigation property, which points to the set of directory objects that are owned by the role. Inherited from [DirectoryObject].The **Role** entity was renamed to **DirectoryRole** beginning with version 1.5. For information about **Role**, see [DirectoryRole].|
|[ServicePrincipal]|Added the **appOwnerTenantID** property.<br/><br/>Added the **autheniticationPolicy** property. Reserved for internal use only. Do not use. Removed in version 1.5.<br/><br/>Added the **createdObjects** navigation property, which points to the set of directory objects that were created by the service principal. Inherited from [DirectoryObject].<br/><br/>Added the **owners** navigation property, which points to the set of directory objects that are owners of the service principal. The owners are a set of non-admin users who are allowed to modify this object. Inherited from [DirectoryObject].<br/><br/>Added the **ownedObjects** navigation property, which points to the set of directory objects that are owned by the service principal. Inherited from [DirectoryObject].|
|[User]|Added the **immutableId** property, which associates an on-premises Active Directory user account to its Azure AD user object. This property must be specified when creating a new user account in the Graph if you are using a federated domain for the user’s **userPrincipalName** (UPN) property.<br/><br/>Added the **userType** property, which is a string value that can be used to classify user types in your directory, such as “Member” and “Guest”.<br/><br/>Added the **createdObjects** navigation property, which points to the set of directory objects that were created by the user. Inherited from [DirectoryObject].<br/><br/>Added the **ownedObjects** navigation property, which points to the set of directory objects that are owned by the user. Inherited from [DirectoryObject].|

### Complex type changes

|Type|Change Description|
|---|---|
|**ServicePrincipalAuthenticationPolicy**|Reserved for internal use only. Do not use. Removed in version 1.5.|

### Action and function changes

|Function|Change Description|
|---|---|
|[assignLicense]|New service action that updates a user with a list of licenses to add and/or remove.|

## Version 2013-04-05 <a id="2013-04-05"></a>

This is the base version of the Graph API.

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
[SignInName]: ../api/entity-and-complex-type-reference.md#SignInNameType
[VerifiedDomain]: ../api/entity-and-complex-type-reference.md#VerifiedDomainType

[assignLicense]: ../api/functions-and-actions.md#assignLicense
[checkMemberGroups]: ../api/functions-and-actions.md#checkMemberGroups
[getAvailableExtensionProperties]: ../api/functions-and-actions.md#getAvailableExtensionProperties
[getMemberGroups]: ../api/functions-and-actions.md#getMemberGroups
[getMemberObjects]: ../api/functions-and-actions.md#getMemberObjects
[getObjectsByObjectIds]: ../api/functions-and-actions.md#getObjectsByObjectIds
[isMemberOf]: ../api/functions-and-actions.md#isMemberOf
[restore]: ../api/functions-and-actions.md#restore
