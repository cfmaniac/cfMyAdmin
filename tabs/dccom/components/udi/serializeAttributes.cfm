<cfparam name="ATTRIBUTES.uid">
<cfparam name="ATTRIBUTES.method"><!--- save/load --->
<cfparam name="ATTRIBUTES.scope" default="session"><!--- SESSION/APPLICATION --->


<!--- Create a new SESSION scope structure to access the variables --->
<cfset collectionName = "#ATTRIBUTES.scope#.dccomData_#ATTRIBUTES.uid#">

<cfswitch expression="#UCASE(ATTRIBUTES.method)#">

	<!--- START: SAVE ALL ATTRIBUTE DATA FOR RE-LOAD IN IFRAME PAGES --->
	<cfcase value="SAVE">
		<cfset "#collectionName#" = arrayNew(1)>
		<!--- Append the current attributes to the array --->
		<cfscript>evaluate("arrayAppend( #collectionName#, CALLER.attributes) ");</cfscript>
		<!--- Append all the sub tag attribute information to the array --->
		<cfparam name="CALLER.thisTag.assocAttribs" default=ArrayNew(1)>
		<cfscript>evaluate("arrayAppend( #collectionName#, CALLER.thisTag.assocAttribs) ");</cfscript>
	</cfcase>
	<!--- END: SAVE ALL ATTRIBUTE DATA --->

	<cfcase value="LOAD">
	<!--- START: LOAD ALL ATTRIBUTE DATA FOR RE-LOAD IN IFRAME PAGES --->
	
		<!--- Check that the session hasn't time out --->
		<cfif NOT isdefined("#collectionName#")>
			<cfoutput>
			</TD></TD></TD></TH></TH></TH></TR></TR></TR></TABLE></TABLE></TABLE></A></ABBREV></ACRONYM></ADDRESS></APPLET></AU></B></BANNER></BIG></BLINK></BLOCKQUOTE></BQ></CAPTION></CENTER></CITE></CODE></COMMENT></DEL></DFN></DIR></DIV></DL></EM></FIG></FN></FONT></FORM></FRAME></FRAMESET></H1></H2></H3></H4></H5></H6></HEAD></I></INS></KBD></LISTING></MAP></MARQUEE></MENU></MULTICOL></NOBR></NOFRAMES></NOSCRIPT></NOTE></OL></P></PARAM></PERSON></PLAINTEXT></PRE></Q></S></SAMP></SCRIPT></SELECT></SMALL></STRIKE></STRONG></SUB></SUP></TABLE></TD></TEXTAREA></TH></TITLE></TR></TT></U></UL></VAR></WBR></XMP>
			<h3>Data for UID #ATTRIBUTES.uid# Not Found!</h3>
			<p>
				The dcCom component could not find data in server memory<br>
				for UID reference #ATTRIBUTES.uid# in scope #ATTRIBUTES.scope#. The data may<br>
				have timed out. Please refresh your browser.
			</p>
			</cfoutput>
			<cfabort>
			<cfabort>
		</cfif>
	
		<!--- Restore the variables --->
		<cfparam name="CALLER.ATTRIBUTES" default="#structNew()#">
		<CFSET bSuccess = StructAppend(CALLER.ATTRIBUTES, evaluate("#collectionName#[1]"), "Yes")>
		<CFSET CALLER.ASSOCATTRIBS = evaluate("#collectionName#[2]")>
		
	<!--- END: LOAD ALL ATTRIBUTE DATA --->
	</cfcase>
	
</cfswitch>