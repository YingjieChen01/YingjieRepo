---
title: Azure AD Graph API Directory Schema Extensions
author: JimacoMS
ms.TocTitle: Directory schema extensions
ms.ContentId: 88e096a4-197a-4f0e-baa3-e7cbd0773d0f
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Directory schema extensions | Graph API concepts
This topic discusses directory extensions in the Azure AD Graph API, which can be used to add properties to directory objects without requiring an external data store. For example, if an organization has a line of business (LOB) application that requires a Skype Id for each user in the directory, the Graph API can be used to register a new property named skypeId on the directory’s User object, and then write a value to the new property for a specific user. This topic will help you understand the limitations of directory extensions, how they’re registered in a directory, and provide examples of how they’re used in the Graph API.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.


##Extension data types <a id="ExtensionDataTypes"> </a>
Extensions can only be registered using Graph API version 1.5 or newer. The following property types can be registered:
 
Property Type |	Remarks
--------------|----------
Binary | 256 bytes maximum.
Boolean |   
DateTime | Must be specified in ISO 8601 format. Will be stored in UTC.
Integer | 32-bit value.
LargeInteger | 64-bit value.
String | 256 characters maximum.

The property types above can be registered on the following objects in a directory:

- [User] 
- [Group]
- [TenantDetail] 
- [Device]
- [Application] 
- [ServicePrincipal]

##Understanding how an extension is registered <a id="UnderstandingRegistration"> </a>
It’s important to understand how an extension property is registered in a directory and how Azure AD’s consent model affects its registration. For more information about application consent in Azure AD, see **Overview of the Consent Framework** in [Integrating Applications with Azure Active Directory](https://azure.microsoft.com/en-us/documentation/articles/active-directory-integrating-applications/#updating-an-application).

Extension properties are registered on an [Application] object within the developer’s directory. After the application has been consented to by a user or an admin in the developer’s directory, the property is added to the target directory type and becomes immediately accessible in the developer’s directory. For a multi-tenant application, when the application is granted consent by a user or an admin in another organization, the extension properties become immediately accessible on the target directory type in the other organization’s directory.

If an organization consents to “read only” permissions for an application with registered extensions, the properties will still become accessible in the other organization’s directory. Additionally, extension properties are accessible by any consented application in an organization, not just for the application to which they are registered. Other consented applications in that organization can read or write values for the new extension property if they have sufficient permissions.

If the application is deleted or consent is removed in the other organization’s directory, the extension property becomes inaccessible on the target directory object. If the extension is deleted by the application, it also becomes inaccessible on the target directory object. If a multi-tenant application adds additional extension properties after consent was granted, these properties become immediately accessible in the other organization’s directory.

**Note**: If an extension property’s value is set on an object and that property becomes inaccessible in that object’s directory, the property still counts against that object’s limit of 100 extension property values. The only way to remove the property value from consideration once it has been set is to explicitly set it to null. You cannot do this if the extension property is inaccessible.
###Example scenario
Consider the following scenario: Litware is an independent software vendor (ISV) that has developed a SaaS application for other organizations to use, and this application requires an extension property named *skypeId* on a User object. Litware first registers the application in its own directory, and then the Graph API is called to register the extension property on the [Application] object, which makes the property accessible on User objects in Litware’s directory. Finally, Litware makes the application multi-tenant capable so that it can be used in other organizations.

Contoso wants to use Litware’s SaaS application, so a user or administrator in Contoso consents to the application. Upon consent, the application is registered in Contoso’s directory and the extension properties registered for the application by Litware immediately become available in the Contoso directory. Since the *skypeId* extension property for a User object was registered by Litware on the application, the property becomes accessible on [User] objects in Contoso’s directory. Litware’s application or other consented applications in Contoso’s directory can now access the new property according to the permissions configured for that application in Contoso’s directory. This means that applications, according to their permissions, may write a value for that extension property on one or more users in the directory. Only users for which a *skypeId* value as been written will return that property on their [User] object. This will be the case until the *skypeId* property is set to **null**, after which time the User object for that user will no longer return the property.

##Sample REST requests for directory extensions <a id="SampleRequests"> </a>

The following sample requests show you how to register, view, write, read, filter, and unregister extensions in your directory. Replace the *&ltapplicationObjectId&gt* placeholder with your registered application’s Object ID. You can get this value in the following way:

1. Go to https://graphexplorer.cloudapp.net/, click the **Sign In** link at the top-right corner, and then sign in using the credentials for an administrator account in your organization’s directory.
2. After you have signed in, click the URL in the resource text box (next to the **GET** button) and select the URL that ends in applications/ then click **GET** or click the **enter** key.
3. Find the desired application entry from the results, and then copy its **objectId** value, such as the following: "objectId": "269fc2f7-6420-4ea4-be90-9e1f93a87a64"

In this section, there are sample requests for the following operations:

- [Register an extension](#RegisterAnExtension)
- [View registered extensions](#ViewRegisteredExtensions) 
- [Write an extension value](#WriteAnExtensionValue) 
- [Remove an extension value](#RemoveAnExtensionValue) 
- [Read an extension value](#ReadAnExtensionValue) 
- [Filter an extension value](#FilterAnExtensionValue) 
- [Unregister an extension](#UnregisterAnExtension) 

For full samples that use extension properties, see the following samples in the Azure AD samples on Github:

- [WebApp-GraphAPI-DirectoryExtensions-PHP](https://github.com/AzureADSamples/WebApp-GraphAPI-DirectoryExtensions-PHP): Shows how to create and use extensions with PHP.
- [WebApp-GraphAPI-DirectoryExtensions-DotNet](https://github.com/AzureADSamples/WebApp-GraphAPI-DirectoryExtensions-DotNet): Displays an AAD tenant org chart and allows reading extension values right out of the box.

###Register an extension <a id="RegisterAnExtension"> </a>

The following sample request creates an *extensionProperty* on the desired [Application] object.

####Request format

```no-highlight
POST https://graph.windows.net/contoso.onmicrosoft.com/applications/<applicationObjectId>/extensionProperties?api-version=1.5 HTTP/1.1

{
    "name": "<extensionPropertyName>",
    "dataType": "<String or Binary>",
    "targetObjects": [
        "<DirectoryObject>"
    ]
}
```

####Sample request

```no-highlight
POST https://graph.windows.net/contoso.onmicrosoft.com/applications/269fc2f7-6420-4ea4-be90-9e1f93a87a64/extensionProperties?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eXAiOiJKV1Qi...r6Xh5KVA
Content-Type: application/json
Host: graph.windows.net
Content-Length: 104

{
    "name": "skypeId",
    "dataType": "String",
    "targetObjects": [
        "User"
    ]
}
```

If the operation was successful, it will return an HTTP 201 Created status code along with the fully-qualified extension property name, which can be used for writing values to the target type.

####Sample response

```no-highlight
HTTP/1.1 201 Created
...

{
    "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/Microsoft.WindowsAzure.ActiveDirectory.ExtensionProperty/@Element",
    "odata.type": "Microsoft.WindowsAzure.ActiveDirectory.ExtensionProperty",
    "objectType": "ExtensionProperty",
    "objectId": "dc893d45-a75b-4ccf-9b92-ce7d80922aa7",
    "name": "extension_ab603c56068041afb2f6832e2a17e237_skypeId",
    "dataType": "String",
    "targetObjects": [
        "User"
    ]
}
```

###View registered extensions <a id="ViewRegisteredExtensions"> </a>

The following sample request gets the extensions that are registered on your [Application] object.

####Request format

```no-highlight
GET https://graph.windows.net/contoso.onmicrosoft.com/applications/<applicationObjectId>/extensionProperties?api-version=1.5 HTTP/1.1
```

####Sample request

```no-highlight
GET https://graph.windows.net/contoso.onmicrosoft.com/applications/269fc2f7-6420-4ea4-be90-9e1f93a87a64/extensionProperties?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eXAiOiJKV1Qi...r6Xh5KVA
Host: graph.windows.net
```

If the operation was successful, it will return an HTTP 200 OK status code along with all the information about each extension property registered on your Application object.

####Sample response

```no-highlight
HTTP/1.1 200 OK
...

{
    "odata.metadata": "https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/Microsoft.WindowsAzure.ActiveDirectory.ExtensionProperty",
    "value": [
        {
            "odata.type": "Microsoft.WindowsAzure.ActiveDirectory.ExtensionProperty",
            "objectType": "ExtensionProperty",
            "objectId": "dc893d45-a75b-4ccf-9b92-ce7d80922aa7",
            "name": "extension_ab603c56068041afb2f6832e2a17e237_skypeId",
            "dataType": "String",
            "targetObjects": [
                "User"
            ]
        }
    ]
}
```

###Write an extension value <a id="WriteAnExtensionValue"> </a>

The following sample request writes an extension value for the *skypeId^ extension property on a [User] object.

####Request format
```no-highlight
PATCH https://graph.windows.net/contoso.onmicrosoft.com/users/username@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1

{
    "<extensionPropertyName>": <value>
}
```
####Sample request
```no-highlight
PATCH https://graph.windows.net/contoso.onmicrosoft.com/users/jim@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eXAiOiJKV1Qi...r6Xh5KVA
Content-Type: application/json
Host: graph.windows.net
Content-Length: 65

{
    "extension_ab603c56068041afb2f6832e2a17e237_skypeId": "jimbob.skype"
}
```

If the operation was successful, it will return a HTTP 204 No Content status code.
####Sample response
```no-highlight
HTTP/1.1 204 No Content
```

If the attempted write surpasses the 100 extension value limit for the object, it will return an HTTP 403 Forbidden response with an error code of “Directory_ResourceSizeExceeded” and the following message: “The size of the object has exceeded its limit. Please reduce the number of values and retry your request”.

###Remove an extension value <a id="RemoveAnExtensionValue"> </a>

The following sample request removes an extension value that was previously set for the *skypeId* extension property on a [User] object by setting the value to **null**.
####Request format
```no-highlight
PATCH https://graph.windows.net/contoso.onmicrosoft.com/users/username@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1

{
    "<extensionPropertyName>": null
}
```
####Sample request
```no-highlight
PATCH https://graph.windows.net/contoso.onmicrosoft.com/users/jim@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eXAiOiJKV1Qi...r6Xh5KVA
Content-Type: application/json
Host: graph.windows.net
Content-Length: 65

{
    "extension_ab603c56068041afb2f6832e2a17e237_skypeId": null
}
```
If the operation was successful, it will return a HTTP 204 No Content status code.
####Sample response
```no-highlight
HTTP/1.1 204 No Content
```

###Read an extension value <a id="ReadAnExtensionValue"> </a>

The following sample request performs a simple GET operation on the user, which will return the standard property values as well as the new extension property value.
####Request format
```no-highlight
GET https://graph.windows.net/contoso.onmicrosoft.com/users/username@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1
```
####Sample request
```no-highlight
GET https://graph.windows.net/contoso.onmicrosoft.com/users/jim@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eXAiOiJKV1Qi...r6Xh5KVA
Host: graph.windows.net
```

If the operation was successful, it will return an HTTP 200 OK status code along with the new extension property value (many user properties have been removed from the sample response for brevity).
####Sample response
```no-highlight
HTTP/1.1 200 OK

{
    ...
    "usageLocation": null,
    "userPrincipalName": "Jim@contoso.onmicrosoft.com",
    "userType": "Member"
    "extension_ab603c56068041afb2f6832e2a17e237_skypeId": "jimbob.skype"
}
```

###Filter an extension value <a id="FilterAnExtensionValue"> </a>

The following sample request filters the users by the specified extension property value.

**Note**: Prefix searches on extensions are limited to 71 characters for string searches and 207 bytes for searches on binary extensions.
####Request format
```no-highlight
GET https://graph.windows.net/contoso.onmicrosoft.com/users?api-version=1.5&$filter=<extensionName>%20eq%20'<value>' HTTP/1.1
```
####Sample request
```no-highlight
GET https://graph.windows.net/contoso.onmicrosoft.com/users?api-version=1.5&$filter=extension_ab603c56068041afb2f6832e2a17e237_skypeId%20eq%20'jimbob.skype' HTTP/1.1
Authorization: Bearer eyJ0eXAiOiJKV1Qi...r6Xh5KVA
Host: graph.windows.net
```

If the operation was successful, it will return an HTTP 200 OK status code, along with the resulting user object.
####Sample response
```no-highlight
HTTP/1.1 200 OK

{
    ...
    "usageLocation": null,
    "userPrincipalName": "Jim@contoso.onmicrosoft.com",
    "userType": "Member"
    "extension_ab603c56068041afb2f6832e2a17e237_skypeId": "jimbob.skype"
}
```

###Unregister an extension <a id="UnregisterAnExtension"> </a>

The following sample request unregisters an extension property by performing a DELETE operation on the extension object ID.
####Request format
```no-highlight
DELETE https://graph.windows.net/contoso.onmicrosoft.com/applications/<applicationObjectId>/extensionProperties/<extensionObjectId>?api-version=1.5 HTTP/1.1
```
####Sample request
```no-highlight
DELETE https://graph.windows.net/contoso.onmicrosoft.com/applications/269fc2f7-6420-4ea4-be90-9e1f93a87a64/extensionProperties/dc893d45-a75b-4ccf-9b92-ce7d80922aa7?api-version=1.5 HTTP/1.1
Authorization: Bearer eyJ0eXAiOiJKV1Qi...r6Xh5KVA
Host: graph.windows.net
```
If the operation was successful, it will return an HTTP 204 No Content status code, and the extension property will be unregistered on the application.
####Sample response
```no-highlight
HTTP/1.1 204 No Content
```

##Extension behavior and limitations <a id="ExtensionBehavior"> </a>

The following behavior and limitations apply to extension properties in a directory:

- Extension properties registered for an application become available in a directory when a directory user or admin consents for the application.

- After an extension property becomes available in a directory, any consented application may read or write a value for that extension property for any of the objects for which that property applies according to that application’s permissions in the directory. The objects for which the extension property applies are specified in the targetObjects property.

- A maximum of 100 extension property values may be written on a specific object in a directory. For example, assuming no other extension property values have been written on any user in a directory, if an application writes an extension property value to user1, then values for 99 other extension properties may be written to user1 by that application or another application with appropriate permissions in the directory; however, other users in the directory will still be able to have up to 100 extension property values written to them.

- If an application tries to set a value for an additional extension property on an object for which 100 extension property values have already been set, Graph API returns a **403 Forbidden** response with an error code of “Directory_ResourceSizeExceeded” and the following message: “The size of the object has exceeded its limit. Please reduce the number of values and retry your request”.

- If a developer unregisters (deletes) an extension property from an application, that extension property immediately becomes inaccessible in the developer directory and also in directories for which the application has been granted consent.

- If the application is removed from the developer directory, all extension properties registered to that application immediately become inaccessible in the developer directory and in directories in which that application has been granted consent.

- If an multi-tenant application has been granted consent in a directory and that application is later unregistered (removed) from that directory -- for example, by an administrator using the azure management portal -- then any extension properties registered on that application immediately become inaccessible in that directory.

- An extension property value must be explicitly set to **null** in order to be removed from a directory object. If an extension property value is set on a directory object and that extension property becomes inaccessible in the directory for any of the reasons cited above, then the extension property will no longer be visible on that directory object. It will, however, still count against the 100 extension property value limit for that object. Until the availability of the extension property is restored -- for example, in some cases, by consenting to the application again -- the value will not be accessible for either read or write.

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

