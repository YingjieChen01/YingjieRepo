# Enable-ComputerRestore

## SYNOPSIS
Enables the System Restore feature on the specified file system drive.

## DESCRIPTION
The Enable-ComputerRestore cmdlet turns on the System Restore feature on one or more file system drives.
As a result, you can use tools, such as the Restore-Computer cmdlet, to restore the computer to a previous state.

By default, System Restore is enabled on all eligible drives, but you can disable it, such as by using the Disable-ComputerRestore cmdlet.
To enable (or re-enable) System Restore on any drive, it must be enabled on the system drive, either first or concurrently.
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

You cannot use this cmdlet to enable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot enable System Restore on drives that are not eligible for System Restore, such as external drives.

To enable System Restore on any drive, System Restore must be enabled on the system drive, either before or concurrently.


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


You cannot use this cmdlet to enable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot enable System Restore on drives that are not eligible for System Restore, such as external drives.

To enable System Restore on any drive, System Restore must be enabled on the system drive, either before or concurrently.


### InformationVariable [System.String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```


You cannot use this cmdlet to enable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot enable System Restore on drives that are not eligible for System Restore, such as external drives.

To enable System Restore on any drive, System Restore must be enabled on the system drive, either before or concurrently.


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

You cannot pipe objects to this cmdlet.

## OUTPUTS
### None

This cmdlet does not generate any output.

## NOTES
To run an Enable-ComputerRestore command on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

To find the file system drives that are eligible for system restore, in System in Control Panel, see the System Protection tab.
To open this tab in Windows PowerShell, type "SystemPropertiesProtection".

This cmdlet uses the Windows Management Instrumentation (WMI) SystemRestore class.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>enable-computerrestore -drive "C:\"

```
This command enables System Restore on the C: drive of the local computer.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>enable-computerrestore -drive "C:\", "D:\"

```
This command enables System Restore on the C: and D: drives of the local computer.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=290487)

[Checkpoint-Computer]()

[Disable-ComputerRestore]()

[Get-ComputerRestorePoint]()

[Restart-Computer]()

[Restore-Computer]()

