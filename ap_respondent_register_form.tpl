<%set_allowed_uri_params_list:reffer_email_%>

<%ap_process_registration_form%>

<%include:header_internal%>

<%include:page_error%>

<%include:ap_ajax_selectors%>


<script type="text/javascript" src="<%:EE_HTTP%>js/respondent.js"></script>


<form action="#" method="post" name="registration">

<div class="int">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
		<%e_cms_cons:Registration form%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <div>

<input type="hidden" name="tns_id" id="tnsId" value="">

<table id="respondent_edit_form" border="0">

<%setValueOf:respondent_id_,0%>

<%include:ap_respondent_fields%>

<%include:password_fields%>

  <tr class="narrow">
    <td><%inv:105%></td>
    <td><%inv:5%></td>
    <td><%inv:175%></td>
    <td><%inv:5%></td>
    <td><%inv:125%></td>
  </tr>

  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:Reffer%><br/><span class="small_text"><%e_cms_cons:if exists%></span></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Enter reffer email if you know it%>
      <input
        type="text"
	class="inputTxt"
	name="reffer_email_"
	value="<%:reffer_email_%>"
        <%iif:<%getError:reffer_email_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms_cons:Enter reffer email if you know it%>"
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr class="narrow">
    <td><%inv:105%></td>
    <td><%inv:5%></td>
    <td><%inv:175%></td>
    <td><%inv:5%></td>
    <td><%inv:125%></td>
  </tr>

<%include:ap_respondent_cumulative_card_number%>

<%setValueOf:captcha_name,respondent_fields_captcha_code%>
<%include:captcha_row%> 

  <tr><td colspan="5">&nbsp;</td></tr>

  <tr>
    <td align="right" valign="top">

<div id="reg_form_checkbox" <%iif:<%getError:checkboxConfirm%>,,,class="error"%>>
      <input
        type="checkbox"
        id="checkboxConfirm"
        name="checkboxConfirm"
	<%iif::checkboxConfirm,,,checked="checked"%>
      />
</div>

    </td>
    <td>&nbsp;</td>
    <td colspan="3">
      <%e_cms:rules_read_confirm%>
    </td>
  </tr>


</table>

      <div id="register_form_submit_link" <%iif:<%count_post:%>,0,style="display:none"%>>
<%text_edit_cms_cons:Send%>
        <a class="system_button" href="javascript:setHidden(); document.forms['registration'].submit();"><%cms_cons:Send%></a>
      </div>

      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>

</form>

<%longtext_edit_page_cms:email_subject%>
<%longtext_edit_page_cms:email_body%>


<div class="flash">
<%media_insert:flash,registration_form%>
</div>

<%include:footer_internal%>

