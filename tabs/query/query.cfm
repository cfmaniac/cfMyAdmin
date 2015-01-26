<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Host - Variable</title>
<style>
body,td {
 background-color:buttonface;
 margin:0px;
 padding:0px;
 font-family:verdana,arial;
 font-size:10px;
}

.overAll {
  width:100%;
  height:100%;
  background-color:buttonface;
  padding:2px;
 }
 
 .atabOn {
  border-top:1px solid #ffffff;
  border-bottom:1px solid buttonface;
  border-left:1px solid #ffffff;
  border-right:1px solid #808080;
  font-family:arial;
  font-size:11px;
  color:black;
  font-weight:bold;
  height:25px;
 }
 
  .atabOff {
  border-top:1px solid #ffffff;
  border-bottom:1px solid #ffffff;
  border-left:1px solid #ffffff;
  border-right:1px solid #808080;
  background-color:buttonface;
  font-family:arial;
  font-size:11px;
  color:black;
  height:22px;
 }
</style>
<link rel="STYLESHEET" type="text/css" href="../../css/dctoolbar.css">
<script>
function runIt()
{
	with(document.queryForm)
	{
		theQuery.value = document.queryForm.theQuery.value;
		if( theQuery.value.length > 0 ) submit();
	}
}
function init()
{
	<!---
	queryIFrame.document.write("<html><head><style>body,td{background-color:white;color:#101010;width:100%;height:100%;font-family:verdana,arial;font-size:13px;font-weight:bold;}</style></head><body id=\"ezedit\"></body></html>");
	queryIFrame.document.close();
	queryIFrame.document.designMode="On";
	--->
	if( top.queryTxt.length ) document.getElementById("theQuery").value = top.queryTxt;
}
function doUnload()
{
	top.queryTxt = document.queryForm.theQuery.value;
}

function handleKey(e) {
	var ie5=document.all && document.getElementById;
	var ns6=document.getElementById && !document.all;
	var keyCode=ie5? event.keyCode : e.which;

	if(keyCode==120) {
		runIt();
	}
}

document.onkeydown=handleKey;
</script>
</head>
<body onLoad="init()" onunload="doUnload()">
<table width=100% height="100%" cellspacing=0 cellpadding=0>
<form name="queryForm" action="results.cfm" target="resultsFrame">
<input type="hidden" name="theDatabase" value="<cfoutput>#theDatabase#</cfoutput>">
<tr>
<!--- ToDo: Try to get line numbers working --->
<td>
<!---<IFRAME name="queryIFrame" width="100%" height="100%"></IFRAME><br>--->
<textarea name="theQuery" cols="4" rows="10" style="background-color:white;color:#101010;width:100%;height:100%;font-family:verdana,arial;font-size:13px;font-weight:bold;"></textarea>
</td>
<td width="80" align="center" style="padding:2px;" valign="top" onselectstart="return false;">
	
	<table cellspacing=1 cellpadding=0 width="100%">
	<tr>
	<td title="View Data" style="padding-left:5px;padding-right:5px" onclick="return false;" 
	 onmousedown="this.className='buttonPressed';runIt();" onmouseout="this.className='buttonOff'" onmouseup="this.className='buttonOn'"
	 onmouseover="this.className='buttonOn'" class="buttonOff">
		<table cellpadding=0 cellspacing=0 border=0 width="100%">
			<tr>
				<td width="16"><img src="../../images/icons/run.gif" border=0 alt="View Data" width="16" height="16"></td>
				<td>Run (F9)</td>
			</tr>		
		</table>
	</td>
	</tr>
	</table> 

</td>
</tr>
</form>
</table>
</body>
</html>
