YAHOO.widget.DataTable.formatObjectLink = function(elCell, oRecord, oColumn, oData) {
		elCell.innerHTML = "<a target='_blank' href='<%:EE_HTTP%>"+oData+"' title='[^] "+oRecord.getData('object_name')+" object'><img alt='<%cons:View page%>' src='<%:EE_HTTP%>img/doc.gif' border='0' /></a>";
	};