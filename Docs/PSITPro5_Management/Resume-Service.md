# Resume-Service

## SYNOPSIS
Resumes one or more suspended (paused) services.

## DESCRIPTION
The Resume-Service cmdlet sends a resume message to the Windows Service Controller for each of the specified services.
If they have been suspended, they will resume service.
If they are currently running, the message is ignored.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object that represents the services that you want to resume.

## PARAMETERS

### DisplayName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Specifies the display names of the services to be resumed.
Wildcards are permitted.


### Exclude [String[]]

Omits the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.


### Include [String[]]

Resumes only the specified services.
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

Specifies ServiceController objects representing the services to be resumed.
Enter a variable that contains the objects, or type a command or expression that gets the objects.


### Name [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 3')]
```

Specifies the service names of the services to be resumed.

The parameter name is optional.
You can use "-Name" or its alias, "-ServiceName", or you can omit the parameter name.


### PassThru [switch]

Returns an object representing the service.
By default, this cmdlet does not generate any output.



## INPUTS
### System.ServiceProcess.ServiceController or System.String

You can pipe a service object or a string that contains a service name to Resume-Service.

## OUTPUTS
### None or System.ServiceProcess.ServiceController

When you use the PassThru parameter, Resume-Service generates a System.ServiceProcess.ServiceController object representing the resumed service.
Otherwise, this cmdlet does not generate any output.

## NOTES
The status of services that have been suspended is "Paused".
When services are resumed, their status is "Running".

Resume-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.

To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column, and the display names appear in the DisplayName column.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>resume-service sens

```
This command resumes the System Event Notification service (the service name is represented in the command by "sens") on the local computer.
The command uses the Name parameter to specify the service name of the service, but the command omits the parameter name because the parameter name is optional.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>get-service | where-object {$_.Status -eq "Paused"} | resume-service

```
This command resumes all of the suspended (paused) services on the computer.
The first command gets all of the services on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects the services with a Status property of "Paused".
The next pipeline operator sends the results to Resume-Service, which resumes the paused services.

In practice, you would use the WhatIf parameter to determine the effect of the command before running it without WhatIf.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293908)

[Get-Service]()

[New-Service]()

[Restart-Service]()

[Set-Service]()

[Start-Service]()

[Stop-Service]()

[Suspend-Service]()

