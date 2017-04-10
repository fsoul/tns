<%media_get2:flash%>
<%iif:<%:media_link_on%>,1,<a href = "<%:media_link_url%>" <%tpl_escape_coma:<%stick_xiti_attribute:<%tpl_escape_coma:<%getValueOf:xitiClickType%>%>,<%tpl_escape_coma:<%getValueOf:xitiS2%>%>,<%tpl_escape_coma:<%getValueOf:xitiLabel%>%>%>%> target = "<%:media_link_open_type%>" <%iif:<%getValueOf:media_title%>,,,title="<%getValueOf:media_title%>"%>>,,%>
<object style="background:<%:media_bgcolor%>;" id="<%:media_name%>" <%iif::media_height,,,height="<%:media_height%><%iif::media_unit_type,%,%,%>"%> <%iif::media_width,,,width="<%:media_width%><%iif::media_unit_type,%,%,%>"%> type="application/x-shockwave-flash" data="<%:media_file%>">
	<param name="movie"	value="<%:media_file%>" />
	<param name="menu"	value="<%:media_show_menu%>" />
	<param name="quality"	value="<%:media_quality%>" />
	<param name="bgcolor"	value="<%:media_bgcolor%>" />
	<param name="wmode"	value="opaque" />
</object><%iif:<%:media_link_on%>,1,</a>,,%>