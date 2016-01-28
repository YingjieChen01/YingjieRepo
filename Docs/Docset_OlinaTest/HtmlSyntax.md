<h1>Html syntext test<h1>
<html>
<head>
<style>
blockquote { 
    display: block;
    margin-top: 1em;
    margin-bottom: 1em;
    margin-left: 40px;
    margin-right: 40px;
}
</style>
</head>

<body>
<h3>"itemscope" and "itemprop" in div </h3>
<!--<p itemscope><time itemprop="date" datetime="2016-01-27">20160127</time> I want to <a itemprop="url" href="http://www.w3schools.com">W3C</a> Learn HTML</p><br>-->
 
<section id="contact-details">  
<div itemscope itemtype="http://schema.org/Person">   
  <div class="header">  
   <h1><span itemprop="name">Olina Liu</span></h1>  
   <div itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">  
    <ul class="info">  
        <li class="address">  
            <span itemprop="street">Shanghai </span>  
        </li>  
        </ul>   
        <ul class="info">  
        <li class="phone">  
                  <span itemprop="telephone">  1595052****  </span>  
        </li>  
        <li class="email">  
              <a href="mailto:liutao10@beyondsoft.com" itemprop="email">liutao10@beyondsoft.com </a>  
        </li>                 
    </ul>  
   </div>   
  </div>  
</div>  
</section>  


<h3>"Headings" test</h3>

<h1>H1</h1>
<h2>H2</h2>
<h3>H3</h3>
<h4>H4</h4>
<h5>H5</h5>
<h6>H6</h6>
<h7>H7</h7>
<h8>H8</h8>
<br/>

## **Prose**
<h3>***** "P" test*****</h3>
<p>Here is a Paragraphs</p>
<p>Here is another Paragraphs</p>
<p>Note: Below is blockquote</p>
<blockquote cite="http://www.worldwildlife.org/who/index.html">
For 50 years, WWF has been protecting the future of nature. The world's leading conservation organization, WWF works in 100 countries and is supported by 1.2 million members in the United States and close to 5 million globally.
<blockquote>Here is nest blockquote</blockquote>
</blockquote>

<h3>***** "div" test*****</h3>
<p>This is some text.</p>
<div style="color:red">
  <h3>This is a heading in a div element</h3>
  <p>This is some text in a div element.</p>
</div>
<p>This is some text.</p>

<h3>*****"ruby" test*****</h3>
<ruby>
  漢 <rp>(</rp><rt>han</rt><rp>)</rp>
  字 <rp>(</rp><rt>zi</rt><rp>)</rp>
</ruby>
<br>



<h4> ** "pre" test** <h4><br/>
<pre>
 Text in a pre element
 is displayed in a fixed-width
 font, and it preserves
 both      spaces and
 line breaks
</pre> 

<br/>


## **Break test**
<h3>br test</h3>
<p>
To break lines<br>in a text,<br>use the br element.
</p>

<h3>hr test</h3>
<p>Leave 2 spaces at the end of a line to do a<hr /> line break</p>

<h3>hr with noshade attribute test</h3>
<p>Leave 2 spaces at the end of a line to do a<hr noshade="noshade" /> line break</p>

<h3>br with clear attribute test</h3>

<img src="Images\flower.jpg" align="left" />
This text should wrap around the image, flowing between the image and the right margin of the document.
<br clear="left" />
This text will flow as well, but will be below the image, extending across the full width of the page. there will be whitespace above this text and to the right of the image.

</body>
</html>