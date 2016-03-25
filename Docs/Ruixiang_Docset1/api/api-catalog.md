---
title: Azure AD Graph API Reference
author: JimacoMS
ms.TocTitle: Graph API reference
Description: Azure
ms.ContentId: DB8E4C4A-D047-4694-8245-3A74AB996F8E
ms.topic: reference (API)
ms.date: 02/18/2016
---

# Azure AD Graph API reference
The Azure Active Directory (AD) Graph API is an OData 3.0 compliant service that you can use to read and modify objects such as users, groups, and contacts in a tenant. Azure AD Graph API exposes REST endpoints that you send HTTP requests to in order to perform operations using the service. The topics in this guide show you how to perform specific operations against the resources exposed by the Graph API. Many of the topics are interactive. They expose a *Try It* feature that you can use to change the parameters of selected operations and observe the responses that are returned from a demo tenant. 

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

Click the appropriate link below to see the documentation and example for a specific operation. For more general information about the Graph API and its supported features, as well as advanced topics such as differential query, batch processing, directory schema extensions, and others, see [Graph API concepts](../howto/azure-ad-graph-api-operations-overview.md).

##Signed-in user (me) operations
[Signed-in user operations overview](./signed-in-user-operations.md) | [Get user](./signed-in-user-operations.md#GetMe) | [Update user](./signed-in-user-operations.md#UpdateMe) | [Get manager](./signed-in-user-operations.md#GetMyManagerObject) | [Assign manager](./signed-in-user-operations.md#SetMyManager) 

##User operations
[User operations overview](./users-operations.md) | [Get users](./users-operations.md#GetUsers) | [Get a user](./users-operations.md#GetAUser) | [Create users (work or school account)](./users-operations.md#CreateUser) | [Create user (local account)](./users-operations.md#CreateLocalAccountUser) | [Update user](./users-operations.md#UpdateUser) | [Reset a user's password](./users-operations.md#ResetUserPassword) | [Delete user](./users-operations.md#DeleteUser) | [Get manager](./users-operations.md#GetUsersManager) | [Assign manager](./users-operations.md#AssignUsersManager) | [Get direct reports](./users-operations.md#GetUsersDirectReports) | [Get memberships](./users-operations.md#GetUsersMemberships) | [User functions and actions](./users-operations.md#UserFunctions)

##Group Operations
[Group operations overview](./groups-operations.md) | [Get groups](./groups-operations.md#GetGroups) | [Get a group](./groups-operations.md#GetAGroup) | [Create group](./groups-operations.md#CreateGroup) | [Update group](./groups-operations.md#UpdateGroup) | [Delete group](./groups-operations.md#DeleteGroup) | [Get members](./groups-operations.md#GetGroupMembers) | [Add members](./groups-operations.md#AddGroupMembers) | [Delete member](./groups-operations.md#DeleteGroupMembers) | [Group functions and actions](./groups-operations.md#GroupFunctions)

##Contact operations
[Contact operations overview](./contacts-operations.md) | [Get contacts](./contacts-operations.md#GetContacts) | [Get a contact](./contacts-operations.md#GetAContact) | [Update contact](./contacts-operations.md#UpdateContact) | [Delete contact](./contacts-operations.md#DeleteContact) | [Get manager](./contacts-operations.md#GetContactsManager) | [Assign manager](./contacts-operations.md#AssignContactsManager) | [Get direct reports](./contacts-operations.md#GetContactsDirectReports) | [Get memberships](./contacts-operations.md#GetContactsMemberships) | [Contact functions and actions](./contacts-operations.md#ContactFunctions)

##Directory Role Operations
[Directory roles operations overview](./directoryroles-operations.md) | [Get directory roles](./directoryroles-operations.md#GetDirectoryRoles) | [Get a directory role](./directoryroles-operations.md#GetADirectoryRole) | [Get directory role templates](./directoryroles-operations.md#GetDirectoryRoleTemplatess) | [Activate a directory role](./directoryroles-operations.md#ActivateDirectoryRole) | [Get members](./directoryroles-operations.md#GetDirectoryRoleMembers) | [Add members](./directoryroles-operations.md#AddDirectoryRoleMembers) | [Delete member](./directoryroles-operations.md#DeleteDirectoryRoleMember) | [Directory role functions and actions](./directoryroles-operations.md#DirectoryRoleFunctions)

##Domain Operations (preview)
[Domains operations overview (preview)](./domains-operations.md) | [Get domains (preview)](./domains-operations.md#GetDomains) | [Get a domain (preview)](./domains-operations.md#GetADomain) | [Create a domain (preview)](./domains-operations.md#CreateDomain) |  [Update a domain (preview)](./domains-operations.md#UpdateDomain) | [Delete a domain (preview)](./domains-operations.md#DeleteDomain) |  [Get domain verification records (preview)](./domains-operations.md#GetDomainVerificationRecords) | [Get domain service configuration records (preview)](./domains-operations.md#GetDomainServiceConfigurationRecords) | [Domain functions and actions (preview)](./domains-operations.md#DomainFunctions)

##Functions and actions
[assignLicense] | [checkMemberGroups] | [getAvailableExtensionProperties] | [getMemberGroups] | [getMemberObjects] | [getObjectsByObjectIds] | [isMemberOf] | [restore] | [verify (preview)]

##Entities and complex types
###Entities
[Application] | [AppRoleAssignment] | [Contact] | [Contract] | [Device] | [DirectoryLinkChange] | [DirectoryObject] | [DirectoryRole] | [DirectoryRoleTemplate] | [Domain (preview)] | [DomainDnsRecord (preview)] | [DomainDnsCnameRecord (preview)] | [DomainDnsMxRecord (preview)] | [DomainDnsSrvRecord (preview)] | [DomainDnsTxtRecord (preview)] | [DomainDnsUnavailableRecord (preview)] | [ExtensionProperty] | [Group] | [OAuth2PermissionGrant] | [ServicePrincipal] | [SubscribedSku] | [TenantDetail] | [User]
###Complex types
[AlternativeSecurityId] | [AppRole] | [AssignedLicense] | [AssignedPlan] | [KeyCredential] | [LicenseUnitsDetail] | [OAuth2Permission] | [PasswordCredential] | [PasswordProfile] | [ProvisionedPlan] | [ProvisioningError] | [RequiredResourceAccess] | [ResourceAccess] | [ServicePlanInfo] | [ServicePrincipalAuthenticationPolicy] | [SignInName] | [VerifiedDomain]

##Additional resources

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
[DomainDnsRecord (preview)]: ./entity-and-complex-type-reference.md#DomainDnsRecordEntity
[DomainDnsCnameRecord (preview)]: ./entity-and-complex-type-reference.md#DomainDnsCnameRecordEntity
[DomainDnsMxRecord (preview)]: ./entity-and-complex-type-reference.md#DomainDnsMxRecordEntity
[DomainDnsSrvRecord (preview)]: ./entity-and-complex-type-reference.md#DomainDnsSrvRecordEntity
[DomainDnsTxtRecord (preview)]: ./entity-and-complex-type-reference.md#DomainDnsTxtRecordEntity
[DomainDnsUnavailableRecord (preview)]: ./entity-and-complex-type-reference.md#DomainDnsUnavailableRecordEntity
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
