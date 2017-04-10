<form method="post" name="<%form_builder_print_cms:form_builder_form_name_%>" id="form_<%:t%>" class="form_content" action="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>action.php?action=form_submit&t=<%:t%>&admin_template=yes" enctype="multipart/form-data" onsubmit="return validForm();">
<%form_builder_print_cms_e:form_builder_form_content_%>
<table cellspacing="0" cellpadding="0" border="0">
<%include:<%iif:<%form_builder_print_cms:form_builder_display_email_%>,1,form_builder/form_email_field%>%>
<%include:<%iif:<%page_cms:form_builder_form_disp_captcha_%>,1,form_builder/form_captcha%>%>
<tr>
	<td width="120"><input value="<%form_builder_print_cms:form_builder_submit_button_%>" name="submit" type="submit"><%form_builder_print_text_cms_edit:form_builder_submit_button_%></td>
	<td width="280">&nbsp;</td>
</tr>
<input type="hidden" name="page_id" value="<%:t%>">
<input type="hidden" name="page_dependent" value="<%:form_builder_page_dependent%>">
<input type="hidden" name="suffix" value="<%:form_builder_suffix%>">
</table>
</form>