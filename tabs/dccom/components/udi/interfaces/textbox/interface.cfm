<cfparam name="assocAttribs[ #attribIndex# ].maxlength" default="-1">
<cfif NOT assocAttribs[ #attribIndex# ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>
<cfparam name="assocAttribs[ #attribIndex# ].cols" default="40">
<cfparam name="assocAttribs[ #attribIndex# ].rows" default="4">
<cfparam name="assocAttribs[ #attribIndex# ].wrap" default="soft">
<cfoutput>
	<textarea name="#dbField#" cols="#assocAttribs[ attribIndex ].cols#" rows="#assocAttribs[ attribIndex ].rows#" wrap="#assocAttribs[ attribIndex ].wrap#"<cfif cStyle NEQ ""> style="#cStyle#"</cfif> <cfif NOT assocAttribs[ #attribIndex# ].edit> onkeydown="return false;"<cfif cStyle EQ ""> style="color:##505050;"</cfif><cfelse> onkeydown="hasChanged()"</cfif><cfif assocAttribs[ attribIndex ].maxlength GE 0> onkeypress="if(this.value.length>#assocAttribs[ attribIndex ].maxlength#) return false;"</cfif>>#dbFieldVal#</textarea>
</cfoutput>