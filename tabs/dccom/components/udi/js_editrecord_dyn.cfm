<cfsetting enablecfoutputonly="Yes">

<!--- Load the attributes --->	
<cfmodule template="serializeAttributes.cfm" method="load" uid="#ref#">

<cfsetting enablecfoutputonly="No">
function doSubmitCheck(){var errTxt="";
<cfloop index="attribIndex" from="1" to="#ArrayLen(assocAttribs)#">
<cfparam name="assocAttribs[ #attribIndex# ].notNull" default="0">
	<!--- Increment the counter --->
<cfparam name="ISDEF_#assocAttribs[ attribIndex ].type#" default="0">
<cfscript>Evaluate("ISDEF_#assocAttribs[ attribIndex ].type# = ISDEF_#assocAttribs[ attribIndex ].type# + 1");</cfscript>
<cfset dbType = assocAttribs[ attribIndex ].type>
	
<cftry>
	<cfinclude template="interfaces/#dbType#/js_submitCheck.cfm">
	<cfcatch type="MissingInclude">
		<cfif assocAttribs[ attribIndex ].notNull>
		if(document.editForm.<cfoutput>#assocAttribs[ attribIndex ].field#</cfoutput>.value=="")errTxt+="\n'<cfoutput>#JSStringFormat(assocAttribs[ attribIndex ].display)#</cfoutput>' must contain a value.";
		</cfif>
	</cfcatch>
</cftry>

</cfloop>
if(errTxt=="")return true;else{alert("Can't Submit Form."+errTxt);return false;}}

function saveRecord(){<cfif NOT ATTRIBUTES.allowInsert>if(document.editForm.updateType.value=="insert") return false;</cfif><cfif NOT ATTRIBUTES.allowUpdate>if(document.editForm.updateType.value=="update")return false;</cfif>
with(document.editForm){
<cfloop index="attribIndex" from="1" to="#ArrayLen(assocAttribs)#">
	<cftry>
		<cfinclude template="interfaces/#assocAttribs[ attribIndex ].type#/js_saverecord.cfm">
		<cfcatch type="MissingInclude">
		</cfcatch>
	</cftry>
</cfloop>
}if(doSubmitCheck())document.editForm.submit();<cfif ATTRIBUTES.MTFP>if(Math.random()*17<6)alert("UDI_TRIAL\n\nThis is a trial version of the UDI component\nfrom Digital Crew. Please purchase a license for\nthe unrestricted version of this component from\nwww.cftagstore.com.");</cfif>}
function hasChanged(){<cfif NOT ATTRIBUTES.allowInsert>if(document.editForm.updateType.value=="insert")return false;</cfif><cfif NOT ATTRIBUTES.allowUpdate>if(document.editForm.updateType.value=="update")return false;</cfif>parent.toolbarFrame.enableSaveButton(true);}
function init(){if(parent.toolbarFrame && parent.toolbarFrame.ready){parent.toolbarFrame.enableSaveButton(false);}}
function newRecord(){document.editForm.updateType.value = "insert";document.getElementById("txt_recordId").innerHTML="<cfif ATTRIBUTES.allowInsert>New Record<cfelse>Choose A Record</cfif>";
<cfset ISDEF_dateNum=0><cfset imageNum=0><cfset htmlNum=0>with(document.editForm){<cfloop index="attribIndex" from="1" to="#ArrayLen(assocAttribs)#">

	<cftry>
		<cfinclude template="interfaces/#assocAttribs[ attribIndex ].type#/js_newrecord.cfm">
		<cfcatch type="MissingInclude">
		</cfcatch>
	</cftry>

</cfloop>}}

<!--- Include Assistance function --->
<cfloop index="attribIndex" from="1" to="#ArrayLen(assocAttribs)#">
	<cfif isdefined("ISDEF_"&assocAttribs[ attribIndex ].type)>
		<cftry>
			<cfinclude template="interfaces/#assocAttribs[ attribIndex ].type#/js_newRecordAssistFunctions.cfm">
			<cfcatch type="MissingInclude">
			</cfcatch>
		</cftry>
	</cfif>
</cfloop>