# Get-ComputerRestorePoint

## SYNOPSIS
Gets the restore points on the local computer.

## DESCRIPTION
The Get-ComputerRestorePoint cmdlet gets the restore points on the local computer.
This cmdlet can also display the status of the most recent attempt to restore the computer.

You can use the information returned by Get-ComputerRestorePoint to select a restore point, and you can use the sequence number to identify a restore point for the Restore-Computer cmdlet.

System restore points and the Get-ComputerRestorePoint cmdlet are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.

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




### LastStatus [switch]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Gets the status of the most recent system restore operation.


### RestorePoint [Int32[]]

```powershell
[Parameter(
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Gets the restore points with the specified sequence numbers.
Enter the sequence numbers of one or more restore points.
By default, Get-ComputerRestorePoint gets all restore points on the local computer.



## INPUTS
### None

You cannot pipe objects to this cmdlet.

## OUTPUTS
### System.Management.ManagementObject#root\default\SystemRestore or String. 

Get-ComputerRestore returns a SystemRestore object, which is an instance of the WMI SystemRestore class.
When you use the LastStatus parameter, this cmdlet returns a string.

## NOTES
To run a Get-ComputerRestorePoint command on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

This cmdlet uses the Windows Management Instrumentation (WMI) SystemRestore class.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>get-computerrestorepoint

```
This command gets all of the restore points on the local computer.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>get-computerrestorepoint -restorepoint 232, 240, 245

```
This command gets the restore points with sequence numbers 232, 240, and 245.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>get-computerrestorepoint -laststatus
The last restore failed.

```
This command displays the status of the most recent system restore operation on the local computer.






### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>get-computerrestorepoint | format-table SequenceNumber, @{Label="Date"; Expression={$_.ConvertToDateTime($_.CreationTime)}}, Description -auto

SequenceNumber Date                  Description
-------------- ----                  -----------
253 8/5/2008 3:19:20 PM   Windows Update
254 8/6/2008 1:53:24 AM   Windows Update
255 8/7/2008 12:00:04 AM  Scheduled Checkpoint
...

```
This command displays the restore points in a table for easy reading.

The Format-Table command includes a calculated property that uses the ConvertToDateTime method to convert the value of the CreationTime property from WMI format to a DateTime object.






### -------------------------- EXAMPLE 5 --------------------------

```powershell
PS C:\>((get-computerrestorepoint)[-1]).sequencenumber

```
This command gets the sequence number of the most recently created restore point on the computer.

The command uses the -1 index to get the last item in the array that Get-ComputerRestorePoint returns.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=290489)

[Checkpoint-Computer]()

[Disable-ComputerRestore]()

[Enable-ComputerRestore]()

[Restart-Computer]()

[Restore-Computer]()

