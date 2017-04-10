<%set_allowed_uri_params_list:sid%>

<%include:header_internal%>

<%include:<%iif:<%ap_process_respondent_activate%>,1,internal_div,incorrect_sid%>%>

<%longtext_edit_page_cms:email_subject%>
<%longtext_edit_page_cms:email_body%>

<%include:footer_internal%>
