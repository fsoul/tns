YAHOO.widget.DataTable.formatDel = function(elCell, oRecord, oColumn, oData) { 
		var is_enabled = oData;
		if (is_enabled == "0")
		{
			elCell.innerHTML = "<img title=\"<%cons:<%iif::modul,_tpl_file,TPL_FILE_CANT_DELETE,GRID_DEL%>%>\" alt='<%cons:<%iif::modul,_tpl_file,TPL_FILE_CANT_DELETE,GRID_DEL%>%>' src='<%:EE_HTTP%>img/delBt_gray.gif'/>";
		}
		else
		{
			elCell.innerHTML = "<button type='button' title='<%cons:GRID_DEL%>'><img alt='<%cons:GRID_DEL%>' src='<%:EE_HTTP%>img/icons_library/gif/16/stop.gif'/></button>";
		}	
	};