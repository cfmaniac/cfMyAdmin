<cfif NOT assocAttribs[ #attribIndex# ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>
<cfparam name="assocAttribs[ #attribIndex# ].size" default="30">
<cfparam name="assocAttribs[ #attribIndex# ].maxlength" default="#Evaluate(assocAttribs[ attribIndex ].size * 2)#">
<cfoutput>
	<input type="password" name="#dbField#" size="#assocAttribs[ attribIndex ].size#" maxlength="#assocAttribs[ attribIndex ].maxlength#" value="#dbFieldVal#"<cfif cStyle NEQ ""> style="#cStyle#"</cfif>  <cfif NOT assocAttribs[ #attribIndex# ].edit> onkeydown="return false;"<cfif cStyle EQ ""> style="color:##505050;"</cfif><cfelse> onkeydown="hasChanged()"</cfif>>
</cfoutput>