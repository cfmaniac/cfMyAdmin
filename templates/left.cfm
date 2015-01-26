<cfif isdefined("action")>

	<cfswitch expression="#action#">
		
		<cfcase value="createDB">
			<cftry>
				<cfmodule template="..\modules\smartquery.cfm" queryname="createDatabase"><cfoutput>
				CREATE DATABASE #LCASE(val1)#
				</cfoutput></cfmodule>
				<script>
				alert("Database Created Successfully.");
				parent.location.reload();
				</script>
				<cfcatch type="database">
					<cfoutput>
					<html><body>
						<script>
						alert("Database Creation Failed.\nPerhaps you are now allowed create databases with\nyour current login or you have invalid characters in\nthe database name.");
						</script>
					</body></html>
					</cfoutput>
					<cfabort>
				</cfcatch>
			</cftry>
			<cfabort>
		</cfcase>
		
	</cfswitch>
	
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>CFMyAdmin LHS Menu</title>
	
	<script src="../js/dccontextmenu.js"></script>
	<link rel="STYLESHEET" type="text/css" href="../css/dccontextmenu.css">
</head>

<style>
body {
 margin:1px;
 padding:0px;
}

a{
color:black;
}

.aLink {
 font-family:arial;
 font-size:11px;
 text-decoration:none;
}

.aLink a:hover {
 font-family:arial;
 font-size:11px;
 color:blue;
 text-decoration:underline;
}
</style>

<body>

<script>
try { document.attachEvent("oncontextmenu",showMenu); } catch(e) {}

function createDB()
{
	var newDBName = prompt("Please enter new database name?","");
	if( newDBName ){
		with( document.workForm )
		{
			action.value = "createDB";
			val1.value = newDBName;
			submit();
		}
	}
}
function refreshFrame()
{
	window.location.reload();
}
</script>

<iframe name="updater" src="about:blank" style="display:none;"></iframe>
<form name="workForm" action="left.cfm" target="updater" method="post" style="display:none;">
<input type="hidden" name="action" value="">
<input type="hidden" name="val1" value="">
<input type="hidden" name="val2" value="">
<input type="hidden" name="val3" value="">
</form>

<!-- Context Menu -->
<div id=menu1 onclick="clickMenu()" onmouseover="toggleMenu()" onmouseout="toggleMenu()" style="position:absolute;display:none;border: 1px outset; border-left-color:#C6C3C6;border-top-color:#C6C3C6;border-bottom-color:#000000;border-right-color:#000000; width:120px;background-color:menu;">
	<div class="dccminnerBody">
	<div style="width:120px;" class="dccmmenuItem" doFunction="createDB();"><img src="../images/icons/createTable.gif" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;Create Database</div>
	<div style="border-bottom:1px solid buttonhighlight;border-top:1px solid #848284;"></div>
	<div style="width:120px;" id="contextDropDB" class="dccmmenuItem" doFunction="top.dropDB(databases[contextDBNo]);"><img src="../images/icons/dropDatabase.gif" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;Drop Database</div>
	<div style="width:120px;" id="contextDropTable" class="dccmmenuItem" doFunction="top.dropTable(databases[contextDBNo]+'.'+tables[contextDBNo][contextTBNo]);"><img src="../images/icons/dropTable.gif" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;Drop Table</div>
	<div style="border-bottom:1px solid buttonhighlight;border-top:1px solid #848284;"></div>
	<div style="width:120px;" class="dccmmenuItem" doFunction="refreshFrame();"><img src="../images/icons/refresh.gif" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;Refresh</div>
	</div>
</div>
<!-- End of Context Menu -->


<script>
var tabSelected="";
var selDBNo = null, selDBName = "";
var selTBNo = null, selTBName = "";
var contextDBNo = 0, contextTBNo = 0;
function getSelectedDB(){return selDBName;}
function setDB(db,bGo)
{
	if( arguments.length < 2 ) bGo = true;
	if( bGo && selTBNo != null )
	{
		document.images['tbl'+selDBNo+'_'+selTBNo].src = "../images/icons/greyTable.gif";
		selTBNo = null;
		selTBName = "";
	}
	document.getElementById('dbs'+db).src = "../images/icons/database.gif";
	if( selDBNo != null && selDBNo != db ) document.images['dbs'+selDBNo].src = "../images/icons/databaseOff.gif";
	selDBNo = db;
	selDBName = databases[db];
	theDatabase = databases[db];
	if( bGo )
	{
		tabSelected = "databaseTab";
		parent.workArea.document.location="../pages/workarea.cfm?theType=database&theDatabase="+selDBName;
	}		
}
function swapv(it,theDatabase)
{
	if(document.getElementById('a'+it).style.display == "none")
		{
			document.getElementById('a'+it).style.display = "block";
			//document.getElementById('a'+it).style.overflow = "visible";
			//document.getElementById('a'+it).style.height = "95%";
			document.getElementById('treeplus'+it).src = "../images/icons/minusTree.gif";
		}
	else
		{
			//document.getElementById('a'+it).style.visibility = "hidden";
			document.getElementById('a'+it).style.display = "none";
			//document.getElementById('a'+it).style.height = "1px";
			document.getElementById('treeplus'+it).src = "../images/icons/plusTree.gif";
		}
}
<!--- Called by content menu handler --->
function prepairMenu(id)
{
	splitId = id.split("_");
	contextDBNo = splitId[0];
	contextTBNo = ((splitId.length > 1)?splitId[1]:0);
	document.getElementById("contextDropDB").style.display = ((id!='root' && id.indexOf('_')==-1)?'block':'none');
	document.getElementById("contextDropTable").style.display = ((id!='root' && id.indexOf('_')!=-1)?'block':'none');
}
function selectTable(db,tb)
{
	//return;
	if( db == -1 )
	{
		if( selDBNo == null ) return;
		db = selDBNo;<!--- -1 means 'keep same database' --->
	}
	if( selTBNo != null && selDBNo != null)
	{
		document.images['tbl'+selDBNo+'_'+selTBNo].src = "../images/icons/greyTable.gif";
	}
	selTBNo = tb;
	selTBName = tables[db][tb];
	document.images['tbl'+db+'_'+tb].src = "../images/icons/table.gif";
	setDB(db,false);
}
function viewTable(db,tb)
{
	selectTable(db,tb);
	if(tabSelected=="dataTab") parent.workArea.document.location="../pages/workarea.cfm?theType=data&theTable="+theDatabase+'.'+selTBName;
	else parent.workArea.document.location='../pages/workarea.cfm?theType=table&theTable='+theDatabase+'.'+selTBName;
}
</script>

<cfmodule template="..\modules\smartquery.cfm" queryname="getDatabases"><cfoutput>
show databases
</cfoutput></cfmodule>

<script>
var databases = new Array(<cfoutput query="getDatabases">"#database#",</cfoutput>"");
var tables = new Array(<cfoutput>#getDatabases.recordCount#</cfoutput>);
<cfloop from="1" to="#getDatabases.recordcount#" index="i">
	<cfmodule template="..\modules\smartquery.cfm" queryname="getTables"><cfoutput>
	SHOW tables FROM #getDatabases.database[i]#
	</cfoutput></cfmodule>
	tables[<cfoutput>#Evaluate(i-1)#</cfoutput>] = new Array(<cfoutput query="getTables">"#evaluate("getTables.TABLES_IN_" & getDatabases.database[i] )#",</cfoutput>"");
</cfloop>

var HTML = '<table cellspacing=0 cellpadding=0><tr><td valign=middle width="16"><img src="../images/icons/server.gif" width="16" height="16" alt="" border="0"></td><td class="aLink" colspan=3 style="padding-left:5px;"><a href="" onclick="parent.workArea.document.location=\'../pages/workarea.cfm?theType=host\';return false;" class="aLink" context="yes" id="root"><cfoutput>#JSStringFormat(SESSION.dbuser)#</cfoutput></a></td></tr></HTML>';
document.write(HTML);
for(db=0;db<databases.length-1;db++)
{
	HTML = '<table cellspacing=0 cellpadding=0>';
	HTML += '<tr><td valign=top width="16" '+((db != databases.length-2)?'background="../images/vLineTree.gif"':'')+'><a href="" onclick="swapv('+db+');return false;" class="aLink"><img id="treeplus'+db+'" src="../images/icons/plusTree.gif" width="16" height="16" alt="" border="0"></a></td>';
	HTML += '<td class="aLink" style="padding-left:2px;">';
	HTML += '<div><a href="" context="yes" id="'+db+'" onclick="setDB('+db+');return false;" class="aLink">';
	HTML += '<img id="dbs'+db+'" src="../images/icons/databaseOff.gif" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;' + databases[db] + '</a></div>';
	HTML += '<div id="a'+db+'" style="display:none;">';
	HTML += '<table cellspacing=0 cellpadding=0 border=0>';

	for( tb=0;tb<tables[db].length-1;tb++ )
	{
		HTML += '<tr><td valign=middle width="18" align=right><img src="../images/icons/'+((tb == tables[db].length-2)?'l':'t')+'tree.gif" width="16" height="16" alt="" border="0"></td>';
		HTML += '<td class="aLink" align=left nowrap style="padding-left:5px;"><a context="yes" id="'+db+'_'+tb+'" href="" onclick="viewTable('+db+','+tb+');return false;" class="aLink"><img id="tbl'+db+'_'+tb+'" src="../images/icons/greyTable.gif" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;'+tables[db][tb]+'</a></td></tr>';
	}
	HTML += '</table></div>';
	HTML += '</td></tr>';
	HTML += '</table>';
	document.write(HTML);
}

</script>
<br><br><br>

</body>
</html>
