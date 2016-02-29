# Test-Connection

## SYNOPSIS
Sends ICMP echo request packets ("pings") to one or more computers.

## DESCRIPTION
The Test-Connection cmdlet sends Internet Control Message Protocol (ICMP) echo request packets ("pings") to one or more remote computers and returns the echo response replies.
You can use this cmdlet to determine whether a particular computer can be contacted across an Internet Protocol (IP) network.

You can use the parameters of Test-Connection to specify both the sending and receiving computers, to run the command as a background job, to set a timeout and number of pings, and to configure the connection and authentication.

Unlike the traditional "ping" command, Test-Connection returns a Win32_PingStatus object that you can investigate in Windows PowerShell, but you can use the Quiet parameter to force it to return only a Boolean value.

## PARAMETERS

### AsJob [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
```

Runs the command as a background job.

Note: To use this parameter, the local and remote computers must be configured for remoting and, on Windows Vista and later versions of Windows, you must open Windows PowerShell with the "Run as administrator" option.
For more information, see about_Remote_Requirements.

When you use the AsJob parameter, the command immediately returns an object that represents the background job.
You can continue to work in the session while the job completes.
The job is created on the local computer and the results from remote computers are automatically returned to the local computer.
To get the job results, use the Receive-Job cmdlet.

For more information about Windows PowerShell background jobs, see about_Jobs and about_Remote_Jobs.


### Authentication [AuthenticationLevel]

```powershell
[ValidateSet(
  'Default',
  'None',
  'Connect',
  'Call',
  'Packet',
  'PacketIntegrity',
  'PacketPrivacy',
  'Unchanged')]
```

Specifies the authentication level that is used for the  WMI connection. (Test-Connection uses WMI.)

Valid values are:

Unchanged:       The authentication level is the same as the previous command.

Default:         Windows Authentication.

None:            No COM authentication.

Connect:         Connect-level COM authentication.

Call:            Call-level COM authentication.

Packet:          Packet-level COM authentication.

PacketIntegrity: Packet Integrity-level COM authentication.

PacketPrivacy:   Packet Privacy-level COM authentication.


### BufferSize [Int32]

Specifies the size, in bytes, of the buffer sent with this command.
The default value is 32.


### ComputerName [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipelineByPropertyName = $true)]
```

Specifies the computers to ping.
Type the computer names or type IP addresses in IPv4 or IPv6 format.
Wildcard characters are not permitted.
This parameter is required.

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter even if your computer is not configured to run remote commands.


### Count [Int32]

Specifies the number of echo requests to send.
The default value is 4.


### Credential [PSCredential]

```powershell
[Parameter(ParameterSetName = 'Set 2')]
```

Specifies a user account that has permission to send a ping request from the source computer.
Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one from the Get-Credential cmdlet.

The Credential parameter is valid only when the Source parameter is used in the command.
The credentials do not affect the destination computer.


### Delay [Int32]

Specifies the interval between pings, in seconds.


### Impersonation [ImpersonationLevel]

```powershell
[ValidateSet(
  'Default',
  'Anonymous',
  'Identify',
  'Impersonate',
  'Delegate')]
```

Specifies the impersonation level to use when calling WMI. (Test-Connection uses WMI.) The default value is "Impersonate".

Valid values are:

Default:      Default impersonation.

Anonymous:    Hides the identity of the caller.

Identify:     Allows objects to query the credentials of the caller.

Impersonate:  Allows objects to use the credentials of the caller.


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


Note: To use this parameter, the local and remote computers must be configured for remoting and, on Windows Vista and later versions of Windows, you must open Windows PowerShell with the "Run as administrator" option.
For more information, see about_Remote_Requirements.

When you use the AsJob parameter, the command immediately returns an object that represents the background job.
You can continue to work in the session while the job completes.
The job is created on the local computer and the results from remote computers are automatically returned to the local computer.
To get the job results, use the Receive-Job cmdlet.

For more information about Windows PowerShell background jobs, see about_Jobs and about_Remote_Jobs.


### InformationVariable [System.String]


Note: To use this parameter, the local and remote computers must be configured for remoting and, on Windows Vista and later versions of Windows, you must open Windows PowerShell with the "Run as administrator" option.
For more information, see about_Remote_Requirements.

When you use the AsJob parameter, the command immediately returns an object that represents the background job.
You can continue to work in the session while the job completes.
The job is created on the local computer and the results from remote computers are automatically returned to the local computer.
To get the job results, use the Receive-Job cmdlet.

For more information about Windows PowerShell background jobs, see about_Jobs and about_Remote_Jobs.


### Quiet [switch]

```powershell
[Parameter(ParameterSetName = 'Set 3')]
```

Suppresses all errors and returns $True if any pings succeeded and $False if all failed.


### Source [String[]]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ParameterSetName = 'Set 2')]
```

Specifies the names of the computers where the ping originates.
Enter a comma-separated list of computer names.
The default is the local computer.


### ThrottleLimit [Int32]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
```

Specifies the maximum number of concurrent connections that can be established to run this command.
If you omit this parameter or enter a value of 0, the default value, 32, is used.

The throttle limit applies only to the current command, not to the session or to the computer.


### TimeToLive [Int32]

Specifies the maximum time, in seconds, that each echo request packet ("pings") is active.
Enter an integer between 1 and 255.
The default value is 80 (seconds).
The alias of the TimeToLive parameter is TTL.



## INPUTS
### None

You cannot pipe input to this cmdlet.

## OUTPUTS
### System.Management.ManagementObject#root\cimv2\Win32_PingStatus, System.Management.Automation.RemotingJob, System.Boolean

When you use the AsJob parameter, the cmdlet returns a job object.
When you use the Quiet parameter, it returns a Boolean.
Otherwise, this cmdlet returns a Win32_PingStatus object for each ping.

## NOTES
This cmdlet uses the Win32_PingStatus class.
A "get-wmiobject win32_pingstatus" command is equivalent to a Test-Connection command.

The Source parameter set was introduced in Windows PowerShell 3.0.

## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>Test-Connection Server01

Source        Destination     IPV4Address     IPV6Address  Bytes    Time(ms)
------        -----------     -----------     -----------  -----    --------
ADMIN1        Server01        157.59.137.44                32       0
ADMIN1        Server01        157.59.137.44                32       0
ADMIN1        Server01        157.59.137.44                32       0
ADMIN1        Server01        157.59.137.44                32       1

```
This command sends echo request packets ("pings") from the local computer to the Server01 computer.
This command uses the ComputerName parameter to specify the Server01 computer, but omits the optional parameter name.


### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>Test-Connection -ComputerName Server01, Server02, Server12

```
This command sends pings from the local computer to several remote computers.


### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>Test-Connection -Source Server02, Server12, localhost -ComputerName Server01 -Credential Domain01\Admin01

```
This command sends pings from different source computers to a single remote computer, Server01.
It uses the Credential parameter to specify the credentials of a user who has permission to send a ping request from the source computers.
Use this command format to test the latency of connections from multiple points.


### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>Test-Connection -ComputerName Server01 -Count 3 -Delay 2 -TTL 255 -BufferSize 256 -ThrottleLimit 32

```
This command sends three pings from the local computer to the Server01 computer.
It uses the parameters of Test-Connection to customize the command.

Use this command format when the ping response is expected to take longer than usual, either because of an extended number of hops or a high-traffic network condition.


### -------------------------- EXAMPLE 5 --------------------------

```powershell
PS C:\>$job = Test-connection -ComputerName (Get-Content Servers.txt) -asjob
PS C:\>if ($job.JobStateInfo.State -ne "Running") {$Results = Receive-Job $job}

```
This example shows how to run a Test-Connection command as a Windows PowerShell background job.

The first command uses the Test-Connection cmdlet to ping many computers in an enterprise.
The value of the ComputerName parameter is a Get-Content command that reads a list of computer names from the Servers.txt file.
The command uses the AsJob parameter to run the command as a background job and it saves the job in the $job variable.

The second command checks to see that the job is not still running, and if it is not, it uses a Receive-Job command to get the results and store them in the $Results variable.


### -------------------------- EXAMPLE 6 --------------------------

```powershell
PS C:\>Test-Connection Server55 -Credential Domain55\User01 -Impersonation Identify

```
This command uses the Test-Connection cmdlet to ping a remote computer.
The command uses the Credential parameter to specify a user account with permission to ping the remote computer and the Impersonation parameter to change the impersonation level to "Identify".


### -------------------------- EXAMPLE 7 --------------------------

```powershell
PS C:\>if (Test-Connection -ComputerName Server01 -Quiet) {New-PSSession Server01}

```
This command creates a session on the Server01 computer only if at least one of the pings sent to the computer succeeds.

The command uses the Test-Connection cmdlet to ping the Server01 computer.
The command uses the Quiet parameter, which returns a Boolean value, instead of a Win32_PingStatus object.
The value is $True if any of the four pings succeed and is, otherwise, $False.

If the Test-Connection command returns a value of $True, the command uses the New-PSSession cmdlet to create the PSSession.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293926)

[Add-Computer]()

[Restart-Computer]()

[Stop-Computer]()

