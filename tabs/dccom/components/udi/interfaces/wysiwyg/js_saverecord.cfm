<cfparam name="htmlNum" default="0">
<cfset htmlNum = htmlNum + 1>

<cfoutput>#assocAttribs[ attribIndex ].field#</cfoutput>.value=<cfoutput>document.idEdit#htmlNum#.document.body.innerHTML;</cfoutput>

<!--- Remove any foreign chars if requested --->
<cfparam name="assocAttribs[#attribIndex#].recodeForeignChars" default="no">
<cfif assocAttribs[attribIndex].recodeForeignChars>
<cfoutput>
var charCodeList = new Array(260,262,280,321,323,211,346,377,379,261,263,281,322,324,243,347,378,380);
for(i=0;i<charCodeList.length;i++)
{
	var replaceMe = String.fromCharCode(charCodeList[i]);
	var re = new RegExp (replaceMe, 'g') ;
	#assocAttribs[ attribIndex ].field#.value = #assocAttribs[ attribIndex ].field#.value.replace(re, '&##' + charCodeList[i] + ';');
}
</cfoutput>
</cfif>