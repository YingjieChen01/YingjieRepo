
<html>

<h1>Input test</h1>


<form action="HtmlSyntex_Result.md"  accept-charset="UTF-8" enctype="text/plain" method="get" target="_blank">
<p>Here only accept image type</p>
  <input type="file" name="pic" accept="image/*"><br><br>
  
First name: <input type="text" name="FirstName" value="Mickey" ><br>
Last name: <input type="text" name="LastName" value="Mouse"><br>
<input type="submit" value="Submit"><br>

<p>Click the "Submit" button and the form-data will be sent to a page on the server called "HtmlSyntex_Result.md".</p>

<h4>Input with "type" & "checked" attribute:</h4>
<p><input type="checkbox" name="vehicle" value="Bike" /> I have a bike</p>
<p><input type="checkbox" name="vehicle" value="Car" checked="checked" /> I have a car</p>

<h4>option with "selected" attribute:</h4>
<select>
  <option>Volvo</option>
  <option selected="selected">Saab</option>
  <option>Mercedes</option>
  <option>Audi</option>
</select>

<h4>"option" with "multiple" attribute:</h4>
<select multiple="multiple" size="4" >
  <option value="volvo">Volvo</option>
  <option value="saab">Saab</option>
  <option value="mercedes">Mercedes</option>
  <option value="audi">Audi</option>
</select>

<h4>label with "for" attribute:</h4>
<label for="male">Male</label>
<input type="radio" name="sex" id="male" />
<br />
<label for="female">Female</label>
<input type="radio" name="sex" id="female" />

<h3>textarea with rows="4" and cols="5"</h3>
<textarea rows="4" cols="50">
At w3schools.com you will learn how to make a website. We offer free tutorials in all web development technologies.
</textarea>

<h3>textarea with maxlength="50"</h3>
<textarea rows="4" cols="50" maxlength="50">
Enter text here...</textarea>

<h3>textarea with readonly</h3>
<textarea rows="4" cols="50" readonly>
At w3schools.com you will learn how to make a website. We offer free tutorials in all web development technologies.
</textarea>

<h3>textarea with disable</h3>
<textarea disabled>
At w3schools.com you will learn how to make a website. We offer free tutorials in all web development technologies.
</textarea>


<br><h3>tabindex test, <h3>
<p><b>注释：</b>请尝试使用键盘上的 "Tab" 键在链接之间进行导航。</p>
<input type="button" value="button 2" tabindex="2"/>
<input type="button" value="button 1" tabindex="1"/>
<input type="button" value="button 3" tabindex="3"/>

</form>

</html>
  

  
