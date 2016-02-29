# Remove-MgmtSvcSqlServerGroup

## SYNOPSIS
Removes a SQL Server group from Windows Azure Pack.

## DESCRIPTION
The Remove-MgmtSvcSqlServerGroup cmdlet removes a SQL Server group from Windows Azure Pack for Windows Server.

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


### ServerGroupId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 4,
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


### Confirm [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.


### WhatIf [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.



## INPUTS
### None


## OUTPUTS
### 




## EXAMPLES
### Example 1: Remove a SQL Server group

```powershell
PS C:\>Remove-MgmtSvcSqlServerGroup -AdminUri "https://Computer01:30004" -Token $Token -ServerGroupId "g5sho0"


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

This command removes the SQL Server group with the ID g5sho0.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321815)

[Add-MgmtSvcSqlServerGroup]()

[Get-MgmtSvcSqlServerGroup]()

