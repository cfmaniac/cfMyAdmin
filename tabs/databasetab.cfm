<cfif SESSION.connectString IS "">
	<html><body><script>alert("Sorry,\nYour session had timed out.");top.location.href="../index.cfm";</script></body></html>
	<cfabort>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Database Tab</title>

<style>
body,td {
 background-color:white;
 margin:0px;
 padding:0px;
 font-family:verdana,arial;
 font-size:10px;
}

tr.columnHeader td{
background-color:buttonface;
border-top:1px solid buttonhighlight;
border-left:1px solid buttonhighlight;
border-bottom:1px solid #848284;
border-right:1px solid #848284;
padding-top:1px;
padding-bottom:1px;
padding-left:3px;
padding-right:3px;
cursor:pointer;
cursor:hand;
}

tr.selRow td{
background-Color:highlight;
color:white;
}

tr.unselRow td{
background-Color:white;
color:text;
}

td.c{
border-bottom:1px solid buttonface;
border-right:1px solid buttonface;
padding-top:1px;
padding-bottom:1px;
padding-left:3px;
padding-right:3px;
font-family: arial;
font-size:11px;
cursor:pointer;
cursor:hand;
white-space:nowrap;
}

</style><link rel="STYLESHEET" type="text/css" href="../css/contextmenucss.css">
</head>
<body bgcolor="white" onload="init()" onunload="onexit()" onunload="resetToolbar()">

<cfmodule template="..\modules\smartquery.cfm" queryname="getTableData"><cfoutput>
SHOW TABLE STATUS FROM #theDatabase#
</cfoutput></cfmodule>

<script>
parent.hideTools("tableTools");
parent.showTools("databaseTools");
parent.document.getElementById("theTitleBar").innerText="Database <cfoutput>#JSStringFormat(theDatabase)#: #getTableData.recordCount# table<cfif getTableData.recordCount IS NOT 1>s</cfif></cfoutput>";

function doNADA(){return false;}
try {
document.attachEvent("oncontextmenu",doNADA);
} catch(e) {}

var selectedDatabase = "<cfoutput>#JSStringFormat(theDatabase)#</cfoutput>";

var selectedTableName = null;
var selectedRow = null;
var selectedTableNo = null;
function init()
{
}
function resetToolbar()
{
	parent.enableBut(1,1,false);
	parent.enableBut(1,2,false);
	parent.enableBut(1,3,false);
	parent.enableBut(1,4,false);
	parent.enableBut(1,5,false);
}
function onexit()
{
	resetToolbar();
}
function setTreeIcon()
{
	parent.parent.leftSide.selectTable(-1,selectedTableNo-1);
}
function getSelectedTable()
{
	if( selectedTableName == null ) return null;
	return selectedDatabase + "." + selectedTableName;
}
function getSelectedTableNo()
{
	return selectedTableNo;
}
function selectTBRow(tbNo,tbName,row)
{
	if( selectedRow != null ) selectedRow.className = "unselRow";
	selectedTableNo = tbNo;
	selectedRow = row;
	selectedRow.className = "selRow";
	selectedTableName = tbName;
	parent.enableBut(1,1);
	parent.enableBut(1,2);
	parent.enableBut(1,3);
	parent.enableBut(1,4);
	parent.enableBut(1,5);
	top.enableBut(1,6,true);//enable drop table button on top frame

}
document.body.onclick=function()<!--- Deselect --->
{
	if( event.srcElement.className == "" )
	{
		if( selectedRow != null )
		{
			resetToolbar();
			selectedRow.className = "unselRow";
			selectedRow = null;
			selectedTB = null;
		}
	}
}
function dblClickRow(row)
{
	row.onclick();
	parent.dbShowTable();
}
document.body.onselectstart = function(){return false};
</script>

<div id="tableMenu" class="skin0" onMouseover="highlightie5(event)" onMouseout="lowlightie5(event)" onClick="jumptoie5(event)" display:none>
	<div class="menuitems" id="tmviewData" action="viewData"><img src="../images/icons/viewData.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">View Data</div>
	<div class="menuitems" id="tmtableProperties" action="tableProperties"><img src="../images/icons/editField.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Table Properties</div>
	<div class="menuitems" id="tmemptyTable" action="emptyTable"><img src="../images/icons/emptyTable.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Empty Table</div>
	<div class="menuitems" id="tmdropTable" action="dropTable"><img src="../images/icons/dropTable.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Drop Table</div>
	<div class="disabled" id="tmcopyTable" action="copyTable"><img src="../images/icons/copyTable.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Copy Table</div>
	<div class="menuitems" id="tmrefresh" action="refreshWindow"><img src="../images/icons/refresh.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Refresh</div>
	<div class="menuitems" id="tmprintWindow" action="printWindow"><img src="../images/icons/print.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Print Window</div>
</div>

<div id="generalMenu" class="skin0" onMouseover="highlightie5(event)" onMouseout="lowlightie5(event)" onClick="jumptoie5(event)" display:none>
	<div class="menuitems" id="gmcreateTable" action="createTable"><img src="../images/icons/createTable.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Create Table</div>
	<div class="menuitems" id="gmrefresh" action="refreshWindow"><img src="../images/icons/refresh.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Refresh</div>
	<div class="menuitems" id="gmprintWindow" action="printWindow"><img src="../images/icons/print.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Print Window</div>
</div>

<table id="listTable" width="100%" cellspacing=0 cellpadding=0>
<tr class="columnHeader">
	<td>Table</td>
	<td>Rows</td>
	<td>Size</td>
	<td>Created</td>
	<td>Type</td>
	<td>Comment</td>
</tr>
<cfoutput query="getTableData">
<tr class="unselRow" onClick="selectTBRow(#CurrentRow#,'#JSStringFormat(Name)#',this)" ondblclick="dblClickRow(this);">
	<td class=c cr="#currentrow#" tableField="#name#"><img src="../images/icons/greyTable.gif" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;#Name#</td>
	<td class=c cr="#currentrow#" tableField="#name#">#Rows#</td>
	<td class=c cr="#currentrow#" tableField="#name#">#Ceiling((Data_length+Index_Length)/1024)# KB</td>
	<td class=c cr="#currentrow#" tableField="#name#">#Dateformat(Create_time,"mmm dd yyyy")# #TimeFormat(Create_time)#&nbsp;</td>
	<td class=c cr="#currentrow#" tableField="#name#">#Type#</td>
	<td class=c cr="#currentrow#" tableField="#name#">#Comment#&nbsp;</td>
</tr>
</cfoutput>
</table>

<script src="../js/databasecontextmenu.js"></script>

<script>
function handleKey(e) {
	var ie5=document.all && document.getElementById;
	var ns6=document.getElementById && !document.all;
	var keyCode=ie5? event.keyCode : e.which;
	var firingObj=ie5? event.srcElement : e.target;
	if(keyCode==46) {
		if(selectedTableName!="") {
			parent.dbDropTable();
		}
	}
}

document.onkeydown=handleKey;
</script>

</body>
</html>
