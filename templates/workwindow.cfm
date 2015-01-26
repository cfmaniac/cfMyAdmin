<cfif isdefined("action")>

	<cfswitch expression="#action#">
	
		<cfcase value="connect">

			<cfset bConnectSuccess = false>
			<!--- If the user is loggin in as ROOT and the root login isn't allowed, say so... --->
			<cfif NOT options_Security_RootAllowed AND FORM.username EQ "ROOT">
				<cfset connectErrMsg = "'ROOT' LOGIN DISABLED" & APPLICATION.NEWLINE & APPLICATION.NEWLINE & "Sorry the 'root' login is disabled for security." & APPLICATION.NEWLINE & "Note: The 'root' login can be enabled in the settings\options.cfm file." & APPLICATION.NEWLINE>
			<cfelse>
				<cfset connectString = "DRIVER={#options_MySQLODBCDriverString#};SERVER=#FORM.server#;UID=#FORM.username#;PWD=#FORM.password#;PORT=#FORM.port#">
				<cftry>
					<cfmodule template="..\modules\smartquery.cfm" queryname="connectionTest" connectstring="#connectString#" server="#FORM.server#" username="#FORM.username#" password="#FORM.password#" port="#FORM.port#">
						<cfoutput>SHOW DATABASES</cfoutput>
					</cfmodule>
					<cfif connectionTest.recordCount GT 0>
						<cfset bConnectSuccess = true>
					<cfelse>
						<cfset connectErrMsg = "No databases found for this user.">
					</cfif>
					<cfcatch type="Database">
						<cfset connectErrMsg = "Could not connect to database." & APPLICATION.NEWLINE & APPLICATION.NEWLINE & REReplaceNoCase( cfcatch.detail, "\[[^>]*\]", "", "ALL" )>
						<cfset connectErrMsg = connectErrMsg & "Tip: This application is running on a remote server," & APPLICATION.NEWLINE & "ensure the server name is correct.">
						<cfset SESSION.datasource = "">
					</cfcatch>
				</cftry>
				<cfif bConnectSuccess>
					<cfset session.connectString = connectString>
					<cfset SESSION.dbuser = "#FORM.username#@#FORM.server#">
					<cfset SESSION.db_server = "#FORM.server#">
					<cfset SESSION.db_username = "#FORM.username#">
					<cfset SESSION.db_password = "#FORM.password#">
					<cfset SESSION.db_port = "#FORM.port#">
				<cfelse>
					<cfset session.connectString = "">
				</cfif>
			</cfif>
			
		</cfcase>
	
		<cfcase value="disconnect">
			<cfset SESSION.connectString = "">
			<cfset SESSION.datasource = "">
		</cfcase>
		
		<cfcase value="dropDB">
			<cfmodule template="..\modules\smartquery.cfm" queryname="dropDB"><cfoutput>
			DROP DATABASE #val1#
			</cfoutput></cfmodule>
		</cfcase>
		
		<cfcase value="dropTable">
			<cfmodule template="..\modules\smartquery.cfm" queryname="dropTable"><cfoutput>
			DROP TABLE #val1#
			</cfoutput></cfmodule>
		</cfcase>

	</cfswitch>

</cfif>
<html><body bgcolor="#848284" style="margin:0px;">
 <cfif session.connectString EQ "">
 &nbsp;
 	<cfif isdefined("bConnectSuccess") AND bConnectSuccess EQ false>
		<script>
		alert("<cfoutput>#JSStringFormat( replaceNoCase(connectErrMsg,"<P>",APPLICATION.NEWLINE,"ALL") )#</cfoutput>");
		parent.openConnDiag("../");
		</script>
	</cfif>
 <cfelse>
  <script>
  parent.updateToolbar("onConnOpen");
  </script>
  <!---------------------------->
  <table width="100%" height="100%" cellpadding=0 cellspacing=0 border=0 bgcolor="white" id="workarea">
  <tr>
   <td valign=top width=200 height="100%" id="leftTD">
    <!----------Left--------->
	<iframe height="100%" width=200 name="leftSide" src="left.cfm" frameborder=1></iframe>
	<!----------------------->
   </td>
   <td valign=top width="100%" height="100%" id="rightTD">
    <iframe height="100%" width=100% id="workArea" src="../pages/workarea.cfm" name="workArea" scrolling="No" frameborder="0"></iframe>
   </td>
  </tr>
  </table>
  <!---------------------------->
</cfif>
</body></html>