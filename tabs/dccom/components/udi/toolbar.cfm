<cfsetting enablecfoutputonly="Yes">
<!--- Load the attributes --->
<cfmodule template="serializeAttributes.cfm" method="load" uid="#ref#">
<cfsetting enablecfoutputonly="No"><html><head><LINK REL="STYLESHEET" TYPE="text/css" HREF="style.css">
<script language="JavaScript1.2">
var version = "<cfoutput>#ATTRIBUTES.version#</cfoutput>",ready=false,jsRef="<cfoutput>#ref#</cfoutput>",jsHidFrameSet="<cfoutput>#ATTRIBUTES.hiddenFrameSetting#</cfoutput>",oldFrameSetting="<cfoutput>#ATTRIBUTES.defaultFrameSetting#</cfoutput>";
function enableSaveButton(bEnable){<cfif ATTRIBUTES.allowUpdate OR ATTRIBUTES.allowInsert>document.getElementById("but_save").className=(bEnable)?"cButton":"cButtonDisabled";</cfif>}
function enableDeleteButton(bEnable){<cfif ATTRIBUTES.allowDelete>document.getElementById('but_delete').className=(bEnable)?"cButton":"cButtonDisabled";</cfif>}
function init(){ready=true;}
<cfif ATTRIBUTES.editInterface>
function editInterface()
{
	<cfif NOT isdefined("ATTRIBUTES.currentTemplatePath")>alert("Sorry. To allow dynamic editing of the UDI interface, the template path must be passed.\r\nPlease append the following to your main <c"+"f_dcCom> tag:\r\n\r\n           currentTemplatePath=\"#GetCurrentTemplatePath()#\"\r\n");
	<cfelse>window.open('editinterface/editinterface.cfm?ref=<cfoutput>#JSStringFormat(ref)#</cfoutput>', 'editinterface<cfoutput>#Left(Hash(ATTRIBUTES.currentTemplatePath),6)#</cfoutput>', 'width=720,height=560,resizable=no,toolbar=no');</cfif>
}
</cfif>
</script><script language="JavaScript1.2" src="toolbar.js"></script></head>
<body onload="init()"><table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
<cfif ATTRIBUTES.showHeader><tr><td height="20"><table cellpadding="0" cellspacing="0" border="0" width="100%" height="20"><tr><td class="appBar" width="16"><img src="icon.gif" width="14" height="14" alt="" border="0"></td><td class="appBar"><cfif NOT isdefined("ATTRIBUTES.title")><cfif isdefined("ATTRIBUTES.datasource") AND ATTRIBUTES.datasource NEQ "" AND isdefined("ATTRIBUTES.table") AND ATTRIBUTES.table NEQ ""><cfoutput>#ATTRIBUTES.datasource# / #ATTRIBUTES.table#</cfoutput><cfelse>UDI Version <cfoutput>#ATTRIBUTES.Version#</cfoutput></cfif><cfelse><cfoutput>#ATTRIBUTES.title#</cfoutput></cfif></td></tr></table></td></tr></cfif>
<tr><td class="toolbar">
<table cellpadding=0 cellspacing=0 align=left><tr>
<!--- Only show icons if there is an interface defined --->
<cfif arrayLen(assocAttribs) GT 0>
<!--- Div Spacer ---><td width="8"><img src="div.gif" width="5" height="25" alt="" border="0"></td>
<td id="but_new" <cfif NOT ATTRIBUTES.allowInsert>class="cButtonDisabled"<cfelse>class="cButton" nowrap onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="newRecord(this)"</cfif> onSelectStart="return false;"><img id="img_new" src="new.gif" width="16" height="16" alt="" border="0" align="absmiddle">&nbsp;New</td>
<td id="but_save" <cfif NOT ATTRIBUTES.allowUpdate>class="cButtonDisabled"<cfelse>class="cButtonDisabled" onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="saveRecord(this)"</cfif> onSelectStart="return false;"><img id="img_save" src="save.gif" width="16" height="16" alt="" border="0" align="absmiddle">&nbsp;Save</td>
<td id="but_edit" <cfif NOT ATTRIBUTES.allowUpdate>class="cButtonDisabled"<cfelse>class="cButtonDisabled" nowrap onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="editRecord(this)"</cfif> onSelectStart="return false;"><img id="img_edit" src="editRecord.gif" width="16" height="16" alt="" border="0" align="absmiddle">&nbsp;Edit</td>
<td id="but_delete" <cfif NOT ATTRIBUTES.allowDelete>class="cButtonDisabled"<cfelse>class="cButtonDisabled" onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="deleteRecord(this)"</cfif> onSelectStart="return false;"><img id="img_delete" src="delete.gif" width="14" height="14" alt="" border="0" align="absmiddle">&nbsp;Delete</td>
<td id="but_refresh" <cfif NOT ATTRIBUTES.allowUpdate>class="cButtonDisabled"<cfelse>class="cButton" onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="refreshViews()"</cfif> onSelectStart="return false;"><img id="img_refresh" src="refresh.gif" width="14" height="14" alt="" border="0" align="absmiddle">&nbsp;Refresh</td>
<td id="but_dpane" <cfif NOT ATTRIBUTES.allowUpdate>class="cButtonDisabled"<cfelse>class="cButton" onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="toggleDetailsView()"</cfif> onSelectStart="return false;"><img id="img_dpane" src="detailspane.gif" width="15" height="15" alt="" border="0" align="absmiddle">&nbsp;Show/Hide</td>
<cfif ATTRIBUTES.allowsearch>
	<td id="but_search" class="cButton" onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="doSearch()" onSelectStart="return false;"><img id="img_search" src="search.gif" width="16" height="16" alt="" border="0" align="absmiddle">&nbsp;Search</td>
</cfif>
</cfif>
<cfif ATTRIBUTES.showAbout>
<td id="but_about" class="cButton" onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="showAbout()" onSelectStart="return false;">About</td>
</cfif>
<cfif ATTRIBUTES.editInterface>
<td id="but_editinterface" class="cButton" onMouseOver="rollOn(this)" onMouseOut="rollOff(this)" onClick="editInterface()" onSelectStart="return false;"><img id="img_interface" src="interface.gif" width="15" height="15" alt="" border="0" align="absmiddle">&nbsp;Edit Interface</td>
</cfif>
</tr></table>
<span id="turnPage" style="display:none;float:right">
	page:
	<button onclick="turnPage(-1)" id=pageDown><img src="larrow.gif" width="6" height="14" alt="" border="0"></button>
	<select onchange="setPage(this.value)" id=pageNos name="pageNo"><option>1</select>
	<button onclick="turnPage(1)" id=pageUp><img src="rarrow.gif" width="6" height="14" alt="" border="0"></button>
</span>
</td></tr></table></body></html>
