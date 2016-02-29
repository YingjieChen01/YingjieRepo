# Get-MgmtSvcSqlServerGroup

## SYNOPSIS
Gets a SQL Server group.

## DESCRIPTION
The Get-MgmtSvcSqlServerGroup cmdlet gets SQL Server groups.
By default, all SQL Server groups are returned.
To get a specific server group, use the GroupName parameter.

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


### GroupName [String[]]

```powershell
[Parameter(
  Position = 4,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies an array of SQL Server group names.


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
### Example 1: Get a specific server group

```powershell
PS C:\>Get-MgmtSvcSqlServerGroup -AdminUri "https://Computer01:30004" -Token $Token -GroupName "SQL Group 01"


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

This command gets the SQL Server group named SQL Group 01.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321813)

[Add-MgmtSvcSqlServerGroup]()

[Remove-MgmtSvcSqlServerGroup]()

