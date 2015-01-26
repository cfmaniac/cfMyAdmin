var el, lastSelTxtElement = null, selTxtElement = null, selTxtElementClass = "";
var ie5 = true;
function showMenu() {
  
   var underMenuId = ie5? event.srcElement.id : e.target.id;
   if( underMenuId == "" || typeof(underMenuId)=="undefined" ) return false;
   if( document.getElementById(underMenuId).nodeName=="IMG") alert("image");
   if( document.getElementById(underMenuId).getAttribute("context") != "yes" ) return false;
   
   clearOldSel();
   ContextElement=event.srcElement;
   selTxtElement = ContextElement;
   selTxtElementClass = selTxtElement.className;
   selTxtElement.className = "selText " + selTxtElement.className;
   
   
   
   //Call the prepairMenu function - it may not exists
   try{
		prepairMenu(underMenuId);
   } catch(ex) {}
   
   menu1.style.leftPos+=10;
   menu1.style.posLeft=event.clientX;
   menu1.style.posTop=event.clientY+document.body.scrollTop;
   menu1.style.display="";
   menu1.setCapture();
   return false;
}
function toggleMenu() {   
   el=event.srcElement;
   if (el.className=="dccmmenuItem") {
      el.className="dccmhighlightItem";
   } else if (el.className=="dccmhighlightItem") {
      el.className="dccmmenuItem";
   }
}
function clearOldSel()
{
	if( selTxtElement == null ) return;
	selTxtElement.className = selTxtElementClass;
	selTxtElement = lastSelTxtElement;
	lastSelTxtElement = null;
}
function clickMenu() {
	clearOldSel();
   menu1.releaseCapture();
   menu1.style.display="none";
   isOneSelected=0;
   el=event.srcElement;
   if (el.doFunction != null) {
     eval(el.doFunction);
   }
}


 
