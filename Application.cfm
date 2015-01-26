<cfsetting enablecfoutputonly="Yes">

<cfapplication name="CFMyAdminDBSEditor6" sessionmanagement="Yes">

<!--- START: Define Global Settings that should only be set-up once --->
<cfif (NOT isdefined("APPLICATION.DBSURL")) OR APPLICATION.DBSURL EQ "" OR isdefined("URL.flush")>

	<!--- START: Lock so we can define all application variables safely --->
	<cflock scope="APPLICATION" timeout="1">
		
		<cfset APPLICATION.DBSURL = replace(GetDirectoryFromPath("http://"&cgi.server_name& cgi.path_info),"\","")>
		<cfset APPLICATION.DBSFilePath = GetDirectoryFromPath(GetCurrentTemplatePath())>

		<!--- Application Constants Definitons for Easy Code Reading --->
		<cfset APPLICATION.NEWLINE = chr(13) & chr(10)>
		<cfset APPLICATION.VERSION = "1.0 BETA 3">
		
		<cfset APPLICATION.ColdFusionVersion = Left(server.ColdFusion.ProductVersion,1)>
		
		<cfif NOT isdefined("APPLICATION.datasources")>
			<cfset APPLICATION.datasources = StructNew()>
		</cfif>
		
	</cflock>
	<!--- END: Lock so we can define all application variables safely --->
	
	<!--- Remove any unneeded datasources --->
	<cfinclude template="action\act_deleteunwanteddatasources.cfm">

</cfif>
<!--- END: Define Global Settings that should only be set-up once --->

<cfparam name="SESSION.connectString" default="">
<cfparam name="SESSION.dbuser" default=""><!--- For display purposes only --->
<cfparam name="SESSION.db_server" default="">
<cfparam name="SESSION.db_username" default="">
<cfparam name="SESSION.db_password" default="">
<cfparam name="SESSION.db_port" default="3306">
<cfinclude template="settings\options.cfm">

<cfsetting enablecfoutputonly="no">