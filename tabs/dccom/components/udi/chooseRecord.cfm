<cfsetting enablecfoutputonly="Yes">

<!--- Load the attributes --->	
<cfmodule template="serializeAttributes.cfm" method="load" uid="#ref#">

<!--- If no interface is defined, then say so!... --->
<cfif arrayLen(assocAttribs) EQ 0>
	<cfoutput><html><body><h3 style="font-family:verdana;">No Interface Defined.
	<cfif ATTRIBUTES.editInterface>
	<br>
	Define this interface by clicking the "Edit Interface" button above.	
	</cfif></h3></body></html></cfoutput>
	<cfabort>
</cfif>

<cfif ATTRIBUTES.startBlank AND NOT isdefined("SQLSearch")>
<cfoutput>
<html><head><LINK REL="STYLESHEET" TYPE="text/css" HREF="style.css"></head><body>
<script language="JavaScript1.2">
var jsRef = "#ref#",sortBy = "",pageNo = 1,SQLsearch = "",pageSize = 0,numOfPages = 0,ready=1;
</script><script language="JavaScript1.2" defer src="chooserecord.js"></script>

		<cftry>
			<cfmodule template="mod_query.cfm" queryname="getRecordCount">
			SELECT COUNT(*) AS numRecords
			FROM #ATTRIBUTES.table#
			<cfif isdefined("ATTRIBUTES.sqlWhereClause")><cfif LEFT(ATTRIBUTES.sqlWhereClause,5) NEQ "WHERE">WHERE </cfif> #ATTRIBUTES.sqlWhereClause#</cfif>
			</cfmodule>
			<div align=center>
				<br>Use the search option above to select the records to display here - #getRecordCount.numRecords# Records Available
			</div>
			<cfcatch type="Database">
				<cfset NEWLINE = chr(10) & chr(13)>
				<script>
				function showDiagnostic()
				{
					alert("Error Diagnostic\n\nError Type: #JSStringFormat(cfcatch.type)#\n\nessage: #JSStringFormat(cfcatch.message)#\n#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#");
				}
				</script>
				<div style="font-family:verdana,arial;font-size:11px">
					<h3>Error executing SQL code for record list.</h3>
					<a href="javascript:showDiagnostic();">Click here to see the generated error.</a>
					<br><br>
					The executed SQL was:<br><br>
					<textarea style="width:100%" cols="40" rows="5">#HTMLEditFormat(assocAttribs[i].query)#</textarea>
				</div>
				<cfabort>
			</cfcatch>
		</cftry>
</body></html>
</cfoutput>
<cfabort>
</cfif>

<!--- Find all "key" attributes --->
<cfset keyList = "">
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif Left(assocAttribs[i].type,3) EQ "KEY">
		<cfset keyList = ListAppend(keyList,i)>
	</cfif>
</cfloop>

<cfif ListLen(keyList) EQ 0>
	<cfoutput><div style="font-family:verdana,arial;">No Key is defined. At least one key must be defined in the interface.</div></cfoutput>
	<cfabort>
</cfif>

<!--- Determine which columns are displayed in the quick view --->
<cfset displayList = "">
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<!--- Has this field been explicitedly turned off? shortList=no=0, default is on=1 --->
	<cftry><cfset shortList = assocAttribs[i].shortList><cfcatch type="Any"><cfset shortList = 1></cfcatch></cftry>
	<cfif ATTRIBUTES.listAll AND shortList AND ListFind(ATTRIBUTES.chooseRecordTypeList,assocAttribs[i].type) AND (NOT ListFind(i,keyList))>
		<cfset displayList = ListAppend(displayList,i)>
	<cfelse>
		<cfif shortList AND ((ListLen(keyList)+ListLen(displayList)) LT ATTRIBUTES.maxShortItems) AND (NOT ListFind(i,keyList))>
			<cfset displayList = ListAppend(displayList,i)>
		</cfif>
	</cfif>
</cfloop>

<!--- Lookup any drop-down select Querys --->
<cfset selectNum = 0>
<cfloop index="i" list="#displayList#">
<cfif assocAttribs[i].type EQ "select_number">
	<cfset selectNum = selectNum + 1>
	<cfparam name="assocAttribs[#i#].query" default="">
	<cfif assocAttribs[#i#].query NEQ "">
		<cftry>
			<cfmodule template="mod_query.cfm" queryname="selectQuery#selectNum#"><cfoutput>
			<cfset queryString = assocAttribs[i].query>
			#preserveSingleQuotes(queryString)#
			</cfoutput></cfmodule>
			<cfcatch type="Database">
			<cfset NEWLINE = chr(10) & chr(13)>
			<cfoutput>
			<script>
			function showDiagnostic()
			{
				alert("Error Diagnostic\n\nError Type: #JSStringFormat(cfcatch.type)#\n\nessage: #JSStringFormat(cfcatch.message)#\n#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#");
			}
			</script>
			<div style="font-family:verdana,arial;font-size:11px">
				<h3>Error executing SQL code for record list.</h3>
				<a href="javascript:showDiagnostic();">Click here to see the generated error.</a>
				<br><br>
				The executed SQL was:<br><br>
				<textarea style="width:100%" cols="40" rows="25">#HTMLEditFormat(assocAttribs[i].query)#</textarea>
			</div>
			</cfoutput>
			<cfabort>
			</cfcatch>
		</cftry>
		<cfparam name="assocAttribs[ #i# ].queryValueColumn" default="valueCol">
		<cfparam name="assocAttribs[ #i# ].queryDisplayColumn" default="displayCol">
		<cfparam name="assocAttribs[ #i# ].delimiter" default="|~">
		<cfscript>
		Evaluate("assocAttribs[ #i# ].displayList=ValueList(selectQuery"&selectNum&"."&assocAttribs[ #i# ].queryDisplayColumn&",assocAttribs[ #i# ].delimiter)");
		Evaluate("assocAttribs[ #i# ].valList=ValueList(selectQuery"&selectNum&"."&assocAttribs[ #i# ].queryValueColumn&",assocAttribs[ #i# ].delimiter)");
		</cfscript>
	</cfif>
</cfif>
</cfloop>

<!--- Set the default sortBy to the first key --->
<cfif NOT isdefined("sortBy")>
	<cfif isdefined("ATTRIBUTES.orderBy")>
		<cfset sortBy="#ATTRIBUTES.orderBy#">
	<cfelse><!--- Otherwise order by the first key --->
		<cfset sortBy="#assocAttribs[ ListGetAt(keyList,1) ].field#">
	</cfif>
</cfif>


<!--- START: Get the required referential data --->	

	<!--- Build SQL --->
	<cfset sqlQuery = "SELECT ">
	<cfloop index="i" from="1" to="#ListLen(keyList)#">
		<cfset sqlQuery = sqlQuery & "#assocAttribs[ ListGetAt(keyList,i) ].field#">
		<cfif i LT ListLen(keyList) OR ListLen(displayList) GT 0>
			<cfset sqlQuery = sqlQuery & ",">
		</cfif>
	</cfloop>
	<cfloop index="i" from="1" to="#ListLen(displayList)#">
		<cfset sqlQuery = sqlQuery & "#assocAttribs[ ListGetAt(displayList,i) ].field#">
		<cfif i LT ListLen(displayList)>
			<cfset sqlQuery = sqlQuery & ",">
		</cfif>
	</cfloop>
	<cfset sqlQuery = sqlQuery & " FROM #ATTRIBUTES.table#">
	<cfif isdefined("ATTRIBUTES.sqlWhereClause")>
		<cfif LEFT(ATTRIBUTES.sqlWhereClause,5) NEQ "WHERE">
			<cfset sqlQuery = sqlQuery & " WHERE">
		</cfif>
		<cfset sqlQuery = sqlQuery & " " & ATTRIBUTES.sqlWhereClause>
	</cfif>
	<cfif isdefined("SQLSearch") AND SQLSearch NEQ "">
		<cfif isdefined("ATTRIBUTES.sqlWhereClause")>
			<cfset sqlQuery = sqlQuery & " AND">
		<cfelseif LEFT(SQLSearch,5) NEQ "WHERE">
			<cfset sqlQuery = sqlQuery & " WHERE">
		</cfif>
		<cfset sqlQuery = sqlQuery & " " & SQLSearch>
	</cfif>
	<cfif sortBy NEQ "">
		<cfset sqlQuery = sqlQuery & " ORDER BY #sortBy#">
	</cfif>

	<!--- Execute SQL --->
	<cftry>
		<cfif ATTRIBUTES.MTFP><cfset limit = 20><cfelse><cfset limit = 2000000></cfif>
		<cfmodule template="mod_query.cfm" queryname="getQuick" maxrows="#limit#">
			<cfoutput>#sqlQuery#</cfoutput>
		</cfmodule>
		<cfcatch type="Database">
		<cfset NEWLINE = chr(10) & chr(13)>
		<cfoutput>
		<script>
		function showDiagnostic()
		{
			alert("Error Diagnostic\n\nError Type: #JSStringFormat(cfcatch.type)#\n\nessage: #JSStringFormat(cfcatch.message)#\n#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#");
		}
		</script>
		<div style="font-family:verdana,arial;font-size:11px">
			<h3>Error executing SQL code for record list.</h3>
			<a href="javascript:showDiagnostic();">Click here to see the generated error.</a>
			<br><br>
			The executed SQL was:<br><br>
			<textarea style="width:100%" cols="40" rows="5">#HTMLEditFormat(sqlQuery)#</textarea>
		</div>
		</cfoutput>
		<cfabort>
		</cfcatch>
	</cftry>

<!--- END: Get the required referential data --->	

	
<cfsetting enablecfoutputonly="No">
<cfparam name="pageNo" default="1">
<cfparam name="SQLsearch" default="">
<html><head><LINK REL="STYLESHEET" TYPE="text/css" HREF="style.css"><link rel="STYLESHEET" type="text/css" href="tablesort.css">

<script type="text/javascript" src="tablesort.js"></script>
<script language="JavaScript1.2">
var jsRef = "<cfoutput>#ref#</cfoutput>";
var sortBy = "<cfoutput>#JSStringFormat(sortBy)#</cfoutput>";
var pageNo = <cfoutput>#pageNo#</cfoutput>;
var SQLsearch = "<cfoutput>#SQLsearch#</cfoutput>";
var pageSize = <cfoutput>#ATTRIBUTES.pagesize#</cfoutput>;
var numOfPages = <cfoutput>#Ceiling(getQuick.recordCount/ATTRIBUTES.pageSize)#</cfoutput>;
var ready=0;

function se(tRow,<cfoutput><cfloop index="i" from="1" to="#ListLen(keyList)#">#assocAttribs[ ListGetAt(keyList,i) ].field#<cfif i LT ListLen(keyList)>,</cfif></cfloop></cfoutput>)
{setEditRow(tRow);parent.toolbarFrame.showDetailsView();
var lookup = <cfoutput>"<cfloop index="i" from="1" to="#ListLen(keyList)#">#assocAttribs[ ListGetAt(keyList,i) ].field#=<cfset type = assocAttribs[ ListGetAt(keyList,i) ].type><cfif type EQ "key_text" OR type EQ "key_uuid">'</cfif>"+#assocAttribs[ ListGetAt(keyList,i) ].field#<cfif i LT ListLen(keyList)>+"<cfif type EQ "key_text" OR type EQ "key_uuid">'</cfif>&<cfelse><cfif type EQ "key_text" OR type EQ "key_uuid">+"'"</cfif></cfif></cfloop></cfoutput>;
parent.editFrame.document.open();parent.editFrame.document.write("<html><head><style>body{background-color:buttonface;font-family:verdana;font-size:8pt;}</style></head><body>Please wait, loading record data...</body></html>");parent.editFrame.document.close();document.lookupForm.lookup.value=lookup;document.lookupForm.submit();}
function deleteRecord(){
if(selectedRow==null)return;
var deleteKey=new Array(),keyName="";

<cfloop index="i" from="1" to="#ListLen(keyList)#">
deleteKey[deleteKey.length]=selectedRow.cells[<cfoutput>#i#</cfoutput>].innerHTML;
keyName=keyName+"<cfoutput>#JSStringFormat(assocAttribs[ ListGetAt(keyList,i) ].field )#</cfoutput>='"+deleteKey[deleteKey.length-1]+"'<cfif i LT ListLen(keyList)>,</cfif>";
</cfloop>

<cfif ATTRIBUTES.showConfirm>if(confirm("You have selected to delete record with key "+keyName+".\r\n\r\nAre you CERTAIN you wish to delete this record?\r\nChanges cannot be undone.")){parent.editFrame.deleteRecord(deleteKey);}<cfelse>parent.editFrame.deleteRecord(deleteKey);</cfif>
}
function editRecord(){if(selectedRow==null)return;se(selectedRow,<cfloop index="i" from="1" to="#ListLen(keyList)#">selectedRow.cells[<cfoutput>#i#</cfoutput>].innerHTML<cfif i LT ListLen(keyList)>,</cfif></cfloop>);}
function initpage()
{
	ready=1;
	if( eval("parent.toolbarFrame") && eval("parent.toolbarFrame.document") && eval("parent.toolbarFrame.ready") )
	{
		parent.toolbarFrame.setPageParams(pageNo,numOfPages);
	<!--- Automatically select tp open the record if there is only one --->
	<cfif getQuick.recordCount IS 1>
	with( document.getElementById('recordTable') )
	{
		rows[1].cells[0].click();
		parent.toolbarFrame.document.getElementById("but_edit").click();
	}
	</cfif>
	}
	else setTimeout(initpage,500);
}
</script><script language="JavaScript1.2" defer src="chooserecord.js"></script></head><body onload="initpage();"><table onclick="sortColumn(event)" id="recordTable" cellpadding="0" cellspacing="0" border="0" width="100%"><form name="lookupForm" target="editFrame" action="editRecord.cfm"><input type="hidden" name="ref" value="<cfoutput>#ref#</cfoutput>"><input type="hidden" name="lookup" value=""></form>
<thead>
<tr><td width="6" class="header"><img src="spacer.gif" width="1" height="1" alt="" border="0"></td>
<cfoutput><cfloop index="i" from="1" to="#ListLen(keyList)#"><td class="header" nowrap><cfset field = assocAttribs[ ListGetAt(keyList,i) ].field><cfif field EQ sortBy><img src="sortarrow.gif" width="5" height="5" alt="" border="0" align="left">#assocAttribs[ ListGetAt(keyList,i) ].display#<cfelse><a href="javascript:doSortOn('#JSStringFormat(field)#');" class="aSortBy">#assocAttribs[ ListGetAt(keyList,i) ].display#</a></cfif><small>(key)</small></td></cfloop><cfloop index="i" from="1" to="#ListLen(displayList)#"><cfset posAt = ListGetAt(displayList,i)><cfif Left( assocAttribs[ posAt ].type,3 ) NEQ "key"><td class="header" nowrap><cfset field = assocAttribs[ posAt ].field><cfif field EQ sortBy><img src="sortarrow.gif" width="5" height="5" alt="" border="0" align="left"></cfif>#assocAttribs[ posAt ].display#</td></cfif></cfloop></cfoutput></tr>
</thead>
<!--- Data View --->
<tbody>
<cfloop query="getQuick" startrow="#Evaluate(((pageNo-1)*ATTRIBUTES.pageSize)+1)#" endrow="#Evaluate(pageNo*ATTRIBUTES.pageSize)#">
<tr onclick="setSelectedRow(this)" ondblclick="se(this,<cfsetting enablecfoutputonly="Yes">

<cfloop index="i" from="1" to="#ListLen(keyList)#">
	<cfset zpos = ListGetAt(keyList,i)>
	<cfif ListFind(ATTRIBUTES.useQuoteTypeList,assocAttribs[ zpos ].type)><cfoutput>'#JSStringFormat(Evaluate( assocAttribs[ zpos ].field ))#'</cfoutput><cfelse><cfoutput>#Evaluate( assocAttribs[ zpos ].field )#</cfoutput></cfif>
	<cfif i LT ListLen(keyList)><cfoutput>,</cfoutput></cfif>
</cfloop>

<cfsetting enablecfoutputonly="No">)" class="row">

<td width="6" class="header"><img src="spacer.gif" width="1" height="1" alt="" border="0"></td>
<cfloop index="i" from="1" to="#ListLen(keyList)#"><td class="cell"><cfoutput>#Evaluate( assocAttribs[ ListGetAt(keyList,i) ].field )#</cfoutput></td></cfloop>
<cfloop index="i" from="1" to="#ListLen(displayList)#">
<cfset posAt = ListGetAt(displayList,i)>
<cfif Left( assocAttribs[ posAt ].type,3 ) NEQ "key">
<td class="cell" nowrap><cfsetting enablecfoutputonly="Yes">
	<cftry>
		<cfset xtype = assocAttribs[ posAt ].type>
		<cfset dbVal = Evaluate( assocAttribs[ posAt ].field )>
		<cfset incpath = "interfaces/" & xtype & "/chooseRecordInterface.cfm">
		<cfinclude template="#incpath#">
		<cfcatch type="MissingInclude">
			<cfoutput>#HTMLEditFormat(Left(dbVal,ATTRIBUTES.maxListTextSize))#</cfoutput>
			<cfif Len(dbVal) GT ATTRIBUTES.maxListTextSize><cfoutput>..</cfoutput><cfelseif Len(dbVal) EQ 0></cfif>
		</cfcatch>
	</cftry>
<cfsetting enablecfoutputonly="No"> &nbsp; </td>
</cfif>
</cfloop></tr></cfloop>
</tbody>
</table>

</body></html>
