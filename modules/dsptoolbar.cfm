<cfsetting enablecfoutputonly="Yes">

<cfset iconList = ATTRIBUTES.iconList>
<cfset nameList = ATTRIBUTES.nameList>
<cfset linkList = ATTRIBUTES.linkList>
<cfset linkBase = ATTRIBUTES.linkBase>
<cfset iconBase = ATTRIBUTES.iconBase>

<cfsetting enablecfoutputonly="No">
<cfif ThisTag.ExecutionMode EQ "start">
<table cellpadding=0 cellspacing=0 border=0 width="100%" class="toolBar">
<tr>
<td width="5" height="20" align=right><img src="images/bar.gif" width="3" height="18" alt="" border="0"></td>
<td height="20" valign="middle">

<table cellspacing="1" id="toolbar1" height="26">
<tr>
	<cfif SESSION.goodBrowser>
		<cfloop from="1" to="#ListLen(iconList)#" index="i">
		<cfset iIcon = ListGetAt(iconList,i)>
		<cfset iName = ListGetAt(nameList,i)>
		<cfset iLink = ListGetAt(linkList,i)>
		<cfoutput>
			<td class="coolButton" onAction="<cfif Find("javascript:",iLink)>if(#Right(iLink,Len(iLink)-11)#)toggleBut(#Evaluate(i-1)#);<cfelse>toggleBut(#Evaluate(i-1)#);browseTo('#linkBase##iLink#');</cfif>" tabIndex="#i#"><cfif iIcon IS NOT "x"><img src="images/icons/#iIcon#" <!---width="15" height="16"---> border="0" alt="#iif(iName IS NOT "x",DE(iName),DE(""))#" align="absmiddle"> </cfif>#iif(iName IS NOT "x",DE(iName),DE(""))#</td>
		</cfoutput>
		</cfloop>
	<cfelse>
		<cfloop from="1" to="#ListLen(iconList)#" index="i">
		<cfset iIcon = ListGetAt(iconList,i)>
		<cfset iName = ListGetAt(nameList,i)>
		<cfset iLink = ListGetAt(linkList,i)>
		<td class=small>&nbsp;&nbsp;&nbsp;
			<cfoutput><a <cfif Find("javascript:",iLink)>href="#iLink#"<cfelse>href="#linkBase##iLink#"<cfif isdefined("CALLER.target")> target="#CALLER.target#"</cfif></cfif>><img src="#iconBase##iIcon#" width="15" height="16" border="0" alt="#iName#" align="absmiddle"></a> <a href="apps/staffdir/dsp_staffdir_iframe.cfm?view=#iLink#"<cfif isdefined("CALLER.target")> target="#CALLER.target#"</cfif>>#iName#</a></cfoutput>
		</td>
		</cfloop>
	</cfif>
</tr>
</table>
</td></tr>
</table>
<!--- END: Show Toolbar --->
<cfif SESSION.goodBrowser>
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
var cells = table.rows[0].cells;
for (var i = 0; i < cells.length; i++) createButton(cells[i]);

<cfparam name="ATTRIBUTES.selectedButton" default="0">
var selectedButton = <cfoutput>#ATTRIBUTES.selectedButton#</cfoutput>;
for (var i=0;i<cells.length;i++)
{
	if( isToggleList[i] )
	{
		cells[i].setToggle(true);
		if(i==selectedButton) cells[i].setValue(true);
		else cells[i].setValue(false);
	}
	<cfif isdefined("ATTRIBUTES.enabledList")>
	cells[i].setEnabled(enabledList[i]);
	</cfif>
}
function toggleBut(butNo)
{
	if(butNo == selectedButton) return;
	var table = document.getElementById("toolbar1");
	var cells = table.rows[0].cells;
	//set the old to unselected
	if( selectedButton>=0 && eval("cells[selectedButton]"))
	{
		cells[selectedButton].setToggle(true);
		cells[selectedButton].setValue(false);
	}
	//set new to selected
	selectedButton = butNo;
}
function browseTo(loc){<cfif ATTRIBUTES.target NEQ "_self"><cfoutput>#ATTRIBUTES.target#</cfoutput>.</cfif>document.location.href= loc;}
</script>
</cfif>
</cfif>