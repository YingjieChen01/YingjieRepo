# Remove-MgmtSvcSqlResourcePoolTemplate

## SYNOPSIS
Removes a resource pool template from Windows Azure Pack.

## DESCRIPTION
The Remove-MgmtSvcSqlResourcePoolTemplate cmdlet removes a resource pool template from Windows Azure Pack for Windows Server.
You can get specific templates by specifying names.

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


### ResourcePoolTemplateId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ParameterSetName = 'Set 1')]
```

Specifies the ID for the resource pool template in Windows Azure Pack.


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
### Example 1: Remove a template

```powershell
PS C:\>$Credential = Get-Credential
PS C:\> $Token = Get-MgmtSvcToken -Type Windows -AuthenticationSite "https://Computer01:30072" -ClientRealm "http://azureservices/AdminSite" -User $Credential -DisableCertificateValidation 
PS C:\> Remove-MgmtSvcSqlResourcePoolTemplate -AdminUri "https://Computer01:30004" -Token $Token -ResourcePoolTemplateId "Template07"

```
The first command creates a PSCredential object by using the Get-Credential cmdlet, and then stores it in the $Credential variable.
The cmdlet prompts you for user name and password.

The second command creates a Windows token for the user in $Credential by using the Get-MgmtSvcToken cmdlet.
The command stores the token in the $Token variable.

The final command removes the specified resource pool template for the URI https://Computer01:30004.



## RELATED LINKS

[Get-MgmtSvcSqlResourcePoolTemplate]()

[Set-MgmtSvcSqlResourcePoolTemplate]()

