<%setValueOf:admin,0%><%setValueOf:get_as_tag,1%><%setValueOf:is_preview,1%><%setValueOf:t,<%:id%>%>
<%setValueOf:get_media_file_by_id_<%:id%>,<%get_media_file_by_id::id%>%>
<%iif:<%:get_media_file_by_id_<%:id%>%>,,,<a href="#" onClick="openWin(\'<%:get_media_file_by_id_<%:id%>%>\'\, <%tpl_add::popup_x,50%>\, <%tpl_add::popup_y,50%>); return false;" target="_blank">%><img

border="0"

src="<%:EE_HTTP%>img/camera.gif"

onMouseOver="ddrivetip('<%print_preview_source::id%>');"

onMouseOut="hideddrivetip();"

><%iif:<%:get_media_file_by_id_<%:id%>%>,,,</a>%>&nbsp;&nbsp;<%setValueOf:admin,1%><%setValueOf:get_as_tag,0%><%setValueOf:is_preview,0%>