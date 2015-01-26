<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Choose Date</title>
	<link type="text/css" rel="StyleSheet" href="css/datepicker.css" />
	<script type="text/javascript" src="datepicker.js"></script>
<script language="JavaScript1.2">
var f=null;
function init()
{
	window.focus();

	var mCal=null,theDate=null;
	theDate = new Date( <cfoutput>#y#, #Evaluate(m-1)#, #d#</cfoutput> );
	f = window.opener.datePickerCallback_<cfoutput>#r#</cfoutput>;
	mCal = new DatePicker(theDate);
	
	mCal.onOK = function(){
	
		if(f) eval("window.opener.datePickerCallback_<cfoutput>#r#</cfoutput>( this._selectedDate , <cfoutput>#r#</cfoutput> )");
		window.close();	

	}
	mCal.setShowNone(false);
	var el = mCal.create();
	document.body.appendChild( el );
}
</script>
</head>
<body style="margin:0px;" onLoad="init()"></body>
</html>
