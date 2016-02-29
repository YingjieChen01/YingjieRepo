# Set-MgmtSvcSqlResourcePoolTemplate

## SYNOPSIS
Modifies values of a resource pool template.

## DESCRIPTION
The Set-MgmtSvcSqlResourcePoolTemplate cmdlet modifies values of a resource pool template.
After you create a resource pool from a template, you can no longer edit the values in that template.

## PARAMETERS

### AdminUri [Uri]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1)]
```

Specifies the URI of the Windows Azure Pack administrator API.
Use the following format: https://\<computer\>:\<port\>, where \<computer\> is the computer on which the administrator API is installed.


### CapCpuCores [Decimal]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 6,
  ParameterSetName = 'Set 1')]
```

Specifies the hard cap limit to the number of CPU cores to reserve for a resource pool.
The combined value of hard cap CPU cores for all resource pools on a server can exceed the total number of CPU cores on the server.


### DisableCertificateValidation [switch]

Disables certificate validation for the Windows Azure Pack installation.
If you specify this parameter, you can use self-signed certificates.


### MaxCpuCores [Decimal]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 5,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum number of CPU cores to reserve for a resource pool.
The combined value of maximum CPU cores for all resource pools on a server can exceed the total number of CPU cores on the server


### MaxIopsPerVolume [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 10,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum physical I/O operations per second (IOPS) per disk volume to reserve for a resource pool.
The combined value of minimum IOPS per volume for all resource pools on a server can exceed the supported number of IOPS per volume on the server.


### MaxMemoryMB [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 8,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum amount of memory to reserve for a resource pool.
The combined value of maximum memory for all resource pools on a server can exceed the total amount of memory on the server.


### MaxSubscriptionsPerPool [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 11,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum number of subscriptions that can be associated with a resource pool.
A value of 1 indicates a dedicated resource pool for every subscription.
A dedicated resource pool can be used to define a service level agreement which guarantee the minimum CPU, memory, and I/O for a subscription.
A value greater than 1 indicates a shared resource pool where multiple subscriptions share the same resource limits.
A shared resource pool can help control a scenario where single tenant might try to monopolize all the resources on server instance.


### MinCpuCores [Decimal]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 4,
  ParameterSetName = 'Set 1')]
```

Specifies the minimum number of CPU cores to reserve for a resource pool.
The combined value of minimum CPU cores for all resource pools on a server cannot exceed the total number of CPU cores on the server.


### MinIopsPerVolume [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 9,
  ParameterSetName = 'Set 1')]
```

Specifies the minimum physical IOPS per disk volume to reserve for a resource pool.
The combined value of minimum IOPS per volume for all resource pools on a server cannot exceed the supported number of IOPS per volume on the server.


### MinMemoryMB [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 7,
  ParameterSetName = 'Set 1')]
```

Specfies the minimum amount of memory to reserve for a created resource pool.
The combined value of minimum memory for all created resource pools on a server cannot exceed the total amount of memory set on the server.


### ResourcePoolTemplate [SqlResourcePoolTemplate]

```powershell
[Parameter(
  Position = 3,
  ParameterSetName = 'Set 2')]
```

Specifies the resource pool template to add to Windows Azure Pack.


### TemplateName [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 3,
  ParameterSetName = 'Set 1')]
```

Specifies a friendly name for the resource pool template.


### Token [String]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 2)]
```

Specifies an identity token.
To create a token, use the Get-MgmtSvcToken cmdlet.


### WorkloadGroupMaxRequests [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 15,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum number of simultaneous requests that are allowed to run in the workload group.
Specify a value of zero (0) to allow unlimited requests.


### WorkloadMaxDegreeOfParallelism [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 16,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum degree of parallelism (DOP) for parallel requests.
Specify a value of zero (0) to use the global SQL Server setting.


### WorkloadRequestMaxCpuTimeSec [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 12,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum CPU time, in seconds, that a request can use.
Specify a value of zero (0) for an unlimited amount.


### WorkloadRequestMaxMemoryGrantMB [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 13,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum amount of memory that a request can take from the resource pool.


### WorkloadRequestMemoryGrantTimeoutSec [Int32]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 14,
  ParameterSetName = 'Set 1')]
```

Specifies the maximum time, in seconds, that a query can wait for a memory grant to become available.
Specify a value of zero (0) to allow SQL Server to determine the maximum time.



## INPUTS
### None


## OUTPUTS
### System.Object

This cmdlet returns a System.Object.


## EXAMPLES
### 1:

```powershell
```




## RELATED LINKS

[Get-MgmtSvcSqlResourcePoolTemplate]()

[Remove-MgmtSvcSqlResourcePoolTemplate]()

