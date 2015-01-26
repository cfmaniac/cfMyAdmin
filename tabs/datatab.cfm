<cfif SESSION.connectString IS "">
	<html><body><script>alert("Sorry,\nYour session had timed out.");top.location.href="../index.cfm";</script></body></html>
	<cfabort>
</cfif>
<cfmodule template="..\modules\smartquery.cfm" queryname="useDatabase"><cfoutput>
USE #theDatabase#
</cfoutput></cfmodule>

<cfmodule template="..\modules\smartquery.cfm" queryname="getTables"><cfoutput>
SHOW FIELDS FROM #theTable#
</cfoutput></cfmodule>

<cfmodule template="..\modules\smartquery.cfm" queryname="getNumRecords"><cfoutput>
SELECT COUNT(*) AS numRecords FROM #theTable#
</cfoutput></cfmodule>

<script>
parent.hideTools("tableTools");
parent.hideTools("databaseTools");
parent.document.getElementById("theTitleBar").innerText = <cfoutput>"#theTable#: #getNumRecords.numRecords# records";</cfoutput>
</script>

<cfset theFields=getTables.columnList>

<html><head><style>body{margin:0px;}</style></head><body>
<cfset ColdFusionVersion = Left(server.ColdFusion.ProductVersion,1)>
<cfif ColdFusionVersion GTE 6>
	
	<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" table="#theTable#" datasource="#SESSION.datasource#" username="#SESSION.db_username#" password="#SESSION.db_password#" listmode="sidebyside" component="udi" width="100%" height="100%" maxShortItems="888" allowInsert="yes" allowUpdate="yes" allowDelete="yes" showHeader="no" showAbout="no" showIFrame="no">
	<cfloop query="getTables">
		<cfif getTables.Key EQ "PRI">
			<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" type="key" display="#field#"></cf_dccom>
		</cfif>
	</cfloop>
	<cfloop query="getTables">
		<cfif NOT getTables.Key EQ "PRI">
			
			<!--- Should notNull be set? --->
			<cfif NULL EQ "YES"><cfset notNull = "0"><cfelse><cfset notNull = "1"></cfif>
		
			<cfif Left(TYPE,7) EQ "varchar">
		
				<!--- VARCHAR --->
				<cf_getnumericvalfromstring string="#TYPE#" output="maxlength">
				<cfset size = maxlength+1>
				<cfif size GT 60><cfset size = 60></cfif>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" notNull="#notNull#" type="text" size="#size#" maxlength="#maxlength#"></cf_dccom>
		
			<cfelseif Left(TYPE,3) EQ "int">
			
				<!---- INT --->
				<cfset endBracket = Find(")",TYPE,3)>
				<cfset maxlength = Mid(TYPE,5,endBracket-5)>
				<cfif Find("unsigned",TYPE)>
					<cfset minval = 0>
					<cfset maxval = (256^maxlength)>
				<cfelse>
					<cfset minval = ((256^maxlength)/2)*-1>
					<cfset maxval = ((256^maxlength)/2)>
				</cfif>
				<cfset size = Len(maxval)>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" notNull="#notNull#" type="number" size="#size#" maxlength="#size#" minValue="#minval#" maxValue="#maxVal#"></cf_dccom>
				
			<cfelseif TYPE EQ "enum('0','1')">
	
				<!--- ENUM('0','1') --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="boolean" default="#DEFAULT#"></cf_dccom>
		
			<cfelseif TYPE EQ "enum('Y','N')" OR TYPE EQ "enum('N','Y')">
	
				<!--- ENUM('Y','N') --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="boolean_yn" default="#DEFAULT#"></cf_dccom>
		
			<cfelseif Left(TYPE,5) EQ "enum(">
	
				<!--- ENUM --->
				<cfset endBracket = Find(")",TYPE,4)>
				<cfset types = Mid(TYPE,6,endBracket-6)>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="select_text" displayList="#types#" valList="#types#" default="#DEFAULT#"></cf_dccom>
		
			<cfelseif TYPE EQ "TINYTEXT">
	
				<!--- TINYTEXT --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="text" size="50" maxlength="255" default="#DEFAULT#"></cf_dccom>
	
			<cfelseif TYPE EQ "TINYTEXT" OR TYPE EQ "TEXT" OR TYPE EQ "MEDIUMTEXT" OR TYPE EQ "longtext">
	
				<!--- TEXT, MEDIUMTEXT, LONGTEXT --->
				<cfif TYPE EQ "text"><cfset max="65535"><cfset rows="8"><cfelseif TYPE EQ "mediumtext"><cfset max="16777215"><cfset rows="12"><cfelseif TYPE EQ "longtext"><cfset max="4294967295"><cfset rows="20"></cfif>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="textbox" cols="60" rows="#rows#" maxlength="#max#" default="#DEFAULT#" style="width:90%;"></cf_dccom>
		
			<cfelseif Left(TYPE,8) EQ "datetime">
	
				<!--- DATETIME --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="datetime" datemask="#options_datemask#" monthfirst="#options_monthfirst#"></cf_dccom>
	
			<cfelseif Left(TYPE,4) EQ "date">
	
				<!--- DATE --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="date" datemask="#options_datemask#" monthfirst="#options_monthfirst#"></cf_dccom>

			<cfelseif Left(TYPE,9) EQ "timestamp">
	
				<!--- TIMESTAMP --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="datetime" edit="no" datemask="#options_datemask#" monthfirst="#options_monthfirst#"></cf_dccom>

			<cfelse>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" notNull="#notNull#" type="text" size="50"></cf_dccom>
			</cfif>
		</cfif>
	</cfloop>
	</cf_dccom>
<cfelse>
	<cf_dccom dcCom_RelPath="dccom/" dcCom_FilePath="dccom/" table="#theTable#" database="#theDatabase#" listmode="sidebyside" component="udi" connectstring="#SESSION.connectString#" width="100%" height="100%" maxShortItems="888" allowInsert="yes" allowUpdate="yes" allowDelete="yes" showHeader="no" showAbout="no" showIFrame="no">
	<cfloop query="getTables">
		<cfif getTables.Key EQ "PRI">
			<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" type="key" display="#field#"></cf_dccom>
		</cfif>
	</cfloop>
	<cfloop query="getTables">
		<cfif NOT getTables.Key EQ "PRI">
			
			<!--- Should notNull be set? --->
			<cfif NULL EQ "YES"><cfset notNull = "0"><cfelse><cfset notNull = "1"></cfif>
		
			<cfif Left(TYPE,7) EQ "varchar">
		
				<!--- VARCHAR --->
				<cf_getnumericvalfromstring string="#TYPE#" output="maxlength">
				<cfset size = maxlength+1>
				<cfif size GT 60><cfset size = 60></cfif>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" notNull="#notNull#" type="text" size="#size#" maxlength="#maxlength#"></cf_dccom>
		
			<cfelseif Left(TYPE,3) EQ "int">
			
				<!---- INT --->
				<cfset endBracket = Find(")",TYPE,3)>
				<cfset maxlength = Mid(TYPE,5,endBracket-5)>
				<cfif Find("unsigned",TYPE)>
					<cfset minval = 0>
					<cfset maxval = (256^maxlength)>
				<cfelse>
					<cfset minval = ((256^maxlength)/2)*-1>
					<cfset maxval = ((256^maxlength)/2)>
				</cfif>
				<cfset size = Len(maxval)>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" notNull="#notNull#" type="number" size="#size#" maxlength="#size#" minValue="#minval#" maxValue="#maxVal#"></cf_dccom>
				
			<cfelseif TYPE EQ "enum('0','1')">
	
				<!--- ENUM('0','1') --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="boolean" default="#DEFAULT#"></cf_dccom>
		
			<cfelseif TYPE EQ "enum('Y','N')" OR TYPE EQ "enum('N','Y')">
	
				<!--- ENUM('Y','N') --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="boolean_yn" default="#DEFAULT#"></cf_dccom>
		
			<cfelseif Left(TYPE,5) EQ "enum(">
	
				<!--- ENUM --->
				<cfset endBracket = Find(")",TYPE,4)>
				<cfset types = Mid(TYPE,6,endBracket-6)>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="select_text" displayList="#types#" valList="#types#" default="#DEFAULT#"></CF_DCCOM>
		
			<cfelseif TYPE EQ "TINYTEXT">
	
				<!--- TINYTEXT --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="text" size="50" maxlength="255" default="#DEFAULT#"></cf_dccom>
	
			<cfelseif TYPE EQ "TINYTEXT" OR TYPE EQ "TEXT" OR TYPE EQ "MEDIUMTEXT" OR TYPE EQ "longtext">
	
				<!--- TEXT, MEDIUMTEXT, LONGTEXT --->
				<cfif TYPE EQ "text"><cfset max="65535"><cfset rows="8"><cfelseif TYPE EQ "mediumtext"><cfset max="16777215"><cfset rows="12"><cfelseif TYPE EQ "longtext"><cfset max="4294967295"><cfset rows="20"></cfif>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="textbox" cols="60" rows="#rows#" maxlength="#max#" default="#DEFAULT#" style="width:80%;"></cf_dccom>
		
			<cfelseif Left(TYPE,8) EQ "datetime">
	
				<!--- DATETIME --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="datetime" datemask="#options_datemask#" monthfirst="#options_monthfirst#"></cf_dccom>
	
			<cfelseif Left(TYPE,4) EQ "date">
	
				<!--- DATE --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="date" datemask="#options_datemask#" monthfirst="#options_monthfirst#"></cf_dccom>

			<cfelseif Left(TYPE,9) EQ "timestamp">
	
				<!--- TIMESTAMP --->
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" type="datetime" edit="no" datemask="#options_datemask#" monthfirst="#options_monthfirst#"></cf_dccom>

			<cfelse>
				<cf_dccom dccom_relpath="dccom/" dccom_filepath="dccom/" field="#field#" display="#field#" notNull="#notNull#" type="text" size="50"></cf_dccom>
			</cfif>
		</cfif>
	</cfloop>
	</cf_dccom>
</cfif>

</body></html>
