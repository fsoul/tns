<!-- sitemap_html begin-->

<%e_page_cms:sitemap_html_text_head%>

<%saveMap::choosed%>

<%iif::admin_template,yes,                      
		<form name="current" method="post">
			<div>
				Chooser list:
			</div>
			<div>
				      <%optionMenu%> 
			</div>
		</form>   
%>

<%site_map:<%iif::choosed,,<%function_check_if_one_map:<%getMap%>%>,<%saveMap::choosed%><%:choosed%>%>,menu/map_top,menu/map_bottom,menu/map_next_top,menu/map_next_bottom,menu/map_item,menu/map_subitem%>

<%e_page_cms:sitemap_html_text_foot%>

<!-- sitemap_html end-->







