<cfparam name="ATTRIBUTES.errorTitle" default="Error Updating Database">
<cfparam name="ATTRIBUTES.writeHTMLTag" default="yes">
<cfparam name="ATTRIBUTES.abort" default="yes">
<cfset NEWLINE = chr(13) & chr(10)>
<cfset errMsgDetail = REReplaceNoCase( CALLER.cfcatch.detail, "\[[^>]*\]", "", "ALL" )>
<cfoutput>
<cfif ATTRIBUTES.writeHTMLTag><html><head></cfif>
<script>
alert( "#JSStringFormat(ATTRIBUTES.errorTitle)#\n\n#JSStringFormat( replaceNoCase( errMsgDetail ,"<P>",NEWLINE,"ALL") )#");
</script>
<cfif ATTRIBUTES.writeHTMLTag></body></html></cfif>
</cfoutput>
<cfif ATTRIBUTES.abort><cfabort></cfif>
