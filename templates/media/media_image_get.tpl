<%media_get2:images%>
<%iif:<%:media_link_on%>,1,<a href = "<%getValueOf:media_link_url,0,0%>" <%tpl_escape_coma:<%stick_xiti_attribute:<%tpl_escape_coma:<%getValueOf:xitiClickType%>%>,<%tpl_escape_coma:<%getValueOf:xitiS2%>%>,<%tpl_escape_coma:<%getValueOf:xitiLabel%>%>%>%> target = "<%:media_link_open_type%>" <%iif:<%getValueOf:media_title%>,,,title="<%getValueOf:media_title%>"%>>,%>
	<img <%iif:<%file_ext:<%:media_file%>%>,png,class="transparent"%> src="<%:media_file%>" border="<%:media_border%>" <%iif:<%:media_height%>,,,<%iif:<%:media_height%>,0,,height="<%:media_height%><%iif::media_unit_type,%,%,%>"%>%> <%iif:<%:media_width%>,,,width="<%:media_width%><%iif::media_unit_type,%,%,%>"%> title="<%iif:<%:media_alt%>,,,<%getHtmlOf:media_alt%>%>" alt="<%iif:<%:media_alt%>,,,<%getHtmlOf:media_alt%>%>" <%:tag_params%>/><%iif:<%:media_link_on%>,1,</a>,%>