# Stop-Service

## SYNOPSIS
Stops one or more running services.

## DESCRIPTION
The Stop-Service cmdlet sends a stop message to the Windows Service Controller for each of the specified services.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object representing the services that you want to stop.

## PARAMETERS

### DisplayName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Specifies the display names of the services to be stopped.
Wildcards are permitted.


### Exclude [String[]]

Omits the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.


### Force [switch]

Allows the cmdlet to stop a service even if that service has dependent services.


### Include [String[]]

Stops only the specified services.
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

Specifies ServiceController objects representing the services to be stopped.
Enter a variable that contains the objects, or type a command or expression that gets the objects.


### Name [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 3')]
```

Specifies the service names of the services to be stopped.
Wildcards are permitted.

The parameter name is optional.
You can use "Name" or its alias, "ServiceName", or you can omit the parameter name.


### NoWait [switch]




### PassThru [switch]

Returns an object representing the service.
By default, this cmdlet does not generate any output.


### Confirm [switch]

Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.


### WhatIf [switch]

Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.



## INPUTS
### System.ServiceProcess.ServiceController or System.String

You can pipe a service object or a string that contains the name of a service to Stop-Service.

## OUTPUTS
### None or System.ServiceProcess.ServiceController

When you use the PassThru parameter, Stop-Service generates a System.ServiceProcess.ServiceController object representing the service.
Otherwise, this cmdlet does not generate any output.

## NOTES
You can also refer to Stop-Service by its built-in alias, "spsv".
For more information, see about_Aliases.

Stop-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.

To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column and the display names appear in the DisplayName column.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>stop-service sysmonlog

```
This command stops the Performance Logs and Alerts (SysmonLog) service on the local computer.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>get-service -displayname telnet | stop-service

```
This command stops the Telnet service on the local computer.
The command uses the Get-Service cmdlet to get an object representing the Telnet service.
The pipeline operator (|) pipes the object to the Stop-Service cmdlet, which stops the service.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>get-service iisadmin | format-list -property name, dependentservices
PS C:\>stop-service iisadmin -force -confirm

```
The Stop-Service command stops the IISAdmin service on the local computer.
Because stopping this service also stops the services that depend on the IISAdmin service, it is best to precede the Stop-Service command with a command that lists the services that depend on the IISAdmin service.

The first command lists the services that depend on IISAdmin.
It uses the Get-Service cmdlet to get an object representing the IISAdmin service.
The pipeline operator (|) passes the result to the Format-List cmdlet.
The command uses the Property parameter of Format-List to list only the Name and DependentServices properties of the service.

The second command stops the IISAdmin service.
The Force parameter is required to stop a service that has dependent services.
The command uses the Confirm parameter to request confirmation from the user before stopping each service.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293923)

[Get-Service]()

[New-Service]()

[Restart-Service]()

[Resume-Service]()

[Set-Service]()

[Start-Service]()

[Suspend-Service]()

