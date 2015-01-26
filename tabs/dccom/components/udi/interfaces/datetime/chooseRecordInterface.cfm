<cfparam name="assocAttribs[ posAt ].default" default="#now()#">
<cfparam name="assocAttribs[ posAt ].timeFormat" default="hh:mmtt">			
<cfparam name="assocAttribs[ posAt ].dateFormat" default="dd mmmm yyyy">
<cfoutput>#TimeFormat(dbVal,assocAttribs[ posAt ].timeFormat)# #DateFormat(dbVal,assocAttribs[ posAt ].dateFormat)#&nbsp;</cfoutput>
