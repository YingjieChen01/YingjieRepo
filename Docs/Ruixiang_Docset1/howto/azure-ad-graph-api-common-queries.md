---
title: Azure AD Graph API Common Queries
author: JimacoMS
ms.TocTitle: Common Queries
ms.ContentId: 3127ec71-aca0-4fe2-9f67-a1f7bd81599e
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

#Graph API Common Queries

This topic shows some common queries that can be performed with the Azure AD Graph API. For more information about supported operations when querying the Graph, see Supported Queries, Filters, and Paging Options in Azure AD Graph API.

- [Addressing](#Addressing)
- [Querying Top-Level Resources](#QueryingTop-LevelResources)
- [Query Operations](#QueryOperations)

**Important**: Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

##Addressing

The queries below all address the tenant using a domain name. You can replace contoso.com with one of your tenant’s registered domain names, with your tenant's ID (GUID), or with the `MyOrganization` alias (for delegated access). For information about other ways of addressing the tenant, see Addressing Entities and Operations in the Graph API.

##Querying Top-Level Resources

The following common queries demonstrate how to access top-level resources with the Graph API using contoso.com as the example tenant. Note that an Authorization header containing a valid bearer token received from Azure AD will be required to run queries against a tenant. 

Top-Level Resource | Query Results | URI (for contoso.com)
--------------|--------------------|-------------------------
Top-level resources | Returns URI list of the top-level resources for directory services (also listed below) | `https://graph.windows.net/contoso.com?api-version=1.6`
Company information | Returns company information | `https://graph.windows.net/contoso.com/tenantDetails?api-version=1.6`
Contacts | Returns organizational contact information | `https://graph.windows.net/contoso.com/contacts?api-version=1.6`
Users | Returns user information | `https://graph.windows.net/contoso.com/users?api-version=1.6`
Groups | Returns group data | `https://graph.windows.net/contoso.com/groups?api-version=1.6`
Directory Roles | Returns all activated directory roles in the tenant | `https://graph.windows.net/contoso.com/roles?api-version=1.6`
SubscribedSkus | Returns the tenant's subscriptions | `https://graph.windows.net/contoso.com/subscribedSkus?api-version=1.6`
Directory metadata | Returns a Service Metadata Document that describes the data model (that is, structure and organization of directory resources) | `https://graph.windows.net/contoso.com/$metadata?api-version=1.6`

##Query Operations

The following table shows some example Graph API queries using using contoso.com as the example tenant.

Query Operation | URI (for contoso.com)
------------|----------------
List all Users and Groups | `https://graph.windows.net/contoso.com/users?api-version=1.6` <br/> <br/> `https://graph.windows.net/contoso.com/groups?api-version=1.6`
Retrieve individual User by specifying the objectId or userPrincipalName | `https://graph.windows.net/contoso.com/users/d1f67a6c-02c9-4fe5-81fb-58160ce24fe5?api-version=1.6` <br/> <br/> `https://graph.windows.net/contoso.com/users/admin@contoso.com?api-version=1.6`
Request and Filter for a user with displayName equal to “Jon Doe” | `https://graph.windows.net/contoso.com/Users?$filter=displayName eq 'Jon Doe'&api-version=1.6`
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

**Note**: White space in the query string should be URL-encoded before sending a request. For example, the following query string, `https://graph.windows.net/contoso.com/Users?$filter=displayName eq 'Jon Doe'&api-version=1.6`, should be URL encoded as: `https://graph.windows.net/contoso.com/Users?$filter=displayName%20eq%20'Jon%20Doe'&api-version=1.6`.
