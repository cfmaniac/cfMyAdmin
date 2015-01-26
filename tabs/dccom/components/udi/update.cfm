<!---
Update.cfm
Receives database record update request and performs it!
--->
<cfsetting enablecfoutputonly="Yes">

<!--- Start Document --->
<cfoutput><html><body></cfoutput>

<!--- Load the attributes --->	
<cfmodule template="serializeAttributes.cfm" method="load" uid="#ref#">

<!--- Find all "key" attributes --->
<cfset keyList = "">
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif Left(assocAttribs[i].type,3) EQ "KEY">
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

<!--- Cycle through all fields setting default values to "" (if string) or null(if integer) if not passed in --->
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif ListFind( ATTRIBUTES.noQuoteTypeList, assocAttribs[ i ].type )>
		<cfparam name="FORM.#assocAttribs[ i ].field#" default="null">
	<cfelseif ListFind( ATTRIBUTES.useQuoteTypeList, assocAttribs[ i ].type )>
		<cfparam name="FORM.#assocAttribs[ i ].field#" default="">
		<!--- Ensure the any string doesn't exceed its allowed maxlength, if set --->
		<cfparam name="assocAttribs[ i ].maxlength" default="-1">
		<cfif assocAttribs[ i ].maxlength GE 1>
			<cfscript>Evaluate("FORM." & assocAttribs[ i ].field & " = Left( FORM." & assocAttribs[ i ].field & ",assocAttribs[ i ].maxlength)");</cfscript>
		</cfif>
	</cfif>
</cfloop>

<!--- START: Delete all strings that create absolute links --->
	<!--- Build list of strings to delete --->
	<cfset delHTMLList = "">
	<cfset delHTMLList = ListAppend(delHTMLList, "http://" & cgi.SERVER_NAME & rereplacenocase(cgi.PATH_INFO, "(.+)/.+", "\1/", "ALL") )>
	<cfif isdefined("ATTRIBUTES.baseHref")>
		<cfset delHTMLList = ListAppend(delHTMLList, ATTRIBUTES.baseHref )>
	</cfif>
	
	<!--- Perform URL conversion on any and all WYSIWYG inputs --->
	<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
		<cfif assocAttribs[ i ].type EQ "wysiwyg">
			<cfloop index="delString" list="#delHTMLList#">
				<cfscript>
					Evaluate( "tempreplaceString = FORM." & assocAttribs[ i ].field );
					tempreplaceString = replacenocase( tempreplaceString, delString, "", "ALL" );
					Evaluate( "FORM." & assocAttribs[ i ].field & "= tempreplaceString");
				</cfscript>
			</cfloop>
			<!--- Also remove references to the base href --->
			<cfparam name="assocAttribs[#i#].basehref" default="">
			<cfif Len(assocAttribs[i].basehref)>
				<cfscript>Evaluate( "FORM." & assocAttribs[ i ].field & "= replaceNoCase(FORM." & assocAttribs[ i ].field & ",assocAttribs[#i#].basehref,'','ALL')");</cfscript>
			</cfif>
		</cfif>
		<cfif ListFind("wysiwyg,text,textbox",LCASE(assocAttribs[ i ].type))>
			<!--- Remove any foreign chars if requested --->
			<cfparam name="assocAttribs[#i#].recodeForeignChars" default="no">
			<cfif assocAttribs[i].recodeForeignChars>
				<cfscript>
				Evaluate( "ts = FORM." & assocAttribs[ i ].field );
				ts = replacenocase( ts, "€", "&euro;", "ALL" );
				ts = replacenocase( ts, "à", "&agrave;", "ALL" );
				ts = replacenocase( ts, "â", "&acirc;", "ALL" );
				ts = replacenocase( ts, "ç", "&##231;", "ALL" );
				ts = replacenocase( ts, "é", "&##233;", "ALL" );
				ts = replacenocase( ts, "è", "&##232;", "ALL" );
				ts = replacenocase( ts, "ê", "&##234;", "ALL" );
				ts = replacenocase( ts, "ë", "&##235;", "ALL" );
				ts = replacenocase( ts, "î", "&##238;", "ALL" );
				ts = replacenocase( ts, "ô", "&##244;", "ALL" );
				ts = replacenocase( ts, "ù", "&##249;", "ALL" );
				ts = replacenocase( ts, "û", "&##251;", "ALL" );
				ts = replacenocase( ts, "À", "&##192;", "ALL" );
				ts = replacenocase( ts, "Â", "&##194;", "ALL" );
				ts = replacenocase( ts, "Ç", "&##199;", "ALL" );
				ts = replacenocase( ts, "È", "&##200;", "ALL" );
				ts = replacenocase( ts, "É", "&##201;", "ALL" );
				ts = replacenocase( ts, "Ê", "&##202;", "ALL" );
				ts = replacenocase( ts, "Ë", "&##203;", "ALL" );
				ts = replacenocase( ts, "Î", "&##206;", "ALL" );
				ts = replacenocase( ts, "Ô", "&##212;", "ALL" );
				ts = replacenocase( ts, "Ù", "&##217;", "ALL" );
				ts = replacenocase( ts, "Û", "&##219;", "ALL" );
				ts = replacenocase( ts, "«", "&##171;", "ALL" );
				ts = replacenocase( ts, "»", "&##187;", "ALL" );
				ts = replacenocase( ts, "Ï", "&##207;", "ALL" );
				//SPANISH
				ts = replacenocase( ts, "á", "&##224;", "ALL" );
				ts = replacenocase( ts, "í", "&##237;", "ALL" );
				ts = replacenocase( ts, "ñ", "&##241;", "ALL" );
				ts = replacenocase( ts, "ó", "&##243;", "ALL" );
				ts = replacenocase( ts, "ú", "&##250;", "ALL" );
				ts = replacenocase( ts, "ü", "&##252;", "ALL" );
				ts = replacenocase( ts, "Á", "&##193;", "ALL" );
				ts = replacenocase( ts, "Í", "&##205;", "ALL" );
				ts = replacenocase( ts, "Ñ", "&##209;", "ALL" );
				ts = replacenocase( ts, "Ó", "&##211;", "ALL" );
				ts = replacenocase( ts, "Ú", "&##218;", "ALL" );
				ts = replacenocase( ts, "Ü", "&##220;", "ALL" );
				ts = replacenocase( ts, "¿", "&##191;", "ALL" );
				ts = replacenocase( ts, "¡", "&##161;", "ALL" );
				//PORTUGUESE
				ts = replacenocase( ts, "ã", "&##267;", "ALL" );
				ts = replacenocase( ts, "Ã", "&##195;", "ALL" );
				//ITALIAN
				ts = replacenocase( ts, "ì", "&##236;", "ALL" );
				ts = replacenocase( ts, "ò", "&##242;", "ALL" );
				ts = replacenocase( ts, "Ì", "&##204;", "ALL" );
				ts = replacenocase( ts, "Ò", "&##210;", "ALL" );
				//GERMAN/SCANDINAVIAN
				ts = replacenocase( ts, "ä", "&##228;", "ALL" );
				ts = replacenocase( ts, "å", "&##229;", "ALL" );
				ts = replacenocase( ts, "æ", "&##230;", "ALL" );
				ts = replacenocase( ts, "ð", "&##240;", "ALL" );
				ts = replacenocase( ts, "ö", "&##246;", "ALL" );
				ts = replacenocase( ts, "ø", "&##248;", "ALL" );
				ts = replacenocase( ts, "ß", "&##223;", "ALL" );
				ts = replacenocase( ts, "þ", "&##254;", "ALL" );
				ts = replacenocase( ts, "ü", "&##252;", "ALL" );
				ts = replacenocase( ts, "ÿ", "&##255;", "ALL" );
				ts = replacenocase( ts, "Ä", "&##196;", "ALL" );
				ts = replacenocase( ts, "Å", "&##197;", "ALL" );
				ts = replacenocase( ts, "Æ", "&##198;", "ALL" );
				ts = replacenocase( ts, "Ð", "&##208;", "ALL" );
				ts = replacenocase( ts, "Ö", "&##214;", "ALL" );
				ts = replacenocase( ts, "Ø", "&##216;", "ALL" );
				ts = replacenocase( ts, "Þ", "&##222;", "ALL" );
				ts = replacenocase( ts, "‘", "&lsquo;", "ALL" );
				ts = replacenocase( ts, "’", "&rsquo;", "ALL" );
				Evaluate( "FORM." & assocAttribs[ i ].field & "= ts");</cfscript>
			</cfif>
		</cfif>
	</cfloop>
	<!--- END: Delete all strings that create absolute links --->

<!--- START: PRE ACTION Extra Processing Includes --->
<!--- If the developer has specified that a file should be included on update, then do it --->
<cfif updateType EQ "update" AND isdefined("ATTRIBUTES.includeBeforeUpdate")>
	<cfinclude template="../../../#ATTRIBUTES.includeBeforeUpdate#">
<cfelseif updateType EQ "insert" AND isdefined("ATTRIBUTES.includeBeforeInsert")>
	<cfinclude template="../../../#ATTRIBUTES.includeBeforeInsert#">
<cfelseif updateType EQ "delete" AND isdefined("ATTRIBUTES.includeBeforeDelete")>
	<cfinclude template="../../../#ATTRIBUTES.includeBeforeDelete#">
</cfif>
<cfif isdefined("ATTRIBUTES.includeBeforeInsertOrUpdate") AND (updateType EQ "insert" OR updateType EQ "update")>
	<cfinclude template="../../../#ATTRIBUTES.includeBeforeInsertOrUpdate#">
<cfelseif isdefined("ATTRIBUTES.includeBeforeInsertOrUpdateOrDelete")>
	<cfinclude template="../../../#ATTRIBUTES.includeBeforeInsertOrUpdateOrDelete#">
</cfif>
<!--- END: PRE ACTION Extra Processing Includes --->

<!--- DATA VALUE CONVERSION --->
<!--- No need for conversion on Delete --->
<cfif updateType NEQ "delete">
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">

	<cfswitch expression="#LCASE(assocAttribs[ i ].type)#">
		<cfcase value="boolean">
		<!--- Handling Non-existant values (eg. An unchecked form send nothing through - value should be set to 0) --->
			<cfif Evaluate( "FORM."&assocAttribs[ i ].field ) EQ "null">
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = 0 ");</cfscript>
			<cfelse>
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = 1 ");</cfscript>
			</cfif>
		</cfcase>
		<cfcase value="boolean_yn">
			<cfif Evaluate( "FORM."&assocAttribs[ i ].field ) EQ "">
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = 'N' ");</cfscript>
			<cfelse>
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = 'Y' ");</cfscript>
			</cfif>
		</cfcase>
		<cfcase value="date">
			<cfparam name="ISDEF_dateNum" default="0">
			<cfset ISDEF_dateNum = ISDEF_dateNum + 1>
			<cfif Evaluate("datePart_y"&ISDEF_dateNum) EQ "">
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = ""null"" ");</cfscript>
			<cfelse>
				<!--- Convert d/m/y to ODBCDateFormat() --->
				<cfset theDate = Evaluate("CreateDate(datePart_y#ISDEF_dateNum#,datePart_m#ISDEF_dateNum#,datePart_d#ISDEF_dateNum#)")>
				<cfscript>Evaluate("theDate"&ISDEF_dateNum&"=theDate");</cfscript>
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = CreateODBCDate(theDate) ");</cfscript>
			</cfif>
		</cfcase>
		<cfcase value="datetime">
			<cfparam name="ISDEF_dateNum" default="0">
			<cfset ISDEF_dateNum = ISDEF_dateNum + 1>
			<!--- Convert d/m/y to ODBCDateTimeFormat() --->
			<cfif Evaluate("dateHours#ISDEF_dateNum#") EQ "" OR Evaluate("dateMins#ISDEF_dateNum#") EQ "">
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = ""null"" ");</cfscript>
			<cfelse>
				<cfset h = Evaluate("dateHours"&ISDEF_dateNum)>
				<cfset m = Evaluate("dateMins"&ISDEF_dateNum)>
				<cfif Evaluate("datePart_y"&ISDEF_dateNum) EQ "">
					<cfscript>
					Evaluate("datePart_y"&ISDEF_dateNum&" = Year(now())");
					Evaluate("datePart_m"&ISDEF_dateNum&" = Month(now())");
					Evaluate("datePart_d"&ISDEF_dateNum&" = Day(now())");
					</cfscript>
				</cfif>
				<cfset theDate = Evaluate("CreateDateTime(datePart_y#ISDEF_dateNum#,datePart_m#ISDEF_dateNum#,datePart_d#ISDEF_dateNum#,h,m,0)")>
				<cfscript>Evaluate("theDate"&ISDEF_dateNum&"=theDate");</cfscript>
				<cfscript>Evaluate( "FORM."&assocAttribs[ i ].field & " = CreateODBCDateTime(theDate) ");</cfscript>
			</cfif>
		</cfcase>	
	</cfswitch>
</cfloop>
</cfif>

<cftry>

	<cfset sqlTxt = "">
	<cfif updateType EQ "update">
	
		<cfset sqlTxt = "UPDATE #ATTRIBUTES.table# SET ">
		<cfloop index="i" from="1" to="#ListLen(displayList)#">
			<cfset sqlTxt = sqlTxt & "#assocAttribs[ ListGetAt(displayList,i) ].field# = ">
			<cfif ListFind( ATTRIBUTES.noQuoteTypeList, assocAttribs[ ListGetAt(displayList,i) ].type )>
				<cfset sqlTxt = sqlTxt & Evaluate( "FORM." & assocAttribs[ ListGetAt(displayList,i) ].field )>
			<cfelse>
				<cfset sqlTxt = sqlTxt & "'#replace(Evaluate( "FORM." & assocAttribs[ ListGetAt(displayList,i) ].field ),"'","''","ALL")#'">
			</cfif>
			<cfif i LT ListLen(displayList)>
				<cfset sqlTxt = sqlTxt & ",">
			</cfif>
		</cfloop>
		<cfset sqlTxt = sqlTxt & " WHERE ">
		<cfloop index="i" from="1" to="#ListLen(keyList)#">
			<cfset index = ListGetAt(keyList,i)>
			<cfswitch expression="#LCASE(assocAttribs[ index ].type)#">
				<cfcase value="key">
					<cfset sqlTxt = sqlTxt & "#assocAttribs[ index ].field# = ">
					<cfset sqlTxt = sqlTxt & "#Evaluate( "FORM.key_" & assocAttribs[ index ].field )#">
				</cfcase>
				<cfcase value="key_text,key_uuid">
					<cfset sqlTxt = sqlTxt & "#assocAttribs[ index ].field# = ">
					<cfset sqlTxt = sqlTxt & "'#Evaluate( "FORM.key_" & assocAttribs[ index ].field )#'">
				</cfcase>
			</cfswitch>
			<cfif i LT ListLen(keyList)>
				<cfset sqlTxt = sqlTxt & " AND ">
			</cfif>
		</cfloop>
	
	<cfelseif updateType EQ "insert">
	
		<cfset sqlTxt = "INSERT INTO #ATTRIBUTES.table#(">
		<cfset fieldCount = 0>
		<cfloop index="i" from="1" to="#ListLen(keyList)#">
			<cfif assocAttribs[ ListGetAt(keyList,i) ].type EQ "key_uuid">
				<cfif fieldCount GT 0><cfset sqlTxt = sqlTxt & ","></cfif>
				<cfset fieldCount = fieldCount+1>
				<cfset sqlTxt = sqlTxt & assocAttribs[ ListGetAt(keyList,i) ].field>
			</cfif>
		</cfloop>
		<cfloop index="i" from="1" to="#ListLen(displayList)#">
			<cfif fieldCount GT 0><cfset sqlTxt = sqlTxt & ","></cfif>
			<cfset fieldCount = fieldCount+1>
			<cfset sqlTxt = sqlTxt & assocAttribs[ ListGetAt(displayList,i) ].field>
		</cfloop>
		<cfset sqlTxt = sqlTxt & ") VALUES(">
		<cfset fieldCount = 0>
		<cfloop index="i" from="1" to="#ListLen(keyList)#">
			<cfif assocAttribs[ ListGetAt(keyList,i) ].type EQ "key_uuid">
				<cfif fieldCount GT 0><cfset sqlTxt = sqlTxt & ","></cfif>
				<cfset fieldCount = fieldCount+1>
				<cfset sqlTxt = sqlTxt & "'#CreateUUID()#'">
			</cfif>
		</cfloop>
		<cfloop index="i" from="1" to="#ListLen(displayList)#">
			<cfif fieldCount GT 0><cfset sqlTxt = sqlTxt & ","></cfif>
			<cfset fieldCount = fieldCount+1>
			<cfif ListFind( ATTRIBUTES.noQuoteTypeList, assocAttribs[ ListGetAt(displayList,i) ].type )>
				<cfset sqlTxt = sqlTxt & Evaluate( "FORM." & assocAttribs[ ListGetAt(displayList,i) ].field )>
			<cfelse>
				<cfset sqlTxt = sqlTxt & "'#replace(Evaluate( "FORM." & assocAttribs[ ListGetAt(displayList,i) ].field ),"'","''","ALL")#'">
			</cfif>
		</cfloop>
		<cfset sqlTxt = sqlTxt & ")">

	<cfelseif updateType EQ "delete">
	
		<cfset sqlTxt = "DELETE FROM #ATTRIBUTES.table# WHERE ">
		<cfloop index="i" from="1" to="#ListLen(keyList)#">
			<cfset index = ListGetAt(keyList,i)>
			<cfset sqlTxt = sqlTxt & "#assocAttribs[ index ].field# = ">
			<cfif assocAttribs[ index ].type EQ "key_text" OR assocAttribs[ index ].type EQ "key_uuid" >
				<cfset sqlTxt = sqlTxt & "'#Evaluate("FORM.key"&i)#'">
			<cfelse>
				<cfset sqlTxt = sqlTxt & "#Evaluate("FORM.key"&i)#">
			</cfif>
			<cfif i LT ListLen(keyList)>
				<cfset sqlTxt = sqlTxt & " AND ">
			</cfif>
		</cfloop>
	</cfif>

	<cfif isdefined("ATTRIBUTES.showDebug") AND ATTRIBUTES.showDebug>
	<cfoutput>
	<div style="font-family:arial;border:1px solid ##202020;padding:10px;">
	About to execute SQL:<br><br>
	<div style="font-family:courier;font-size:10px;">
		<cfif LEFT(sqlTxt,7) EQ "UPDATE ">
			#replace(replaceList(sqlTxt,"UPDATE , SET , = ,WHERE","<b>UPDATE</b> ,<br> <b>SET</b> <span style='color:red'>,</span> = ,<br><b>WHERE</b>"),",",",<br><span style='color:red'>","ALL")#
		<cfelse>
			#replaceList(sqlTxt,"INSERT INTO, VALUES","<span style='color:green;'><b>INSERT INTO</b></span>,<br><span style='color:green;'><b>VALUES</b></span>")#
		</cfif>	
	</div>
	</div>
	<br><br>
	</cfoutput>
	</cfif>
	
	<!--- MySQL Escaping --->
	<cfif ATTRIBUTES.dbtype EQ "MYSQL">
		<cfset sqlTxt = replace(sqlTxt,"\","\\","ALL")>
	</cfif>
	
	<!--- Execute the generated SQL --->
	<cfmodule template="mod_query.cfm" queryname="updateRecord" maxrows="1">
		<cfoutput>#sqlTxt#</cfoutput>
	</cfmodule>
	
	<cfcatch type="Any">
		<cfset NEWLINE = chr(13)&chr(10)>
		<cfoutput>
			<script language="JavaScript1.2">
			function showMsg(msgTitle,msg)
			{
				var UDIMsgWin=window.open('about:blank','UDIMsgWin','width=360,height=400,resizable=no');
				UDIMsgWin.document.open();
				UDIMsgWin.document.write("<html><head><title>"+msgTitle+"</title><style>body,td{font-family:verdana,arial;font-size:10px;}body{margin:0px}</style></head><body><table cellpadding=0 cellspacing=0 border=0 width=100% height=100%><tr><td height=67 background='editinterface/header1.jpg'>&nbsp;</td></tr><tr><td height=22 background='editinterface/header2.jpg'>&nbsp;</td></tr><tr><td height=13 background='editinterface/header3.jpg'>&nbsp;</td></tr><tr><td><div style='height:100%;overflow:auto;padding:10px;'><h3>"+msgTitle+"</h3>"+msg+"</div></td></tr></table></body></html>");
				UDIMsgWin.document.close();
			}
			if(confirm("Error updating database.\r\nShow Details?"))
			{
				msg = "Error Type: #JSStringFormat(cfcatch.type)#\rMessage: #JSStringFormat(cfcatch.message)#\r#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#";
				showMsg("UDI Update/Insert Error",msg);
			}
			</script>
		</cfoutput>
		<cfabort>
	</cfcatch>

</cftry>


<!--- Lookup any drop-down select Querys --->
<cfset selectNum = 0>
<cfloop index="i" list="#displayList#">
<cfif assocAttribs[i].type EQ "select_number">
	<cfset selectNum = selectNum + 1>
	<cfparam name="assocAttribs[#i#].query" default="">
	<cfif assocAttribs[#i#].query NEQ "">
		<cfset queryString = assocAttribs[i].query>
		<cfmodule template="mod_query.cfm" queryname="selectQuery#selectNum#">
			<cfoutput>#queryString#</cfoutput>
		</cfmodule>
		<cfparam name="assocAttribs[ #i# ].delimiter" default="|~">
		<cfparam name="assocAttribs[ #i# ].queryValueColumn" default="valueCol">
		<cfparam name="assocAttribs[ #i# ].queryDisplayColumn" default="displayCol">
		<cfscript>
		Evaluate("assocAttribs[ #i# ].displayList=ValueList(selectQuery"&selectNum&"."&assocAttribs[ #i# ].queryDisplayColumn&", assocAttribs[ i ].delimiter )");
		Evaluate("assocAttribs[ #i# ].valList=ValueList(selectQuery"&selectNum&"."&assocAttribs[ #i# ].queryValueColumn&", assocAttribs[ i ].delimiter )");
		</cfscript>
	</cfif>
</cfif>
</cfloop>


<cfoutput>
<script language="JavaScript1.2">
	var updateKey = new Array();
	var updateVals = new Array();
</cfoutput>

<cfif updateType EQ "delete">
	<cfloop index="i" from="1" to="#ListLen(keyList)#">
		<cfoutput>
			updateKey[#Evaluate(i-1)#] = "#JSStringFormat(Evaluate( "FORM.key" & i ))#";
		</cfoutput>
	</cfloop>
<cfelse>
	<cfloop index="i" from="1" to="#ListLen(keyList)#">
		<cfoutput>
			updateKey[#Evaluate(i-1)#] = "#JSStringFormat(Evaluate( "FORM.key_" & assocAttribs[ ListGetAt(keyList,i) ].field ))#";
		</cfoutput>
	</cfloop>
	
	<cfset count = 0>
	<cfloop index="i" from="1" to="#ListLen(displayList)#">
		<cfif ATTRIBUTES.listAll OR ( (ListLen(keyList)+count) LT ATTRIBUTES.maxShortItems )>
			<cfset theType = assocAttribs[ ListGetAt(displayList,i) ].type>
			<cfif Left(theType,3) NEQ "key">
				<cfif ATTRIBUTES.listAll OR ListFind( ATTRIBUTES.chooseRecordTypeList, theType )>
					<cfset count = count + 1>
		
					<cfset posAt = ListGetAt(displayList,i)>
					<cfset dbVal = Evaluate("FORM."&assocAttribs[ posAt ].field)>
					<cfswitch expression="#theType#">
						<cfcase value="select_number">
							<cfparam name="assocAttribs[ posAt ].rangeStart" default="">
							<cfif assocAttribs[ posAt ].rangeStart NEQ "">
								<cfoutput>updateVals[updateVals.length] = "#JSStringFormat( HTMLEditFormat( Left( dbVal, ATTRIBUTES.maxListTextSize ) ) )#";</cfoutput>
							<cfelse>
								<cfparam name="assocAttribs[ #posAt# ].delimiter" default="|~">
								<cfset foundAtPos = ListFind( assocAttribs[ posAt].valList , dbVal, assocAttribs[ posAt ].delimiter )>
								<cfif foundAtPos NEQ 0>
									<cfoutput>updateVals[updateVals.length] = "#JSStringFormat( HTMLEditFormat( Left( ListGetAt( assocAttribs[ posAt ].displayList, foundAtPos, assocAttribs[ posAt ].delimiter ), ATTRIBUTES.maxListTextSize ) ) )#";</cfoutput>
								<cfelse>
									<cfoutput>updateVals[updateVals.length] = "#JSStringFormat( HTMLEditFormat( "<span style=""color:red;font-weight:bold;"">NO MATCH</span>" ) )#";</cfoutput>
								</cfif>
							</cfif>					
						</cfcase>
						<cfcase value="password">
							<cfoutput>updateVals[updateVals.length] = "<span style=\"color:##999999\"><em>HIDDEN</em></span>";</cfoutput>
						</cfcase>
						<cfcase value="date">
							<cfparam name="ISDEF_dateNum2" default="0">
							<cfset ISDEF_dateNum2 = ISDEF_dateNum2 + 1>
							<cfif dbVal EQ "">
								<cfoutput>updateVals[updateVals.length] = " &nbsp; ";</cfoutput>
							<cfelse>
								<cfparam name="assocAttribs[#posAt#].dateFormat" default="dd mmmm yyyy">
								<cfoutput>updateVals[updateVals.length] = "#JSStringFormat(HTMLEditFormat( DateFormat(Evaluate("theDate"&ISDEF_dateNum2), assocAttribs[posAt].dateformat ) ))#";</cfoutput>
							</cfif>
						</cfcase>
						<cfcase value="datetime">
							<cfparam name="ISDEF_dateNum2" default="0">
							<cfset ISDEF_dateNum2 = ISDEF_dateNum2 + 1>
							<cfif dbVal EQ "">
								<cfoutput>updateVals[updateVals.length] = " &nbsp; ";</cfoutput>
							<cfelse>
								<cfparam name="assocAttribs[#posAt#].dateFormat" default="dd mmmm yyyy">
								<cfoutput>updateVals[updateVals.length] = "#JSStringFormat( HTMLEditFormat( TimeFormat(Evaluate("theDate"&ISDEF_dateNum2)) & " " & DateFormat(Evaluate("theDate"&ISDEF_dateNum2), assocAttribs[posAt].dateformat ) ))#";</cfoutput>
							</cfif>
						</cfcase>
						<cfdefaultcase>
							<cfoutput>updateVals[updateVals.length] = "#JSStringFormat( HTMLEditFormat( Left( dbVal, ATTRIBUTES.maxListTextSize ) ) )#";</cfoutput>
						</cfdefaultcase>
					</cfswitch>
				</cfif>
			</cfif>
		</cfif>
	</cfloop>
</cfif>

<!--- If update must slide the update text back 1 position for every key_text so we count them here, --->
<!--- also we need to update the hidden key names --->
<cfset num_text_keys = 0>
<cfif updateType EQ "update">
	<cfloop index="i" from="1" to="#ListLen(keyList)#">
		<cfset posAt = ListGetAt(keyList,i)>
		<cfif assocAttribs[ posAt ].type EQ "key_text">
			<cfset num_text_keys = num_text_keys + 1>
			<cfif Evaluate("key_"&assocAttribs[ posAt ].field) NEQ Evaluate(assocAttribs[ posAt ].field)>
				<cfoutput>parent.document.editForm.key_#assocAttribs[ posAt ].field#.value = "#JSStringFormat(Evaluate(assocAttribs[ posAt ].field))#";</cfoutput>
			</cfif>
		</cfif>
	</cfloop>
</cfif>

<cfoutput>
 parent.parent.chooseFrame.updateRowView( "#updateType#", updateKey, updateVals, #num_text_keys# );</cfoutput>

<!--- Disable the save button --->
<cfoutput>parent.parent.toolbarFrame.enableSaveButton(false);</cfoutput>

<!--- End the javascript --->
<cfoutput></script></cfoutput>


<!--- START: POST ACTION Extra Processing Includes --->
<!--- If the developer has specified that a file should be included on update, then do it --->
<cfif updateType EQ "update" AND isdefined("ATTRIBUTES.includeOnUpdate")>
	<cfinclude template="../../../#ATTRIBUTES.includeOnUpdate#">
<!--- If the developer has specified that a file should be included on insert, then do it --->
<cfelseif updateType EQ "insert" AND isdefined("ATTRIBUTES.includeOnInsert")>
	<cfinclude template="../../../#ATTRIBUTES.includeOnInsert#">
<cfelseif updateType EQ "delete" AND isdefined("ATTRIBUTES.includeOnDelete")>
	<cfinclude template="../../../#ATTRIBUTES.includeOnDelete#">
</cfif>
<cfif isdefined("ATTRIBUTES.includeOnInsertOrUpdate") AND (updateType EQ "insert" OR updateType EQ "update")>
	<cfinclude template="../../../#ATTRIBUTES.includeOnInsertOrUpdate#">
<cfelseif isdefined("ATTRIBUTES.includeOnInsertOrUpdateOrDelete")>
	<cfinclude template="../../../#ATTRIBUTES.includeOnInsertOrUpdateOrDelete#">
</cfif>
<!--- END: POST ACTION Extra Processing Includes --->


<!--- Close Document --->
<cfoutput></body></html></cfoutput>