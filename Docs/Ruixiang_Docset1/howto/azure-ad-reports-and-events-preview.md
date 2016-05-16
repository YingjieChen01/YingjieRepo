---
title: Azure AD Reports and Events (Preview)
author: JimacoMS
ms.TocTitle: Reports and events (preview)
ms.ContentId: 6a27680a-3088-4bde-aae2-bc347aad20af
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Reports and events (preview) | Graph API concepts

Applies To: Azure AD Graph API

## Overview and prerequisites

The Azure AD Reports and Events REST API Preview provides read-only access to the access and usage reporting data maintained within an Azure AD tenant.  Please refer to the article [View your access and usage reports](http://azure.microsoft.com/documentation/articles/active-directory-view-access-usage-reports/) for an overview of the available report types, and information on accessing the reporting feature in the related Azure Management Portal user interface.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token. Note that reports and events are not currently supported in Microsoft Graph; you will need to use Azure AD Graph API for these features. 

Familiarity with Azure AD authentication and application configuration is also necessary before using the Reports and Events API Preview.  If you are unfamiliar with the concepts associated with Azure AD authentication, and/or the ability to grant permissions to an application to allow access to your tenant, please review the [Authentication Scenarios for Azure AD](http://azure.microsoft.com/documentation/articles/active-directory-authentication-scenarios/) article, and specifically the section titled [Basics of Registering an Application in Azure AD](http://azure.microsoft.com/documentation/articles/active-directory-authentication-scenarios/#basics-of-registering-an-application-in-azure-ad).  The latter section also links to a more detailed [Integrating Applications with Azure Active Directory](https://azure.microsoft.com/documentation/articles/active-directory-integrating-applications/) article, including specific permissions for Accessing the Graph API, once you are ready to configure access for your application.

Finally, you will need access to an Azure AD tenant once you are ready to configure access for your application. You can find a companion ASP.NET sample app called [WebApp-GraphAPI-Reporting](https://github.com/AzureADSamples/WebApp-GraphAPI-Reporting) on Github with step-by-step instructions in readme.md, as well as an overview of all samples that illustrate usage of the Active Directory Authentication Library (ADAL) and the Graph API from multiple platforms on the main [Azure AD Code Samples](http://azure.microsoft.com/documentation/articles/active-directory-code-samples/) page.

## Addressing

Once you have your tenant configured and are ready to access the Reports and Events API, refer to the [Quickstart for the Azure AD Graph API](https://azure.microsoft.com/documentation/articles/active-directory-graph-api-quickstart/) article for details on the basics of constructing a service URL, HTTP request header, and related OData access token, as well as information on using testing tools (ie: Graph Explorer, Fiddler) to run test requests against your tenant.

Keep in mind that all Reports and Events operations are addressed using the following OData compliant URL format, where `tenant-name` is the name of your Azure AD tenant, and `reports/<service-operation>` is the path to the specific report resource you want to call: `https://graph.windows.net/<tenant-name>/reports/<service-operation>?api-version=beta`.

Also, the Reports and Events API supports a subset of the OData Query Options supported by the main Graph API (see next section).

## Supported query options

### $filter

The following restrictions apply to filter expressions:

- All reports default to the prior 30 days of history.

- Not all properties of supported entities can be used in a filter expression. See the property details for each of the Reports and Events entities below in this topic for more information.

- Logical operators: **and** is supported. For example: `https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta&$filter=(eventTime gt 2014-03-01 and eventTime lt 2015-04-23) or eventTime lt 2015-02-01`

- Comparison operators: **eq** (equal to), **gt** (greater than), **ge** (greater than or equal to),  **lt** (less than), and **le** (less than or equal to) are supported.

- **startswith**: not supported.

- **any**: not supported.

- Arithmetic operators: not supported.

- Functions: not supported.

- **null** values are not supported as an operand in filter expressions.

**Note**: Spaces in the query string should be URL-encoded before sending a request. For example, the following query string, `https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta&$filter=eventTime gt 2014-03-01 and eventTime lt 2015-04-23`, should be URL encoded as: `https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta&$filter=eventTime%20gt%202014-03-01%20and%20eventTime%20lt%202015-04-23`.

Example requests using the $filter query option:

|Request|Description|
|---|---|
|`https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta&$filter=eventTime%20eq%202015-03-12T22:01:18.4385955Z`|Returns a list of audit report events that occurred on a specific date and time.|
|`https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta&$filter=eventTime%20gt%202014-03-01%20and%20eventTime%20lt%202015-04-23`|Returns a list of audit report events that occurred within the specified range.|

### $top

$top returns a subset of the entries for the given report, consisting of the first N entries, where N is a positive integer.  Example requests using the $top query option:

|Request|Description|
|---|---|
|`https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta&$top=5`|Returns the 5 most recent audit report events.|

### $skip

$skip returns a subset of the entries for the given report, where the subset is defined by seeking N entries into the report collection and selecting only the remaining entries (starting with entry N+1).  Example requests using the $skip query option:

|Request|Description|
|---|---|
|`https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta&$skip=17`|Returns the remaining entries from the audit report events collection, starting with entry 18.|

## Service metadata, entities, properties, and operations

All entities and properties supported by the Reports and Events OData resources are specified in its Service Metadata Document, which defines the service’s Entity Data Model (EDM) using standard OData Common Schema Definition Language (CSDL).  You can retrieve the CSDL metadata by adding the $metadata segment to the /reports resource path in the URL: `https://graph.windows.net/<tenant-name>/reports/$metadata?api-version=beta`.  Excluding the $metadata segment will return a list of the available report resources as JSON data in the response body.  The OData Service Operations that can be used in the resource path to access the event data collections, are defined by the “Name” attribute of the &ltEntitySet&gt elements near the bottom of the CSDL.  For example, to access the event data collection associated with the “audit” report, you would use a URL similar to the following: `https://graph.windows.net/<tenant-name>/reports/auditEvents?api-version=beta`.

**Note**: The namespace that defines the OData entities supported by the Reports and Events API is **Microsoft.ActiveDirectory.DataService.PublicApi.Model.Reporting**, which is different from the one that defines the entities in the main Graph API, which is **Microsoft.DirectoryServices**.  In addition, Reports and Events differs from the main Graph API in the following important ways:

- the entities do not derive from a base type or support any navigation properties
- the service does not support additional functions or complex types
- the service supports HTTP READ operations only

This topic provides additional detail on the collections offered by each entity and its associated properties, which are supported only in read (HTTP GET) operations.  Please refer to the [View your access and usage reports](http://azure.microsoft.com/documentation/articles/active-directory-view-access-usage-reports/) article for additional details on each.

- [AllUsersWithAnomalousSignInActivityEvent](#AllUsersWithAnomalousSignInActivityEvent)

- [AccountProvisioningEvent](#AccountProvisioningEvent)

- [ApplicationUsageSummaryEvent](#ApplicationUsageSummaryEvent)

- [AuditEvent](#AuditEvent)

- [CompromisedCredentialsEvent](#CompromisedCredentialsEvent)

- [IrregularSignInActivityEvent](#IrregularSignInActivityEvent)

- [MimSsgmGroupActivityEvent](#MimSsgmGroupActivityEvent)

- [MimSsprActivityEvent](#MimSsprActivityEvent)

- [MimSsprRegistrationActivityEvent](#MimSsprRegistrationActivityEvent)

- [SignInsAfterMultipleFailuresEvent](#SignInsAfterMultipleFailuresEvent)

- [SignInsFromIPAddressesWithSuspiciousActivityEvent](#SignInsFromIPAddressesWithSuspiciousActivityEvent)

- [SignInsFromMultipleGeographiesEvent](#SignInsFromMultipleGeographiesEvent)

- [SignInsFromPossiblyInfectedDevicesEvent](#SignInsFromPossiblyInfectedDevicesEvent)

- [SignInsFromUnknownSourcesEvent](#SignInsFromUnknownSourcesEvent)

- [SsgmGroupActivityEvent](#SsgmGroupActivityEvent)

- [SsprActivityEvent](#SsprActivityEvent)

- [SsprRegistrationActivityEvent](#SsprRegistrationActivityEvent)


### AllUsersWithAnomalousSignInActivityEvent <a id="AllUsersWithAnomalousSignInActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the irregular activity was detected.|
|detail|Edm.String||Details about the activity.|
|reason|Edm.String||The anomalous activity which caused the user to be in the report.|
|id|Edm.Guid||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### AccountProvisioningEvent <a id="AccountProvisioningEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|id|Edm.String||Unique identifier for the event.|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|application|Edm.String||The name of the application that caused the provisioning event.|
|instanceName|Edm.String||The name of the application instance that caused the provisioning event.|
|operation|Edm.String||The name of the operation.|
|sourceType|Edm.String||The type of the source of the activity|
|targetType|Edm.String||The type of the target of the activity.|
|joiningProperty|Edm.String||The property used for joining.|
|addedProperties|Edm.String||The names of the properties that were added.|
|removedProperties|Edm.String||The names of the properties that were removed.|
|result|Edm.String||The result of the operation.|

### ApplicationUsageSummaryEvent <a id="ApplicationUsageSummaryEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|id|Edm.String||Unique identifier for the event.|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|applicationName|Edm.String||The display name of the application with sign in activity.|
|uniqueUsers|Edm.Int32||The number of unique users that have signed into the application.|
|signIns|Edm.Int32||The number of sign ins to the application.|

### AuditEvent <a id="AuditEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|id|Edm.String||Unique identifier for the event.|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|actor|Edm.String||The User Principal Name (UPN) of the actor user.|
|action|Edm.String||The specific action taken by the actor.  For more details on the possible action values, please refer to the Azure AD Audit Report Events article.|
|target|Edm.String||The User Principal Name (UPN) of the target user.|
|actorDetail|Edm.String||Additional property detail for the actor user, including UPN, PUID, and other.|
|targetDetail|Edm.String||Additional property detail for the target user, including UPN and PUID.|
|updatedProperties|Edm.String||Properties that were updated in an update event, as indicated by the action property.|

### CompromisedCredentialsEvent <a id="CompromisedCredentialsEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|credentialType|Edm.String||The type of credential.|
|reason|Edm.String||The reason why the account was marked compromised.|
|id|Edm.Guid||A unique identifier for the user.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### IrregularSignInActivityEvent <a id="IrregularSignInActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the irregular activity was detected.|
|ipAddress|Edm.String||The IP address of the sign in.|
|eventClassification|Edm.String||Whether the sign in is classified as Irregular or Suspicious.|
|device|Edm.String||Information about the device the user signed in from.|
|reason|Edm.String||The reason the sign in was flagged as suspicious.|
|location|Edm.String||The approximate geographic location of the sign in.|
|id|Edm.Guid||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### MimSsgmGroupActivityEvent <a id="MimSsgmGroupActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|id|Edm.String||The unique identifier of the event.|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|group|Edm.String||The group that the self-service action was performed on.|
|action|Edm.String||The self-service group action performed.|

### MimSsprActivityEvent <a id="MimSsprActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|role|Edm.String||The role of the user.|
|methodsUsed|Edm.String||The method used to reset the user’s password.|
|result|Edm.String||The result of the user’s attempt to reset their password.|
|details|Edm.String||Additional details about the user’s attempt to reset their password.|
|id|Edm.String||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### MimSsprRegistrationActivityEvent <a id="MimSsprRegistrationActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|role|Edm.String||The role of the user.|
|registrationActivity|Edm.String||The registration activity that the user performed.|
|id|Edm.String||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### SignInsAfterMultipleFailuresEvent <a id="SignInsAfterMultipleFailuresEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|firstSuccessfulSignIn|Edm.DateTimeOffset|Filterable|The date and time of the first successful sign in, after multiple attempts.|
|failedAttemptsToSignIn|Edm.Int32||The number of failed sign ins before the successful sign in.|
|id|Edm.Guid||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### SignInsFromIPAddressesWithSuspiciousActivityEvent <a id="SignInsFromIPAddressesWithSuspiciousActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The last date and time this type of event occurred.|
|ipAddress|Edm.String||The IP address of the sign in.|
|id|Edm.Guid||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### SignInsFromMultipleGeographiesEvent <a id="SignInsFromMultipleGeographiesEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|firstSigninFrom|Edm.String||The approximate location of the first sign in.|
|secondSigninFrom|Edm.String||The approximate location of the second sign in.|
|timeOfSecondSignIn|Edm.DateTimeOffset|Filterable|Date and time of the second sign in.|
|timeBetweenSignIns|Edm.String||The approximate difference between the two sign in locations.|
|estimatedTravelHours|Edm.Int32||The estimated required travel time between the two sign in locations.|
|id|Edm.Guid||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### SignInsFromPossiblyInfectedDevicesEvent <a id="SignInsFromPossiblyInfectedDevicesEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|deviceIPAddress|Edm.String||The IP address where the sign in occurred.|
|lastSignInTime|Edm.DateTimeOffset|Filterable|Date and time of the latest login.|
|deviceLocation|Edm.String||The approximate geographic location of the sign in.|
|client|Edm.String||Information about the potentially infected device.|
|suspectedInfection|Edm.String||Any information about the potential infection.|
|latestPotentiallySuspiciousActivity|Edm.DateTimeOffset|Filterable|Date and time of infection.|
|id|Edm.Guid||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### SignInsFromUnknownSourcesEvent <a id="SignInsFromUnknownSourcesEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|numberOfSignins|Edm.Int32||Total number of logins.|
|ipAddress|Edm.String||The IP address of the sign in.|
|timeOfLastSuccessfulSignIn|Edm.DateTimeOffset|Filterable|The last date and time this type of event occurred.|
|id|Edm.Guid||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### SsgmGroupActivityEvent <a id="SsgmGroupActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|id|Edm.String||The unique identifier of the event.|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|group|Edm.String||The group that the self-service action was performed on.|
|action|Edm.String||The self-service group action performed.|

### SsprActivityEvent <a id="SsprActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|role|Edm.String||The role of the user.|
|methodsUsed|Edm.String||The method used to reset the user’s password.|
|result|Edm.String||The result of the user’s attempt to reset their password.|
|details|Edm.String||Additional details about the user’s attempt to reset their password.|
|id|Edm.String||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

### SsprRegistrationActivityEvent <a id="SsprRegistrationActivityEvent"></a>

|Name|Type|Read(GET)|Description|
|---|---|---|---|
|eventTime|Edm.DateTimeOffset|Filterable|The date and time that the event occurred.|
|role|Edm.String||The role of the user.|
|registrationActivity|Edm.String||The registration activity that the user performed.|
|id|Edm.String||The unique identifier of the event.|
|displayName|Edm.String||The display name of the user.|
|userName|Edm.String||The name of the user.|

## Addtional resources

- For more information on the OData primitive date types exposed by the EDM, see [Entity Data Model: Primitive Data Types](https://msdn.microsoft.com/library/ee382832.aspx).
- [Azure AD Graph API reference](../api/api-catalog.md)

