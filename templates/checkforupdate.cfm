<cfhttp url="http://www.cfmyadmin.com/version.dcv" method="get"></cfhttp>

<cfset fc=cfhttp.fileContent>
<html>
<head>
	<title>Checks for updated version</title>
</head>
<body>
	<span id="version">
	<cfif trim(application.version) neq trim(fc)>
		There is a new version of CFMyAdmin available - New version <cfoutput>#fc#</cfoutput>
	<cfelse>
		You have the latest version of CFMyAdmin - Version <cfoutput>#application.version#</cfoutput>
	</cfif>
	</span>
</body>
</html>