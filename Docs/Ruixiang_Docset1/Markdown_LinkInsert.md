## Link Testing
***
## Inline link(Directly Insert)
### External link and title are displayed well
This is [Baidu](http://baidu.com/ "Baidu") inline link.

[This link](http://baidu.com/) has no title attribute.

### Relative reference path
See my [Internal link Topic03](Topic03.md) page for details.

# Internal link
[Internal link Topic03](Topic03.md)

***
## Reference link(define the link outside of sentence)
### External link and title are displayed well
This is [an baidu][id] reference-style link.
[id]: http://baidu.com/  "baidu is title"

### Verify no title displayed
This is [an google][id1] reference-style link with no title.
[id1]: http://google.com/ 

### Verify Same tag when insert reference link
This is [an google][id1] reference-style link.
[id1]: http://google.com/ 

This is [an MSN][id1] reference-style link.
[id1]:http://search.msn.com/  

### Verify mutiple insert and title style
I get 10 times more traffic from [Google] [1] than from
[Yahoo] [2] or [MSN] [3].
  [1]: http://google.com/        "Google"
  [2]: http://search.yahoo.com/   'Yahoo Search'
  [3]: http://search.msn.com/    (MSN Search)

### Verify no title when insert reference link
[Google][]
[Google]: http://google.com/


Share folder
See my [About](//v-rukang/path) page for details


please open e-mail to [ruixiang](v-rukang@microsoft.com).

***
## Images Testing 
***
## inline image
### External Image link and title are displayed
![Image](http://pica.nipic.com/2008-01-09/200819134250665_2.jpg "Title")

### internal image 
![image1](Images\image1.jpg)

## Reference image
### External Image link and title are displayed
 ![Internal image][lalala]
[lalala]: http://pica.nipic.com/2008-01-09/200819134250665_2.jpg "Title"
 
###  internal image 
![image1][11]
 [11]: Images\image1.jpg

# There are all link testing, Thank you very much.
