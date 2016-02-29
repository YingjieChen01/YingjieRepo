# Remove-PSDrive

## SYNOPSIS
Deletes temporary Windows PowerShell drives and disconnects mapped network drives.

## DESCRIPTION
The Remove-PSDrive cmdlet deletes temporary Windows PowerShell drives that were created by using the New-PSDrive cmdlet.

Beginning in Windows PowerShell 3.0, Remove-PSDrive also disconnects mapped network drives, including, but not limited to, drives created by using the Persist parameter of New-PSDrive.

Remove-PSDrive cannot delete Windows physical or logical drives.

Beginning in Windows PowerShell 3.0, when an external drive is connected to the computer, Windows PowerShell automatically adds a PSDrive to the file system that represents the new drive.
You do not need to restart Windows PowerShell.
Similarly, when an external drive is disconnected from the computer, Windows PowerShell automatically deletes the PSDrive that represents the removed drive.

## PARAMETERS

### Force [switch]

Removes the current Windows PowerShell drive.


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




### LiteralName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 2')]
```

Specifies the name of the drive.

The value of LiteralName is used exactly as typed.
No characters are interpreted as wildcards.
If the name includes escape characters, enclose it in single quotation marks (').
Single quotation marks instruct Windows PowerShell not to interpret any characters as escape sequences.


### Name [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the names of the drives to remove.
Do not type a colon (:) after the drive name.


### PSProvider [String[]]

```powershell
[Parameter(ValueFromPipelineByPropertyName = $true)]
```

Removes and disconnects all of the drives associated with the specified Windows PowerShell provider.


### Scope [String]

```powershell
[Parameter(ValueFromPipelineByPropertyName = $true)]
```

Accepts an index that identifies the scope from which the drive is being removed.


### Confirm [switch]

Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.


### WhatIf [switch]

Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.


### UseTransaction [switch]

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see



## INPUTS
### System.Management.Automation.PSDriveInfo

You can pipe a drive object, such as one from the Get-PSDrive cmdlet, to the Remove-PSDrive cmdlet.

## OUTPUTS
### None

This cmdlet does not return any output.

## NOTES
The Remove-PSDrive cmdlet is designed to work with the data exposed by any Windows PowerShell provider.
To list the providers in your session, use the Get-PSProvider cmdlet.
For more information, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>Remove-PSDrive -Name smp

```
This command removes a temporary file system drive named "smp".


### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>Get-PSDrive X, S | Remove-PSDrive

```
This command disconnects the X: mapped network drive that was created in File Explorer and the S: mapped network drive that was created by using the Persist parameter of the New-PSDrive cmdlet.

The command uses the Get-PSDrive cmdlet to get the drives and the Remove-PSDrive cmdlet to disconnect them.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293898)

[Get-PSDrive]()

[New-PSDrive]()

[about_Providers]()

