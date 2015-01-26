<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Host - Variable</title>
<style>
body,td {
 background-color:buttonface;
 margin:0px;
 padding:0px;
 font-family:verdana,arial;
 font-size:10px;
}


td.columnHeader{
background-color:buttonface;
border-top:1px solid buttonhighlight;
border-left:1px solid buttonhighlight;
border-bottom:1px solid #848284;
border-right:1px solid #848284;
padding-top:1px;
padding-bottom:1px;
padding-left:3px;
padding-right:3px;
}

td.columnRow{
background-color:white;
border-bottom:1px solid #707070;
border-right:1px solid #707070;
padding-top:1px;
padding-bottom:1px;
padding-left:3px;
padding-right:3px;
font-family: verdana,arial;
font-size:11px;
vertical-align:top;
}

</style>
</head>

<body>

<cfmodule template="..\..\modules\smartquery.cfm" queryName="getTableData"><cfoutput>
SHOW PROCESSLIST
</cfoutput></cfmodule>

<table width=100% cellspacing=0 cellpadding=0>
<tr><td class="columnHeader">Id</td><td class="columnHeader">User</td>
<td class="columnHeader">Host</td>
<td class="columnHeader">DB</td>
<td class="columnHeader">Command</td>
<td class="columnHeader">Time</td>
<td class="columnHeader">State</td>
<td class="columnHeader">Info</td>
</tr>
<cfoutput query="getTableData">
<tr><td class="columnRow">#Id#</td><td class="columnRow">#user#</td>
<td class="columnRow">#Host#</td>
<td class="columnRow">#db#&nbsp;</td>
<td class="columnRow">#Command#</td>
<td class="columnRow">#Time#</td>
<td class="columnRow">#State#&nbsp;</td>
<td class="columnRow">#Info#&nbsp;</td>
</tr>
</cfoutput>
</table>


</body>
</html>
