---
title: Azure AD Graph API Operations Overview 
author: JimacoMS
ms.TocTitle: Operations overview
ms.ContentId: 840d87e5-a6bb-41f5-bb83-76073145916f
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Operations overview | Graph API concepts

The Azure Active Directory (AD) Graph API is an OData 3.0 compliant service that you can use to read and modify objects such as users, groups, and contacts in a tenant. Azure AD Graph API exposes REST endpoints that you send HTTP requests to in order to perform operations using the service. The following sections provide general information about how to format requests and what to expect in responses when you use the Graph API to read and write directory resources, call directory functions or actions, or perform queries against the directory. For more detailed information about performing specific operations directory resources, see the appropriate operations topic in the [Azure AD Graph API reference](../api/api-catalog.md).

A successful request to the Graph API must be addressed to a valid endpoint and be well-formatted, that is, it must contain any required headers and, if necessary, a JSON payload in the request body. The app making the request must include a token received from Azure AD that proves that it is authorized to access the resources targeted by the request. The app must be able to handle any responses received from the Graph API. 

The sections in this topic will help you understand the format of requests and responses used with the Graph API.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.


## Authentication and authorization <a id="AuthenticationAndAuthorization"> </a>
Every request to the Graph API must have a bearer token issued by Azure Active Directory attached. The token carries information about your app, the signed-in user (in the case of delegated permissions), authentication, and the operations on the directory that your app is authorized to perform. This token is carried in the **Authorization** header of the request. For example (the token has been shortened for brevity):

```no-highlight
Authorization: Bearer eyJ0eX ... FWSXfwtQ
```

The Graph API performs authorization based on OAuth 2.0 permission scopes present in the token. For more information about the permission scopes that the Graph API exposes, see [Graph API Permission Scopes](../api/graph-api-permission-scopes.md).

In order for your app to authenticate with Azure AD and call the Graph API, you must add it to your tenant and configure it to require permissions (OAuth 2.0 permission scopes) for Windows Azure Active Directory. For information about adding and configuring an app, see [Integrating Applications with Azure Active Directory](https://azure.microsoft.com/documentation/articles/active-directory-integrating-applications/).

Azure AD uses the OAuth 2.0 authentication protocol. You can learn more about OAuth 2.0 in Azure AD, including supported flows and access tokens in [OAuth 2.0 in Azure AD](https://msdn.microsoft.com/en-us/library/azure/dn645545.aspx).

## Endpoint addressing <a id="EndpointAddressing"></a>
To perform operations with the Graph API, you send HTTP requests with a supported method - typically GET, POST, PATCH, PUT, or DELETE -- to an endpoint that targets the service, a resource collection, an individual resource, a navigation property of a resource, or a function or action exposed by the service. Endpoints are expressed as URLs.

The following describes the basic format of a Graph API endpoint:

```no-highlight
https://graph.windows.net/{tenant_id}/{resource_path}?{api_version}
```

The following components comprise the URL:

- **Service Root**: The service root for all Graph API requests is `https://graph.windows.net`.
- **[Tenant Identifier {tenant_id}](#TenantIdentifier)**: The identifier for the tenant that the request targets.  
- **[Resource path {resource_path}](#ResourcePath)**: The path to the resource -- for example, a user or a group -- that the request targets.
- **[Graph API Version {api_version}](#GraphApiVersion)**: The version of the Graph API targeted by the request. This is expressed as a query parameter and is required.

**Note**: In some cases, when reading resource collections, OData query parameters can be added to the request to filter, order, and page the result set. For more information, see the [OData query parameters](#OdataQueryParameters) section in this topic. 


### Tenant identifier {tenant_id} <a id="TenantIdentifier"></a>

You can specify the target tenant of a request in one of four ways:

- **By tenant object ID**. The GUID that was assigned when the tenant was created. This can be found in the **objectId** property of the [TenantDetail] object. The following URL shows how to address the users resource collection by using the tenant object ID: <br/>`https://graph.windows.net/12345678-9abc-def0-1234-56789abcde/users?api-version=1.6`.

- **By verified (registered) domain name**. One of the domain names that are registered for the tenant. These can be found in the **verifiedDomains** property of the [TenantDetail] object. The following URL shows how to address the users resource collection of a tenant that has the domain contoso.com: <br/>`https://graph.windows.net/contoso.com/users?api-version=1.6`.

- **By using the `myOrganization` alias**. This alias is only available when using OAuth Authorization Code Grant type (3-legged) authentication; that is, when using a delegated permission scope. The alias is not case sensitive. It replaces the object ID or tenant domain in the URL. When the alias is used, Graph API derives the tenant from the claims presented in the token attached to the request. The following URL shows how to address the users resource collection of a tenant using this alias: <br/> `https://graph.windows.net/myorganization/users?api-version=1.6`.

- **By using the `me` alias**. This alias is only available when using OAuth Authorization Code Grant type (3-legged) authentication; that is, when using a delegated permission scope. The alias is not case sensitive. It replaces the object ID or tenant domain in the URL. When the alias is used, Graph API derives the user from the claims presented in the token attached to the request. The following URL to address the signed-in user using this alias: <br/>`https://graph.windows.net/me?api-version=1.6`.

**Note**: You use `me` alias solely to target operations against the signed-in user. For more information, see [Signed-in User Operations](../api/signed-in-user-operations.md).

###Resource path {resource_path} <a id="ResourcePath"></a>

You specify the `{resource_path}` differently depending on whether you are targeting a resource collection, an individual resource, a navigation property of a resource, a function or action exposed on the tenant, or a function or action exposed on a resource. 

| Target | Path | Explanation |
|--------|------|-------------|
|Service Metadata|`/$metadata`|Returns the service metadata document. The following example targets service metadata using the contoso.com tenant:  <br/>`https://graph.windows.net/contoso.com/$metadata?api-version=1.6` <br/><br/> **Note**: No authentication is necessary to read the service metadata. |
|Resource collection | `/{resource_collection}`|Targets a resource collection, such as users or groups in the tenant. You can use this path to read resources in the collection, and, depending on the resource type, to create a new resource in the tenant. In many cases the result set returned by a read can be further refined by the addition of query parameters to filter, order, or page the results. The following example targets the user collection: <br/> `https://graph.windows.net/myorganization/users?api-version=1.6`|
|Single resource| `/{resource_collection}/{resource_id}`|  Targets a specific resource in a tenant, such as a user, organizational contact, or group. For most resources the `resource_id` is the object ID. Some resources allow additional specifiers; for example, users can be also specified by user principal name (UPN). Depending on the resource, you can use this path to get the declared properties of the resource, to modify its declared properties, or to delete the resource. The following example targets the user john@contoso.com:  <br/>`https://graph.windows.net/contoso.com/users/john@contoso.com?api-version=1.6` |
|Navigation property (objects) | `/{resource_collection}/{resource_id}/{property_name}`|  Targets a navigation property of a specific resource, such as a user's manager or group memberships, or a group's members. You can use this path to return the object or objects referenced by the target navigation property. The following example targets the manager of john@contoso.com: <br/>`https://graph.windows.net/contoso.com/users/john@contoso.com/manager?api-version=1.6` <br/><br/>**Note**: This form of addressing is only available for reads.|
|Navigation property (links) | `/{resource_collection}/{resource_id}/$links/{property_name}`|  Targets a navigation property of a specific resource, such as a user's manager or group memberships, or a group's members. You can use this form of addressing to both read and modify a navigation property. On reads, the objects referenced by the property are returned as one or more links in the response body. On writes, the objects are specified as one or more links in the request body. The following example targets the manager property of john@contoso.com:  <br/>`https://graph.windows.net/contoso.com/users/john@contoso.com/$links/manager?api-version=1.6` |
|Functions or actions exposed on the tenant | `/{function_name}`|Targets a function or action exposed at the tenant. Functions and actions are typically invoked with a POST Request and may include a request body. The following example targets the [isMemberOf] function: <br/>`https://graph.windows.net/myorganization/isMemberOf?api-version=1.6`. | 
|Functions or actions exposed on a resource. | `/{resource_collection}/{resource_id}/{function_name}`| Targets a function or action exposed on a resource. Functions and actions are typically invoked with a POST Request and may include a request body. The following example targets the [getMemberGroups] function: <br/>`https://graph.windows.net/myorganization/users/john@contoso.com/getMemberGroups?api-version=1.6`.| 

### Graph API version {api-version} <a id="GraphApiVersion"></a>
You use the `api-version` query parameter to target a specific version of the Graph API for an operation. This parameter is required. 

The value for the `api-version` parameter can be one of the following:

- "beta"
- "1.6" 
- "1.5" 
- "2013/11/08"
- "2013/04/05"

For example the following URL targets the user collection using Graph API version 1.6:

```no-highlight
https://graph.windows.net/myorganization/users?api-version=1.6
```

For more information about versions and feature changes between versions, see [Versioning](./azure-ad-graph-api-versioning.md).

## OData query parameters <a id="OdataQueryParameters"></a>

In many cases when you read a collection of resources, you can filter, sort, and page the result set by attaching OData query parameters to your request. 
 
The Graph API supports the following Odata query parameters:

- $filter
- $batch
- $expand
- $orderby
- $top
- $skiptoken and previous-page

See [Supported Queries, Filters, and Paging Options](./azure-ad-graph-api-supported-queries-filters-and-paging-options.md) for more information about supported OData query parameters and their limitations in the Graph API.

## Request and response headers <a id="RequestAndResponseHeaders"></a>
The following table shows common HTTP headers used in requests with the Graph API. It is not meant to be comprehensive. 

Request Header | Description
---------|----------------
Authorization | Required. A bearer token issued by Azure Active Directory. See [Authentication and Authorization](#Authentication) in this topic for more information.
Content-Type | Required if request body is present. The media type of the content in the request body. Use application/json. Parameters may be included with the media type. <br/>**Note**: application/atom+xml and application/xml (for links) are supported but are not recommended both for performance reasons and because support for XML will be deprecated in a future release. 
Content-Length | Required if request body is present. The length of the request in bytes.



The following table shows common HTTP headers returned in responses by the Graph API. It is not meant to be comprehensive. 


Response Header | Description
---------|----------------
Content-Type | The media type of the content in the response body. The default is application/json. Requests for user thumbnail photos return image/jpeg by default.
Location | Returned in responses to POST requests that create a new resource (object) in the directory. Contains the URI of the newly created resource. 
ocp-aad-diagnostics-server-name | The identifier for the server that performed the requested operation.
ocp-aad-session-key | The key that identifies the current session with the directory service.

At a minimum, we recommend you do the following for each request:

1. Log an accurate time stamp of the request submission.
2. Send and log the `client-request-id`.
3. Log the HTTP response code and `request-id`.

Providing information in such logs will help Microsoft troubleshoot issues when you ask for help or support.

## Request and response bodies<a id="RequestAndResponseBodies"></a>
Request bodies for POST, PATCH, and PUT requests can be sent in JSON or XML payloads. Server responses can be returned in JSON or XML payloads. You can specify the payload in request bodies by using the `Content-Type` request header and in responses by using the `Accept` request header. 

**We strongly recommend that you use JSON payloads in requests and responses with the Graph API. This is both for performance reasons and because XML will be deprecated in a future release.** 

## Advanced features<a id="AdvancedFeatures"></a>
The preceding sections discussed the formatting of basic requests and responses with the Graph API. More advanced features may add additional query string parameters or have significantly different request and response bodies than the basic operations discussed previously in this topic.

These features include:

- **Batch Processing**: The Graph API supports batching. Sending requests in batches reduces round trips to the server, which reduces network overhead and helps your operations complete more quickly. For more information about batch processing with the Graph API, see [Batch Processing](azure-ad-graph-api-batch-processing.md).
- **Differential Query**: The Graph API supports performing differential queries. Differential query allows you to return changes to specific entities in a tenant between requests issued at different times. This feature is often used to sync a local store with changes on the tenant. For more information about differential query with the Graph API, see [Differential Query](azure-ad-graph-api-differential-query.md).


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
[VerifiedDomain]: ../api/entity-and-complex-type-reference.md#VerifiedDomainType

[assignLicense]: ../api/functions-and-actions.md#assignLicense
[checkMemberGroups]: ../api/functions-and-actions.md#checkMemberGroups
[getAvailableExtensionProperties]: ../api/functions-and-actions.md#getAvailableExtensionProperties
[getMemberGroups]: ../api/functions-and-actions.md#getMemberGroups
[getMemberObjects]: ../api/functions-and-actions.md#getMemberObjects
[getObjectsByObjectIds]: ../api/functions-and-actions.md#getObjectsByObjectIds
[isMemberOf]: ../api/functions-and-actions.md#isMemberOf
[restore]: ../api/functions-and-actions.md#restore
