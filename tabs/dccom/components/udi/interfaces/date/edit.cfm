<!--- date (datetime also uses this interface) --->

<form name="editForm">
<table width="100%" cellpadding=7 cellspacing=0 border=0>
<tr><td width="95">Display Name:</td><td><input type="text" name="_display" size="40" value=""></td></tr>
<tr><td width="95">Default Value:</td><td><input type="text" name="_default" size="40" value=""></td></tr>
<tr><td>Month First?</td><td><input type="checkbox" name="_monthfirst">
<div class="info">
This option, when enabled will ask users to type the date in "mm/dd/yyyy" format instead
of the default "dd/mm/yyyy" format.
</div>
</td></tr>
<tr><td>Mask<br>(Date Format):</td><td><input type="text" name="_dateformat" size="40" value="">
<div class="info">
Mask used with standard CFML DateFormat() function when displaying this date. e.g. Entering "dddd&nbsp;dd&nbsp;mmm&nbsp;yyyy" will give dates like "<cfoutput>#DateFormat(now(),"dddd dd mm yyyy")#</cfoutput>".
</div>
</td></tr>
<tr><td>Can Edit?</td><td><input type="checkbox" name="_edit">
<div class="info">
Can this interface be edited or is it just for display purposes?
</div>
</td></tr>
<tr><td>Required?</td><td><input type="checkbox" name="_notnull">
<div class="info">
Check this option to force the user to enter the date.
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
		_default.value = getVar("default");
		_dateformat.value = getVar("dateformat");
		var bCanEdit = getVar("edit").toLowerCase();
		if( bCanEdit == "" ) bCanEdit = 1;//DEFAULT - CAN EDIT
		if( bCanEdit != "no" && bCanEdit ) _edit.checked = true; else _edit.checked = false;
		var bMonthFirst = getVar("monthfirst").toLowerCase();
		if( bMonthFirst == "" ) bMonthFirst = 0;//DEFAULT - MONTH IS NOT FIRST dd/mm/yyyy is default
		if( bMonthFirst != "no" && bMonthFirst ) _monthfirst.checked = true; else _monthfirst.checked = false;
		var bNotNull = getVar("notnull").toLowerCase();
		if( bNotNull != "no" && bNotNull ) _notnull.checked = true; else _notnull.checked = false;
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
		if(_default.value!="") setVar("default",_default.value);
		if(_dateformat.value!="") setVar("dateformat",_dateformat.value);
		setVar("monthfirst",(_monthfirst.checked)? "yes":"no");
		setVar("edit",(_edit.checked)? "yes":"no");
		setVar("notnull",(_notnull.checked)? "yes":"no");
		if(_style.value!="") setVar("style",_style.value);
	}
	//after updating, switch back to editRecordView
	parent.document.getElementById('fieldlistTabH2').click();
}
</script>
