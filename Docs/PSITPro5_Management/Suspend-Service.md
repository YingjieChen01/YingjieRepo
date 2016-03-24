# Suspend-Service

## SYNOPSIS
Suspends (pauses) one or more running services.

## DESCRIPTION
The Suspend-Service cmdlet sends a suspend message to the Windows Service Controller for each of the specified services.
While suspended, the service is still running, but its action is halted until resumed, such as by using Resume-Service.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object representing the services that you want to suspend.

## PARAMETERS

### DisplayName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Specifies the display names of the services to be suspended.
Wildcards are permitted.


### Exclude [String[]]

Omits the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.


### Include [String[]]

Suspends only the specified services.
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

Specifies ServiceController objects representing the services to be suspended.
Enter a variable that contains the objects, or type a command or expression that gets the objects.


### Name [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 3')]
```

Specifies the service names of the services to be suspended.
Wildcards are permitted.

The parameter name is optional.
You can use "Name" or its alias, "ServiceName", or you can omit the parameter name.


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

You can pipe a service object or a string that contains a service name to Suspend-Service.

## OUTPUTS
### None or System.ServiceProcess.ServiceController

When you use the PassThru parameter, Suspend-Service generates a System.ServiceProcess.ServiceController object representing the service.
Otherwise, this cmdlet does not generate any output.

## NOTES
Suspend-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.

Also, Suspend-Service can suspend only services that support being suspended and resumed.
To determine whether a particular service can be suspended, use the Get-Service cmdlet with the CanPauseAndContinue property.
For example, "get-service wmi | format-list name, canpauseandcontinue".
To find all services on the computer that can be suspended, type "get-service | where-object {$_.canpauseandcontinue -eq "True"}".

To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column, and the display names appear in the DisplayName column.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>suspend-service -displayname "Telnet"

```
This command suspends the Telnet service (Tlntsvr) service on the local computer.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>suspend-service -name lanman* -whatif

```
This command tells what would happen if you suspended the services that have a service name that begins with "lanman".
To suspend the services, rerun the command without the WhatIf parameter.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>get-service schedule | suspend-service

```
This command uses the Get-Service cmdlet to get an object that represents the Task Scheduler (Schedule) service on the computer.
The pipeline operator (|) passes the result to the Suspend-Service cmdlet, which suspends the service.






### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>get-service | where-object {$_.canpauseandcontinue -eq "True"} | suspend-service -confirm

```
This command suspends all of the services on the computer that can be suspended.
It uses the Get-Service cmdlet to get objects representing the services on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects only the services that have a value of "True" for the CanPauseAndContinue property.
Another pipeline operator passes the results to the Suspend-Service cmdlet.
The Confirm parameter prompts you for confirmation before suspending each of the services.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293924)

[Get-Service]()

[New-Service]()

[Restart-Service]()

[Resume-Service]()

[Set-Service]()

[Start-Service]()

[Stop-Service]()

