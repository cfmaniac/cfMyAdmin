<cfparam name="ATTRIBUTES.file">
<cffile action="READ" file="#ATTRIBUTES.file#" variable="theFile">
<CFSET NEWLINE = chr(13) & chr(10)>
<cfloop index="line" list="#theFile#" delimiters=";">
	<cfset equalsPos = Find("=",line)>
	<cfif equalsPos NEQ 0>
		<cfset varname = LTrim(RTrim(Left(line,equalsPos-1)))>
		<cfset varvalue = LTrim(RTrim(Right(line,Len(line)-equalsPos)))>
		<cfscript>Evaluate("CALLER."&varname&"="&replace(varvalue,"[semi]",";","ALL"));</cfscript>
	</cfif>
</cfloop> 