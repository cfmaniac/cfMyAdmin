<!--- image --->

<form name="editForm">
<table width="100%" cellpadding=7 cellspacing=0 border=0>
<tr><td width="95">Display Name:</td><td><input type="text" name="_display" size="40" value=""></td></tr>
<tr><td width="95">Default Value:</td><td><input type="text" name="_default" size="40" value=""></td></tr>
<tr><td>Size:</td><td><input type="text" name="_size" size="5" value="" onkeypress="ensureInt(this)"></td></tr>
<tr><td>Show Preview Image?:</td><td>
<input type="radio" name="_previewimage" value="" id="_pi1"><label for="_pi1">Default (No Preview)</label>
<input type="radio" name="_previewimage" value="yes" id="_pi2"><label for="_pi2">Yes (Display Preview)</label>
<input type="radio" name="_previewimage" value="no" id="_pi3"><label for="_pi3">No (No Preview)</select></label>
<div class="info">
Default is "no". Should a preview of the selected image file be displayed on the edit record interface?
</div>
</td></tr>
<tr><td width="95">Preview Width:</td><td><input type="text" name="_previewwidth" size="5" value="" onkeypress="ensureInt(this)">
<div class="info">
Optional. This is the width that any image previews will be previewed at - this prevents a large image taking up too much room in the edit form.
If no value is entered, image will be full size.
</div>
</td></tr>
<tr><td width="95">URL Path:</td><td>
<input type="text" name="_urlpath" size="50" value="">
<a href="javascript:selectAppVar('editForm._urlpath')"><img src="but_select2.gif" width="17" height="17" alt="" border="0" align="absmiddle">Select Application Variable</a>
<div class="info">REQUIRED.
Set this to the _FULL_ URL path to the root of the directory you want to select images from.
It is important that you include the trailing slash in this path. e.g. "http://server/images/".
</div>
</td></tr>
<tr><td width="95">File Path:</td><td>
<input type="text" name="_filepath" size="50" value="">
<a href="javascript:selectAppVar('editForm._filepath')"><img src="but_select2.gif" width="17" height="17" alt="" border="0" align="absmiddle">Select Application Variable</a>
<div class="info">
REQUIRED. Set this to the _FULL_ file path to the root of the directory you want to select the image from. It is important that you include the trailing slash in this path
e.g. "c:\inetpub\wwwroot\site\images\".
</div>
</td></tr>
<tr><td>Disable Upload?:</td><td>
<input type="radio" name="_disableupload" value="" id="_du1"><label for="_du1">Default (Upload Is Allowed)</label>
<input type="radio" name="_disableupload" value="yes" id="_du2"><label for="_du2">Yes - Upload Is Disabled</label>
<input type="radio" name="_disableupload" value="no" id="_du3"><label for="_du3">No - Upload Is Allowed</select></label>
<div class="info">
Decide whether or not to allow the user to upload new .jpg and .gif images to the server.
</div>
</td></tr>
<tr><td>Resize?:</td><td><input type="text" name="_resize" size="5" value="" onkeypress="ensureInt(this)"><br>
<div class="info">
OPTIONAL. If you enter a value here, any uploaded images will be resized to have a WIDTH of this value.
For resizing to work, the free CFX tag <a href="http://www.google.com/search?q=CFX%5FImage" target="_blank">CFX_Image</a> must be installed on the server.
</div>
</td></tr>
<tr><td>Create Thumbnails?:</td><td>
<input type="radio" name="_createthumbnails" value="" id="_ct1"><label for="_ct1">Default (No)</label>
<input type="radio" name="_createthumbnails" value="yes" id="_ct2"><label for="_ct2">Yes - Create Thumbnails</label>
<input type="radio" name="_createthumbnails" value="no" id="_ct3"><label for="_ct3">No - Don't Need Thumbnails</select></label>
<div class="info">
ADVANCED. OPTIONAL. If "yes" then whenever an image is uploaded to the server with this interface, a thumbnail of that image will be generated.
If this option is set to yes... then the next two fields should be defined with valid URL and File paths to the
thumbnail directory so that the real images and thumbnails are not in the same directory.
</div>
</td></tr>
<tr><td width="95">Thumbnail URL Path:</td><td>
<input type="text" name="_thumb_urlpath" size="50" value="">
<a href="javascript:selectAppVar('editForm._thumb_urlpath')"><img src="but_select2.gif" width="17" height="17" alt="" border="0" align="absmiddle">Select Application Variable</a>
<div class="info">
ADVANCED. OPTIONAL. Default is URL Path (see above). Use this create thumbnails into a directory other that the one the real image has been uploaded to.
e.g. "http://server/images/thumbnails/".
</div>
</td></tr>
<tr><td width="95">Thumbnail File Path:</td><td>
<input type="text" name="_thumb_filepath" size="50" value="">
<a href="javascript:selectAppVar('editForm._thumb_filepath')"><img src="but_select2.gif" width="17" height="17" alt="" border="0" align="absmiddle">Select Application Variable</a>
<div class="info">
ADVANCED. OPTIONAL. Default is filePath (see above). Used to create thumbnails into a directory other that the one the real image has been uploaded to.
e.g. "c:\inetpub\wwwroot\site\images\thumbnails\".
</div>
</td></tr>
<tr><td width="95">Thumbnail Size:</td><td>
<input type="text" name="_thumb_resize" size="5" value="" onkeypress="ensureInt(this)">
<div class="info">
ADVANCED. OPTIONAL. Default is 50. This is the width thumbnails will be resized to if they are created.
</div>
</td></tr>
<tr><td width="95">Thumbnail Prepend:</td><td>
<input type="text" name="_thumb_fileprepend" size="10" value="">
<div class="info">
ADVANCED. OPTIONAL. Default is "thumb_". This text will be preprended to any generated thumbnails.
e.g. if prepend is "thumb_" and "superted.jpg" is uploaded, the thumbnail will be named "thumb_superted.jpg".
</div>
</td></tr>
<tr><td width="95">Thumbnail Append:</td><td>
<input type="text" name="_thumb_fileappend" size="10" value="">
<div class="info">
ADVANCED. OPTIONAL. Default is "". This text will be appended to any generated thumbnails.
e.g. If append is "_thumbnail" and "superted.jpg" is uploaded, the thumbnail will be named "superted_thumbnail.jpg".
</div>
</td></tr>

<tr><td>Can Edit?</td><td><input type="checkbox" name="_edit"><br>
<div class="info">
Can this interface be edited or is it just for display purposes.?
</div>
</td></tr>
<tr><td>Required?</td><td><input type="checkbox" name="_notnull"><br>
<div class="info">
Check this option to force the user to select an image.
</div>
</td></tr>
<tr><td>CSS Style:</td><td><input type="text" name="_style" size="50" style="width:100%" value=""><br>
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
		_size.value = getVar("size");

		var __previewimage = getVar("previewimage").toLowerCase();

		if( __previewimage == "" ) _previewimage[0].checked = true;
		else if( __previewimage == 0 || __previewimage == 'no' ) _previewimage[2].checked = true;
		else  _previewimage[1].checked = true;

		_previewwidth.value = getVar("previewwidth");
		_urlpath.value = getVar("urlpath");
		_filepath.value = getVar("filepath");

		var __disableupload = getVar("disableupload").toLowerCase();
		if( __disableupload == "" ) _disableupload[0].checked = true;
		else if( __disableupload == 0 || __disableupload == 'no' ) _disableupload[2].checked = true;
		else  _disableupload[1].checked = true;
		_resize.value = getVar("resize");
		var __createthumbnails = getVar("createthumbnails").toLowerCase();
		if( __createthumbnails == "" ) _createthumbnails[0].checked = true;
		else if( __createthumbnails == 0 || __createthumbnails == 'no' ) _createthumbnails[2].checked = true;
		else  _createthumbnails[1].checked = true;
		_thumb_urlpath.value = getVar("thumb_urlpath");
		_thumb_filepath.value = getVar("thumb_filepath");
		_thumb_resize.value = getVar("thumb_resize");
		_thumb_fileappend.value = getVar("thumb_fileappend");
		_thumb_fileprepend.value = getVar("thumb_fileprepend");
		
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
		if( _urlpath.value=="" ) errMsg = errMsg + "'URL Path' cannot be blank";
		if( _display.value=="" ) errMsg = errMsg + "'Display' cannot be blank";
		if( _filepath.value=="" ) errMsg = errMsg + "'File Path' cannot be blank";
		if( errMsg!="" ){alert("Errors in form.\n\n"+errMsg);return;}
		
		//clear the old values
		doVarReset();

		//do the update
		setVar("display",_display.value);
		parent.document.getElementById('fieldListTable').rows[fieldNo].cells[4].childNodes[0].value = _display.value;
		setVar("default",_default.value);
		setVar("size",_size.value);
		setVar("previewimage", getRadioVal(_previewimage));
		setVar("previewwidth",_previewwidth.value);
		setVar("urlpath",_urlpath.value);
		setVar("filepath",_filepath.value);
		setVar("disableupload", getRadioVal(_disableupload));
		setVar("resize",_resize.value);
		setVar("createthumbnails", getRadioVal(_createthumbnails));
		setVar("thumb_urlpath",_thumb_urlpath.value);
		setVar("thumb_filepath",_thumb_filepath.value);
		setVar("thumb_resize",_thumb_resize.value);
		setVar("thumb_resize",_thumb_resize.value);
		setVar("thumb_fileprepend",_thumb_fileprepend.value);
		setVar("thumb_fileappend",_thumb_fileappend.value);
		
		setVar("edit",(_edit.checked)? "yes":"no");
		setVar("notnull",(_notnull.checked)? "yes":"no");
		setVar("style",_style.value);
	}
	//after updating, switch back to editRecordView
	parent.document.getElementById('fieldlistTabH2').click();
}
</script>
