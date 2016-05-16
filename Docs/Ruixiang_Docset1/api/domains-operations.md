---
title: Azure AD Graph API operations on Domains
author: JimacoMS
ms.TocTitle: Operations on domains (preview)
ms.ContentId: 0e0a8a4e-2e9a-4ccf-aed3-ef513a7a1da6
ms.topic: reference (API)
ms.date: 01/26/2016
---



# Operations on domains (preview) | Graph API reference

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
This topic discusses how to perform operations on domains using the Azure Active Directory (AD) Graph API. 

> [!IMPORTANT]
> Domain operations are currently in preview and are supported only in Azure AD Graph API version beta. 

The Graph API is an OData 3.0 compliant REST API that provides programmatic access to directory objects in Azure Active Directory, such as users, groups, organizational contacts, and applications. 

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token. Note that domain operations are not currently supported in Microsoft Graph; you will need to use Azure AD Graph API for this feature.

## Performing REST operations on domains

To perform operations on domains with the Graph API, you send HTTP requests with a supported method (GET, POST, PATCH, PUT, or DELETE) to an endpoint that targets the domains resource collection, a specific domain, a navigation property of a domain, or a function or action that can be called on a domain. 


Graph API requests use the following basic URL:
```no-highlight
https://graph.windows.net/{tenant_id}/{resource_path}?{api_version}[odata_query_parameters]
```

> [!IMPORTANT]
> Requests sent to the Graph API must be well-formed, target a valid endpoint and version of the Graph API, and carry a valid access token obtained from Azure AD in their `Authorization` header. For more detailed information about creating requests and receiving responses with the Graph API, see [Operations Overview].

You specify the `{resource_path}` differently depending on whether you are targeting the collection of all domains in your tenant, an individual domain, or a navigation property of a specific domain. 

- `/domains` targets the domains resource collection. You can use this resource path to read all domains or a filtered list of domains in your tenant or to create one or more new domains in your tenant. 
- `/domains({domain_name})` targets an individual domain in your tenant. You specify the `domain-name` as the fully qualified domain name of the target domain enclosed in single quotes. You can use this resource path to get the declared properties of a domain, to modify the declared properties of a domain, or to delete a domain. 
- `/domains({domain_name})/{nav_property}` targets the specified navigation property of a domain. You can use it to return the object or objects referenced by the target navigation property of the specified domain. **Note**: This form of addressing is only available for reads. 
- `/domains({domain_name})/$links/{nav_property}` targets the specified navigation property of a domain. You can use this form of addressing to both read and modify a navigation property. On reads, the objects referenced by the property are returned as one or more links in the response body. On writes, the objects are specified as one or more links in the request body. 

For example, the following request returns a link to the specified domain's service configuration records:

```no-highlight
GET https://graph.windows.net/myorganization/domains('contoso.com')/serviceConfigurationRecords?api-version=beta
```

**Important**: Operations on domains are supported only in version beta.


## Basic operations on domains (preview) <a id="BasicDomainOperations"> </a>
You can perform basic create, read, update, and delete (CRUD) operations on domains and their declared properties by targeting either the domain resource collection or a specific domain. The following topics show you how.

The Graph API supports operations on groups as follows:

- Create (POST): Unverified and verified domains.
- Read (GET): all domains.
- Update (PATCH): Verified domains only. Not all properties are supported.
- Delete (DELETE): all domains.


****

### Get domains (preview) <a id="GetDomains"> </a>
Gets a collection of domains. You can add OData query parameters to the request to filter, sort, and page the response. For more information, see [Supported Queries, Filters, and Paging Options in Azure AD Graph API](https://msdn.microsoft.com/en-us/library/azure/dn727074.aspx).

On success, returns a collection of [Domain] objects; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Domains",
    "operation":    "get domains", 
     "showComponents": {        
        "codeGenerator": "true",
        "tryFeature": "false"      
    } 
}
```

****

###Get a domain (preview) <a id="GetADomain"> </a>

Gets a specified domain. Specify the domain with its fully qualified domain name.

On success, returns the [Domain] object for the specified domain; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Domains",
    "operation":    "get a domain",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "false"      
    } 
}
```

****

### Create a domain (preview) <a id="CreateDomain"> </a>
Adds a domain to the tenant. The request body contains the **name** property for the new domain. This is the only property that can be specified and it is required. 

The following table shows the properties that are required when you create a domain. 
 
|**Required parameter**|**Type**|**Description**|
|:-----|:-----|:-----|
|name|string|The fully qualified domain name of the new domain; for example, "contoso.com".|

**Important**: If the domain being created is a sub-domain of an existing verified domain in the tenant, it will be created as a verified domain (**isVerified** property is **true**); otherwise, it will be created as an unverified domain (**isVerified** property is **false**).

On success, returns the newly created [Domain]; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Domains",
    "operation":    "create domain" 
}
```
****

### Update a domain (preview) <a id="UpdateDomain"> </a>

Update a domain's properties. Specify any writable [Domain] property in the request body. Only the properties that you specify are changed.

**Important**: Only verified domains can be updated.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Domains",
    "operation":    "update domain"
}
```
****

### Delete a domain (preview) <a id="DeleteDomain"> </a>

Deletes a domain. Deleted domains are not recoverable.

On success, no response body is returned; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Domains",
    "operation":    "delete domain"
}
```

****

## Operations on domain navigation properties (preview) <a id="DomainNavigationOps"> </a>

Relationships between a domain and other objects in the directory such as its verification records and service configuration records are exposed through navigation properties. You can read these relationships by targeting these navigation properties in your requests. 

### Get a domain's verification records (preview) <a id="GetDomainVerificationRecords"> </a>

Gets the domain's verification records from the **verificationDnsRecords** navigation property. 

You can’t use the domain with your Azure AD tenant until you have successfully verified that you own the domain. To verify the ownership of the domain, you need to first retrieve a set of domain verification records which you need to add to the zone file of the domain.

On success, returns a collection of [DomainDnsRecord] objects; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

**Note**: You can add the "$links" segment to the URL to return links to the [DomainDnsRecord]s.

```RESTAPIdocs
{
    "api":  "Domains",
    "operation":    "get domain verification records",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "false"      
    } 
}
```

****
### Get a domain's service configuration records (preview) <a id="GetDomainServiceConfigurationRecords"> </a>

Gets the domain's service configuration records from the **serviceConfigurationRecords** navigation property. 

After you have successfully verified the ownership of a domain and you have indicated what services you plan to use with the domain, you can request Azure AD to return you a set of DNS records which you need to add to the zone file of the domain so that the services can work properly with your domain.

On success, returns a collection of [DomainDnsRecord] objects; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

**Note**: You can add the "$links" segment to the URL to return links to the [DomainDnsRecord]s.

```RESTAPIdocs
{
    "api":  "Domains",
    "operation":    "get domain service configuration records",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "false"      
    } 
}
```

****
## Functions and actions on domains (preview) <a id="DomainFunctions"> </a>
You can call the following actions on a domain.

### verify action (preview)
You can call the [verify] action on an unverified domain (**isVerified** property is **false**) to verify the ownership of the domain.

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

[!CODE-RESTAPI_Swagger [domains_swagger2](./domains_swagger2.json)]
