
<!--- START: Show Toolbar --->
<cfmodule template="..\sys\widgets\cb2\dsptoolbar.cfm"
iconList = "viewData.gif,editField.gif,addField.gif,dropField.gif"
nameList = "x,x,x,x"
altList = "View Data,Edit Field / Index...,Add Field / Index...,Drop Field"
linkList = "javascript:tbViewData(),javascript:tabContents.editField(),javascript:tabContents.addField(),javascript:tabContents.dropField()"
linkBase = "index.cfm"
iconBase = "../images/icons/"
target   = "ciframe"
selectedButton = 0
enabledList =  "1,0,1,0"
isToggleList = "0,0,0,0"
dir="vert"
>
<!--- END: Show Toolbar --->	
