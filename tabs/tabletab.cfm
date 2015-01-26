<cfif SESSION.connectString IS "">
	<html><body><script>top.location.href="../index.cfm";</script></body></html>
	<cfabort>
</cfif>
<cfif isdefined("FORM.action")>

	<cfswitch expression="#FORM.action#">
	
		<cfcase value="dropField">
		
			<cfmodule template="..\modules\smartquery.cfm" queryname="usetDatabase"><cfoutput>
			USE #theDatabase#
			</cfoutput></cfmodule>
			
			<cftry>
				<cfmodule template="..\modules\smartquery.cfm" queryname="getNumRecords"><cfoutput>
				ALTER TABLE #theTable# DROP #FORM.val1#
				</cfoutput></cfmodule>
				<cfcatch type="Database">
					<cfset NEWLINE = chr(13)&chr(10)>
					<script language="JavaScript1.2" defer>
					<cfoutput>alert("Whoops!\n\n#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#</cfoutput>");
					</script>
					<cfset noResults = 1>
				</cfcatch>
			</cftry>
		
		</cfcase>
	
	</cfswitch>

</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Table Tab</title>
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

</style>
<link rel="STYLESHEET" type="text/css" href="../css/contextmenucss.css">
</head>
<body onunload="resetToolbar()">

<cfmodule template="..\modules\smartquery.cfm" queryname="getTableData"><cfoutput>
SHOW fields FROM #theTable#
</cfoutput></cfmodule>
<cfmodule template="..\modules\smartquery.cfm" queryname="getTableKeys"><cfoutput>
SHOW KEYS FROM #theTable#
</cfoutput></cfmodule>
<cfset tableKeys = arrayNew(1)>
<cfloop query="getTableKeys">
	<cfset tableKeys[CurrentRow] = StructNew()>
	<cfset tableKeys[CurrentRow].nonUnique = Non_unique>
</cfloop>

<script>
parent.showTools("tableTools");
parent.hideTools("databaseTools");
parent.document.getElementById("theTitleBar").innerText="Viewing Design Of Table <cfoutput>#theTable#</cfoutput>";

function doNADA(){return false;}
try {document.attachEvent("oncontextmenu",doNADA);} catch(e) {}

var theDatabase = "<cfoutput>#JSStringFormat(theDatabase)#</cfoutput>";
var theTable = "<cfoutput>#JSStringFormat(theTable)#</cfoutput>";
var selectedFieldName = "";
var selectedRow = null;
var selectedRowNo = null;
function resetToolbar()
{
	parent.enableBut(2,1,false);
	parent.enableBut(2,2,true);
	parent.enableBut(2,3,false);
}
function gettheTable()
{
	return selectedFieldName;
}
function selectRow(rowNo,fieldName,row)
{
	if( selectedRow != null ) selectedRow.className = "unselRow";
	selectedRowNo = rowNo;
	selectedRow = row;
	selectedRow.className = "selRow";
	selectedFieldName = fieldName;
	parent.enableBut(2,1);
	parent.enableBut(2,2);
	parent.enableBut(2,3);
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
function editField()
{
	var height=370;
	var width=313;
	var sLeft=(screen.width-width)/2;
	var sTop=(screen.height-height)/2;
	
	var cString="width=" + width + ",height=" + height + ",top=" + sTop + ", left=" + sLeft + ",resizable=no,toolbar=no";
	
	window.open("../pages/popup_addfield.cfm?theTable="+theTable+"&theField="+selectedFieldName, "dbAddField", cString);
}
function addField()
{
	var height=370;
	var width=313;
	var sLeft=(screen.width-width)/2;
	var sTop=(screen.height-height)/2;
	
	var cString="width=" + width + ",height=" + height + ",top=" + sTop + ", left=" + sLeft + ",resizable=no,toolbar=no";
	
	window.open("../pages/popup_addfield.cfm?theTable="+theTable, "dbEditField", cString);
}
function dropField()
{
	if( confirm("Drop field '" + selectedFieldName + "'?") )
	{
		with( document.workerForm )
		{
			action.value = "dropField";
			val1.value = selectedFieldName;
			submit();
		}
	}
}
function dblClickRow(row)
{
	row.onclick();
	editField();
}

document.body.onselectstart = function(){return false};
</script>

<form name="workerForm" action="tabletab.cfm" method="post" style="display:none">
<input type="hidden" name="action">
<input type="hidden" name="theDatabase" value="<cfoutput>#theDatabase#</cfoutput>">
<input type="hidden" name="theTable" value="<cfoutput>#theTable#</cfoutput>">
<input type="hidden" name="val1">
</form>

<div id="tableMenu" class="skin0" onMouseover="highlightie5(event)" onMouseout="lowlightie5(event)" onClick="jumptoie5(event)" display:none>
	<div class="menuitems" id="tmeditField" action="editField"><img src="../images/icons/editField.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Edit Field</div>
	<div class="menuitems" id="tmaddField" action="dropField"><img src="../images/icons/dropField.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Drop Field</div>
	<div class="menuitems" id="tmviewData" action="viewData"><img src="../images/icons/viewData.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">View Data</div>
	<div class="menuitems" id="tmaddField" action="addField"><img src="../images/icons/addField.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Add New Field</div>
	<div class="menuitems" id="tmrefreshWindow" action="refreshWindow"><img src="../images/icons/refresh.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Refresh</div>
	<div class="menuitems" id="tmprintWindow" action="printWindow"><img src="../images/icons/print.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Print Window</div>
</div>

<div id="generalMenu" class="skin0" onMouseover="highlightie5(event)" onMouseout="lowlightie5(event)" onClick="jumptoie5(event)" display:none>
	<div class="menuitems" id="gmviewData" action="viewData"><img src="../images/icons/viewData.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">View Data</div>
	<div class="menuitems" id="gmaddField" action="addField"><img src="../images/icons/addField.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Add New Field</div>
	<div class="menuitems" id="gmrefresh" action="refreshWindow"><img src="../images/icons/refresh.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Refresh</div>
	<div class="menuitems" id="gmprintWindow" action="printWindow"><img src="../images/icons/print.gif" width="16" hspace=4 align=absmiddle height="16" alt="" border="0">Print Window</div>
</div>

<table id="listTable" width=100% cellspacing=0 cellpadding=0>
<tr class="columnHeader">
	<td>Name</td>
	<td>Type</td>
	<td>Not&nbspNull</td>
	<td>Default</td>
	<td>Extra</td>
</tr>
<cfoutput query="getTableData">
<tr class="unselRow" onClick="selectRow(#CurrentRow#,'#JSStringFormat(Field)#',this)" ondblclick="dblClickRow(this);">
	<td class=c cr="#currentrow#" tableField="#field#"><img src="../images/icons/<cfif Key EQ "PRI">field_primary.gif<cfelseif Len(Key)>field_index.gif<cfelse>field.gif</cfif>" width="16" height="16" alt="" border="0" align=absmiddle>&nbsp;#FIELD#</td>
	<td class=c cr="#currentrow#" tableField="#field#">#Type#</td>
	<td class=c cr="#currentrow#" tableField="#field#"><cfif Null EQ "Yes">Yes<cfelse>No</cfif></td>
	<td class=c cr="#currentrow#" tableField="#field#">#Default#&nbsp;</td>
	<td class=c cr="#currentrow#" tableField="#field#">#Extra#&nbsp;</td>
</tr>
</cfoutput>
</table>

<script src="../js/tablecontextmenu.js"></script>

<script>
function handleKey(e) {
	var ie5=document.all && document.getElementById;
	var ns6=document.getElementById && !document.all;
	var keyCode=ie5? event.keyCode : e.which;
	var firingObj=ie5? event.srcElement : e.target;
	if(keyCode==46) {
		if(selectedFieldName!="") {
			dropField();
		}
	}
}

document.onkeydown=handleKey;
</script>

</body>
</html>
