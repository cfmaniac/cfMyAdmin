<cfinclude template="..\templates\mysqldatatypes.cfm">
<cfif isdefined("action") AND action EQ "createTable">
<cfsetting enablecfoutputonly="Yes">

	<cftry>
		<cfwddx action="WDDX2CFML" input="#FORM.wddx#" output="fields">
		
		<cfmodule template="..\modules\smartquery.cfm" queryname="setDatabase"><cfoutput>
		USE #FORM.database#
		</cfoutput></cfmodule>

		<cfset SQL = "#APPLICATION.NEWLINE#CREATE TABLE `" & LCASE(FORM.tablename) & "` (">

		<!--- START: Field Types --->
		<cfset iNumFieldsFound = 0>
		<cfloop from="1" to="#ArrayLen(fields)#" index="fieldNo">
			<cfset iNumFieldsFound = iNumFieldsFound + 1>
			<cfif iNumFieldsFound GT 1><cfset SQL = SQL & ","></cfif>
			<cfset SQL = SQl & "`#fields[fieldNo].fieldName#`">
			<cfset fieldType = fieldTypes[ fields[fieldNo].fieldTypeNo+1 ].fieldType>
			<cfset SQL = SQL & " #fieldType#">
			<cfswitch expression="#UCASE(fieldType)#">
				<cfdefaultcase><cfset SQL = SQL & " (#fields[fieldNo].lengthorset#)"></cfdefaultcase>
			</cfswitch>
			<!--- The Options --->
			<cfloop from="1" to="8" index="optionNo">
				<cfif fields[fieldNo].bOptions[optionNo] IS 1>
				<cfswitch expression="#optionNo#">
					<cfcase value="1"><cfset SQL = SQL & " BINARY"></cfcase>
					<cfcase value="2"><cfset SQL = SQL & " UNSIGNED"></cfcase>
					<cfcase value="3"><cfset SQL = SQL & " ZEROFILL"></cfcase>
					<cfcase value="4"><cfset SQL = SQL & " AUTO_INCREMENT"></cfcase>
					<cfcase value="5"><cfset SQL = SQL & " NOT NULL"></cfcase>
				</cfswitch>
				</cfif>
			</cfloop>
			<!--- The Default Value --->
			<cfif Len(fields[fieldNo].defaultval)>
				<cfset SQL = SQL & " default '#fields[fieldNo].defaultval#'">
			</cfif>
		</cfloop>
		<!--- END: Field Types --->
		
		<!--- START: Primary Keys --->
		<cfset iNumPrimaryKeysFound = 0>
		<cfloop from="1" to="#ArrayLen(fields)#" index="fieldNo">
			<cfif fields[fieldNo].bOptions[6]>
				<cfif iNumPrimaryKeysFound IS 0>
					<cfset SQL = SQL & ", PRIMARY KEY(">
				</cfif>
				<cfset iNumPrimaryKeysFound = iNumPrimaryKeysFound + 1>
				<cfif iNumPrimaryKeysFound GT 1><cfset SQL = SQl & ","></cfif>
				<cfset SQL = SQl & " `" & fields[fieldNo].fieldName & "`">
			</cfif>
		</cfloop>
		<cfif iNumPrimaryKeysFound GT 0><cfset SQL = SQL & ")"></cfif>
		<!--- END: Primary Keys --->
		
		<!--- START: UNIQUE fields --->
		<cfset iNumUniqueFieldsFound = 0>
		<cfloop from="1" to="#ArrayLen(fields)#" index="fieldNo">
			<cfif fields[fieldNo].bOptions[7]>
				<cfif iNumUniqueFieldsFound IS 0>
					<cfset SQL = SQL & ", UNIQUE(">
				</cfif>
				<cfset iNumUniqueFieldsFound = iNumUniqueFieldsFound + 1>
				<cfif iNumUniqueFieldsFound GT 1><cfset SQL = SQl & ","></cfif>
				<cfset SQL = SQl & " `" & fields[fieldNo].fieldName & "`">
			</cfif>
		</cfloop>
		<cfif iNumUniqueFieldsFound GT 0><cfset SQL = SQL & ")"></cfif>
		<!--- END: UNIQUE fields --->
		
		<!--- START: INDEX fields --->
		<cfset iNumIndexFieldsFound = 0>
		<cfloop from="1" to="#ArrayLen(fields)#" index="fieldNo">
			<cfif fields[fieldNo].bOptions[8]>
				<cfif iNumIndexFieldsFound IS 0>
					<cfset SQL = SQL & ", INDEX(">
				</cfif>
				<cfset iNumIndexFieldsFound = iNumIndexFieldsFound + 1>
				<cfif iNumIndexFieldsFound GT 1><cfset SQL = SQl & ","></cfif>
				<cfset SQL = SQl & " `" & fields[fieldNo].fieldName & "`">
			</cfif>
		</cfloop>
		<cfif iNumIndexFieldsFound GT 0><cfset SQL = SQL & ")"></cfif>
		<!--- END: INDEX fields --->
		
		<!--- End The SQL --->
		<cfset SQL = SQL & ")">
		
		<!--- Set Database Type (if not automatic) --->
		<cfif NOT FindNoCase("automatic",tabletype)>
			<cfset SQl = SQL & " TYPE = #tabletype#">
		</cfif>
		
		<!---
		<cfoutput><pre>
		#SQL#
		</pre></cfoutput>
		--->
		
		<cfmodule template="..\modules\smartquery.cfm" queryname="emptyTable"><cfoutput>
		#SQL#
		</cfoutput></cfmodule>
		<cfoutput>
			<html><body>
			<script>
			if( parent.window.opener && parent.window.opener.document && parent.window.opener.document.getElementById("databaseTab") ) parent.window.opener.document.getElementById("databaseTab").onclick();
			parent.window.opener.top.workwindow.leftSide.refreshFrame();
			parent.window.close();
			</script>
			</body></html>
		</cfoutput>
		<cfcatch type="Database">
			<cfmodule template="..\modules\mod_dberrorhandler.cfm" errorTitle="Error Creating Database">
		</cfcatch>
	</cftry>

	<cfabort>

</cfif>
<cfmodule template="..\modules\smartquery.cfm" queryname="getDatabases"><cfoutput>
show databases
</cfoutput></cfmodule>
<cfset fieldTypeList = "">
<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i">
	<cfset fieldTypeList = ListAppend( fieldTypeList, fieldTypes[i].fieldtype )>
</cfloop>
<html>
<head>
	<title>CFMyAdmin - Create Table</title>
<style>
body {
 background-color:buttonface;
 margin:2px;
 padding:0px;
}
body,td{
font:11px arial,sans-serif;
}
</style>
<script src="../js/wddx.js" type="text/javascript"></script>
<script>
var bBinaryOptions = new Array(<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i"><cfif fieldTypes[i].bBinaryOption>1,<cfelse>0,</cfif></cfloop>0);
var bUnsignedOptions = new Array(<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i"><cfif fieldTypes[i].bUnsignedOption>1,<cfelse>0,</cfif></cfloop>0);
var bZeroFillOptions = new Array(<cfloop from="1" to="#ArrayLen(fieldTypes)#" index="i"><cfif fieldTypes[i].bZeroFillOption>1,<cfelse>0,</cfif></cfloop>0);
var selectedFieldPos = null;
var fields = new Array();
var okChars = "abcdefghijklmnopqrstuvwxyz1234567890_-ABCDEFGHIJKLMNOPQRSTUVWXYZ";
function checkCharOK(othis)
{
	//toDo: Check that each keypress is allowed, block stupid characters
}
var bCheckFieldnameTimerRunning = false;
function checkFieldNameAndAdjustAddButton()
{

	with( document.createTableForm )
	{
		lastTimerFieldName = fieldname.value;//remember so we know if its updated
		fname = fieldname.value;
		var bIsDisabled = false;
		if( fname == "" || fname == "FieldName" ) bIsDisabled = true;
		else { 
			for( i=0; i<fields.length; i++ ) if( fields[ i ].fieldName == fname ) bIsDisabled = true;
		}
		document.getElementById("butAdd").disabled = bIsDisabled;
		document.getElementById("butChange").disabled = ( selectedFieldPos == null )? true:bIsDisabled;
		
	}
	if( bCheckFieldnameTimerRunning ) setTimeout( checkFieldNameAndAdjustAddButton,500 );//check every sec
}
function stopStartCheckFieldTimer(bStart)
{
	if( bStart )
	{
		bCheckFieldnameTimerRunning = true;
		setTimeout( checkFieldNameAndAdjustAddButton, 500 );//check every sec
	}
	else bCheckFieldnameTimerRunning = false;
}
function setType( typeNo, bManual )
{
	if( arguments.length < 2 ) bManual = false;
	with( document.createTableForm )
	{
		if( !bManual ) fieldtype.selectedIndex = typeNo;
		optBinary.disabled = (bBinaryOptions[typeNo] != 1);
		if( !bBinaryOptions[typeNo] && optBinary.checked ) optBinary.checked = false;
		optUnsigned.disabled = (bUnsignedOptions[typeNo] != 1);
		if( !bUnsignedOptions[typeNo] && optUnsigned.checked ) optUnsigned.checked = false;
		optZeroFill.disabled = (bZeroFillOptions[typeNo] != 1);
		if( !bZeroFillOptions[typeNo] && optZeroFill.checked ) optZeroFill.checked = false;
	}
	if( bManual ) updateField();
}
function selectField( fieldNo, bManual )
{
	if( arguments.length < 2 ) bManual = false;
	with( document.createTableForm )
	{
		selectedFieldPos = fieldNo;
		if( !bManual ) fieldList.selectedIndex = fieldNo;//set selection
		else fieldname.value = fields[ fieldNo ].fieldName;
		lengthorset.value = fields[ fieldNo ].lengthorset;
		defaultval.value = fields[ fieldNo].defaultval;
		var optList = new Array("optBinary","optUnsigned","optZeroFill","optAutoInc","optNotNull","optPrimary","optUnique","optIndex");
		for( i=0; i< optList.length; i++ ) eval( optList[i] + ".checked = (fields[ fieldNo ].bOptions[i]==1)" );
		
		//load RHS options based on current field selection
		setType( fields[ selectedFieldPos ].fieldTypeNo );
	}
}
function enableFieldProperties( bEnable )
{

	with( document.createTableForm )
	{
		if( arguments.length < 1 ) bEnable = true;
		var optionsToEnable = new Array("fieldType","lengthorset","defaultval");
		
		for( i=0; i< optionsToEnable.length; i++ ) { 
			document.getElementById( optionsToEnable[i] ).disabled = !bEnable;
		}

		if( !bEnable ){//Disaable all options
			optBinary.disabled = true;
			optUnsigned.disabled = true;
			optZeroFill.disabled = true;
			optPrimary.disabled = true;
			optIndex.disabled = true;
			optUnique.disabled = true;
			optBinary.disabled = true;
			optAutoInc.disabled = true;
		}
		else {
			//These fields are always enabled regardless of field type, remaining 3 fields enabled/disabled according to the field type
			optPrimary.disabled = !bEnable;
			optIndex.disabled = !bEnable;
			optNotNull.disabled = !bEnable;
			optUnique.disabled = !bEnable;
			optAutoInc.disabled = !bEnable;
		}
	}
}
function addField()
{
	with( document.createTableForm )
	{
		if( fieldname.value.length == 0 ) return;
		insPos = fields.length;
		fields[ insPos ] = new Object();
		fields[ insPos ].fieldName = fieldname.value;
		fields[ insPos ].fieldTypeNo = 0;
		fields[ insPos ].lengthorset = "3";
		fields[ insPos ].defaultval = "0";
		fields[ insPos ].bOptions = new Array(0,1,0,0,0,0,0,0);
		fieldList.options[ insPos ] = new Option( fieldname.value, insPos );
		enableFieldProperties();
		selectField( fields.length-1 );
		document.getElementById("butAdd").disabled = true;
		document.getElementById("butChange").disabled = true;
		document.getElementById("butRemove").disabled = false;
		document.getElementById("butCreate").disabled = false;
	}
}
function updateField()
{
	if( selectedFieldPos == null ) return;
	with( document.createTableForm )
	{
		fields[ selectedFieldPos ].lengthorset = lengthorset.value;
		fields[ selectedFieldPos ].defaultval = defaultval.value;
		fields[ selectedFieldPos ].fieldTypeNo = fieldtype.selectedIndex;
		var optList = new Array("optBinary","optUnsigned","optZeroFill","optAutoInc","optNotNull","optPrimary","optUnique","optIndex");
		for( i=0; i< optList.length; i++ ) eval( "fields[ selectedFieldPos ].bOptions[i] = " + optList[i] + ".checked" );
	}
}
function changeField()
{
	with( document.createTableForm )
	{
		document.getElementById("butRemove").disabled = false;
		fields[ selectedFieldPos ].fieldName = fieldname.value;
		fieldList.options[ selectedFieldPos ] = new Option( fieldname.value, selectedFieldPos );
		fieldList.selectedIndex = selectedFieldPos;
	}	
}
function removeField()
{
	with( document.createTableForm )
	{
		fieldList.options[selectedFieldPos] = null;
		for( i=selectedFieldPos; i<fields.length-1; i++ ) fields[i] = fields[i+1];
		fields.length = fields.length-1;
		
		if( fields.length == 0 )
		{
			document.getElementById("butRemove").disabled = true;
			document.getElementById("butCreate").disabled = true;
			selectedFieldPos = null;
		}
		else if( fieldList.length > selectedFieldPos ) { fieldList.selectedIndex = selectedFieldPos; }
		else {selectedFieldPos--;fieldList.selectedIndex = selectedFieldPos; }
		checkFieldNameAndAdjustAddButton();
	}
}
function moveUp()
{
	with( document.createTableForm )
	{
		if( selectedFieldPos == 0 ) return;
		//swap field list names
		temp = fieldList.options[selectedFieldPos-1].text;
		fieldList.options[selectedFieldPos-1].text = fieldList.options[selectedFieldPos].text;
		fieldList.options[selectedFieldPos].text = temp;
		//swap field list values
		temp = fieldList.options[selectedFieldPos-1].value;
		fieldList.options[selectedFieldPos-1].value = fieldList.options[selectedFieldPos].value;
		fieldList.options[selectedFieldPos].value = temp;
		//swap definition objects
		temp = fields[selectedFieldPos-1];
		fields[selectedFieldPos-1] = fields[selectedFieldPos];
		fields[selectedFieldPos] = temp;
		selectedFieldPos--;
		fieldList.selectedIndex = selectedFieldPos;
	}
}
function moveDown()
{
	with( document.createTableForm )
	{
		if( selectedFieldPos == fieldList.length-1 ) return;
		//swap field list names
		temp = fieldList.options[selectedFieldPos+1].text;
		fieldList.options[selectedFieldPos+1].text = fieldList.options[selectedFieldPos].text;
		fieldList.options[selectedFieldPos].text = temp;
		//swap field list values
		temp = fieldList.options[selectedFieldPos+1].value;
		fieldList.options[selectedFieldPos+1].value = fieldList.options[selectedFieldPos].value;
		fieldList.options[selectedFieldPos].value = temp;
		//swap definition objects
		temp = fields[selectedFieldPos+1];
		fields[selectedFieldPos+1] = fields[selectedFieldPos];
		fields[selectedFieldPos] = temp;
		selectedFieldPos++;
		fieldList.selectedIndex = selectedFieldPos;
	}
}
function createTable()
{
	var s=new WddxSerializer();
	var wddxdata = s.serialize( fields );
	with( document.createTableForm )
	{
		wddx.value = wddxdata;
		submit();
	}
}
</script>
</head>
<body onload="document.createTableForm.tablename.select();">

<table cellpadding=2 cellspacing=0 border=0 width="100%" height="100%">
<form name="createTableForm" action="popup_createtable.cfm" method="post" target="updater">
<input type="hidden" name="action" value="createTable">
<input type="hidden" name="wddx" value="">
<tr><td height=20>

  <table cellspacing=0 cellpadding=0 border=0 width=100% style="background-color:#08246B;border-left:1px solid #848284;border-top:1px solid #848284;border-right:1px solid #ffffff;border-bottom:1px solid #ffffff;">
  <tr>
	<td height=20 style="padding-left:5px;font-size:12px;color:#ffffff;font-weight:bold;font-family:arial;" id="theTitleBar">Create Table...</td>
  </tr>
  </table>

</td></tr>
<tr><td style="padding-left:10px;padding-right:10px;">

	<table cellpadding=0 cellspacing=0 border=0 width="100%" height="100%">
	<tr><td height="76" style="border-bottom:1px solid #848284;">
		<table cellpadding=0 cellspacing=4 border=0 width="100%">
		<tr>
			<td><b>Table-Name:</b></td><td width=153><input name="tablename" type="text" style="width:153px;" value="TableName" onclick="if(this.value=='TableName')this.select();"></td>
			<td width=10>&nbsp;</td>
			<td>Comment:</td><td width=153><input name="comment" type="text" style="width:153px;"></td>
		</tr>
		<tr>
			<td>In Database:</td><td width=153><select name="database" style="width:153px;"><cfoutput query="getDatabases"><option value="#database#"<cfif database EQ theDatabase> selected</cfif>>#database#</cfoutput></select></td>
			<td width=10>&nbsp;</td>
			<td>Table-Type:</td><td width=153><select name="tabletype" style="width:153px;"><cfloop list="#tableTypeList#" index="tableType"><option value="<cfoutput>#tableType#">#tableType#</cfoutput></cfloop></select></select></td>
		</tr>
		</table>
	</td></tr>
	<tr><td style="border-top:1px solid buttonhighlight;border-bottom:1px solid #848284;">
		<table cellpadding=0 cellspacing=0 border=0 width="100%" height="100%">
		<tr>
			<td height=20 valign=bottom style="padding-left:4px;">Fields:</td>
			<td valign=top width=235>&nbsp;</td>
		</tr>
		<tr>
			<td valign=top>
				<table cellpadding=0 cellspacing=4 border=0 width="100%" height="100%">
				<tr>
					<td height=20 valign=top>
						<input type="text" name="fieldname" style="width:100%" value="FieldName" onclick="if(this.value=='FieldName')this.select();" onkeypress="checkCharOK(this)" onfocus="stopStartCheckFieldTimer(true)" onblur="stopStartCheckFieldTimer(false)" onchange="checkFieldNameAndAdjustAddButton()">
					</td>
					<td width=100 valign=top>
						<input type="button" id="butAdd" style="width:77px;" value="Add" onclick="addField()" disabled>
					</td>
				</tr>
				<tr>
					<td valign=top rowspan=2>
						<select name="fieldList" size=10 style="width:100%;height:100%;" onchange="selectField( this.selectedIndex, true )">
						</select>
					</td>
					<td width=100 valign=top>
						<div style="margin-bottom:4px;"><input id="butChange" type="button" style="width:77px;" value="Change" onclick="changeField()" disabled></div>
						<div><input id="butRemove" type="button" style="width:77px;" value="Remove" onclick="removeField()" disabled></div>
					</td>
				</tr>
				<tr><td valign=bottom>
					<div><button id="butMoveUp" style="width:26px;" onclick="moveUp()"><img src="../images/icons/up.gif" width="16" height="16" alt="" border="0"></button></div>
					<div style="margin-bottom:6px;"><button id="butMoveDown" style="width:26px;" onclick="moveDown()"><img src="../images/icons/down.gif" width="16" height="16" alt="" border="0"></button></div>
				</td></tr>
				</table>			
			</td>
			<td valign=top width=235>
				<fieldset style="height:98%;">
					<legend>Field-Properties:</legend>
					<table cellpadding=0 cellspacing=2 border=0 width="200" align=center>
					<tr><td>Type:</td><td width=115><select name="fieldtype" id="fieldType" style="font:10px arial,sans-serif;width:100%;" onchange="setType( this.selectedIndex, true )" disabled><cfloop list="#fieldTypeList#" index="fieldType"><option value="<cfoutput>#fieldType#">#fieldType#</cfoutput></cfloop></select></td></tr>
					<tr><td>Length/Set:</td><td width=115><input type=text name="lengthorset" id="lengthorset" style="width:100%;" onchange="updateField()" disabled></td></tr>
					<tr><td>Default Value:</td><td width=115><input type=text name="defaultval" id="defaultval" style="width:100%;" onchange="updateField()" disabled></td></tr>
					<tr><td valign=top colspan=2>
						<table cellpadding=0 cellspacing=2 border=0 width="100%">
						<tr>
							<td><input type="checkbox" name="optPrimary" id="optPrimary" onclick="updateField()" disabled><label for="optPrimary">&nbsp;Primary</label></td>
							<td><input type="checkbox" name="optIndex" id="optIndex" onclick="updateField()" disabled><label for="optIndex">&nbsp;Index</label></td>
							<td><input type="checkbox" name="optUnique" id="optUnique" onclick="updateField()" disabled><label for="optUnique">&nbsp;Unique</label></td>
						</tr>
						<tr>
							<td><input type="checkbox" name="optBinary" id="optBinary" onclick="updateField()" disabled><label for="optBinary">&nbsp;Binary</label></td>
							<td colspan=2><input type="checkbox" name="optNotNull" id="optNotNull" onclick="updateField()" disabled><label for="optNotNull">&nbsp;Not&nbsp;Null</label></td>
						</tr>
						<tr>
							<td><input type="checkbox" name="optUnsigned" id="optUnsigned" onclick="updateField()" disabled><label for="optUnsigned">&nbsp;Unsigned</label></td>
							<td colspan=2><input type="checkbox" name="optAutoInc" id="optAutoInc" onclick="updateField()" disabled><label for="optAutoInc">&nbsp;Auto&nbsp;Increment</label></td>
						</tr>
						<tr>
							<td><input type="checkbox" name="optZeroFill" id="optZeroFill" disabled><label for="optZeroFill">&nbsp;Zero&nbsp;Fill</label></td>
							<td colspan=2>&nbsp;</td>
						</tr>
						</table>					
					</td></tr>
					</table>
				</fieldset>			
			</td>
		</tr>
		</table>
	</td></tr>
	<tr><td height=40 align=right valign=middle style="border-top:1px solid buttonhighlight;">
		<table cellpadding=5 cellspacing=0 border=0>
		<tr>
			<td><input type="button" id="butCreate" value="Create!" onclick="createTable()" disabled></td>
			<td><input type="button" value="Cancel" onclick="window.close();"></td>
		</tr>
		</table>		
	</td></tr>
	</table>

</td></tr>
</form>
</table>

<iframe name="updater" width="1" height="1" style="display:none;"></iframe>

</body>
</html>
