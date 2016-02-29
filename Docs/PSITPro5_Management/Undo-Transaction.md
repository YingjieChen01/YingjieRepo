# Undo-Transaction

## SYNOPSIS
Rolls back the active transaction.

## DESCRIPTION
The Undo-Transaction cmdlet rolls back the active transaction.
When you roll back a transaction, the changes made by the commands in the transaction are discarded and the data is restored to its original form.

If the transaction includes multiple subscribers, an Undo-Transaction command rolls back the entire transaction for all subscribers.

By default, transactions are rolled back automatically if any command in the transaction generates an error.
However, transactions can be started with a different rollback preference and you can use this cmdlet to roll back the active transaction at any time.

The Undo-Transaction cmdlet is one of a set of cmdlets that support the transactions feature in Windows PowerShell.
For more information, see about_Transactions.

## PARAMETERS

### InformationAction [System.Management.Automation.ActionPreference]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
[ValidateSet(
  'SilentlyContinue',
  'Stop',
  'Continue',
  'Inquire',
  'Ignore',
  'Suspend')]
```




### InformationVariable [System.String]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```




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

You cannot pipe input to this cmdlet.

## OUTPUTS
### None

This cmdlet does not return any output.

## NOTES
You cannot roll back a transaction that has been committed.

You cannot roll back any transaction other than the active transaction.
To roll back a different, independent transaction, you must first commit or roll back the active transaction.

Rolling back the transaction ends the transaction.
To use a transaction again, you must start a new transaction.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>undo-transaction

```
This command rolls back the current (active) transaction.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>cd hkcu:\software
PS HKCU:\Software> start-transaction
PS HKCU:\Software> new-item MyCompany -usetransaction
PS HKCU:\Software> undo-transaction

```
This command starts a transaction and then rolls it back.
As a result, no changes are made to the registry.






### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>cd hkcu:\software
PS HKCU:\Software> start-transaction
PS HKCU:\Software> new-item MyCompany -usetransaction
PS HKCU:\Software> get-transaction

RollbackPreference   SubscriberCount   Status
------------------   ---------------   -----
Error                1                 Active

PS HKCU:\Software> start-transaction
PS HKCU:\Software> get-transaction

RollbackPreference   SubscriberCount   Status
------------------   ---------------   -----
Error                2                 Active

PS HKCU:\Software> undo-transaction
PS HKCU:\Software> get-transaction

RollbackPreference   SubscriberCount   Status
------------------   ---------------   -----
Error                0                 RolledBack

```
This example demonstrates that when any subscriber rolls back a transaction, the entire transaction is rolled back for all subscribers.

The first command changes the location to the HKCU:\Software registry key.

The second command starts a transaction.

The third command uses the New-Item cmdlet to create a new registry key.
The command uses the UseTransaction parameter to include the change in the transaction.

The fourth command uses the Get-Transaction cmdlet to get the active transaction.
Notice that the status is Active and the subscriber count is 1.

The fifth command uses the Start-Transaction command again.
Typically, starting a transaction while another transaction is in progress occurs when a script used by the main transaction includes its own complete transaction. (This example is done interactively so that you can examine it in stages.) When you enter a Start-Transaction command while another transaction is in progress, the commands join the existing transaction as a new "subscriber" and the subscriber count is incremented.

The sixth command uses the Get-Transaction cmdlet to get the active transaction.
Notice that the subscriber count is now 2.

The seventh command uses the Undo-Transaction cmdlet to roll back the transaction.
This command does not return any objects.

The final command is a Get-Transaction command that gets the active (or in this case, the most recently active) transaction.
The results show that the transaction is rolled back, and that the subscriber count is 0, showing that the transaction was rolled back for all subscribers.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293928)

[Complete-Transaction]()

[Get-Transaction]()

[Start-Transaction]()

[Use-Transaction]()

[about_Providers]()

[about_Transactions]()

