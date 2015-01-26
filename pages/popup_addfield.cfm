<cfinclude template="..\templates\mysqldatatypes.cfm">
<cfif isdefined("action")>

	<cfswitch expression="#action#">
	
		<cfcase value="addField,updateField">

			<cfset SQL = "ALTER TABLE #FORM.theTable#">
			<cfif action EQ "addField">
				<cfset SQL = SQL & " ADD #FORM.fieldname#">
			<cfelse>
				<cfset SQL = SQL & " CHANGE #FORM.theField# #FORM.fieldname#">
			</cfif>
			<cfset SQL = SQl & " #FORM.fieldtype#">
			<cfif Len(fieldlengthorset)><cfset SQL = SQL & "(#FORM.fieldlengthorset#)"></cfif>
			<!--- The Options --->
			<cfif isdefined("FORM.optBinary")><cfset SQL = SQL & " BINARY"></cfif>
			<cfif isdefined("FORM.optUnsigned")><cfset SQL = SQL & " UNSIGNED"></cfif>
			<cfif isdefined("FORM.optZeroFill")><cfset SQL = SQL & " ZEROFILL"></cfif>
			<cfif isdefined("FORM.optAutoInc")><cfset SQL = SQL & " AUTO_INCREMENT"></cfif>
			<cfif isdefined("FORM.optNotNull")><cfset SQL = SQL & " NOT NULL"></cfif>
			<!--- The Default --->
			<cfif Len(FORM.fielddefault)>
				<cfset SQL = SQL & " default '#FORM.fielddefault#'">
			</cfif>
			
			<!--- Position --->
			<cfif FORM.position NEQ "END"><cfset SQL = SQL & " #FORM.position#"></cfif>
			
			<!--- Debugging --->
			<!---
			<cfoutput><pre>
			<script>
			alert("#JSStringFormat(SQL)#")
			</script>
			</pre></cfoutput>
			--->			
			
			<cftry>
				<cfmodule template="..\modules\smartquery.cfm" queryname="setDatabase"><cfoutput>
				#SQL#
				</cfoutput></cfmodule>
				<cfoutput>
					<html><body>
					<script>
					if( parent.window.opener && parent.window.opener.document && parent.window.opener.parent.document.getElementById("tableTab") ) parent.window.opener.parent.document.getElementById("tableTab").onclick();
					parent.window.close();
					</script>
					</body></html>
				</cfoutput>
				<cfcatch type="Database">
					<cfset NEWLINE = chr(13)&chr(10)>
					<script language="JavaScript1.2" defer>
					<cfoutput>alert("Whoops!\n\n#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#</cfoutput>");
					</script>
				</cfcatch>
			</cftry>
		
			<cfabort>
		</cfcase>
		
	</cfswitch>

</cfif>
<cfset fieldTypeList = "">
<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i">
	<cfset fieldTypeList = ListAppend( fieldTypeList, fieldTypes[i].fieldtype )>
</cfloop>
<cfmodule template="..\modules\smartquery.cfm" queryname="getFields"><cfoutput>
SHOW FIELDS FROM #theTable#
</cfoutput></cfmodule>
<cfmodule template="..\modules\smartquery.cfm" queryname="getKeys"><cfoutput>
SHOW KEYS FROM #theTable#
</cfoutput></cfmodule>
<cfif isdefined("theField")>
	<cfset fieldNamesList = ValueList(getFields.Field)>
	<cfset pos = ListFind( fieldNamesList, theField )>
	<cfif pos IS 0><html><body><script>alert("Field not found.");window.close();</script></body></html><cfabort></cfif>
	<cfset fieldInfo = getFields.Type[ pos ]>
	<cfset fieldDefault = getFields.Default[ pos ]>
	<cfset optNotNull = iif(getFields.Null[ pos ] NEQ "",DE(" checked"),DE(""))>
	<cfset optAutoInc = iif(getFields.Extra[ pos ] EQ "auto_increment",DE(" checked"),DE(""))>
	<cfset optBinary = iif(FindNoCase(" binary",fieldInfo) GT 0,DE(" checked"),DE(""))>
	<cfset optZeroFill = iif(FindNoCase(" zerofill",fieldInfo) GT 0,DE(" checked"),DE(""))>
	<cfset optUnsigned = iif(FindNoCase(" unsigned",fieldInfo) GT 0,DE(" checked"),DE(""))>
	<cfset startPos = Find("(", fieldInfo )>
	<cfif startPos IS 0>
		<cfset fieldType = fieldInfo>
		<cfset fieldLengthOrSet = 0>
		<cfset fielddefault = "">
	<cfelse>
		<cfset endPos = Find(")", fieldInfo, startPos+1)>
		<cfset fieldLengthOrSet = Mid( fieldInfo, startPos+1, (endPos-startPos)-1)>
		<cfset fieldType = Left( fieldInfo, startPos-1)>
	</cfif>

<!---
<cfoutput><pre>
fieldType: "#fieldType#"
fieldlengthorset: "#fieldlengthorset#"
fielddefault: "#fielddefault#"
optNotNull: "#optNotNull#"
optAutoInc: "#optAutoInc#"
optZeroFill: "#optZeroFill#"
optBinary: "#optBinary#"
optUnsigned: "#optUnsigned#"
</pre></cfoutput>
<cfabort>
--->

</cfif>


<cfparam name="theType" default="field">
<html>
<head>
	<title>Add Field / Index</title>
<style>
body {
 background-color:buttonface;
 margin:2px;
 padding:0px;
}
body,td{
font:11px icon,arial,sans-serif;
}
.atabOn {
	border-top:2px outset #ffffff;
	border-bottom:2px solid buttonface;
	border-left:2px outset #ffffff;
	border-right:2px inset #808080;
	font-family:arial;
	font-size:11px;
	color:black;
	font-weight:bold;
	height:25px;
}
.atabOff {
	border-top:2px outset #ffffff;
	border-bottom:2px inset #ffffff;
	border-left:2px outset #ffffff;
	border-right:2px inset #808080;
	background-color:buttonface;
	font-family:arial;
	font-size:11px;
	color:black;
	height:22px;
}
</style>
<script src="../js/wddx.js" type="text/javascript"></script>
<script>
var bBinaryOptions = new Array(<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i"><cfif fieldTypes[i].bBinaryOption>1,<cfelse>0,</cfif></cfloop>0);
var bUnsignedOptions = new Array(<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i"><cfif fieldTypes[i].bUnsignedOption>1,<cfelse>0,</cfif></cfloop>0);
var bZeroFillOptions = new Array(<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i"><cfif fieldTypes[i].bZeroFillOption>1,<cfelse>0,</cfif></cfloop>0);

var last="<cfoutput>#theType#</cfoutput>Tab";
var theType = "<cfoutput>#theType#</cfoutput>";
<cfif Len(theTable)><cfset theDatabase=listgetat(theTable,1,".")></cfif>
var theDatabase = "<cfoutput>#JSStringFormat(theDatabase)#</cfoutput>";
var theTable = "<cfoutput>#JSStringFormat(theTable)#</cfoutput>";
function changeTab(theTab)
{
	if(last!=null)
	{
		document.getElementById(last).className="atabOff";
	}
	document.getElementById(theTab).className="atabOn";
	document.getElementById( last + "Content" ).style.display = "none";
	document.getElementById( theTab + "Content" ).style.display = "block";
	last=theTab;
}
function h(theId)
{
	if(theId!=last) document.getElementById(theId).style.backgroundColor="#e0e0e0";
}

function setType( typeNo, bManual )
{
	if( arguments.length < 2 ) bManual = false;
	with( document.addFieldForm )
	{
		if( !bManual ) fieldtype.selectedIndex = typeNo;
		optBinary.disabled = (bBinaryOptions[typeNo] != 1);
		if( !bBinaryOptions[typeNo] && optBinary.checked ) optBinary.checked = false;
		optUnsigned.disabled = (bUnsignedOptions[typeNo] != 1);
		if( !bUnsignedOptions[typeNo] && optUnsigned.checked ) optUnsigned.checked = false;
		optZeroFill.disabled = (bZeroFillOptions[typeNo] != 1);
		if( !bZeroFillOptions[typeNo] && optZeroFill.checked ) optZeroFill.checked = false;
	}
	//if( bManual ) updateField();
}
function addField()
{
	with( document.addFieldForm )
	{
		submit();
	}
}
</script>
</head>
<body onload="document.addFieldForm.fieldname.select();">

<table cellpadding=2 cellspacing=0 border=0 width="100%" height="100%">
<form name="addFieldForm" action="popup_addfield.cfm" method="post" target="updater">
<input type="hidden" name="action" value="<cfif isdefined("theField")>update<cfelse>add</cfif>Field">
<input type="hidden" name="theTable" value="<cfoutput>#theTable#</cfoutput>">
<cfif isdefined("theField")>
<input type="hidden" name="theField" value="<cfoutput>#theField#</cfoutput>">
</cfif>
<tr><td height=20>

  <table cellspacing=0 cellpadding=0 border=0 width=100% style="background-color:#08246B;border-left:1px solid #848284;border-top:1px solid #848284;border-right:1px solid #ffffff;border-bottom:1px solid #ffffff;">
  <tr>
	<td height=20 style="padding-left:5px;font-size:12px;color:#ffffff;font-weight:bold;font-family:arial;" id="theTitleBar">Field-Editor</td>
  </tr>
  </table>

</td></tr>
<tr><td style="padding-left:4px;padding-right:4px;">

	<table width="100%" cellspacing=0 cellpadding=0 border=0 height=100%>
	<tr><td height=20 align=center valign=top>
	
	<table cellspacing=0 cellpadding=0 border=0 width="100%">
	<tr>
	 <td valign=bottom width=80  style="cursor:hand;" align=center>
	  <!----------Tab------->
	  <table id="fieldTab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "field">On<cfelse>off</cfif>"><tr><td width=16 style="padding-left:10px" align=right><img src="../images/icons/field.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Fields</td></tr></table>
	 <!---------/Tab-------->
	 </td>
	 <td valign=bottom width=85  style="cursor:hand;" align=center>
	 <!----------Tab------->
	  <table id="indexTab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "index">On<cfelse>off</cfif>"><tr><td width=16 style="padding-left:10px" align=right><img src="../images/icons/index.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Indexes</td></tr></table>
	 <!---------/Tab-------->
	 </td>
	 <td valign=bottom width=110  style="cursor:hand;" align=center>
	 <!----------Tab------->
	  <table id="relationshipTab" onmouseover="h(this.id)" onmouseout="this.style.backgroundColor='buttonface'" onclick="changeTab(this.id);" cellspacing=0 width=100% cellpadding=0 border=0 class="atab<cfif theType is "relationship">On<cfelse>off</cfif>"><tr><td width=16 style="padding-left:10px" align=right><img src="../images/icons/relationship.gif" width="16" height="16" alt="" border="0"></td><td align=left style="padding-left:5px;">Foreign&nbsp;Keys</td></tr></table>
	 <!---------/Tab-------->
	 </td>
	 <td style="border-bottom:2px inset #ffffff;" align=center valign=bottom>&nbsp;</td>
	</tr>
	</table>
	
	</td></tr>
	<tr><td valign=top align=center style="border-left:2px outset buttonhighlight;border-right:2px inset #848284;border-bottom:2px inset #848284;">
		
		<div id="fieldTabContent">
		<table cellpadding=0 cellspacing=0 border=0 width="262" height="100%">
		<tr><td>&nbsp;</td></tr>
		<tr><td>
			<table cellpadding=0 cellspacing=2 border=0 width="262">
			<tr><td>Position</td><td width=186><select name="position" style="width:100%">
			<cfif isdefined("theField")><option value="">&nbsp;</cfif>
			<option value="END">At End of Table
			<option value="FIRST">At Beginning of Table
			<cfoutput query="getFields">
				<cfif isdefined("theField") AND field NEQ theField>
					<option value="AFTER #field#">After #field#
				<cfelse>
					<option value="AFTER #field#">After #field#
				</cfif>
			</cfoutput>
			</select>
			</td></tr>
			<tr><td>Name:</td><td width=186><input name="fieldname" type="text" style="width:100%" value="<cfif isdefined("theField")><cfoutput>#theField#</cfoutput><cfelse>FieldName</cfif>" onclick="if(this.value=='FieldName')this.select();"></td></tr>
			<tr><td>Type:</td><td><select name="fieldtype" style="width:100%;" onchange="setType( this.selectedIndex, true )"><cfloop list="#fieldTypeList#" index="loopFieldType"><option value="<cfoutput>#loopFieldType#"<cfif isdefined("fieldType") AND fieldType EQ loopFieldType> selected</cfif>>#loopFieldType#</cfoutput></cfloop></select></td></tr>
			<tr><td>Length/Set:</td><td><input name="fieldlengthorset" type="text" style="width:100%" value="<cfif isdefined("fieldlengthorset")><cfoutput>#fieldlengthorset#</cfoutput><cfelse>3</cfif>"></td></tr>
			<tr><td>Default:</td><td><input name="fielddefault" type="text" style="width:100%" value="<cfif isdefined("fielddefault")><cfoutput>#fielddefault#</cfoutput><cfelse>0</cfif>"></td></tr>
			</table>
		</td></tr>
		<tr><td height="100%" style="margin-bottom:4px;">

			<fieldset>
				<legend>Attributes:</legend>
				<cfoutput>
				<table cellpadding=0 cellspacing=4 border=0 width="220" align=center>
				<tr>
					<td><input type="checkbox" name="optBinary" id="optBinary" onclick="updateField()"<cfif isdefined("optBinary")> #optBinary#</cfif> disabled><label for="optBinary">&nbsp;Binary</label></td>
					<td colspan=2><input type="checkbox" name="optNotNull" id="optNotNull" onclick="updateField()"<cfif isdefined("optNotNull")> #optNotNull#<cfelse> checked</cfif>><label for="optNotNull">&nbsp;Not&nbsp;Null</label></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="optUnsigned" id="optUnsigned" onclick="updateField()"<cfif isdefined("optUnsigned")> #optUnsigned#<cfelse> checked</cfif>><label for="optUnsigned">&nbsp;Unsigned</label></td>
					<td colspan=2><input type="checkbox" name="optAutoInc" id="optAutoInc" onclick="updateField()"<cfif isdefined("optAutoInc")> #optAutoInc#</cfif>><label for="optAutoInc">&nbsp;Auto&nbsp;Increment</label></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="optZeroFill" id="optZeroFill"<cfif isdefined("optZeroFill")> #optZeroFill#</cfif>><label for="optZeroFill">&nbsp;Zero&nbsp;Fill</label></td>
					<td colspan=2>&nbsp;</td>
				</tr>
				</table>
				</cfoutput>		
			</fieldset>			
		
		</td></tr>
		<tr><td>&nbsp;</td></tr>
		</table>
		</div>
		<div id="indexTabContent" style="display:none;">
			<div style="padding:26px;text-align:left;">
				Coming soon to a MySQL manager near you ;)<br>
				Check back to www.cfmyadmin.com for version 1.5<br>
			</div>
		</div>
		<div id="relationshipTabContent" style="display:none;">
			<div style="padding:26px;text-align:left;">
				Coming soon to a MySQL manager near you ;)<br>
				Check back to www.cfmyadmin.com for version 1.5<br>
			</div>
		</div>
	
	</td></tr>
	</table>

</td></tr>
<tr><td height=40 align=right>
	<table cellpadding=5 cellspacing=0 border=0>
	<tr>
		<td><input type="button" value="<cfif isdefined("theTable")>Update<cfelse>Add</cfif> Field" onclick="addField()"></td>
		<td><input type="button" value="Cancel" onclick="window.close();"></td>
	</tr>
	</table>
</td></tr>
</form>
</table>

<iframe name="updater" width="1" height="1" style="display:none;"></iframe>

</body>
</html>
