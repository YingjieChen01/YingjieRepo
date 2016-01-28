<html>
<head>
<script type="text/javascript">
function disp_prompt()
  {
  var name=prompt("Please enter your name","Bill Gates");
  if (name!=null && name!="")
    {
    document.write("Hello " + name + "!")
    }
  }
</script>
</head>
<body>
<br><h3>prompt<h3>
<input type="button" onclick="disp_prompt()"
value="Display a prompt box" />
</body>
</html>