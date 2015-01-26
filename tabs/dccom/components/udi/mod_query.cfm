<CFIF ThisTag.ExecutionMode IS "End">

	<cfparam name="ATTRIBUTES.maxrows" default="999999">
	<cfif isdefined("CALLER.ATTRIBUTES.connectString")>
	
		<cfinclude template="connectstring.cfm">

	<cfelse>
	
		<cfquery name="CALLER.#ATTRIBUTES.queryname#" datasource="#CALLER.ATTRIBUTES.datasource#" username="#CALLER.ATTRIBUTES.username#" password="#CALLER.ATTRIBUTES.password#" maxrows="#ATTRIBUTES.maxrows#">
		#PreserveSingleQuotes(thisTag.generatedContent)#
		</cfquery>

	</cfif>
	
	<cfset thisTag.generatedContent = "">

</cfif>
