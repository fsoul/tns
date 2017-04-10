<%row%
<tr <%tr_bgcolor%>>

<%:row_fields%>

	<td>&nbsp;</td>
	<td align="center" height="25" class="table_data">
	<nobr>

<%iif:<%file_exists:<%:EE_PATH%><%:EE_IMG_PATH%>gallery/<%:gallery_id%>/<%:image_filename%>%>,,<img border="0" src="<%:EE_HTTP%>img/camera_p.gif">,<a href="#" onClick="openWin('<%:EE_GALLERY_HTTP%><%:gallery_id%>/<%:image_filename%>'\, 900\, 700); return false;" target="_blank"><img border="0" src="<%:EE_HTTP%>img/camera.gif" onMouseOver="ddrivetip('<img src=\\'<%:EE_GALLERY_HTTP%><%:gallery_id%>/_<%:image_filename%>\\'>');" onMouseOut="hideddrivetip();"></a>%>
&nbsp;&nbsp;

	<a href="javascript:openPopup('<%:modul%>.php?op=1&edit=<%:id%>&gallery_id=<%:gallery_id%>&admin_template=yes',<%:popup_width%>,<%:popup_height%>,<%:popup_scroll%>)"><img src="<%:EE_HTTP%>img/editBt.gif" width="16" height="16" alt="<%cons:GRID_EDIT%>" title= "<%cons:GRID_EDIT%>" border="0"></a>&nbsp;&nbsp;
	</td>
	<td align="center">
	<a href="#" onclick="del('<%:id%>','\'<%trim::name%>\' (id=<%:id%>)', 'gallery_id=<%:gallery_id%>')"><img src="<%:EE_HTTP%>img/delBt.gif" width="15" height="15" alt="<%cons:GRID_DEL%>" title ="<%cons:GRID_DEL%>" border="0"></a>
	</td>
	<td align="center">
	<%include:<%iif::modul,_seo,,_error_page,,list_row_sel_del%>%>		
	</nobr>
	</td>
</tr>

%row%>
<!--
<%row_empty%
<tr><td align="center" colspan="20" height="30"><%words:<%cons:No_records_found%>%></td></tr>
%row_empty%>
-->
