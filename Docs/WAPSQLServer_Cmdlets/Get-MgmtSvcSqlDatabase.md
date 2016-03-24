# Get-MgmtSvcSqlDatabase

## SYNOPSIS
Gets a SQL Server database.

## DESCRIPTION
The Get-MgmtSvcSqlDatabase cmdlet gets SQL Server databases.
By default, all SQL Server databases for a hosting server are returned.
To get a specific database, use the Name parameter.

## PARAMETERS

### AdminUri [Uri]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the URI of the Windows Azure Pack administrator API.
Use the following format: https://\<computer\>:\<port\>, where \<computer\> is the computer on which the administrator API is installed.


### Descending [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Indicates that the returned databases are displayed in descending order.


### DisableCertificateValidation [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Disables certificate validation for the Windows Azure Pack installation.

If you specify this parameter, you can use self-signed certificates.


### HostingServerId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the ID of a SQL Server hosting server.


### Name [String]

```powershell
[Parameter(
  Position = 4,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the name of a SQL Server database.


### Token [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies an identity token.
To create a token, use the Get-MgmtSvcToken cmdlet.



## INPUTS
### None


## OUTPUTS
### 




## EXAMPLES
### Example 1: Get a database by name

```powershell
PS C:\>Get-MgmtSvcSqlDatabase -AdminUri "https://Computer01:30004" -Token $Token -HostingServerId "u37k25" -Name "DB01"


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

This command gets the database named DB01 on the hosting server with the ID u37k25.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321809)

[Get-MgmtSvcSqlHostingServer]()

