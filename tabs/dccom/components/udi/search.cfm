<!--- Load the attributes --->
<cfmodule template="serializeAttributes.cfm" method="load" uid="#ref#">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head><title>UDI Search</title><LINK REL="STYLESHEET" TYPE="text/css" HREF="style.css">
<style>
.i{border:1px solid black;width:100%;}
.idis{background-color:#EEEEEE;border:1px solid black;width:100%;}
.isel{background-color:#ECF5FE;border:1px solid #2379C9;width:100%;}
</style>
<script>
var itype = new Array(<cfsetting enablecfoutputonly="Yes">
<cfloop index="i" from="1" to="#arrayLen(assocAttribs)#">
	<cfif Left(assocAttribs[i].type,7) NEQ "select_">
		<cfif LCASE(assocAttribs[i].type) IS "boolean_yn">
			<cfoutput>"byn",</cfoutput>
		<cfelseif LCASE(assocAttribs[i].type) IS "boolean">
			<cfoutput>"b",</cfoutput>
		<cfelseif ListFind(ATTRIBUTES.useQuoteTypeList,LCASE(assocAttribs[i].type))>
			<cfoutput>"t",</cfoutput>
		<cfelse>
			<cfoutput>"i",</cfoutput>
		</cfif>
	</cfif>
</cfloop>
<cfsetting enablecfoutputonly="No">0);

function setMatchtypeOption(r)
{
	with( document.searchForm )
	{
		if( itype[eval("field"+r).selectedIndex] == "t" )
		{
			eval("matchtype"+r).options.length = 0;
			eval("matchtype"+r).options[0] = new Option("STARTS WITH","LIKE");
			eval("matchtype"+r).options[1] = new Option("CONTAINS","LIKE");
			eval("matchtype"+r).options[2] = new Option("IS","LIKE");
			eval("matchtype"+r).options[3] = new Option("IS NOT","<>");
			eval("fieldsearch"+r).disabled = false;
			if( eval("fieldsearch"+r).value=="0") eval("fieldsearch"+r).value="";
		}
		else if( itype[eval("field"+r).selectedIndex] == "b" )
		{
			eval("matchtype"+r).options.length = 0;
			eval("matchtype"+r).options[0] = new Option("TRUE","= 1");
			eval("matchtype"+r).options[1] = new Option("FALSE","= 0");
			eval("fieldsearch"+r).disabled = true;
		}
		else if( itype[eval("field"+r).selectedIndex] == "byn" )
		{
			eval("matchtype"+r).options.length = 0;
			eval("matchtype"+r).options[0] = new Option("TRUE","= 'Y'");
			eval("matchtype"+r).options[1] = new Option("FALSE","= 'N'");
			eval("fieldsearch"+r).disabled = true;
		}
		else{
			eval("matchtype"+r).options.length = 0;
			eval("matchtype"+r).options[0] = new Option("<","<");
			eval("matchtype"+r).options[1] = new Option("<=","<=");
			eval("matchtype"+r).options[2] = new Option("=","=");
			eval("matchtype"+r).options[3] = new Option(">=",">=");
			eval("matchtype"+r).options[4] = new Option(">",">");
			eval("matchtype"+r).options[5] = new Option("IS NOT","<>");
			eval("fieldsearch"+r).disabled = false;
			var ival = parseFloat( eval("fieldsearch"+r).value );
			if( !ival && ival!=0 ) ival = "0";
			eval("fieldsearch"+r).value = ival;
		}
	}
}
function toggleRow(r)
{
	with( document.searchForm )
	{
		var bOnOff = eval("chk"+r).checked;
		if(!bOnOff)
		{
			eval("field"+r).disabled = true;
			eval("matchtype"+r).disabled = true;
			eval("fieldsearch"+r).disabled = true;
			eval("fieldsearch"+r).className = 'idis';
		}
		else
		{
			eval("field"+r).disabled = false;
			eval("matchtype"+r).disabled = false;
			eval("fieldsearch"+r).disabled = false;
			eval("fieldsearch"+r).className = 'i';
		}
	}
}
function init()
{
	for(r=1;r<=3;r++) setMatchtypeOption(r);
	document.searchForm.fieldsearch1.select();
}
function doSearch()
{
	var SQL = "";
	with( document.searchForm )
	{
		for(r=1;r<=3;r++)
		{
			var searchVal = eval("fieldsearch"+r).value;
			var matchType = eval("matchtype"+r).value;
			var matchTypeName = eval("matchtype"+r+".options[matchtype"+r+".selectedIndex].text");
			if( eval("chk"+r).checked && eval("fieldsearch"+r).value != "" )
			{
				if( SQL != "" ) SQL = SQL + " AND ";
				SQL = SQL + eval("field"+r).value + " ";
				SQL = SQL + matchType + " ";
				if( itype[eval("field"+r).selectedIndex] != "b" && itype[eval("field"+r).selectedIndex] != "byn" )
				{
					if( itype[eval("field"+r).selectedIndex] == "t" )
					{
						SQL = SQL + "'";
						//add on the % if this is a LIKE search and its not there already...
						if( matchTypeName=="CONTAINS" && searchVal.charAt( 0 ) != "%" ) searchVal = "%" + searchVal;
						if( (matchTypeName=="CONTAINS" || matchTypeName == "STARTS WITH") && searchVal.charAt( searchVal.length-1 ) != "%" ) searchVal = searchVal + "%";
						SQL = SQL + searchVal.replace("'","''") + "'";
					}
					else{
						var ival = parseFloat( searchVal );
						if( !ival && ival!=0 ) ival = "0";
						SQL = SQL + ival;
					}
				}
			}
		}
	}
	try{
		window.opener.setSearchSQLString(SQL);
	}catch(e){alert("UDI was refreshed ot closed. Search no longer attached.");window.close();}
	document.searchForm.fieldsearch1.select();
	return false;
}
</script>
</head>
<body class=cButton onload="init()">

<table cellpadding=0 cellspacing=0 border=0 width="100%" height="100%">
<tr><td style="border-bottom:1px solid #303030;padding:5px;">
<img src="search.gif" width="16" height="16" alt="" border="0" align=absmiddle>
<strong>Search</strong>
</td></tr>
<form name="searchForm" onsubmit="return doSearch()">
<tr><td>

	<table cellpadding=5 cellspacing=1 width="100%">
	<tr>
		<td width=20><input type="checkbox" name="chk1" checked onclick="toggleRow(1)"></td>
		<td width="140"><select name="field1" onchange="setMatchtypeOption(1)" style="width:100%"><cfloop index="i" from="1" to="#arrayLen(assocAttribs)#"><cfif Left(assocAttribs[i].type,7) NEQ "select_"><cfoutput><option value="#assocAttribs[i].field#" <cfif ListFind(ATTRIBUTES.useQuoteTypeList,assocAttribs[i].type) AND NOT isdefined("z1")><cfset z1=1> selected</cfif>>#assocAttribs[i].display#</option></cfoutput></cfif></cfloop></select></td>
		<td width="40"><select name="matchtype1"><option>&lt;<option>&lt;=<option>=<option>&gt;=<option>&gt;</select></td></td>
		<td><input name="fieldsearch1" type="text" size="30" class=i onfocus="this.className='isel'" onblur="this.className='i'"></td>
	</tr>
	<tr>
		<td width=20><input type="checkbox" name="chk2" onclick="toggleRow(2)"></td>
		<td width="140"><select name="field2" onchange="setMatchtypeOption(2)" style="width:100%" disabled><cfloop index="i" from="1" to="#arrayLen(assocAttribs)#"><cfif Left(assocAttribs[i].type,7) NEQ "select_"><cfoutput><option value="#assocAttribs[i].field#" <cfif ListFind(ATTRIBUTES.useQuoteTypeList,assocAttribs[i].type) AND NOT isdefined("z2")><cfset z2=1> selected</cfif>>#assocAttribs[i].display#</option></cfoutput></cfif></cfloop></select></td>
		<td width="40"><select name="matchtype2" disabled><option>&lt;<option>&lt;=<option>=<option>&gt;=<option>&gt;</select></td></td>
		<td><input name="fieldsearch2" type="text" size="30" disabled class=idis onfocus="this.className='isel'" onblur="this.className='i'"></td>
	</tr>
	<tr>
		<td width=20><input type="checkbox" name="chk3" onclick="toggleRow(3)"></td>
		<td width="140"><select name="field3" onchange="setMatchtypeOption(3)" style="width:100%" disabled><cfloop index="i" from="1" to="#arrayLen(assocAttribs)#"><cfif Left(assocAttribs[i].type,7) NEQ "select_"><cfoutput><option value="#assocAttribs[i].field#" <cfif ListFind(ATTRIBUTES.useQuoteTypeList,assocAttribs[i].type) AND NOT isdefined("z3")><cfset z3=1> selected</cfif>>#assocAttribs[i].display#</option></cfoutput></cfif></cfloop></select></td>
		<td width="40"><select name="matchtype3" disabled><option>&lt;<option>&lt;=<option>=<option>&gt;=<option>&gt;</select></td></td>
		<td><input name="fieldsearch3" type="text" size="30" disabled class=idis onfocus="this.className='isel'" onblur="this.className='i'"></td>
	</tr>
	</table>

</td></tr>
<tr><td align="right">
	<input type="button" value="Close" onClick="window.close()">
	<input type="submit" value="Search">
</td></tr>
</form>
</table>
</body>
</html>
