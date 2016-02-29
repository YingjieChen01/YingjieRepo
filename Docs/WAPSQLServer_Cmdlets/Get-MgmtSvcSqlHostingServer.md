# Get-MgmtSvcSqlHostingServer

## SYNOPSIS
Gets a SQL Server hosting server.

## DESCRIPTION
The Get-MgmtSvcSqlHostingServer cmdlet gets a SQL Server hosting server.
By default, all hosting servers are returned.
To get a specific hosting server, use the Name parameter.
You can also get a specified number of servers by using the First and Skip parameters.

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

Indicates that the returned servers are displayed in descending order.


### DisableCertificateValidation [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Disables certificate validation for the Windows Azure Pack installation.

If you specify this parameter, you can use self-signed certificates.


### Name [String]

```powershell
[Parameter(
  Position = 3,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the name of a SQL Server hosting server.


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
### Example 1: Get a specific hosting server by name

```powershell
PS C:\>Get-MgmtSvcSqlHostingServer -AdminUri "https://Computer01:30004" -Token $Token -Name "SQLServer01.Contoso.com"


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

This command gets the SQL Server hosting server named SQLServer01.Contoso.com.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321810)

[Add-MgmtSvcSqlHostingServer]()

[Set-MgmtSvcSqlHostingServer]()

[Test-MgmtSvcSqlHostingServer]()

[Remove-MgmtSvcSqlHostingServer]()

[Get-MgmtSvcSqlHostingServerByGroup]()

