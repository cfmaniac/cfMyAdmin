<cfif SESSION.connectString IS "">
	<html><body><script>top.location.href="../index.cfm";</script></body></html>
	<cfabort>
</cfif>
<html>
<head>
	<title>Host</title>
	<link rel="STYLESHEET" type="text/css" href="../css/dcToolbar.css">

<style>
body,td {
 background-color:buttonface;
 margin:0px;
 padding:0px;
 font-family:verdana,arial;
 font-size:10px;
}

.overAll {
  width:100%;
  height:100%;
  background-color:buttonface;
  padding:2px;
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

<cfparam name="selHostTab" default="variables">

<script>
var lastT="<cfoutput>#selHostTab#</cfoutput>tab";

function changeTab(theTab)
{
	if(lastT!=null){
		document.getElementById(lastT).className="atabOff";
	}

	document.getElementById(theTab).className="atabOn";
    tabContentsHost.document.location="../tabs/host/"+theTab+".cfm";
    lastT=theTab;  
}

function h(theId)
{
	if(theId!=lastT) document.getElementById(theId).style.backgroundColor="#e0e0e0";
}
</script>
</head>
<body>

<cfmodule template="..\modules\smartquery.cfm" queryname="getTableData"><cfoutput>
SHOW VARIABLES
</cfoutput></cfmodule>

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

<cfset theTabTitle="#getServerInfo.version# / uptime: "  & TimeFormat(uptime)>

<script>
parent.hideTools("tableTools");
parent.hideTools("databaseTools");
parent.document.getElementById("theTitleBar").innerText="<cfoutput>#theTabTitle#</cfoutput>";
</script>

<table width=100% cellspacing=0 cellpadding=0 border=0 height="100%">
<tr><td valign=middle height=24>

	<table cellspacing=0 cellpadding=0 border=0 width="100%">
	<tr>
	 <td valign=bottom width=100 style="cursor:pointer;cursor:hand;" align=center>
		<!----------Tab------->
		<table id="variablestab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif selHostTab is "variables">On<cfelse>off</cfif>"><tr><td align=left style="padding-left:5px;">Variables (<cfoutput>#getTableData.recordCount#</cfoutput>)</td></tr></table>
		<!---------/Tab-------->
	 </td>
	 <td valign=bottom width=100  style="cursor:pointer;cursor:hand;" align=center>
	 <!----------Tab------->
	  <table id="processtab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif selHostTab is "process">On<cfelse>off</cfif>"><tr><td align=left style="padding-left:5px;">Process-List</td></tr></table>
	 <!---------/Tab-------->
	 </td>
	 <td style="border-bottom:1px solid #ffffff;" align=center valign=bottom>&nbsp;</td>
	</tr>
	<tr><td colspan="3" height="1"><img src="../images/spacer.gif" width="1" height="1" alt="" border="0"></td></tr>
	</table>

</td></tr>
<tr><td valign=top>

<table cellspacing=0 cellpadding=0 border=0 height=100% width="100%" style="border-bottom:1px solid #808080;border-right:1px solid #808080;">
<tr>
 <td style="border-left:1px solid white;padding:5px;">
  <!--------------------------Tools----------------------------------->
  <table cellspacing=0 cellpadding=0 width=100% height=100%>
   <tr>
    <td valign=top>
	  <iframe scrolling="Auto" frameborder=0 width=100% height="100%" name="tabContentsHost" id="tabContentsHost" src="../tabs/host/<cfoutput>#selHostTab#</cfoutput>tab.cfm">
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
