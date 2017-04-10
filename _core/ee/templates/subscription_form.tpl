<%include:subscribe_hat%>
<form action="<%:EE_HTTP%>action.php" method="post">
<input type="hidden" name="action" value="newsletter_subscribe"/>
<input type="hidden" name="language" value="<%:language%>"/>
<!-- //for dissable group-checking use line
<input type="hidden" name="group_1" value="1"/> -->
<%iif::admin_template,yes,<input type="hidden" name="admin_template" value="yes"/>%>

	<table cellpadding="5" cellspacing="5" border="0">
		<tr><td colspan="3">	
			<%cms:<%iif::result,err_invalid_email_format,invalid_email_format,1%>%>
			<%cms:<%iif::result,err_at_least_one_group,at_least_one_group%>%>
			<%cms:<%iif::result,subscriber_exists,subscriber_exists%>%>
			<%cms:<%iif::result,ok,subscription_confirmed,1%>%>
			<%cms:<%iif::result,err_blank_name,blank_name,1%>%>
			<%cms:<%iif::result,err_blank_lname,blank_last_name,1%>%>
			<br/>
			<%e_page_cms:text%>			
		</td></tr>
<%parse_sql_to_html:SELECT * FROM v_nl_group WHERE show_on_front=1,nl_groups_row%>
		<tr><td><%cms_e:your_name_text%></td><td colspan="2"><input type="text" name="name" size="40" value="<%:name%>"/></td></tr>
		<tr><td><%cms_e:your_lname_text%></td><td colspan="2"><input type="text" name="lname" size="40" value="<%:lname%>"/></td></tr>
		<tr><td><%cms_e:your_email_text%></td><td colspan="2"><input type="text" name="email" size="40" value="<%:email%>"/></td></tr>
		<tr><td colspan="3" align="right"><input type="submit" size="5" value="<%cms:submit_text%>" class="red_button" /><%text_edit_cms:submit_text%></td></tr>
		<tr><td colspan="3" align="right"><%cms:text_bottom%><%edit_cms2:text_bottom%></td></tr>
	</table>
<input type="hidden" name="page_id" value="<%:page_id%>" />
<%include_if:admin_template,yes,subscription_edit%>
</form>
<%include:subscribe_foot%>