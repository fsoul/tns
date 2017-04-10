<%ap_process_reffer_form%>

<a name="reffer">&nbsp;</a>

<%include:page_error%>

<form action="#reffer" method="post" name="reffer">

<div class="int">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%e_cms_cons:Reffer form%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <div>

<table id="reffer_form" border="0">
  <tr>
    <td align="left" colspan="5" collspan="5">
	<%text_edit_cms_cons:You can invite friends%><%cms_cons:You can invite friends%>
    </td>
  </tr>
<!--
  <tr class="narrow_text">
    <td align="center" colspan="5" collspan="5">
	<%text_edit_cms_cons:You can invite friends%><%cms_cons:You can invite friends%>
	<%text_edit_cms_cons:Your reffer link%><%cms_cons:Your reffer link%>:</td>
  </tr>

  <tr class="narrow_text">
    <td align="center" colspan="5" collspan="5"><a href="<%get_reffer_link%>"><%get_reffer_link%></a></td>
  </tr>
-->
  <tr class="narrow_text">
    <td align="center" colspan="5" collspan="5">&nbsp;</td>
  </tr>

  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:Invitation to email%></td>
    <td>&nbsp;</td>
    <td>
<%text_edit_cms_cons:Enter e-mail in standart format%>
      <input
        type="text"
	class="inputTxt"
        name="invitation_to_email"
        value="<%:invitation_to_email%>"
        <%iif:<%getError:invitation_to_email%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms_cons:Enter e-mail in standart format%>"
      />
    </td>
    <td>&nbsp;</td>
    <td>
      <div id="reffer_form_submit_link">
<%text_edit_cms_cons:Send%>
        <a class="system_button" href="javascript:document.forms['reffer'].submit();"><%cms_cons:Send%></a>
      </div>
    </td>
  </tr>


</table>


<%text_edit_cms:reffer_email_subject%>
<%html_edit_cms:reffer_email_body%>


      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>

</form>

