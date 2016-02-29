# Disable-ComputerRestore

## SYNOPSIS
Disables the System Restore feature on the specified file system drive.

## DESCRIPTION
The Disable-ComputerRestore cmdlet turns off the System Restore feature on one or more file system drives.
As a result, attempts to restore the computer do not affect the specified drive.

To disable System Restore on any drive, it must be disabled on the system drive, either first or concurrently.

To re-enable System Restore, use the Enable-ComputerRestore cmdlet.
To find the state of System Restore for each drive, use Rstrui.exe.

System restore points and the ComputerRestore cmdlets are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.

## PARAMETERS

### Drive [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the file system drives.
Enter one or more file system drive letters, each followed by a colon and a backslash and enclosed in quotation marks, such as "C:\" or "D:\".
This parameter is required.

You cannot use this cmdlet to disable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot disable System Restore on drives that are not eligible for System Restore, such as external drives.

To disable System Restore on any drive, System Restore must be disabled on the system drive, either before or concurrently.


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


You cannot use this cmdlet to disable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot disable System Restore on drives that are not eligible for System Restore, such as external drives.

To disable System Restore on any drive, System Restore must be disabled on the system drive, either before or concurrently.


### InformationVariable [System.String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```


You cannot use this cmdlet to disable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot disable System Restore on drives that are not eligible for System Restore, such as external drives.

To disable System Restore on any drive, System Restore must be disabled on the system drive, either before or concurrently.


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
To run a Disable-ComputerRestore command on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

To find the file system drives that are eligible for system restore, in System in Control Panel, see the System Protection tab.
To open this tab in Windows PowerShell, type "SystemPropertiesProtection".

This cmdlet uses the Windows Management Instrumentation (WMI) SystemRestore class.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>disable-computerrestore -drive "C:\"

```
This command disables System Restore on the C: drive.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>disable-computerrestore "C:\", "D:\"

```
This command disables System Restore on the C: and D: drives.
The command uses the Drive parameter, but it the omits the optional parameter name.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=290486)

[Checkpoint-Computer]()

[Enable-ComputerRestore]()

[Get-ComputerRestorePoint]()

[Restart-Computer]()

[Restore-Computer]()

