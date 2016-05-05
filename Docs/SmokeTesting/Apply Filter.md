# Apply Filter.xml

*Apply a filter such as IIR, moving average, and FIR to columns of a dataset*

Category: [Data Transformation\Filter](529B4991-8A7F-4E12-8F36-51F9FACA4383)


## Module Overview
returns a dataset in which the selected columns have been transformed by the specified filter.


## Technical Notes

### Filter Periods
When you apply a filter to a column, note that the filter period is determined in part by the filter type,as follows:


-   For Finite Impulse Response, Simple Moving Average, and Triangular Moving Average filters, the filter period is **finite**.

-   For Infinite Impulse Response, Exponential Moving Average, and Cumulative Moving Average filters, the filter period is **infinite**.

-   For Threshold filters, the filter period is always **1**.

-   For Median filters, regardless of the filter period, NaNs and missing values in the input signal do not produce new NaNs in output.


### How Missing Values are Handled
If a filter encounters a NaN or a missing value in the input dataset, the output dataset becomes spoiled with NaNs for some next number of samples, depending on the filter period. This has the following consequences:


-   Filters created using Finite Impulse Response, Simple Moving Average, or Triangular Moving Average have a finite period; thus, any missing value will be followed by a number of NaNs equal to the filter order minus one.

-   Filters created using Infinite Impulse Response, Exponential Moving Average, or Cumulative Moving Average have an infinite period; thus, after the first missing value is encountered, NaNs will continue to propogate indefinitely.

-   Because the period of the Threshold filter equals 1, missing values and NaNs do not propagate.

-   For Median filters, NaNs and missing values encountered in the input dataset do not produce new NaNs in output, regardless of the filter period.


##
## Expected Inputs


|Name|Type|Description|
|--------|--------|---------------|
|Filter||Filter implementation|
|Dataset||Input dataset|


## Module Parameters


|Name|Range|Type|Default|Description|
|--------|---------|--------|-----------|---------------|
|Column set|any|ColumnSelection|NumericAll|Select the columns to filter|


## Outputs


|Name|Type|Description|
|--------|--------|---------------|
|Results dataset||Output dataset|


## See Also
Reference  modules



|Module|Description|
|----------|---------------|
||Create a finite impulse response (FIR) filter|
||Create an infinite impulse response (IIR) filter|
||Create a median filter|
||Create a moving average filter|
||Create a threshold filter|
||Create a custom IIR or FIR filter|

</br>
</br>
