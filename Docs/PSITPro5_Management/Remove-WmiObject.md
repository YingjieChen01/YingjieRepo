# Remove-WmiObject

## SYNOPSIS
Deletes an instance of an existing Windows Management Instrumentation (WMI) class.

## DESCRIPTION
The Remove-WmiObject cmdlet deletes an instance of an existing WMI class.

## PARAMETERS

### AsJob [switch]

Runs the command as a background job.
Use this parameter to run commands that take a long time to finish.

New CIM cmdlets, introduced Windows PowerShell 3.0, perform the same tasks as the WMI cmdlets.
The CIM cmdlets comply with WS-Management (WSMan) standards and with the Common Information Model (CIM) standard, which enables the cmdlets to use the same techniques to manage Windows computers and those running other operating systems.
Instead of using Remove-WmiObject, consider using the [Remove-CimInstance]() cmdlet.

When you use the AsJob parameter, the command returns an object that represents the background job and then displays the command prompt.
You can continue to work in the session while the job finishes.
If Remove-WmiObject is used against a remote computer, the job is created on the local computer, and the results from remote computers are automatically returned to the local computer.
To manage the job, use the cmdlets that contain the Job noun (the Job cmdlets).
To get the job results, use the Receive-Job cmdlet.

Note: To use this parameter with remote computers, the local and remote computers must be configured for remoting.
Start Windows PowerShell by using the "Run as administrator" option.
For more information, see about_Remote_Requirements.

For more information about Windows PowerShell background jobs, see  about_Jobs and about_Remote_Jobs.


### Authentication [AuthenticationLevel]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[ValidateSet(
  'Default',
  'None',
  'Connect',
  'Call',
  'Packet',
  'PacketIntegrity',
  'PacketPrivacy',
  'Unchanged')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

Specifies the authentication level to be used with the WMI connection.
Valid values are:

-1: Unchanged

0: Default

1: None (No authentication in performed.)

2: Connect (Authentication is performed only when the client establishes a relationship with the application.)

3: Call (Authentication is performed only at the beginning of each call when the application receives the request.)

4: Packet (Authentication is performed on all the data that is received from the client.)

5: PacketIntegrity (All the data that is transferred between the client  and the application is authenticated and verified.)

6: PacketPrivacy (The properties of the other authentication levels are used, and all the data is encrypted.)


### Authority [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

Specifies the authority to use to authenticate the WMI connection.
You can specify standard NTLM or Kerberos authentication.
To use NTLM, set the authority setting to "ntlmdomain:\<DomainName\>", where \<DomainName\> identifies a valid NTLM domain name.
To use Kerberos, specify "kerberos:\<DomainName\>\\<ServerName\>".
You cannot include the authority setting when you connect to the local computer.


### Class [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the name of a WMI class that you want to delete.


### ComputerName [String[]]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

Runs the command on the specified computers.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one or more computers.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter even if your computer is not configured to run remote commands.


### Credential [PSCredential]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

Specifies a user account that has permission to perform this action.
The default is the current user.
Type a user name, such as "User01", "Domain01\User01", or "User@Contoso.com".
Or, enter a PSCredential object, such as an object that is returned by the Get-Credential cmdlet.
When you type a user name, you will be prompted for a password.


### EnableAllPrivileges [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

Enables all the privileges of the current user before the command makes the WMI call.


### Impersonation [ImpersonationLevel]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[ValidateSet(
  'Default',
  'Anonymous',
  'Identify',
  'Impersonate',
  'Delegate')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

Specifies the impersonation level to use.
Valid values are:

0: Default (Reads the local registry for the default impersonation level, which is usually set to "3: Impersonate".)

1: Anonymous (Hides the credentials of the caller.)

2: Identify (Allows objects to query the credentials of the caller.)

3: Impersonate (Allows objects to use the credentials of the caller.)

4: Delegate (Allows objects to permit other objects to use the credentials of the caller.)


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


New CIM cmdlets, introduced Windows PowerShell 3.0, perform the same tasks as the WMI cmdlets.
The CIM cmdlets comply with WS-Management (WSMan) standards and with the Common Information Model (CIM) standard, which enables the cmdlets to use the same techniques to manage Windows computers and those running other operating systems.
Instead of using Remove-WmiObject, consider using the [Remove-CimInstance]() cmdlet.

When you use the AsJob parameter, the command returns an object that represents the background job and then displays the command prompt.
You can continue to work in the session while the job finishes.
If Remove-WmiObject is used against a remote computer, the job is created on the local computer, and the results from remote computers are automatically returned to the local computer.
To manage the job, use the cmdlets that contain the Job noun (the Job cmdlets).
To get the job results, use the Receive-Job cmdlet.

Note: To use this parameter with remote computers, the local and remote computers must be configured for remoting.
Start Windows PowerShell by using the "Run as administrator" option.
For more information, see about_Remote_Requirements.

For more information about Windows PowerShell background jobs, see  about_Jobs and about_Remote_Jobs.


### InformationVariable [System.String]


New CIM cmdlets, introduced Windows PowerShell 3.0, perform the same tasks as the WMI cmdlets.
The CIM cmdlets comply with WS-Management (WSMan) standards and with the Common Information Model (CIM) standard, which enables the cmdlets to use the same techniques to manage Windows computers and those running other operating systems.
Instead of using Remove-WmiObject, consider using the [Remove-CimInstance]() cmdlet.

When you use the AsJob parameter, the command returns an object that represents the background job and then displays the command prompt.
You can continue to work in the session while the job finishes.
If Remove-WmiObject is used against a remote computer, the job is created on the local computer, and the results from remote computers are automatically returned to the local computer.
To manage the job, use the cmdlets that contain the Job noun (the Job cmdlets).
To get the job results, use the Receive-Job cmdlet.

Note: To use this parameter with remote computers, the local and remote computers must be configured for remoting.
Start Windows PowerShell by using the "Run as administrator" option.
For more information, see about_Remote_Requirements.

For more information about Windows PowerShell background jobs, see  about_Jobs and about_Remote_Jobs.


### InputObject [ManagementObject]

```powershell
[Parameter(
  Mandatory = $true,
  ValueFromPipeline = $true,
  ParameterSetName = 'Set 6')]
```

Specifies a ManagementObject object to use as input.
When this parameter is used, all other parameters are ignored.


### Locale [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

Specifies the preferred locale for WMI objects.
The Locale parameter is specified as an array in the MS_\<LCID\> format in the preferred order.


### Namespace [String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[Parameter(ParameterSetName = 'Set 2')]
[Parameter(ParameterSetName = 'Set 3')]
[Parameter(ParameterSetName = 'Set 4')]
[Parameter(ParameterSetName = 'Set 5')]
```

When used with the Class parameter, this parameter specifies the WMI repository namespace where the referenced WMI class is located.


### Path [String]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 2')]
```

Specifies the WMI object path of a WMI class, or specifies the WMI object path of an instance of a WMI class to delete.


### ThrottleLimit [Int32]

Allows the user to specify a throttling value for the number of WMI operations that can be executed simultaneously.
This parameter is used together with the AsJob parameter.
The throttle limit applies only to the current command, not to the session or to the computer.


### Confirm [switch]

Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.


### WhatIf [switch]

Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.



## INPUTS
### System.Management.ManagementObject

You can pipe a management object to Remove-WmiObject.

## OUTPUTS
### None or System.Management.Automation.RemotingJob

When you use the AsJob parameter, this cmdlet returns a job object.
Otherwise, it does not generate any output.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>notepad
PS C:\>$np = get-wmiobject -query "select * from win32_process where name='notepad.exe'"
PS C:\>$np | remove-wmiobject

```
This command closes all the instances of Notepad.exe.

The first command starts an instance of Notepad.

The second command uses the Get-WmiObject cmdlet to retrieve the instances of the Win32_Process that correspond to Notepad.exe and stores them in the $np variable.

The third command passes the object in the $np variable to the Remove-WmiObject cmdlet, which deletes all the instances of Notepad.exe.





### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>$a = Get-WMIObject -query "Select * From Win32_Directory Where Name ='C:\\Test'"
PS C:\>$a | Remove-WMIObject

```
This command deletes the C:\Test directory.

The first command uses the Get-WMIObject cmdlet to query for the C:\Test directory and then stores the object in the $a variable.

The second command pipes the $a variable to the Remove-WMIObject, which deletes the directory.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293899)

[Get-WSManInstance]()

[Invoke-WSManAction]()

[New-WSManInstance]()

[Remove-WSManInstance]()

[Get-WmiObject]()

[Invoke-WmiMethod]()

[Set-WmiInstance]()

