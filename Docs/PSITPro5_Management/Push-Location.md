# Push-Location

## SYNOPSIS
Adds the current location to the top of a location stack.

## DESCRIPTION
The Push-Location cmdlet adds ("pushes") the current location onto a location stack.
If you specify a path, Push-Location pushes the current location onto a location stack and then changes the current location to the location specified by the path.
You can use the Pop-Location cmdlet to get locations from the location stack.

By default, the Push-Location cmdlet pushes the current location onto the current location stack, but you can use the StackName parameter to specify an alternate location stack.
If the stack does not exist, Push-Location creates it.

For more information about location stacks, see the Notes.

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




### LiteralPath [String]

```powershell
[Parameter(ParameterSetName = 'Set 2')]
```

Specifies the path to the new location.
Unlike the Path parameter, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.


### PassThru [switch]

Passes an object representing the location to the pipeline.
By default, this cmdlet does not generate any output.


### Path [String]

```powershell
[Parameter(
  Position = 1,
  ValueFromPipeline = $true,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Changes your location to the location specified by this path after it adds (pushes) the current location onto the top of the stack.
Enter a path to any location whose provider supports this cmdlet.
Wildcards are permitted.
The parameter name ("Path") is optional.


### StackName [String]

```powershell
[Parameter(ValueFromPipelineByPropertyName = $true)]
```

Specifies the location stack to which the current location is added.
Enter a location stack name.
If the stack does not exist, Push-Location creates it.

Without this parameter, Push-Location adds the location to the current location stack.
By default, the current location stack is the unnamed default location stack that Windows PowerShell creates.
To make a location stack the current location stack, use the StackName parameter of the Set-Location cmdlet.
For more information about location stacks, see the Notes.

NOTE: Push-Location cannot add a location to the unnamed default stack unless it is the current location stack.


### UseTransaction [switch]

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see



## INPUTS
### System.String

You can pipe a string that contains a path (but not a literal path) to Push-Location.

## OUTPUTS
### None or System.Management.Automation.PathInfo

When you use the PassThru parameter, Push-Location generates a System.Management.Automation.PathInfo object that represents the location.
Otherwise, this cmdlet does not generate any output.

## NOTES
A "stack" is a last-in, first-out list in which only the most recently added item is accessible.
You add items to a stack in the order that you use them, and then retrieve them for use in the reverse order.
Windows PowerShell lets you store provider locations in location stacks.

Windows PowerShell creates an unnamed default location stack and you can create multiple named location stacks.
If you do not specify a stack name, Windows PowerShell uses the current location stack.
By default, the unnamed default location is the current location stack, but you can use the Set-Location cmdlet to change the current location stack.

To manage location stacks, use the Windows PowerShell Location cmdlets, as follows.

-- To add a location to a location stack, use the Push-Location cmdlet.

-- To get a location from a location stack, use the Pop-Location cmdlet.

-- To display the locations in the current location stack, use the Stack parameter of the Get-Location cmdlet.
To display the locations in a named location stack, use the StackName parameter of the Get-Location cmdlet.

-- To create a new location stack, use the StackName parameter of the Push-Location cmdlet.
If you specify a stack that does not exist, Push-Location creates the stack.

-- To make a location stack the current location stack, use the StackName parameter of the Set-Location cmdlet.

The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you cannot no longer use Push-Location or Pop-Location cmdlets add or get items from the default stack or use Get-Location command to display the locations in the unnamed stack.
To make the unnamed stack the current stack, use the StackName parameter of the Set-Location cmdlet with a value of $null or an empty string ("").

You can also refer to Push-Location by its built-in alias, "pushd".
For more information, see about_Aliases.

The Push-Location cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PSProvider".
For more information, see about_Providers.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>push-location C:\Windows

```
This command pushes the current location onto the default location stack and then changes the location to C:\Windows.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>push-location HKLM:\Software\Policies -stackname RegFunction

```
This command pushes the current location onto the RegFunction stack and changes the current location to the HKLM:\Software\Policies location.
You can use the Location cmdlets in any Windows PowerShell drive (PSDrive).






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>push-location

```
This command pushes the current location onto the default stack.
It does not change the location.






### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>push-location ~ -stackname Stack2
PS C:\Users\User01> pop-location -stackname Stack2
PS C:\>

```
These commands show how to create and use a named location stack.

The first command pushes the current location onto a new stack named Stack2, and then changes the current location to the home directory (%USERPROFILE%), which is represented in the command by the tilde symbol (~) or $home.
If Stack2 does not already exist in the session, Push-Location creates it.

The second command uses the Pop-Location cmdlet to pop the original location (PS C:\\>) from the Stack2 stack.
Without the StackName parameter, Pop-Location would pop the location from the unnamed default stack.

For more information about location stacks, see the Notes.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293892)

[Get-Location]()

[Pop-Location]()

[Set-Location]()

[about_Providers]()

