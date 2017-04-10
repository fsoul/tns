YAHOO.widget.DataTable.formatModulesList = function(elCell, oRecord, oColumn, oData) { 
		var is_enabled = oData;
		var title = ('<%:modul%>' == '_tpl_folder') ? '<%words:<%cons:folder_access%>%>' : '<%cons:GRID_MODULS_LIST%>';
		if (is_enabled == "0")
		{
			elCell.innerHTML = "<img src='<%:EE_HTTP%>img/options2_16_p.gif' width='16' height='16' title='"+title+"' alt='"+title+"' border='0'>";
		}
		else
		{
			elCell.innerHTML = "<button type='button' title='"+title+"'><img src='<%:EE_HTTP%>img/options2_16_a.gif' width='16' height='16' alt='"+title+"' border='0'></button>";
		}
	};