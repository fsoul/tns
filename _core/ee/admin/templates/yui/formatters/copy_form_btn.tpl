YAHOO.widget.DataTable.formatCopyForm = function(elCell, oRecord, oColumn, oData) { 
		var id = oRecord.getData('hidden_id'); 
		elCell.innerHTML = "<a href='<%:modul%>.php?op=copy_form&form_id="+id+"' title='<%cons:COPY_FORM%>'><img src='<%:EE_HTTP%>img/icons_library/gif/16/copy.gif' width='16' height='16' alt='<%cons:COPY_FORM%>' border='0'></a>";		
	};