# Convert-Path

## SYNOPSIS
Converts a path from a Windows PowerShell path to a Windows PowerShell provider path.

## DESCRIPTION
The Convert-Path cmdlet converts a path from a Windows PowerShell path to a Windows PowerShell provider path.

## PARAMETERS

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




### LiteralPath [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Specifies the path to be converted.
The value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.


### Path [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipeline = $true,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the Windows PowerShell path to be converted.


### UseTransaction [switch]

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see



## INPUTS
### System.String

You can pipe a path (but not a literal path) to Convert-Path.

## OUTPUTS
### System.String

Convert-Path returns a string that contains the converted path.

## NOTES
The cmdlets that contain the Path noun (the Path cmdlets) manipulate path names and return the names in a concise format that all Windows PowerShell providers can interpret.
They are designed for use in programs and scripts where you want to display all or part of a path name in a particular format.
Use them like you would use Dirname, Normpath, Realpath, Join, or other path manipulators.

You can use the path cmdlets with several providers, including the FileSystem, Registry, and Certificate providers.

The Convert-Path cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PSProvider".
For more information, see about_Providers.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>convert-path .

```
This command converts the current working directory, which is represented by a dot (.), to a standard file system path.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>convert-path HKLM:\software\microsoft

```
This command converts the Windows PowerShell provider path to a standard registry path.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>convert-path ~
C:\Users\User01

```
This command converts the path to the home directory of the current provider, which is the FileSystem provider, to a string.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=290482)

[Join-Path]()

[Resolve-Path]()

[Split-Path]()

[Test-Path]()

[about_Providers]()

