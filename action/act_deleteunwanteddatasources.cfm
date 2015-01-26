<!--- Delete unwanted the new datasource --->
<cfif APPLICATION.ColdFusionVersion GTE 6>

	<cfset TwentyMinutesAgo = DateAdd("n", -20, now())>
	<cfscript>
	factory = CreateObject("java", "coldfusion.server.ServiceFactory");
	ds_service = factory.datasourceservice;
	dsources = ds_service.datasources;
	</cfscript>

	<cfloop collection="#dsources#" item="datasource">
		<cfif Left( datasource, 10 ) EQ "CFMyAdmin_">
			<cfif	(NOT StructKeyExists( APPLICATION.datasources, datasource ))
					OR (NOT StructKeyExists( APPLICATION.datasources[datasource], "lastUpdate" ))
					OR DateCompare( TwentyMinutesAgo, APPLICATION.datasources[datasource].lastUpdate ) IS 1>
				<!--- Delete the APPLICATION.datasources reference to this datasource --->
				<cflock name="appDatasources" type="exclusive" timeout="10">
					<cfscript>structDelete( APPLICATION.datasources, datasource, false );</cfscript>
				</cflock>
				<!--- Delete the *real* datasource --->
				<cflock name="serviceFactory" type="exclusive" timeout="10">
					<cfscript>structDelete( dsources, datasource, false );</cfscript>
				</cflock>
			</cfif>
		</cfif>
	</cfloop>

</cfif>