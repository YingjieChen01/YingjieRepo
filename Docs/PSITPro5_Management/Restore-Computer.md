# Restore-Computer

## SYNOPSIS
Starts a system restore on the local computer.

## DESCRIPTION
The Restore-Computer cmdlet restores the local computer to the specified system restore point.

A Restore-Computer command restarts the computer.
The restore is completed during the restart operation.

System restore points and the Restore-Computer cmdlet are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.

## PARAMETERS

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




### RestorePoint [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the sequence number of the restore point.
To find the sequence number, use Get-ComputerRestorePoint.
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

You cannot pipe input to this cmdlet.

## OUTPUTS
### None

This cmdlet does not generate any output.

## NOTES
To run a Restore-Computer command on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

This cmdlet uses the Windows Management Instrumentation (WMI) SystemRestore class.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>restore-computer -RestorePoint 253

```
This command restores the local computer to the restore point with sequence number 253.

Because the RestorePoint parameter is positional, you can omit the parameter name.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>restore-computer 255 -confirm

Confirm
Are you sure you want to perform this action?
Performing operation "Restore-Computer" .
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):

```
This command restores the local computer to the restore point with sequence number 255.
It uses the Confirm parameter to prompt the user before actually performing the operation.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>Get-ComputerRestorePoint
PS C:\>Restore-Computer -RestorePoint 255
PS C:\>Get-ComputerRestorePoint -LastStatus

```
These commands run a system restore and then check its status.

The first command uses the Get-ComputerRestorePoint cmdlet to get the restore points on the local computer.

The second command uses Restore-Computer to restore the computer to the restore point with sequence number 255.

The third command uses the LastStatus parameter of Get-ComputerRestorePoint cmdlet to check the status of the restore operation.
Because the Restore-Computer command forces a restart, this command would be entered when the computer restarted.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293907)

[Checkpoint-Computer]()

[Disable-ComputerRestore]()

[Enable-ComputerRestore]()

[Get-ComputerRestorePoint]()

[Restart-Computer]()

