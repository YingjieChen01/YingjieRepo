# Get-MgmtSvcSqlResourcePoolByTemplate

## SYNOPSIS
Gets resource pools created by using a template.

## DESCRIPTION
The Get-MgmtSvcSqlResourcePoolByTemplate cmdlet gets the resource pools that Windows Azure Pack for Windows Server created by using a specific template.

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


### ServerName [String[]]

```powershell
[Parameter(
  Position = 4,
  ParameterSetName = 'Set 1')]
```

Specifies an array of names of SQL Server hosting servers for resource pools.
This cmdlet gets the resource pools for the server that this parameter specifies.


### TemplateId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ParameterSetName = 'Set 1')]
```

Specifies the ID of a  resource pool template for which this cmdlet gets resource pools.


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
### Example 1: Get resource pools by template

```powershell
PS C:\>$Credential = Get-Credential
PS C:\> $Token = Get-MgmtSvcToken -Type Windows -AuthenticationSite "https://Computer01:30072" -ClientRealm "http://azureservices/AdminSite" -User $Credential -DisableCertificateValidation 
PS C:\> Get-MgmtSvcSqlResourcePoolByTemplate -AdminUri "https://Computer01:30004" -Token $Token -TemplateId "Template18"

```
The first command creates a PSCredential object by using the Get-Credential cmdlet, and then stores it in the $Credential variable.
The cmdlet prompts you for user name and password.

The second command creates a Windows token for the user in $Credential by using the Get-MgmtSvcToken cmdlet.
The command stores the token in the $Token variable.

The final command gets resource pools for the specified administrator group for the Template18 template.



## RELATED LINKS

[Get-MgmtSvcSqlResourcePoolByGroup]()

[Get-MgmtSvcSqlResourcePoolByServer]()

