<%ap_process_password_update_form%>

<a name="password_update">&nbsp;</a>

<%include:page_error%>

<form action="#password_update" method="post" name="password_update">

<div class="int form-item">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%e_cms_cons:Password update form%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <div>

<table id="password_update_form" border="0">
  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:Old password%></td>
    <td>&nbsp;</td>
    <td width="175px">
      <input
        type="password" class="inputTxt"
        name="old_password"
        <%iif:<%getError:old_password%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
      />
    </td>
    <td>&nbsp;</td>
    <td width="150px">&nbsp;</td>
  </tr>

  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:New password%></td>
    <td>&nbsp;</td>
    <td>
<%text_edit_cms:password_rules_error%>
      <input
        type="password" class="inputTxt"
        name="new_password"
        <%iif:<%getError:new_password%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms:password_rules_error%>"
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:Confirm password%></td>
    <td>&nbsp;</td>
    <td>
<%text_edit_cms:password_rules_error%>
      <input
        type="password" class="inputTxt"
        name="confirm_password"
        <%iif:<%getError:confirm_password%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms:password_rules_error%>"
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

<%setValueOf:captcha_name,password_update_captcha_code%>
<%include:captcha_row%>

</table>

      <div id="register_form_submit_link">
<%text_edit_cms_cons:Save%>
        <a class="button link" href="javascript:document.forms['password_update'].submit();"><%cms_cons:Save%></a>
      </div>

      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>

</form>
