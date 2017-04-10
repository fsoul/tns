<div id="survey_history_navigation">
<%text_edit_cms_cons:First page%>
<%text_edit_cms_cons:first%>
<%text_edit_cms_cons:Previous page%>
<%text_edit_cms_cons:previous%>
<%text_edit_cms_cons:Previous_pages_block%>
<%text_edit_cms_cons:Next_pages_block%>
<%text_edit_cms_cons:Next page%>
<%text_edit_cms_cons:next%>
<%text_edit_cms_cons:Last page%>
<%text_edit_cms_cons:last%>
<%iif::page_url_prev,,,<a class="system_button_navigation_back" title="<%cms_cons:First page%>" href="<%:page_url_first%>#list"><%cms_cons:first%>%><%iif::page_url_prev,,,</a>%>
<%iif::page_url_prev,,,<a class="system_button_navigation_back" title="<%cms_cons:Previous page%>" href="<%:page_url_prev%>#list"><%cms_cons:previous%>%><%iif::page_url_prev,,,</a>%>
<%iif::page_url_prev_block,,,<a title="<%cms_cons:Previous_pages_block%>" href="<%:page_url_prev_block%>#list">...</a>%>

<%row%
	<%iif::page_url,,,<a href="<%:page_url%>#list">%><%:page_number%><%iif::page_url,,,</a>
	%>
%row%>

<%iif::page_url_next_block,,,<a title="<%cms_cons:Next_pages_block%>" href="<%:page_url_next_block%>#list">...</a>%>
<%iif::page_url_next,,,<a class="system_button_navigation" title="<%cms_cons:Next page%>" href="<%:page_url_next%>#list"><%cms_cons:next%>%><%iif::page_url_next,,,</a>%>
<%iif::page_url_next,,,<a class="system_button_navigation" title="<%cms_cons:Last page%>" href="<%:page_url_last%>#list"><%cms_cons:last%>%><%iif::page_url_next,,,</a>%>

</div>
