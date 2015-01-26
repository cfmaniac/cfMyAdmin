<cfsetting enablecfoutputonly="Yes">

<!--- START: LOAD ALL ATTRIBUTE DATA FOR RE-LOAD IN IFRAME PAGES --->

	<cfparam name="ref">

	<!--- Check that the session hasn't time out --->
	<cfif NOT isdefined("SESSION.dcDBEditor_#ref#")>
		<cfoutput>
		<html><head><title>Error</title><style>body{font:8pt verdana;}</style></head><body>Session has timed out.<script>alert("Session has timed out. Please log in again.");</script></body></html>
		</cfoutput>
		<cfabort>
	</cfif>

	<cfset collectionName = "SESSION.dcDBEditor_#ref#">
	<cfset ATTRIBUTES = evaluate("#collectionName#[1]")>
	<cfset ASSOCATTRIBS = evaluate("#collectionName#[2]")>
	
<!--- END: LOAD ALL ATTRIBUTE DATA --->

<!--- Conversion of expected attributes to LOWERCASECASE --->
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfset assocAttribs[i].type = LCASE(assocAttribs[i].type)>
</cfloop>


<cfsetting enablecfoutputonly="No">
