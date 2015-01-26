<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Choose Date</title>
	<link type="text/css" rel="StyleSheet" href="css/datepicker.css" />
	<script type="text/javascript" src="datepicker.js"></script>
<script language="JavaScript1.2">
var vIn;
function init()
{
	var mCal=null,theDate=null;
	vIn = window.dialogArguments;
	if(vIn["d"] && vIn["m"] && vIn["y"]){
		theDate = new Date( vIn["y"], vIn["m"]-1, vIn["d"] );
		mCal = new DatePicker(theDate);
	}
	else{
		mCal = new DatePicker();
		theDate = new Date( <cfoutput>#DateFormat(now(),"yyyy")#, #Evaluate(DateFormat(now(),"m")-1)#, #DateFormat(now(),"d")#</cfoutput> );
	}
	
	mCal.onOK = function(){
	

		var month = this._selectedDate.getMonth()+1;
		var day = this._selectedDate.getDay();//FIX
		var year = this._selectedDate.getYear();
		//alert("Day is "+day+", Month is "+month+", Year is "+year);

		var dateArr = new Array();
		dateArr["selDate"] = this._selectedDate;
		window.returnValue = dateArr;
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
