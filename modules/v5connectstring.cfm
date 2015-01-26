<cfif attributes.connectString eq "">
	
	<script>parent.top.document.frames[1].document.location="../templates/workwindow.cfm?message=Your session has ended";</script>
	
<cfelse>

	<cfquery name="#ATTRIBUTES.queryname#" dbtype="Dynamic" connectstring="#ATTRIBUTES.connectString#">
	#PreserveSingleQuotes(thisTag.generatedContent)#
	</cfquery>

</cfif>

	
