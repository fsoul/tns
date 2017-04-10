YAHOO.widget.DataTable.formatExportFormData = function(elCell, oRecord, oColumn, oData) { 
		var form_name = oRecord.getData('form_name');
		var id = oRecord.getData('hidden_id');
		var is_enabled = oData;
		if (is_enabled == "0")
		{
			elCell.innerHTML = "<img src='<%:EE_HTTP%>img/export_db_p.gif' width='16' height='16' alt='<%cons:Export%>' title='<%cons:Export%>' border='0'>";		
		}
		else
		{
			elCell.innerHTML = "<a href='<%:modul%>.php?op=export_form_to_csv&edit="+id+"&form_name="+encodeURIComponent(form_name)+"'><img src='<%:EE_HTTP%>img/export_db_a.gif' width='16' height='16' alt='<%cons:Export%>' title='<%cons:Export%>' border='0'></a>";		
		}
	};