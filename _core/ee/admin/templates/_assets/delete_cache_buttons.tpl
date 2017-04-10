<td nowrap>
<%iif:<%check_folder_exist:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,1,
	<%iif:<%is_writable:<%:EE_PATH%><%:EE_CACHE_DIR%>%>,1,	
		<%iif:<%check_if_cache_exists%>,1,
			<a href="<%:modul%>.php?op=delete_all_cache" onclick="return confirm('Are you sure to clear the cache?')" title="Clear the cache"><img src="<%:EE_HTTP%>img/cache/cache_exists.gif" height="24" width="24" border="0" style="margin:5px;" alt="Clear the cache"/></a>&nbsp;
			,
			<img src="<%:EE_HTTP%>img/cache/cache_enabled.gif" height="24" width="24" border="0" style="margin: 5px;" alt="Cache is enabled" title = "Cache is enabled"/>
		%>,,<img src="<%:EE_HTTP%>img/cache/cache_error.png" height="24" width="24" border="0" style="margin: 5px;" alt="Cache folder is not writable" title = "Cache folder is not writable"/>
	%>
,<img src="<%:EE_HTTP%>img/cache/cache_error.png" height="24" width="24" border="0" style="margin:5px;" alt="Cache folder is not exists" title = "Cache folder is not exists" />
%>
</td>