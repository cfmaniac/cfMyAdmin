<!--- Whodat? browser detection

Renamed to getBrowserInfo.cfm by Peter Coppinger 11 Nov 2002

Author: Gerald Harris (gharris@blueblox.com)
                Blueblox.com (http://www.blueblox.com)

Date: June, 2001

Purpose:  Whodat? looks at cgi.http_user_agent to determine what browser the
user
                is utilizing. Additionally Whodat? also returns a good amount of
                information to help web-developers determine the abilities of their
                visitor's browsers which will hopefully allow the web-developer to
build a
                site that is highly accessible for multiple software packages across
                multiple platforms.

Parameter: None.

Returns: browserdata = cgi.http_user_agent (The user agent string)
                MozillaVersion = The Mozilla version, or "other" if Mozilla version is
not
applicable (as in Lynx)
                BrowserName =  Netscape, Microsoft, AOL, WebTV, Opera, Lynx, or other
                BrowserVersion = The browser version
                Platform = Windows, Macintosh, Unix, Linux, OS/2, WebTV, other
                CssFriendly = Yes, or no
                DhtmlFriendly = Yes, or no
                XmlFriendly = Yes, or no
                JavaFriendly = Yes, or no
                JavaScriptFriendly = Yes, or no
                ============================
                JSVersion and EcmaCompliant will automatically return "no" if the
browser
is not Javascript Friendly.
                ============================
                JSVersion = 1.0,1.1,1.2,1.3
                EcmaCompliant = Yes, or no



======================
Notes:
======================
Check out the about.cfm page to view some possible uses for Whodat?.

Please leave this header in place, and let me know if, and how, you are
using Whodat?

If you have suggestions for improving this tag please send them to me and
I'll
check them out for possible inclusion in upcoming versions of Whodat?

If you send me code, and I use it in a future version of Whodat? then I will
include your name, email, and website address, in the credit section of this
file. Please refrain from sending me addresses that would direct users to
any
"adult" site.

Check out the Salt Lake City, Utah ColdFusion users group site at
http://www.slcfug.org

======================
Updates:
======================
July 20, 2001: Repaired bug in the manner that CF_Whodat determines Browser
version for Netscape 6.
---><cfsilent>

<cfparam name="browserdata" default="#cgi.http_user_agent#">
<cfscript>
BrowserVersion="other";
MozillaVersion="other";
BrowserName="other";
Platform="other";
CssFriendly="no";
DhtmlFriendly="no";
FlashFriendly="no";
XmlFriendly="no";
JavaFriendly="no";
JavaScriptFriendly="no";
JSVersion="no";
EcmaCompliant="no";
Mozilla=Find("Mozilla", browserdata);
MSIE=Find("MSIE", browserdata);
Opera=Find("Opera", browserdata);
WebTv=Find("WebTV", browserdata);
Lynx=Find("Lynx", browserdata);
AOL=Find("AOL", browserdata);
compatible=Find("compatible", browserdata);


if (Lynx EQ 0){
MozillaVersion=GetToken(browserdata, 2, "/ (");
}

//Browser name and version?
if (Mozilla NEQ 0 and MSIE EQ 0 and Opera EQ 0 and WebTV EQ 0 and Lynx EQ 0
and AOL EQ 0 and compatible EQ 0){
        BrowserName="Netscape";
        if (MozillaVersion GTE "5"){
                BrowserVersion=GetToken(browserdata, 3, "/");
                BrowserVersion=RemoveChars(BrowserVersion, 1, 17);
        }
        else{
                BrowserVersion=MozillaVersion;
        }
}
else if (MSIE NEQ 0 and Opera EQ 0 and WebTV EQ 0 and Lynx EQ 0 and AOL EQ
0){
        BrowserName="Microsoft";
        BrowserVersion=GetToken(browserdata, 2, ";");
        BrowserVersion=RemoveChars(BrowserVersion, 1, 5);
}
else if (AOL NEQ 0){
        BrowserName="AOL";
        BrowserVersion=GetToken(browserdata, 2, " ");
}
else if (Opera NEQ 0){
        BrowserName="Opera";
        BrowserVersion=GetToken(browserdata, 2, ")");
        BrowserVersion=RemoveChars(BrowserVersion, 1, 7);
        BrowserVersion=Replace(BrowserVersion, " [en]", "");
}
else if (WebTV NEQ 0){
        BrowserName="WebTV";
        BrowserVersion=GetToken(browserdata, 4, "/ ");
}
else if (Lynx NEQ 0){
        BrowserName="Lynx";
        BrowserVersion=GetToken(browserdata, 1, "r");
        BrowserVersion=RemoveChars(BrowserVersion, 1, 5);
}

//Determine Platform
if (FindNoCase("win", browserdata) NEQ 0){
        Platform="Windows";
}
else if (FindNoCase("mac", browserdata) NEQ 0){
        Platform="Macintosh";
}
else if (FindNoCase("xll", browserdata) NEQ 0){
        Plarform="Unix";
        if (FindNoCase("inux", browserdata) NEQ 0){
                Platform="Linux";
        }
}
else if ((FindNoCase("os/2", browserdata) NEQ 0) OR
(FindNoCase("ibm-webexplorer", browserdata) NEQ 0)){
        Platform="OS/2";
}
else if (FindNoCase("webtv", browserdata) NEQ 0){
        Platform="WebTV";
}

//DCSS friendly?
if ((BrowserName EQ "Netscape" AND BrowserVersion GTE 4) OR (BrowserName EQ
"Microsoft" AND BrowserVersion GTE 4) OR (BrowserName EQ "AOL" AND
BrowserVersion GTE 3) OR (BrowserName EQ "Opera" AND BrowserVersion GTE 3.6)
OR (BrowserName EQ "WebTV")){
        CssFriendly="Yes";
}

//DHTML friendly?
if ((BrowserName EQ "Netscape" AND BrowserVersion GTE 4) OR (BrowserName EQ
"Microsoft" AND BrowserVersion GTE 4) OR (BrowserName EQ "AOL" AND
BrowserVersion GTE 4)){
        DhtmlFriendly="Yes";
}

//XML friendly?
if ((BrowserName EQ "Netscape" AND BrowserVersion GTE 6) OR (BrowserName EQ
"Microsoft" AND BrowserVersion GTE 5) OR (BrowserName EQ "Opera" AND
BrowserVersion GTE 4)){
        XmlFriendly="Yes";
}

//JAVA friendly?
if ((BrowserName EQ "Netscape" AND BrowserVersion GTE 3) OR (BrowserName EQ
"Microsoft" AND BrowserVersion GTE 3) OR (BrowserName EQ "AOL" AND
BrowserVersion GTE 3)){
        JavaFriendly="Yes";
}


//Javascript friendly? What version? ECMA compliant?
if ((BrowserName EQ "Netscape" AND BrowserVersion GTE 2) OR (BrowserName EQ
"Microsoft" AND BrowserVersion GTE 3) OR (BrowserName EQ "AOL" AND
BrowserVersion GTE 3) OR (BrowserName EQ "Opera" AND BrowserVersion GTE 3.5)
OR (BrowserName EQ "WebTV")){
        JavaScriptFriendly="Yes";
                JSVersion="1.0";
                EcmaCompliant="No";
         if (BrowserName EQ "Netscape"){
                if (BrowserVersion GTE 2){
                        JSVersion="1.0";
                        EcmaCompliant="No";
                }
                if (BrowserVersion GTE 3){
                        JSVersion="1.1";
                        EcmaCompliant="No";
                }
                if (BrowserVersion GTE 4){
                        JSVersion="1.2";
                        EcmaCompliant="No";
                }
                if (BrowserVersion GTE 4.06){
                        JSVersion="1.3";
                        EcmaCompliant="Yes";
                }
                if (BrowserVersion GTE 6){
                        JSVersion="1.5";
                        EcmaCompliant="Yes";
                }
        }
        if (BrowserName EQ "Microsoft"){
                if (BrowserVersion GTE 3){
                        JSVersion="1.1";
                        EcmaCompliant="No";
                }
                if (BrowserVersion GTE 4){
                        JSVersion="1.2";
                        EcmaCompliant="No";
                }
                if (BrowserVersion GTE 4.5){
                        JSVersion="1.3";
                        EcmaCompliant="Yes";
                }
                if (BrowserVersion GTE 5){
                        JSVersion="1.3";
                        EcmaCompliant="Yes";
                }
        }
        if (BrowserName EQ "Opera" AND BrowserVersion GTE 5){
                JSVersion="1.2";
                EcmaCompliant="No";
        }
        if (BrowserName EQ "WebTV"){
                JSVersion="1.2";
                EcmaCompliant="No";
        }
        if (BrowserName EQ "AOL" AND BrowserVersion GTE 3){
                JSVersion="1.2";
                EcmaCompliant="No";
        }
}

//Set Callers
ATTRIBUTES.browserdata="#browserdata#";
ATTRIBUTES.MozillaVersion="#MozillaVersion#";
ATTRIBUTES.BrowserName="#BrowserName#";
ATTRIBUTES.BrowserVersion="#RTrim(LTrim(BrowserVersion))#";
ATTRIBUTES.Platform="#Platform#";
ATTRIBUTES.CssFriendly="#CssFriendly#";
ATTRIBUTES.DhtmlFriendly="#DhtmlFriendly#";
ATTRIBUTES.XmlFriendly="#XmlFriendly#";
ATTRIBUTES.JavaFriendly="#JavaFriendly#";
ATTRIBUTES.JavaScriptFriendly="#JavaScriptFriendly#";
ATTRIBUTES.JSVersion="#JSVersion#";
ATTRIBUTES.EcmaCompliant="#EcmaCompliant#";
</cfscript>

</cfsilent>
 <!--- Remove the top and bottom comment lines to debug.
 <cfoutput>
User Agent String=#browserdata#<br>
Mozilla Version=#MozillaVersion#<br>
Browser Name=#BrowserName#<br>
Browser Version=#BrowserVersion#<br>
Platform=#Platform#<br>
CSS Friendly=#CssFriendly#<br>
DHTML Friendly=#DhtmlFriendly#<br>
XML Friendly=#XmlFriendly#<br>
JAVA Friendly=#JavaFriendly#<br>
JavaScript Friendly=#JavaScriptFriendly#<br>
JavaScript Version=#JSVersion#<br>
Ecma Compliant=#EcmaCompliant#<br>
<br><br>
Mozilla=#Mozilla#<br>
MSIE=#MSIE#<br>
Opera=#Opera#<br>
WebTV=#WebTV#<br>
Lynx=#Lynx#<br>
AOL=#AOL#
 </cfoutput>

--->
  