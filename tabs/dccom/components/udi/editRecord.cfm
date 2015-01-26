<cfsetting enablecfoutputonly="Yes">

<!--- Load the attributes --->	
<cfmodule template="serializeAttributes.cfm" method="load" uid="#ref#">

<!-- Get URL path to this component --->
<cfset urlpathtocom = replace(GetDirectoryFromPath("http://"&cgi.server_name& cgi.path_info),"\","") >

<!--- If no interface is defined, then say so!... --->
<cfif arrayLen(assocAttribs) EQ 0>
	<cfoutput><html><body><h3 style="font-family:verdana;">No Interface Defined.</h3></body></html></cfoutput>
	<cfabort>
</cfif>

<!--- Find all "key" attributes --->
<cfset keyList = "">
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif left(assocAttribs[i].type,3) EQ "KEY">
		<cfset keyList = ListAppend(keyList,i)>
	</cfif>
</cfloop>

<!--- Get the list of attributes that describe items to display/update --->
<cfset displayList = "">
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif NOT ListFind(i,keyList)>
		<cfset displayList = ListAppend(displayList,i)>
	</cfif>
</cfloop>

<!--- Lookup any drop-down select Querys --->
<cfset selectNum = 0>
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif assocAttribs[i].type EQ "SELECT_NUMBER" OR assocAttribs[i].type EQ "SELECT_TEXT">
		<cfset selectNum = selectNum + 1>
		<cfparam name="assocAttribs[#i#].query" default="">
		<cfif assocAttribs[#i#].query NEQ "">
			<cfmodule template="mod_query.cfm" queryname="selectQuery#selectNum#">
			<cfset queryString = assocAttribs[i].query>
				<cfoutput>#queryString#</cfoutput>
			</cfmodule>
		</cfif>
	</cfif>
</cfloop>

<!--- Create the full list --->
<cfset fullList	= keyList & "," & displayList>

<!--- lookup determines which record to lookup! --->
<cfparam name="lookup" default="">

<cfif lookup NEQ "">
	<!--- Get the selected RECORD --->	
	<cfmodule template="mod_query.cfm" queryname="getRecord" maxrows="1"><cfoutput>
	SELECT 
	<cfloop index="i" from="1" to="#ListLen(keyList)#">#assocAttribs[ ListGetAt(keyList,i) ].field#<cfif i LT ListLen(keyList) OR ListLen(displayList) GT 0>,</cfif></cfloop>
	<cfloop index="i" from="1" to="#ListLen(displayList)#">#assocAttribs[ ListGetAt(displayList,i) ].field#<cfif i LT ListLen(displayList)>,</cfif></cfloop>
	FROM #ATTRIBUTES.table#
	WHERE <cfset zpos = 0><cfloop list="#lookup#" delimiters="&" index="searchItem"><cfset zpos = zpos + 1><cfif zpos GT 1> AND </cfif>#PreserveSingleQuotes(searchItem)#</cfloop>
	</cfoutput></cfmodule>
</cfif>

<!--- If necessary, create the new record - insert entry with the default values (or blank) --->
<cfif lookup EQ "" OR getRecord.RecordCount EQ 0>
	<!--- Create a new record with the required fields --->
	<cfset queryNewString = "QueryNew(""">
	<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
		<cfset queryNewString = queryNewString & assocAttribs[i].field>
		<cfif i LT arrayLen(assocAttribs)><cfset queryNewString = queryNewString & ","></cfif>
	</cfloop>
	<cfset queryNewString = queryNewString & """)">
	<cfset getRecord = Evaluate("#queryNewString#")>
	<!--- Add a row to the record --->
	<cfset newRow  = QueryAddRow(getRecord)>
	<!--- Set all required fields to their default (if any) --->
	<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
		<cfparam name="assocAttribs[#i#].default" default="">
		<cfset temp = QuerySetCell(getRecord, assocAttribs[i].field, assocAttribs[i].default, 1)>
	</cfloop>

	<cfset updateType = "insert">
<cfelse>
	<cfset updateType = "update">
</cfif>

	
<cfsetting enablecfoutputonly="No">
<html><head><LINK REL="STYLESHEET" TYPE="text/css" HREF="style.css">

<script language="JavaScript1.2" src="js_editrecord_dyn.cfm?ref=<cfoutput>#ref#</cfoutput>"></script>
<script language="JavaScript1.2" defer src="editRecord.js"></script>

<cfif ATTRIBUTES.saveAlert>
	<cfif ATTRIBUTES.BrowserName NEQ "Microsoft" OR ATTRIBUTES.BrowserVersion LT 4>

		<script language="JavaScript1.2">
		function saveAlert()
		{
			<!--- If it IS possible to click the save button - ie, saving IS possible --->
			if( parent.toolbarFrame.document.getElementById('but_save').className == "cButton" )
			if(confirm("Save changes to this record before exiting?"))
			{
				saveRecord();
				alert("Record Saved.");
			}	
		}
		</script>

	<cfelse>
		
		<script language="VBScript" src="editrecord.vbs"></script>

	</cfif>
</cfif>

</head>
<!--- Display the interface for editing the record --->
<body onload="init()"<cfif ATTRIBUTES.saveAlert> onunload="saveAlert()"</cfif>>
<div class="cRecord">
<fieldset class="cFieldset" style="width:<cfif ATTRIBUTES.BrowserName EQ "Netscape">95<cfelse>100</cfif>%;">
<form name="editForm" action="update.cfm" target="saveIFrame" method="post" onsubmit="return doSubmitCheck()">
<legend id="txt_recordId">
<cfif updateType EQ "insert">
	<cfif ATTRIBUTES.allowInsert>New Record<cfelse>Choose A Record</cfif>
<cfelse>
Editing Record <small>(key:
<cfloop index="i" from="1" to="#ListLen(keyList)#">
	<cfif assocAttribs[i].type EQ "KEY" OR assocAttribs[i].type EQ "KEY_TEXT">
		<cfoutput>#assocAttribs[ i ].field# = #Evaluate( "getRecord."&assocAttribs[ i ].field )#</cfoutput>
	</cfif>
</cfloop>
)</small>
</cfif>
</legend>

<!--- Write ref and updateType hidden fields and placeholders for Key fields for update --->
<cfoutput><input type="hidden" name="ref" value="#ref#"><input type="hidden" name="updateType" value="#updateType#"></cfoutput>
<cfloop index="attribIndex" list="#keyList#">
<cfoutput><input type="hidden" name="key_#assocAttribs[ attribIndex ].field#" value="#Evaluate( "getRecord."&assocAttribs[ attribIndex ].field )#"></cfoutput>
</cfloop>

<cfset selectNum = 0><cfset imageNum = 0><cfset fileNum = 0><cfset htmlNum = 0>
<cfoutput query="getRecord">
<table cellpadding=2 cellspacing=6 border=0 width="100%"><cfloop index="attribIndex" list="#displayList#"><tr><cfif ATTRIBUTES.listMode NEQ "0" AND ATTRIBUTES.listMode NEQ "sidebyside"><td class="columnName" nowrap>#assocAttribs[ attribIndex ].display#</td></tr><tr><cfelse><td class="columnName" nowrap>#assocAttribs[ attribIndex ].display#<cfparam name="assocAttribs[ #attribIndex# ].note" default=""><cfif Len( assocAttribs[ attribIndex ].note )><div class=note>#assocAttribs[ attribIndex ].note#</div></cfif></td></cfif>
<td class="columnValue" nowrap>
<cfparam name="assocAttribs[ #attribIndex# ].edit" default="1">
<cfset dbField = assocAttribs[ attribIndex ].field><cfset dbFieldVal = Evaluate(dbField)><cfparam name="assocAttribs[ #attribIndex# ].style" default=""><cfset cStyle = assocAttribs[ #attribIndex# ].style>
<cfinclude template="interfaces/#assocAttribs[ attribIndex ].type#/interface.cfm">
</td></tr>
</cfloop>
</table>
</cfoutput>
</form>

<cfif isdefined("ISDEF_dateNum")>
<form name="tranFormer" style="margin:0px;" action="dateTransformer.cfm" target="saveIFrame" method="post">
<input type="hidden" name="d" value="">
<input type="hidden" name="m" value="">
<input type="hidden" name="y" value="">
<input type="hidden" name="dateFormat" value="">
<input type="hidden" name="resultField" value="">
</form>
</cfif>

<!--- create a form simply for posting delete key details --->
<form name="deleteForm" action="update.cfm" target="saveIFrame" method="post">
<input type="hidden" name="ref" value="<cfoutput>#ref#</cfoutput>">
<input type="hidden" name="updateType" value="delete">
<cfloop index="i" from="1" to="#ListLen(keyList)#"><input type="hidden" name="key<cfoutput>#i#</cfoutput>" value=""></cfloop>
</form>

<!--- Write out the image paths that any html thingies should use --->
<cfset htmlNum = 0>
<cfloop index="attribIndex" list="#displayList#">
	<cfif assocAttribs[ attribIndex ].type EQ "wysiwyg">
		<cfset htmlNum = htmlNum + 1>
		<cfif htmlNum EQ 1>
			<script language="JavaScript1.2">
			var htmlImgURLPath = new Array();
			var htmlImgFilePath = new Array();
		</cfif>
		<cfparam name="assocAttribs[ #attribIndex# ].URLPath" default="">
		<cfparam name="assocAttribs[ #attribIndex# ].filePath" default="#GetDirectoryFromPath(GetBaseTemplatePath())#">
		htmlImgURLPath[<cfoutput>#Evaluate(htmlNum-1)#</cfoutput>] = "<cfoutput>#JSStringFormat( assocAttribs[ attribIndex ].URLPath )#</cfoutput>";
		htmlImgFilePath[<cfoutput>#Evaluate(htmlNum-1)#</cfoutput>] = "<cfoutput>#JSStringFormat( assocAttribs[ attribIndex ].filePath )#</cfoutput>";
	</cfif>
</cfloop>
<cfif htmlNum NEQ 0></script></cfif>

<cfif htmlNum GT 0>
	<SCRIPT defer>
	function initEditor(){
	var i=1;
	while( document.getElementById('idEdit'+i) )
	{
		eval("initHTML"+i+"()");
		i++;
		bLoad=true;
	}
	init();
	}	
	document.body.onload = initEditor;
	</SCRIPT>
</cfif>

</fieldset>
</div>

<cfif isdefined("ATTRIBUTES.showDebug") AND ATTRIBUTES.showDebug>
<span style="font-family:arial;font-size:10px;padding:10px;">Debug:</span>
<iframe src="about:blank" name="saveIFrame" width="100%" height="300"></iframe>
<cfelse>
<iframe src="about:blank" name="saveIFrame" width="1" height="1" style="display:none"></iframe>
</cfif>

</body>
</html>