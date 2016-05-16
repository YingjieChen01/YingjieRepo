---
title: Azure AD Graph API Supported Queries Filters and Paging Options
author: JimacoMS
ms.TocTitle: Supported queries, filters, and paging options
ms.ContentId: 0bb7e159-d5cc-4fd0-b383-9a3172e3deb8
ms.topic: article (how-tos)
ms.date: 02/18/2016
---

# Supported queries, filters, and paging options | Graph API concepts

This topic lists query options, filters, and paging operations that you can use with the Azure Active Directory (AD) Graph API. The final section gives some examples of common queries that you can perform with the Azure AD Graph API.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

## Addressing <a id="Addressing"></a>
The queries below all address the tenant using a domain name. You can replace *contoso.com* with one of your tenant’s registered domain names, with your tenant's ID (GUID), or with the `MyOrganization` alias (for delegated access). In some cases, you may be able to use the `me` alias. For information about ways of addressing the tenant, see [Operations overview](./azure-ad-graph-api-operations-overview.md).

## Supported query options <a id="SupportedQueryOptions"></a>

The Graph supports the following query options: **$filter**, **$orderby**, **$expand**, **$top**, and **$format**. The following query options are not currently supported: **$count**, **$inlinecount**, and **$skip**.

### $filter

The following general restrictions apply to queries that contain a filter:

- $filter cannot be combined with $orderby expressions.

- Filtering is not supported for queries on [DirectoryRole] or [SubscribedSku] directory objects.

- Not all properties of supported directory objects can be used in a filter expression. For information about filterable properties of supported types, see [User], [Group], and [Contact].

The following restrictions apply to filter expressions:

- Logical operators: **and** and **or** are supported. For example: `https://graph.windows.net/contoso.com/users?api-version=2013-11-08&$filter=accountEnabled eq true and (userPrincipalName eq 'jonlawr@contoso.com' or mail eq 'jonlawr@contoso.com')`

- Comparison operators: **eq** (equal to), **ge** (greater than or equal to), and **le** (less than or equal to) are supported.

- **startswith** is supported. For example: `https://graph.windows.net/contoso.com/users?api-version=2013-11-08&$filter=startswith(displayName,'Mary')`

- **any** is supported when querying multi-valued properties. For example: `https://graph.windows.net/contoso.com/users?api-version=2013-11-08&$filter=userPrincipalName eq 'Mary@Contoso.com' or proxyAddresses/any(c:c eq 'smtp:Mary@Contoso.com')`

- Arithmetic operators: not supported.

- Functions: not supported.

- **null** values are not supported as an operand in filter expressions. For example, you cannot specify a **null** value to filter for unset properties.

### $orderby

$orderby will sort the returned objects by the specified parameter. Example requests using the $orderby option:

|Request|Description|
|---|---|
|`https://graph.windows.net/contoso.com/users?$orderby=displayName&api-version=1.6`|Returns a list of users ordered by their display name.|
|`https://graph.windows.net/contoso.com/users?$orderby=displayName&$top=50&api-version=1.6`|Returns a list of the first 50 users ordered by their display name.|

The following restrictions apply to $orderby expressions:

- Two sort orders are currently supported: **DisplayName** for [User] and [Group] objects, and **UserPrincipalName** for [User] objects. The default sort order for users is by **UserPrincipalName**.

- $orderby cannot be combined with $filter expressions.

### $expand

$expand will return an object and its linked objects. Example requests using the $expand option:

|Request|Description|
|---|---|
|`https://graph.windows.net/contoso.com/groups/1747ad35-dd4c-4115-8604-09b54f89277d?$expand=members&api-version=1.6`|Returns both the group object as well as its members.|
|`https://graph.windows.net/contoso.com/users/derek@contoso.com?$expand=directReports&api-version=1.6`|Returns both the user object as well as its direct reports.|
|`https://graph.windows.net/contoso.com/users/adam@contoso.com?$expand=manager&api-version=1.6`|Returns both the user object as well as its manager.|

The following restrictions apply to $expand expressions:

- The maximum number of returned objects for a request is 20.

### $top

$top is not supported for queries on [DirectoryRole] or [SubscribedSku]  directory objects.

## Paging support <a id="PagingSupport"></a>

You can page forward and backward in the Graph. A response that contains paged results will include a skip token (**odata.nextLink**) that allows you to get the next page of results. This skip token can be combined with a **previous-page=true** query argument to page backwards.

The follow example request demonstrates paging forward:

|Request|Description|
|---|---|
|`https://graph.windows.net/contoso.com/users?$top=5&api-version=2013-11-08&$skiptoken=X'4453707402.....0000'`|The **$skiptoken** parameter from the previous response is included, and allows you to get the next page of results.|

The following example request demonstrates paging backward:

|Request|Description|
|---|---|
|`https://graph.windows.net/contoso.com/users?$top=5&api-version=2013-11-08&$skiptoken=X'4453707.....00000'&previous-page=true`|The **$skiptoken** parameter from the previous response is included. When this is combined with the **&previous-page=true** parameter, the previous page of results will be retrieved.|

The following steps demonstrate the request/response flow to page forward and backward:

1. A request is made to get a list of the first 10 users out of 15. The response contains a skip token to indicate the final page of 10 users.
2. To get the final 5 users, another request is made that contains the skip token returned from the previous response.
3. To page backward, a request is made using the skip token returned in step 1 and the parameter **&previous-page=true** is added to the request.
4. The response contains the previous (first) page of 10 users. In a different scenario where more pages are left, a new skip token would be returned. This new skip token can be added to the request along with **&previous-page=true** to page backward again.

The following restrictions apply to paged requests:

- The default page size is 100. The maximum page size is 999.
- Queries against roles do not support paging. This includes reading role objects themselves as well as role members.
- Resource listing, such as a search for all users in a tenant (**/users**), queries do support paging. For example: `https://graph.windows.net/contoso.com/users?api-version=1.6`. However, across all types when a filter is applied, paging is not supported and only the first page of results is returned.
- Paging is not supported for link searches, such as for querying group members. For example: `https://graph.windows.net/contoso.com/groups/3f575eef-bb04-44a5-a9af-eee9f547e3f9/$links/members?api-version=1.6`.

## Sort order <a id="SortOrder"></a>

- The result set of a query for all users is ordered by the **UserPrincipalName** property. For example: `https://graph.windows.net/contoso.com/users?api-version=1.6`.
- The result set of a query for all other top-level resources, such as Groups, Contacts, etc. is ordered by the **objectId** property. For example: `https://graph.windows.net/contoso.com/groups?api-version=1.6`.
- The order of the results of queries other than for top-level resources is indeterminate.

##Common queries <a id="CommonQueries"></a>
The following sections show some examples of common queries you can perform with the Graph API.
###Querying top-level resources

The following queries demonstrate how to access top-level resources with the Graph API using contoso.com as the example tenant. Note that an Authorization header containing a valid bearer token received from Azure AD will be required to run queries against a tenant. 

Top-Level Resource | Query Results | URI (for contoso.com)
--------------|--------------------|-------------------------
Top-level resources | Returns URI list of the top-level resources for directory services (also listed below) | `https://graph.windows.net/contoso.com?api-version=1.6`
Company information | Returns company information | `https://graph.windows.net/contoso.com/tenantDetails?api-version=1.6`
Contacts | Returns organizational contact information | `https://graph.windows.net/contoso.com/contacts?api-version=1.6`
Users | Returns user information | `https://graph.windows.net/contoso.com/users?api-version=1.6`
Groups | Returns group data | `https://graph.windows.net/contoso.com/groups?api-version=1.6`
Directory Roles | Returns all activated directory roles in the tenant | `https://graph.windows.net/contoso.com/directoryRoles?api-version=1.6`
SubscribedSkus | Returns the tenant's subscriptions | `https://graph.windows.net/contoso.com/subscribedSkus?api-version=1.6`
Directory metadata | Returns a Service Metadata Document that describes the data model (that is, structure and organization of directory resources) | `https://graph.windows.net/contoso.com/$metadata?api-version=1.6`

###Other query operations

The following table shows some additional example Graph API queries using contoso.com as the example tenant.

Query Operation | URI (for contoso.com)
------------|----------------
List all Users and Groups | `https://graph.windows.net/contoso.com/users?api-version=1.6` <br/> <br/> `https://graph.windows.net/contoso.com/groups?api-version=1.6`
Retrieve individual User by specifying the objectId or userPrincipalName | `https://graph.windows.net/contoso.com/users/d1f67a6c-02c9-4fe5-81fb-58160ce24fe5?api-version=1.6` <br/> <br/> `https://graph.windows.net/contoso.com/users/admin@contoso.com?api-version=1.6`
Request and Filter for a user with displayName equal to “Jon Doe” | `https://graph.windows.net/contoso.com/users?$filter=displayName eq 'Jon Doe'&api-version=1.6`
Request and Filter for specific users with firstName equal to “Jon” | `https://graph.windows.net/contoso.com/users?$filter=givenName eq 'Jon'&api-version=1.6`
Filter for givenName and surname values. | `https://graph.windows.net/contoso.com/users?$filter=givenName eq 'Jon' and surname eq 'Doe'&api-version=1.6`
Retrieve individual group by specifying the objectId | `https://graph.windows.net/contoso.com/groups/06790a81-0382-434c-b40e-216fa41bda21?api-version=1.6`
Retrieve a user’s manager | `https://graph.windows.net/contoso.com/users/John.Smith@contoso.com/manager?api-version=1.6`
Retrieve a user’s direct reports list | `https://graph.windows.net/contoso.com/users/3c4a09b0-a7b6-444e-9702-96983635a66e/directReports?api-version=1.6`
Retrieve a list of links to a user’s direct reports | `https://graph.windows.net/contoso.com/users/3c4a09b0-a7b6-444e-9702-96983635a66e/$links/directReports?api-version=1.6`
Retrieve membership list of a group | `https://graph.windows.net/contoso.com/groups/3f575eef-bb04-44a5-a9af-eee9f547e3f9/members?api-version=1.6`
Retrieve a list of links to the members of a group. | `https://graph.windows.net/contoso.com/groups/3f575eef-bb04-44a5-a9af-eee9f547e3f9/$links/members?api-version=1.6`
Retrieve a user’s group membership (not transitive) | `https://graph.windows.net/contoso.com/users/ee6308f6-646a-4845-a4e1-57ac96ccc0c8/memberOf?api-version=1.6`
Retrieve a list of the groups that the user is a member of (not transitive) | `https://graph.windows.net/contoso.com/users/ee6308f6-646a-4845-a4e1-57ac96ccc0c8/$links/memberOf?api-version=1.6`
Request and filter for groups with displayName >= "az" and <= "dz" | `https://graph.windows.net/contoso.com/groups?$filter=displayName ge 'az' and displayName le 'dz'&api-version=1.6`
Return all local account users in an Azure Active Directory B2C tenant | `https://graph.windows.net/contoso.com/users?filter=creationType eq 'LocalAccount'&api-version=1.6`
Return local account user with the sign-in name "joe@example.com" from an Azure Active Directory B2C tenant | `https://graph.windows.net/contoso.com/users?$filter=signInNames/any(x:x/value eq 'joe@example.com')&api-version=1.6`

**Note**: White space in the query string should be URL-encoded before sending a request. For example, the following query string, `https://graph.windows.net/contoso.com/users?$filter=displayName eq 'Jon Doe'&api-version=1.6`, should be URL encoded as: `https://graph.windows.net/contoso.com/users?$filter=displayName%20eq%20'Jon%20Doe'&api-version=1.6`.

## Additional resources <a id="AdditionalResources"></a>

- [Azure AD Graph API differential query](./azure-ad-graph-api-differential-query.md)
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

