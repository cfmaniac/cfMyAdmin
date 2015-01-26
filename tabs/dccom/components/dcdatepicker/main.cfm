<!------------------------------------------------------------------------------------------------
Component:            dcDatePicker
Programmers:          Peter Coppinger aka Topper <peter@digital-crew.com>
Version:              0.1
Styleable?:           Yes
dcCom Dependencies:   Requires dcSelectImage
Browser Specific:     Yes. MS Internet Explorer 4.5+ Only
Copyright:            Copyright (c) 2002 by Peter Coppinger, Digital Crew

Purpose:
--------------------------------------------------------------------------------------------------


Usage:
--------------------------------------------------------------------------------------------------
<CF_DCCOM component="dcDatePicker" dateorder="month first" createScript="no"></CF_DCCOM>

... dcDatePicker(stringObject) ...


Examples:
--------------------------------------------------------------------------------------------------
	Example 1 - [Example Name]
	<CF_DCCOM component="[dcDatePicker]" [dateOrderFirst="[month|day:default:day]"]></CF_DCCOM>
	<form name="theForm">
		<input type="text" name="theDate">
		<input type="button" value="Pick Date" onClick="dcDatePicker('document.theForm.theDate.value')">
	</form>

Description:	
--------------------------------------------------------------------------------------------------



CHANGE LOG:
--------------------------------------------------------------------------------------------------
Nov 25		TOP	Component Created

------------------------------------------------------------------------------------------------------>
<!--- IMPORTANT: In components enableCFOutputOnly="Yes" by default so theres no need to use <cfsetting enableCFOutputOnly="Yes"> --->
<CFIF ThisTag.ExecutionMode IS "End">

	<!--- RECOMMENDED: Perform URL Variable Passing Security Test --->
	<cfinclude template="../../engine/urlsecurity.cfm">
	
	<cfparam name="ATTRIBUTES.dateOrderFirst" default="day">
	<cfparam name="ATTRIBUTES.createScript" type="boolean" default="yes">
	
	<cfif ATTRIBUTES.dateOrderFirst NEQ "day" AND ATTRIBUTES.dateOrderFirst NEQ "month">
		<cfthrow type="custom" message="Attribute dateOrderFirst must be either ""day"" or ""month"".">
	</cfif>

	<cfif NOT isdefined("CALLER.ISDEF_dcCom_dcDatePicker")>

	<cfset CALLER.ISDEF_dcCom_dcDatePicker = 1>

		<cfif ATTRIBUTES.createScript>
			<cfoutput><script language="JavaScript1.2" defer></cfoutput>
		</cfif>
	
		<cfoutput>
		function dcDatePicker(f,d,m,y,r)
		{
			var ie5 = (document.getElementsByTagName && document.all) ? true : false;
			var w=182,h=186;

			if(d==null) d = #DateFormat(now(),"d")#;
			if(m==null) m = #Evaluate(DateFormat(now(),"m"))#;
			if(y==null) m = #DateFormat(now(),"yyyy")#;
			if(r==null) r = 1;
			
			if(!ie5)
			{
				if(r) eval("window.datePickerCallback_"+r+" = f");
				window.open("#ATTRIBUTES.dcCom_RelPath#components/#ATTRIBUTES.component#/calendar.cfm?d="+d+"&m="+m+"&y="+y+"&r="+r, "calendar"+r, "width="+w+", height="+h+",location=no,menubar=no,status=no,toolbar=no,scrollbars=no,resizable=no");
			}
			else{
				var vOut=null;
				var vIn = new Array();
				vIn["d"] = d;vIn["m"] = m;vIn["y"] = y;
				vOut=self.showModalDialog("#ATTRIBUTES.dcCom_RelPath#components/#ATTRIBUTES.component#/iecalendar.cfm",vIn,"status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no;dialogWidth:"+w+"px;dialogHeight:"+h+"px;");
				if(vOut!=null){ var oDate=vOut["selDate"]; }
				if(f){if(r)f(oDate,r);else f(oDate);}
			}
			return false;
		}
		</cfoutput>
	
		<cfif ATTRIBUTES.createScript>
			<cfoutput></script></cfoutput>
		</cfif>

	<cfelse>
		<cfset CALLER.ISDEF_dcCom_dcDatePicker = CALLER.ISDEF_dcCom_dcDatePicker + 1>
	</cfif>
	
</CFIF>