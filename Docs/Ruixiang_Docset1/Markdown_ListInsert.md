# Bulieted list Test
***
## Bulleted list start with "*" 
* aaa
* bbb
* ccc

## Bulleted list start with "+"
+ aaa
+ bbb
+ ccc

## Bulleted list start with "-"
- aaa
- bbb
- ccc

## Bulleted list start with "*+-" 
* aaa
+ bbb
- ccc


## Verify the max number of space berfore *（Right）
   * aaa
   * bbb
   * ccc
  
## Verify the max number of space berfore *（False）
    * aaa
    * bbb
    * ccc

## Verify error when no indenting after "*"/"+"/"-" 
 
 *aaa
 *bbb
 *ccc
 
 ## Verify max number of space in the indent between tag and message 

### 4 spaces
*    aaa
*    bbb
*    ccc
 
### 1 tab
*   aaa
*   bbb
*   ccc
 
### 5 spaces 

*      aaa
*      bbb
*      ccc
 
 
### 2 tabs

*       aaa
*       bbb
*       ccc
 
# Ordered list Test
 ***
## Verify Start with number and a dot
### (true)
1. aaa
2. bbb
3. ccc

### (false)
1. aaa
2, bbb
c. ccc

## Verify the list numbers are not ordered
### Start with 1.2.3.
1. aaa
2. bbb
3. ccc

### Start with 3.7.9.
3. aaa
7. bbb
9. ccc

## Verify max number of space in the indent between tag and message 

### 4 spaces
1.    aaa
2.    bbb
3.    ccc
 
### 1 tab
1.  aaa
2.  bbb
3.  ccc
 
### 5 spaces 

1.     aaa
2.     bbb
3.     ccc
 
 
### 2 tabs

 1.     aaa
 2.     bbb
 3.     ccc


# Nest list
***
 ## Verify indent with ">" for sub list
 1. aaa
 >2. bbb
 >5. eee
 3. ccc
 
## Verify indent with 8 spaces/2 tabs
### 7 spaces
*   A list item with a blockquote:
       This is a blockquote
              
### 8 spaces
*   A list item with a blockquote:
        This is a blockquote
        
### 1 tab
*   A list item with a blockquote:
    This is a blockquote
 
### 2 tabs   
*   A list item with a blockquote:
        This is a blockquote
        
## Table testing 
***
## insert table
 | Tables        | Are           | Cool  |
 | ------------- |:-------------:| -----:|
 | col 3 is      | right-aligned | $1600 |
 | col 2 is      | centered      |   $12 |
 | zebra stripes | are neat      |    $1 |
 
## Insert table with blank lines

 | Tables        | Are           | Cool  |
 | ------------- |:-------------:| -----:|
 | col 3 is      | right-aligned | $1600 |

 | col 2 is      | centered      |   $12 |
 | zebra stripes | are neat      |    $1 |
 
 ## Content of each line unaligned
| Tables        | Are           | Cool  |
                                | ------------- |:-------------:| -----:|
            | col 3 is      | right-aligned | $1600 |
                                            | col 2 is      | centered      |   $12 |
    | zebra stripes | are neat      |    $1 |
    
## Align Right + Align Left + Align Center
| Tables        | Are           | Cool  |
 | -------------: |:-------------|:-----:|
 | col 3 is      | right-aligned | $1600 |
 | col 2 is      | centered      |   $12 |
 | zebra stripes | are neat      |    $1 |
 
## No content Line with only dash
 | Tables        | Are           | Cool  |
  | ------------- |:-------------:| -----:|
 | col 3 is      | right-aligned | $1600 |
 | | | |
 | col 2 is      | centered      |   $12 |
 | zebra stripes | are neat      |    $1 |  
       
# These are all lists testing, Thank you very much. 