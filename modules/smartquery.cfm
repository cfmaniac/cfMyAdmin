<cfif ThisTag.ExecutionMode EQ "end">

	<cfparam name="ATTRIBUTES.queryname">
	<cfparam name="ATTRIBUTES.connectString" default="#SESSION.connectString#">
	<cfparam name="ATTRIBUTES.server" default="#SESSION.db_server#">
	<cfparam name="ATTRIBUTES.username" default="#SESSION.db_username#">
	<cfparam name="ATTRIBUTES.password" default="#SESSION.db_password#">
	<cfparam name="ATTRIBUTES.port" default="#SESSION.db_port#">
	
	<cftry>
	
		<!--- For ColdFusion MX and Higher --->
		<cfif APPLICATION.ColdFusionVersion GTE 6>
		
			<cfif NOT isdefined("SESSION.datasource") OR NOT Len(SESSION.datasource)>
				<cfset huid = Hash( ATTRIBUTES.server & ATTRIBUTES.username & ATTRIBUTES.password & ATTRIBUTES.port )>
				<cfset SESSION.datasource = "CFMyAdmin_" & Left( huid, 10 )>
			</cfif>
			
			<!--- Track this datasource in the application.datasources structure --->	
			<cflock name="appDatasources" type="exclusive" timeout="10">
				<!--- If the possibly new datasource isn't defined in the top level list of datasources, then add it --->
				<cfif NOT StructKeyExists( APPLICATION.datasources, SESSION.datasource)>
					<cfset APPLICATION.datasources["#SESSION.datasource#"] = StructNew()>
					<cfinclude template="registerdatasource.cfm">
				</cfif>
			</cflock>

			<cfquery name="#ATTRIBUTES.queryname#" datasource="#SESSION.datasource#" username="#ATTRIBUTES.username#" password="#ATTRIBUTES.password#">
			#PreserveSingleQuotes(thisTag.generatedContent)#
			</cfquery>

			<cfset APPLICATION.datasources["#SESSION.datasource#"].lastUpdate = now()>
		
		<cfelseif APPLICATION.ColdFusionVersion IS 5>
		
			<!--- Connectstring is available in version 5 --->
			<cfinclude template="v5connectstring.cfm">
		
		<cfelse>
		
			<cfoutput>Sorry, your version of ColdFusion (#APPLICATION.ColdFusionVersion#) is not supported.</cfoutput>
			<cfabort>
		
		</cfif>
	
		<cfcatch type="Database">
			<cfset thisTag.generatedContent = "">
			<cfrethrow>
		</cfcatch>
	
	</cftry>
	
	<cfset thisTag.generatedContent = "">
	
	<cfif isdefined( ATTRIBUTES.queryname )>
		<cfscript>
			Evaluate("CALLER." & ATTRIBUTES.queryname & " = " & ATTRIBUTES.queryname);
		</cfscript>
	</cfif>

</cfif>