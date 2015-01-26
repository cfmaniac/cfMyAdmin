		<cfquery name="useDB" connectString="#CALLER.ATTRIBUTES.connectString#" DBTYPE="Dynamic" maxrows="#ATTRIBUTES.maxrows#">
		use #CALLER.ATTRIBUTES.database#
		</cfquery>
		<cfquery name="CALLER.#ATTRIBUTES.queryname#" connectString="#CALLER.ATTRIBUTES.connectString#" DBTYPE="Dynamic" maxrows="#ATTRIBUTES.maxrows#">
		#PreserveSingleQuotes(thisTag.generatedContent)#
		</cfquery>
