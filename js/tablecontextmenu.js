var selectedItems="";
function showmenuie5(e){

document.getElementById("generalMenu").style.visibility="hidden";
document.getElementById("tableMenu").style.visibility="hidden";

var underMenuId=ie5? event.srcElement : e.target;

if(underMenuId.parentNode.nodeName=="TR" && underMenuId.getAttribute("cr")!=null) {
	var cr=underMenuId.getAttribute("cr");
	var tField=underMenuId.getAttribute("tableField");
	var obj=underMenuId.parentNode;
	selectedFieldName=tField;
	selectRow(cr,tField,obj);
	menuobj=document.getElementById("tableMenu");
} else {
	menuobj=document.getElementById("generalMenu");
}

//Find out how close the mouse is to the corner of the window
var rightedge=ie5? document.body.clientWidth-event.clientX : window.innerWidth-e.clientX
var bottomedge=ie5? document.body.clientHeight-event.clientY : window.innerHeight-e.clientY

//if the horizontal distance isn't enough to accomodate the width of the context menu
if (rightedge<menuobj.offsetWidth)
//move the horizontal position of the menu to the left by it's width
menuobj.style.left=ie5? document.body.scrollLeft+event.clientX-menuobj.offsetWidth : window.pageXOffset+e.clientX-menuobj.offsetWidth
else
//position the horizontal position of the menu where the mouse was clicked
menuobj.style.left=ie5? document.body.scrollLeft+event.clientX : window.pageXOffset+e.clientX

//same concept with the vertical position
if (bottomedge<menuobj.offsetHeight)
menuobj.style.top=ie5? document.body.scrollTop+event.clientY-menuobj.offsetHeight : window.pageYOffset+e.clientY-menuobj.offsetHeight
else
menuobj.style.top=ie5? document.body.scrollTop+event.clientY : window.pageYOffset+e.clientY

menuobj.style.visibility="visible"

return false
}

function hidemenuie5(e){
	document.getElementById("generalMenu").style.visibility="hidden";
	document.getElementById("tableMenu").style.visibility="hidden";
	menuobj.style.visibility="hidden"
}

function highlightie5(e){
	var firingobj=ie5? event.srcElement : e.target
	if (firingobj.className=="menuitems"||ns6&&firingobj.parentNode.className=="menuitems"){
	if (ns6&&firingobj.parentNode.className=="menuitems") firingobj=firingobj.parentNode //up one node
	firingobj.style.backgroundColor="highlight"
	firingobj.style.color="white"
	if (display_url==1)
		window.status=event.srcElement.url
	}
}

function lowlightie5(e) {
	var firingobj=ie5? event.srcElement : e.target
	if (firingobj.className=="menuitems"||ns6&&firingobj.parentNode.className=="menuitems") {
		if (ns6&&firingobj.parentNode.className=="menuitems") firingobj=firingobj.parentNode //up one node
		firingobj.style.backgroundColor=""
		firingobj.style.color="black"
		window.status=''
	}
}

function jumptoie5(e){
	
	var firingObj=ie5? event.srcElement : e.target
	
	if(firingObj.parentNode.className!="menuItems" && firingObj.parentNode.className!="skin0") {
		firingObj=firingObj.parentNode;
	}
	
	if(firingObj.className=="menuitems") {
		var action=firingObj.getAttribute("action");

		switch(action) {

			case "editField":
	  			editField();
	 		break;
			
			case "dropField":
	  			dropField();
	 		break;
			
			case "viewData":
	  			parent.tbViewData();
	 		break;
			
			case "addField":
	  			addField();
	 		break;
			
			case "refreshWindow":
	  			document.location.reload();
	 		break;
			
			case "printWindow":
	  			window.print();
	 		break;
		}
	}
}

var display_url=0
var ie5=document.all&&document.getElementById
var ns6=document.getElementById&&!document.all

if (ie5||ns6) {
	var menuobj=document.getElementById("tableMenu");
}

if (ie5||ns6){
	menuobj.style.display=''
	document.oncontextmenu=showmenuie5
	document.onclick=hidemenuie5
}
