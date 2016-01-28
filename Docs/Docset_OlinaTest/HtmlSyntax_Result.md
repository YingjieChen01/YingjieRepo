
<html>
 
<head>

 <script type="text/javascript">
        window.onload = function () 
        {
             var Name = Response.QueryString["FirstName"];
             document.getElementById("aaa").value=Name;
        }

    </script>
<style type="text/css">
h1 {color:#FF0000;}
p {color:#0000FF;}
body {background-color:#FFEFD6;}
</style>

<style type="text/css" media="print">
h1 {color:#000000;}
p {color:#000000;}
body {background-color:#FFFFFF;}
</style>
</head>

<body>
<h1>Header 1</h1>
<p>A paragraph.</p>

<input type="text" id="aaa"/>
</p>
</body>
</html>

