# Pop-Location

## SYNOPSIS
Changes the current location to the location most recently pushed onto the stack.
You can pop the location from the default stack or from a stack that you create by using the Push-Location cmdlet.

## DESCRIPTION
The Pop-Location cmdlet changes the current location to the location most recently pushed onto the stack by using the Push-Location cmdlet.
You can pop a location from the default stack or from a stack that you create by using a Push-Location command.

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




### PassThru [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Passes an object representing the location to the pipeline.
By default, this cmdlet does not generate any output.


### StackName [String]

```powershell
[Parameter(
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the location stack from which the location is popped.
Enter a location stack name.

Without this parameter, Pop-Location pops a location from the current location stack.
By default, the current location stack is the unnamed default location stack that Windows PowerShell creates.
To make a location stack the current location stack, use the StackName parameter of the Set-Location cmdlet.

NOTE: Pop-Location cannot pop a location from the unnamed default stack unless it is the current location stack.


### UseTransaction [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see



## INPUTS
### None

You cannot pipe input to Pop-Location.

## OUTPUTS
### None or System.Management.Automation.PathInfo 

When you use the PassThru parameter, Pop-Location generates a System.Management.Automation.PathInfo object that represents the location.
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

You can also refer to Pop-Location by its built-in alias, "popd".
For more information, see about_Aliases.

The Pop-Location cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PSProvider".
For more information, see about_Providers.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>pop-location

```
This command changes your location to the location most recently added to the current stack.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>pop-location -stackname Stack2

```
This command changes your location to the location most recently added to the Stack2 location stack.

For more information about location stacks, see the Notes.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>pushd HKLM:\Software\Microsoft\PowerShell
pushd Cert:\LocalMachine\TrustedPublisher
popd
popd
PS C:\>push-location HKLM:\Software\Microsoft\PowerShell
PS HKLM:\Software\Microsoft\PowerShell> push-location Cert:\LocalMachine\TrustedPublisher
PS cert:\LocalMachine\TrustedPublisher> popd
PS HKLM:\Software\Microsoft\PowerShell> popd
PS C:\ps-test>

```
These commands use the Push-Location and Pop-Location cmdlets to move between locations supported by different Windows PowerShell providers.
The commands use the "pushd" alias for Push-Location and the "popd" alias for Pop-Location.

The first command pushes the current file system location onto the stack and moves to the HKLM drive supported by the Windows PowerShell Registry provider.
The second command pushes the registry location onto the stack and moves to a location supported by the Windows PowerShell certificate provider.

The last two commands pop those locations off the stack.
The first "popd" command returns to the Registry drive, and the second command returns to the file system drive.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293891)

[Get-Location]()

[Push-Location]()

[Set-Location]()

[about_Providers]()

