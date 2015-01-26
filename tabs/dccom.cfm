<!------------------------------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------
 
Application:	Any
Project:		Any
Filename:		dcCom.cfm
Programmers:	Peter Coppinger <peter@digital-crew.com>

Description:	Interface to invoke a dccom component.
				Syntax: <cf_DCCOM component="[COMPONENT NAME]" [...x=y...]>
				
CHANGE LOG:
24 Feb 2002		PC - Document created.
07 May 2002		PC - Optimised
23 Jun 2002		PC - Optimised and Improved, Fix Minor Bug with Sub Attributes

 ----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------>
<cfsetting enablecfoutputonly="Yes">

<!--- If ATTRIBUTES.dcCom_filePath is not defined then check if the application level
	variable is set for the current directory, if not then search backwards through
	the directories until we find the dcCom folder and then assign that to both
	the required ATTRIBUTES.dcCom_filePath and the application scope so that it won't
	have to be looked up next time --->
<cfif NOT isDefined("attributes.dcCom_filePath")>
	<cfset dcCom_callerdir = GetDirectoryFromPath(GetCurrentTemplatePath())>
	<cfset dcCom_dirHash = Hash(dcCom_callerdir)>
	<cfset dcCom_DirFilePathVar = "APPLICATION.dcCom_" & dcCom_dirHash & "_filepath">
	
	<cfif isdefined("#dcCom_DirFilePathVar#")>
		<!--- Assigned the pre-existing APPLICATION level path information to the required path attributes --->
		<cfset ATTRIBUTES.dcCom_filePath = Evaluate(dcCom_DirFilePathVar)>
	<cfelse>
		<!--- Now find the relative file path if it is different to that startPath --->
		<cfset startFilePath = GetDirectoryFromPath(GetCurrentTemplatePath())>
		<!--- Drop ending "\" because this will be treated as list --->
		<cfset searchFilePath = Left(dcCom_callerdir, Len(dcCom_callerdir)-1)>
		<!--- Search this and all parent directories for the dcCom directory --->
		<cfset foundDir = false><cfset ATTRIBUTES.dcCom_filePath = "">
		<cfloop condition="foundDir EQ false AND ListLen(searchFilePath,'\') GT 0">
			<cfif DirectoryExists(searchFilePath & "\dcCom\components\")>
				<cfset foundDir = true>
				<cfset ATTRIBUTES.dcCom_filePath = ATTRIBUTES.dcCom_filePath & "dcCom/">
				<cfscript>Evaluate(dcCom_DirFilePathVar & " = ATTRIBUTES.dcCom_filePath" );</cfscript>
			<cfelse>
				<!--- move the relative path up one for next loop match search --->
				<cfset ATTRIBUTES.dcCom_filePath = "../" & ATTRIBUTES.dcCom_filePath>
			</cfif>
			<!--- Remove last directory from the directory list --->
			<cfset searchFilePath = ListDeleteAt(searchFilePath, ListLen(searchFilePath,"\"), "\")>
		</cfloop>
		<!--- Check for error finding the dcCom directory --->
		<cfif foundDir EQ false>
			<cfoutput>
			</TD></TD></TD></TH></TH></TH></TR></TR></TR></TABLE></TABLE></TABLE></A></ABBREV></ACRONYM></ADDRESS></APPLET></AU></B></BANNER></BIG></BLINK></BLOCKQUOTE></BQ></CAPTION></CENTER></CITE></CODE></COMMENT></DEL></DFN></DIR></DIV></DL></EM></FIG></FN></FONT></FORM></FRAME></FRAMESET></H1></H2></H3></H4></H5></H6></HEAD></I></INS></KBD></LISTING></MAP></MARQUEE></MENU></MULTICOL></NOBR></NOFRAMES></NOSCRIPT></NOTE></OL></P></PARAM></PERSON></PLAINTEXT></PRE></Q></S></SAMP></SCRIPT></SELECT></SMALL></STRIKE></STRONG></SUB></SUP></TABLE></TD></TEXTAREA></TH></TITLE></TR></TT></U></UL></VAR></WBR></XMP>
			<h3><cfif isdefined("ATTRIBUTES.component")>#ATTRIBUTES.component# </cfif>Error!</h3>
			<p>
				<b>Could not find relative file path to dcCom directory.</b><br><br>
				Please ensure that the dcCom folder is place in the same or a URL accessable<br>
				parent directory of "#CGI.path_info#".				
			</p>
			</cfoutput>
			<cfabort>
		</cfif>
	</cfif>
	
</cfif>



<cfif NOT isdefined("ATTRIBUTES.dcCom_RelPath") AND isdefined("ATTRIBUTES.component")>
	<cfif isdefined("APPLICATION.dcCom_RelPath")>
		<cfset ATTRIBUTES.dcCom_RelPath = APPLICATION.dcCom_RelPath>
	<cfelse>
		<cfif NOT isdefined("dcCom_callerdir")>
			<cfset dcCom_callerdir = GetDirectoryFromPath(GetCurrentTemplatePath())>
			<cfset dcCom_dirHash = Hash(dcCom_callerdir)>
		</cfif>
		
		<cfset dcCom_DirRelPathVar = "APPLICATION.dcCom_" & dcCom_dirHash & "_relpath">
	
		<cfif isdefined("#dcCom_DirRelPathVar#")>
			<cfset ATTRIBUTES.dcCom_RelPath = Evaluate(dcCom_DirRelPathVar)>
		<cfelse>
			<!--- Calculate the relative URL path to the dcCom directory --->
			<cfset startURLPath = GetDirectoryFromPath(GetBaseTemplatePath())>
			<!--- Drop ending "\" because this will be treated as list --->
			<cfset searchURLPath = Left(startURLPath, Len(startURLPath)-1)>
			<!--- Search this and all parent directories for the dcCom directory --->
			<cfset foundDir = false><cfset ATTRIBUTES.dcCom_RelPath = "">
			<cfloop condition="foundDir EQ false AND ListLen(searchURLPath,'\') GT 0">
				<cfif DirectoryExists(searchURLPath & "\dcCom\components\")>
					<cfset foundDir = true>
					<cfset ATTRIBUTES.dcCom_RelPath = ATTRIBUTES.dcCom_RelPath & "dcCom/">
					<cfscript>Evaluate(dcCom_DirRelPathVar & " = ATTRIBUTES.dcCom_RelPath" );</cfscript>
				<cfelse>
					<!--- move the relative path up one for next loop match search --->
					<cfset ATTRIBUTES.dcCom_RelPath = "../" & ATTRIBUTES.dcCom_RelPath>
				</cfif>
				
				<!--- Remove last directory from the directory list --->
				<cfset searchURLPath = ListDeleteAt(searchURLPath, ListLen(searchURLPath,"\"), "\")>
			</cfloop>
			<!--- Check for error finding the dcCom directory --->
			<cfif foundDir EQ false>
				<cfoutput>
				</TD></TD></TD></TH></TH></TH></TR></TR></TR></TABLE></TABLE></TABLE></A></ABBREV></ACRONYM></ADDRESS></APPLET></AU></B></BANNER></BIG></BLINK></BLOCKQUOTE></BQ></CAPTION></CENTER></CITE></CODE></COMMENT></DEL></DFN></DIR></DIV></DL></EM></FIG></FN></FONT></FORM></FRAME></FRAMESET></H1></H2></H3></H4></H5></H6></HEAD></I></INS></KBD></LISTING></MAP></MARQUEE></MENU></MULTICOL></NOBR></NOFRAMES></NOSCRIPT></NOTE></OL></P></PARAM></PERSON></PLAINTEXT></PRE></Q></S></SAMP></SCRIPT></SELECT></SMALL></STRIKE></STRONG></SUB></SUP></TABLE></TD></TEXTAREA></TH></TITLE></TR></TT></U></UL></VAR></WBR></XMP>
				<h3><cfif isdefined("ATTRIBUTES.component")>#ATTRIBUTES.component# </cfif>Error!</h3>
				<p>
					<b>Could not find relative URL path to dcCom directory.</b><br><br>
					Please ensure that the dcCom folder is place in the same or a URL accessable<br>
					parent directory of "#CGI.path_info#".				
				</p>
				</cfoutput>
				<cfabort>
			</cfif>
		</cfif>
	</cfif>
</cfif>




<cfparam name="ATTRIBUTES.comstyle" default="default"><!--- default comstyle is (of course) "default" --->


<cfif NOT isdefined("ATTRIBUTES.component")>
	<!--- Its a parameter, pass along data and exit --->
	<CFIF ThisTag.ExecutionMode IS "Start">
		<CFASSOCIATE BASETAG="CF_DCCOM">
	</cfif>
<cfelse>
	<!--- EXECUTE THE TAG! --->
	<cftry>
		<cfinclude template="#ATTRIBUTES.dcCom_filePath#/engine/setup.cfm">
		<cfcatch type="MissingInclude">
			<cfoutput>
			</TD></TD></TD></TH></TH></TH></TR></TR></TR></TABLE></TABLE></TABLE></A></ABBREV></ACRONYM></ADDRESS></APPLET></AU></B></BANNER></BIG></BLINK></BLOCKQUOTE></BQ></CAPTION></CENTER></CITE></CODE></COMMENT></DEL></DFN></DIR></DIV></DL></EM></FIG></FN></FONT></FORM></FRAME></FRAMESET></H1></H2></H3></H4></H5></H6></HEAD></I></INS></KBD></LISTING></MAP></MARQUEE></MENU></MULTICOL></NOBR></NOFRAMES></NOSCRIPT></NOTE></OL></P></PARAM></PERSON></PLAINTEXT></PRE></Q></S></SAMP></SCRIPT></SELECT></SMALL></STRIKE></STRONG></SUB></SUP></TABLE></TD></TEXTAREA></TH></TITLE></TR></TT></U></UL></VAR></WBR></XMP>
			<h3>#ATTRIBUTES.component# Error!</h3>
			<p>
				<b>Path to dcComponent Directory is Incorrect.</b><br><br>
				Attempted path to dcComponents directory was "#Replace(ATTRIBUTES.dcCom_filePath,"/","\","ALL")#".
			</p>
			</cfoutput>
			<cfabort>
		</cfcatch>
	</cftry>
	<cfinclude template="#ATTRIBUTES.dcCom_filePath#/engine/exec.cfm">
</cfif>


<cfsetting enablecfoutputonly="No">

