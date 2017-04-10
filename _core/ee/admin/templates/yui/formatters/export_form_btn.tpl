YAHOO.widget.DataTable.formatExportForm = function(elCell, oRecord, oColumn, oData) { 
		var form_name = oRecord.getData('form_name');
		var id = oRecord.getData('hidden_id');
		var is_enabled = oData;
		elCell.innerHTML = "<a href='<%:modul%>.php?op=export_2_xml&form_id="+id+"' title='<%:FORMBUILDER_EXPORT_FORM%>'><img src='<%:EE_HTTP%>img/xml_export.gif' width='16' height='16' alt='<%:FORMBUILDER_EXPORT_FORM%>' border='0'></a>";		
	};