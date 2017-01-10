---
title: Azure AD Graph API Operations on Groups
author: JimacoMS
ms.TocTitle: Operations on groups
ms.ContentId: 58e577ec-1126-46bc-8847-ebbaa0841730
ms.topic: reference (API)
ms.date: 02/26/2016
---


# Operations on groups | Graph API reference 

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
This topic discusses how to perform operations on groups using the Azure Active Directory (AD) Graph API. With the Azure AD Graph API, you can create, read, update, and delete groups. You can also query members of a group, add and delete members from a group, check a group's membership in other groups, assign app roles to a group, and much more. Some group operations are transitive and others are scoped only to direct members of the group. Support for some operations varies between security groups, mail distribution groups, and mail-enabled security groups. Groups may have users, contacts, and other groups as members.

The Graph API is an OData 3.0 compliant REST API that provides programmatic access to directory objects in Azure Active Directory, such as users, groups, organizational contacts, and applications. 

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

## Performing REST operations on groups

To perform operations on groups with the Graph API, you send HTTP requests with a supported method (GET, POST, PATCH, PUT, or DELETE) to an endpoint that targets the groups resource collection, a specific group, a navigation property of a group or a function or action that can be called on a group. The following sections discuss how to target and compose operations on groups.

Graph API requests use the following basic URL:
```no-highlight
https://graph.windows.net/{tenant_id}/{resource_path}?{api_version}[odata_query_parameters]
```

> [!IMPORTANT]
> Requests sent to the Graph API must be well-formed, target a valid endpoint and version of the Graph API, and carry a valid access token obtained from Azure AD in their `Authorization` header. For more detailed information about creating requests and receiving responses with the Graph API, see [Operations Overview].

You specify the `{resource_path}` differently depending on whether you are targeting the collection of all groups in your tenant, an individual group, or a navigation property of a specific group. 

- `/groups` targets the group resource collection. You can use this resource path to read all groups in your tenant or to create new security groups in your tenant. 
- `/groups/{object_id}` targets an individual group in your tenant. You specify the target group with its object ID (GUID). You can use this resource path to get the declared properties of a group, to modify the declared properties of a group, or to delete a security group. 
- `/group/{object_id}/{nav_property}` targets the specified navigation property of a group. You can use it to return the object or objects referenced by the target navigation property of the specified group; for example, the group's members. **Note**: This form of addressing is only available for reads. 
- `/groups/{object_id}/$links/{nav_property}` targets the specified navigation property of a group. You can use this form of addressing to both read and modify a navigation property. On reads, the objects referenced by the property are returned as one or more links in the response body. On writes, the objects are specified as one or more links in the request body. 

For example, the following request returns a a collection of links to the  members of the specified group :

```no-highlight
GET https://graph.windows.net/myorganization/groups/ffffffff-ffff-ffff-ffff-ffffffffffff/$links/members?api-version=1.6
```
 
## Basic operations on groups <a id="BasicGroupOperations"> </a>
You can perform basic create, read, update, and delete (CRUD) operations on groups and their declared properties by targeting either the group resource collection or a specific group. The following topics show you how.

The Graph API supports operations on groups as follows:

- Create (POST): security groups only.
- Read (GET): all groups.
- Update (PATCH): security groups and mail-enabled security groups. Not all properties are supported.
- Delete (DELETE): security groups only.


****

### Get groups <a id="GetGroups"> </a>
Gets a collection of groups. You can add OData query parameters to the request to  sort, and page the response. For more information, see [Supported Queries, Filters, and Paging Options].

On success, returns a collection of [Group] objects; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling]. 

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "get groups", 
     "showComponents": {        
        "codeGenerator": "true",
        "tryFeature": "true"      
    } 
}
```

****

###Get a group <a id="GetAGroup"> </a>

Gets a specified group. Specify the group by its object ID (GUID).

On success, returns the [Group] object for the specified group; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "get group by id",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****

### Create a group <a id="CreateGroup"> </a>
Adds a security group to the tenant. The request body contains the properties of the group to be created. You must specify the required properties for the  group. You can optionally specify any other writable properties.

**Important**: You can only create security groups with the Graph API. You cannot create mail-enabled security groups or mail distribution groups.

The following table shows the properties that are required when you create a group. 
 
|**Required parameter**|**Type**|**Description**|
|:-----|:-----|:-----|
|displayName|string|The name to display in the address book for the group.|
|mailEnabled|boolean|Must be *false*. This is because only pure security groups can be created using the Graph API.|
|mailNickname|string|The mail alias for the group.|
|securityEnabled|boolean|Must be *true*. This is because only pure security groups can be created using the Graph API.|

On success, returns the newly created [Group]; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "create group" 
}
```
****

### Update a group <a id="UpdateGroup"> </a>

Update a group's properties. Specify any writable [Group] property in the request body. Only the properties that you specify are changed.

**Important**:

- Only security groups and mail-enabled security groups can be updated.
- A security group cannot be updated to a mail-enabled security group or to a mail distribution group.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "update group"
}
```
****

### Delete a group <a id="DeleteGroup"> </a>

Deletes a group. Deleted groups are not recoverable.

**Important**: You can only delete security groups with the Graph API. You cannot delete mail-enabled security groups or mail distribution groups.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "delete group"
}
```

****

## Operations on group navigation properties <a id="GroupNavigationOps"> </a>

Relationships between a group and other objects in the directory such as the users, contacts, and other groups that may be its members are exposed through navigation properties. You can read and, in some cases, modify these relationships by targeting these navigation properties in your requests. 

Operations are supported as follows:

- Read (GET): all groups.
- Update (POST): security groups and mail-enabled security groups (**members** and **owners** only).
- Delete (DELETE): security groups only (**members** and **owners** only).


### Get a group's direct members <a id="GetGroupMembers"> </a>

Gets the group's direct members from the **members** navigation property. 

On success, returns a collection of links to the [User]s, [Contact]s, [ServicePrincipal]s, and other [Group]s that are direct members of this group; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "get group members links",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****

### Add group members <a id="AddGroupMembers"> </a>

Adds a member to a security group or a mail-enabled security group through the **members** navigation property. You can add users, contacts, service principals, or other groups. The request body contains a single link to the [User], [Contact], [ServicePrincipal], or [Group] to add. 

**Important**: You can only add members to security groups and mail-enabled security groups.


On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "add group members"
}
```

****
### Delete a group member <a id="DeleteGroupMember"> </a>

Deletes a specified group member from a security group through the **members** navigation property. Specify the object ID of the [User], [Contact], [ServicePrincipal], or [Group] to delete in the terminal URL segment. 

**Important**: You can only delete members from pure security groups.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Groups",
    "operation":    "delete group member"
}
```

****
### Other navigation properties
By using the same patterns shown above, you can target other navigation properties exposed by groups. Some properties are read-only and others may be modified. For more information about group navigation properties, see the documentation for [Group]. 

****

## Functions and actions on groups <a id="GroupFunctions"> </a>
You can call any of the following functions or actions on a group.

### Check membership in a specific group (transitive)
You can call the [isMemberOf] function to check a user, contact, service principal, or another group for membership in a specific group. The check is transitive.

### Check membership in a list of groups (transitive)
You can call the [checkMemberGroups] function to check a user, contact, service principal, or group for membership in a list of groups. The check is transitive.

### Get all group memberships (transitive)
You can call the [getMemberGroups] function to return all the groups that a user, contact, service principal, or group is a member of. The check is transitive.

### Get all group and directory role memberships (transitive)
You can call the [getMemberObjects] function to return all of the groups and directory roles that a user, contact, group, or service principal is a member of. The check is transitive.

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

[!CODE-RESTAPI_Swagger [groups_swagger2](./groups_swagger2.json)]