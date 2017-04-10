YAHOO.widget.DataTable.formatImagePreview = function(elCell, oRecord, oColumn, oData) { 
		var is_enabled = oData; 
		if (is_enabled == "0")
		{
			elCell.innerHTML = "<img border=\"0\" src=\"<%:EE_HTTP%>img/camera_p.gif\" alt=\"<%cons:No preview%>\" title=\"<%cons:No preview%>\">";
		}
		else
		{
			image_src = ('<%:modul%>' == '_gallery_image' ? "<%:EE_GALLERY_HTTP%>"+oRecord.getData('gallery_id')+"/_"+oRecord.getData('image_filename') : oData);
			elCell.innerHTML = "<button type=\"button\" onMouseOver=\"ddrivetip('<img src=\\'"+image_src+"\\'>');\" onMouseOut=\"hideddrivetip();\" target='_blank'><img border='0' src='<%:EE_HTTP%>img/icons_library/gif/16/camera.gif'></button>";
		}	
	};