<cfset ISDEF_dateNum=ISDEF_dateNum+1>
<cfparam name="assocAttribs[ attribIndex ].dateFormat" default="dd mmmm yyyy">
<cfparam name="assocAttribs[ #attribIndex# ].default" default="">
<cfif assocAttribs[ attribIndex ].default EQ "">
	<cfscript>Evaluate("assocAttribs[ #attribIndex# ].default = ""#now()#""");</cfscript>
<cfelseif NOT IsDate(assocAttribs[attribIndex].default)>
	<cfif ListLen(assocAttribs[ attribIndex ].default,"/") NEQ 3>
		<cfthrow type="custom" message="Default Date Must be In dd/mm/yyyy format.">
	</cfif>
	<cfset d = ListGetAt(assocAttribs[ attribIndex ].default,1,"/")>
	<cfset m = ListGetAt(assocAttribs[ attribIndex ].default,2,"/")>
	<cfset y = ListGetAt(assocAttribs[ attribIndex ].default,3,"/")>
	<cfset assocAttribs[ attribIndex ].default = createDateTime(y,m,d,0,0,0)>	
</cfif>
<cfset d = DateFormat(assocAttribs[attribIndex].default,"d")>
<cfset m = DateFormat(assocAttribs[attribIndex].default,"m")>
<cfset y = DateFormat(assocAttribs[attribIndex].default,"yyyy")>
<cfset hours = TimeFormat(assocAttribs[attribIndex].default,"HH")>
<cfset mins = TimeFormat(assocAttribs[attribIndex].default,"mm")>
<cfoutput>
#assocAttribs[ attribIndex ].field#.value="#d#/#m#/#y#";
datePart_d#ISDEF_dateNum#.value="#d#";
datePart_m#ISDEF_dateNum#.value="#m#";
datePart_y#ISDEF_dateNum#.value="#y#";
<cfif assocAttribs[ attribIndex ].type EQ "datetime">
dateHours#ISDEF_dateNum#.value="#hours#";
dateMins#ISDEF_dateNum#.value="#mins#";
</cfif>	
dateDisp#ISDEF_dateNum#.value="#DateFormat(assocAttribs[attribIndex].default,assocAttribs[attribIndex].dateFormat)#";
</cfoutput>