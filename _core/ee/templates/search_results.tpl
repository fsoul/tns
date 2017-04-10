<%cms:<%iif:<%getValueOf:is_short_search_str%>,1,search_string_too_short%>%>
	<%iif:<%getValueOf:is_short_search_str%>,1,<br>%>
<%cms:<%iif::search_results_count,0,search_results_is_empty,,,search_results_count%>%>

<%include_if:admin_template,yes,search_edit_texts%>
<%show_search_results:search_item%>
