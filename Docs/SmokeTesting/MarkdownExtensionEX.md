---
title: This is page title
---

# Outlook Calendar REST API reference


## <a id="Swagger"> </a> Swagger


[!code-REST-i[calendar_api_get_calendar_by_id](Data/calendar_api_get_calendar_by_id.json)]

```RESTAPIdocs
{
    "api":  "Contacts",
    "operation":    "get contacts", 
     "showComponents": {        
        "codeGenerator": "true"
    } 
}
``` 

## <a id="Code_table"> </a>Code table

## <a id="ABCCodefasdfasdf_table" />ABCCode table

> [!div class="tabbedCodeSnippets" data-resources="OutlookServices.Calendar"]
> ```cs-i
var outlookClient = await CreateOutlookClientAsync("Calendar");
var events = await outlookClient.Me.Events
  .Take(10)
  .ExecuteAsync();
foreach(var calendarEvent in events.CurrentPage)
{
  System.Diagnostics.Debug.WriteLine("Event '{0}'.", calendarEvent.Subject);
}
```
> ```javascript-i
outlookClient.me.events.getEvents().fetch().then(function (result) {
    result.currentPage.forEach(function (event) {
console.log('Event "' + event.subject + '"')
    });
}, function(error) {
    console.log(error);
});
```

> [!CAUTION]
> This is CAUTION

The above is CAUTION text

If any question, please contact me~

## <a> </a>Responsive Table
Scenario  |Permission
------------- | ------------- |
Password Sync| <ul><li>Replicate Directory Changes.</li>  <li>Replicate Directory Changes All.</li></ul>
Exchange Hybrid Deployment|See [Office 365 Exchange Hybrid AAD Sync write-back attributes and permissions](https://msdn.microsoft.com/library/azure/dn757602.aspx#exchange).
Password Write-back | <ul><li>Change Password</li><li>Reset password</li></ul>
User, Group, and Device Write-back|Write permissions to the directory objects and attributes that you wish to 'write-back'
Single Sign-On and AD FS| Domain admin permissions in the domain in which your federated servers are located. 
