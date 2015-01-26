<cfif NOT assocAttribs[ #attribIndex# ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>
<cfoutput>
	<input type="Checkbox" name="#dbField#" <cfif cStyle NEQ ""> style="#cStyle#"</cfif><cfif dbFieldVal NEQ "0" AND dbFieldVal NEQ ""> checked</cfif> <cfif NOT assocAttribs[ #attribIndex# ].edit> onClick="return false"<cfelse> onClick="hasChanged()"</cfif>>
</cfoutput>