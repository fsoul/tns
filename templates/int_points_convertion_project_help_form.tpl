<div class="int" id="project_help"  <%iif:<%post:points_convertion_type%>,project_help,,style="display:none"%>>

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%e_cms_cons:Project Investigation of children help%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">

      <div class="form_row">
      </div>

<%setValueOf:password_sfx,project_help%>
<%include:int_points_convertion_password%>
  
<%include:int_points_convertion_send_request%>

    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>
