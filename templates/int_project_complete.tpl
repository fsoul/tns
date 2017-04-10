
<%set_allowed_uri_params_list:project_code,respondent_code,complete_type%>

<%include:header_internal%>


<div class="int">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%page_cms:internal_page_header%>
<%text_edit_page_cms:internal_page_header%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <div>
<%e_cms_cons:Project code%>: <%get:project_code%><br />
<%e_cms_cons:Respondent code%>: <%iif:<%get:respondent_code%>,,<%ap_get_respondent_id%>,<%get:respondent_code%>%><br />
<%e_cms_cons:Complete type%>: <%iif:<%get:complete_type%>,,1,<%get:complete_type%>%><br /><br />
<%ap_process_project_complete%>
      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>


<%include:footer_internal%>
