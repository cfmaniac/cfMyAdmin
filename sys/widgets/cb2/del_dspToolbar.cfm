<cfsetting enablecfoutputonly="Yes">

<cfparam name="ATTRIBUTES.dir" default="horiz">

<cfset iconList = ATTRIBUTES.iconList>
<cfset altList = ATTRIBUTES.altList>
<cfset nameList = ATTRIBUTES.nameList>
<cfset linkList = ATTRIBUTES.linkList>
<cfset linkBase = ATTRIBUTES.linkBase>
<cfset iconBase = ATTRIBUTES.iconBase>

<cfsetting enablecfoutputonly="No">
<cfif ThisTag.ExecutionMode EQ "start">
<table cellpadding=0 cellspacing=0 border=0 width="100%">
<tr>
<td<cfif ATTRIBUTES.dir NEQ "vert"> height="20"</cfif> valign="middle">

<table cellspacing="1" id="toolbar1"<cfif ATTRIBUTES.dir NEQ "vert"> height="26"</cfif>>
<cfsetting enablecfoutputonly="yes">
<cfif ATTRIBUTES.dir NEQ "vert"><cfoutput><tr></cfoutput></cfif>
<cftry>
	<cfloop from="1" to="#ListLen(iconList)#" index="i">
		<cfset iAlt = ListGetAt(altList,i)>
		<cfset iIcon = ListGetAt(iconList,i)>
		<cfset iName = ListGetAt(nameList,i)>
		<cfset iLink = ListGetAt(linkList,i)>
		<cfoutput><cfif ATTRIBUTES.dir EQ "vert"><tr></cfif><td class="coolButton" onAction="<cfif Find("javascript:",iLink)>if(#Right(iLink,Len(iLink)-11)#)toggleBut(#Evaluate(i-1)#);<cfelse>toggleBut(#Evaluate(i-1)#);browseTo('#linkBase##iLink#');</cfif>" tabIndex="#i#"><cfif iIcon IS NOT "x"><img src="#iconBase##iIcon#" <!---width="15" height="16"---> border="0" alt="#iAlt#" align="absmiddle"> </cfif>#iif(iName IS NOT "x",DE(iName),DE(""))#</td><cfif ATTRIBUTES.dir EQ "vert"></tr></cfif></cfoutput>
	</cfloop>
	<cfcatch>
		<cfoutput><pre>
		This might help with debugging:
		
		ListLen(iconList)     = #ListLen(iconList)#
		ListLen(altList)      = #ListLen(altList)#
		ListLen(nameList)     = #ListLen(nameList)#
		ListLen(linkList)     = #ListLen(linkList)#
		ListLen(enabledList)  = #ListLen(ATTRIBUTES.enabledList)#
		ListLen(isToggleList) = #ListLen(ATTRIBUTES.isToggleList)#
		</pre></cfoutput>
		<cfrethrow>
	</cfcatch>
</cftry>
<cfif ATTRIBUTES.dir NEQ "vert"><cfoutput></tr></cfoutput></cfif>
<cfsetting enablecfoutputonly="no">
</table>
</td></tr>
</table>
<!--- END: Show Toolbar --->
<script>
<cfif isdefined("ATTRIBUTES.enabledList")>
var enabledList = new Array(<cfoutput>#ATTRIBUTES.enabledList#</cfoutput>);
<cfelse>
var enabledList = new Array(<cfloop from="1" to="#listlen(nameList)#" index="zi">1,</cfloop>1);
</cfif>
<cfif isdefined("ATTRIBUTES.isToggleList")>
var isToggleList = new Array(<cfoutput>#ATTRIBUTES.isToggleList#</cfoutput>);
<cfelse>
var isToggleList = new Array(<cfloop from="1" to="#listlen(nameList)#" index="zi">1,</cfloop>1);
</cfif>
var table = document.getElementById("toolbar1");
<cfif ATTRIBUTES.dir NEQ "vert">
var cells = table.rows[0].cells;
for (var i = 0; i < cells.length; i++) createButton(cells[i]);
<cfelse>
for (var i = 0; i < <cfoutput>#ListLen(linkList)#</cfoutput>; i++) createButton(table.rows[i].cells[0]);
</cfif>

<cfparam name="ATTRIBUTES.selectedButton" default="0">
var selectedButton = <cfoutput>#ATTRIBUTES.selectedButton#</cfoutput>;
for (var i=0;i<<cfoutput>#ListLen(linkList)#</cfoutput>;i++)
{
	if( isToggleList[i] )
	{
		<cfif ATTRIBUTES.dir NEQ "vert">
			cells[i].setToggle(true);
			if(i==selectedButton) cells[i].setValue(true);
			else cells[i].setValue(false);
		<cfelse>
			table.rows[i].cells[0].setToggle(true);
			if(i==selectedButton) table.rows[i].cells[0].setValue(true);
			else table.rows[i].cells[0].setValue(false);
		</cfif>
	}
	<cfif isdefined("ATTRIBUTES.enabledList")>
		<cfif ATTRIBUTES.dir NEQ "vert">
			cells[i].setEnabled(enabledList[i]);
		<cfelse>
			table.rows[i].cells[0].setEnabled(enabledList[i]);
		</cfif>
	</cfif>
}
function toggleBut(butNo)
{
	if(butNo == selectedButton) return;
	var table = document.getElementById("toolbar1");
	<cfif ATTRIBUTES.dir NEQ "vert">
		var cells = table.rows[0].cells;
		<!--- set the old to unselected --->
		if( selectedButton>=0 && eval("cells[selectedButton]"))
		{
			cells[selectedButton].setToggle(true);
			cells[selectedButton].setValue(false);
		}
	<cfelse>
		<!--- set the old to unselected --->
		if( selectedButton>=0 && eval("table.rows[selectedButton].cells[0]."))
		{
			table.rows[selectedButton].cells[0].setToggle(true);
			table.rows[selectedButton].cells[0].setValue(false);
		}
	</cfif>
	<!--- set new to selected --->
	selectedButton = butNo;
}
function enableBut(toolbarNo,butNo)
{
	var onOff = true;
	if( arguments.length > 2 ) onOff = arguments[2];
	<cfif ATTRIBUTES.dir NEQ "vert">
		document.getElementById("toolbar1").rows[0].cells[butNo].setEnabled(onOff);
	<cfelse>
		document.getElementById("toolbar1").rows[butNo].cells[0].setEnabled(onOff);
	</cfif>
}
function browseTo(loc){<cfif ATTRIBUTES.target NEQ "_self"><cfoutput>#ATTRIBUTES.target#</cfoutput>.</cfif>document.location.href= loc;}
</script>
</cfif>
