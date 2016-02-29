# Wait-Process

## SYNOPSIS
Waits for the processes to be stopped before accepting more input.

## DESCRIPTION
The Wait-Process cmdlet waits for one or more running processes to be stopped before accepting input.
In the Windows PowerShell console, this cmdlet suppresses the command prompt until the processes are stopped.
You can specify a process by process name or process ID (PID), or pipe a process object to Wait-Process.

Wait-Process works only on processes running on the local computer.

## PARAMETERS

### Id [Int32[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 2')]
```

Specifies the process IDs of the processes.
To specify multiple IDs, use commas to separate the IDs.
To find the PID of a process, type "get-process".
The parameter name ("Id") is optional.


### InformationAction [System.Management.Automation.ActionPreference]]

```powershell
[ValidateSet(
  'SilentlyContinue',
  'Stop',
  'Continue',
  'Inquire',
  'Ignore',
  'Suspend')]
```




### InformationVariable [System.String]]




### InputObject [Process[]]

```powershell
[Parameter(
  Mandatory = $true,
  ValueFromPipeline = $true,
  ParameterSetName = 'Set 3')]
```

Specifies the processes by submitting process objects.
Enter a variable that contains the process objects, or type a command or expression that gets the process objects, such as a Get-Process command.


### Name [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the process names of the processes.
To specify multiple names, use commas to separate the names.
Wildcards are not supported.


### Timeout [Int32]

```powershell
[Parameter(Position = 2)]
```

Determines the maximum time, in seconds, that Wait-Process waits for the specified processes to stop.
When this interval expires, the command displays a non-terminating error that lists the processes that are still running, and ends the wait.
By default, there is no timeout.



## INPUTS
### System.Diagnostics.Process

You can pipe a process object to Wait-Process.

## OUTPUTS
### None

This cmdlet does not generate any output.

## NOTES
This cmdlet uses the WaitForExit method of the System.Diagnostics.Process class.
For more information about this method, see the Microsoft .NET Framework SDK.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>$nid = (get-process notepad).id
PS C:\>stop-process -id $nid
PS C:\>wait-process -id $nid

```
These commands stop the Notepad process and then wait for the process to be stopped before proceeding with the next command.

The first command uses the Get-Process cmdlet to get the ID of the Notepad process.
It saves it in the $nid variable.

The second command uses the Stop-Process cmdlet to stop the process with the ID saved in $nid.

The third command uses the Wait-Process cmdlet to wait until the Notepad process is stopped.
It uses the ID parameter of Wait-Process to identify the process.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>$p = get-process notepad
PS C:\>wait-process -id $p.id
PS C:\>wait-process -name notepad
PS C:\>wait-process -inputobject $p

```
These commands show three different methods of specifying a process to the Wait-Process cmdlet.
The first command gets the Notepad process and saves it in the $p variable.

The second command uses the ID parameter, the third command uses the Name parameter, and the fourth command uses the InputObject parameter.

These commands have the same results and can be used interchangeably.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>wait-process -name outlook, winword -timeout 30

```
This command waits 30 seconds for the Outlook and Winword processes to stop.
If both processes are not stopped, the cmdlet displays a non-terminating error and the command prompt.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293930)

[Debug-Process]()

[Get-Process]()

[Start-Process]()

[Stop-Process]()

[Wait-Process]()

