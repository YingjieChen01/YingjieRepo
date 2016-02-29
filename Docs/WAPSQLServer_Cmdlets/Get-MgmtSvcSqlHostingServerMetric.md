# Get-MgmtSvcSqlHostingServerMetric

## SYNOPSIS
Gets capacity metrics for a SQL Server hosting server.

## DESCRIPTION
The Get-MgmtSvcSqlHostingServerMetric cmdlet gets metrics for a SQL Server hosting server.
By default, all metrics for a specified hosting server are returned.
To get a specific metric, use the MetricName parameter.
You can also narrow your results by using the StartTime and EndTime parameters to specify a date range.

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


### EndTime [DateTime]

```powershell
[Parameter(
  Position = 6,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the end time of the date range as a DateTime object.
To create a DateTime object, use the Get-Date cmdlet.


### HostingServerId [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifes the ID of a SQL Server hosting server.


### MetricName [String[]]

```powershell
[Parameter(
  Position = 4,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies an array of metric names.
You can get the following metrics: DatabaseCount, TotalAllottedSpace.


### StartTime [DateTime]

```powershell
[Parameter(
  Position = 5,
  ValueFromPipelineByPropertyName = $true,
  ParameterSetName = 'Set 1')]
```

Specifies the start time of the date range as a DateTime object.


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
### Example 1: Get the metrics for DatabaseCount

```powershell
PS C:\>Get-MgmtSvcSqlHostingServerMetric -AdminUri "https://Computer01:30004" -Token $Token -HostingServerId "u37k25" -MetricName DatabaseCount


```
NOTE: This example assumes that you have created a token by using Get-MgmtSvcToken and have stored it in a variable named $Token.

This command gets the DatabaseCount metrics for the hosting server with the ID of u37k25.



## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=321812)

[Get-MgmtSvcSqlHostingServer]()

