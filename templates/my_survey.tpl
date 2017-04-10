<%ap_authorized_only%>

<%set_allowed_uri_params_list:page%>

<%include:header_internal%>

<%ap_current_projects_list2:current_projects_row2%>


				<div id="page_header">
<%e_page_cms:page_header2%>
				</div>
				
				<div id="page_comment">
<%e_page_cms:page_comment2%>
				</div>
		

<%ap_survey_history:<%iif:<%get:page%>,,1,<%get:page%>%>%>

<%include:reffer_form%>


<%include:footer_internal%>
