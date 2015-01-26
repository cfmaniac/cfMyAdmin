function init()
{
	with(document.forms[0])
	{
		for(i=0;i<connDescs.length;i++)
		{
			desc.options[desc.options.length] = new Option(connDescs[i]);
		}
		if(i>0)showConn(0);
	}
}
function showConn(i)
{
	with(document.forms[0])
	{
		ip.value = connIPs[i];
		user.value = connUser[i];
		password.value = connPass[i];
		port.value = connPort[i];
		desc.selectedIndex = i;
	}
	enableSave(false);
	enableDel(true);
}
function newConn()
{
	with(document.forms[0])
	{
		var pdesc = prompt("Description:","New Connection "+(desc.options.length+1));
		if(pdesc==null)return;
		desc.options[desc.options.length] = new Option(pdesc);
		connIPs[desc.options.length-1] = "localhost";
		connUser[desc.options.length-1] = "root";
		connPass[desc.options.length-1] = "";
		connPort[desc.options.length-1] = "3306";
		showConn(desc.options.length-1);
	}
	enableSave(true);
}
function saveConn()
{
	with(document.forms[0])
	{
		if( desc.selectedIndex==-1 && (ip.value!="" ||  user.value!="" || password.value!="") )
		{
			desc.options[desc.options.length] = new Option("New Connection");
			connIPs[desc.options.length-1] = ip.value;
			connUser[desc.options.length-1] = user.value;
			connPass[desc.options.length-1] = password.value;
			connPort[desc.options.length-1] = port.value;
			desc.selectedindex = 0;
		}
		//copy current data across to the arrays
		connIPs[desc.selectedIndex] = ip.value;
		connUser[desc.selectedIndex] = user.value;
		connPass[desc.selectedIndex] = password.value;
		connPort[desc.selectedIndex] = (port.value.length)?port.value:"3306";
		document.workerform.action.value = "saveConn";
		//loop through arrays building save strings
		var s = new WddxSerializer();
		var conndata = new Object();
		connDescs.length = 0;
		for(i=0;i<desc.options.length;i++) connDescs[i] = desc.options[i].text;
		conndata.connDescs = connDescs;
		conndata.connIPs = connIPs;
		conndata.connUser = connUser;
		conndata.connPass = connPass;
		conndata.connPort = connPort;
		var conndataWDDX = s.serialize( conndata );
		document.workerform.conndata.value = conndataWDDX;
		document.workerform.submit();
	}
	
	enableSave(false);
	enableDel(true);
}
function delConn()
{
	with(document.forms[0])
	{
		if(desc.length==0)return;
		var selNo=desc.selectedIndex;
		for(i=selNo;i<desc.length-1;i++)desc.options[i].text=desc.options[i+1].text;
		desc.length = desc.length-1;
		for(i=selNo;i<connIPs.length-1;i++)connIPs[i]=connIPs[i+1];
		connIPs.length = connIPs.length-1;
		for(i=selNo;i<connUser.length-1;i++)connUser[i]=connUser[i+1];
		connUser.length = connUser.length-1;
		for(i=selNo;i<connPass.length-1;i++)connPass[i]=connPass[i+1];
		connPass.length = connPass.length-1;
		for(i=selNo;i<connPort.length-1;i++)connPort[i]=connPort[i+1];
		connPort.length = connPort.length-1;
		if(connIPs.length>0)
		{
			selNo=selNo-1;
			if(selNo>=0) showConn(selNo);
			else showConn(0);
			saveConn();
		}
		else
		{
			ip.value = "";
			user.value = "";
			password.value = "";
			port.value = "3306";
			saveConn();
			enableDel(false);
		}		
	}
}
function editDesc()
{
	var pdesc;
	with(document.forms[0])
	{
		if(desc.length>0) pdesc = prompt("Edit Description:",desc.options[desc.selectedIndex].text);
		if(pdesc==null) return;
		desc.options[desc.selectedIndex].text = pdesc;
		enableSave(true);
	}
}
function enableSave(bSave)
{
	var butSave = document.getElementById("butSave");
	if( butSave )
	{
		if(bSave)document.getElementById("butSave").className="buttonOk";
		else document.getElementById("butSave").className="buttonDis";
	}
}
function enableDel(bSave)
{
	if(bSave)document.getElementById("butDel").className="buttonOk";
	else document.getElementById("butDel").className="buttonDis";
}
function connect()
{
	with(document.forms[0])
	{
		if(window.opener)window.opener.connect(ip.value,user.value,password.value,port.value);
		window.close();
	}
}