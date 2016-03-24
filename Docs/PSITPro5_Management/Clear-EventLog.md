# Clear-EventLog

## SYNOPSIS
Deletes all entries from specified event logs on the local or remote computers.

## DESCRIPTION
The Clear-EventLog cmdlet deletes all of the entries from the specified event logs on the local computer or on remote computers.
To use Clear-EventLog, you must be a member of the Administrators group on the affected computer.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## PARAMETERS

### ComputerName [String[]]

```powershell
[Parameter(
  Position = 2,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies a remote computer.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.


### InformationAction [System.Management.Automation.ActionPreference]]

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


Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.


### InformationVariable [System.String]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```


Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.


### LogName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the event logs.
Enter the log name (the value of the Log property; not the LogDisplayName) of one or more event logs, separated by commas.
Wildcard characters are not permitted.
This parameter is required.


### Confirm [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.


### WhatIf [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.



## INPUTS
### None

You cannot pipe objects to Clear-EventLog.

## OUTPUTS
### None

This cmdlet does not generate any output.

## NOTES
To use Clear-EventLog on Windows Vista and later versions of Windows, start Windows PowerShell with the "Run as administrator" option.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>clear-eventlog "Windows PowerShell"

```
This command deletes the entries from the "Windows PowerShell" event log on the local computer.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>clear-eventlog -logname ODiag, OSession -computername localhost, Server02

```
This command deletes all of the entries in the Microsoft Office Diagnostics (ODiag) and Microsoft Office Sessions (OSession) logs on the local computer and the Server02 remote computer.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>clear-eventlog -log application, system -confirm

```
This command prompts you for confirmation before deleting the entries in the specified event logs.






### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>function clear-all-event-logs ($computerName="localhost")
{
   $logs = get-eventlog -computername $computername -list | foreach {$_.Log}
   $logs | foreach {clear-eventlog -comp $computername -log $_ }
   get-eventlog -computername $computername -list
}

PS C:\>clear-all-event-logs -comp Server01

Max(K) Retain OverflowAction        Entries Log
------ ------ --------------        ------- ---
15,168      0 OverwriteAsNeeded           0 Application
15,168      0 OverwriteAsNeeded           0 DFS Replication
512      7 OverwriteOlder              0 DxStudio
20,480      0 OverwriteAsNeeded           0 Hardware Events
512      7 OverwriteOlder              0 Internet Explorer
20,480      0 OverwriteAsNeeded           0 Key Management Service
16,384      0 OverwriteAsNeeded           0 Microsoft Office Diagnostics
16,384      0 OverwriteAsNeeded           0 Microsoft Office Sessions
30,016      0 OverwriteAsNeeded           1 Security
15,168      0 OverwriteAsNeeded           2 System
15,360      0 OverwriteAsNeeded           0 Windows PowerShell

```
This function clears all event logs on the specified computers and then displays the resulting event log list.

Notice that a few entries were added to the System and Security logs after the logs were cleared but before they were displayed.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=289799)

[Get-EventLog]()

[Limit-EventLog]()

[New-EventLog]()

[Remove-EventLog]()

[Show-EventLog]()

[Write-EventLog]()

