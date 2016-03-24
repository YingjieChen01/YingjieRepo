# Get-EventLog

## SYNOPSIS
Gets the events in an event log, or a list of the event logs, on the local or remote computers.

## DESCRIPTION
The Get-EventLog cmdlet gets events and event logs on the local and remote computers.

Use the parameters of Get-EventLog to search for events by using their property values.
Get-EventLog gets only the events that match all of the specified property values.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## PARAMETERS

### After [DateTime]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Gets only the events that occur after the specified date and time.
Enter a DateTime object, such as the one returned by the Get-Date cmdlet.


### AsBaseObject [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Returns a standard System.Diagnostics.EventLogEntry object for each event.
Without this parameter, Get-EventLog returns an extended PSObject object with additional EventLogName, Source, and InstanceId properties.

To see the effect of this parameter, pipe the events to the Get-Member cmdlet and examine the TypeName value in the result.


### AsString [switch]

```powershell
[Parameter(ParameterSetName = 'Set 2')]
```

Returns the output as strings, instead of objects.


### Before [DateTime]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Gets only the events that occur before the specified date and time.
Enter a DateTime object, such as the one returned by the Get-Date cmdlet.


### ComputerName [String[]]

Specifies a remote computer.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.


### EntryType [String[]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[ValidateSet(
  'Error',
  'Information',
  'FailureAudit',
  'SuccessAudit',
  'Warning')]
```

Gets only events with the specified entry type.
Valid values are Error, Information, FailureAudit, SuccessAudit, and Warning.
The default is all events.


### Index [Int32[]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Gets only events with the specified index values.


### InformationAction [System.Management.Automation.ActionPreference]

```powershell
[ValidateSet(
  'SilentlyContinue',
  'Stop',
  'Continue',
  'Inquire',
  'Ignore',
  'Suspend')]
```




### InformationVariable [System.String]




### InstanceId [Int64[]]

```powershell
[Parameter(
  Position = 2,
  ParameterSetName = 'Set 1')]
```

Gets only events with the specified instance IDs.


### List [switch]

```powershell
[Parameter(ParameterSetName = 'Set 2')]
```

Gets a list of event logs on the computer.


### LogName [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the event log.
Enter the log name (the value of the Log property; not the LogDisplayName) of one event log.
Wildcard characters are not permitted.
This parameter is required.


### Message [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Gets events that have the specified string in their messages.
You can use this property to search for messages that contain certain words or phrases.
Wildcards are permitted.


### Newest [Int32]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the maximum number of events retrieved.
Get-EventLog gets the specified number of events, beginning with the newest event in the log.


### Source [String[]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Gets events that were written to the log by the specified sources.
Wildcards are permitted.


### UserName [String[]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Gets only the events that are associated with the specified user names.
Enter names or name patterns, such as User01, User*, or Domain01\User*.
Wildcards are permitted.



## INPUTS
### None.

You cannot pipe input to this cmdlet.

## OUTPUTS
### System.Diagnostics.EventLogEntry. System.Diagnostics.EventLog. System.String

If the LogName parameter is specified, the output is a collection of EventLogEntry objects (System.Diagnostics.EventLogEntry).

If only the List parameter is specified, the output is a collection of EventLog objects (System.Diagnostics.EventLog).

If both the List and AsString parameters are specified, the output is a collection of Strings (System.String).

## NOTES
The Get-EventLog and Get-WinEvent cmdlets are not supported in Windows Preinstallation Environment (Windows PE).

## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>get-eventlog -list

```
This command gets the event logs on the computer.


### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>get-eventlog -newest 5 -logname application

```
This command gets the five most recent entries from the Application event log.


### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>$events = get-eventlog -logname system -newest 1000
PS C:\>$events | group-object -property source -noelement | sort-object -property count –descending

Count Name
----- ----
75    Service Control Manager
12    Print
6     UmrdpService
2     DnsApi
2     DCOM
1     Dhcp
1     TermDD
1     volsnap

```
This example shows how to find all of the sources that are represented in the 1000 most recent entries in the System event log.

The first command gets the 1,000 most recent entries from the System event log and stores them in the $events variable.

The second command uses a pipeline operator (|) to send the events in $events to the Group-Object cmdlet, which groups the entries by the value of the Source property.
The command uses a second pipeline operator to send the grouped events to the Sort-Object cmdlet, which sorts them in descending order, so the most frequently appearing source is listed first.

Source is just one property of event log entries.
To see all of the properties of an event log entry, pipe the event log entries to the Get-Member cmdlet.


### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>get-eventlog -logname System -EntryType Error

```
This command gets only error events from the System event log.


### -------------------------- EXAMPLE 5 --------------------------

```powershell
PS C:\>get-eventlog -logname System -instanceID 3221235481 -Source "DCOM"

```
This command gets events from the System log that have an InstanceID of 3221235481 and a Source value of "DCOM."


### -------------------------- EXAMPLE 6 --------------------------

```powershell
PS C:\>get-eventlog -logname "Windows PowerShell" -computername localhost, Server01, Server02

```
This command gets the events from the "Windows PowerShell" event log on three computers, Server01, Server02, and the local computer, known as "localhost".


### -------------------------- EXAMPLE 7 --------------------------

```powershell
PS C:\>get-eventlog -logname "Windows PowerShell" -message "*failed*"

```
This command gets all the events in the Windows PowerShell event log that have a message value that includes the word "failed".


### -------------------------- EXAMPLE 8 --------------------------

```powershell
PS C:\>$a = get-eventlog -log System -newest 1
PS C:\>$a | format-list -property *

EventID            : 7036
MachineName        : Server01
Data               : {}
Index              : 10238
Category           : (0)
CategoryNumber     : 0
EntryType          : Information
Message            : The description for Event ID
Source             : Service Control Manager
ReplacementStrings : {WinHTTP Web Proxy Auto-Disco
InstanceId         : 1073748860
TimeGenerated      : 4/11/2008 9:56:05 PM
TimeWritten        : 4/11/2008 9:56:05 PM
UserName           :
Site               :
Container          :

```
This example shows how to display the property values of an event in a list.

The first command gets the newest event from the System event log and saves it in the $a variable.

The second command uses a pipeline operator (|) to send the event in $a to the Format-List command, which displays all (*) of the event properties.


### -------------------------- EXAMPLE 9 --------------------------

```powershell
PS C:\>get-eventlog -log application -source outlook | where {$_.eventID -eq 34}

```
This command gets events in the Application event log where the source is Outlook and the event ID is 34.
Even though Get-EventLog does not have an EventID parameter, you can use the Where-Object cmdlet to select events based on the value of any event property.


### -------------------------- EXAMPLE 10 --------------------------

```powershell
PS C:\>get-eventlog -log system -username NT* | group-object -property username -noelement | format-table Count, Name -auto

Count Name
----- ----
6031  NT AUTHORITY\SYSTEM
42    NT AUTHORITY\LOCAL SERVICE
4     NT AUTHORITY\NETWORK SERVICE

```
This command returns the events in the system log grouped by the value of  their UserName property.
The Get-EventLog command uses the UserName parameter to get only events in which the user name begins with "NT*".


### -------------------------- EXAMPLE 11 --------------------------

```powershell
PS C:\>$May31 = get-date 5/31/08
PS C:\>$July1 = get-date 7/01/08
PS C:\>get-eventlog -log "Windows PowerShell" -entrytype Error -after $may31 -before $july1

```
This command gets all of the errors in the Windows PowerShell event log that occurred in June 2008.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=290493)

[Clear-EventLog]()

[Limit-EventLog]()

[New-EventLog]()

[Remove-EventLog]()

[Show-EventLog]()

[Write-EventLog]()

