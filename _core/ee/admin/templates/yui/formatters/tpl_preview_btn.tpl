YAHOO.widget.DataTable.formatTplPreview = function(elCell, oRecord, oColumn, oData) { 
		var tpl_name = oRecord.getData('file_name'); 
		elCell.innerHTML = "<a target='_blank' title='<%str_to_title:<%cons:template_preview%>%>'  href='<%:EE_HTTP%>index.php?admin_template=yes&t=tpl_preview&tpl_name="+tpl_name+"'><img src='<%:EE_HTTP%>img/icons_library/gif/16/browse.gif' width='16' height='16' alt='<%str_to_title:<%cons:template_preview%>%>' border='0'></a>";		
	};