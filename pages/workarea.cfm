<cfif SESSION.connectString IS "">
	<html><body><script>alert("Sorry,\nYour session had timed out.");top.location.href="../index.cfm";</script></body></html>
	<cfabort>
</cfif>
<cfif isdefined("action")>

	<cfswitch expression="#action#">
	
		<cfcase value="emptytable">

			<cftry>
				<cfmodule template="..\modules\smartquery.cfm" queryname="emptyTable"><cfoutput>
				DELETE FROM #val1#
				</cfoutput></cfmodule>
				<cfoutput>
					<html><body>
					<script>
						parent.tabContents.location.reload();
					</script>
					</body></html>
				</cfoutput>
				<cfcatch type="Database">
					<cfmodule template="..\modules\mod_dberrorhandler.cfm" errorTitle="Error Emptying Database">
				</cfcatch>
			</cftry>

		</cfcase>

		<cfcase value="droptable">

			<cftry>
				<cfmodule template="..\modules\smartquery.cfm" queryname="emptyTable"><cfoutput>
				DROP TABLE #val1#
				</cfoutput></cfmodule>
				<cfoutput>
					<html><body>
					<script>
						parent.tabContents.location.reload();
						parent.parent.leftSide.refreshFrame();
					</script>
					</body></html>
				</cfoutput>
				<cfcatch type="Database">
					<cfmodule template="..\modules\mod_dberrorhandler.cfm" errorTitle="Error Emptying Database">
				</cfcatch>
			</cftry>

		</cfcase>

	</cfswitch>

	<cfabort>
	
</cfif>
<html>
<head>
	<title>Work Area</title>
	<link rel="STYLESHEET" type="text/css" href="../css/dctoolbar.css">
	<!--- Prepair Cool Button Widget --->
	<link type="text/css" rel="StyleSheet" href="../sys/widgets/cb2/cb2.css">
	<script type="text/javascript" language="JavaScript1.5" src="../sys/widgets/cb2/ieemu.js"></script>
	<script type="text/javascript" src="../sys/widgets/cb2/cb2.js"></script>
</head>

<body>

<style>
body {
	background-color:buttonface;
	margin:0px;
	padding:0px;
}
.atabOn {
	border-top:1px solid #ffffff;
	border-bottom:1px solid buttonface;
	border-left:1px solid #ffffff;
	border-right:1px solid #808080;
	font-family:arial;
	font-size:11px;
	color:black;
	font-weight:bold;
	height:25px;
}
	.atabOff {
	border-top:1px solid #ffffff;
	border-bottom:1px solid #ffffff;
	border-left:1px solid #ffffff;
	border-right:1px solid #808080;
	background-color:buttonface;
	font-family:arial;
	font-size:11px;
	color:black;
	height:22px;
}
</style>

<cfparam name="theTable" default="">
<cfparam name="theDatabase" default="">
<cfparam name="theType" default="host">

<cfif Len(theTable)>
	<cfset theDatabase=listgetat(theTable,1,".")>
</cfif>

<cfif Len(theDatabase)>
	<cfmodule template="..\modules\smartquery.cfm" queryname="emptyTable"><cfoutput>
	USE #theDatabase#
	</cfoutput></cfmodule>
</cfif>

<form name="updaterForm" action="workarea.cfm" method="post" target="updater" style="display:none;">
<input type="hidden" name="action" value="">
<input type="hidden" name="val1" value="">
<input type="hidden" name="val2" value="">
</form>

<iframe name="updater" src="about:blank" width="1" height="1" style="display:none"></iframe>

<script>
var last="<cfoutput>#theType#</cfoutput>tab";
var theDatabase = "<cfoutput>#JSStringFormat(theDatabase)#</cfoutput>";
var theTable = "<cfoutput>#JSStringFormat(theTable)#</cfoutput>";

var theType = "<cfoutput>#theType#</cfoutput>";
function changeTab(theTab)
{
	if(last!=null)
	{
		document.getElementById(last).className="atabOff";
	}
	document.getElementById(theTab).className="atabOn";
	tabContents.document.location="../tabs/"+theTab+".cfm?theDatabase="+theDatabase+"&theTable="+theTable+"&theType="+theTab;
	parent.leftSide.tabSelected = theTab;
	last=theTab;  
}

function h(theId)
{
	if(theId!=last) document.getElementById(theId).style.backgroundColor="#e0e0e0";
}

function dbCreateTable()
{
	var height=379;
	var width=505;
	var sLeft=(screen.width-width)/2;
	var sTop=(screen.height-height)/2;
	var cString="width="+width+",height="+height+",top=" + sTop + ", left=" + sLeft + ",resizable=no,toolbar=no";
	window.open("../pages/popup_createtable.cfm?theDatabase="+theDatabase, "dbCreateTable", cString);
}
function dbViewData()
{
	var selTable = tabContents.getSelectedTable();
	if( selTable == null ) return;
	theTable = selTable;
	tabContents.setTreeIcon();
	if( theType == "database" ) document.location = '../pages/workarea.cfm?theType=data&theTable='+ theTable;
	else document.getElementById("datatab").onclick();
}
function dbShowTable()
{
	var selTable = tabContents.getSelectedTable();
	if( selTable == null ) return;
	theTable = selTable;
	tabContents.setTreeIcon();
	if( theType == "database" ) document.location = '../pages/workarea.cfm?theType=table&theTable='+ theTable;
	else document.getElementById("tabletab").onclick();
}
function dbEmptyTable()
{
	var selTable = tabContents.getSelectedTable();
	if( selTable == null ) return;
	if( confirm("Empty Table '"+selTable+"'?") )
	{
		with( document.updaterForm )
		{
			action.value = "emptytable";
			val1.value = selTable;
			submit();
		}
	}
}
function dbDropTable()
{
	var selTable = tabContents.getSelectedTable();
	if( selTable == null ) return;
	if( confirm("Drop Table '"+selTable+"'?") )
	{
		with( document.updaterForm )
		{
			action.value = "droptable";
			val1.value = selTable;
			submit();
		}
	}
}
function dbCopyTable()
{
	alert("Not done yet. Due for version 1.5.");
}
function tbViewData()
{
	if( theType == "database" ) document.location = '../pages/workarea.cfm?theType=data&theTable='+ theTable;
	else document.getElementById("datatab").onclick();
}
</script>

<cfmodule template="..\modules\smartquery.cfm" queryname="getServerInfo"><cfoutput>
SELECT VERSION() AS version
</cfoutput></cfmodule>

<cfmodule template="..\modules\smartquery.cfm" queryname="getServerStatus"><cfoutput>
SHOW STATUS
</cfoutput></cfmodule>

<cfset nameList = ValueList(getServerStatus.Variable_name)>
<cfset valuList = ValueList(getServerStatus.Value)>

<cfset uptime = ListGetAt( valuList, ListFind(nameList,"Uptime") )>
<cfset uptime = CreateTimeSpan(0,0,0,uptime)>

<cfswitch expression="#theType#">

	<cfcase value="host">
		<cfset theTabTitle="#getServerInfo.version# / uptime: "  & TimeFormat(uptime)>
	</cfcase>
	
	<cfcase value="Database">
		<cfset theTabTitle="Viewing Database: " & theDatabase>
	</cfcase>
	
	<cfcase value="table">
		<cfset theTabTitle="Viewing Table Design: " & theTable>
	</cfcase>
	
	<cfcase value="data">
		<cfset theTabTitle="Viewing Data in Table " & theTable & " of Database " & theDatabase>
	</cfcase>
	
	<cfcase value="query">
		<cfset theTabTitle="SQL Query">
	</cfcase>

</cfswitch>

<script>
function showTools(theToolBar)
{
 //set the toolbar on
 document.getElementById(theToolBar).style.visibility="visible";
 document.getElementById(theToolBar).style.overflow="visible";
 document.getElementById(theToolBar).style.width="28px";
}

function hideTools(theToolBar)
{
 //set the toolbar on
 document.getElementById(theToolBar).style.visibility="hidden";
 document.getElementById(theToolBar).style.overflow="hidden";
 document.getElementById(theToolBar).style.width="0px";
}
</script>

<table width="100%" cellspacing=0 cellpadding=0 border=0 height=100%>
<tr><td height=20 align=center valign=top>

<table cellspacing=0 cellpadding=0 border=0 width="100%">
<tr>
 <td valign=bottom width=100  style="cursor:pointer;cursor:hand;" align=center>
  <!----------Tab------->
  <table id="hosttab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "host">On<cfelse>off</cfif>"><tr><td width=15 style="padding-left:20px" align=right><img src="../images/icons/server.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Host</td></tr></table>
 <!---------/Tab-------->
 </td>
 <cfif not theType is "host">
 <td valign=bottom width=100  style="cursor:pointer;cursor:hand;" align=center>
 <!----------Tab------->
  <table id="databasetab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "database">On<cfelse>off</cfif>"><tr><td width=15 style="padding-left:20px" align=right><img src="../images/icons/databaseTab.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Database</td></tr></table>
 <!---------/Tab-------->
 </td>
 </cfif>
 <cfif not theType is "database" AND not theType is "host">
 <td valign=bottom width=100  style="cursor:pointer;cursor:hand;" align=center>
 <!----------Tab------->
  <table id="tabletab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "table">On<cfelse>off</cfif>"><tr><td width=15 style="padding-left:20px" align=right><img src="../images/icons/table.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Table</td></tr></table>
 <!---------/Tab-------->
 </td>
 <td valign=bottom width=100  style="cursor:pointer;cursor:hand;" align=center>
 <!----------Tab------->
  <table id="datatab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "data">On<cfelse>off</cfif>"><tr><td width=15 style="padding-left:20px" align=right><img src="../images/icons/data.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Data</td></tr></table>
 <!---------/Tab-------->
 </td>
 </cfif>
 <td valign=bottom width=100  style="cursor:pointer;cursor:hand;" align=center>
 <!----------Tab------->
  <table id="querytab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "query">On<cfelse>off</cfif>"><tr><td width=15 style="padding-left:20px" align=right><img src="../images/icons/sql.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Query</td></tr></table>
 <!---------/Tab-------->
 </td>
 <td style="border-bottom:1px solid #ffffff;" align=center valign=bottom>&nbsp;</td>
</tr>
</table>

</td></tr>
<tr><td valigh=top height=18>

<table style="border-left:1px solid white;border-right:1px solid #848284;" cellspacing=0 cellpadding=0 border=0 height=20 width="100%">
<tr>
 <td height=20 style="padding-left:5px;padding-right:5px;padding-top:5px;">
  <table cellspacing=0 cellpadding=0 border=0 width=100% style="background-color:#08246B;border-left:1px solid #848284;border-top:1px solid #848284;border-right:1px solid #ffffff;border-bottom:1px solid #ffffff;">
  <tr>
	<td height=20 style="padding-left:5px;font-size:12px;color:#ffffff;font-weight:bold;font-family:arial;" id="theTitleBar"><cfoutput>#theTabTitle#</cfoutput></td>
  </tr>
  </table>
 </td>
</tr>
</table>

</td></tr>
<tr><td>

<table cellspacing=0 cellpadding=0 border=0 height=100% width="100%">
<tr>
 <td style="border-left:1px solid white;padding:5px;">
  <!--------------------------Tools----------------------------------->
  <table cellspacing=0 cellpadding=0 width=100% height=100%>
   <tr>
    
    <td width=1 valign=top>
	 
	 <!-----------Tools-------------->
	 <div id="databaseTools" style="width:0px;visibility:hidden;height:1px;overflow:hidden;">
	 <cfinclude template="../templates/vdatabasetoolbar.cfm">
	 </div>

	 <div id="tableTools" style="width:0px;visibility:hidden;height:1px;overflow:hidden;">
	 <cfinclude template="../templates/vtabletoolbar.cfm">
	 </div>
	 <!------------------------------>	
	
	</td>

    <td valign=top>
	  <iframe frameborder=1 width="100%" height="100%" scrolling="Auto" name="tabContents" id="tabContents" src="../tabs/<cfoutput>#theType#</cfoutput>tab.cfm?theDatabase=<cfoutput>#theDatabase#</cfoutput>&theTable=<cfoutput>#theTable#</cfoutput>">
	</td>
   </tr>
  </table>
  <!------------------------------------------------------------------>
 </td>
</tr>
</table>

</td></tr>
</table>


</body>
</html>
