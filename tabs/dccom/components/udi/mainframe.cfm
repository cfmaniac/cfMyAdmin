<cfsetting enablecfoutputonly="Yes">

<!--- Load the attributes --->	
<cfmodule template="serializeAttributes.cfm" method="load" uid="#ref#">
<cfsetting enablecfoutputonly="No"><html><frameset id="mainframe" name="mainframe" rows="<cfoutput>#ATTRIBUTES.hiddenFrameSetting#</cfoutput>"><cfoutput><frame name="toolbarFrame" src="toolbar.cfm?ref=#ref#" frameborder="No" scrolling="no" noresize><frame name="chooseFrame" src="chooseRecord.cfm?ref=#ref#"><frame name="editFrame" src="editRecord.cfm?ref=#ref#"></cfoutput></frameset></html>
