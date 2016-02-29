# Show-EventLog

## SYNOPSIS
Displays the event logs of the local or a remote computer in Event Viewer.

## DESCRIPTION
The Show-EventLog cmdlet opens Event Viewer on the local computer and displays in it all of the classic event logs on the local computer or a remote computer.

To open Event Viewer on Windows Vista and later versions of Windows, the current user must be a member of the Administrators group on the local computer.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## PARAMETERS

### ComputerName [String]

```powershell
[Parameter(
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies a remote computer.
Show-EventLog displays the event logs from the specified computer in Event Viewer on the local computer.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.

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


Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.


### InformationVariable [System.String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```


Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.



## INPUTS
### None

You cannot pipe input to this cmdlet.

## OUTPUTS
### None

This cmdlet does not generate any output.

## NOTES
The Windows PowerShell command prompt returns as soon as Event Viewer opens.
You can work in the current session while Event Viewer is open.

Because this cmdlet requires a user interface, it does not work on Server Core installations of Windows Server.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>show-eventlog

```
This command opens Event Viewer and displays in it the classic event logs on the local computer.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>show-eventlog -computername Server01

```
This command opens Event Viewer and displays in it the classic event logs on the Server01 computer.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293916)

[Clear-EventLog]()

[Get-EventLog]()

[Limit-EventLog]()

[New-EventLog]()

[Remove-EventLog]()

[Write-EventLog]()

