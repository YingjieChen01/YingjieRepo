---
title: Azure AD Graph API Addressing Entities and Operations 
author: JimacoMS
ms.TocTitle: Addressing Entities and Operations
ms.ContentId: 69465032-c46d-41eb-b291-d442263a3284
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Addressing Entities and Operations in the Graph API

This topic discusses different addressing alternatives that you can use when addressing directory entities, calling directory functions, performing queries against the directory, or performing operations on directory entities and resource sets using Azure AD Graph API. For more detailed information about performing specific operations or queries, addressing directory entities, or calling functions, see the appropriate operations topic in the [Azure AD Graph API reference documentation](../api/api-catalog.md).

- For information about performing queries against the directory, see [Azure AD Graph API Supported Queries, Filters, and Paging Options](./azure-ad-graph-api-supported-queries-filters-and-paging-options.md).

- For information about directory entities and the operations that can be performed on them as well as about functions that are exposed by Graph, see the relevant topic in the [Azure AD Graph REST API Reference](https://msdn.microsoft.com/en-us/library/azure/hh974478.aspx).

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

## Tenant Addressing

You can address your tenant in one of three ways:

- **By tenant object ID**. This is a GUID that was assigned when the tenant was created. It is equivalent to the **objectId** property of the [TenantDetail] object. The following URL shows how to address the top-level resources of a tenant’s directory by using the object ID: `https://graph.windows.net/12345678-9abc-def0-1234-56789abcde/?api-version=1.6`.

- **By verified (registered) domain name**. This is one of the domain names that are registered for the tenant. These can be found in the **verifiedDomains** property of the [TenantDetail] object. The following URL shows how to address the top-level resources of a tenant that has the domain contoso.com: `https://graph.windows.net/contoso.com/?api-version=1.6`.

- **By using the “MyOrganization” alias**. This alias is only available when using OAuth Authorization Code Grant type (3-legged) authentication. The alias is not case sensitive. It replaces the object ID or tenant domain in the URL. When the alias is used, Graph API derives the tenant from the claims presented in the token attached to the request. The following URL shows how to address the top-level resources of a tenant using this alias: `https://graph.windows.net/myorganization/?api-version=1.6`.

- **By using the “Me” alias**. This alias is only available when using OAuth Authorization Code Grant type (3-legged) authentication. The alias is not case sensitive. It replaces the object ID or tenant domain in the URL. When the alias is used, Graph API derives the user from the claims presented in the token attached to the request. The following URL can be used to call the [getMemberGroups] function to return the transitive group memberships of the current user: `https://graph.windows.net/me/getMemberGroups?api-version=1.6`. (**Note**: a request body must also be supplied with the POST request.)

## See Also


[Azure AD Graph API Supported Queries, Filters, and Paging Options](./azure-ad-graph-api-supported-queries-filters-and-paging-options.md)

[Azure AD Graph REST API Reference](../api/api-catalog.md)


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
