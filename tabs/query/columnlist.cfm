<!--- 
Filename:    ColumnList.cfm
Description: Custom Tag which creates a "properly" ordered list of columns in
             a query.  Although the CF-supplied ColumnList query attribute is
			 a list of the columns, they are in an unpredictable order.
			 
			 If the SELECT clause is a list of columns, this tag returns a
			 list of those columns in the same order as they appear in the
			 SELECT clause.
			 
			 If the SELECT clause is "*", this tag returns a list of those columns
			 in the same order as they appear in the database.
			 
			 This tag works by simply converting the input query into a WDDX
			 packet and then extracting the packet's list of columns.  It so
			 happens that the data in the WDDX packet is in the proper order.
			 
			 This tag has been tested using Oracle and MS Access under 
			 CF 4.0.1 and 4.5.2 on Windows NT.
			 
			 This tag may be freely distributed.  The author would love to
			 hear from anyone who uses it.
			 
Author:      David Shadovitz
Contact:     david@shadovitz.com or david_shadovitz@xontech.com
History:     
             Version  Date           Change
			 -------  -------------  -----------------------------------
			 1.0      March 3, 2001  Initial release.
			 
Attributes:
  Query     -  input  - the CFML query
  ColumnList - output - the properly-ordered column list
 
Sample Usage:
  <cfquery name="myQuery" datasource="#Request.dsn#">
  select a, b, c, d from myTable
  </cfquery>
  <CF_ColumnList Query="#myQuery#" ColumnList="colList">
  <cfloop index="iCol" from="1" to="#listLen(colList)#">
     ... loop stuff ...
  </cfloop>
--->

<!--- For error reporting purposes --->
<cfset tagName = "CF_ColumnList">

<!--- Ensure that the attributes have been provided --->
<cfloop index="Attribute" list="Query,ColumnList">
	<cfif not IsDefined("Attributes." & Attribute)>
		<hr>
		<h4>Missing Attribute</h4>
		The <b><cfoutput>#tagName#</cfoutput></b> tag requires the attribute 
		<b><cfoutput>#Attribute#</cfoutput></b>.<br>
		<hr>
		<cfabort>
	</cfif>
</cfloop>

<!--- Ensure that the input query is indeed a CFML query --->
<cfif not IsQuery(Attributes.Query)>
		<hr>
		<h4>Invalid Query</h4>
		The Query attribute of the <b><cfoutput>#tagName#</cfoutput></b> tag 
		must be a CFML query.<br>
		<hr>
		<cfabort>
</cfif>

<!--- Serialize the query --->
<cfwddx action="CFML2WDDX" input=#Attributes.Query# output='qWDDX'>

<!--- Get the list of column names --->
<cfset fieldNamesStart = "fieldNames='">
<cfset fieldNamesStartPos = FindNoCase(fieldNamesStart,qWDDX)+Len(fieldNamesStart)>
<cfset tmp1 = Right(qWDDX,Len(qWDDX)-fieldNamesStartPos)>
<cfset fieldNamesStop = "'">
<cfset fieldNamesLen = FindNoCase(fieldNamesStop,tmp1)>
<cfset tmp2 = Mid(qWDDX,fieldNamesStartPos,fieldNamesLen)>

<!--- Return the list of column names --->
<cfset #SetVariable("Caller." & Attributes.ColumnList,tmp2)#>
