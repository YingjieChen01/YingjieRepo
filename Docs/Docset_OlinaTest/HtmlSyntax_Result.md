
<html>
 
<head>

 <script type="text/javascript">
        window.onload = function () 
        {
             var Name = Response.QueryString["FirstName"];
              alert(Name);
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
<p>
The first name is：@<%=Request.Form("FirstName")%> <br>
The last name is：<%=Request.Form("LastName")%> <br>

The first name is：Request(FirstName) <br>
The last name is：Request(LastName) <br>

The first name is：@Response.QueryString["FirstName"] <br>
The last name is：Response.QueryString["LastName"] <br>

</p>
</body>
</html>

