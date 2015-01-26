<!--- boolean_yn --->

<form name="editForm">
<table width="100%" cellpadding=7 cellspacing=0 border=0>
<tr><td width="95">Display Name:</td><td><input type="text" name="_display" size="40" value=""></td></tr>
<tr><td width="95">Default Value:</td><td><input type="checkbox" name="_default">
<div class="info">
<cfif interface EQ "boolean">Checked = 1, Unchecked = 0.<cfelse>Checked = 'Y', Unchecked = 'N'.</cfif>
</div>
</td></tr>
<tr><td>Can Edit?</td><td><input type="checkbox" name="_edit">
<div class="info">
Can this interface be edited or is it just for display purposes?
</div>
</td></tr>
<tr><td>CSS Style:</td><td><input type="text" name="_style" size="50" style="width:100%" value="">
<div class="info">
You can use this field to appy CSS Style formatting to this interface.
</div>
</td></tr>
</table>
</form>

<script src="getset.js"></script>
<script>
var fieldNo = <cfoutput>#fieldNo#</cfoutput>;
var skipCode = "<cfoutput>#skipCode#</cfoutput>";
var interface_type = "<cfoutput>#JSStringFormat(interface)#</cfoutput>";
var interface_field = "<cfoutput>#JSStringFormat(field)#</cfoutput>";
function init()
{
	with(document.editForm)
	{
		_display.value = getVar("display");
		var bDefaultChecked = getVar("default");
		if( <cfif interface EQ "boolean_yn">bDefaultChecked != 'N' && </cfif>bDefaultChecked != '0' ) _default.checked = true;
		var bCanEdit = getVar("edit").toLowerCase();
		if( bCanEdit == "" ) bCanEdit = 1;//DEFAULT - CAN EDIT
		if( bCanEdit != "no" && bCanEdit ) _edit.checked = true; else _edit.checked = false;
		_style.value = getVar("style");
	}
}
function updateChanges()
{
	with(document.editForm)
	{
		//check for errors
		errMsg = "";
		if( _display.value=="" ) errMsg = "'Display' cannot be blank";
		if( errMsg!="" ){alert("Errors in form.\n\n"+errMsg);return;}
	
		//clear the old values
		doVarReset();

		//do the update
		setVar("display",_display.value);
		parent.document.getElementById('fieldListTable').rows[fieldNo].cells[4].childNodes[0].value = _display.value;
		setVar("default", <cfif interface EQ "boolean">(_default.checked)? '1':'0'<cfelse>(_default.checked)? 'Y':'N'</cfif> );
		setVar("edit",(_edit.checked)? "yes":"no");
		if(_style.value!="") setVar("style",_style.value);
	}
	//after updating, switch back to editRecordView
	parent.document.getElementById('fieldlistTabH2').click();
}
</script>
