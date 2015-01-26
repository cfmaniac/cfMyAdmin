<!--- Remove any unneeded datasources --->
<cfinclude template="..\action\act_deleteunwanteddatasources.cfm">

<!--- Load WDDX Serialised data or create blank WDDX file --->
<cfset wddxloadsuccess = false>

<cfif findNoCase("Windows",server.OS.Name)>
	<cfset theConnFile="#GetDirectoryFromPath(GetCurrentTemplatePath())#..\settings\conndata.cfm">
<cfelse>
	<cfset theConnFile="#GetDirectoryFromPath(GetCurrentTemplatePath())#../settings/conndata.cfm">
</cfif>

<cfif FileExists("#theConnFile#")>
	<cftry>
		
		<cfif findNoCase("Windows",server.OS.Name)>
			<cffile action="read" file="#GetDirectoryFromPath(GetCurrentTemplatePath())#..\settings\conndata.cfm" variable="wddxdata">
		<cfelse>
			<cffile action="read" file="#GetDirectoryFromPath(GetCurrentTemplatePath())#../settings/conndata.cfm" variable="wddxdata">
		</cfif>
		
		<cfwddx action="wddx2cfml" input="#wddxdata#" output="connInfo">

		<!--- PORT wasn't available is earlier versions, ensure it exists --->
		<cfif NOT StructKeyExists( connInfo, "connPort" )>
			<cfset connInfo.connPort = ArrayNew(1)>
			<cfloop index="i" from="1" to="#ArrayLen(connInfo.connDescs)#">
				<cfset connInfo.connPort[i] = "3306">
			</cfloop>
		</cfif>

		<cfcatch type="Any">
			<cfset wddxloadsuccess = false>
		</cfcatch>

	</cftry>
	<cfset wddxloadsuccess = true>
</cfif>
<!--- If load was a failure then create new wddx file --->
<cfif NOT wddxloadsuccess>
	<cfscript>
	  connInfo = structNew();
	  connInfo.connDescs = ArrayNew(1); connInfo.connDescs[1] = "New Connection";
	  connInfo.connIPs = ArrayNew(1); connInfo.connIPs[1] = "localhost";
	  connInfo.connUser = ArrayNew(1); connInfo.connUser[1] = "";
	  connInfo.connPass = ArrayNew(1); connInfo.connPass[1] = "";
	  connInfo.connPort = ArrayNew(1); connInfo.connPort[1] = "3306";
	</cfscript>

	<cfwddx action="cfml2wddx" input="#connInfo#" output="wddxConnInfo">
	
	<cfif findNoCase("Windows",server.OS.Name)>
		<cffile action="write" file="#GetDirectoryFromPath(GetCurrentTemplatePath())#..\settings\conndata.cfm" output="#wddxConnInfo#">
	<cfelse>
		<cffile action="write" file="#GetDirectoryFromPath(GetCurrentTemplatePath())#../settings/conndata.cfm" output="#wddxConnInfo#">
	</cfif>

</cfif>
<cfif isdefined("action")>

	<cfparam name="FORM.action">
	<cfswitch expression="#FORM.action#">

		<cfcase value="saveConn">
			<!--- If saving of passwords is disabled, dump all passwords from the WDDX packet --->
			<cfif options_SecurityLevel GTE 5>
				<cfwddx action="WDDX2CFML" input="#FORM.conndata#" output="connInfo">
				<cfloop index="i" from="1" to="#ArrayLen(connInfo.connPass)#"><cfset connInfo.connPass[i] = ""></cfloop>
				<cfwddx action="CFML2WDDX" input="#connInfo#" output="FORM.conndata">
			</cfif>
			
			<cfif findNoCase("Windows",server.OS.Name)>
				<cffile action="write" file="#GetDirectoryFromPath(GetCurrentTemplatePath())#..\settings\conndata.cfm" output="#FORM.conndata#" addnewline="No">
			<cfelse>
				<cffile action="write" file="#GetDirectoryFromPath(GetCurrentTemplatePath())#../settings/conndata.cfm" output="#FORM.conndata#" addnewline="No">
			</cfif>
		</cfcase>
	
	</cfswitch>
	<!--- When saving, commas in variable names are NOT allowed --->
<cfabort>
</cfif>
<!--- ToDo: Prevent right click --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Connection to MySQL-Host...</title>
<style>
body,td{
background-color:buttonface;
font-family:arial,sans-serif;
font-size:11px;
color:black;
}
.buttonDis{
Filter:Alpha(Opacity=20);
-moz-opacity: 0.2;
}
.buttonOk{
Filter:Alpha(Opacity=100);
}
.image {
	background-color:white;
	border:1px solid #848484;
}
.v {
	padding-right:10px;
	padding-top:10px;
	font-size:16px;
	font-weight:bold;
	color:black
}
</style>
<script src="../js/wddx.js" type="text/javascript"></script>
<script type="text/javascript">
var connDescs = new Array(<cfloop index="i" from="1" to="#ArrayLen(connInfo.connDescs)#"><cfif i GT 1>,</cfif>"<cfoutput>#JSStringFormat(connInfo.connDescs[i])#</cfoutput>"</cfloop>);
var connIPs = new Array(<cfloop index="i" from="1" to="#ArrayLen(connInfo.connIPs)#"><cfif i GT 1>,</cfif>"<cfoutput>#JSStringFormat(connInfo.connIPs[i])#"</cfoutput></cfloop>);
var connUser = new Array(<cfloop index="i" from="1" to="#ArrayLen(connInfo.connUser)#"><cfif i GT 1>,</cfif>"<cfoutput>#JSStringFormat(connInfo.connUser[i])#</cfoutput>"</cfloop>);
var connPass = new Array(<cfloop index="i" from="1" to="#ArrayLen(connInfo.connPass)#"><cfif i GT 1>,</cfif>"<cfoutput>#JSStringFormat(connInfo.connPass[i])#</cfoutput>"</cfloop>);
var connPort = new Array(<cfloop index="i" from="1" to="#ArrayLen(connInfo.connPort)#"><cfif i GT 1>,</cfif>"<cfoutput>#JSStringFormat(connInfo.connPort[i])#</cfoutput>"</cfloop>);
function doNADA(){return false;}
try { document.attachEvent("oncontextmenu",doNADA); } catch(e) {}




</script>
<script src="../js/connopen.js"></script>
</head>

<body bgcolor="buttonface" onload="init()">
<table cellpadding=0 cellspacing=0 border=0 width="100%" height="100%">
<tr>
	<td height=70 class="image" align=left valign=middle><table style="background-color:white" cellspacing=0 cellpadding=0 width=100%><tr><td valign=middle style="background-color:white;padding-left:5px"><img src="../images/logo.gif" width="257" height="52" align=absmiddle alt="" border="0"></td><td valign=middle align=right style="background-color:white" class="v">Version <cfoutput>#application.version#</cfoutput></td></tr></table></td>
</tr>
<form onsubmit="return false;">
<tr>
	<td valign=top>

		<table cellpadding=0 cellspacing=0 width="100%" height=100%>
		<tr><td height="40">
			<table cellpadding=0 cellspacing=10 border=0 align=center>
			<tr>
			<td width="33%"><button id="butNew" style="width:90px;" class="buttonOk" onClick="if(this.className!='buttonDis')newConn();"><img src="../images/icons/new.gif" width="16" height="16" alt="" border="0" align="absmiddle">&nbsp;New</button></td>
			<cfif options_SecurityLevel LT 10><td width="33%"><button id="butSave" style="width:90px;" class="buttonDis" onClick="if(this.className!='buttonDis')saveConn();"><img src="../images/icons/save.gif" width="16" height="16" alt="" border="0" align="absmiddle">&nbsp;Save</button></td></cfif>
			<td><button id="butDel" style="width:90px;" class="buttonDis" onClick="if(this.className!='buttonDis')delConn();"><img src="../images/icons/dropTable.gif" width="16" height="16" alt="" border="0" align="absmiddle">&nbsp;Delete</button></td>
			</tr>			
			</table>		
		</td></tr>
		<tr><td height="20">
		
			<table cellpadding=5 cellspacing=0 border=0 width="100%">
			<tr>
				<td width="80">Description:</td>
				<td><select name="desc" style="width:100%;" onchange="showConn(this.selectedIndex)"></select></td>
				<td width="24"><input type="button" value=".." style="width:24px;" onClick="editDesc()"></td>
			</tr>
			</table>
		
		</td></tr>
		<tr><td>
		
			<table cellpadding=5 cellspacing=0 border=0 width="100%">
			<tr><td width="80">Hostname/IP:</td>
				<td>
					<table cellspacing=0 cellpadding=0 border=0 width="100%">
					<tr>
						<td><input type="text" name="ip" size="20" value="" style="width:100%;" onkeydown="enableSave(true)"></td>
						<td width=50 align=right>Port:</td>
						<td width=50><input type="text" name="port" size="5" value="" style="width:50px;" onkeydown="enableSave(true)"></td>
					</tr>
					</table>
				</td>
			</tr>
			<tr><td width="80">User:</td><td><input type="text" name="user" size="20" value="" style="width:100%;" onkeydown="enableSave(true)"></td></tr>
			<tr><td width="80">Password:</td><td><input type="password" name="password" size="20" value="" style="width:100%;" onkeydown="enableSave(true)"></td></tr>
			<tr><td width="80">&nbsp;</td><td style="font:10px verdana,sans-serif;color:#848284;">
				<cfif options_SecurityLevel LT 5>
				Security Level: LOW<br>(All connection data saved)<br>Security Warning: Do not perform save with password on remote servers.
				<cfelseif options_SecurityLevel LT 10>
				Security Level: MEDIUM<br>(Passwords not saved)
				<cfelse>
				Security Level: HIGH<br>(Not allowed save connection data)
				</cfif>
			</td></tr>
			</table>
		
		</td></tr>
		</table>

	</td>
</tr>
<tr>
	<td height="26" align="right">
	<hr>
		<div style="padding-right:16px">
		<input type="button" value="Connect!" style="width:84;" onclick="connect()">
		&nbsp;&nbsp;
		<input type="button" value="Cancel" style="width:84;" onclick="window.close();">
		</div>
		</form>
		<form name="workerform" target="worker" action="connopen.cfm" method="post">
		<input type="hidden" name="action" value="">
		<input type="hidden" name="conndata" value="">
		</form>
		<iframe name="worker" src="about:blank" width=1 height=1 style="display:none;"></iframe>
	</td>
</tr>
</table>
</body>
</html>
