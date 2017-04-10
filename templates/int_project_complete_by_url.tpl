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
      <div style="font-size: 16px">
          <%ap_process_project_complete_by_url%>
<!--
<%:project_complete_code%> -->
<!--<%:complete_type%> -->
          <%longtext_edit_cms:project_no_params_text%>
          <%longtext_edit_cms:project_not_complete_text%>
          <%longtext_edit_cms:project_complete_text_1%>
          <%longtext_edit_cms:project_complete_text_2%>
          <%longtext_edit_cms:project_complete_text_3%>
          <%longtext_edit_cms:project_complete_text_4%>
          <%longtext_edit_cms:project_complete_text_score%>
		  <%longtext_edit_cms:project_complete_text_ending%>
          <%ap_project_complete_result::project_complete_code,<%:complete_type%>%>
      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>


<%include:footer_internal%>