<h1>Table test</h1>

<html>
<head>
<style>
thead {color:green;}
tbody {color:blue;}
tfoot {color:red; background:Silver;}

table, th, td {
    border: 1px solid black;
}
</style>
</head>

<body>
<h4>Simple table<h4>
<table>
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
  <tr>
    <td>February</td>
    <td>$80</td>
  </tr>
</table>
<br>

<h4>Simple table with cellpadding<h4>
<table cellpadding="50">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
  <tr>
    <td>February</td>
    <td>$80</td>
  </tr>
</table>
<br>

<h4>Simple table with cellspacing<h4>
<table cellspacing="50">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
  <tr>
    <td>February</td>
    <td>$80</td>
  </tr>
</table>
<br>

<h4>Table with frame="above":</h4>
<table frame="above">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
</table>

<h4>Table with rules="cols":</h4>
<table rules="cols">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
</table>


<h4>Table with colspan="2":</h4>
<table width="60%" border="1">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td colspan="2">January</td>
  </tr>
  <tr>
    <td colspan="2">February</td>
  </tr>
</table>

<h4>Table with rowspan="2":</h4>
<table width="60%" border="1">
  <tr>
    <th>Month</th>
    <th>Savings</th>
    <th>Savings for holiday!</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
    <td rowspan="2">$50</td>
  </tr>
  <tr>
    <td>February</td>
    <td>$80</td>
  </tr>
</table>

<h4>Table with align="right" at the first data col & valign="bottom" at the second data col:</h4>
<table width="60%" border="1">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr style="height:50px">
    <td align="right">January</td>
    <td valign="bottom">$100</td>
  </tr>
</table>

<h4>Table with headers attribute:</h4>
<table style="width:60%">
  <tr>
    <th id="name">Name</th>
    <th id="email">Email</th>
    <th id="phone">Phone</th>
    <th id="addr">Address</th>
  </tr>
  <tr>
    <td headers="name">John Doe</td>
    <td headers="email">someone@example.com</td>
    <td headers="phone">+45342323</td>
    <td headers="addr">Rosevn 56,4300 Sandnes,Norway</td>
  </tr>
</table>

<h4>Table with scope attribute:</h4>
<!--The scope attribute defines a way to associate header cells and data cells in a table.
Syntax: <td scope="col|row|colgroup|rowgroup">-->

<table>
  <tr>
    <th></th>
    <th scope="col">Month</th>
    <th scope="col">Savings</th>
  </tr>
  <tr>
    <td>1</td>
    <td>January</td>
    <td>$100</td>
  </tr>
  <tr>
    <td>2</td>
    <td>February</td>
    <td>$80</td>
  </tr>
</table>


<h4>td with nowrap="nowrap":</h4>
<table>
  <tr>
    <th>Poem</th>
    <th>Poem</th>
  </tr>
  <tr>
    <td nowrap="nowrap">Never increase, beyond what is necessary, the number of entities required to explain anything</td>
    <td>Never increase, beyond what is necessary, the number of entities required to explain anything</td>
  </tr>
</table>

<h4>td with axis:</h4>
<p><b>Note:</b> The axis attribute is not supported by any of the major browsers.</p>
<table border="1" width="60%">
  <tr>
    <th axis="name">Name</td>
    <th axis="contact">Email</td>
    <th axis="contact">Phone</td>
    <th axis="contact">Address</td>
  </tr>
  <tr>
    <td axis="name">George Bush</td>
    <td axis="contact">someone@example.com</td>
    <td axis="contact">+789451236</td>
    <td axis="contact">Fifth Avenue New York,USA</td>
  </tr>
</table>

<h4>td with char:</h4>
<table border="1">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td align="char" char=".">$100.00</td>
  </tr>
  <tr>
    <td>February</td>
    <td align="char" char=".">$10.00</td>
  </tr>
</table>

<h4>td with charoff="2":</h4>
<table>
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td align="char" char="." charoff="2">$100.00</td>
  </tr>
  <tr>
    <td>February</td>
    <td align="char" char="." charoff="2">$10.00</td>
  </tr>
</table>


<h4>Complex table: with thead, tfoot, tbody<h4>
<table>
  <thead>
    <tr>
      <th>Month</th>
      <th>Savings</th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <td>Sum</td>
      <td>$180</td>
    </tr>
  </tfoot>
  <tbody>
    <tr>
      <td>January</td>
      <td>$100</td>
    </tr>
    <tr>
      <td>February</td>
      <td>$80</td>
    </tr>
  </tbody>
</table>

</body>
</html>
