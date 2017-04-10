<%set_allowed_uri_params_list:id,page,load_cookie%>

<%include:header_internal%>


<%ap_investigation_detail:<%get:id%>%>



<div class="int">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
<%text_edit_cms_cons:list%>
<a name="<%cms_cons:list%>" >
    <div class="int_h_text">
<%e_cms_cons:Investigations%>
    </div>
</a>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <div>

<%ap_investigations_list:<%iif:<%get:page%>,,1,<%get:page%>%>%>

      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>

<%include:footer_internal%>

