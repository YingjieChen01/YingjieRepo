# Get-MgmtSvcSqlHostingServerByGroup

## SYNOPSIS
Gets hosting servers by SQL Server group.

## DESCRIPTION
The Get-MgmtSvcSqlHostingServerByGroup gets SQL Server hosting servers by SQL Server group.
By default, all SQL Server hosting servers for a group are returned.
To get a specific hosting server, use the Name parameter.

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


### DisableCertificateValidation [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Disables certificate validation for the Windows Azure Pack installation.

If you specify this parameter, you can use self-signed certificates.


### Name [String[]]

```powershell
[Parameter(
  Position = 4,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies an array of SQL Server hosting server names.


### ServerGroupId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the ID of a SQL Server group.


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
### Example 1: Get all hosting servers for a group

```powershell
PS C:\>Get-MgmtSvcSqlHostingServerByGroup -AdminUri "https://Computer01:30004" -Token $Token -ServerGroupId "g5sho0"


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

This command gets all SQL Server hosting servers in the group with the ID of g5sho0.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321811)

[Get-MgmtSvcSqlHostingServer]()

