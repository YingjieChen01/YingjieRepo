---
title: Azure AD Graph API Permission Scopes
author: JimacoMS
ms.TocTitle: Permission scopes
ms.ContentId: 0a73d49a-00e2-4933-a5c7-4cf580044a48
ms.topic: reference (API)
ms.date: 01/26/2016
---


# Permission scopes | Graph API concepts

 _**Applies to:** Graph API | Azure Active Directory_

The Graph API exposes OAuth 2.0 permission scopes that are used to control access that an app has to customer directory data. As a developer, you configure your app with the permission scopes appropriate to the access that it requires. Typically you do this through the Azure portal. During sign-in, users or administrators are given an opportunity to consent to allow your app access to their directory data with the permission scopes you configured. For this reason, you should choose permission scopes that provide the least level of privilege needed by your app. For more details on how to configure permissions for your app and on the consent process, see [Integrating Applications with Azure Active Directory](https://azure.microsoft.com/documentation/articles/active-directory-integrating-applications/).

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

##Permission scope concepts <a id="PermissionScopeConcepts"></a>

###App-only vs. delegated scopes
Permission scopes can be either app-only or delegated. App-only scopes  (also known as app roles) grant the app the full set of privileges offered by the scope. App-only scopes are typically used by apps that run as a service without a signed-in user being present. Delegated permission scopes are for apps that a user signs in to. These scopes delegate the privileges of the signed-in user to the app, allowing the app to act as the signed in user. The actual privileges granted to the app will be the least privileged combination (the intersection) of the privileges granted by the scope and those possessed by the signed-in user. For example, if the permission scope grants delegated privileges to write all directory objects, but the signed-in user has privileges only to update their own user profile, the app will only be able to write the signed-in user's profile but no other objects.

###Full and basic profiles for users and groups
The full profile (or profile) of a [User](../api/entity-and-complex-type-reference.md#UserEntity) or a [Group](../api/entity-and-complex-type-reference.md#GroupEntity) includes all of the entity's declared properties. Because the profile may contain sensitive directory information or personally identifiable information (PII), several scopes constrain app access to a limited set of properties known as a basic profile. For users, the basic profile includes only the following properties: display name, first and last name, photo, and email address. For groups, the basic profile contains only the display name. 

##Permission scope details <a id="PermissionScopeDetails"></a>
   
 The following table lists the Graph API permission scopes and explains the access granted by each. 

- The **Scope** column lists the scope name. Scope names take the form resource.operation.constraint; for example, Group.ReadWrite.All. If the constraint is "All", the scope grants the app the ability to perform the operation (ReadWrite) on all of the specified resources (Group) in the directory; otherwise, the scope only permits the operation on the profile of the signed-in user. Scopes may grant limited privileges for the specified operation, see the **Description** column for details.
- The **Permission** column shows how the scope is displayed on the Azure  portal. 
- The **Description** column describes the full set of privileges granted by the scope. For delegated scopes, the actual access granted to the app will be the least privileged combination (intersection) of the access granted by the scope and the privileges of the signed-in user. 


| Scope | Permission | Description | Scope Type | Requires Administrator Consent
|:----|:-----------|:------------|:-----------------------------
| User.Read | Enable sign-in and read user profile | Allows users to sign in to the app and allows the app to read the full profile of the signed-in user. The full profile includes all of the declared properties of the [User](../api/entity-and-complex-type-reference.md#UserEntity) entity. The app cannot read navigation properties, such as manager or direct reports. Also allows the app to read the following basic company information of the signed-in user (through the [TenantDetail](../api/entity-and-complex-type-reference.md#TenantDetailEntity) object): tenant ID, tenant display name, and verified domains. | delegated | No
| User.ReadBasic.All | Read all users' basic profiles | Allows the app to read the basic profile of all users in the organization on behalf of the signed-in user. The following properties comprise a user’s basic profile: display name, first and last name, photo, and email address. To read the groups that a user is a member of, the app will also require Group.Read.All or Group.ReadWrite.All. | delegated  | No
| User.Read.All | Read all users' full profiles | Same as User.ReadBasic.All, except that it allows the app to read the full profile of all users in the organization and when reading navigation properties like manager and direct reports. The full profile includes all of the declared properties of the [User](../api/entity-and-complex-type-reference.md#UserEntity) entity. To read the groups that a user is a member of, the app will also require either Group.Read.All or Group.ReadWrite.All.	| delegated | Yes
| Group.Read.All | Read all groups (preview) | Allows the app to read the basic profile of all groups in the organization on behalf of the signed-in user. The app can also read the basic profile of the groups that a group is a member of. The basic profile for a group includes only the group’s display name. To read the profile information of a group’s members, the app will also require either User.ReadBasic or User.Read.All. | delegated  | Yes
| Group.ReadWrite.All | Read and write all groups (preview) | Allows the app to read the full profile of all groups in the organization, as well as to create and update groups on behalf of the signed-in user. The app can also read the full profile of the groups that a group is a member of. The full profile includes all of the declared properties of the [Group](../api/entity-and-complex-type-reference.md#GroupEntity) entity. To read the profiles of or update a group’s members, the app will also require either User.ReadBasic or User.Read.All. | delegated  | Yes
| Device.ReadWrite.All | Read and write all devices | Allows the app to read and write all device properties without a signed in user.  Does not allow device creation, device deletion, or update of device alternative security identifiers. | app-only | Yes
| Directory.Read.All | Read directory data | Allows the app to read all of the data in the organization's directory, such as users, groups, and apps, and their associated navigation properties. **Note**: Users may consent to applications that require this permission if the application is registered in their own organization’s tenant. | app-only, delegated | Yes
| Directory.ReadWrite.All | Read and write directory data | Allows the app to read all of the data in the organization's directory. Allows the app to create and update users and groups, and update their navigation properties, but prohibits user or group deletion. Also allows the app to define schema extensions on applications. For a detailed list of privileges, see  [Directory.ReadWrite.All privileges detail](#DirectoryRWDetail) below. | app-only, delegated | Yes
| Directory.AccessAsUser.All | Access directory as the signed-in user | Allows the app the same access to data in the organization's directory as the signed-in user. **Note**: A native client app can have the user consent to this permission however, a web app requires administrator consent. | delegated | Yes


**Note**: By default, when you create an app using the Azure portal, Azure AD assigns it a delegated permission scope of User.Read.

###Directory.ReadWrite.All privileges detail <a id="DirectoryRWDetail"> </a>
The Directory.ReadWrite.All permission scope grants the following privileges:

- Full read of all directory objects (both declared properties and navigation properties)
- Create and update users
- Disable and enable users (but not company administrator)
- Set user alternative security id (but not administrators)
- Create and update groups
- Manage group memberships
- Update group owner
- Manage license assignments
- Define schema extensions on applications
- **Note**: No rights to reset user passwords
- **Note**: No rights to delete entities (including users or groups)
- **Note**: Specifically excludes create or update for entities not listed above. This includes: Application, Oauth2PermissionGrant, AppRoleAssignment, Device, ServicePrincipal, TenantDetail, domains, etc.


##Permission scope scenarios <a id="PermissionScopeScenarios"></a>

The following table shows the permission scopes needed for an app to be able to perform specific operations. Note that in some cases the ability of the app to perform some operations will depend on whether the permission scope is app-only or delegated, and, in the case of delegated permission scopes, on the privileges of the signed-in user. 

| Scenario | Access Required | Permission Scope Needed
|:----------|:--------------|:-----------------|
| Sign-in and show a tile with the user's name and thumbnail photo. | Read full profile of the signed-in user. <br/> Read basic company information. | User.Read | 
| Basic people picker. | Read basic profile of all users on behalf of the signed-in user. | User.ReadBasic.All | 
| People picker with full profile. | Same as above but access to full profile of users on behalf of the signed-in user. | User.Read.All | 
| Org chart navigator. | Read full profile of all users, their managers, and direct reports on behalf of the signed-in user. | User.Read.All | 
| People picker that includes groups for access control to your app. <br/> <br/> Group and membership viewer. | Read basic profile of all groups and users on behalf of the signed-in user. <br/> Read basic user profiles for users' manager and direct reports. <br/> Read basic profile of users' group memberships. <br/> Read basic profile of groups' group memberships. <br/> Read basic profile of groups' members | User.ReadBasic.All and Group.Read.All | 
| Show the profile of the signed-in user and the user's manager, direct reports, and group memberships. | Use [`me`](../api/signed-in-user-operations.md) operations to read: <br/> The full profile of the signed-in user. <br/> The full profile of the signed-in user's manager and direct reports. <br/> The basic profile of the groups that the signed-in user is a member of. <br/> <br/> **Note**: The combination of the two scopes grants more access than that noted here for `me` operations.  | User.Read.All and Group.Read.All |
| Group management service that allows users to create and manage groups. | Read full profile of all groups and users on behalf of the signed-in user. <br/> Read full profiles for users' manager and direct reports. <br/> Read full profile of users' group memberships. <br/> Read full profile of groups' group memberships. <br/> Read full profile of groups' members. <br/> Create and update groups and their navigation properties (members). | User.Read.All and Group.ReadWrite.All |
|  | Read all directory objects (including navigation properties). | Directory.Read.All | 
|  | Read all directory objects (including navigation properties). <br/> Create and update user and group objects. <br/> No user or group deletion. <br/> <br/> **Note**: Not all privileges granted are listed here. | Directory.ReadWrite.All | 
| Act as the signed-in user. | Read and write directory objects (including navigation properties) on behalf of the signed-in user. | Directory.AccessAsUser.All | 

##Default access for administrators, users, and guest users <a id="DefaultAccess"></a>
The following table lists the default access of (global) administrators, users, and guest users in the directory. The default access may be further augmented or restricted based on configuration settings for the directory and/or a user's membership in one or more directory roles. For more detailed information about configuring the access of users and guest users to directory data, see [Create or edit users in Azure AD](https://azure.microsoft.com/documentation/articles/active-directory-create-users/). For more information about the access associated with various directory roles, see [Assigning administrator roles in Azure AD](https://azure.microsoft.com/documentation/articles/active-directory-assign-admin-roles/). 

| User Type | Access | 
|:----|:-----------|
| Global Administrator | Read all directory objects. <br/> Create, Update, and Delete all directory objects |
| User | Read all directory objects. <br/> Create applications and associated service principals. <br/> Update their profile. <br/> Update groups that they own (and the members property). <br/> Update applications and service principals that they own. <br/> Delete applications and service principals that they own. | 
| Guest User | Read their full profile. <br/> Read the basic profiles of all other users <br/> Read basic profile of all groups. <br/> Read applications. <br/> Update some properties of their profile. <br/> No user or group search (see [User and group search limitations for guest users](#SearchLimits) below). |

###User and group search limitations for guest users <a id="SearchLimits"> </a>
User and group search capabilities allow the app to search for any user or group in the customer directory by performing queries against the **users** or **groups** resource set (for example, `https://graph.windows.net/myorganization/users?api-version=1.6`). Both administrators and users have this capability. Guest users do not. If the signed-in user is a guest user, depending on the permission scope, an app can read the profile of a specific user or group by using the object ID or user principal name (UPN) for a user or the object ID for a group (for example, `https://graph.windows.net/myorganization/users/241f22af-f634-44c0-9a15-c8cd2cea5531?api-version=1.6`); however, it cannot perform queries against the **users** or **groups** resource set that potentially request more than one entity. For example, depending on the permission scope, the app can read the profiles of users or groups that it obtains by following links in navigation properties, but it cannot issue a query to return all users or groups in the directory.  


##Additional resources <a id="AdditionalResources"></a>

- [Azure AD Graph API reference](../api/api-catalog.md)
