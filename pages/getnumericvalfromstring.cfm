<cfsetting enablecfoutputonly="Yes">
<cfparam name="ATTRIBUTES.string">
<cfparam name="ATTRIBUTES.output">
<cfparam name="ATTRIBUTES.mode" default="getFirstNumber">
<cfset keepGoing = 1><cfset num = 0><cfset i = 1>
<cfloop condition="keepGoing AND i LTE #Len(ATTRIBUTES.string)#">
	<cfset char = asc(Mid(ATTRIBUTES.string,i,1))>
	<cfif char GTE 48 AND char LTE 57>
		<cfset num = num * 10>
		<cfset num = num + ( char - 48 )>
	<cfelseif ATTRIBUTES.mode EQ "getFirstNumber" AND num GT 0>
		<cfset keepGoing = 0>
	</cfif>
	<cfset i = i + 1>
</cfloop>
<cfscript>Evaluate("CALLER." & ATTRIBUTES.output & "=num");</cfscript>
<cfsetting enablecfoutputonly="No">
