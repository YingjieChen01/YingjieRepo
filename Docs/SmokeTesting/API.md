ms.TocTitle: Outlook Calendar REST API reference
Title: Outlook Calendar REST API reference
Description: Reference how to interact with the Calendar REST API and client library APIs that provide access to events, calendars, and calendar groups in Exchange Online.
ms.ContentId: 443f1cdf-1adb-46a2-b299-228c6f429954
ms.topic: reference (API)
ms.date: July 13, 2015

# Outlook Calendar REST API reference

<a name="GetCalendar"> </a>
###Get a calendar (REST)

_Required scope:  **Calendar.Read**_

Get a calendar by ID. You can get the user's primary calendar by using the `../me/calendar` endpoint.

```no-highlight
GET https://outlook.office365.com/api/{version}/me/calendars/{calendar_id}
```

|**Required parameter**|**Type**|**Description**|
|:-----|:-----|:-----|
|_URL parameters_|
|version|string|The [version](#SupportedVersions) of the API.|
|calendar_id|string|The calendar ID.|


```REST-i
[!RESTAPI [calendar_api_get_calendar_by_id](trydata/calendar_api_get_calendar_by_id.json)]
```

**Response type**

****

<a name="GetCalendarsClient"> </a>
###Get a calendar collection or a calendar (Client)

Get the user's calendars. To get the user's default calendar, use the `client.Me.Calendar` shortcut property. To get a different calendar, specify the calendar ID
 as the index of the  **Calendars** collection or use the **GetById** method.

Example: `client.Me.Calendars[calendarId].ExecuteAsync()`

**Note** Calendar collections support query expressions such as **Select**, **OrderBy**, and **Take**.

****

<a name="GetEventsClient"></a>
### Get events from the user's calendar (Client)

Get the events from the user's default calendar. To get the events from a different calendar, call the calendar's **Events** property.

Example: `outlookClient.Me.Calendars[calendarId].Events.ExecuteAsync()`


**Attention** If you're accessing mailbox data on Outlook.com, do not use the client libraries and call the REST API directly.


To get a particular event, you can specify the event ID as the index of the **Events** collection or use the **GetById** method.

**Note** Event collections support query expressions such as **Select**, **OrderBy**, and **Take**.

This example calls the method that [creates the Outlook Services client](#GetClient).

<!-- BEGINSECTION class="tabbedCodeSnippets" data-resources="OutlookServices.Calendar" -->

```cs-i
var outlookClient = await CreateOutlookClientAsync("Calendar");
var events = await outlookClient.Me.Events
  .Take(10)
  .ExecuteAsync();
 
foreach(var calendarEvent in events.CurrentPage)
{
  System.Diagnostics.Debug.WriteLine("Event '{0}'.", calendarEvent.Subject);
}
 
```

```javascript-i
outlookClient.me.events.getEvents().fetch().then(function (result) {
    result.currentPage.forEach(function (event) {
console.log('Event "' + event.subject + '"')
    });
}, function(error) {
    console.log(error);
});
```

<!-- ENDSECTION -->


This call returns the event series, not the individual expanded instances for recurring events (such as a weekly team meeting).

Querying event instances is currently not supported in the client library. You can use the REST API to query the **CalendarView** property on the
 Calendar resource or the **Instances** property on the Event resource:
 
```no-highlight
GET https://outlook.office.com/api/{version}/me/events/{event_id}/instances?startDateTime={start_datetime}&endDateTime={end_datetime}
```
 
<!--Update c# example to get instance-->
<!--Update js example and remove note when this works in js-->

****