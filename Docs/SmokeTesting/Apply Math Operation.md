# Apply Math Operation.xml

*Apply a mathematical operation to the selected columns*

Category: [Statistical Functions](8A248CBA-24AA-4779-AAD6-35D73A0A2340)


## Module Overview
[!INCLUDE[M_ApplyMathOp](Token\M_ApplyMathOp.md)] returns a data table where elements of
selected columns have been transformed by the specified operation.
For unary operations, such as Abs(x), the operation is applied to each
of elements. For binary operations, such as Subtract(x,y), two selections
of columns are required and the result is computed over pairs of elements
between columns.

**Column Type Evaluation**

Input columns must be numeric and the range of data must be valid for
the selected mathematical operation. Otherwise an error or NaN result may
occur. For example, Ln(\-1.0) yields NaN result.

For a sparse column all elements that correspond to background zeros are not processed in an unary operation.
If one argument of a binary operation is a sparse column and the other argument is a dense one,
then the resulting column is sparse with all background zeros propagated from input sparse column.
If both arguments of a binary operation are sparse columns, then the resulting column
contains background zeros in all positions where both input columns contained background zeros.

For a categorical column the operation is applied not only to column data, but also to categorical data values.


-   If a unary operation is applied to a categorical column, then different categorical data values of input column can be transformed
to equal associated categorical data values of the output column.
    In this case the values are merged and the number of categorical data values in the output becomes less than the number in the input.

-   The same statement is true also for the case when a binary operation is applied to a categorical column and the second argument
of the operation is a scalar.

-   If a binary operation is applied to a categorical column and some other column, then the behavior of the module is as follows:
    
    1. If the other column is dense, then the output column is categorical.
        Categorical data values present in input are lost.
        The output column has only those values that are present in output column data.    
    2. If the other column is sparse, then the output column is sparse.


## Expected Inputs


|Name|Type|Description|
|--------|--------|---------------|
|Dataset|[!INCLUDE[T_DataTable](Token\T_DataTable.md)]|Input dataset|


## Module Parameters


|Name|Range|Type|Default|Description|
|--------|---------|--------|-----------|---------------|
|Category|any|MathMethods|Trigonometric|Choose a category of mathematical functions|
|Trigonometric function|any|TrigMethods|Sin|Select a trigonometric function|
|Basic math function|any|BasicMethods|Abs|Select one of the provided basic math functions|
|Comparison function|any|ComparisonMethods|EqualTo|Select one of the comparison operations to apply, given the specified values and columns|
|Basic operation|any|OperationMethods|Add|Select an arithmetic operation to use with the specified arguments|
|Rounding operation|any|RoundingMethods|Floor|Select a type of rounding operation to apply to the specified columns|
|Special function|any|SpecialMethods|Erf|Choose one of the provided special math function|
|Column set|any|ColumnSelection|NumericAll|Select the columns to include in or exclude from the operation|
|Second argument type|any|ApplyMathOpSecArgType|Constant|Select the type of value used in second argument of the match function|
|Second argument|any|ColumnSelection|NumericAll|Specify the value of the second argument|
|Constant second argument|any|Float|1.0|Specify the constant used in the second argument of the math function|
|Value to compare type|any|ApplyMathOpSecArgType|ColumnSet|Choose the type of value used in the second argument of the comparison function|
|Value to compare|any|ColumnSelection|NumericAll|Select the column that contains the value to compare|
|Constant value to compare|any|Float|1.0|Specify a constant to use in the second argument of the comparison|
|Operation argument type|any|ApplyMathOpSecArgType|Constant|Choose the type of values to use in the operation|
|Operation argument|any|ColumnSelection|NumericAll|Select the column that contains the values used in the second argument of the operation|
|Constant operation argument|any|Float|1.0|Specify a constant used in the second argument of the operation|
|Precision Type|any|ApplyMathOpSecArgType|Constant|Choose the type of values that will be rounded|
|Precision|any|ColumnSelection|NumericAll|Select the column that contains the precision information|
|Constant Precision|any|Float|1.0|Specify a constant that determines the precision of rounding functions|
|Operation argument type|any|ApplyMathOpSecArgType|ColumnSet|Select the type of values used in the parameter of the special function|
|Parameter|any|ColumnSelection|NumericAll|Select a column to use as parameter in the special function|
|Constant Parameter|any|Float|1.0|Specify a constant to use as a parameter in the special function|
|Output mode|any|OutputTo|ResultOnly|Specify how the result values should be output|


## Outputs


|Name|Type|Description|
|--------|--------|---------------|
|Results dataset|[!INCLUDE[T_DataTable](Token\T_DataTable.md)]|Results dataset|

</br>
</br>
