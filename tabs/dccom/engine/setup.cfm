<!------------------------------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------
 
Application:	Any
Project:		Any
Filename:		setup.cfm
Programmers:	Peter Coppinger <peter@digital-crew.com>
				
Purpose:		Part of dcComponent engine!
				This document is part of an effort to reduce the bulk of each dcComponent,
				placing as much of the shared setup and error testing in one central file
				as possible.
				Included by each dcComponent

CHANGE LOG:
30 Jan 2002		Document created.

 ----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------>

<!------------------------------------------------------------------------------->
<!--- Ensure dcCom relative path is set and that it is correct				  --->
<!------------------------------------------------------------------------------->
<cftry>
	<cfparam name="ATTRIBUTES.dcCom_RelPath">	
	<cfcatch type="MissingInclude">
		<cfoutput>
		</TD></TD></TD></TH></TH></TH></TR></TR></TR></TABLE></TABLE></TABLE></A></ABBREV></ACRONYM></ADDRESS></APPLET></AU></B></BANNER></BIG></BLINK></BLOCKQUOTE></BQ></CAPTION></CENTER></CITE></CODE></COMMENT></DEL></DFN></DIR></DIV></DL></EM></FIG></FN></FONT></FORM></FRAME></FRAMESET></H1></H2></H3></H4></H5></H6></HEAD></I></INS></KBD></LISTING></MAP></MARQUEE></MENU></MULTICOL></NOBR></NOFRAMES></NOSCRIPT></NOTE></OL></P></PARAM></PERSON></PLAINTEXT></PRE></Q></S></SAMP></SCRIPT></SELECT></SMALL></STRIKE></STRONG></SUB></SUP></TABLE></TD></TEXTAREA></TH></TITLE></TR></TT></U></UL></VAR></WBR></XMP>
		<h3>#ATTRIBUTES.component# Error!!</h3>
		<b>Image Path to dcComponent Directory undefined.</b>
		<br><br>
		Each dcComponent need to know the relative file and IMAGE path to the dcComponent directory.<br>
		This can be passed in using the attribute dataPath, eg. &lt;cf_#ATTRIBUTES.component# dcCom_RelPath="[Insert Path To dcComponents Directory]"&gt;<br>
		or a global variable "dcCom_RelPath" with the correct relative file path.
		<br><small>All paths should have closing slash!</small>
		<br><br><br><br><br>
		</cfoutput>
		<cfabort>
	</cfcatch>
</cftry>

<!--- By default the component request is a tag --->
<cfparam name="ATTRIBUTES.comtype" default="component">
<cfset ATTRIBUTES.comtype = LCASE(ATTRIBUTES.comtype)>
