<cfset attribIndex = ListGetAt(displayList,i)>
<cfparam name="assocAttribs[#attribIndex#].query" default="">
<cfif assocAttribs[attribIndex].query NEQ "">
	<cfparam name="assocAttribs[#attribIndex#].querylookedup" default="no">
	<cfif assocAttribs[attribIndex].querylookedup EQ "no">
		<cfmodule template="..\mod_query.cfm" name="selectQueryRef">
		<cfset queryString = assocAttribs[attribIndex].query>
			<cfoutput>#queryString#</cfoutput>
		</cfmodule>
		<cfparam name="assocAttribs[ #attribIndex# ].delimiter" default="|~">
		<cfparam name="assocAttribs[ #attribIndex# ].queryValueColumn" default="valueCol">
		<cfparam name="assocAttribs[ #attribIndex# ].queryDisplayColumn" default="displayCol">
		<cfscript>
		Evaluate("assocAttribs[ #attribIndex# ].displayList=ValueList(selectQueryRef."&assocAttribs[ #attribIndex# ].queryDisplayColumn&", assocAttribs[ attribIndex ].delimiter )");
		Evaluate("assocAttribs[ #attribIndex# ].valList=ValueList(selectQueryRef."&assocAttribs[ #attribIndex# ].queryValueColumn&", assocAttribs[ attribIndex ].delimiter )");
		</cfscript>
		<cfset assocAttribs[attribIndex].querylookedup = "Yes">
	</cfif>
</cfif>
<cfparam name="assocAttribs[ attribIndex ].rangeStart" default="">
<cfif assocAttribs[ attribIndex ].rangeStart NEQ "">
	<cfoutput>#dbVal#</cfoutput>
<cfelse>
	<cfparam name="assocAttribs[ #attribIndex# ].delimiter" default=",">
	<cfparam name="assocAttribs[ #attribIndex# ].displayList" default="">
	<cfparam name="assocAttribs[ #attribIndex# ].valList" default="">
	<cfif assocAttribs[ attribIndex ].displayList EQ "" AND assocAttribs[ attribIndex ].valList NEQ "">
		<cfset assocAttribs[ attribIndex ].displayList = assocAttribs[ attribIndex ].valList>
	</cfif>
	<cfset foundAtPos = ListFind( assocAttribs[ attribIndex ].valList , dbVal, assocAttribs[ attribIndex ].delimiter )>
	<cfif foundAtPos NEQ 0>
		<cfoutput>#ListGetAt( assocAttribs[ attribIndex ].displayList, foundAtPos, assocAttribs[ attribIndex ].delimiter )#</cfoutput>
	<cfelse>
		<cfoutput><span style="color:red;font-weight:bold;">NO MATCH</span></cfoutput>
	</cfif>
</cfif>