<%ap_authorized_only%>

<%include:header_internal%>

<%include:reffer_form%>

<%ap_process_edit_profile_form%>
<%setValueOf:rndmz_for_captcha,<%rand:0,<%time%>%>%>

<%include:ap_ajax_selectors%>
<script type="text/javascript" src="<%:EE_HTTP%>js/respondent.js"></script>

<a name="edit_profile">&nbsp;</a>

<%include:page_error%>

<form action="#" method="post" name="registration">

<div class="int">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
		<%cms_cons:Registration form%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <div class="form-item">

<table id="respondent_edit_form" border="0">

<%setValueOf:respondent_id_,<%ap_get_respondent_id%>%>

<%include:ap_respondent_fields%>

<%setValueOf:captcha_name,respondent_fields_captcha_code%>
<%include:captcha_row%> 

  <tr><td colspan="5"><%cms_cons:Password for update confirmation%>:</td></tr>

  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>
      <input
        type="password"
        name="pass_"
        class="inputTxt"
        <%iif:<%getError:pass_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>


</table>

      <div id="register_form_submit_link">
<%text_edit_cms_cons:Send%>
        <a class="button link" href="javascript:setHidden(); document.forms['registration'].submit();"><%cms_cons:Send%></a>
      </div>

      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>


</form>
<%text_edit_cms_cons:Unsubscribe%>
<%text_edit_cms_cons:Are you sure you unsubscribe%>
<div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
        <%cms_cons:Unsubscribe%>
    </div>
</div><br>
<a class="button link" href="javascript:void(0)" onclick="process_unsubscribe()"><%cms_cons:Unsubscribe%></a>
<script type="text/javascript">
    function process_unsubscribe() {
        if(confirm("<%cms_cons:Are you sure you unsubscribe%>")) {
            location.href = '<%:EE_HTTP%>action.php?action=user_unsubscribe';
        }
        return false;
    }
</script>
<br>
<%include:password_update_form%>

<%include:footer_internal%>

