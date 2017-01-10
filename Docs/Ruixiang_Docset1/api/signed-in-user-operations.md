---
title: Azure AD Graph API Operations on the Signed-in User
author: JimacoMS
ms.TocTitle: Operations on the signed-in user
ms.ContentId: bff2e900-d262-4601-b279-372d9c531d05
ms.topic: reference (API)
ms.date: 01/26/2016
---


# Operations on the signed-in user | Graph API reference

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
This topic discusses how to perform operations on the signed-in user with the Azure Active Directory (AD) Graph API by using the `me` alias. With the Azure AD Graph API, you can read and update properties of the signed-in user. You can also query and modify a the signed-in user's relationships to other directory entities. For example, you  can assign the signed-in user's manager, query the user's direct reports, manage group memberships, app roles, and devices assigned to the user, and much more.

The Graph API is an OData 3.0 compliant REST API that provides programmatic access to directory objects in Azure Active Directory, such as users, groups, organizational contacts, and applications.

> [!IMPORTANT]
>Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

##  Performing REST operations on the signed-in user <a id="Signed-in User"> </a>

You can use the `me` alias to target the signed-in user. To perform operations on the signed-in user with the Graph API, you send HTTP requests with a supported method (GET, POST, PATCH, PUT, or DELETE) to an endpoint that uses the `me` alias to target the signed-in user, a navigation property of the user, or a function or action that can be called on the user.

Graph API requests use the following basic URL:
```no-highlight
https://graph.windows.net/{tenant_id}/{resource_path}?{api_version}[odata_query_parameters]
```

> [!IMPORTANT]
>Requests sent to the Graph API must be well-formed, target a valid endpoint and version of the Graph API, and carry a valid access token obtained from Azure AD in their `Authorization` header. For more detailed information about creating requests and receiving responses with the Graph API, see [Operations Overview].

You use can use the `me` alias to target the signed-in user. This alias replaces the `{tenant id}` and `{resource path}` segments in the request URL. When you send a request to the Graph API with the `me` alias, it derives the tenant and user from the bearer token attached to the request. For example, sending a GET request to `https://graph.windows.net/me?api-version=1.6` will return the user object of the signed-in user.

You specify the URL differently depending on whether you are targeting the signed-in user or one of its navigation properties. 

- `me` targets the signed-in user. You can use this resource path to get the declared properties of the user and to modify the declared properties of the user. 
- `me/{nav_property}` targets the specified navigation property of the signed-in user. You can use it to return the object or objects referenced by the target navigation property of the user. **Note**: This form of addressing is only available for reads. 
- `me/$links/{nav_property}` targets the specified navigation property of the signed-in user. You can use this form of addressing to both read and modify a navigation property. On reads, the objects referenced by the property are returned as one or more links in the response body. On writes, the objects are specified as one or more links in the request body. 

For example, the following request returns a link to the signed-in user's manager:

```no-highlight
GET https://graph.windows.net/me/$links/manager?api-version=1.6
```

****
## Basic operations on the signed-in user <a id="BasicOperations"> </a>

You can read the signed-in user and update its declared properties by using the `me` alias. The following topics show you how.

****

### Get the signed-in user <a id="GetMe"> </a>

Gets the signed-in user.

On success, returns the [User] object for the signed-in user; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].


```RESTAPIdocs
{
    "api":  "MeOps",
    "operation":    "get me",
     "showComponents": {
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****


### Update the signed-in user <a id="UpdateMe"> </a> 

Updates properties of the signed-in user. Specify any writable [User] property in the request body. Only the properties that you specify are changed.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].


```RESTAPIdocs
{
    "api":  "MeOps",
    "operation":    "update me"
}
```
****
## Operations on navigation properties <a id="NavigationOps"> </a>

Relationships between a user and other objects in the directory such as the user's manager, direct group memberships, and direct reports are exposed through navigation properties. When you use the `me` alias, you can read and, in some cases, modify these relationships by targeting these navigation properties in your requests.
 
****

### Get the signed-in user's manager (object) <a id="GetMyManagerObject"> </a>

Gets the signed-in user's manager (object) from the **manager** navigation property.

On success, returns the [User] or [Contact] assigned as the user's manager; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].
 
Returns **404 Not Found** if the user does not have a manager assigned.


```RESTAPIdocs
{
    "api":  "MeOps",
    "operation":    "get my manager object",
     "showComponents": {
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****

### Get the signed-in user's manager (link) <a id="GetMyManagerLink"> </a>

Gets a link to the signed-in user's manager from the **manager** navigation property.

On success, returns a link to the [User] or [Contact] assigned as the user's manager; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

Returns **404 Not Found** if the user does not have a manager assigned.


```RESTAPIdocs
{
    "api":  "MeOps",
    "operation":    "get my manager link",
     "showComponents": {
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```




****

### Update the signed-in user's manager <a id="SetMyManager"> </a>

Assigns the signed-in user's manager through the **manager** property. Either a user or a contact may be assigned. The request body contains a link to the [User] or [Contact] to assign. 

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "MeOps",
    "operation":    "set my manager"
}
```

****
### Other navigation properties
By using the same patterns shown above, you can target other navigation properties exposed by users. Some properties are read-only and others may be modified. For more information about user navigation properties, see the documentation for [User]. 

****

## Functions and actions on the signed-in user <a id="Functions"> </a>

You can call any of the following functions or actions on the signed-in user by using the `me` alias.

### Assign and remove licenses
You can call the [assignLicense] action to assign or remove licenses for a user and to enable or disable specific plans for the user.

### Check membership in a list of groups (transitive)
You can call the [checkMemberGroups] function to check for membership in a list of groups. The check is transitive.

### Get all group memberships (transitive)
You can call the [getMemberGroups] function to return all the groups that the user is a member of. The check is transitive, unlike reading the **memberOf** navigation property, which returns only the groups that the user is a direct member of.

### Get all group and directory role memberships (transitive)
You can call the [getMemberObjects] function to return all of the groups and directory roles that the user is a member of. The check is transitive, unlike reading the **memberOf** navigation property, which returns only the groups that the user is a direct member of.

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

[!CODE-RESTAPI_Swagger [me_ops_swagger2](./me_ops_swagger2.json)]
