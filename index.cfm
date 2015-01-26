<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>CFMyAdmin - MySQl DB Administration Tool - From Digital Crew</title>
	<link rel="STYLESHEET" type="text/css" href="css/filemenu.css">
	<script src="js/filemenu.js"></script>

	<!--- Prepair Cool Button Widget --->
	<link type="text/css" rel="StyleSheet" href="sys/widgets/cb2/cb2.css">
	<script type="text/javascript" language="JavaScript1.5" src="sys/widgets/cb2/ieemu.js"></script>
	<script type="text/javascript" src="sys/widgets/cb2/cb2.js"></script>

</head>
<body>

<style>
body {
 margin:0px;
 padding:0px;
 background-color:buttonface;
}
</style>

<table cellspacing=0 cellpadding=0 width=100% height="100%">
<tr>
 <td height=20><cfinclude template="templates/filemenu.cfm"></td>
</tr>
<tr>
 <td height=2><cfinclude template="templates/toolbar.cfm"></td>
</tr>
<tr>
 <td width="100%" height="100%">
	<iframe width="100%" scrolling="No" height="100%" name="workwindow" src="templates/workwindow.cfm"></iframe>
 </td>
</tr>
</table>
<iframe name="workFrame" src="templates/checkforupdate.cfm" style="display:none;"></iframe>

</body>
</html>
