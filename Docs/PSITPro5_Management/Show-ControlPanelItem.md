# Show-ControlPanelItem

## SYNOPSIS
Opens control panel items.

## DESCRIPTION
The Show-ControlPanelItem cmdlet opens control panel items on the local computer.
You can use it to open control panel items by name, category, or description, even on systems that do not have a user interface, and you can pipe control panel items from Get-ControlPanelItem to Show-ControlPanelItem.

Show-ControlPanelItem searches only the control panel items that can be opened on the system.
On computers that do not have Control Panel or File Explorer, Show-ControlPanelItem searches only control panel items that can open without these components.

This cmdlet is introduced in Windows PowerShell 3.0.
It works only on Windows 8 and Windows Server 2012.
Because this cmdlet requires a user interface, it does not work on Server Core installations of Windows Server.

## PARAMETERS

### CanonicalName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Opens control panel items with the specified canonical names or name patterns.
Wildcards are permitted.
If you enter multiple names, Get-ControlPanelItem opens the control panel items that match any of the names, as though the items in the name list were separated by an "or" operator.


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




### InputObject [ControlPanelItem[]]

```powershell
[Parameter(
  Position = 1,
  ValueFromPipeline = $true,
  ParameterSetName = 'Set 3')]
```

Specifies the control panel items to open by submitting control panel item objects.
Enter a variable that contains the control panel item objects, or type a command or expression that gets the control panel item objects, such as a Get-ControlPanelItem command.


### Name [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipeline = $true,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Opens control panel items with the specified names or name patterns.
Wildcards are permitted.
If you enter multiple names, Get-ControlPanelItem opens the control panel items that match any of the names, as though the items in the name list were separated by an "or" operator.



## INPUTS
### System.String,  Microsoft.PowerShell.Commands.ControlPanelItem

You can pipe a name or control panel item object to Show-ControlPanelItem.

## OUTPUTS
### None

This cmdlet does not return any output.


## EXAMPLES
### Example 1: Open a Control Panel Item

```powershell
PS C:\>Show-ControlPanelItem –Name AutoPlay

```



### Example 2: Pipe a control panel item to Show-ControlPanelItem

```powershell
PS C:\>Get-ControlPanelItem –Name "Windows Firewall" | Show-ControlPanelItem

```
This command opens the Windows Firewall control panel item on the local computer.
It uses the Get-ControlPanelItem cmdlet to get the control panel item and the Show-ControlPanelItem cmdlet to open it.


### Example 3: Use a file name to open a control panel item

```powershell
PS C:\>appwiz

```
This command opens the Programs and Features control panel item by using its application name.
The .cpl file name extension is not required in the command.

This method is an alternative to using a Show-ControlPanelItem command.

In Windows PowerShell 3.0, you can omit the .cpl file name extension for control panel item files because it is included in the value of the PathExt environment variable.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293915)

[Get-ControlPanelItem]()

