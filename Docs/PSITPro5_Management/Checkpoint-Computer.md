# Checkpoint-Computer

## SYNOPSIS
Creates a system restore point on the local computer.

## DESCRIPTION
The Checkpoint-Computer cmdlet creates a system restore point on the local computer.

System restore points and the Checkpoint-Computer cmdlet are supported only on client operating systems, such as Windows 8, Windows 7, Windows Vista, and Windows XP.

Beginning in Windows 8, Checkpoint-Computer cannot create more than one checkpoint each day.

## PARAMETERS

### Description [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies a descriptive name for the restore point.
This parameter is required.


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




### RestorePointType [String]

```powershell
[Parameter(
  Position = 2,
  ParameterSetName = 'Set 1')]
[ValidateSet(
  'APPLICATION_INSTALL',
  'APPLICATION_UNINSTALL',
  'DEVICE_DRIVER_INSTALL',
  'MODIFY_SETTINGS',
  'CANCELLED_OPERATION')]
```

Specifies the type of restore point.
The default is APPLICATION_INSTALL.

Valid values are APPLICATION_INSTALL, APPLICATION_UNINSTALL, DEVICE_DRIVER_INSTALL, MODIFY_SETTINGS, and CANCELLED_OPERATION.



## INPUTS
### None

You cannot pipe objects to Checkpoint-Computer.

## OUTPUTS
### None

This cmdlet does not generate any output.

## NOTES
This cmdlet uses the CreateRestorePoint method of the SystemRestore class with a BEGIN_SYSTEM_CHANGE event.

Beginning in Windows 8, Checkpoint-Computer cannot create more than one system restore point each day.
If you try to create a new restore point before the 24-hour period has elapsed, Windows PowerShell generates the following error:

"A new system restore point cannot be created because one has already been created within the past 24 hours.
Please try again later."

## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>Checkpoint-Computer -Description "Install MyApp"

```
This command creates a system restore point called "Install MyApp".
It uses the default APPLICATION_INSTALL restore point type.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>Checkpoint-Computer -Description "ChangeNetSettings" -RestorePointType MODIFY_SETTINGS

```
This command creates a MODIFY_SETTINGS system restore point called "ChangeNetSettings".







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=289797)

[Disable-ComputerRestore]()

[Enable-ComputerRestore]()

[Get-ComputerRestorePoint]()

[Restore-Computer]()

