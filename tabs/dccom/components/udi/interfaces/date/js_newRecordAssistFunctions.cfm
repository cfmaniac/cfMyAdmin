<cfif NOT isdefined("ISDEF_fn_dateAssistFunctions")>
<cfset ISDEF_fn_dateAssistFunctions = 1>
function makeInt(it)
{
	var intPart = 0;
	for(pos=0;pos<it.length;pos++)
	if( it.charAt(pos) <= '9' && it.charAt(pos) >= '0' )
	{
		intPart = intPart * 10;
		intPart += it.charAt(pos) - '0';	
	}
	return intPart;
}
function pad2(d)
{
	return ( d<10 )?("0" + d):d;
}
function checkDateForRestore(refNo,monthfirst)
{
	curDateTxt = eval("document.editForm.dateDisp"+refNo+".value");
	if( curDateTxt == "dd/mm/yyyy" || curDateTxt == "mm/dd/yyyy" )
	{
		var d,m,y;
		eval("d=document.editForm.datePart_d"+refNo+".value");
		eval("m=document.editForm.datePart_m"+refNo+".value");
		eval("y=document.editForm.datePart_y"+refNo+".value");
		var theDate = (monthfirst?(""+pad2(m)+"/"+pad2(d)+"/"+y):(""+pad2(d)+"/"+pad2(m)+"/"+y));
	 	eval("document.editForm.dateDisp"+refNo+".value = theDate");
	}		
}
function ensureDate(oDate,refNo,monthfirst)
{
	if(arguments.length<3) monthfirst=0;
	if(oDate){
		var d = oDate.getDate();
		var m = oDate.getMonth()+1;
		var y = oDate.getYear();
	}
	else{
		//ensure dateDisp[num] is in "dd/mm/yyyy" format
		var dateVal = eval("document.editForm.dateDisp"+refNo+".value");
		if(dateVal!="")
		{
			if( dateVal.length < 8 ) {alert("Please enter in "+(monthfirst?"mm/dd":"dd/mm")+"/yyyy format.");eval("document.editForm.dateDisp"+refNo+".value='"+(monthfirst?"mm/dd":"dd/mm")+"/yyyy'");eval("document.editForm.dateDisp"+refNo+".select()");return false;}
			dateVal = dateVal.replace(/\\/g,"/");
			dateVal = dateVal.replace(/\./g,"/");
			var i = dateVal.indexOf("/");
			if(i<1) {alert("Please enter in "+(monthfirst?"mm/dd":"dd/mm")+"/yyyy format.1");eval("document.editForm.dateDisp"+refNo+".value='dd/mm/yyyy'");eval("document.editForm.dateDisp"+refNo+".select()");return false;}
			eval((monthfirst?"m":"d")+" = makeInt(dateVal.substring(0,i))");
			var i2 = dateVal.indexOf("/",i+1);
			if(i2<i+2) {alert("Please enter in "+(monthfirst?"mm/dd":"dd/mm")+"/yyyy format.2");return false;}
			eval((monthfirst?"d":"m")+" = makeInt(dateVal.substring(i+1,i2))");
			var y = makeInt(dateVal.substring(i2+1, dateVal.length));
			var errMsg="";
			if(d<1 || d>31) errMsg+="\r\nDay is out of range 1-31.";
			if(m<1 || m>12) errMsg+="\r\nMonth is out of range 1-12.";
			if(y<1601 || y>9999) errMsg+="\r\nYear is out of range 1601-9999.";
			if(errMsg!=""){
				alert("Date is out of range!\r\nPlease enter in dd/mm/yyyy format.\r\n"+errMsg);
				eval("document.editForm.dateDisp"+refNo+".value='dd/mm/yyyy'");eval("document.editForm.dateDisp"+refNo+".select()");
				return false;
			}
		}
	}
	hasChanged();

	//Update the hidden fields
	if(dateVal=="")
	{
		eval("document.editForm.dateDisp"+refNo+".value=''");
		var theField = eval("document.editForm.dateFieldName"+refNo+".value");
		eval("document.editForm."+theField+".value=''");
		eval("document.editForm.datePart_d"+refNo+".value=''");
		eval("document.editForm.datePart_m"+refNo+".value=''");
		eval("document.editForm.datePart_y"+refNo+".value=''");
	}
	else{
		var theDate = ""+d+"/"+m+"/"+y;
		eval("document.editForm.dateDisp"+refNo+".value=theDate");
		var theField = eval("document.editForm.dateFieldName"+refNo+".value");
		eval("document.editForm."+theField+".value=theDate");
		eval("document.editForm.datePart_d"+refNo+".value=d");
		eval("document.editForm.datePart_m"+refNo+".value=m");
		eval("document.editForm.datePart_y"+refNo+".value=y");

		//Transform the date from dd/mm/yyyy format to dd mmmm yyyy format
		with(document.tranFormer)
		{
			d.value = eval("document.editForm.datePart_d"+refNo+".value");
			m.value = eval("document.editForm.datePart_m"+refNo+".value");
			y.value = eval("document.editForm.datePart_y"+refNo+".value");
			resultField.value = "dateDisp"+refNo;
			dateFormat.value = eval("document.editForm.dateFormat"+refNo+".value");
			submit();
			return true;
		}
	}
}
function slideValue(o,dir,rS,rE)
{
	var newVal=o.value;
	if(newVal=="")newVal=rS+dir;
	else newVal=makeInt(newVal)+dir;
	if(newVal<rS)newVal=rE;
	if(newVal>rE)newVal=rS;
	o.value=newVal;
	hasChanged();
}
function amPM(o,refNo)
{
	if(o.value<=11) document.getElementById('date_ampm'+refNo).innerHTML = "<strong>AM</strong>";
	else document.getElementById('date_ampm'+refNo).innerHTML = "<strong>PM</strong>";			
}
</cfif>