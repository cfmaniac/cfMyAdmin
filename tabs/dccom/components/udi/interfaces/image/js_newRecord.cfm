<cfset imageNum = imageNum + 1>
<cfoutput>#assocAttribs[ attribIndex ].field#</cfoutput>.value="<cfoutput>#assocAttribs[ attribIndex ].default#</cfoutput>";
<cfparam name="assocAttribs[ attribIndex ].previewImage" default="0">
<cfparam name="assocAttribs[ attribIndex ].default" default="">
<cfparam name="assocAttribs[ attribIndex ].URLPath" default="">
<cfif assocAttribs[ attribIndex ].previewImage>
	document.getElementById("imgPrev<cfoutput>#assocAttribs[ attribIndex ].field#")</cfoutput>.src="<cfif assocAttribs[ attribIndex ].default NEQ ""><cfoutput>#assocAttribs[ attribIndex ].URLPath##assocAttribs[ attribIndex ].default#</cfoutput><cfelse>spacer.gif</cfif>";
</cfif>