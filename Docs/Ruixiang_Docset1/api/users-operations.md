---
title: Azure AD Graph API Operations on Users
author: JimacoMS
ms.TocTitle: Operations on users
ms.ContentId: 061d80ce-2c24-4256-bc0e-bcf65d99635a
ms.topic: reference (API)
ms.date: 02/18/2016
---


# Operations on users | Graph API reference

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
This topic discusses how to perform operations on users using the Azure Active Directory (AD) Graph API. With the Azure AD Graph API, you can create, read, update, and delete users. You can also query and modify a user's relationships to other directory entities. For example, you  can assign the user's manager, query the user's direct reports, manage group memberships, app roles, and devices assigned to the user, and much more.

The Graph API is an OData 3.0 compliant REST API that provides programmatic access to directory objects in Azure Active Directory, such as users, groups, organizational contacts, and applications. 

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token. Test.


## Performing REST operations on users

To perform operations on users with the Graph API, you send HTTP requests with a supported method (GET, POST, PATCH, PUT, or DELETE) to an endpoint that targets the users resource collection, a specific user, a navigation property of a user, or a function or action that can be called on a user. 


Graph API requests use the following basic URL:
```no-highlight
https://graph.windows.net/{tenant_id}/{resource_path}?{api_version}[odata_query_parameters]
```

> [!IMPORTANT]
>Requests sent to the Graph API must be well-formed, target a valid endpoint and version of the Graph API, and carry a valid access token obtained from Azure AD in their `Authorization` header. For more detailed information about creating requests and receiving responses with the Graph API, see [Operations Overview].

You specify the resource path differently depending on whether you are targeting the collection of all users in your tenant, an individual user, or a navigation property of a specific user. 

- `/users` targets the user resource collection. You can use this resource path to read all users or a filtered list of users in your tenant or to create one or more new users in your tenant. 
- `/users/{user_id}` targets an individual user in your tenant. You specify the `user_id` either as the object ID (GUID) or the user principal name (UPN) of the target user. You can use this resource path to get the declared properties of a user, to modify the declared properties of a user, or to delete a user. 
- `/users/{user_id}/{property}` targets the specified navigation property of a user. You can use it to return the object or objects referenced by the target navigation property of the specified user. **Note**: This form of addressing is only available for reads. 
- `/users/{user_id}/$links/{property}` targets the specified navigation property of a user. You can use this form of addressing to both read and modify a navigation property. On reads, the objects referenced by the property are returned as one or more links in the response body. On writes, the objects are specified as one or more links in the request body. 

For example, the following request returns a link to the specified user's manager:

```no-highlight
GET https://graph.windows.net/myorganization/users/john@contoso.onmicrosoft.com/$links/manager?api-version=1.6
```
**Note**: You can use the `me` alias to target the signed-in user. For more information  about performing operations using the `me` alias, see [Operations on the Signed-in User](./signed-in-user-operations.md).

## Basic operations on users <a id="BasicUserOperations"> </a>
You can perform basic create, read, update, and delete (CRUD) operations on users and their declared properties by targeting either the user resource collection or a specific user. The following topics show you how. 

****

### Get users <a id="GetUsers"> </a>
Gets a collection of users. You can add OData query parameters to the request to filter, sort, and page the response. For more information, see [Supported Queries, Filters, and Paging Options].

On success, returns a collection of [User] objects; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get users", 
     "showComponents": {        
        "codeGenerator": "true",
        "tryFeature": "true"      
    } 
}
```

****

###Get a user <a id="GetAUser"> </a>

Gets a specified user. You can use either the object ID (GUID) or the user principal name (UPN) to identify the target user.

On success, returns the [User] object for the specified user; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get user by id",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****

###Get a user's thumbnail photo <a id="GetUserThumbnailPhoto"> </a>

Gets the thumbnail photo for a specified user from the **thumbnailPhoto** property. You can use either the object ID (GUID) or the user principal name (UPN) to identify the target user.

On success, returns the thumbnail photo for the specified user; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

**Important**: The media type depends on the image type stored in Azure AD and is returned in the `Content-Type` header; for example, `image/jpeg`. If the media type cannot be determined, the Graph API returns a `Content-Type` of `*/*`. The Graph API does not convert between media (image) types.

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get user thumbnail photo",
     "showComponents": {        
        "codeGenerator":    "false",
        "tryFeature": "false"      
    } 
}
```

****

### Create a user (work or school account) <a id="CreateUser"> </a>
Adds a user to the tenant by creating a work or school account. Such users are also known as organizational accounts or organizational users. The request body contains the properties of the user to create. At a minimum, you must specify the required properties for the user. You can optionally specify any other writable properties except for **creationType** or **signInNames**, which are only valid for local accounts. To add a local account user to an Azure Active Directory B2C tenant, see [Create a user (local account)](#CreateLocalAccountUser).

The following table shows the properties that are required when you create a user. 
 
|**Required parameter**|**Type**|**Description**|
|:-----|:-----|:-----|
|accountEnabled|boolean|*true* if the account is enabled; otherwise, *false*.|
|displayName|string|The name to display in the address book for the user.|
|immutableId|string|Only needs to be specified when creating a new user account if you are using a federated domain for the user's *userPrincipalName* (UPN) property.|
|mailNickname|string|The mail alias for the user.|
|passwordProfile|[PasswordProfile]|The password profile for the user.|
|userPrincipalName|string|The user principal name (someuser@contoso.com). The user principal name must contain one of the verified domains for the tenant.|

On success, returns the newly created [User]; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "create user" 
}
```
****
### Create a user (local account) <a id="CreateLocalAccountUser"> </a>
Beginning with version 1.6, Graph API supports creating local account users for Azure Active Directory B2C tenants. Unlike users associated with a work or school account, which require sign-in with an email address that contains one of the tenant's verified domains, local account users support signing in with app-specific credentials; for example, with a 3rd-party email address or an app-specific user name. For more information about Azure Active Directory B2C, see the [Azure Active Directory  B2C documentation](https://azure.microsoft.com/documentation/services/active-directory-b2c/).

The request body contains the properties of the local account user to create. At a minimum, you must specify the required properties for the local account user. These are somewhat different than those specified for work or school accounts as you can see in the table below. For local account users, the **creationType** property must be specified to indicate that the user is a local account and the **signInNames** property must be specified to pass the sign-in names for the user. In addition to the required properties, you can optionally specify any other writable properties on the [User] entity; however, this is generally limited to app-defined extension properties and a subset of the available properties on the [User] entity. You cannot assign licenses or subscriptions to local account users. 

The following table shows the properties that are required when you create a local account user. 
 
|**Required parameter**|**Type**|**Description**|
|:-----|:-----|:-----|
|accountEnabled|boolean|*true* if the account is enabled; otherwise, *false*.|
|creationType|string|Must be set to "LocalAccount" to create a local account user. **Note**: Specified as "NameCoexistence" in beta.|
|displayName|string|The name to display in the address book for the user.|
|passwordProfile|[PasswordProfile]|The password profile for the user.|
|signInNames|collection([SignInName])|One or more [SignInName] records that specify the sign-in names for the user. Each sign-in name must be unique across the company/tenant. **Note**: Renamed from **alternativeSignInNamesInfo** in beta.|

On success, returns the newly created [User]; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users2",
    "operation":    "create local account user" 
}
```
****

### Update a user <a id="UpdateUser"> </a>

Update a user's properties. Specify any writable [User] property in the request body. Only the properties that you specify are changed.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "update user"
}
```
****

### Reset a user's password <a id="ResetUserPassword"> </a>

Reset a user's password. Resetting a user's password is a special case of the update user operation. Specify the **passwordProfile** property for the [User]. The request contains a valid [PasswordProfile] object that specifies a password that satisfies the tenant’s password complexity policy. The password policy typically imposes constraints on the complexity, length, and re-use of a password. For more information, see the [PasswordProfile] topic.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users2",
    "operation":    "reset user password"
}
```
****

### Delete a user <a id="DeleteUser"> </a>

Deletes a user. Deleted users might not be recoverable.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "delete user"
}
```

****

## Operations on user navigation properties <a id="UserNavigationOps"> </a>

Relationships between a user and other objects in the directory such as the user's manager, direct group memberships, and direct reports are exposed through navigation properties. You can read and, in some cases, modify these relationships by targeting these navigation properties in your requests. 

### Get a user's manager <a id="GetUsersManager"> </a>

Gets the user's manager from the **manager** navigation property. 

On success, returns a link to the [User] or [Contact] assigned as the user's manager; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

**Note**: You can remove the "$links" segment from the URL to return the [User] or [Contact] object instead of a link.

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get user manager link",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****

### Assign a user's manager <a id="AssignUsersManager"> </a>

Assigns a user's manager through the **manager** property. Either a user or a contact may be assigned. The request body contains a link to the [User] or [Contact] to assign. 

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "update user manager"
}
```

****
### Get a user's direct reports <a id="GetUsersDirectReports"> </a>

Gets the user's direct reports from the **directReports** navigation property. 

On success, returns a collection of links to the [User]'s and [Contact]'s for whom this user is assigned as manager; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

**Note**: You can remove the "$links" segment from the URL to return  [DirectoryObject]s for the users and contacts instead of links.

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get user direct reports links",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****
### Get a user's group and directory role memberships <a id="GetUsersMemberships"> </a>

Gets the user's group and directory role memberships from the **memberOf** navigation property. 

This property returns only groups or directory roles that the user is a direct member of. To get all of the groups that the user  has direct or transitive membership in, call the [getMemberGroups] function. To get all of the groups or directory roles that the user has direct or transitive membership in, call the [getMemberObjects] function. 

On success, returns a collection of links to the [Group]'s and [DirectoryRole]'s that this user is a member of; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

**Note**: You can remove the "$links" segment from the URL to return the [DirectoryObject]s for the groups and directory roles instead of links.

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get user memberOf links",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****
### Other navigation properties
By using the same patterns shown above, you can target other navigation properties exposed by users. Some properties are read-only and others may be modified. For more information about user navigation properties, see the documentation for [User]. 

****
## Functions and actions on users <a id="UserFunctions"> </a>
You can call any of the following functions or actions on a user.

### Assign a license to a user
You can call the [assignLicense] action to assign or remove licenses for a user and to enable or disable specific plans for the user.

### Check membership in a specific group (transitive)
You can call the [isMemberOf] function to check for membership in a specific group. The check is transitive.

### Check membership in a list of groups (transitive)
You can call the [checkMemberGroups] function to check for membership in a list of groups. The check is transitive.

### Get all group memberships (transitive)
You can call the [getMemberGroups] function to return all the groups that the user is a member of. The check is transitive, unlike reading the [memberOf](#GetUsersMemberships) navigation property, which returns only the groups that the user is a direct member of.

### Get all group and directory role memberships (transitive)
You can call the [getMemberObjects] function to return all of the groups and directory roles that the user is a member of. The check is transitive, unlike reading the [memberOf](#GetUsersMemberships) navigation property, which returns only the groups that the user is a direct member of.

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
[SignInName]: ./entity-and-complex-type-reference.md#SignInNameType
[VerifiedDomain]: ./entity-and-complex-type-reference.md#VerifiedDomainType

[assignLicense]: ./functions-and-actions.md#assignLicense
[checkMemberGroups]: ./functions-and-actions.md#checkMemberGroups
[getAvailableExtensionProperties]: ./functions-and-actions.md#getAvailableExtensionProperties
[getMemberGroups]: ./functions-and-actions.md#getMemberGroups
[getMemberObjects]: ./functions-and-actions.md#getMemberObjects
[getObjectsByObjectIds]: ./functions-and-actions.md#getObjectsByObjectIds
[isMemberOf]: ./functions-and-actions.md#isMemberOf
[restore]: ./functions-and-actions.md#restore
[verify (preview)]: ./functions-and-actions.md#verify
    
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

[!CODE-RESTAPI_Swagger [users_swagger2](./users_swagger2.json)]
[!CODE-RESTAPI_Swagger [users2_swagger2](./users2_swagger2.json)]
