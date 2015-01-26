
<!--- START: Show Toolbar --->
<cfmodule template="..\sys\widgets\cb2\dsptoolbar.cfm"
iconList = "createTable.gif,viewData.gif,editField.gif,emptyTable.gif,dropTable.gif,copyTable.gif"
nameList = "x,x,x,x,x,x"
altList = "Create Table,View Data,Show Table Properties,Empty Table,Drop Table,Copy Table"
linkList = "javascript:dbCreateTable(),javascript:dbViewData(),javascript:dbShowTable(),javascript:dbEmptyTable(),javascript:dbDropTable(),javascript:dbCopyTable()"
linkBase = "index.cfm"
iconBase = "../images/icons/"
target   = "ciframe"
selectedButton = 0
enabledList =  "1,0,0,0,0,0"
isToggleList = "0,0,0,0,0,0"
dir="vert"
>
<!--- END: Show Toolbar --->	