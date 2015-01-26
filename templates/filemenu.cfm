<div class="menuBar" style="width:100%;">
<a class="menuButton" href="" onclick="return buttonClick(event, 'mnuFile');" onmouseover="buttonMouseover(event, 'mnuFile');">File</a>
<a class="menuButton" href="" onclick="return buttonClick(event, 'mnuTools');" onmouseover="buttonMouseover(event, 'mnuTools');">Tools</a>
<a class="menuButton" href="" onclick="return buttonClick(event, 'mnuLink');" onmouseover="buttonMouseover(event, 'mnuLink');">Link</a>
<a class="menuButton" href="" onclick="return buttonClick(event, 'mnuHelp');" onmouseover="buttonMouseover(event, 'mnuHelp');">Help</a>
</div>
<div onmouseover="menuMouseover(event)" id="mnuFile" class="menu">
	<a class="menuItem" href="" onclick="openConnDiag();return false;">Open Connection</a>
	<a class="menuItem" href="" onclick="closeConn();return false;">Close Connection</a>
</div>
<div onmouseover="menuMouseover(event)" id="mnuTools" class="menu">
	<a class="menuItem" href="javascript:refreshPane();">Refresh</a>
	<a class="menuItem" href="javascript:createDB();">Create Database</a>
	<a class="menuItem" href="" onclick="return false;" onmouseover="menuItemMouseover(event, 'mnuToolsFlush');"><span class="menuItemText">Flush</span><span class="menuItemArrow">&#9654;</span></a>
	<a class="menuItem" href="javascript:userManager()">User Manager</a>
</div>
<div onmouseover="menuMouseover(event)" id="mnuLink" class="menu">
	<a class="menuItem" href="http://www.cfmyadmin.com/" target=_blank>CFMyAdmin.com</a>
	<a class="menuItem" href="http://www.digital-crew.com/" target=_blank>Digital Crew</a>
	<a class="menuItem" href="http://www.cftagstore.com/" target=_blank>CFTagStore.com</a>
</div>
<div onmouseover="menuMouseover(event)" id="mnuHelp" class="menu">
	<a class="menuItem" href="javascript:about()">About CFMyAdmin</a>
	<a class="menuItem" href="javascript:checkForUpdate()">Check for update</a>
	<a class="menuItem" href="javascript:version()">Version</a>
</div>
<div onmouseover="menuMouseover(event)" id="mnuToolsFlush" class="menu">
	<a class="menuItem" href="" onclick="return doQuickSQL('FLUSH Hosts')">Hosts</a>
	<a class="menuItem" href="" onclick="return doQuickSQL('FLUSH Logs')">Logs</a>
	<a class="menuItem" href="" onclick="return doQuickSQL('FLUSH Privileges')">Privileges</a>
	<a class="menuItem" href="" onclick="return doQuickSQL('FLUSH Tables')">Tables</a>
	<a class="menuItem" href="" onclick="return doQuickSQL('FLUSH Tables with read lock')">Tables With Read Lock</a>
	<a class="menuItem" href="" onclick="return doQuickSQL('FLUSH status')">Status</a>
</div> 