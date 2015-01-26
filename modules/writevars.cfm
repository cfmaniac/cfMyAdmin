<cfparam name="ATTRIBUTES.file">
<cfparam name="ATTRIBUTES.vars">
<cfset file = "">
<CFSET NEWLINE = chr(10)>
<cfloop index="var" list="#ATTRIBUTES.vars#">
	<cfset var = LTrim(RTrim(var))>
	<cfset value = Evaluate("CALLER.#var#")>
	<cfset file = file & replace(var&" = """&value,";","[semi]","ALL") & """;" & NEWLINE>
</cfloop>
<cffile action="WRITE" file="#ATTRIBUTES.file#" output="#file#">
 