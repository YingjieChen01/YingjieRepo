
<html>
<head>
<script type="text/javascript">
function disp_prompt()
  {
  var name=prompt("Please enter your name","Bill Gates")
  if (name!=null && name!="")
    {
    document.write("Hello " + name + "!")
    }
  }
</script>
</head>
<body>
<h1>Input test</h1>

<br>**form test**<br>
<form action="HtmlSyntex.md"  accept-charset="UTF-8" enctype="text/plain" method="get" target="_blank">
<p>Here only accept image type</p>
  <input type="file" name="pic" accept="image/*"><br><br>
  
First name: <input type="text" name="FirstName" value="Mickey" ><br>
Last name: <input type="text" name="LastName" value="Mouse"><br>
<input type="submit" value="Submit"><br>

<p>Click the "Submit" button and the form-data will be sent to a page on the server called "HtmlSyntex_Result.md".</p>

<label for="male">Male</label>
<input type="radio" name="sex" id="male" />
<br />
<label for="female">Female</label>
<input type="radio" name="sex" id="female" />

<br><h3>prompt<h3>
<input type="button" onclick="disp_prompt()"
value="Display a prompt box" />

</form>
</body>
</html>
  

  
