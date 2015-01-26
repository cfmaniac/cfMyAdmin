<cfif NOT assocAttribs[ attribIndex ].edit>
	<img src="lock.gif" width="14" height="17" alt="" border="0" align="left">
</cfif>
<cfset imageNum = imageNum + 1>
<cfparam name="assocAttribs[ #attribIndex# ].size" default="30">
<cfparam name="assocAttribs[ #attribIndex# ].previewImage" default="1">
<cfparam name="assocAttribs[ #attribIndex# ].URLPath" default="">
<cfparam name="assocAttribs[ #attribIndex# ].filePath" default="#GetDirectoryFromPath(GetBaseTemplatePath())#">
<cfparam name="assocAttribs[ #attribIndex# ].resize" default="0">
<cfparam name="assocAttribs[ #attribIndex# ].disableUpload" default="0">
<cfparam name="assocAttribs[ #attribIndex# ].previewWidth" default="0">
<cfparam name="assocAttribs[ #attribIndex# ].createThumbnails" default="0">
<cfif assocAttribs[ attribIndex ].createThumbnails>
	<cfparam name="assocAttribs[ #attribIndex# ].thumb_URLPath" default="#assocAttribs[ attribIndex ].URLPath#">
	<cfparam name="assocAttribs[ #attribIndex# ].thumb_filepath" default="#assocAttribs[ attribIndex ].filePath#">
	<cfparam name="assocAttribs[ #attribIndex# ].thumb_reSize" default="50">
	<cfparam name="assocAttribs[ #attribIndex# ].thumb_FilePrepend" default="">
	<cfparam name="assocAttribs[ #attribIndex# ].thumb_FileAppend" default="">
</cfif>
<cfif assocAttribs[ attribIndex ].previewImage AND assocAttribs[ #attribIndex# ].createThumbnails AND assocAttribs[ attribIndex ].thumb_URLPath NEQ "">
	<cfset thumbnailsEnabled = 1>
<cfelse>
	<cfset thumbnailsEnabled = 0>
</cfif>
<cfif assocAttribs[ attribIndex ].previewImage AND ( assocAttribs[ attribIndex ].URLPath EQ "" AND NOT thumbnailsEnabled )>
	<cfset assocAttribs[ attribIndex ].previewImage = 0>
</cfif>
<cfoutput>
<cfif assocAttribs[ attribIndex ].previewImage>
	<!--- Should we use the img root or thumbnail root? --->
	<cfif thumbnailsEnabled>
		<cfset imgRoot = assocAttribs[ attribIndex ].thumb_URLPath>
	<cfelse>
		<cfset imgRoot = assocAttribs[ attribIndex ].URLPath>
	</cfif>
	<cfif dbFieldVal EQ "">
		<cfset imgPrevSrc = "spacer.gif">
	<cfelse>
		<cfset imgPrevSrc = imgRoot & dbFieldVal>
	</cfif>

	<img name="imgPrev#dbField#" src="#imgPrevSrc#" border="<cfparam name="assocAttribs[ #attribIndex# ].border" default="0">#assocAttribs[ attribIndex ].border#"<cfif assocAttribs[ attribIndex ].previewWidth> width="#assocAttribs[ attribIndex ].previewWidth#"</cfif> alt="" border="0"><br>
</cfif>
	<input type="text" name="#dbField#" size="#assocAttribs[ attribIndex ].size#" value="#dbFieldVal#"<cfif cStyle NEQ ""> style="#cStyle#"</cfif> <cfif NOT assocAttribs[ #attribIndex# ].edit> onkeydown="return false;"<cfif cStyle EQ ""> style="color:##505050;"</cfif><cfelse> onkeydown="hasChanged()"</cfif>>
	<cfset CIattribs = imageNum>
	<cfif assocAttribs[ attribIndex ].previewImage>
		<cfset CIattribs = CIattribs & ",1">
	<cfelse>
		<cfset CIattribs = CIattribs & ",0">
	</cfif>
	<cfset CIattribs = CIattribs & ", """ & assocAttribs[ attribIndex ].field & """">
	<cfset CIattribs = CIattribs & ",""" & JSStringFormat(assocAttribs[ attribIndex ].URLPath) & """">
	<cfset CIattribs = CIattribs & ",""" & JSStringFormat(assocAttribs[ attribIndex ].filePath) & """">
	<cfset CIattribs = CIattribs & "," & assocAttribs[ attribIndex ].resize>
	<cfif assocAttribs[ attribIndex ].disableUpload>
		<cfset CIattribs = CIattribs & ",1">
	<cfelse>
		<cfset CIattribs = CIattribs & ",0">
	</cfif>
	<cfif assocAttribs[ attribIndex ].createThumbnails>
		<cfset CIattribs = CIattribs & ",""" & JSStringFormat(assocAttribs[ attribIndex ].thumb_URLPath)& """">
		<cfset CIattribs = CIattribs & ",""" & JSStringFormat(assocAttribs[ attribIndex ].thumb_filepath) & """">
		<cfset CIattribs = CIattribs & "," & JSStringFormat(assocAttribs[ attribIndex ].thumb_reSize)>
		<cfset CIattribs = CIattribs & ",""" & JSStringFormat(assocAttribs[ attribIndex ].thumb_FilePrepend) & """">
		<cfset CIattribs = CIattribs & ",""" & JSStringFormat(assocAttribs[ attribIndex ].thumb_FileAppend) & """">
	</cfif>
	<input type="button" onClick='<cfif NOT assocAttribs[#attribIndex#].EDIT>void();<cfelse>chooseImage(#CIattribs#);</cfif>' value="Choose Image"<cfif NOT assocAttribs[ #attribIndex# ].edit> style="color:##505050;"</cfif>>
</cfoutput>
