<!--- Set default attributes --->
<cfparam name="ATTRIBUTES.pageName" default="">
<cfparam name="ATTRIBUTES.securePage" default="no">
<cfparam name="ATTRIBUTES.dcFader" default="no">
<cfparam name="ATTRIBUTES.securityLevel" default="none">
<cfparam name="ATTRIBUTES.HTMLHeader" default="yes">
<cfparam name="ATTRIBUTES.layoutHeader" default="yes">
<cfparam name="ATTRIBUTES.showMessages" default="yes">
<cfparam name="ATTRIBUTES.forceFrames" default="yes">
<cfparam name="ATTRIBUTES.basehref" default="#APPLICATION.IntranetURL#">
<cfparam name="ATTRIBUTES.compactHTML" default="no">
<cfparam name="ATTRIBUTES.rollover" default="yes">
<cfparam name="ATTRIBUTES.dtree" default="no">

<cfif thisTag.executionMode IS "Start">

	<!--- Page View Security Check --->
	<cf_testUserSecurity level="#ATTRIBUTES.securityLevel#">

	<!--- Return the page name to the outer scope so that it can be used --->
	<cfset CALLER.pageName = ATTRIBUTES.pageName>
	
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<cfif ATTRIBUTES.HTMLHeader>
		<!--- Display the header --->
		<cfinclude template="..\templates\inc_html_header.cfm">
		<!--- Display the optional Page Layout Header, if any --->
		<cfif ATTRIBUTES.layoutHeader>
			<cfinclude template="..\templates\inc_layout_header.cfm">
		</cfif>
	</cfif>
	
	<!--- DISPLAY MESSAGE (if any) --->
	<cfif ATTRIBUTES.showMessages AND isdefined("CALLER.message")>
		<cfparam name="CALLER.messageTitle" default="">
		<cfmodule template="modules\dspdisplaymessage.cfm" message="#CALLER.message#" messageTitle="#CALLER.messageTitle#">
	</cfif>
	
<!--------------------------------------------------------->
<cfelse><!--------------------------------------------------------->
<!--------------------------------------------------------->
	<cfif ATTRIBUTES.HTMLHeader>
		<!--- Display the optional Page Layout Footer, if any --->
		<cfif ATTRIBUTES.layoutHeader>
			<cfinclude template="..\templates\inc_layout_footer.cfm">
		</cfif>
		<!--- Display the closing HTML --->
		<cfinclude template="..\templates\inc_html_footer.cfm">
	</cfif>
	
	<!--- If stripWhitespace is enable, then do it --->
	<cfif ATTRIBUTES.compactHTML>
		<!--- Remove comments at this stage --->
		<!--- UNNESSARY! <cfset thisTag.generatedContent = REReplaceNoCase(thisTag.generatedContent,"<!-[^-]*(-[^-<]*)*->","","ALL")> --->
		<!--- Remove JavaScript style comments --->
		<cfset thisTag.generatedContent = REReplaceNoCase(thisTag.generatedContent,"(http|ftp)://","\1:\\","ALL")>
		<cfset thisTag.generatedContent = REReplaceNoCase(thisTag.generatedContent,"//[^#chr(10)#]*#chr(10)#","","ALL")>
		<cfset thisTag.generatedContent = REReplaceNoCase(thisTag.generatedContent,"(http|ftp):\\\\","\1://","ALL")>
		<!--- Remove Newlines, Carriage Returns and Tabs --->
		<cfset thisTag.generatedContent = rereplace(thisTag.generatedContent, "[#chr(10)##chr(13)##chr(9)# ]*[#chr(10)##chr(13)#][#chr(10)##chr(13)##chr(9)# ]+","","ALL")>
		<!--- Remove any whitespace between tags --->
		<cfset thisTag.generatedContent = ReReplace(thisTag.generatedContent,">[ ]+<","><","ALL")>
	</cfif>
	
	<CFSETTING ENABLECFOUTPUTONLY="Yes">
</cfif>