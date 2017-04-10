YAHOO.widget.DataTable.formatView = function(elCell, oRecord, oColumn, oData) { 
		var id = oData;
		elCell.innerHTML = "<button type='button' title='<%cons:GRID_PREVIEW%>'><img src='<%:EE_HTTP%>img/icons_library/gif/16/zoom_in.gif' width='16' height='16' alt='<%cons:GRID_PREVIEW%>' border='0'></button>";
	};