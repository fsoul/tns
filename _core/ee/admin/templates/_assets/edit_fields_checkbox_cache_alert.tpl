<script type="text/javascript">
function check_box_alert(obj, type)
{
	if (obj.checked == false)
	{
		switch(type)
		{
			case 'draft_content':
				if (!confirm('This will publish all your draft content. Are you sure?')) obj.checked=true;
				break;
			case 'cache_html':
                	        if (!confirm('This will delete all cache. Are you sure?')) obj.checked=true;
				break;				
		} 
	}
}

</script>
<input <%iif::readonly,,,readonly%> type="checkbox" name="<%:field_name%>" <%iif:<%check_folder_exist:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,1,<%iif:<%is_writable:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,1,<%iif:<%:<%:field_name%>%>,1,checked%>%>%> value="1" onchange="check_box_alert(this, 'cache_html')">
<%iif:<%check_cache_enabled%>,1,
<%iif:<%check_folder_exist:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,,<span class = "error">Warning! Cache folder is not exists</span>,
	<%iif:<%is_writable:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,,<span class = "error">Warning! Cache folder is not writable</span>%>
%>
%>
