# New-MgmtSvcSqlResourcePoolTemplate

## SYNOPSIS


## DESCRIPTION


## PARAMETERS

### AdminUri [Uri]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1)]
```




### CapCpuCores [Decimal]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### DisableCertificateValidation [switch]




### MaxCpuCores [Decimal]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### MaxIopsPerVolume [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### MaxMemoryMB [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### MaxSubscriptionsPerPool [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### MinCpuCores [Decimal]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### MinIopsPerVolume [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### MinMemoryMB [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### ResourcePoolTemplate [SqlResourcePoolTemplate]

```powershell
[Parameter(
  Position = 3,
  ParameterSetName = 'Set 2')]
```




### TemplateName [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ParameterSetName = 'Set 1')]
```




### Token [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2)]
```




### WorkloadGroupMaxRequests [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### WorkloadMaxDegreeOfParallelism [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### WorkloadRequestMaxCpuTimeSec [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### WorkloadRequestMaxMemoryGrantMB [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```




### WorkloadRequestMemoryGrantTimeoutSec [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  ParameterSetName = 'Set 1')]
```





## INPUTS
### None


## OUTPUTS
### 




## EXAMPLES
### 1:

```powershell
PS C:\>

```




## RELATED LINKS

