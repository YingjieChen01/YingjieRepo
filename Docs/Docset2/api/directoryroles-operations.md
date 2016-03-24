---
title: Azure AD Graph API Operations on Directory Roles
author: JimacoMS
ms.TocTitle: Operations on directory roles
ms.ContentId: f8b57609-f41a-4bc5-9aad-4b8542271c14
ms.topic: reference (API)
ms.date: 01/26/2016
---


# Operations on directory roles | Graph API reference 

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
This topic discusses how to perform operations on Azure AD directory roles using the Azure Active Directory (AD) Graph API. Directory roles ([DirectoryRole]) carry specific sets of rights within the directory. Azure AD grants the users and service principals that are members of a directory role the rights associated with that role. Azure AD directory roles are also known as *administrator roles*. For more information about directory (administrator) roles, see [Assigning administrator roles in Azure AD](http://azure.microsoft.com/documentation/articles/active-directory-assign-admin-roles/).

With the Graph API, you can read the properties of directory roles, query members of a directory role, and add and delete members to and from a directory role. Directory Roles may have users and service principals as members. Adding groups to directory roles is not currently supported. 

In versions prior to 1.5 all directory roles are present in the tenant by default. In versions 1.5 and newer, only the Company Administrators directory role is present by default. To access and assign members to another directory role, you must first activate it by using its corresponding directory role template ([DirectoryRoleTemplate]). For more information, see [Activate a directory role](#ActivateDirectoryRole). 

The Graph API is an OData 3.0 compliant REST API that provides programmatic access to directory objects in Azure Active Directory, such as users, groups, organizational contacts, and applications.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

## Performing REST operations on directory roles

To perform operations on directory roles with the Graph API, you send HTTP requests with a supported method (GET, POST, PATCH, PUT, or DELETE) to an endpoint that targets the directoryRoles resource collection, a specific directory role, a navigation property of a directory role, or a function or action that can be called on a directory role. 

Graph API requests use the following basic URL:
```no-highlight
https://graph.windows.net/{tenant_id}/{resource_path}?{api_version}[odata_query_parameters]
```

> [!IMPORTANT]
> Requests sent to the Graph API must be well-formed, target a valid endpoint and version of the Graph API, and carry a valid access token obtained from Azure AD in their `Authorization` header. For more detailed information about creating requests and receiving responses with the Graph API, see [Operations Overview].

You specify the `{resource_path}` differently depending on whether you are targeting the collection of all directory roles in your tenant, an individual directory role, or a navigation property of a specific directory role. 

- `/directoryRoles` targets the directoryRoles resource collection. You can use this resource path to read all directory roles in your tenant and, in version 1.5 and newer, to activate a directory role in your tenant. 
- `/directoryRoleTemplates` targets the directoryRoleTemplates resource collection. You can use this resource path to read all directory role templates available in your tenant. In version 1.5 and newer, you use directory role templates to activate a directory roles in your tenant. 
- `/directoryRoles/{object_id}` targets an individual directory role in your tenant. You specify the target role with its object ID (GUID). You can use this resource path to get the declared properties of a specified directory role. 
- `/directoryRoles/{object_id}/members` targets the **members** navigation property of a directory role. You can use it to return the users and service principals that are members of the specified directory role. **Note**: This form of addressing is only available for reads. 
- `/directoryRoles/{object_id}/$links/members` targets the **members** navigation property of a directory role. You can use this form of addressing to both read and modify the members of the role. On reads, the users and service principals referenced by the property are returned as one or more links in the response body. On writes, the users and service principals are specified as one or more links in the request body. 

For example, the following request returns a a collection of links to the  members of the specified directory role:

```no-highlight
GET https://graph.windows.net/myorganization/directoryRoles/ffffffff-ffff-ffff-ffff-ffffffffffff/$links/members?api-version=1.6
```
 
## Basic operations on directory roles <a id="BasicDirectoryRoleOperations"> </a>
You can perform the following basic operations on directory roles and directory role templates. 

- Read the properties of all directory roles or an individual role.
- Read the properties of all directory role templates or an individual template (version 1.5 and newer).  
- Activate a directory role using a POST request (version 1.5 and newer).

The following topics show you how.

****

### Get directory roles <a id="GetDirectoryRoles"> </a>
Gets the collection directory roles that are activated in the tenant. (For versions prior to 1.5, all directory roles were activated by default.)

On success, returns the collection of [DirectoryRole] objects that are activated; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling]. 

```RESTAPIdocs
{
    "api":  "DirectoryRoles",
    "operation":    "get directory roles", 
     "showComponents": {        
        "codeGenerator": "true"
    } 
}
```

****

###Get a directory role <a id="GetADirectoryRole"> </a>

Gets a specified directory role. Specify the directory role by its object ID (GUID).

On success, returns the [DirectoryRole] object for the specified role; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "DirectoryRoles",
    "operation":    "get directory role by id",
     "showComponents": {        
        "codeGenerator":    "true"
    } 
}
```

****

### Get directory role templates <a id="GetDirectoryRoleTemplates"> </a>
Gets the collection of directory role templates that are available in the tenant. In version 1.5 and newer, directory role templates are used to activate directory roles. Not available in versions prior to 1.5.

On success, returns the collection of [DirectoryRoleTemplate] objects for the tenant; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling]. 

```RESTAPIdocs
{
    "api":  "DirectoryRoles",
    "operation":    "get directory role templates", 
     "showComponents": {        
        "codeGenerator": "true"
    } 
}
```

****

### Activate a directory role <a id="ActivateDirectoryRole"> </a>
Activates a directory role in the tenant. Available in version 1.5 and newer only. The request body contains the object ID of the directory role template for the directory role you want to activate.

**Note**: In versions prior to 1.5 all directory roles are present in the tenant by default. In versions 1.5 and newer, only the Company Administrators directory role is present by default. To access and assign members to another directory role, you must first activate it with its corresponding directory role template ([DirectoryRoleTemplate]).

The following table shows the properties that are required when you activate a directory role. 
 
|**Required parameter**|**Type**|**Description**|
|:-----|:-----|:-----|
|roleTemplateId|string|The <strong>objectId</strong> of the [DirectoryRoleTemplate] that the role is based on.|

On success, returns the newly created [DirectoryRole]; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "DirectoryRoles",
    "operation":    "activate directory role" 
}
```
****


## Operations on directory role navigation properties <a id="DirectoryRoleNavigationOps"> </a>

Navigation properties represent relationships between an instance of an entity and other objects in the directory. Directory roles expose only a single navigation property, the **members** property. This property contains users and service principals that have been added to the directory role. You can read (GET), add (POST), and delete (DELETE) members from the directory role by targeting the **members** property. 


### Get a directory role's members <a id="GetDirectoryRoleMembers"> </a>

Gets the directory role's members from the **members** navigation property. 

On success, returns a collection of links to the [User]s, and [ServicePrincipal]s that are members of the directory role; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

**Note**: You can remove the "$links" segment from the URL to return [DirectoryObject]s for the users and service principals instead of links. 

```RESTAPIdocs
{
    "api":  "DirectoryRoles",
    "operation":    "get directory role members links",
     "showComponents": {        
        "codeGenerator":    "true"
    } 
}
```

****

### Add directory role members <a id="AddDirectoryRoleMembers"> </a>

Adds one or more members to a directory role through the **members** navigation property. You can add users or service principals. The request body contains one or more links to the [User]s and [ServicePrincipal]s to add. 

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "DirectoryRoles",
    "operation":    "add directory role members"
}
```

****
### Delete a directory role member <a id="DeleteDirectoryRoleMember"> </a>

Deletes a specified member from a directory role through the **members** navigation property. Specify the object ID of the [User] or [ServicePrincipal] to delete in the terminal URL segment. 

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "DirectoryRoles",
    "operation":    "delete directory role member"
}
```

****

## Functions and actions on directory roles <a id="DirectoryRoleFunctions"> </a>
You can call any of the following functions for directory roles.

### Get all group and directory role memberships (transitive)
You can call the [getMemberObjects] function to return all of the groups and directory roles that a user, contact, group, or service principal is a member of. The check is transitive for groups (directory roles cannot have groups or other directory roles as members).

### Get objects from a list of object IDs
Call the [getObjectsByObjectIds] function on the directory service to return the directory objects specified in a list of object IDs. You can also specify which resource collections (users, groups, etc.) should be searched by specifying the optional **types** parameter. For example, you could use this function to find the directory roles in the list of object IDs returned by the **getMemberObjects** function above. 


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

[!CODE-RESTAPI_Swagger [directoryroles_swagger2](./directoryroles_swagger2.json)]
