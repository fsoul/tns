<%include:page_error%>

<form action="#" method="post" name="password">

<input type="hidden" name="sid" value="<%get:sid%>" />
 


<div class="int form-item">

<%text_edit_page_cms:int_h_1_class%>
  <div class="int_h color_<%page_cms:int_h_1_class%>">
    <div class="int_h_text">
	<%e_cms_cons:Registration form%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_1_class%>">
    <div class="int_b_content">

<table id="respondent_edit_form" border="0">

<%include:password_fields%>

<%include:captcha_row%>

</table>

      <div id="register_form_submit_link">
<%text_edit_cms_cons:Save%>
        <a class="button link" href="javascript:document.forms['password'].submit();"><%cms_cons:Save%></a>
      </div>

    </div>
  </div>
<%text_edit_page_cms:int_b_1_class%>

</div>


</form>
