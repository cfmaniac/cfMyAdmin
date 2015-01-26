<cfif NOT assocAttribs[ #attribIndex# ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>

<cfset htmlNum = htmlNum + 1>
<cfparam name="assocAttribs[ #attribIndex# ].width" default="100%">
<cfparam name="assocAttribs[ #attribIndex# ].height" default="200">
<cfparam name="assocAttribs[ #attribIndex# ].style" default="">
<cfif assocAttribs[ attribIndex ].style EQ "">
	<cfparam name="assocAttribs[ #attribIndex# ].bgcolor" default="white">
	<cfparam name="assocAttribs[ #attribIndex# ].color" default="black">
	<cfparam name="assocAttribs[ #attribIndex# ].padding" default="5">
</cfif>

<cfparam name="assocAttribs[ #attribIndex# ].stylesheet" default="">
<cfif assocAttribs[ attribIndex ].stylesheet EQ "">
	<cfparam name="assocAttribs[ #attribIndex# ].editStyle" default="font-family:verdana;font-size:10pt;">
<cfelse>
	<cfparam name="assocAttribs[ #attribIndex# ].editStyle" default="">
</cfif>

<cfif htmlNum EQ 1>
	<script src="editrtf.js"></script>
</cfif>

<cfoutput><DIV ID="idBox#htmlNum#" style="width:#assocAttribs[ attribIndex ].width#;height:#assocAttribs[ attribIndex ].height#;<cfif assocAttribs[ attribIndex ].style NEQ "">#assocAttribs[ attribIndex ].style#<cfelse>color:#assocAttribs[attribIndex].color#;border:1px solid black;padding:#assocAttribs[ attribIndex ].padding#px;</cfif>"></cfoutput>

<!--- No spellchecker option by default --->
<cfparam name="assocAttribs[ #attribIndex# ].spellChecker" default="">
<cfif assocAttribs[ attribIndex ].spellChecker NEQ "" AND htmlNum EQ 1>
	<cf_dcCom component="#assocAttribs[ attribIndex ].spellChecker#" dcCom_RelPath="../../"></cf_dccom>
</cfif>
<cfparam name="assocAttribs[ #attribIndex# ].superModeOption" default="YES">
<cfif assocAttribs[ #attribIndex# ].superModeOption>

	<cfif NOT isdefined("ISDEF_dcCOM_vRichEdit")>
		<cfset ISDEF_dcCOM_vRichEdit = 1>
		<script>function fvRichEdit(it){window.open('../dcVRichEdit/edit.cfm?HTMLfield='+it, 'vrichedit', 'width=600,height=360,resizable=no,toolbar=no');}</script>
	</cfif>

</cfif>

<cfparam name="assocAttribs[ #attribIndex# ].basehref" default="">
<cfparam name="assocAttribs[ #attribIndex# ].linkSelector" default="">

<cfoutput>
<script>
<cfif assocAttribs[ attribIndex ].linkSelector NEQ "">
var linkSel#htmlNum#="#ListGetAt(assocAttribs[ attribIndex ].linkSelector,1)#";
<cfif ListLen(assocAttribs[ attribIndex ].linkSelector) GE 3>
var linkSel_w#htmlNum#="#ListGetAt(assocAttribs[ attribIndex ].linkSelector,2)#";
var linkSel_h#htmlNum#="#ListGetAt(assocAttribs[ attribIndex ].linkSelector,3)#";
<cfelse>
var linkSel_w#htmlNum#,linkSel_h#htmlNum#;
</cfif>
<cfelse>
var linkSel#htmlNum#="",linkSel_w#htmlNum#,linkSel_h#htmlNum#;
</cfif>
<cfif assocAttribs[ #attribIndex# ].edit>var bMode#htmlNum#=true,sel#htmlNum#=null;document.write(getToolbar1(#htmlNum#));
document.write(getToolbar2(#htmlNum#,<cfif assocAttribs[ attribIndex ].superModeOption>1<cfelse>0</cfif><cfif assocAttribs[ attribIndex ].spellChecker NEQ "">,"#assocAttribs[ attribIndex ].spellChecker#"</cfif>));</cfif>
function initHTML#htmlNum#(){idEdit#htmlNum#.document.open();idEdit#htmlNum#.document.write('<html><head><cfif assocAttribs[ attribIndex ].basehref NEQ "">#JSStringFormat("<base href=""" & assocAttribs[ attribIndex ].basehref & """>")#</cfif><cfif assocAttribs[ attribIndex ].stylesheet NEQ "">#JSStringFormat("<link rel=""STYLESHEET"" type=""text/css"" href=""#assocAttribs[ attribIndex ].stylesheet#"">")#</cfif><cfif assocAttribs[ attribIndex ].editstyle NEQ ""><style>body,td{#JSStringFormat(assocAttribs[ attribIndex ].editStyle)#}</style></cfif></head><body style="behavior:url(#urlpathtocom#handleImgSel.htc);">#replacenocase(JSStringFormat(dbFieldVal),"</script>","</scr'+'ipt>","ALL")#</body></html>');idEdit#htmlNum#.document.close();<cfif assocAttribs[ #attribIndex# ].edit>idEdit#htmlNum#.document.designMode='On';</cfif>}
</SCRIPT>
<IFRAME name="idEdit#htmlNum#" style="width:98%;height:#Evaluate(assocAttribs[ attribIndex ].height-20)#"></IFRAME><br>
</div><input type="hidden" NAME="#dbField#" value="">
</cfoutput>