---
title: Azure AD Graph API Error Codes and Error Handling
author: JimacoMS
ms.TocTitle: Error codes and error handling
ms.ContentId: 22d84fe2-aadd-4d5a-8f07-3cfab25384f0
ms.topic: article (how-tos)
ms.date: 01/26/2016
---


# Error codes and error handling | Graph API concepts 

    
 _**Applies to:** Graph API | Azure Active Directory_


<a id="Overview"> </a>
Client applications that use the Azure Active Directory (AD) Graph API should implement error handling logic to react as gracefully as possible to varying conditions and provide the best experience possible to their customers. The topic discusses the types of errors that the Azure AD Graph API returns and provides general guidance on how to handle them.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token.

## Handling Graph API errors <a id="HandlingGraphApiErrors"></a>

### Types of errors
Graph API errors occur in the following categories.

- **Client Errors**. Client errors are represented by 400-series HTTP status codes. They include objects with invalid values, objects that are missing required properties or property values, attempting to access a non-existent resource, attempting to update a read-only property, and omitting the required authorization token. To resolve these errors, fix the underlying issue before retrying the request.
- **Server Errors**. Server errors are represented by 500-series HTTP status codes, such as a transient directory failure. Most of these errors are transient and can be resolved by retrying the request.
- **Network/Protocol Errors**. A variety of network-related errors can occur while sending a request or receiving a response, such as host name resolution errors, prematurely closed connections, and SSL negotiation errors. Most of these errors cannot be resolved by retrying; the underlying issue has to be fixed. However, some errors, such as host-name resolution failures or timeouts, might be resolved by retrying the request.


### Error message structure
Graph API errors have a formatted body that consists of an HTTP status code, a message, and values.  Use the properties of the error body in your error handling logic.

**Note**: Some HTTP responses might not include the code/message/values response body because the request is routed through proxy and gateway services. Be sure to include default logic that can handle errors based on the HTTP status code alone. 

The following is an example of an HTTP 400 Request_BadRequest error.


```no-highlight
 HTTP/1.1 400 Bad Request
 Content-Type: application/json;odata=minimalmetadata;charset=utf-8
 request-id: ddca4a7e-02b1-4899-ace1-19860901f2fc
 Date: Tue, 02 Jul 2013 01:48:19 GMT
 …
 
 {
     "odata.error" : {
         "code" : "Request_BadRequest",
         "message" : {
             "lang" : "en",
             "value" : "A value is required for property 'mailNickname' of resource 'Group'."
         },
     "values" : null
    }
 }

```

Each message body has code, message, and values properties.

- **Code**: Design your error-handling logic to branch based on the code.

    ```no-highlight
    "code" : "Request_BadRequest"
    ```
- **Message**: A language/value tuple that represents a human-readable error message. The content is in the value field. In the following example, the request fails because the value of the **mailNickname** property is missing.

    ```no-highlight
    "message" : {
         "lang" : "en",
         "value" : "A value is required for property 'mailNickname' of resource 'Group'."
    }
    ```

- **Values**: A collection of name/value pairs that provide more information about the nature of the failure. In the following example no values are included.

    ```no-highlight
    "values" : null
    ```

## Error code reference <a id="ErrorCodeReference"></a>

### HTTP error codes <a id = "HttpErrorCodes"></a> 
The following table lists Graph API error codes, error messages, and actions to consider when correcting errors.

In general, HTTP 500-series errors respond to retries, preferably distributed over increasingly long time intervals ("retry with a back-off interval") and with a random distribution factor. 400-series errors indicate a problem that must be fixed before retrying.

| HTTP Status Code | Error code | Error message | Details 
|:-----------------|:----------|:--------------|:-------
| 400 | Directory_ResultSizeLimitExceeded | Result Size Limit was Exceeded | The request cannot be fulfilled because it is associated with too many results. This error occurs very infrequently.
| 400 | Request_BadRequest | Bad request. Please fix the request before retrying. | Indicates an error in the request, such as an invalid property value or an unsupported query argument. Fix the request before retrying.
| 400 | Request_UnsupportedQuery |     | The GET request is unsupported. Fix the request parameters and try again.
| 401 | Authentication_ExpiredToken | Your access token has expired. Please renew it before submitting the request. | Access token has expired. Renew the token and then resubmit.
| 401 | Authentication_MissingOrMalformed | Access Token missing or malformed. | The access_token value in the authorization header is missing or malformed. This value is required. Use the value in the authentication token.
| 401 | Authorization_IdentityDisabled | The calling application principal is disabled. | The principal specified in the access token is in the directory, but is it disabled.  Re-enable the account in the directory, and try again.
| 401 | Authorization_IdentityNotFound | The identity of the calling application could not be established. | The principal specified in the access token was not found in the directory. This might occur because the token is stale, the principal was deleted from the directory, or directory synchronization is delayed.
| 403 | Authentication_Unauthorized | Unauthorized request. | The token contains invalid or unsupported claims. Get the request token again and then retry the request.
| 403 | Authorization_RequestDenied | The specified credentials do not have sufficient privileges to make this request. | The request is denied due to insufficient privileges. For example, a non-administrative principal does not have permission to delete a resource.
| 403 | Directory_QuotaExceeded | The directory object quota limit for the \{tenantName\} has been exceeded. Please ask your administrator to increase the quota limit or delete objects to reduce the used quota. | A directory quota has been exceeded. The tenant might have too many objects or the objects might have too many values. This also occurs when too many objects are created on for the principal. Increase the maximum allowed object count for the tenant or principal, or reduce the number of values included in the create/update request.
| 404 | Request_ResourceNotFound | Resource {resource} does not exist or one of its queried reference-property objects are not present. | The resource identified by the URI does not exist. Revise the value and retry the request.
| 500 | Service_InternalServerError | Encountered an internal server error. | Internal server error while processing the request.
| 502 | [All] | “... Service Unavailable...” | A server acting as a gateway or proxy encountered an error from another server while processing the request. Wait a few minutes and then retry the request.
| 503 | Request_ThrottledTemporarily | Your request is throttled temporarily. Please try after {0} seconds. | The token request rate has exceeded the limit that the service can manage. Wait a few minutes and retry the request with increasing back-off intervals. Increasing the delay between retries makes it more likely that the request succeeds and the backlog is eliminated.
|     | Authentication_Unknown | Internal server error. | This error code is used when other error codes do not apply.
|     | Authentication_UnsupportedTokenType | The type of token presented is not handled. Only bearer tokens are supported. | The token type is not supported. Revise the token type before trying the request again.
|     | Directory_BindingRedirection | Tenant information is not available locally. Use the following Urls to get the information. | When the tenant partition is not available in the datacenter, clients must connect to the URl returned in the response.
|     | Directory_BindingRedirectionInternalServerError | Tenant information is not available locally. The server encountered an internal error while trying to populate the nearest datacenter endpoints. | When a binding redirection exception occurs, the list of nearest datacenter endpoints for the service is populated. This error indicates an exception when populating the list. Try the query again.
|     | Directory_CompanyNotFound | Unable to read the company information from the directory. | An error occurred while loading company information from the directory service. 
|     | Directory_ReplicaUnavailable | The preferred replica is unavailable. Please retry without any replica session key header. | Omit the x-ms-replica-session-key header and then retry.
|     | Headers_DataContractVersionMissing | The data contract version header is missing. Include x-ms-dirapi-data-contract-version in your request. | The client contract version is missing from the request.
|     | Headers_HeaderNotSupported | Header {0} is not currently supported. | The request contains an unsupported HTTP header. Change the header and try the request again.
|     | Request_InvalidReplicaSessionKey | The replica session key provided is not valid. | Fix the replica session key and try the request again.
|     | Request_ThrottledPermanently | Your request is throttled permanently. Please call support to address the issue. | The tenant repeatedly and persistently exceeded the token request rate limit. Requests from the tenant are rejected until the service is renegotiated. For help, contact Microsoft Support.

##Additional resources <a id="AdditionalResources"></a>

- [Azure AD Graph API reference](../api/api-catalog.md)

