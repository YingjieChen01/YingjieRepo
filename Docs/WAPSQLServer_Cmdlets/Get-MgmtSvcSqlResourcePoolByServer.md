# Get-MgmtSvcSqlResourcePoolByServer

## SYNOPSIS
Gets resource pools created on a hosting server.

## DESCRIPTION
The Get-MgmtSvcSqlResourcePoolByServer cmdlet gets the resource pools that Windows Azure Pack for Windows Server created on a specific SQL Server hosting server.

## PARAMETERS

### AdminUri [Uri]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
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


### ResourcePoolTemplateId [String[]]

```powershell
[Parameter(
  Position = 4,
  ParameterSetName = 'Set 1')]
```

Specifies an array of ID for resource pool templates in Windows Azure Pack.
This cmdlet gets resource pools that Windows Azure Pack created by using the templates that this parameter specifies.


### ServerId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ParameterSetName = 'Set 1')]
```

Specifies the ID of a hosting server for which this cmdlet gets resource pools.


### Token [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2,
  ParameterSetName = 'Set 1')]
```

Specifies an identity token.
To create a token, use the Get-MgmtSvcToken cmdlet.



## INPUTS
### None


## OUTPUTS
### System.Object

This cmdlet returns a System.Object.


## EXAMPLES
### Example 1: Get resource pools by server

```powershell
PS C:\>$Credential = Get-Credential
PS C:\> $Token = Get-MgmtSvcToken -Type Windows -AuthenticationSite "https://Computer01:30072" -ClientRealm "http://azureservices/AdminSite" -User $Credential -DisableCertificateValidation 
PS C:\> Get-MgmtSvcSqlResourcePoolByServer -AdminUri "https://Computer01:30004" -Token $Token -ServerId "Server07"

```
The first command creates a PSCredential object by using the Get-Credential cmdlet, and then stores it in the $Credential variable.
The cmdlet prompts you for user name and password.

The second command creates a Windows token for the user in $Credential by using the Get-MgmtSvcToken cmdlet.
The command stores the token in the $Token variable.

The final command gets resource pools for the specified administrator group for the ServerGroup03 group.



## RELATED LINKS

[Get-MgmtSvcSqlResourcePoolByGroup]()

[Get-MgmtSvcSqlResourcePoolByTemplate]()

