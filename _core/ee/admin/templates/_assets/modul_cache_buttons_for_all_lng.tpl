<%iif:<%check_if_exists_other_lng_cache:<%:id%>%>,1,
	<%iif:<%check_folder_exist:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,1,
		<%iif:<%is_writable:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,1,
			<a onclick="return confirm('Are you sure to clear the cache this page?')" title="<%:DELETE_CACHE_ALL_LANG%>" href="<%:EE_ADMIN_URL%><%:modul%>.php?op=delete_page_cache_for_all_lng&t=<%:id%>&admin_template=yes"><img src="<%:EE_HTTP%>img/cache/cache_exists_row.gif" width="16" height="16" alt="<%:DELETE_CACHE_ALL_LANG%>" border="0"/></a>,
			<%inv:16,16%>%>,<%inv:16,16%>
		%>
,<%inv:16,16%>
%> 


