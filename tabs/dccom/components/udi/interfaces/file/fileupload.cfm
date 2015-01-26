<cfsetting enablecfoutputonly="Yes">

<!--- Load the attributes --->	
<cfmodule template="..\..\serializeAttributes.cfm" method="load" uid="#ref#">

<cfset fileNo = 0>
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif assocAttribs[i].type EQ "file">
		<cfset fileNo = fileNo + 1>
		<cfif fileNo IS fileNum>
			<cfset fileData = assocAttribs[i]>
		</cfif>
	</cfif>
</cfloop>

<cfsetting enablecfoutputonly="No">
<cfoutput>
<html>
<head>
	<title>File Upload - "#fileData.display#"</title>
<style>
body{
margin:0px;
background-color:buttonface;
}
td{font:7pt verdana,arial black;}
</style>
</head>
<body>

<table cellpadding="0" cellspacing="2" border="0" width="100%" height="100%"><tr><td valign="top">
	<fieldset style="padding:0px; width: 100%; height: 100%"><legend>File Uploader</legend>
	
<cfif NOT isdefined("action")><!--- SELECT UPLOAD FILES --->

	<script language="JavaScript1.2" defer>
	function doTest()
	{
		<cfif fileData.filter NEQ "">
		var notTypeMsg = "Sorry only files of type \"#JSStringFormat(fileData.filter)#\" are supported.";
		</cfif>
		with(document.uploader)
		{
			if( thefile1.value == "" && thefile2.value == "" && thefile3.value == "" ) {alert("Please select a file to upload.");return false;}
			<cfif fileData.filter NEQ "">
				<cfset filterList = replace(fileData.filter,"*","","ALL")>
				<cfif ListLen(filterList) GTE 1>
			if( thefile1.value != ""<cfloop list="#filterList#" index="f"> && thefile1.value.toLowerCase().indexOf("#JSStringFormat(f)#")==-1</cfloop>) {alert(notTypeMsg);return false;}
			else if( thefile2.value != ""<cfloop list="#filterList#" index="f"> && thefile2.value.toLowerCase().indexOf("#JSStringFormat(f)#")==-1</cfloop>) {alert(notTypeMsg);return false;}
			else if( thefile3.value != ""<cfloop list="#filterList#" index="f"> && thefile3.value.toLowerCase().indexOf("#JSStringFormat(f)#")==-1</cfloop>) {alert(notTypeMsg);return false;}
			else </cfif></cfif>if( thefile1.value == "" && thefile2.value == "" && thefile3.value == "" ) return false;
			else if(( thefile1.value!= "" && thefile1.value == thefile2.value )
				||	( thefile1.value!= "" && thefile1.value == thefile3.value )
				||	( thefile2.value!= "" && thefile2.value == thefile3.value ))
				{
					alert("You have selected the same file twice!");
					return false;
				}
		}
		document.uploader.submit()
	}
	</script>

	<table align="center" width="100%" height="80%" cellpadding="8">
	<form name="uploader" action="fileupload.cfm" enctype="multipart/form-data" method="post">
	<input type="hidden" name="action" value="upload">
	<input type="hidden" name="ref" value="#ref#">
	<input type="hidden" name="fileNum" value="#fileNum#">
	<tr><td valign="bottom">Choose one or more files to upload:<cfif fileData.filter NEQ ""> (#fileData.filter#)</cfif></td></tr>
	<tr><td valign="top" align="center">
		<table cellpadding=0 cellspacing=0 border=0 width="100%">
		<tr><td width="20">1.</td><td><input size="40" type="File" name="thefile1" style="width:100%"></td></tr>
		<tr><td width="20">2.</td><td><input size="40" type="File" name="thefile2" style="width:100%"></td></tr>
		<tr><td width="20">3.</td><td><input size="40" type="File" name="thefile3" style="width:100%"></td></tr>
		</table>
	</td></tr>
	<tr><td align="right" valign="bottom">
	<input type="button" value="Cancel" onclick="window.close()">
	<input type="Reset">
	<input id="but" type="button" value="Upload Selected Files" onClick="doTest()"></td></tr>
	</form></table>
	
<cfelse><!--- DO UPLOAD --->
	
	<!--- Upload File --->
	<cfset uploadCount = 0>
	<cfset uploadedList = "">
	<cfloop index="i" from="1" to="3">
		<cfif isdefined("thefile"&i) AND Evaluate("thefile"&i) NEQ "">
		
			<CFSET NEWLINE = chr(13)&chr(10)>
			<cfset errMessage = "">
			<cfset rootpath = fileData.filePath>
			
			<!----------------------------------------------------------------------------------------->
			<!--- Upload the File																--->
			<!----------------------------------------------------------------------------------------->
			<cffile action="upload" nameconflict="#fileData.nameconflict#" filefield="#('thefile'&i)#" destination="#rootpath#">
			<cfset uploadCount = uploadCount + 1>
			<cfset uploadedList = ListAppend(uploadedList,ServerFile )>
			
		</cfif>
	</cfloop>

	<table cellpadding="5" cellspacing="0" width="100%" height="80%" align="center">
	<form name="goAgain" action="fileupload.cfm" method="post">
	<input type="hidden" name="ref" value="#ref#">
	<input type="hidden" name="fileNum" value="#fileNum#">
	<tr><td colspan="2">
		<font face="verdana,arial" size=3><b>#uploadCount# File<cfif uploadCount NEQ 1>s</cfif> Uploaded Successfully</b></font><br>
		<table cellpadding="0" cellspacing="0" border="0" width="70%">
		<small>Uploaded:<ul style="list-style-type : square;">
		<cfloop index="i" list="#uploadedList#">
			<li>#i#</li>
		</cfloop>
		</ul><small>
		</table>
	</td></tr>
	<tr>
		<td align="center" valign="bottom">
			<input type="button" value="Upload More Files" onClick="document.goAgain.submit()">
			<input type="button" value="Finished" onClick="window.close();">
		</td>
	</tr>
	</form>
	</table>
	
	<cfif errMessage EQ "">
		<script language="JavaScript1.2">
		if( window.opener && window.opener.document.editForm)
		{
			window.opener.document.editForm.#fileData.field#.options.length = 0;
			<cfif NOT fileData.notNull>
				window.opener.setFSOption("#JSStringFormat(fileData.field)#","NO FILE","-");
			</cfif>
			<cfdirectory action="LIST" directory="#fileData.filePath#" name="getDir" filter="#fileData.filter#" sort="#fileData.sort#">
			<cfloop query="getDir"><cfif Left(Name,1) NEQ "."><cfif type EQ "file">
				window.opener.setFSOption("#JSStringFormat(fileData.field)#","#JSStringFormat(Name)#","#JSStringFormat(Name)#");
			</cfif></cfif></cfloop>
			window.opener.document.editForm.#fileData.field#.value = "#JSStringFormat( ListGetAt(uploadedList,1) )#";
			window.opener.hasChanged();
		}
		setTimeout("window.close()",6000);
		</script>
	</cfif>
	
</cfif>

	</fieldset>

</td></tr></table>

</body>
</html>
</cfoutput>
