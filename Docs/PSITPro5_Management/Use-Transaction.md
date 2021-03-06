﻿# Use-Transaction

## SYNOPSIS
Adds the script block to the active transaction.

## DESCRIPTION
The Use-Transaction cmdlet adds a script block to an active transaction.
This enables you to do transacted scripting using transaction-enabled Microsoft .NET Framework objects.
The script block can contain only transaction-enabled .NET Framework objects, such as instances of the Microsoft.PowerShell.Commands.Management.TransactedString class.

The UseTransaction parameter, which is optional for most cmdlets, is required when using this cmdlet.

The Use-Transaction cmdlet is one of a set of cmdlets that support the transactions feature in Windows PowerShell.
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




### TransactedScript [ScriptBlock]

```powershell
[Parameter(
  Mandatory = $true,
  Position = 1,
  ParameterSetName = 'Set 1')]
```

Specifies the script block that is run in the transaction.
Enter any valid script block enclosed in braces ( { } ).
This parameter is required.


### UseTransaction [switch]

```powershell
[Parameter(ParameterSetName = 'Set 1')]
```

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see



## INPUTS
### None

You cannot pipe input to this cmdlet.

## OUTPUTS
### PSObject

Use-Transaction returns the result of the transaction.

## NOTES
The Use-Transaction parameter includes the command in the active transaction.
Because the Use-Transaction cmdlet is always used in transactions, this parameter is required to make any Use-Transaction command effective.


## EXAMPLES
### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>start-transaction
PS C:\>$transactedString = New-Object Microsoft.PowerShell.Commands.Management.TransactedString
PS C:\>$transactedString.Append("Hello")
PS C:\>use-transaction -TransactedScript { $transactedString.Append(", World") } -UseTransaction
PS C:\>$transactedString.ToString()
Hello
PS C:\>use-transaction -transactedScript { $transactedString.ToString() } -UseTransaction
Hello, World
PS C:\>complete-transaction
PS C:\>$transactedString.ToString()
Hello, World

```
This example shows how to use the Use-Transaction cmdlet to script against a transaction-enabled .NET Framework object.
In this case, the object is a TransactedString object.

The first command uses the Start-Transaction cmdlet to start a transaction.

The second command uses the New-Object command to create a TransactedString object.
It stores the object in the $TransactedString variable.

The third and fourth commands both use the Append method of the TransactedString object to add text to the value of $TransactedString.
One command is part of the transaction; the other is not.

The third command uses the Append method of the transacted string to add "Hello" to the value of $TransactedString.
Because the command is not part of the transaction, the change is applied immediately.

The fourth command uses the Use-Transaction cmdlet to add text to the string within the transaction.
The command uses the Append method to add ", World" to the value of $TransactedString.
The command is enclosed in braces ( {} ) to make it a script block.
The UseTransaction parameter is required in this command.

The fifth and sixth commands use the ToString method of the TransactedString object to display the value of the TransactedString as a string.
Again, one command is part of the transaction; the other is not.

The fifth command uses the ToString method to display the current value of the $TransactedString variable.
Because it is not part of the transaction, it displays only the current state of the string.

The sixth command uses the Use-Transaction cmdlet to run the same command within the transaction.
Because the command is part of the transaction, it displays the current value of the string within the transaction, much like a preview of the transaction changes.

The seventh command uses the Complete-Transaction cmdlet to commit the transaction.

The final command uses the ToString method to display the resulting value of the variable as a string.






### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>start-transaction
PS C:\>$transactedString = New-Object Microsoft.PowerShell.Commands.Management.TransactedString
PS C:\>$transactedString.Append("Hello")
PS C:\>use-transaction -TransactedScript { $transactedString.Append(", World") } -UseTransaction
PS C:\>undo-transaction
PS C:\>$transactedString.ToString()
Hello

```
This example shows the effect of rolling back a transaction that includes Use-Transaction commands.
Like all commands in a transaction, when the transaction is rolled back, the transacted changes are discarded and the data is unchanged.

The first command uses the Start-Transaction cmdlet to start a transaction.

The second command uses the New-Object command to create a TransactedString object.
It stores the object in the $TransactedString variable.

The third command, which is not part of the transaction, uses the Append method to add "Hello" to the value of $TransactedString.

The fourth command uses the Use-Transaction cmdlet to run another command that uses the Append method within the transaction.
The command uses the Append method to add ", World" to the value of $TransactedString.

The fifth command uses the Undo-Transaction cmdlet to roll back the transaction.
As a result, all commands performed within the transaction are reversed.

The final command uses the ToString method to display the resulting value of $TransactedString as a string.
The results show that only the changes made outside of the transaction were applied to the object.







## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/p/?linkid=293929)

[Complete-Transaction]()

[Get-Transaction]()

[Start-Transaction]()

[Undo-Transaction]()

[about_Transactions]()

