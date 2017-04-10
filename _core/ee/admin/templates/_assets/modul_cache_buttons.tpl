<%iif::cache_status,Yes,
<a onclick="return confirm('Are you sure to clear the cache this page for <%:language%> language?')" title="<%:EE_DELETE_CACHE_CURR_LANG%> for <%:language%> language"   href="<%:EE_ADMIN_URL%><%:modul%>.php?op=delete_page_cache&t=<%:id%>&admin_template=yes&language=<%:language%>">
<img src="<%:EE_HTTP%>img/delete_cache_page.gif" width="16" height="16" alt="<%:EE_DELETE_CACHE_CURR_LANG%> for <%:language%> language" border="0"/></a>,<%inv:16,16%>%>
