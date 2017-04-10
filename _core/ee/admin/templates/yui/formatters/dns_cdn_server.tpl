YAHOO.widget.DataTable.dnsCDNServer = function(elCell, oRecord, oColumn, oData) { 
		var is_enabled = oData;
		if (is_enabled == "0")
		{
			elCell.innerHTML = '<%inv:16,16%>';
		}
		else
		{
			elCell.innerHTML = '<a href=""><img src="<%:EE_HTTP%>img/comp_web.gif" width="16" height="16" border="0" title="As CDN for: '+is_enabled+'" alt="CDN" /></a>';
		}
	};