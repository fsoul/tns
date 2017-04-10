<%ap_authorized_only%>

<%set_allowed_uri_params_list:page%>

<%include:header_internal%>


<%ap_survey_history:<%iif:<%get:page%>,,1,<%get:page%>%>%>


<div class="int">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
      <%e_cms_cons:Points convertion%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <%e_cms:points_using_comment%>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>


<%include:footer_internal%>
