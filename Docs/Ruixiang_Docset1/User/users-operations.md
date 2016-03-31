
### Get users <a id="GetUsers"> </a>
Gets a collection of users. You can add OData query parameters to the request to filter, sort, and page the response. For more information, see [Supported Queries, Filters, and Paging Options].

On success, returns a collection of [User] objects; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get users", 
     "showComponents": {        
        "codeGenerator": "true",
        "tryFeature": "true"      
    } 
}
```

****

###Get a user <a id="GetAUser"> </a>

Gets a specified user. You can use either the object ID (GUID) or the user principal name (UPN) to identify the target user.

On success, returns the [User] object for the specified user; otherwise, the response body contains error details. For more information about errors, see [Error Codes and Error Handling].

```RESTAPIdocs
{
    "api":  "Users",
    "operation":    "get user by id",
     "showComponents": {        
        "codeGenerator":    "true",
        "tryFeature": "true"      
    } 
}
```

****

[User]: ./entity-and-complex-type-reference.md#UserEntity

[!CODE-RESTAPI_Swagger [users_swagger2](./users_swagger2.json)]
[!CODE-RESTAPI_Swagger [users2_swagger2](./users2_swagger2.json)]
