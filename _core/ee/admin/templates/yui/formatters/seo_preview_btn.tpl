YAHOO.widget.DataTable.formatSeoPreview = function(elCell, oRecord, oColumn, oData) { 
		var data = oData; 
		elCell.innerHTML = "<img onMouseOver=\"ddrivetip('"+data+"')\" onMouseOut=\"hideddrivetip()\" src=\"<%:EE_HTTP%>img/meta_preview.gif\" width=\"16\" height=\"16\" alt=\"<%str_to_title:<%cons:meta_tags_preview%>%>\" border=\"0\">";		
	};