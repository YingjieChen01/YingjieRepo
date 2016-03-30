# Add Rows.xml

*Append rows of second input dataset to the end of the first dataset*

## Module Overview
[!INCLUDE[M_AddRows](Token\M_AddRows.md)] concatenates two datsets, by addingthe rows of the second dataset to the end of the first dataset.


-   To concatenate rows together, the rows must have the same number of values (columns).

-   The number of rows in the new dataset equals the sum of the columns of both input datasets.

-   You cannot filter on the source dataset when adding rows \-\- all the rows from both inputs are concatenated when you use [!INCLUDE[M_AddColumns](Token\M_AddColumns.md)]. If you want to add only a few rows, use [!INCLUDE[M_Splitter](Token\M_Splitter.md)] to define a condition by which to filter the rows and generate a dataset with just the rows you want.

**Examples**

Concatenation of rows is useful in these scenarios:


-   You have generated a series of evaluation statistics and want to combine them into one table for easier reporting. (See the [Sentiment Analysis](http://azure.microsoft.com/en-us/documentation/services/machine-learning/models/) example.)

-   You have been working with different datasets and wat ot append one to the other to create the final dataset. (See the [Breast Cancer](http://azure.microsoft.com/en-us/documentation/services/machine-learning/models/) example.)


## Expected Inputs


|Name|Type|Description|
|--------|--------|---------------|
|Dataset1|[!INCLUDE[T_DataTable](Token\T_DataTable.md)]|Dataset rows to be added to the output dataset first|
|Dataset2|[!INCLUDE[T_DataTable](Token\T_DataTable.md)]|Dataset rows to be appended to the first dataset|


## Outputs


|Name|Type|Description|
|--------|--------|---------------|
|Results dataset|[!INCLUDE[T_DataTable](Token\T_DataTable.md)]|Dataset that contains all rows of both input datasets|


## Exceptions


|Exception|Description|
|-------------|---------------|
|[!INCLUDE[E_NullOrEmpty](Token\E_NullOrEmpty.md)]|Exception occurs if one or more of inputs are null or empty.|
|[!INCLUDE[E_NotEqualColumnNames](Token\E_NotEqualColumnNames.md)]|Exception occurs if input datasets have column names that should match but do not.|
|[!INCLUDE[E_NotCompatibleColumnTypes](Token\E_NotCompatibleColumnTypes.md)]|Exception occurs if input datasets passed to the module should have compatible column types but do not.|
|[!INCLUDE[E_NotInRangeValue](Token\E_NotInRangeValue.md)]|Exception occurs if parameter is not in range.|



