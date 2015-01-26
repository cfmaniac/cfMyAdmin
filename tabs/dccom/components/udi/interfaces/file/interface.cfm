<cfif NOT assocAttribs[ attribIndex ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>
<cfset fileNum = fileNum + 1>
<cfparam name="assocAttribs[ #attribIndex# ].size" default="1">
<cfparam name="assocAttribs[ #attribIndex# ].filePath" default="">
<cfif assocAttribs[ attribIndex ].filePath IS "">
	<cfset dirPath = GetDirectoryFromPath(GetBaseTemplatePath())>
	<cf_dropDownOneDir dirVariable="dirPath"><cf_dropDownOneDir dirVariable="dirPath"><cf_dropDownOneDir dirVariable="dirPath">
	<cfset assocAttribs[ attribIndex ].filePath = dirPath>
</cfif>
<cfif NOT DirectoryExists( assocAttribs[ attribIndex ].filePath )>
	<cfoutput>
	<h4>Error</h4>
	Directory "#assocAttribs[ attribIndex ].filePath#"<br>
	doesn't exist for field "#dbField#".
	</cfoutput>
	<cfabort>
</cfif>

<cfparam name="assocAttribs[ #attribIndex# ].disableUpload" default="0">
<cfparam name="assocAttribs[ #attribIndex# ].filter" default="">
<cfparam name="assocAttribs[ #attribIndex# ].showfilepath" default="no">
<cfparam name="assocAttribs[ #attribIndex# ].sort" default="Type,Name">
<cfparam name="assocAttribs[ #attribIndex# ].nameconflict" default="OVERWRITE">
<cfparam name="assocAttribs[ #attribIndex# ].notNull" default="false">

<cfdirectory action="LIST" directory="#assocAttribs[ attribIndex ].filePath#" name="getDir" filter="#assocAttribs[attribIndex].filter#" sort="#assocAttribs[attribIndex].sort#">

<cfoutput>
	<cfif fileNum IS 1>
	<script>
	function uploadFile(fileNum)
	{
		var ufw=window.open("interfaces/file/fileupload.cfm?fileNum="+fileNum+"&ref=#JSStringFormat(URL.ref)#",'uf'+fileNum,'width=450,height=190,resizable=yes,toolbar=no');
	}
	function setFSOption(dbField,a,b)
	{
		with( eval("document.editForm."+dbField) ){
			options[options.length] = new Option(a,b);
		}
	}
	function fViewFile(fileNum,dbField)
	{
		with( eval("document.editForm."+dbField) ){
			if( value != "" ) window.open("interfaces/file/filedownload.cfm?fileNum="+fileNum+"&ref=#JSStringFormat(URL.ref)#&f="+escape(value),'df'+fileNum,'width=800,height=600,resizable=yes,toolbar=no');
		}
	}
	</script>
	</cfif>
	<cfif assocAttribs[attribIndex].showfilepath>
		<div>File Path: "#assocAttribs[ attribIndex ].filePath#"</div>
	</cfif>
	<select name="#dbField#"<cfif cStyle NEQ ""> style="#cStyle#"</cfif> <cfif NOT assocAttribs[ #attribIndex# ].edit> onchange="<cfif dbFieldVal NEQ "">this.value='#JSStringFormat(dbFieldVal)#';</cfif>if(this.selectedIndex==-1)this.selectedIndex=0;"<cfelse> onchange="hasChanged()"</cfif><cfif assocAttribs[ attribIndex ].size GT 1> size="#assocAttribs[ attribIndex ].size#"</cfif>>
		<cfif NOT assocAttribs[attribIndex].notNull><option value="">NO FILE</cfif>
		<cfloop query="getDir"><cfif Left(Name,1) NEQ "."><cfif type EQ "file">
			<option value="#Name#"<cfif Name EQ dbFieldVal> selected</cfif>>#Name#
		</cfif></cfif></cfloop>
	</select>
	<input type="button" value="View/Download" onClick="fViewFile(#fileNum#,'#JSStringFormat(dbField)#')">
	<cfif NOT assocAttribs[ attribIndex ].disableUpload>
		<input type="button" value="Upload File" onClick="uploadFile(#fileNum#)"<cfif NOT assocAttribs[ attribIndex ].edit> disabled</cfif>>
	</cfif>
</cfoutput>
