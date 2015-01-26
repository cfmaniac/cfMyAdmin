<cfif SESSION.connectString IS "">
	<html><body><script>top.location.href="../index.cfm";</script></body></html>
	<cfabort>
</cfif>
<html>
<head>
	<title>Database Query</title>
</head>

<script>
parent.hideTools("tableTools");
parent.hideTools("databaseTools");
parent.document.getElementById("theTitleBar").innerText="SQL-Query on Database <cfoutput>#theDatabase#</cfoutput>";
</script>

<frameset name="queryFrameset" rows="30%,*">
	<frame name="queryFrame" src="query/query.cfm?theDatabase=<cfoutput>#theDatabase#</cfoutput>" frameborder="1" bordercolor="#202020" scrolling="no">
	<frame name="resultsFrame" src="query/results.cfm" frameborder="1" bordercolor="#202020" scrolling="yes">
</frameset>

</body>
</html>
