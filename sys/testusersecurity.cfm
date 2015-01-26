<!------------------------------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------
 
 	Application:	Any
	Project:		Any
	Filename:		testUserSecurity.cfm
	Programmers:	Peter Coppinger <peter@digital-crew.com>
					
	Purpose:		Test if current user has access to a site page.

	Usage:			<cf_testUserSecurity [level="[LEVEL-default:1]"] [redirect="[REDIRECT URL: default: index.cfm?action=trippedsecurity]"]>
	
	Description:	Tests SESSION.loggedInLev - this value must be at least #Attributes.level# or else the
					user is redirected to #Attributes.redirect#.
					When calling this function, the programmer can substitute the number required for
					Attributes.level with one of the following strings:
						NOTLOGGEDIN, NONE, USER, POWERUSER, SUPERUSER, ADMINISTRATOR, GOD
						eg. <cf_testUserSecurity level=SUPERUSER>
	
	CHANGE LOG:
	14 Jan 2002		Document Created


 ----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------>
<cfparam name="Attributes.level" default="0">
<cfparam name="Attributes.redirect" default="#APPLICATION.IntranetURL#index.cfm?page=trippedsecurity">

<!--- substitution of text version of security level --->
<cfset Attributes.level = ReplaceList(UCASE(Attributes.level), "NOTLOGGEDIN,NONE,USER,POWERUSER,SUPERUSER,ADMINISTRATOR,GOD", "0, 0, 10, 20, 30, 40, 50")>

<cfparam name="SESSION.loggedInLev" default="0"><!--- defaults to not logged in --->

<cfif SESSION.loggedInLev LT Attributes.level>
	<cflocation url="#Attributes.redirect#">
</cfif>