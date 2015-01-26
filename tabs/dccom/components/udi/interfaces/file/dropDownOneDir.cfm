<!------------------------------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------
 
 	Application:	Any
	Project:		Any
	Filename:		dropDownOneDir.cfm
	Version:		1.0
	Programmers:	Peter Coppinger <peter@digital-crew.com>
					
	Purpose:		Given a directory pathm returns that path less 1 level.
					e.g. "this/is/a/path/" -> "this/is/a/"

	Usage:			<cf_dropDownOneDir dirVariable="[PATH]" [outDirVariable="[varName]"]>
	
	Description:	Returns the path without the last branch.
	
	CHANGE LOG:
	11 Feb 2001		Document created.


 ----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------>
<cfparam name="Attributes.dirVariable">
<cfif NOT isdefined("Attributes.outDirVariable")><cfset Attributes.outDirVariable = Attributes.dirVariable></cfif>

<cfset temp = Evaluate("caller."&Attributes.dirVariable)>
<cfset temp = reverse( temp )>

<cfif Find("\",temp)>
	<cfset slash="\">
<cfelse>
	<cfset slash="/">
</cfif>

<cfset slashPos = Find(slash, TEMP, 2)>

<cfif slashPos NEQ "0">
	<cfset temp = Right(temp, Len(temp) - slashPos + 1)>
<cfelse>
	<cfset temp = "">
</cfif>

<!--- return Escaped HTML --->
<cfscript>Evaluate( "Caller." & Attributes.outDirVariable & "= reverse(temp)" );</cfscript>
