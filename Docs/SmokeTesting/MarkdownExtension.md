# This is the topic to test the Markdown Extensions

Extension Type | Support in OPS? | Start testing   | Comment
---------------|-----------------|-----------------|--------
Note           |NO -> S94        |After 1/13       |   
Warning/Caution|NO -> S94        |After 1/13       |   
Tip            |NO -> S94        |After 1/13       |   
Important      |NO -> S94        |After 1/13       |   
Include        |Yes              |Ready for testing|Work fine :
Video          |NO               |                 |   
Selector       |NO -> S95        |After S95 deployment|   
Selector-List  |NO -> S95        |After S95 deployment|
Insert API     |Yes              |Ready for testing|  
Insert API-Swagger|Yes              |Ready for testing|  
REference a Swagger files|Yes| Ready for testing|
Bookmarks|  | Ready for testing| Work fine :smile:
Code snippet|yes|Ready for testing|1. Fail to add Multiple Language 2. The language of code could not be shown

:smile:
## Alerts (Note, Tip, Warning, Important)
> [!NOTE] 
Sample Notification

> [AZURE.NOTE] 
Sample Notification with Azure Syntax

> [!WARNING] 
Sample Warning

> [AZURE.WARNING] 
Sample Warning with Azure Syntax

[!TIP] 
<Sample Tip>

[AZURE.TIP] 
Sample Tip with Azure Syntax

[!IMPORTANT] 
Sample Important

[AZURE.IMPORTANT] 
Sample Important with Azure Syntax

[!CAUTION] 
Sample Caution

CAUTION with  Azure Syntax is not support

## Include (Tokens)
Token of VS2010 from VS2010.md, should be shown as *Visual Studio 2010*: [!Include[VS2010](Tokens\VS2010.md)]

Token of VS2011 form vs2011.xml, should be shown as *Visual Studio 2011*: [!Include[VS2011](Tokens\VS2011.XML)]

## Video
Todo
## Bookmarks
You do not have to create anchors anymore - they are automatically generated at publishing time for all H2 headings. The only thing you have to do is create links to the H2 sections
the-text-of-the-H2-section-separated-by-hyphens

[Go to Bookmark1 node](#Node-of-Bookmark1)

[Go to Bookmark which anchor of H3 ](#Node-of-Bookmark-with-H3)

[Go to Bookmark node in topic MarkDownSyntax](MarkDownSyntax.md#BookMark-Node-End2)


## Code Snippets
### Single code Snippet

>```C#
>    using System;
>```

[!Code-Javascript[jdbc_handling_errors1](CodeSnippet\jdbc_handling_errors1\VB\jdbc_handling_errors1.vb)]

code of the entire file
[!Code-C#[Main](CodeSnippet\test.cs)]

One snippet in the file with tag Name
[!Code-C#[Main](CodeSnippet\test.cs#snippetGetActions "snippetGetActions")]

One snippet in the file with tag Name miss title in the end
[!Code-C#[Main](CodeSnippet\test.cs#snippetGetActions)]

One snippet in the file with tag Name and special Name
[!Code-C#[snippetGetActions](CodeSnippet\test.cs#snippetGetActions)]

One snippet in the file with Code Line
[!Code-C#[Main](CodeSnippet\test.cs#L82-L92 "snippetGetActions")]

One snippet in the file with Code Line(? syntax)
[!Code-C#[Main](CodeSnippet\test.cs?start=82&end=92)]

One snippet in the file with tag Name(? syntax)
[!Code-C#[Main](CodeSnippet\test.cs?name=snippetGetActions "snippetGetActions")]

### Multiple Language
> [!div class="tabbedCodeSnippets" data-resources="OutlookServices.Calendar"]
>```C#
    using System;
```
>```VB
    Import System
```

> [!div class="tabbedCodeSnippets" data-resources="OutlookServices.Calendar"]
[!Code-C#[Main](CodeSnippet\test.cs?name=snippetGetActions "snippetGetActions")]
[!Code-C#[Main](CodeSnippet\test.cs?name=snippetGetActions "snippetGetActions")]

## Simple Selector
Todo
## Two-Way Selector
Todo
## Insert API


## Insert API – Swagger


RESTAPIdocs
{
    "api":  "Calendar Events",
    "operation":    "get events"
} 


## Reference a Swagger file (end of .md file)
```RESTAPI_Swagger
[!INCLUDE [calendar_api_get_event_by_id](Data\calendar_api_get_event_by_id.json)]
```

## Node of Bookmark1 
### Node of Bookmark with H3
