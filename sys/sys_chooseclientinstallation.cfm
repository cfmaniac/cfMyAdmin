<cfdirectory action="list" name="getDir" directory="#GetDirectoryFromPath(GetCurrentTemplatePath())#..\i\">

<form name="zform" action="index.cfm" name="action" method="get">
<input type="hidden" name="flush" value="<cfoutput>#RandRange(1,99999)#</cfoutput>">
<table cellpadding=5 cellspacing=5 border=0 style="border:1px solid #303030" align=center>
<tr><td><b>Choose Installation</b></td>
<td>
<select name="setInstId" style="font-size:12px;font-family:arial;" onchange="zform.submit();">
<cfoutput query="getDir">
	<cfif Name NEQ "." AND Name NEQ "..">
		<option value="#Name#"<cfif Name EQ APPLICATION.instId> selected</cfif>>#Name#</option>
	</cfif>
</cfoutput>
</select>
</td></tr>
</table>
</form>