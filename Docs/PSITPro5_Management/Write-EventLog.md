# Write-EventLog

## SYNOPSIS
Writes an event to an event log.

## DESCRIPTION
The Write-EventLog cmdlet writes an event to an event log.

To write an event to an event log, the event log must exist on the computer and the source must be registered for the event log.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## PARAMETERS

### Category [Int16]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies a task category for the event.
Enter an integer that is associated with the strings in the category message file for the event log.


### ComputerName [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies a remote computer.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.


### EntryType [EventLogEntryType]

```powershell
[Parameter(
  Position = 4,
  ParameterSetName = 'Set 1')]
[ValidateSet(
  'Error',
  'Warning',
  'Information',
  'SuccessAudit',
  'FailureAudit')]
```

Specifies the entry type of the event.
Valid values are Error, Warning, Information, SuccessAudit, and FailureAudit.
The default value is Information.

For a description of the values, see System.Diagnostics.EventLogEntryType in the [MSDN library]() at http://go.microsoft.com/fwlink/?LinkId=143599.


### EventId [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ParameterSetName = 'Set 1')]
```

Specifies the event identifier.
This parameter is required.
The maximum allowed value for the EventId parameter is 65535.


### InformationAction [System.Management.Automation.ActionPreference]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[ValidateSet(
  'SilentlyContinue',
  'Stop',
  'Continue',
  'Inquire',
  'Ignore',
  'Suspend')]
```




### InformationVariable [System.String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```




### LogName [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the name of the log to which the event is written.
Enter the log name (the value of the Log property, not the LogDisplayName).
Wildcard characters are not permitted.
This parameter is required.


### Message [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 5,
  ParameterSetName = 'Set 1')]
```

Specifies the event message.
This parameter is required.


### RawData [Byte[]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the binary data that is associated with the event, in bytes.


### Source [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ParameterSetName = 'Set 1')]
```

Specifies the event source, which is typically the name of the application that is writing the event to the log.



## INPUTS
### None

You cannot pipe input to this cmdlet.

## OUTPUTS
### System.Diagnostics.EventLogEntry

Write-EventLog returns objects that represents the events in the logs.

## NOTES
To use Write-EventLog, start Windows PowerShell with the "Run as administrator" option.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>write-eventlog -logname Application -source MyApp -eventID 3001 -entrytype Information -message "MyApp added a user-requested feature to the display." -category 1 -rawdata 10,20

```
This command writes an event from the MyApp source to the Application event log.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>write-eventlog -computername Server01 -logname Application -source MyApp -eventID 3001 -message "MyApp added a user-requested feature to the display."

```
This command writes an event from the MyApp source to the Application event log on the Server01 remote computer.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293931)

[Clear-EventLog]()

[Get-EventLog]()

[Limit-EventLog]()

[New-EventLog]()

[Remove-EventLog]()

[Show-EventLog]()

[Write-EventLog]()

