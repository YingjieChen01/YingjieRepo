# New-EventLog

## SYNOPSIS
Creates a new event log and a new event source on a local or remote computer.

## DESCRIPTION
This cmdlet creates a new classic event log on a local or remote computer.
It can also register an event source that writes to the new log or to an existing log.

The cmdlets that contain the EventLog noun (the Event log cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## PARAMETERS

### CategoryResourceFile [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the path to the file that contains category strings for the source events.
This file is also known as the Category Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.


### ComputerName [String[]]

```powershell
[Parameter(
  Position = 3,
  ParameterSetName = 'Set 1')]
```

Creates the new event logs on the specified computers.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.


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


The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.


### InformationVariable [System.String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```


The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.


### LogName [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the name of the event log.

If the log does not exist, New-EventLog creates the log and uses this value for the Log and LogDisplayName properties of the new event log.
If the log exists, New-EventLog registers a new source for the event log.


### MessageResourceFile [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the path to the file that contains message formatting strings for the source events.
This file is also known as the Event Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.


### ParameterResourceFile [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the path to the file that contains strings used for parameter substitutions in event descriptions.
This file is also known as the Parameter Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.


### Source [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ParameterSetName = 'Set 1')]
```

Specifies the names of the event log sources, such as application programs that write to the event log.
This parameter is required.



## INPUTS
### None

You cannot pipe input to this cmdlet.

## OUTPUTS
### System.Diagnostics.EventLogEntry



## NOTES
To use New-EventLog on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

To create an event source in Windows Vista, Windows XP Professional, or Windows Server 2003, you must be a member of the Administrators group on the computer.

When you create a new event log and a new event source, the system registers the new source for the new log, but the log is not created until the first entry is written to it.

The operating system stores event logs as files.
When you create a new event log, the associated file is stored in the %SystemRoot%\System32\Config directory on the specified computer.
The file name is the first eight characters of the Log property with an .evt file name extension.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>new-eventlog -source TestApp -logname TestLog -MessageResourceFile C:\Test\TestApp.dll

```
This command creates the TestLog event log on the local computer and registers a new source for it.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>$file = "C:\Program Files\TestApps\NewTestApp.dll"
PS C:\>new-eventlog -computername Server01 -source NewTestApp -logname Application -MessageResourceFile $file -CategoryResourceFile $file

```
This command adds a new event source, NewTestApp, to the Application log on the Server01 remote computer.

The command requires that the NewTestApp.dll file is located on the Server01 computer.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293885)

[Clear-EventLog]()

[Get-EventLog]()

[Limit-EventLog]()

[New-EventLog]()

[Remove-EventLog]()

[Show-EventLog]()

[Write-EventLog]()

