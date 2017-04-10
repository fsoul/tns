<a href="<%:EE_HTTP%>action.php?action=get_object_file&file=<%:<%:field_name%>%>"><b><%:<%:field_name%>%></b></a> (<%format_f_size:<%filesize:<%:EE_PATH%><%:EE_IMG_PATH%><%:<%:field_name%>%>%>%>)&nbsp;&nbsp;
<input type="hidden" name="<%:field_name%>" value="<%:<%:field_name%>%>">
<input type="submit" name="delete_file" value="<%:field_name%>" class="del-file-button">