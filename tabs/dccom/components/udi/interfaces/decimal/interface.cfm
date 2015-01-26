<cfif NOT assocAttribs[ #attribIndex# ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>
<cfparam name="assocAttribs[ #attribIndex# ].size" default="30">
<cfparam name="assocAttribs[ #attribIndex# ].minValue" default="null">
<cfset minValue = assocAttribs[ #attribIndex# ].minValue>
<cfparam name="assocAttribs[ #attribIndex# ].maxValue" default="null">
<cfset maxValue = assocAttribs[ #attribIndex# ].maxValue>
<cfparam name="assocAttribs[ #attribIndex# ].maxlength" default="#Evaluate(assocAttribs[ attribIndex ].size * 2)#">
<cfoutput>
	<input name="#dbField#" type="text" size="#assocAttribs[ attribIndex ].size#" value="#dbFieldVal#" maxlength="#assocAttribs[ attribIndex ].maxlength#" onkeypress="ensureFloat(this);"<cfif cStyle NEQ ""> style="#cStyle#"</cfif><cfif minValue NEQ "null" OR maxValue NEQ "null"> onChange="inRange(this,#minValue#,#maxValue#);"</cfif> <cfif NOT assocAttribs[ #attribIndex# ].edit> onkeydown="return false;"<cfif cStyle EQ ""> style="color:##505050;"</cfif><cfelse> onkeydown="hasChanged()"</cfif>>
</cfoutput>