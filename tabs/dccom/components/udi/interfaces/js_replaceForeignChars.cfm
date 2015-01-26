<!--- Remove any foreign chars if requested --->
<cfparam name="assocAttribs[#attribIndex#].recodeForeignChars" default="no">
<cfif assocAttribs[attribIndex].recodeForeignChars>
	<cfif NOT isdefined("ISSET_charcodeListToReplace")>
		<cfoutput>var charCodeList = new Array(260,262,280,321,323,211,346,377,379,261,263,281,322,324,243,347,378,380);</cfoutput>
		<cfset ISSET_charcodeListToReplace = 1>
	</cfif>
	<cfoutput>
	for(i=0;i<charCodeList.length;i++)
	{
		var replaceMe = String.fromCharCode(charCodeList[i]);
		var re = new RegExp (replaceMe, 'g') ;
		#assocAttribs[ attribIndex ].field#.value = #assocAttribs[ attribIndex ].field#.value.replace(re, '&##' + charCodeList[i] + ';');
	}
	</cfoutput>
</cfif>