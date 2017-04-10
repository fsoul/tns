<form name="select_category" action="<%:EE_HTTP%>set_channel.php" method="post">
<table class="redform"><tr><td>
	<input type="hidden" name="admin_template" value="yes">
	<input type="hidden" name="language" value="<%:language%>">
	<input type=hidden name="page_id" value="<%:t%>">
	<select name="channel" style="width:150"><option value=-1 <%iif:<%cms:page_channel_<%:t%>%>,-1,selected%>></option><%build_channel_list:<%cms:page_channel_<%:t%>%>%></select>	
	<input type="text" name="limit" style="width:50" value="<%cms:page_news_limit_<%:t%>%>">
	<input type="submit" value="filter">
	<!--<a href="<%:EE_HTTP%>?t=32<%iif::admin_template,yes,&admin_template=yes%>">all&nbsp;events</a>-->
</td></tr></table>
</form>