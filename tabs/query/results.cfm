<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Host - Variable</title>
<style>
body,td {
 background-color:buttonface;
 margin:0px;
 padding:0px;
 font-family:verdana,arial;
 font-size:10px;
}


td.columnHeader{
background-color:buttonface;
border-top:1px solid buttonhighlight;
border-left:1px solid buttonhighlight;
border-bottom:1px solid #848284;
border-right:1px solid #848284;
padding-top:1px;
padding-bottom:1px;
padding-left:3px;
padding-right:3px;
white-space: nowrap;
font-weight:bold;
}

td.columnRow{
background-color:white;
border-bottom:1px solid #707070;
border-right:1px solid #707070;
padding-top:1px;
padding-bottom:1px;
padding-left:3px;
padding-right:3px;
font-family: verdana,arial;
font-size:11px;
overflow:clip;
}

</style>
</head>
<body>

<cfif isdefined("theQuery")>

	<cftry>
	
		<cfif Len(theDatabase)>
			<cfmodule template="..\..\modules\smartquery.cfm" queryName="setDatabase"><cfoutput>
			USE #theDatabase#
			</cfoutput></cfmodule>
		</cfif>
			
		<cfmodule template="..\..\modules\smartquery.cfm" queryName="getData"><cfoutput>
		#theQuery#
		</cfoutput></cfmodule>
		
		<cfcatch type="Database">
			<cfset NEWLINE = chr(13)&chr(10)>
			<script language="JavaScript1.2" defer>
			<cfoutput>alert("Whoops!\n\n#JSStringFormat( replaceNoCase(cfcatch.detail,"<P>",NEWLINE,"ALL") )#</cfoutput>");
			</script>
		</cfcatch>
	
	</cftry>
	<cfif NOT isdefined("getData")>
		<cfset noResults = 1>
	</cfif>

	<cfif NOT isdefined("noResults")>
		<CF_ColumnList Query="#getData#" ColumnList="CorrectOrderColumnList">
		<table cellspacing=0 cellpadding=0 border=0>
		<tr><td class="columnHeader" colspan="<cfoutput>#ListLen(getData.columnList)#">#ListLen(getData.columnList)# Fields, #getData.recordCount#</cfoutput> Records:</td></tr>
		<tr>
			<cfloop index="query_columnName" list="#CorrectOrderColumnList#">
				<td class="columnHeader"><cfoutput>#query_columnName#</cfoutput></td>
			</cfloop>
		<cfoutput query="getData">
		<tr>
			<cfloop index="query_columnName" list="#CorrectOrderColumnList#">
				<td nowrap class="columnRow"><cfset val = Evaluate(query_columnName)>#HTMLEditFormat(Left(val,60))#<cfif Len(val) GT 60>...</cfif></td>
			</cfloop>
		</tr>
		</cfoutput>
		</table>
	</cfif>

<cfelse>
	<cfset noResults = 1>
</cfif>

<cfif isdefined("noResults")>
	<table cellspacing=0 cellpadding=0>
	<tr><td class="columnHeader">&nbsp;</td><td class="columnHeader" width="190">&nbsp;</td></tr>
	<tr><td class="columnRow">&nbsp;</td><td class="columnRow" width="190"><cfif isdefined("theQuery") AND FindNoCase("UPDATE ",theQuery)>Update Complete <cfoutput>(#TimeFormat(now(),"hh:MM:SS")#)</cfoutput></cfif>&nbsp;</td></tr>
	</table>
</cfif>

</body>
</html>
