<cfparam name="assocAttribs[ posAt ].default" default="#now()#">
<cfparam name="assocAttribs[ posAt ].dateFormat" default="dd mmmm yyyy">
<cfoutput>#DateFormat(dbVal,assocAttribs[ posAt ].dateFormat)#&nbsp;</cfoutput>
