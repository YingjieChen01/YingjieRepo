# Apply Quantization Function.xml

*Assign numbers into buckets using a quantization function*

Category: [Deprecated](27565421-8F99-41A5-9B76-241B103E4E88)


## Module Overview
returns a dataset where each element has been binned 
according to the specified mode. It also returns a function that can be passed to
Apply Quantization Function module to bin new samples of data using the
same binning mode and parameters.

> [!NOTE]
> Input columns must be numeric, and for quantile binning there must be a sufficient
> range of data points to determine the quantiles. Otherwise an error or NaN result may occur.

During binning, each input element is mapped to a bin by comparing its value
against positions of bin edges. For example, if value is 1.5 and bin edges are 1,2,3,
the element would be mapped to bin number 2. Value 0.5 would be mapped to bin number 1
(the underflow bin), and value 3.5 would be mapped to bin number 4 (the overflow bin).

The binning mode specifies how the bin edges are determined:


- 
    
    The data is binned so as to make
distribution across bins equal\-height. Parameter “Number of bins”
must be specified
    
    Parameter “Quantile normalization” must also be specified.
This parameter determines the normalization: \[1,number of bins],
\[0,1] or \[0,100]

-  
    
    data is binned into N equal\-width bins.
For this mode, narameter “Number of bins” must be specified.

-  
    
    For this mode, parameters  “First edge position”, “Bin width” and
“Last edge position” must be specified.

-  
    
    For this mode, a comma\-separated list of bin edges in sorted order must
be specified.

The same binning rule is applied to all columns specified in list of
columns to quantize. The output mode specifies how the quantized values are
returned. Choices include appending input table, overwriting columns in input
table, and returning result columns only.

The option “Tag columns as categorical” can be used to control
whether the quantized columns become categorical variables.

> [!NOTE]
> To apply different quantization rule to different columns,
> chain together multiple instances of Quantize module, and in each
> instance select a subset of columns to quantize.
>
> If column to bin (quantize) is sparse, then bin index offset (quantile offset) is used when resulting column is populated.
> The offset is chosen so that sparse 0 always goes to bin with index 0 (quantile with value 0).
> As a result, sparse zeros are propagated from input to output column.
> Notice that processing of dense column always produces result with minimum bin index equal 1 (minimum quantile value equal minimum value in the column).
> At the same time, processing of sparse column produces result with variable minimum bin index (minimum quantile value).
>
> All NaNs and missing values are propagated from input to output column.
> The only exception is the case when the module returns quantile indexes.
> In this case all NaNs are promoted to missing values.


## Expected Inputs


|Name|Type|Description|
|--------|--------|---------------|
|Dataset||Input dataset|
|Binning function|Function|Select a predefined quantization function to apply|


## Outputs


|Name|Type|Description|
|--------|--------|---------------|
|Quantized dataset||Dataset after quantization is applied|

</br>
</br>
