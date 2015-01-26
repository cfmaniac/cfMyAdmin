<!--- select_text --->

<form name="editForm">
<table width="100%" cellpadding=7 cellspacing=0 border=0>
<tr><td width="95">Display Name:</td><td><input type="text" name="_display" size="40" value=""></td></tr>
<tr><td width="95">Default Value:</td><td><input type="text" name="_default" size="40" value=""></td></tr>
<cfif interface EQ "select_text">
<tr><td>Multiple Selection?</td><td><input type="checkbox" name="_multiple">
<div class="info">
	If yes multiple values can be selected; these values will be entered into the database comma-seperated.
	e.g. 'Peter Coppinger,Daniel Mackey,Cormac McCarthy'.
	Ensure that the database field has enough room to store several appended values if this
	option is used, otherwise the resulting string may be truncated or generate errors.
</div>
</td></tr>
</cfif>
<tr><td>Size:</td><td><input type="text" name="_size" size="5" value="" onkeypress="ensureInt(this)">
<div class="info">
	If size is set bigger than 1, the select interface changes from a drop-down select to
	a list-select.
	<cfif interface EQ "select_text">
	If the 'multiple' option is selected (see above), you should set this size to a value greater than 1
	to allow the user to make multiple selections.
	</cfif>
</div>
</td></tr>
<tr><td>Interface Style:</td><td>

<input type="radio" name="istyle" id="is1" onClick="showInterface(1)">
<label for="is1">Query Based Selection</label>
<input type="radio" name="istyle" id="is2" onClick="showInterface(2)">
<label for="is2">Display List and Value List</label>
<input type="radio" name="istyle" id="is3" onClick="showInterface(3)">
<label for="is3">Number Range</label>
<div class="info">
	These 3 different interface types are available for <cfoutput>#interface#</cfoutput>.
	The relevant fields the selected interface are shown below:
</div>
<div id="istyle_opt1" style="display:none;">
	<table cellpadding=7 cellspacing=0 border=0 width="100%">
	<tr><td width=95>Query:</td><td><textarea name="_query" cols="40" rows="4" style="width:100%"></textarea>
	<div class="info">
	REQUIRED. The SQL query string execute to retrieve values to use to popular the select's options.
	e.g. "SELECT userid, username FROM users"
	</div>
	</td></tr>
	<tr><td width=95>Query Value Column:</td><td><input type="text" name="_queryvaluecolumn" size="40" style="width:100%">
	<div class="info">
	OPTIONAL. Default is "valueCol".
	This is the name of the field returned by the query to use as the text value for each select interface option.
	</div>
	</td></tr>
	<tr><td width=95>Display Value Column:</td><td><input type="text" name="_querydisplaycolumn" size="40" style="width:100%">
	<div class="info">
	OPTIONAL. Default is "displayCol".
	This is the name of the field returned by the query to use as the text value for each select interface option.
	</div>
	</td></tr>
	</table>
</div>
<div id="istyle_opt2" style="display:none;">
	<table cellpadding=7 cellspacing=0 border=0 width="100%">
	<tr><td width=95>Value List:</td><td><textarea name="_vallist" cols="40" rows="4" style="width:100%"<cfif interface EQ "select_number"> onkeypress="ensureIntOrComma(this)"</cfif>></textarea>
	<div class="info">
	REQUIRED. A comma separated list of values to use to populate the select interface options.
	</div>
	</td></tr>
	<tr><td width=95>Display List:</td><td><textarea name="_displaylist" cols="40" rows="4" style="width:100%"></textarea>
	<div class="info">
	OPTIONAL. The optional display names to use for each corresponding value in the list valList, again comma separated.
	If not defined, the values in valList will be also used as the display values.
	</div>
	</td></tr>
	</table>
</div>
<div id="istyle_opt3" style="display:none;">
	<table cellpadding=7 cellspacing=0 border=0 width="100%">
	<tr><td width=95>Range Start:</td><td><input type="text" name="_rangestart" size="40" style="width:100%">
	<div class="info">
	REQUIRED. The starting number of the range.
	</div>
	</td></tr>
	<tr><td width=95>Range End:</td><td><input type="text" name="_rangeend" size="40" style="width:100%">
	<div class="info">
	REQUIRED. The ending number of the range.
	</div>
	</td></tr>
	<tr><td width=95>Range Step:</td><td><input type="text" name="_rangestep" size="40" style="width:100%">
	<div class="info">
	OPTIONAL. Default is 1. The increment step to use to span the range.
	</div>
	</td></tr>
	</table>
</div>

</td></tr>
<tr><td>Can Edit?</td><td><input type="checkbox" name="_edit">
<div class="info">
Can this interface be edited or is it just for display purposes?
</div>
</td></tr>
<tr><td>Required?</td><td><input type="checkbox" name="_notnull">
<div class="info">
Check this option to force the user to enter the some text.
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
<cfif interface EQ "select_text">
		var __bMultiple = getVar("multiple").toLowerCase();
		if( __bMultiple == "" ) __bMultiple = 0;//DEFAULT - NOT MULTIPLE
		if( __bMultiple != "no" && __bMultiple ) _multiple.checked = true;
		else _multiple.checked = false;
</cfif>
		_size.value = getVar("size");
		
		_query.value = getVar("query");
		_queryvaluecolumn.value = getVar("queryvaluecolumn");
		_querydisplaycolumn.value = getVar("querydisplaycolumn");
		_vallist.value = getVar("vallist");
		_displaylist.value = getVar("displaylist");
		_rangestart.value = getVar("rangestart");
		_rangeend.value = getVar("rangeend");
		_rangestep.value = getVar("rangestep");

		//decide which interface is currently selected...
		if(_query.value!="") document.getElementById("is1").click();
		else if(_vallist.value!="") document.getElementById("is2").click();
		else if(_rangestart.value) document.getElementById("is3").click();
		
		
		var bCanEdit = getVar("edit").toLowerCase();
		if( bCanEdit == "" ) bCanEdit = 1;//DEFAULT - CAN EDIT
		if( bCanEdit != "no" && bCanEdit ) _edit.checked = true; else _edit.checked = false;
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
		if( _display.value=="" ) errMsg = "'Display' cannot be blank.";
		if( istyle[1].checked && _displaylist.value!="" && _vallist.value.split(",").length != _displaylist.value.split(",").length )  errMsg = "'Display List' and 'Value List' must have the same amount of items.";
		if( errMsg!="" ){alert("Errors in form.\n\n"+errMsg);return;}

		//clear the old values
		doVarReset();
	
		//do the update
		setVar("display",_display.value);
		parent.document.getElementById('fieldListTable').rows[fieldNo].cells[4].childNodes[0].value = _display.value;
		setVar("default",_default.value);
		<cfif interface EQ "select_text">
			setVar("multiple",(_multiple.checked)? "yes":"no");
		</cfif>
		setVar("size",_size.value);
		
		if( istyle[0].checked )
		{
			setVar("query",_query.value);
			setVar("queryvaluecolumn",_queryvaluecolumn.value);
			setVar("querydisplaycolumn",_querydisplaycolumn.value);
		}
		else if( istyle[1].checked )
		{
			setVar("vallist",_vallist.value);
			setVar("displaylist",_displaylist.value);
		}
		else
		{
			setVar("rangestart",_rangestart.value);
			setVar("rangeend",_rangeend.value);
			setVar("rangestep",_rangestep.value);
		}
		
		setVar("edit",(_edit.checked)? "yes":"no");
		setVar("notnull",(_notnull.checked)? "yes":"no");
		setVar("style",_style.value);
	}
	//after updating, switch back to editRecordView
	parent.document.getElementById('fieldlistTabH2').click();
}
var lastI=0;
function showInterface(i)
{
	if(lastI) document.getElementById('istyle_opt'+lastI).style.display='none';
	document.getElementById('istyle_opt'+i).style.display='block';
	lastI=i;
}
</script>
