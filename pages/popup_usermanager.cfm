<cfinclude template="..\templates\mysqldatatypes.cfm">
<cfif isdefined("action")>

	<cfswitch expression="#action#">
	
		<cfcase value="addField">

			
		</cfcase>
		
	</cfswitch>

</cfif>

<cfparam name="theType" default="addUser">

<html>
<head>
	<title>CFMYAdmin - User Manager</title>
<style>
body {
 background-color:buttonface;
 margin:2px;
 padding:0px;
}
body,td{
font:11px icon,arial,sans-serif;
}
.atabOn {
	border-top:2px outset #ffffff;
	border-bottom:2px solid buttonface;
	border-left:2px outset #ffffff;
	border-right:2px inset #808080;
	font-family:arial;
	font-size:11px;
	color:black;
	font-weight:bold;
	height:25px;
}
.atabOff {
	border-top:2px outset #ffffff;
	border-bottom:2px inset #ffffff;
	border-left:2px outset #ffffff;
	border-right:2px inset #808080;
	background-color:buttonface;
	font-family:arial;
	font-size:11px;
	color:black;
	height:22px;
}
</style>

<script>
var last="<cfoutput>#theType#</cfoutput>Tab";
var theType = "<cfoutput>#theType#</cfoutput>";

function changeTab(theTab)
{
	if(last!=null)
	{
		document.getElementById(last).className="atabOff";
	}
	document.getElementById(theTab).className="atabOn";
	document.getElementById( last + "Content" ).style.display = "none";
	document.getElementById( theTab + "Content" ).style.display = "block";
	last=theTab;
}
function h(theId)
{
	if(theId!=last) document.getElementById(theId).style.backgroundColor="#e0e0e0";
}


function addField()
{
	with( document.addFieldForm )
	{
		submit();
	}
}
</script>
</head>
<body onload="">

<table cellpadding=2 cellspacing=0 border=0 width="100%" height="100%">
<form name="addFieldForm" action="popup_addField.cfm" method="post" target="updater">

<cfif isdefined("theField")><input type="hidden" name="theField" value="<cfoutput>#theField#</cfoutput>"></cfif>
<tr><td height=20>

  <table cellspacing=0 cellpadding=0 border=0 width=100% style="background-color:#08246B;border-left:1px solid #848284;border-top:1px solid #848284;border-right:1px solid #ffffff;border-bottom:1px solid #ffffff;">
  <tr>
	<td height=20 style="padding-left:5px;font-size:12px;color:#ffffff;font-weight:bold;font-family:arial;" id="theTitleBar">User Manager</td>
  </tr>
  </table>

</td></tr>
<tr><td style="padding-left:4px;padding-right:4px;">

	<table width="100%" cellspacing=0 cellpadding=0 border=0 height=100%>
	<tr><td height=20 align=center valign=top>
	
	<table cellspacing=0 cellpadding=0 border=0 width="100%">
	<tr>
	 <td valign=bottom width=100  style="cursor:hand;" align=center>
	  <!----------Tab------->
	  <table id="addUserTab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "addUser">On<cfelse>off</cfif>"><tr><td width=16 style="padding-left:10px" align=right><img src="../images/icons/addUser.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Add User</td></tr></table>
	 <!---------/Tab-------->
	 </td>
	 <td valign=bottom width=100  style="cursor:hand;" align=center>
	 <!----------Tab------->
	  <table id="editUserTab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "index">On<cfelse>off</cfif>"><tr><td width=16 style="padding-left:10px" align=right><img src="../images/icons/editUsers.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Edit Users</td></tr></table>
	 <!---------/Tab-------->
	 </td>
	 <td style="border-bottom:2px inset #ffffff;" align=center valign=bottom>&nbsp;</td>
	</tr>
	</table>
	
	</td></tr>
	<tr><td valign=top align=center style="border-left:2px outset buttonhighlight;border-right:2px inset #848284;border-bottom:2px inset #848284;">
		
		<div id="addUserTabContent">
			<div style="padding-right:15px;padding-left:15px;padding-top:0px;text-align:left;">
				<fieldset style="padding:20px;text-align:left;">
					<legend>Add User</legend>
					<br>
					Coming soon to a MySQL manager near you ;)<br>
					<br>
					Check back to <a href="http://www.cfmyadmin.com.com" target="_blank">www.CFMYAdmin.com</a> for version 1.5<br>
					
				</fieldset>
			</div>
			<!--
			<!--------------Add User Form---------------->
			<table width=100%>
			<tr>
				<td width=50% valign=top style="padding:10px;">
					<!------------LHS------------>
					<table width=100%>
						<tr>
							<td colspan=2><b>Credentials</b></td>
						</tr>
						<tr>
							<td>Username</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>From Host</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>Password</td>
							<td><input type="text"></td>
						</tr>
					</table>
					<br><hr><br>
					<table width=100%>
						<tr>
							<td width=70><b>Privledges</b></td>
							<td><input type="checkbox" id="cb"><label for="cb">All Privledges</label></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td valign=top align=left>
							<div style="padding:5px;height:170px;background-color:white;border:1px solid black;">
							Hete
							</div>
							</td>
						<tr>
					</table>
					<!--------------------------->
				</td>
				<td width=50% valign=top style="padding:10px;">
					<!------------RHS------------>
					
					<!--------------------------->
				</td>
			</tr>
			</table>-->
			<!------------------------------------------->
		</div>
		<div id="editUserTabContent" style="display:none;">
			<div style="padding-right:15px;padding-left:15px;padding-top:0px;text-align:left;">
				<fieldset style="padding:20px;text-align:left;">
					<legend>Edit User</legend>
					<br>
					Coming soon to a MySQL manager near you ;)<br>
					<br>
					Check back to <a href="http://www.cfmyadmin.com.com" target="_blank">www.CFMYAdmin.com</a> for version 1.5<br>
					
				</fieldset>
			</div>
		</div>
	
	</td></tr>
	</table>

</td></tr>
<tr><td height=40 align=right>
	<table cellpadding=5 cellspacing=0 border=0>
	<tr>
		<td><input type="button" value="<cfif isdefined("theTable")>Update<cfelse>Add</cfif> Field" onclick="addField()"></td>
		<td><input type="button" value="Cancel" onclick="window.close();"></td>
	</tr>
	</table>
</td></tr>
</form>
</table>

<iframe name="updater" width="1" height="1" style="display:none;"></iframe>

</body>
</html>
