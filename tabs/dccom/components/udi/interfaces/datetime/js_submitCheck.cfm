<cfparam name="ISDEF_dateSC" default="0">
<cfset ISDEF_dateSC = ISDEF_dateSC + 1>
if(document.editForm.dateHours<cfoutput>#ISDEF_dateSC#</cfoutput>.value=="" || document.editForm.dateMins<cfoutput>#ISDEF_dateSC#</cfoutput>.value=="")errTxt+="\nThis time setting for '<cfoutput>#JSStringFormat(assocAttribs[ attribIndex ].display)#</cfoutput>' must contain a valid time.";