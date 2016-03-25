---
title: Azure AD Graph API Batch Processing
author: JimacoMS
ms.TocTitle: Batch processing
ms.ContentId: 09fb494e-66fa-4a6e-a09e-498cf9b5b13d
ms.topic: article (how-tos)
ms.date: 01/26/2016
---

# Batch processing | Graph API concepts
With Azure AD Graph API, you can batch operations on entities to reduce roundtrips to the server. Batching your requests reduces network overhead, and your operations will complete more quickly.

> [!IMPORTANT]
> Azure AD Graph API functionality is also available through [Microsoft Graph](https://graph.microsoft.io/), a unified API that also includes APIs from other Microsoft services like Outlook, OneDrive, OneNote, Planner, and Office Graph, all accessed through a single endpoint with a single access token. Note that batch processing is not currently supported in Microsoft Graph; you will need to use Azure AD Graph API for this feature.


## Graph API support for OData batch requests <a id="SupportForOdataBatchRequests"></a>
The semantics for entity batch processing are defined by the [OData 3.0 Batch Processing Specification](http://www.odata.org/documentation/odata-version-3-0/batch-processing/). The OData specification defines the following concepts for batch requests:

- A query is a single query or function invocation.
- A change set is a group of one or more insert, update, or delete operations, action invocations, or service invocations.
- A batch is a container of operations, including one or more change sets and query operations.

The Graph API supports a subset of the functionality defined by the OData specification:

- A single batch can contain a maximum of five queries and/or change sets combined.
- A change set can contain a maximum of one source object modification and up to 20 add-link and delete-link operations combined. All operations in the change set must be on a single source entity.

## Graph API batch requests <a id="BatchRequests"></a>
The following sections describe how to construct a batch request, how to interpret the batch response, and show samples of each.
### Batch request syntax
To perform a batch request, specify the $batch option on the request URI. For example:

```no-highlight
https://graph.windows.net/contoso.onmicrosoft.com/$batch?api-version=1.6
```

A batch request is sent to the server with a single POST directive.

The payload is a multi-part MIME message containing the batch and its constituent queries and change sets. The payload includes two types of MIME boundaries:

- A batch boundary separates each query and/or change set in the batch.
- A change set boundary separates individual operations within a change set.

An individual request within a change set is identical to a request made when that operation is called by itself. For example:

- To specify the payload format (JSON or ATOM) for each operation in the change set, include the appropriate Content-Type and, if needed, Accept headers.
- To suppress the response content echo when creating an entity, specify the Prefer header with the return-no-content value for each insert operation in a change set.

### Sample request
The following example shows a batch request that contains five items:

1. A change set that creates a user, testuser@contoso.onmicrosoft.com (POST). This operation includes the Prefer: response-no-content header to suppress the newly created user being returned.
2. A change set that updates the Department and Job Title properties of the new user (PATCH), and sets its manager navigation property (PUT).
3. A query for the manager of the new user (GET).
4. A change set that deletes the new user (DELETE).
5. A query for the user (GET). This operation will fail because the user was deleted in the previous step.

```no-highlight
POST https://graph.windows.net/contoso.onmicrosoft.com/$batch?api-version=1.5 HTTP/1.1
Authorization: Bearer ey … jQA
Content-Type: multipart/mixed; boundary=batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Host: graph.windows.net
Content-Length: 2961

--batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: multipart/mixed; boundary=changeset_77162fcd-b8da-41ac-a9f8-9357efbbd620 
Content-Length: 631       

--changeset_77162fcd-b8da-41ac-a9f8-9357efbbd620 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

POST /contoso.onmicrosoft.com/users?api-version=1.5 HTTP/1.1
Content-Type: application/json
Accept: application/json
Content-Length: 256
Prefer: return-no-content
Host: graph.windows.net

{
    "accountEnabled": true,
    "displayName": "Test User",
    "mailNickname": "testuser",
    "passwordProfile": { "password" : "Test1234", "forceChangePasswordNextLogin": false },
    "userPrincipalName": "testuser@contoso.onmicrosoft.com"
}

--changeset_77162fcd-b8da-41ac-a9f8-9357efbbd620----batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: multipart/mixed; boundary=changeset_4b2cbfb7-011d-4edb-8bbf-e044f9830aaf 
Content-Length: 909

--changeset_4b2cbfb7-011d-4edb-8bbf-e044f9830aaf 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

PATCH /contoso.onmicrosoft.com/users/testuser@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1
Content-Type: application/json
Accept: application/json
Content-Length: 72
Host: graph.windows.net

{
    "department": "Engineering",
    "jobTitle": "Test Engineer"
}

--changeset_4b2cbfb7-011d-4edb-8bbf-e044f9830aaf 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

PUT /contoso.onmicrosoft.com/users/testuser@contoso.onmicrosoft.com/$links/manager?api-version=1.5 HTTP/1.1
Content-Type: application/json
Accept: application/json
Content-Length: 112
Host: graph.windows.net

{
  "url":"https://graph.windows.net/contoso.onmicrosoft.com/users/a71e4d1c-ce99-40dc-8d4b-390eac63e039"
}

--changeset_4b2cbfb7-011d-4edb-8bbf-e044f9830aaf----batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: application/http 
Content-Transfer-Encoding:binary

GET /contoso.onmicrosoft.com/users/testuser@contoso.onmicrosoft.com/$links/manager?api-version=1.5 HTTP/1.1
Accept: application/json
Host: graph.windows.net

--batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: multipart/mixed; boundary=changeset_9a0b5878-0f4a-4f57-91c5-9792cdd5ef20 
Content-Length: 331       

--changeset_9a0b5878-0f4a-4f57-91c5-9792cdd5ef20 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

DELETE /contoso.onmicrosoft.com/users/testuser@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1
Accept: application/json
Host: graph.windows.net


--changeset_9a0b5878-0f4a-4f57-91c5-9792cdd5ef20----batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: application/http 
Content-Transfer-Encoding:binary

GET /contoso.onmicrosoft.com/users/testuser@contoso.onmicrosoft.com?api-version=1.5 HTTP/1.1
Accept: application/json
Host: graph.windows.net

--batch_36522ad7-fc75-4b56-8c71-56071383e77b--
```

##Batch response syntax <a id="BatchResponseSyntax"></a>
The response returns an overall status code for the batch request, and individual status codes and result fragments for each item in the batch. The response is a multi-part MIME message that includes batch boundaries and change set boundaries.

Assuming that the batch request has been properly authenticated and has been successfully received by the Graph API, the batch request returns status code **202 Accepted**, even if one of the operations in the batch fails. If the batch request itself fails, it fails before any operation in the batch is executed. For example, the batch request may fail due to an authentication error, in which case the status code will indicate that failure.

The response fragment for a query item contains a single status code that indicates either the success or failure of the operation as well as any response body appropriate.

The operations in a change set are processed atomically; that is, either all operations in the change set succeed, or the entire change set fails. The Graph API continues processing operations in the change set until one fails. If an operation fails, all preceding operations in the change set are rolled back.

If all operations in a change set are successfully processed, the status code (and response body) for each operation within the change set appears within the change set response. If an operation in a change set fails, then only a single status code is returned for the change set. This will be the status code (and response body) returned by the failed operation; for example, **400 Bad Request** or **404 Not Found**.

###Sample response
The following example shows the response for the batch operation sent in the sample request shown above. The status for the batch request itself is set to **202 Accepted**. This indicates that there no problems with the batch request itself. The response to each item in the batch is delimited with the *batchresponse* boundary identifier and each response to an operation within a change set is delimited with a *changesetresponse* boundary identifier.

The following lists the response fragments for each batch item:

1. The status for the POST request to create the new user is set to **204 No Content**. This is because the *Prefer* header was set to `return-no-content` in the request. It indicates that the user was successfully created.
2. The response for the second batch item contains two *204 No Content** responses, one for the user object update (PATCH) and one for setting the manager link (PUT) in the change set. This indicates that both operations were successful.
3. The response for the request to read the user’s manager, returns the link to the manager and a status of **200 OK**.
4. The status for the attempt to delete the user, is **204 No Content**. This indicates that the operation was successful
5. The status for the attempt to read the deleted user, is **404 Not Found** and the response contains a code and message that indicates that the user (resource) was not found.

```no-highlight
HTTP/1.1 202 Accepted
Cache-Control: no-cache
Pragma: no-cache
Content-Type: multipart/mixed; boundary=batchresponse_1eb70252-25d2-466c-9a1d-7a3f45378b06
Expires: -1
Server: Microsoft-IIS/8.5
ocp-aad-diagnostics-server-name: Nv0YIi2YUldDWu0YPQAXsYwXQ4ttyr7ded6Waf8xyCc=
request-id: 2f7d2f81-3441-4c2a-b494-25cd1d6ce624
client-request-id: f40c00af-3e1f-4198-9261-386f0e3aecc6
x-ms-gateway-rewrite: false
x-ms-dirapi-data-contract-version: 1.5
ocp-aad-session-key: cdhenl3mgHuI3vaRRIQ14uXdwRLUqirNpDXjJP42EzUEvqhhn2NFr22ulR4PsqrM1UD_eSUDItt7J9kUQhNvTT_48q90coHHt2RutCIgPNg.lD81Z0iS2SaHbqkfAaDvbbigoX7ak7rfiUGFby0LOIE
X-Content-Type-Options: nosniff
DataServiceVersion: 1.0;
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-AspNet-Version: 4.0.30319
X-Powered-By: ASP.NET
X-Powered-By: ASP.NET
Date: Tue, 20 Jan 2015 23:21:15 GMT
Content-Length: 3065

--batchresponse_1eb70252-25d2-466c-9a1d-7a3f45378b06
Content-Type: multipart/mixed; boundary=changesetresponse_8a63ce5e-ed31-4de6-bc90-9d3ff31debbb--changesetresponse_8a63ce5e-ed31-4de6-bc90-9d3ff31debbb
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 204 No Content
X-Content-Type-Options: nosniff
Cache-Control: no-cache
Preference-Applied: return-no-content
DataServiceVersion: 3.0;
Location: https://graph.windows.net/contoso.onmicrosoft.com/directoryObjects/6a287a96-ede9-44d2-b685-d6fc03a124c5/Microsoft.DirectoryServices.User
DataServiceId: https://graph.windows.net/contoso.onmicrosoft.com/directoryObjects/6a287a96-ede9-44d2-b685-d6fc03a124c5


--changesetresponse_8a63ce5e-ed31-4de6-bc90-9d3ff31debbb----batchresponse_1eb70252-25d2-466c-9a1d-7a3f45378b06
Content-Type: multipart/mixed; boundary=changesetresponse_11ba5cf0-9fba-4995-9f15-bd5c9981cdd6--changesetresponse_11ba5cf0-9fba-4995-9f15-bd5c9981cdd6
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 204 No Content
X-Content-Type-Options: nosniff
Cache-Control: no-cache
DataServiceVersion: 1.0;


--changesetresponse_11ba5cf0-9fba-4995-9f15-bd5c9981cdd6
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 204 No Content
X-Content-Type-Options: nosniff
Cache-Control: no-cache
DataServiceVersion: 1.0;


--changesetresponse_11ba5cf0-9fba-4995-9f15-bd5c9981cdd6----batchresponse_1eb70252-25d2-466c-9a1d-7a3f45378b06
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 200 OK
DataServiceVersion: 3.0;
Content-Type: application/json;odata=minimalmetadata;streaming=true;charset=utf-8
X-Content-Type-Options: nosniff
Cache-Control: no-cache

{
  "odata.metadata":"https://graph.windows.net/contoso.onmicrosoft.com/$metadata#directoryObjects/$links/manager",
  "url":"https://graph.windows.net/contoso.onmicrosoft.com/directoryObjects/a71e4d1c-ce99-40dc-8d4b-390eac63e039/Microsoft.DirectoryServices.User"
}
--batchresponse_1eb70252-25d2-466c-9a1d-7a3f45378b06
Content-Type: multipart/mixed; boundary=changesetresponse_bb215a84-f91e-4486-a771-ba2cc5d429d1--changesetresponse_bb215a84-f91e-4486-a771-ba2cc5d429d1
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 204 No Content
X-Content-Type-Options: nosniff
Cache-Control: no-cache
DataServiceVersion: 1.0;


--changesetresponse_bb215a84-f91e-4486-a771-ba2cc5d429d1----batchresponse_1eb70252-25d2-466c-9a1d-7a3f45378b06
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 404 Not Found
X-Content-Type-Options: nosniff
Cache-Control: no-cache
DataServiceVersion: 3.0;
Content-Type: application/json;odata=minimalmetadata;streaming=true;charset=utf-8

{
  "odata.error":
    {
      "code":"Request_ResourceNotFound",
      "message":
        {
          "lang":"en",
          "value":"Resource 'testuser@contoso.onmicrosoft.com' does not exist or one of its queried reference-property objects are not present."
        }
    }
}
--batchresponse_1eb70252-25d2-466c-9a1d-7a3f45378b06--
```

###Sample error response
As discussed above, the Graph API returns an error code of **202 Accepted** for the entire batch if it can accept the batch; that is, if the batch request is well-formed and there are no errors, such as an authentication error. Otherwise, the Graph API returns the appropriate error and does not process the batch. If an individual item within the batch fails then the response fragment for that item will contain a status code and response body that indicates that error. When an operation inside a change set fails, a single response fragment will be returned for the entire change set and that fragment will contain the status code and response body associated with the failed operation.

The following example shows a response from batch request that contains a change set in which one of the operations failed. Note that the batch response returns status code **202 Accepted**. The status code returned for the change set indicates that an operation failed with a status of **404 Not Found**. Additional error information is included in the response body for the failed operation. The **code** element specifies the Graph API error code and the **message** element contains the error message string. In this example, the response body has been indented for readability.

```no-highlight
HTTP/1.1 202 Accepted
Cache-Control: no-cache
Pragma: no-cache
Content-Type: multipart/mixed; boundary=batchresponse_3ac28387-a100-4758-8998-8b9ec36f9fdc
Expires: -1
Server: Microsoft-IIS/8.5
ocp-aad-diagnostics-server-name: 1l3fvSoDCV+VKoBCuHRN+HIwCACBOck3dqmtCGj+aiU=
request-id: e434261b-c32f-48b4-b21d-3e1beab6d525
client-request-id: 236bf26e-b4e8-40a4-b6fb-d41105a7b178
x-ms-gateway-rewrite: false
x-ms-dirapi-data-contract-version: 1.5
ocp-aad-session-key: 9aOaAUxX95OZ0ctrYbeLUproN-37GypZXrss0PYKhEfqamKRG-C68hFcCw5h-ZCWFqBrXPrldGEnjq4CKKr0bW91tjrdo-BlwAqHxbP5jq4.FaXtVZni3cSsWFRMSjQAbjiluPcEvZofwp9OH3t1fyk
X-Content-Type-Options: nosniff
DataServiceVersion: 1.0;
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-AspNet-Version: 4.0.30319
X-Powered-By: ASP.NET
X-Powered-By: ASP.NET
Date: Wed, 21 Jan 2015 21:13:25 GMT
Content-Length: 779

--batchresponse_3ac28387-a100-4758-8998-8b9ec36f9fdc
Content-Type: multipart/mixed; boundary=changesetresponse_72ba9a5a-2da3-4d39-ae4f-dd9527efd742--changesetresponse_72ba9a5a-2da3-4d39-ae4f-dd9527efd742
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 404 Not Found
X-Content-Type-Options: nosniff
DataServiceVersion: 3.0;
Content-Type: application/json;odata=minimalmetadata;streaming=true;charset=utf-8

{
  "odata.error":
    {
      "code":"Request_ResourceNotFound",
      "message":
        {
          "lang":"en",
          "value":"Resource 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee' does not exist or one of its queried reference-property objects are not present."
        }
    }
}
--changesetresponse_72ba9a5a-2da3-4d39-ae4f-dd9527efd742----batchresponse_3ac28387-a100-4758-8998-8b9ec36f9fdc--
```

For reference, the following example shows the batch that generated the response above. It contains a single change set that adds three users to a group. The Object IDs for the last two users are fictitious: eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee and ffffffff-ffff-ffff-ffff-ffffffffffff. The batch URL and associated request headers are omitted for brevity.

```no-highlight
--batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: multipart/mixed; boundary=changeset_5a769eb2-d1a7-4a10-94f6-d1a5ed5c4bc0 
Content-Length: 1432

--changeset_5a769eb2-d1a7-4a10-94f6-d1a5ed5c4bc0 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

POST /contoso.onmicrosoft.com/groups/fc15e7ef-993f-4865-bf37-317d9b8017b8/$links/members?api-version=1.5 HTTP/1.1
Content-Type: application/json
Accept: application/json
Content-Length: 112
Host: graph.windows.net

{
  "url":"https://graph.windows.net/contoso.onmicrosoft.com/users/a71e4d1c-ce99-40dc-8d4b-390eac63e039"
}

--changeset_5a769eb2-d1a7-4a10-94f6-d1a5ed5c4bc0 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

POST /contoso.onmicrosoft.com/groups/fc15e7ef-993f-4865-bf37-317d9b8017b8/$links/members?api-version=1.5 HTTP/1.1
Content-Type: application/json
Accept: application/json
Content-Length: 112
Host: graph.windows.net

{
  "url":"https://graph.windows.net/contoso.onmicrosoft.com/users/eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee
"
}

--changeset_5a769eb2-d1a7-4a10-94f6-d1a5ed5c4bc0 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

POST /contoso.onmicrosoft.com/groups/fc15e7ef-993f-4865-bf37-317d9b8017b8/$links/members?api-version=1.5 HTTP/1.1
Content-Type: application/json
Accept: application/json
Content-Length: 112
Host: graph.windows.net

{
  "url":"https://graph.windows.net/contoso.onmicrosoft.com/users/ffffffff-ffff-ffff-ffff-ffffffffffff"
}

--changeset_5a769eb2-d1a7-4a10-94f6-d1a5ed5c4bc0----batch_36522ad7-fc75-4b56-8c71-56071383e77b--
```

##Additional resources <a id="AdditionalResources"></a>

- [OData 3.0 Batch Processing Specification](http://www.odata.org/documentation/odata-version-3-0/batch-processing/)
- [OData Specification](http://www.odata.org/)
- [Azure AD Graph API reference](../api/api-catalog.md)

