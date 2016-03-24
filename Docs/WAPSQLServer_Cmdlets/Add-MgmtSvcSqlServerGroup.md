# Add-MgmtSvcSqlServerGroup

## SYNOPSIS
Adds a SQL Server group to Windows Azure Pack.

## DESCRIPTION
The Add-MgmtSvcSqlServerGroup adds a SQL Server group to Windows Azure Pack for Windows Server.

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


### GroupName [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 4,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies a name for the SQL Server group.


### ResourceGovernorEnabled [switch]

```powershell
[Parameter(
  Position = 5,
  ParameterSetName = 'Set 1')]
```

Indicates that the server group has the resource governor enabled.


### ServerGroup [SqlServerGroup]

```powershell
[Parameter(
  Position = 4,
  ValueFromPipeline = $true,
  ParameterSetName = 'Set 2')]
```

Specifies a SQL Server group object.


### Token [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ValueFromPipelineByPropertyName = $true)]
```

Specifies an identity token.
To create a token, use the Get-MgmtSvcToken cmdlet.


### Confirm [switch]

Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.


### WhatIf [switch]

Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.



## INPUTS
### None


## OUTPUTS
### 




## EXAMPLES
### Example 1: Add a SQL Server group

```powershell
PS C:\>Add-MgmtSvcSqlServerGroup -AdminUri "https://Computer01:30004" -Token $Token -GroupName "SQL Group 01"


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

This example adds a SQL Server group named SQL Group 01.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321808)

[Get-MgmtSvcSqlServerGroup]()

[Remove-MgmtSvcSqlServerGroup]()

