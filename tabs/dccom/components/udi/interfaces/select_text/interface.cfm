<cfif NOT assocAttribs[ attribIndex ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>
<cfset selectNum = selectNum + 1>
<cfparam name="assocAttribs[ #attribIndex# ].size" default="0">
<cfparam name="assocAttribs[ #attribIndex# ].multiple" default="no">
<cfoutput>
<select name="#dbField#"<cfif cStyle NEQ ""> style="#cStyle#"</cfif> <cfif NOT assocAttribs[ attribIndex ].edit> onchange="<cfif dbFieldVal NEQ "">this.value='#JSStringFormat(dbFieldVal)#';</cfif>if(this.selectedIndex==-1)this.selectedIndex=0;"<cfelse> onchange="hasChanged()"</cfif><cfif assocAttribs[ attribIndex ].size GT 1> size="#assocAttribs[ attribIndex ].size#"</cfif><cfif assocAttribs[ attribIndex ].multiple> multiple</cfif>>
<cfif assocAttribs[ attribIndex ].query NEQ "">
	<cfparam name="assocAttribs[ #attribIndex# ].queryValueColumn" default="valueCol">
	<cfparam name="assocAttribs[ #attribIndex# ].queryDisplayColumn" default="displayCol">
	<cfset queryValueColumn = assocAttribs[ attribIndex ].queryValueColumn>
	<cfset queryDisplayColumn = assocAttribs[ attribIndex ].queryDisplayColumn>
	<cfloop query="selectQuery#selectNum#">
		<cfset loopFieldValue = evaluate( "#queryValueColumn#" )>
		<option<cfif (assocAttribs[ attribIndex ].multiple AND ListFind(dbFieldVal,loopFieldValue)) OR loopFieldValue EQ dbFieldVal> selected</cfif> value="#loopFieldValue#">#evaluate( "#queryDisplayColumn#" )#</option>
	</cfloop>
<!--- Complex Selects Based On Datastructures --->
<cfelse>
	<!--- Test for Dual Lists - Display List and Value List --->
	<cfparam name="assocAttribs[ #attribIndex# ].valList" default="">
	<cfparam name="assocAttribs[ #attribIndex# ].displayList" default="#assocAttribs[ attribIndex ].valList#">
	<cfif assocAttribs[ attribIndex ].displayList NEQ "" AND assocAttribs[ attribIndex ].valList NEQ "">
		<cfloop index="i" from="1" to="#ListLen( assocAttribs[ attribIndex ].displayList )#">
			<cfset loopFieldValue = ListGetAt( assocAttribs[ attribIndex ].valList , i )>
			<cfset loopFieldDisplay = ListGetAt( assocAttribs[ attribIndex ].displayList , i )>
			<option<cfif (assocAttribs[ attribIndex ].multiple AND ListFind(dbFieldVal,loopFieldValue)) OR loopFieldValue EQ dbFieldVal> selected</cfif> value="#loopFieldValue#">#loopFieldDisplay#</option>
		</cfloop>
	</cfif>
</cfif>
</select>
</cfoutput>