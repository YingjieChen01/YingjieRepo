﻿# Set-Service

## SYNOPSIS
Starts, stops, and suspends a service, and changes its properties.

## DESCRIPTION
The Set-Service cmdlet changes the properties of a local or remote service, including the status, description, display name, and start mode.
You can use this cmdlet to start, stop, or suspend (pause) a service.
To identify the service, enter its service name or submit a service object, or pipe a service name or service object to Set-Service.

## PARAMETERS

### ComputerName [String[]]

```powershell
[Parameter(ValueFromPipelineByPropertyName = $true)]
```

Specifies one or more computers.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Set-Service even if your computer is not configured to run remote commands.


### Description [String]

Specifies a new description for the service.

The service description appears in Services in Computer Management.
Description is not a property of the ServiceController object that Get-Service gets.
To see the service description, use Get-WmiObject to get a Win32_Service object that represents the service.


### DisplayName [String]

Specifies a new display name for the service.


### InformationAction [System.Management.Automation.ActionPreference]]

```powershell
[ValidateSet(
  'SilentlyContinue',
  'Stop',
  'Continue',
  'Inquire',
  'Ignore',
  'Suspend')]
```


Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Set-Service even if your computer is not configured to run remote commands.


### InformationVariable [System.String]]


Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Set-Service even if your computer is not configured to run remote commands.


### InputObject [ServiceController]

```powershell
[Parameter(
  ValueFromPipeline = $true,
  ParameterSetName = 'Set 2')]
```

Specifies a ServiceController object that represents the service to be changed.
Enter a variable that contains the object, or type a command or expression that gets the object, such as a Get-Service command.
You can also pipe a service object to Set-Service.


### Name [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipeline = $true,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the service name of the service to be changed.
Wildcards are not permitted.
You can also pipe a service name to Set-Service.


### PassThru [switch]

Returns objects that represent the services that were changed.
By default, this cmdlet does not generate any output.


### StartupType [ServiceStartMode]

```powershell
[ValidateSet(
  'Automatic',
  'Manual',
  'Disabled')]
```

Changes the start mode of the service.
Valid values for StartupType are:

-- Automatic: Start when the system starts.

-- Manual: Starts only when started by a user or program.

-- Disabled: Cannot be started.


### Status [String]

```powershell
[ValidateSet(
  'Running',
  'Stopped',
  'Paused')]
```

Starts, stops, or suspends (pauses) the services.
Valid values are:

-- Running: Starts the service.

-- Stopped: Stops the service.

-- Paused: Suspends the service.



## INPUTS
### System.ServiceProcess.ServiceController, System.String

You can pipe a service object or a string that contains a service name to Set-Service.

## OUTPUTS
### System.ServiceProcess.ServiceController

This cmdlet does not return any objects.

## NOTES
To use Set-Service on Windows Vista and later versions of Windows, start Windows PowerShell with the "Run as administrator" option.
Set-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.
To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column and the display names appear in the DisplayName column.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>set-service -name lanmanworkstation -DisplayName "LanMan Workstation"

```
This command changes the display name of the lanmanworkstation service to "LanMan Workstation". (The default is "Workstation".)






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>get-wmiobject win32_service -filter "name = 'SysmonLog'"

ExitCode  : 0
Name      : SysmonLog
ProcessId : 0
StartMode : Manual
State     : Stopped
Status    : OK
PS C:\>set-service sysmonlog -startuptype automatic
PS C:\>get-wmiobject win32_service -filter "name = 'SysmonLog'"
ExitCode  : 0
Name      : SysmonLog
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK

PS C:\>get-wmiobject win32_service | format-table Name, StartMode -auto

Name                                  StartMode
----                                  ---------
AdtAgent                              Auto
Alerter                               Disabled
ALG                                   Manual
AppMgmt                               Manual
...

```
These commands get the startup type of the Performance Logs and Alerts (SysmonLog) service, set the start mode to automatic, and then display the result of the change.

These commands use the Get-WmiObject cmdlet to get the Win32_Service object for the service, because the ServiceController object that Get-Service returns does not include the start mode.

The first command uses the Get-WmiObject cmdlet to get the Windows Management Instrumentation (WMI) object that represents the SysmonLog service.
The default output of this command displays the start mode of the service.

The second command uses Set-Service to change the start mode to automatic.
Then, the first command is repeated to display the change.

The final command displays the start mode of all services on the computer.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>set-service -name Schedule -computername S1 -description "Configures and schedules tasks."
PS C:\>get-wmiobject win32_service -computername s1 | where-object {$_.Name -eq "Schedule"} | format-list Name, Description

```
These commands change the description of the Task Scheduler service on the S1 remote computer and then display the result.

These commands use the Get-WmiObject cmdlet to get the Win32_Service object for the service, because the ServiceController object that Get-Service returns does not include the service description.

The first command  uses a Set-Service command to change the description.
It identifies the service by using the service name of the service, "Schedule".

The second command uses the Get-WmiObject cmdlet to get an instance of the WMI Win32_Service that represents the Task Scheduler service.
The first element in the command gets all instances of the Win32_service class.

The pipeline operator (|) passes the result to the Where-Object cmdlet, which selects instances with a value of "Schedule" in the Name property.

Another pipeline operator sends the result to the Format-List cmdlet, which formats the output as a list with only the Name and Description properties.






### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>set-service winrm -status Running -passthru -computername Server02

```
This command starts the WinRM service on the Server02 computer.
The command uses the Status parameter to specify the desired status ("running") and the PassThru parameter to direct Set-Service to return an object that represents the WinRM service.






### -------------------------- EXAMPLE 5 --------------------------

```powershell
PS C:\>get-service schedule -computername S1, S2 | set-service -status paused

```
This command suspends the Schedule service on the S1 and S2 remote computers.
It uses the Get-Service cmdlet to get the service.
A pipeline operator (|) sends the service to the Set-Service cmdlet, which changes its status to "Paused".






### -------------------------- EXAMPLE 6 --------------------------

```powershell
PS C:\>$s = get-service schedule
PS C:\>set-service -inputobject $s -status stopped

```
These commands stop the Schedule service on the local computer.

The first command uses the Get-Service cmdlet to get the Schedule service.
The command saves the service in the $s variable.

The second command uses the Set-Service cmdlet to change the status of the Schedule service to "Stopped".
It uses the InputObject parameter to submit the service stored in the $s variable, and it uses the Status parameter to specify the desired status.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293913)

[Get-Service]()

[New-Service]()

[Restart-Service]()

[Resume-Service]()

[Start-Service]()

[Stop-Service]()

[Suspend-Service]()

