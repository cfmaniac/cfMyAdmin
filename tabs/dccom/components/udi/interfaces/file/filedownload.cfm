<cfparam name="ref">

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

<cfset filePath = fileData.filePath & f> 
<cfif NOT fileExists(filePath)>
	<html><head><title>Error</title><style>td,body{font:11px verdana,arial,sans-serif;}</style></head><body>Sorry, file must have been deleted.</body></html>
	<cfabort>
</cfif>

<!--- Change the mime type and spit out the file --->
<cfheader NAME="Content-disposition" VALUE="inline;filename=#filePath#">
<cfset extNo = ListLen(filePath,".")>
<cfif extNo GT 1>
	<cfset ext = "." & ListGetAt(filePath,extNo,".")>
<cfelse>
	<cfset ext = "">
</cfif>

<cfswitch expression="#ext#">
	<cfcase value=".cfm,.txt,.htm,.html,.log,.asp,.jsp,.css">
		<CFCONTENT TYPE="text/plain" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".exe">
		<CFCONTENT TYPE="application/octet-stream" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".zip">
		<CFCONTENT TYPE="application/zip" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".jpeg,.jpg">
		<CFCONTENT TYPE="image/jpeg" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".gif">
		<CFCONTENT TYPE="image/gif" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".bmp">
		<CFCONTENT TYPE="image/bmp" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".png">
		<CFCONTENT TYPE="image/png" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".doc">
		<CFCONTENT TYPE="application/msword" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfcase value=".xls">
		<CFCONTENT TYPE="application/excel" FILE="#filePath#" DELETEFILE="no">
	</cfcase>
	<cfdefaultcase>
		<CFCONTENT TYPE="application/octet-stream" FILE="#filePath#" DELETEFILE="no">
	</cfdefaultcase>
</cfswitch>