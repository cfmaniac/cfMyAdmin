<!--- text --->

<form name="editForm">
<table width="100%" cellpadding=7 cellspacing=0 border=0>
<tr><td width="95">Display Name:</td><td><input type="text" name="_display" size="40" value=""></td></tr>
<tr><td width="95">Default Value:</td><td><textarea name="_default" col="50" rows=5 style="width:100%"></textarea></td></tr>
<tr><td>Width:</td><td><input type="text" name="_width" size="5" value="">
	<div class="info">OPTIONAL. Default Width is 100%.</div>
</td></tr>
<tr><td>Height:</td><td><input type="text" name="_height" size="5" value="">
	<div class="info">OPTIONAL. Default Height is 200.</div>
</td></tr>
<tr><td>Can Edit?</td><td><input type="checkbox" name="_edit">
	<div class="info">Can this interface be edited or is it just for display purposes?</div>
</td></tr>
<tr><td>Required?</td><td><input type="checkbox" name="_notnull">
	<div class="info">Check this option to force the user to enter the some text.</div>
</td></tr>
<tr><td>Background Color:</td><td><input type="text" name="_bgcolor" size="9" maxlength=12 value="">
	<div class=info>OPTIONAL. Default is "white". The background color of the WYSIWYG.</div>
</td></tr>
<tr><td>Text Color:</td><td><input type="text" name="_color" size="9" maxlength=12 value="">
	<div class=info>OPTIONAL. Default is "black". The default color of the WYSIWYG text.</div>
</td></tr>
<tr><td>Padding:</td><td><input type="text" name="_padding" size="6" maxlength=12 value="" onkeypress="ensureInt(this)">
	<div class=info>OPTIONAL. Default is 5. The amount of padding on the WYSIWYG. Maximum 20.</div>
</td></tr>
<tr><td>CSS Style:</td><td><input type="text" name="_style" size="50" style="width:100%" value="">
	<div class="info">OPTIONAL. If defined, this css style will be applied to the WYSIWYG</div>
</td></tr>
<tr><td>Edit Style:</td><td><textarea name="_editstyle" col="50" rows=3 style="width:100%"></textarea>
	<div class="info">OPTIONAL. If defined, this css style will be applied to the WYSIWYG HTML and will override settings in any referenced CSS file.</div>
</td></tr>
<tr><td>BASE HREF:</td><td><input type="text" name="_basehref" size="50" style="width:100%" value="">
	<div class="info">Optional. If supplied, the WYSIWYG will use this base href. Setting this attribute is <strong>highly recommended</strong>, as it allows the editor to turn absolute image paths into relative ones, useful if you ever move the site e.g. from development to production URLs.</div>
</td></tr>
<tr><td>Style Sheet URL:</td><td><input type="text" name="_stylesheet" size="50" style="width:100%" value="">
	<div class="info">OPTIONAL. The full URL path to a stylesheet to use with the WYSIWYG html. e.g. stylesheet="http://www.yourserver.com/myStyleSheet.css". This is highly recommended because it allows the user to see exactly how the HTML will look on screen.</div>
</td></tr>
<tr><td>URL Path:</td><td><input type="text" name="_URLPath" size="50" style="width:100%" value="">
	<div class="info">OPTIONAL. Default is dcCom UDI directory url. It is highly recommended that you set this to the _FULL_ URL path to the root of the directory you want to select the insert images from. It is important that you include the trailing slash in this path. e.g. "http://server/images/".</div>
</td></tr>
<tr><td>File Path:</td><td><input type="text" name="_filePath" size="50" style="width:100%" value="">
	<div class="info">OPTIONAL. Default is dcCom UDI directory path. It is highly recommended that you set this to the _FULL_ file path to the root of the directory you want to select the insert images from. It is important that you include the trailing slash in this path e.g. "c:\inetpub\wwwroot\site\images\".</div>
</td></tr>
<tr><td>Super Mode Option:</td><td><input type="checkbox" name="_superModeOption">
	<div class="info">OPTIONAL. Default is "yes". If "yes", a superman icon will appear in the toolbar to give the user the option to invoke a more powerful WYSIWYG editor in a pop-up window. <strong>Requires dcCom component dcVRichEdit</strong>. (1="yes"=1,0="no"=0)</div>
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
		_width.value = getVar("width");
		_height.value = getVar("height");
		_bgcolor.value = getVar("bgcolor");
		_color.value = getVar("color");
		_padding.value = getVar("padding");
		_style.value = getVar("style");
		_editstyle.value = getVar("editstyle");
		_basehref.value = getVar("basehref");
		_stylesheet.value = getVar("stylesheet");
		_URLPath.value = getVar("urlpath");
		_filePath.value = getVar("filepath");
		var bSuperModeOption = getVar("supermodeoption");
		if( bSuperModeOption == "" ) bSuperModeOption = 1;//DEFAULT - CAN EDIT
		_superModeOption.checked = ( bSuperModeOption != "no" && bSuperModeOption );
		var bCanEdit = getVar("edit").toLowerCase();
		if( bCanEdit == "" ) bCanEdit = 1;//DEFAULT - CAN EDIT
		_edit.checked = ( bCanEdit != "no" && bCanEdit );
		var bNotNull = getVar("notnull").toLowerCase();
		_notnull.checked = ( bNotNull != "no" && bNotNull );
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
		if(_width.value!="") setVar("width",_width.value);
		if(_height.value!="") setVar("height",_height.value);
		if(_bgcolor.value!="") setVar("bgcolor",_bgcolor.value);
		if(_color.value!="") setVar("color",_color.value);
		if(_padding.value!="") setVar("padding",Math.min(_padding.value,20));
		if(_style.value!="") setVar("style",_style.value);
		if(_editstyle.value!="") setVar("editstyle",_editstyle.value);
		if(_basehref.value!="") setVar("basehref",_basehref.value);
		if(_stylesheet.value!="") setVar("stylesheet",_stylesheet.value);
		if(_URLPath.value!="") setVar("urlpath",_URLPath.value);
		if(_filePath.value!="") setVar("filepath",_filePath.value);
		setVar("supermodeoption",(_superModeOption.checked)? "yes":"no");
		setVar("edit",(_edit.checked)? "yes":"no");
		setVar("notnull",(_notnull.checked)? "yes":"no");
	}
	//after updating, switch back to editRecordView
	parent.document.getElementById('fieldlistTabH2').click();
}
</script>
