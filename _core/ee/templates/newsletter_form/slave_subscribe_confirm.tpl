<%include:header%>
<iframe src="<%:SLAVE_MASTER_SITE%>/action.php?language=<%:language%>&site_name=<%:SLAVE_SITE_NAME%>&slave_server=<%urlencode:<%:EE_HTTP_SERVER%>%>&slave_prefix=<%urlencode:<%:EE_HTTP_PREFIX%>%>&action=nl_slave_confirm&confirm_code=<%get:confirm_code%>" frameborder="0" height="500" width="444" marginheight="0" marginwidth="0" scrolling="no"></iframe>
<%include:footer%>