	YAHOO.widget.DataTable.formatDel = function(elCell, oRecord, oColumn, oData)
	{ 
		var is_enabled = oData[0];
		var error_message = oData[1];

		if (is_enabled)
		{
			elCell.innerHTML = "<button type=\"button\" title=\"<%cons:GRID_DEL%>\"><img alt=\"<%cons:GRID_DEL%>\" src=\"<%:EE_HTTP%>img/icons_library/gif/16/stop.gif\"/></button>";
		}
		else
		{
			elCell.innerHTML = "<img title=\"" + error_message + "\" alt=\"" + error_message + "\" src=\"<%:EE_HTTP%>img/delBt_gray.gif\"/>";
		}	
	};