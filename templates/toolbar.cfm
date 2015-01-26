<cfif isdefined("action")>

	<cfswitch expression="#action#">
	
		<cfcase value="doQuickSQL">
			<cftry>
				<cfmodule template="..\modules\smartquery.cfm" queryname="doQuickSQL"><cfoutput>
				#FORM.SQL#
				</cfoutput></cfmodule>
				<cfoutput><html><body><script>alert("SQL Executed Successfully\n\n#JSStringFormat(FORM.SQL)#");</script></body></html></cfoutput>
				<cfcatch type="Database">
					<cfmodule template="..\modules\mod_dberrorhandler.cfm" errorTitle="Error Executing SQL ""#SQL#""">
				</cfcatch>
			</cftry>
			<cfabort>
		</cfcase>

	</cfswitch>

</cfif>
<script>
var queryTxt="";
function openConnDiag(path)
{
	if( arguments.length < 1 ) path = "";
	var width=494;
	var height=378;
	var sLeft=(screen.width-width)/2;
	var sTop=(screen.height-height)/2;
	var cString="width="+width+",top="+sTop+", left="+sLeft+",height="+height+",resizable=no";
	
	var serverConnWin = window.open(path+"pages/connopen.cfm", "connDialog", cString);
}
function updateToolbar(status)
{
	switch( status )
	{
		case 'onConnOpen':
			enableBut(1,0,false);
			for( i=1; i<7; i++ ) enableBut(1,i,true);
			break;
		case 'onConnClose':
			enableBut(1,0,true);
			for( i=1; i<7; i++ ) enableBut(1,i,false);
			break;
	}
}
function closeConn()
{
	workwindow.document.location.href = "templates/workwindow.cfm?action=disconnect";
	updateToolbar("onConnClose");
}
function printCurrPane()
{
	workwindow.workArea.tabContents.print();
}

function createDB() {
	if( workwindow.leftSide ) workwindow.leftSide.createDB();
}

function dropDB(dbname)
{
	if( arguments.length < 1 ) dbname = workwindow.leftSide.getSelectedDB();
	if( dbname == "" ) return;
	if( confirm("Drop Database '"+dbname+"'?\n\nWARNING: You will lose all tables in database "+dbname+"!") )
	{
		with( document.workForm )
		{
			action.value = "dropDB";
			val1.value = dbname;
			submit();
		}
	}
}
function dropTable(tableName)
{
	if( confirm("Drop Table '"+tableName+"'?") )
	{
		with( document.workForm )
		{
			action.value = "dropTable";
			val1.value = tableName;
			submit();
		}
	}
}
function refreshPane()
{
	if( workwindow.leftSide )
	{
		workwindow.leftSide.refreshFrame();
		workwindow.workArea.location.reload();
	}
	else workwindow.location.reload();
}
function doQuickSQL(inSQL)
{
	with( document.quickSQLForm )
	{
		action.value = "doQuickSQL";
		SQL.value = inSQL;
		submit();
	}
	return false;
}
function reloadPrivileges()
{
	doQuickSQL("FLUSH PRIVILEGES");
}

function userManager() {
	alert("Coming in version 1.5");
	return;
	var width=500;
	var height=300;
    var sLeft=(screen.width-width)/2;
	var sTop=(screen.height-height)/2;
	
	var params=eval("'height="+height+", width="+width+", top="+sTop+", left="+sLeft+", scrollbars=no'");

	window.open("pages/popup_usermanager.cfm", '', params);
}

function version() {
	var v="";
	v+="CFMyAdmin is currently running in :\n";
	v+="\nVersion <cfoutput>#application.version#</cfoutput>\n\n";
	alert(v);
}

function checkForUpdate() {
	alert(workFrame.document.getElementById("version").innerHTML);
}

function about() {
	var width=400;
	var height=350;
    var sLeft=(screen.width-width)/2;
	var sTop=(screen.height-height)/2;
	
	var params=eval("'height="+height+", width="+width+", top="+sTop+", left="+sLeft+", scrollbars=no'");

	window.open("pages/popup_aboutcfmyadmin.cfm", '', params);
}

function connect(server,username,password,port)
{
	document.connectForm.server.value=server;
	document.connectForm.username.value=username;
	document.connectForm.password.value=password;
	document.connectForm.port.value=port;
	document.connectForm.submit();	
}
</script>


<div style="<cfif not find("MSIE",cgi.user_agent)>display:none;</cfif>">
<form name="connectForm" action="templates/workwindow.cfm" target="workwindow" method="post">
<input type="hidden" name="action" value="connect">
<input type="hidden" name="server" value="">
<input type="hidden" name="username" value="">
<input type="hidden" name="password" value="">
<input type="hidden" name="port" value="">
</form>
<form name="workForm" action="templates/workwindow.cfm" target="workwindow" method="post">
<input type="hidden" name="action" value="">
<input type="hidden" name="val1" value="">
<input type="hidden" name="val2" value="">
<input type="hidden" name="val3" value="">
</form>
<form name="quickSQLForm" action="templates/toolbar.cfm" target="updater" method="post">
<input type="hidden" name="action" value="">
<input type="hidden" name="SQL" value="">
</form></div>

<iframe name="updater" src="about:blank" style="display:none"></iframe>
<table cellspacing=0 cellpadding=0 class="toolbar" border=0>
<tr>
	<td style="padding-left:2px;" width=2><div style="height:16px;width:2px;border-top:1px solid white;border-left:1px solid white;border-bottom:1px solid #848284;border-right:1px solid #848284;"></div></td>
	<td style="padding-right:2px;" width=2><div style="height:16px;width:2px;border-top:1px solid white;border-left:1px solid white;border-bottom:1px solid #848284;border-right:1px solid #848284;"></div></td>
	<td>
<!--- START: Show Toolbar --->
<cfmodule template="..\sys\widgets\cb2\dsptoolbar.cfm"
iconList = "connection.gif,closeConnection.gif,print.gif,createDatabase.gif,refresh.gif,reloadPrivileges.gif,userManager.gif"
nameList = "x,x,x,x,x,x,x"
altList = "Server Connection,Close Connection,Print Current Pane,Create Database,Refresh Current Pane,Reload Privileges,User Manager"
linkList = "javascript:openConnDiag(),javascript:closeConn(),javascript:printCurrPane(),javascript:createDB(),javascript:refreshPane(),javascript:reloadPrivileges(),javascript:userManager()"
linkBase = "index.cfm"
iconBase = "images/icons/"
target   = "ciframe"
selectedButton = 0
enabledList =  "1,0,0,0,0,0,0"
isToggleList = "0,0,0,0,0,0,0"
>
<!--- END: Show Toolbar --->	
	</td>
</tr></table> 