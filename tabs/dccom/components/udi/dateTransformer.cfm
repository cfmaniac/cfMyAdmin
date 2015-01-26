<!---
dateTransformer.cfm
Receives a date in dd/mm/yyyy format and converts it into the required format for display
--->
<cfsetting enablecfoutputonly="Yes">

<!--- Start Document --->
<cfoutput><html><body><script language="JavaScript1.2" defer></cfoutput>

	<cfparam name="FORM.d">
	<cfparam name="FORM.m">
	<cfparam name="FORM.y">
	<cfparam name="FORM.dateFormat">
	<cfparam name="FORM.resultField">

	<cfset theDate = CreateDate(FORM.y,FORM.m,FORM.d)>
	
	<cfoutput>
	parent.document.editForm.#resultField#.value = "#DateFormat(theDate,FORM.dateFormat)#";
	</cfoutput>
	
<!--- Close Document --->
<cfoutput></script></body></html></cfoutput>