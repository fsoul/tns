<select name="choosed" onchange='javascript:document.current.submit()'>
<%iif:<%cms:sitemap_html_selected_menu,<%:t%>,%>,,<%iif:<%:menu_items_count%>,1,,<option></option>%>%>
<%row%
	<option value="<%:id_map%>" <%iif:<%:sel%>,1,,selected%>>page_id_<%:t%>_<%:sitemap_html_name%></option>
%row%>
</select>




