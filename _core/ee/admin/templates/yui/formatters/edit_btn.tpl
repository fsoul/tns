YAHOO.widget.DataTable.formatEdit = function(elCell, oRecord, oColumn, oData) { 
		var is_enabled = oData;
		if ('<%:modul%>' == '_formbuilder')
		{
			elCell.innerHTML = "<a href='<%:modul%>.php?op=1&edit="+oRecord.getData('hidden_id')+"' title='<%cons:GRID_EDIT%>'><img src=\"<%:EE_HTTP%>img/icons_library/gif/16/pen.gif\" title='<%cons:GRID_EDIT%>' alt='<%cons:GRID_EDIT%>' border='0'></button>";
		}
		else
		{
			if (is_enabled == '0')
			{
				elCell.innerHTML = "<img src=\"<%:EE_HTTP%>img/icons_library/gif/16/pen.gif\" title='<%cons:GRID_EDIT%>' alt='<%cons:GRID_EDIT%>' onclick=\"alert('<%words:<%cons:NO_CONTENT_ACCESS%>%>');\">";
			}
			else
			{
				elCell.innerHTML = "<button type='button' title='<%cons:GRID_EDIT%>'><img src=\"<%:EE_HTTP%>img/icons_library/gif/16/pen.gif\" title='<%cons:GRID_EDIT%>' alt='<%cons:GRID_EDIT%>'></button>";
			}
		}
	};