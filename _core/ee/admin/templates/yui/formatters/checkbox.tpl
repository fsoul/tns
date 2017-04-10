YAHOO.widget.DataTable.formatCheckbox = function(elCell, oRecord, oColumn, oData) { 
		var is_enabled = oData;
		if (is_enabled == "0")
		{
			elCell.innerHTML = "<input type='checkbox' disabled value='"+oRecord.getData("hidden_id")+"' name='selected_items[]'/>";
		}
		else
		{
			elCell.innerHTML = "<input type='checkbox' value='"+oRecord.getData("hidden_id")+"' name='selected_items[]'/>";
		}
	};