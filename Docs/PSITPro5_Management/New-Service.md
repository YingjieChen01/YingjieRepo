# New-Service

## SYNOPSIS
Creates a new Windows service.

## DESCRIPTION
The New-Service cmdlet creates a new entry for a Windows service in the registry and in the service database.
A new service requires an executable file that executes during the service.

The parameters of this cmdlet let you set the display name, description, startup type, and dependencies of the service.

## PARAMETERS

### BinaryPathName [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ParameterSetName = 'Set 1')]
```

Specifies the path to the executable file for the service.
This parameter is required.


### Credential [PSCredential]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies a user account that has permission to perform this action.
Type a user name, such as "User01" or "Domain01\User01".
Or, enter a PSCredential object, such as one from the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.


### DependsOn [String[]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the names of other services upon which the new service depends.
To enter multiple service names, use a comma to separate the names.


### Description [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies a description of the service.


### DisplayName [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies a display name for the service.


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




### Name [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the name of the service.
This parameter is required.


### StartupType [ServiceStartMode]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[ValidateSet(
  'Automatic',
  'Manual',
  'Disabled')]
```

Sets the startup type of the service.  "Automatic" is the default.

Valid values are:

--  Manual:      The service is started only manually, by a user (using the Service Control Manager) or by an application.

--  Automatic:  The service is to be started (or was started) by the operating system, at system start-up.
If an automatically started service depends on a manually started service, the manually started service is also started automatically at system startup.

-- Disabled: The service is disabled and cannot be started by a user or application.



## INPUTS
### None

You cannot pipe input to this cmdlet.

## OUTPUTS
### System.ServiceProcess.ServiceController

New-Service returns an object that represents the new service.

## NOTES
To run this cmdlet on Windows Vista and later versions of Windows, start Windows PowerShell with the "Run as administrator" option.

To delete a service, use Sc.exe, or use the Get-WmiObject cmdlet to get the Win32_Service object that represents the service and then use the Delete method to delete the service. (The object that Get-Service returns does not have a delete method.) For an example, see the Examples section.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>new-service -name TestService -binaryPathName "C:\WINDOWS\System32\svchost.exe -k netsvcs"

```
This command creates a new service named "TestService".






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>new-service -name TestService -binaryPathName "C:\WINDOWS\System32\svchost.exe -k netsvcs" -dependson NetLogon -displayName "Test Service" -StartupType Manual -Description "This is a test service."

```
This command creates a new service named "TestService".
It uses the parameters of the New-Service cmdlet to specify a description, startup type, and display name for the new service.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>get-wmiobject win32_service -filter "name='testservice'"

ExitCode  : 0
Name      : testservice
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK

```
This command uses the Get-WmiObject cmdlet to get the Win32_Service object for the new service.
This object includes the start mode and the service description.






### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>sc.exe delete TestService
- or -
PS C:\>(get-wmiobject win32_service -filter "name='TestService'").delete()

```
This example shows two ways to delete the TestService service.
The first command uses the delete option of Sc.exe.
The second command uses the Delete method of the Win32_Service objects that the Get-WmiObject cmdlet returns.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293889)

[Get-Service]()

[Restart-Service]()

[Resume-Service]()

[Set-Service]()

[Start-Service]()

[Stop-Service]()

[Suspend-Service]()

