<%ap_process_password_reminder_form%>

<%include:header_internal%>

<%include:page_error%>

<form action="#" method="post" name="reminde_password">

<div class="int form-item">

  <div class="int_h">
    <div class="int_h_text">
      <%cms_cons:Password reminder form%>
    </div>
  </div>

  <div class="int_b">
    <div class="int_b_content">
      <div>
        <%cms_cons:Enter your e-mail%>:
      </div>
  
      <div class="int_b_text_form center">
        <input type="text" class="inputTxt" id="inputEnterEmail" name="email_" value="<%post:email_%>" placeholder="<%cms_cons:Login%>"/>
      </div>
  
      <div class="int_b_text_submit">
<%text_edit_cms_cons:Send%>
        <a class="button link" href="javascript:document.forms['reminde_password'].submit();"><%cms_cons:Send%></a>
      </div>
    </div>
  </div>

</div>


</form>
