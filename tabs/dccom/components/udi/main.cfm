<!------------------------------------------------------------------------------------------------
Component:            UDI
Programmers:          Peter Coppinger <peter@digital-crew.com> aka Topper
Version:              3.9
Ending Tag:           Required
Styleable?:           No
dcCom Dependencies:   Requires dcSelectImage
Browser Specific:     Yes. MS Internet Explorer 4.5+ Only
Copyright:            Copyright (c) 2002 by Peter Coppinger, Digital Crew
Purpose:			  Provides Interface to Edit Database Table Online

ChangeLog:
10 Sept 2002	PC - Built dcCom component framework.
20 Sept 2002	PC - Started interface about this time
01 August 2002	PC - Added Super WYSIWYG support.
13 August 2002	PC - Fixed Super Bug that occurs when innerHTML of editing div is blank
18 Sept 2000	PC - Fixed Javascript bug on disabled select
23 Oct 2002		PC - Fixed Delete On Selected Record Bug
01 Nov 2002		PC - Added More Advanced Extra Work Including Support Before Or After Update
						Added border size option to image preview. eg. border="1"
05 Nov 2002		PC - Fixed dcSelectImage bug. dcSelectImage function would only be defined if
				there was an image select element - however the wysiwyg will always need this too.
				PC - Fixed problem with .htc file not loading when base href is passed to wysiwyg
				PC - Selected new images now enables the save button
06 Nov 2002		PC - Fixed bug in include before/on insert. Added include before/on delete.
21 Nov 2002		PC - Fixed bug in SqlWhereClause where strings are used. PreserveSingleQuotes(sql)
				fixed it.
25 Nov 2002		PC - Fixed relative path calling to sub dcCom component, ATTRIBUTES.dcCom_RelPath is
				of course already calculated in the component so when calling a sub component
				we should pass the new relative path  dcCom_RelPath="../../".
27 Nov 2002		PC - Added date and datetime support.
15 Jan 2003		PC - Added basic detection of database type, mySQL, MSSQL and ACCESS.
				MySQL needs back slashes escaped! On update, a test is performed to determine the
				database type. If it is determined that the database is mySQL, slashes are escaped.
27 Jan 2003		PC - Added support for saveAlert - will popup a prompt asking the user if he wants to save.
				Added browser detection code - the following are now defined:
				ATTRIBUTES.browserdata="#browserdata#";
				ATTRIBUTES.MozillaVersion="#MozillaVersion#";
				ATTRIBUTES.BrowserName="#BrowserName#";
				ATTRIBUTES.BrowserVersion="#BrowserVersion#";
				ATTRIBUTES.Platform="#Platform#";
				ATTRIBUTES.CssFriendly="#CssFriendly#";
				ATTRIBUTES.DhtmlFriendly="#DhtmlFriendly#";
				ATTRIBUTES.XmlFriendly="#XmlFriendly#";
				ATTRIBUTES.JavaFriendly="#JavaFriendly#";
				ATTRIBUTES.JavaScriptFriendly="#JavaScriptFriendly#";
				ATTRIBUTES.JSVersion="#JSVersion#";
				ATTRIBUTES.EcmaCompliant="#EcmaCompliant#";
27 Jan 2003		PC - Fixed a minor onload bug, init() wasn't being called to gray the save button when
				the WYSIWYG is in use bacause the WYSIWYG overwrites the body onload. Simply added init()
				to the WYSIWYG's initEditor() method to fix.
04 Feb 2003		PC - Modified frame resizing code for onSelect to not give JS error in IE5.0
05 Feb 2003		PC - Fixed minor bug with components misusage of ATTRIBUTES.maxShortItems.
06 Feb 2003		PC - Fixed bug in reportingIn feedback routine - application.applicationname may NOT be
				always defined, will now send "NONE" instead, also submits 1st and on every _200_ request
				instead of 100.
26 Mar 2003		PC - Added support for multiple selection on select_text.
27 Mar 2003		PC - Added support for key_text - text primary keys instead of autonumber
28 Mar 2003		PC - Save button now disables after insert so there will be no save-warning alert after insert-and-exit
				PC - Save button now disabled after save too!
23 Jun 2003		PC - So many improvements you wouldn't believe
					Added UDI Wizard, key_UUID support , improved everything, search, pagination
08 July 2003	PC - Fixed Query Lookup bug with comma used as delimitor after ValueList() changes delimitor to "|~".
04 Aug  2003	PC - Added monthfirst support for date and datetime interface
				PC - Added startBlank option
				PC - Added Oracle Support (as yet untested)
25 Nov 2003		PC - Added advanced licensing support - linkage with CFTagStore.com
08 Dec 2003		PC - Added File Select Support
17 Dec 2003		PC - Added "note" attribute - displays a note under a field's name on the edit form
20 Dec 2003		PC - Fixed bug with listall="yes"
22 Dec 2003		PC - Dumped text size from drop downs
					Added WYSIWYG deleting of absolute paths
					Fixed bug with defaultFrameSetting - was cfset not cfparam for overriding
22 Jan 2004		PC - Added automatic conversion of some symbols such as € to code "&euro;" for text, textbox and wysiwyg.
				Symbols converted are: $αινσϊ
				PC - Added full support for MX - scalar problems fixed
29 Jan 2004		PC - Fixed another MX related bug in update.cfm when re-looking up dropdown querys
				PC - Fixed another MX bug with file preview/download - can't use varible called "file" - reserved
02 Feb 2004		PC - Added recodeForeignChars option to WYSIWYG editor to support foreign language chars with charactor codes
				By default recodeForeignChars="no".
09 Feb 2004		PC - Added Polish character support - conversion done on client side by build chars in mem from their codes.
16 Feb 2004		PC - Fixed bug with serialozeAttributes.cfm error report message uid -> attributes.uid
20 Feb 2004		PC - Fixed bug with date mask after update
05 Apr 2004		PC - Added support for connect strings instead of DB connections
--->
<CFIF ThisTag.ExecutionMode IS "Start">
<CFELSEIF ThisTag.ExecutionMode IS "End">

<!--- Perform URL Variable Passing Security Test --->
<cfinclude template="../../engine/urlsecurity.cfm">


<!--- Get information about the users browser --->
<cfinclude template="getBrowserInfo.cfm">
		
<!--- Now with a version number --->
<cfparam name="ATTRIBUTES.version" default="3.8">
<cfparam name="ATTRIBUTES.releaseDate" default="#CreateDate(2003,12,22)#">

<!--- START: License checking --->
<cfif NOT isdefined("SESSION.connectString") OR NOT isdefined("SESSION.dbuser")>
<cfif Find(".",cgi.server_name) AND cgi.server_name NEQ "localhost" AND cgi.server_name IS NOT "127.0.0.1">

	<cftry>
		
		<cfset lic_FileName = "UDI.lic">
		<cfif fileExists("#GetDirectoryFromPath(getCurrentTemplatePath())#..\..\licenses\"&lic_FileName)>
		
			<cffile action="READ" file="#licFile#" variable="license">
			<cfset license = Decrypt(license,"^dc%LIC*")>
			<cfset lic_protocol = ListGetAt(license,1)>
			<cfset lic_licType = ListGetAt(license,2)>
			<cfset lic_component = ListGetAt(license,3)>
			<cfset lic_info = ListGetAt(license,4)>
			<cfset lic_checksum = ListGetAt(license,5)>
			<cfset lic_urlpath = urlpath>
			
			<!--- Build and add checksum --->
			<cfset lic_checkSum2 = 0>
			<cfloop from="1" to="#Evaluate(Len(license)-(Len(lic_checksum)))#" index="i">
				<cfset lic_checkSum2 = lic_checkSum2 + Asc( Mid( license, i, 1 ) )>
			</cfloop>
			
			<cfif lic_checksum IS NOT lic_checksum2>
				<cfthrow type="INVALIDLICFILE" message="Invalid Licence File - checksums don't match">
			</cfif>
			
			<!--- Test for licence match --->
			<cfif lic_component NEQ Hash(component)>
				<cfthrow type="INVALIDLICFILE" message="Invalid Licence File - component name is incorrect (#lic_component#) (#component#)">
			</cfif>
			
			<!--- Test for server match ---> 
			<cfif lic_licType IS "S">
				<!--- If a server is something like sys.site.com, we want to dump the sys part --->
				<cfif ListLen(lic_urlpath,".") GT 2>
					<cfset lic_urlpath = Right( lic_urlpath, Len(lic_urlpath) - ( Len( ListGetAt(lic_urlpath,1,".") ) + 1) )>
				</cfif>
				<cfset lic_urlpath = Hash(lic_urlpath)>
				<cfif Find(lic_urlpath,lic_info) IS 0>
					<cfthrow type="INVALIDLICFILE" message="Invalid Licence File (#lic_urlpath#) (#lic_info#)">
				</cfif>
			<!--- Test for Website match --->
			<cfelse>
				<cfset lic_urlpath = Hash(lic_urlpath)>
				<cfif lic_info NEQ lic_urlpath>
					<cfthrow type="INVALIDLICFILE" message="Invalid Licence File (#lic_info#) (#lic_urlpath#)">
				</cfif>
			</cfif>
			
			<cfoutput><div><h5 style="color:green;">VALID LICENCE</h5></div></cfoutput>
	
		<cfelse>		
		
			<!--- Remote licensing lookup --->
			<cfset tagId = "11">
			<cfset componentName = ATTRIBUTES.component & " Version " & ATTRIBUTES.version>
			<cfset checkLicenseEvery = 200>
			<cfset cvar = "lic"&Hash(componentName)>
			<cfif NOT isdefined("APPLICATION.#cvar#")><cflock scope="APPLICATION" timeout="1"><cfscript>evaluate("APPLICATION.#cvar# = 1");</cfscript></cflock></cfif>
			<cfif evaluate("APPLICATION.#cvar#") mod checkLicenseEvery EQ 1>
				<cfhttp url="http://www.cftagstore.com/webservice/checkLicense.cfm" method="post" throwonerror="Yes" timeout="1">
					<cfhttpparam name="server" type="FORMFIELD" value="#cgi.server_name#">
					<cfhttpparam name="tagid" type="FORMFIELD" value="#tagId#">
					<cfhttpparam name="CFServer" type="FORMFIELD" value="#server.ColdFusion.ProductName# #server.ColdFusion.ProductLevel# #server.ColdFusion.ProductVersion#">
					<cfhttpparam name="OS" type="FORMFIELD" value="#server.OS.Name# #server.OS.Version#">
				    <cfif isdefined("APPLICATION.APPLICATIONNAME")><cfhttpparam name="AppName" type="FORMFIELD" value="#APPLICATION.APPLICATIONNAME#"><cfelse><cfhttpparam name="AppName" type="FORMFIELD" value="NONE"></cfif>
				</cfhttp>
				<cfif cfhttp.fileContent EQ "Y">
					<cflock scope="APPLICATION" timeout="100"><cfscript>evaluate("APPLICATION.#cvar# = APPLICATION.#cvar# + 1");</cfscript></cflock>
				<cfelse>
					<cfthrow type="INVALIDLICFILE" message="Invalid Licence - not registered with central server">
				</cfif>
			</cfif>
	
		</cfif>

		<cfcatch type="INVALIDLICFILE">
			<cfoutput></SCRIPT></SELECT></TEXTAREA></DIV>
			<html><head><body><div style="font:10pt sans-serif;position:absolute;left:30px;top:20px;border:1px solid black;background-color:white;padding:10px;width:450px;color:black;">
			<h3>Unregistered Tag/Component Detected</h3>
			<p><strong>#componentName#</strong> requires a licence to be purchased to allow its use on "<i>#cgi.server_name#</i>".</p>
			<ul>
				<li>You can purchase a license for "#componentName#" online at <a href="http://www.cftagstore.com/" target=_blank>www.cftagstore.com</a>
				<li>If you have already purchased a licence, you may have forgot to register your license using the CFTagStore.com license manager available on your <a href="http://www.cftagstore.com/index.cfm/page/myaccount" target=_blank>account management page</a>.
			</ul>
			<p>Note:<br>The licensing mechanism employed in the tag/component places little overhead on your server. It occasionally connects to the CFTagStore.com server to verify it is licensed when it detects that a tag/component is been used commercially. For more information on how this works, please email security@cftagstore.com</p>
		
				<div><h5 style="color:red;">INVALID LICENCE</h5>
				#cfcatch.message#
			</div></body></head></html></cfoutput><cfabort>
		</cfcatch>
		<cfcatch></cfcatch>
		
	</cftry>	

</cfif>
</cfif>
	
	<cfif isdefined("ATTRIBUTES.connectString") OR (  isdefined("ATTRIBUTES.datasource") AND isdefined("ATTRIBUTES.username") AND isdefined("ATTRIBUTES.password") )>
		<cfset datasourceDefined = 1>
	<cfelse>
		<cfif isDefined("ATTRIBUTES.editInterface")>
			<cfset datasourceDefined = 0>
		<cfelse>
			<cfthrow message="Sorry, the attributes <b>datasource</b>, <b>username</b> and <b>password</b> MUST be passed.">
		</cfif>
	</cfif>

	<cfparam name="ATTRIBUTES.width" default="100%">
	<cfparam name="ATTRIBUTES.height" default="100%">

	<!--- The list of tags that will display in the chooseRecord view --->
	<cfset ATTRIBUTES.chooseRecordTypeList = "">
	<!--- Set the list of update TYPES that DO NOT use quotes --->
	<cfset ATTRIBUTES.noQuoteTypeList = "">
	<!--- Set the list of update TYPES that DO NOT use quotes --->
	<cfset ATTRIBUTES.useQuoteTypeList = "key_text,key_uuid">

	<cfdirectory directory="#GetDirectoryFromPath(GetCurrentTemplatePath())#interfaces/" name="dirList">

	<cfloop from="1" to="#dirList.recordCount#" index="currentRow">
		<cfset name = dirList.Name[currentRow]>
		<cfset type = dirList.Type[currentRow]>
		<cfif type EQ "Dir" AND Left(name,1) NEQ ".">
			<!--- Get the info about this type --->
			<cfinclude template="interfaces/#name#/info.cfm">
			<cfif interface_listInChooseRecordView>
				<cfif NOT ListFind(ATTRIBUTES.chooseRecordTypeList,Name)>
					<cfset ATTRIBUTES.chooseRecordTypeList = ListAppend(ATTRIBUTES.chooseRecordTypeList,Name)>
				</cfif>
			</cfif>
			<cfif interface_updateType EQ "number">
				<cfif NOT ListFind(ATTRIBUTES.noQuoteTypeList,Name)>
					<cfset ATTRIBUTES.noQuoteTypeList = ListAppend(ATTRIBUTES.noQuoteTypeList,Name)>
				</cfif>
			<cfelse>
				<cfif NOT ListFind(ATTRIBUTES.useQuoteTypeList,Name)>
					<cfset ATTRIBUTES.useQuoteTypeList = ListAppend(ATTRIBUTES.useQuoteTypeList,Name)>
				</cfif>
			</cfif>
		</cfif>
	</cfloop>


	<!--- Datasource connection parameters --->
	<cfparam name="ATTRIBUTES.username" default="">
	<cfparam name="ATTRIBUTES.password" default="">

	<!--- Show a title bar header --->
	<cfparam name="ATTRIBUTES.showHeader" default="yes">

	<!--- Default maxium number of items to display in chooser menu --->
	<cfparam name="ATTRIBUTES.allowInsert" default="yes">
	<cfparam name="ATTRIBUTES.allowUpdate" default="yes">
	<cfparam name="ATTRIBUTES.allowDelete" default="yes">

	<!--- Show the search button? --->
	<cfparam name="ATTRIBUTES.allowsearch" default="yes">
	
	<!--- Are we allowed edit the interface --->
	<cfparam name="ATTRIBUTES.editInterface" default="0">

	<!--- Ask to Save Option on Onload --->
	<cfparam name="ATTRIBUTES.saveAlert" default="yes" type="boolean">
	
	<!--- Show confirmation for delete --->
	<cfparam name="ATTRIBUTES.showConfirm" default="yes">
	
	<!--- Should the interface start in BLANK MODE? --->
	<cfparam name="ATTRIBUTES.startBlank" default="no" type="boolean">
	
	<!--- Show about button --->
	<cfparam name="ATTRIBUTES.showAbout" default="yes">
	
	<!--- List Mode for Name and Data Entry 0=Side by side, 1=top/bottom --->
	<cfparam name="ATTRIBUTES.listMode" default="1">

	<!--- Default maximum number of items to display in chooser menu --->
	<cfparam name="ATTRIBUTES.maxShortItems" default="8" type="numeric">
	
	<!--- Should all the short view items be listed --->
	<cfparam name="ATTRIBUTES.listAll" default="no">
	
	<!--- The maximum length of each value display --->
	<cfparam name="ATTRIBUTES.maxListTextSize" default=30>

	<!--- The default page size --->	
	<cfparam name="ATTRIBUTES.pageSize" default="100">

	<!--- The default framesetting --->	
	<cfif ATTRIBUTES.showHeader>
		<cfparam name="ATTRIBUTES.hiddenFrameSetting" default = "47,*,0">
		<cfparam name="ATTRIBUTES.defaultFrameSetting" default = "47,140,*">
	<cfelse>
		<cfparam name="ATTRIBUTES.hiddenFrameSetting" default = "26,*,0">
		<cfparam name="ATTRIBUTES.defaultFrameSetting" default = "26,140,*">
	</cfif>

	<!--- Make the fuckers pay (MTFP) for the code! yes = UDI_TRIAL --->
	<cfset ATTRIBUTES.MTFP = "no">
	
	<!--- Verify that the database connection is ok with some generic SQL --->
	<cfif datasourceDefined>
	<cftry>
		<!--- Standard Database conn test --->
		
		<cfmodule template="mod_query.cfm" queryname="connTest" maxrows="1"><cfoutput>
		SELECT 1 AS one
		</cfoutput></cfmodule>
		<cfcatch type="any">
			<!--- Oracle Test --->
			<cftry>
				<cfmodule template="mod_query.cfm" queryname="connTest" maxrows="1"><cfoutput>
				SELECT 1 AS one FROM DUAL
				</cfoutput></cfmodule>
				<cfcatch type="Database">
					<cfset NEWLINE = chr(13)&chr(10)>
					<cfoutput>
					</TD></TD></TD></TH></TH></TH></TR></TR></TR></TABLE></TABLE></TABLE></A></ABBREV></ACRONYM></ADDRESS></APPLET></AU></B></BANNER></BIG></BLINK></BLOCKQUOTE></BQ></CAPTION></CENTER></CITE></CODE></COMMENT></DEL></DFN></DIR></DIV></DL></EM></FIG></FN></FONT></FORM></FRAME></FRAMESET></H1></H2></H3></H4></H5></H6></HEAD></I></INS></KBD></LISTING></MAP></MARQUEE></MENU></MULTICOL></NOBR></NOFRAMES></NOSCRIPT></NOTE></OL></P></PARAM></PERSON></PLAINTEXT></PRE></Q></S></SAMP></SCRIPT></SELECT></SMALL></STRIKE></STRONG></SUB></SUP></TABLE></TD></TEXTAREA></TH></TITLE></TR></TT></U></UL></VAR></WBR></XMP>
					<h3>#ATTRIBUTES.component#</h3>
					<h4>Database Connection Cannot Be Established</h4>
					<p>	
					A connection to the database cannot be established with the given<br>
					datasource, username and password.<br>
					<br>
					Please check the authentication details and try again.<br>
					To view the error generated by ColdFusion,<br>
					please <a href="javascript:dcDBEditor_showEr()">click here</a>.
					</p>
					<script language="JavaScript1.2" defer>function dcDBEditor_showEr(){alert("Error updating database.\r\n\r\n#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#");}</script>
					</cfoutput>
					<cfabort>		
				</cfcatch>
			</cftry>
		</cfcatch>
	</cftry>
	</cfif>
	
	<!--- Determine, which database is being used and that the connection is ok --->
	<cfparam name="ATTRIBUTES.dbtype" default="unknown">
	<cfif ATTRIBUTES.dbtype EQ "unknown" AND datasourceDefined>
		<!--- Perform tests, to determine which database type is in use --->
		<!--- 1. Try mySQL --->
		<cftry>
			<cfmodule template="mod_query.cfm" queryname="connTest" maxrows="1"><cfoutput>
			SELECT version(), sysdate(), now()
			</cfoutput></cfmodule>
			<cfset ATTRIBUTES.dbtype = "MYSQL">
			<cfcatch type="Database">
				<!--- 2. Try MSSQL --->
				<cftry>
					<cfmodule template="mod_query.cfm" queryname="connTest" maxrows="1"><cfoutput>
					SELECT getdate(), current_timestamp
					</cfoutput></cfmodule>
					<cfset ATTRIBUTES.dbtype = "MSSQL">
					<cfcatch type="Database">
						<!--- 3. Try Access --->
						<cftry>
							<cfmodule template="mod_query.cfm" queryname="connTest" maxrows="1"><cfoutput>
							SELECT now(), time()
							</cfoutput></cfmodule>
							<cfset ATTRIBUTES.dbtype = "MSACCESS">
							<cfcatch type="Database">
								<!--- 4. Try Oracle --->
								<cftry>
									<cfmodule template="mod_query.cfm" queryname="connTest" maxrows="1"><cfoutput>
									SELECT currdate FROM dual
									</cfoutput></cfmodule>
									<cfset ATTRIBUTES.dbtype = "ORACLE">
									<cfcatch type="Database"></cfcatch>
								</cftry>
							</cfcatch>
						</cftry>
					</cfcatch>
				</cftry>
			</cfcatch>
		</cftry>
	</cfif>

	<!--- START: Convert all interface types to lowercase (faster list lookups) --->
	<!--- Protect against no sub-tags --->
	<CFPARAM Name='thisTag.assocAttribs' default=#arrayNew(1)#>
	<!--- Loop over the attribute sets of all sub tags --->
	<CFLOOP index=i from=1 to=#arrayLen(thisTag.assocAttribs)#>
	    <!--- Get the attributes structure --->
	    <CFSET thisTag.assocAttribs[i].type = LCase(thisTag.assocAttribs[i].type)>
	</CFLOOP>
	<!--- END: Convert all interface types to lowercase (faster list lookups) --->

	<!--- SPECIAL!!! key_text auto creates a 'Text' interface line for itself's updates --->
	<cfset i = 1>
	<cfloop condition="i LT arrayLen(thisTag.assocAttribs)">
		<cfif thisTag.assocAttribs[i].type EQ "key_text">
			<!--- slide all attributes down 1 to make room --->
			<cfloop index="m" from="#arrayLen(thisTag.assocAttribs)#" to="#i#" step="-1">
				<cfset thisTag.assocAttribs[m+1] = StructCopy(thisTag.assocAttribs[m])>
			</cfloop>
			<!--- Change type of clone to 'text' --->
			<cfset thisTag.assocAttribs[i+1].type = "text">
			<!--- Ensure this item can't be displayed on the shortlist --->
			<cfset thisTag.assocAttribs[i+1].shortList = 0>
		</cfif>
		<cfset i=i+1>
	</cfloop>	

	<!--- Save the relative path to this component for removal from URLs in WYSIWYG --->
	<cfset ATTRIBUTES.RelSharedPath = "#ATTRIBUTES.dcCom_RelPath#components/#ATTRIBUTES.component#/">

	<!--- START: SAVE ALL ATTRIBUTE DATA FOR RE-LOAD IN IFRAME PAGES --->
		<cfset UUID = Replace(CreateUUID(),"-","X","ALL")>
		<cfmodule template="serializeAttributes.cfm" method="save" uid="#UUID#">
	<!--- END: SAVE ALL ATTRIBUTE DATA --->
	
	<cfoutput><iframe src="#ATTRIBUTES.RelSharedPath#mainframe.cfm?ref=#URLEncodedFormat(UUID)#" width="#ATTRIBUTES.width#" height="#ATTRIBUTES.height#" frameborder="0" marginheight="0" marginwidth="0" scrolling="No"></iframe></cfoutput>
	
</CFIF>