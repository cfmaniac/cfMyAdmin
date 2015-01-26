<!--- Register the new datasource --->
<cflock name="serviceFactory" type="exclusive" timeout="10">

	<cfscript>
	factory = CreateObject("java", "coldfusion.server.ServiceFactory");
	ds_service = factory.datasourceservice;
	dsources = ds_service.datasources;
	</cfscript> 
	<!--- dump existing datasources for visual verification--->
  
	<cfset path = GetDirectoryFromPath( GetCurrentTemplatePath() )>
	<cffile action="READ" file="#path#MySQLDSWDDX.z" variable="DSASWDDX">
	<cfwddx action="WDDX2CFML" input="#DSASWDDX#" output="mySQLDSTemplate">
	<cfset mySQLDSTemplate.Name = SESSION.datasource>
	
	<!--- Change from jdbc:mysql://localhost:3306/mysql? --->
	<cfset murl = replace( mySQLDSTemplate.url, "localhost", ATTRIBUTES.server )>
	<cfif ATTRIBUTES.port NEQ "3306">
		<cfset murl = replace( murl, "3306", ATTRIBUTES.port )>
	</cfif>
	<cfset mySQLDSTemplate.url = murl>
	<cfset mySQLDSTemplate.username = ATTRIBUTES.username>
	<cfset mySQLDSTemplate.password = ds_service.encryptPassword(ATTRIBUTES.password)>
	<cfset mySQLDSTemplate.urlmap.CONNECTIONPROPS.database = "unknown">
	<cfset mySQLDSTemplate.urlmap.CONNECTIONPROPS.host = ATTRIBUTES.server>
	<cfset mySQLDSTemplate.urlmap.CONNECTIONPROPS.port = ATTRIBUTES.port>
	<cfset mySQLDSTemplate.urlmap.host = ATTRIBUTES.server>
	<cfset mySQLDSTemplate.urlmap.port = ATTRIBUTES.port>
	
	<cfset dsources["#SESSION.datasource#"] = mySQLDSTemplate>

</cflock>
