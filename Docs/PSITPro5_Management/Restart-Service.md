# Restart-Service

## SYNOPSIS
Stops and then starts one or more services.

## DESCRIPTION
The Restart-Service cmdlet sends a stop message and then a start message to the Windows Service Controller for a specified service.
If a service was already stopped, it is started without notifying you of an error.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass an object that represents each service that you want to restart.

## PARAMETERS

### DisplayName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Specifies the display names of services to be restarted.
Wildcards are permitted.


### Exclude [String[]]

Omits the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.


### Force [switch]

Restarts a service that has dependent services.


### Include [String[]]

Restarts only the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.


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




### InputObject [ServiceController[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipeline = $true,
  ParameterSetName = 'Set 1')]
```

Specifies ServiceController objects that represent the services to be restarted.
Enter a variable that contains the objects, or type a command or expression that gets the objects.


### Name [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 3')]
```

Specifies the service names of the services to be restarted.


### PassThru [switch]

Returns an object that represents the service.
By default, this cmdlet does not generate any output.



## INPUTS
### System.ServiceProcess.ServiceController, System.String

You can pipe a service object or a string that contains a service name to Restart-Service.

## OUTPUTS
### None or System.ServiceProcess.ServiceController

When you use the PassThru parameter, Restart-Service generates a System.ServiceProcess.ServiceController object that represents the restarted service.
Otherwise, this cmdlet does not generate any output.

## NOTES
Restart-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.

To find the service names and display names of the services on your system, type "get-service".
The service names appears in the Name column, and the display names appear in the DisplayName column.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>Restart-Service winmgmt

```
This command restarts the Windows Management Instrumentation service (WinMgmt) on the local computer.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>Restart-Service -DisplayName net* -Exclude "net logon"

```
This command restarts the services that have a display name that begins with "Net", except for the "Net Logon" service.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>Get-Service net* | Where-Object {$_.Status -eq "Stopped"} | Restart-Service

```
This command starts all of the stopped network services on the computer.

It uses the Get-Service cmdlet to get objects representing the services whose service name begins with "net". (The optional Name parameter name is omitted.) The pipeline operator (|) sends the services object to the Where-Object cmdlet, which selects only the services with a status of "stopped." Another pipeline operator sends the selected services to Restart-Service.
In practice, you would use the WhatIf parameter to see the effect of the command before using it.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293906)

[Get-Service]()

[New-Service]()

[Resume-Service]()

[Set-Service]()

[Start-Service]()

[Stop-Service]()

[Suspend-Service]()

