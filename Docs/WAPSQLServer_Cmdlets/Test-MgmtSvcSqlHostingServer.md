# Test-MgmtSvcSqlHostingServer

## SYNOPSIS
Verifies a SQL Server hosting server can be created.

## DESCRIPTION
The Test-MgmtSvcSqlHostingServer cmdlet verifies that a SQL Server hosting server can be created, and that the specified login credentials are correct.
This cmdlet verifies that no server with the same name is already registered.

## PARAMETERS

### AdminUri [Uri]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipelineByPropertyName = $true)]
```

Specifies the URI of the Windows Azure Pack administrator API.
Use the following format: https://\<computer\>:\<port\>, where \<computer\> is the computer on which the administrator API is installed.


### DisableCertificateValidation [switch]

Disables certificate validation for the Windows Azure Pack installation.

If you specify this parameter, you can use self-signed certificates.


### HostingServer [SqlHostingServer]

```powershell
[Parameter(
  Position = 3,
  ValueFromPipeline = $true,
  ParameterSetName = 'Set 2')]
```

Specifies a SQL Server hosting server object.


### MaximumResourcePools [System.Int32]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the number of resource pools for the server.


### Name [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the name of a SQL Server.


### NumberOfCpuCores [System.Int32]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the number of CPU cores for the server.


### ServerGroupId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 6,
  ValueFromPipelineByPropertyName = $true)]
```

Specifies the ID for a SQL Server group.


### SupportedIopsPerVolume [System.Int32]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the supported I/O operations per second (IOPS) for the server.


### Token [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ValueFromPipelineByPropertyName = $true)]
```

Specifies an identity token.
To create a token, use the Get-MgmtSvcToken cmdlet.


### TotalMemoryGB [System.Int32]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Specifies the total amount of memory, in gigabytes, for the server.


### TotalSpaceMB [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 4,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the size, in megabytes (MB) of the hosting server.


### User [PSCredential]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 5,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies a user account and password as a PSCredential object.
To create a PSCredential object, use the Get-Credential cmdlet.



## INPUTS
### None


## OUTPUTS
### 




## EXAMPLES
### Example 1: Verify a SQL Server hosting server

```powershell
PS C:\>$Creds = Get-Credential
PS C:\> Test-MgmtSvcSqlHostingServer -AdminUri "https://Computer01:30004" -Token $Token -Name "SQLServer01.Contoso.com" -TotalSpaceMB 2048 -User $Creds -ServerGroupId "g5sho0"


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

The first command prompts the user for credentials and stores the provided user name and password in the $Credential variable.

The second command tests the SQL Server hosting server named SQLServer01.Contoso.com, using the credentials provided in the first command.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321817)

[Add-MgmtSvcSqlHostingServer]()

[Get-MgmtSvcSqlHostingServer]()

[Set-MgmtSvcSqlHostingServer]()

[Remove-MgmtSvcSqlHostingServer]()

