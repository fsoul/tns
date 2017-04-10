YAHOO.widget.DataTable.formatFolderAccess = function(elCell, oRecord, oColumn, oData) { 
		var is_enabled = oData;
		if (is_enabled == "0")
		{
			elCell.innerHTML = "<img src='<%:EE_HTTP%>img/folders_p.gif' width='16' height='16' alt='<%cons:GRID_DIR_ACCESS_LIST%>' title='<%cons:GRID_DIR_ACCESS_LIST%>' border='0'>";
		}
		else
		{
			elCell.innerHTML = "<button type='button' title='<%cons:GRID_DIR_ACCESS_LIST%>'><img src='<%:EE_HTTP%>img/folders_a.gif' width='16' height='16' alt='<%cons:GRID_DIR_ACCESS_LIST%>' border='0' /></button>";
		}
	};