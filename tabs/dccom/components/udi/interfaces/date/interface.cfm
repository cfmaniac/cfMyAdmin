<cfif NOT assocAttribs[ attribIndex ].edit><img src="lock.gif" width="14" height="17" alt="" border="0" align="left"></cfif>
<cfsilent>
<cfparam name="assocAttribs[ attribIndex ].default" default="">
<cfparam name="assocAttribs[ attribIndex ].monthFirst" default="no">

<cfif assocAttribs[ attribIndex ].monthFirst><cfset monthFirst = 1><cfelse><cfset monthFirst = 0></cfif>

<cfif assocAttribs[ attribIndex ].default EQ "">
	<cfscript>Evaluate("assocAttribs[ #attribIndex# ].default = ""#now()#""");</cfscript>
	<cfset dbFieldVal = assocAttribs[ attribIndex ].default>
<cfelseif NOT IsDate(assocAttribs[attribIndex].default)>
	<cfif ListLen(assocAttribs[ attribIndex ].default,"/") NEQ 3 AND ListLen(assocAttribs[ attribIndex ].default,"/") NEQ 5>
		<cfthrow type="custom" message="Default Date Must be In dd/mm/yyyy or dd/mm/yyyy/hours/minutes format.">
	</cfif>
	<cfif assocAttribs[ attribIndex ].monthFirst>
		<cfset m = ListGetAt(assocAttribs[ attribIndex ].default,1,"/") mod 12>
		<cfset d = ListGetAt(assocAttribs[ attribIndex ].default,2,"/") mod 31>
	<cfelse>
		<cfset d = ListGetAt(assocAttribs[ attribIndex ].default,1,"/") mod 31>
		<cfset m = ListGetAt(assocAttribs[ attribIndex ].default,2,"/") mod 12>
	</cfif>
	<cfset y = ListGetAt(assocAttribs[ attribIndex ].default,3,"/")>
	<cfif ListLen(assocAttribs[ attribIndex ].default,"/") GE 5>
		<cfset hours = ListGetAt(assocAttribs[ attribIndex ].default,4,"/")>
		<cfset mins = ListGetAt(assocAttribs[ attribIndex ].default,5,"/")>
	<cfelse>
		<cfset hours=0><cfset mins=0>
	</cfif>
	<cfset assocAttribs[ attribIndex ].default = CreateDateTime(y,m,d,hours,mins,0)>	
	<cfset dbFieldVal = assocAttribs[ attribIndex ].default>
</cfif>
<cfparam name="assocAttribs[ #attribIndex# ].dateFormat" default="dd mmmm yyyy">
</cfsilent>
<cfif NOT isdefined("ISDEF_dateNum")><cfset ISDEF_dateNum = 1><cf_dcCom component="dcDatePicker" dcCom_RelPath="../../"></cf_dccom>
<cfelse><cfset ISDEF_dateNum = ISDEF_dateNum + 1></cfif>
<cfparam name="assocAttribs[ attribIndex ].style" default="">
<cfparam name="assocAttribs[ attribIndex ].dateFormat" default="dd mmmm yyyy">
<cfparam name="assocAttribs[ attribIndex ].size" default="40">
<cfoutput>
<table cellspacing=0 cellspacing=0 border=0>
<tr><td><input name="dateDisp#ISDEF_dateNum#" type="text" size="#assocAttribs[ attribIndex ].size#" value="#DateFormat(dbFieldVal,assocAttribs[ attribIndex ].dateFormat)#" <cfif NOT assocAttribs[ attribIndex ].edit>onkeydown="return false;"<cfelse>onChange="return ensureDate(null,#ISDEF_dateNum#,#monthFirst#)" onFocus="this.value='<cfif monthFirst>mm/dd<cfelse>dd/mm</cfif>/yyyy';this.select()" onBlur="checkDateForRestore(#ISDEF_dateNum#,<cfif monthFirst>1<cfelse>0</cfif>)"</cfif><cfif assocAttribs[ attribIndex ].style NEQ ""> style="#assocAttribs[ attribIndex ].style#"</cfif>></td>
<td><button <cfif NOT assocAttribs[ attribIndex ].edit>disabled class="cButtonDisabled"<cfelse>onClick="return dcDatePicker(ensureDate,document.editForm.datePart_d#ISDEF_dateNum#.value,document.editForm.datePart_m#ISDEF_dateNum#.value,document.editForm.datePart_y#ISDEF_dateNum#.value,#ISDEF_dateNum#);"</cfif>><img src="calendar.gif" width="20" height="15" alt="Open Calendar" border="0"></button></td>
<cfif assocAttribs[ attribIndex ].type EQ "datetime">
<cfparam name="assocAttribs[ attribIndex ].timeFormat" default="hh:mmtt">
<cfif assocAttribs[ attribIndex ].edit>
<td width="40" align=right>
	<table cellpadding=0 cellspacing=0 border=0 width=16>
	<tr><td><img src="up.gif" width="16" height="10" alt="" border="0" onClick="slideValue(document.editForm.dateHours#ISDEF_dateNum#,1,0,23);amPM(document.editForm.dateHours#ISDEF_dateNum#,#ISDEF_dateNum#);" ondblclick="slideValue(document.editForm.dateHours#ISDEF_dateNum#,3,0,23);amPM(document.editForm.dateHours#ISDEF_dateNum#,#ISDEF_dateNum#);"></td></tr>
	<tr><td><img src="down.gif" width="16" height="9" alt="" border="0" onClick="slideValue(document.editForm.dateHours#ISDEF_dateNum#,-1,0,23);amPM(document.editForm.dateHours#ISDEF_dateNum#,#ISDEF_dateNum#);" ondblclick="slideValue(document.editForm.dateHours#ISDEF_dateNum#,-3,0,23);amPM(document.editForm.dateHours#ISDEF_dateNum#,#ISDEF_dateNum#);"></td></tr>
	</table>
</td>
</cfif>
<td align=right><input type="text" name="dateHours#ISDEF_dateNum#" value="#TimeFormat(dbFieldVal,"HH")#" size="1" maxlength="2" style="border-right:1px solid white;" <cfif NOT assocAttribs[ #attribIndex# ].edit> onkeydown="return false;"<cfelse>onkeypress="ensureInt(this);" onkeyup="amPM(this,#ISDEF_dateNum#);" onChange="inRange(this,0,23);"</cfif>></td>
<td align=left><input type="text" name="dateMins#ISDEF_dateNum#" value="#TimeFormat(dbFieldVal,"mm")#" size="1" maxlength="2" style="border-left:1px solid white;" <cfif NOT assocAttribs[ #attribIndex# ].edit> onkeydown="return false;"<cfelse>onkeypress="ensureInt(this);" onChange="inRange(this,0,59);"</cfif>></td>
<cfif assocAttribs[ attribIndex ].edit>
<td>
	<table cellpadding=0 cellspacing=0 border=0 width=16>
	<tr><td><img src="up.gif" width="16" height="10" alt="" border="0" onClick="slideValue(document.editForm.dateMins#ISDEF_dateNum#,1,0,60)" ondblclick="slideValue(document.editForm.dateMins#ISDEF_dateNum#,5,0,60)"></td></tr>
	<tr><td><img src="down.gif" width="16" height="9" alt="" border="0" onClick="slideValue(document.editForm.dateMins#ISDEF_dateNum#,-1,0,60)" ondblclick="slideValue(document.editForm.dateMins#ISDEF_dateNum#,-5,0,60)"></td></tr>
	</table>
</td>
</cfif>
<td valign=bottom><span id="date_ampm#ISDEF_dateNum#"><cfif TimeFormat(dbFieldVal,"HH") NEQ ""><strong><cfif TimeFormat(dbFieldVal,"HH") LE 11>AM<cfelse>PM</cfif></strong></cfif></span></td>
</cfif>
</tr></table>
<input type="hidden" name="dateFieldName#ISDEF_dateNum#" value="#dbField#">
<input type="hidden" name="dateFormat#ISDEF_dateNum#" value="#assocAttribs[ attribIndex ].dateFormat#">	
<input type="hidden" name="#dbField#" value="#dbFieldVal#">
<input type="hidden" name="datePart_d#ISDEF_dateNum#" value="#DateFormat(dbFieldVal,"d")#">
<input type="hidden" name="datePart_m#ISDEF_dateNum#" value="#DateFormat(dbFieldVal,"m")#">
<input type="hidden" name="datePart_y#ISDEF_dateNum#" value="#DateFormat(dbFieldVal,"yyyy")#">
</cfoutput>
