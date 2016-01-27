
<html>
<head>
<title>Title tag test: Title of the document</title>
</head>

<body>
The content of the document......<br>

<h3>Dir test: list directory titles</h3>
<dir>
  <li>html</li>
  <li>xhtml</li>
  <li>css</li>
</dir>

<h3> "Abbr" test</h3><br>
<p>The <abbr title="World Health Organization">WHO</abbr> was founded in 1948.</p>

<h4>The "cite" tag:</h4>
<p><cite>The Scream</cite> by Edward Munch. Painted in 1893.</p>



<h3>*****"lang" test with Franch language*****</h3>
<p>This is a paragraph.</p>
<p lang="fr">Ceci est un paragraphe.</p>

<h3>"Span" test</h3>
<p>My mother has <span style="color:blue;font-weight:bold">blue</span> eyes and my father has 
<span style="color:darkolivegreen;font-weight:bold">dark green</span> eyes.</p>

<h3>font size and color test</h3>
<p><font size="4" color="red">This is some text!</font></p>
<p><font size="3" color="blue">This is some text!</font></p>

<h3>"summary" test</h3>
<details>
<summary>HTML 5</summary>
This document teaches you everything you have to learn about HTML 5.
</details><br>
</body>


<h3>"area" with "shape" & "coords" & "nohref" and img with "usemap" test</h3>
<p>Click on the sun or on one of the planets to watch it closer: the left one is no href</p>

<img src="http://www.w3schools.com/tags/planets.gif" width="145" height="126" alt="Planets" usemap="#planetmap">

<map name="planetmap">
  <area shape="rect" coords="0,0,82,126" alt="Sun" nohref="nohref" href="http://www.w3schools.com/tags/sun.htm">
  <area shape="circle" coords="90,58,3" alt="Mercury" href="http://www.w3schools.com/tags/mercur.htm">
  <area shape="circle" coords="124,58,8" alt="Venus"  href="http://www.w3schools.com/tags/venus.htm">
</map>

<h3>"time" with "datetime" attribute:</h3>
<p>We open at <time>10:00</time> every morning.</p>

<p>I have a date on <time datetime="2008-02-14 20:00">Valentines day</time>.</p>

<p><b>Note:</b> The time element does not render as anything special in any of the major browsers.</p>

</html>
