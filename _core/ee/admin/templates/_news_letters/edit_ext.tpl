<script language="JavaScript"  type="text/javascript">
 function check_groops() {
	var checkbox_choices = false;
	var empls = document.form_send_letter['group_ids[]'];
	var langs_checked = false;
 	var langs = document.form_send_letter['language_ids[]'];
	
	//if (empls==undefined){
		for(var i=0; i<empls.length; i++) {
			if(empls[i].checked){
				checkbox_choices = true;
				break;
			}
		}
	/*}else{
		checkbox_choices = document.form_send_letter['group_ids'].checked;
	}*/
	for(var i=0; i<langs.length; i++){
		if(langs[i].checked){
			langs_checked = true;
			break;
		}
	}
	
	if(empls.length == undefined) checkbox_choices = document.form_send_letter['group_ids[]'].checked;
	if(langs.length == undefined) langs_checked = document.form_send_letter['language_ids[]'].checked;
	if(!langs_checked && !checkbox_choices){
		alert('Please select one or more groups and languages');
	}else if (!langs_checked){
		alert('Please select one or more languages');
	}else if (!checkbox_choices){
		alert('Please select one or more groups');
	}
	return (checkbox_choices && langs_checked);
}
</script>

<tr <%tr_bgcolor%>>
	<td><img src="../img/inv.gif" width="200" height="10" alt=""/></td>
	<td><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
	<td width="100%"><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Newsletter status</td>
	<td><%case_title::email_status%></td>
	<td class="error">&nbsp;&nbsp;</td>
</tr>
<form name="form_send_test_letter" method="POST" action="?op=6&edit=<%:edit%>&admin_template=yes">
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;<input type="submit" class="button" name="send_test" value="Send Test"></td>
	<td><input type="text" name="email_test" value="Type here valid email" size="30" onFocus="if(this.value == 'Type here valid email') this.value = '';" onBlur="if(this.value == '') this.value = 'Type here valid email';"></td>
	<td <%iif:<%getError:email_test_succ%>,,class="error",class="success"%>>&nbsp;&nbsp;<%getError:email_test%><%getError:email_test_succ%></td>
</tr>
</form>
<form name="form_send_letter" method="POST" action="?op=5&edit=<%:edit%>&admin_template=yes" onsubmit="return check_groops();" id="form_send_letter">
<input type="hidden" name="op" value="5">
<input type="hidden" name="edit" value="<%:edit%>">
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;<input type="<%iif::email_status,draft,submit,hidden%>" class="button" name="send_letter" value="Send Letter"></td>
	<td>
	<%parse_sql_to_html:SELECT nl_group.*\, count(nl_email_group.nl_email_id) AS email_count FROM nl_group AS nl_group LEFT JOIN nl_email_group AS nl_email_group ON nl_group.id = nl_email_group.nl_group_id AND nl_email_group.nl_email_id = <%:email_id%> WHERE (SELECT COUNT(*) FROM nl_subscriber WHERE nl_group_id = nl_group.id AND (`status`=1 OR `status`=3))>0 GROUP BY id\, group_name,templates/<%:modul%>/groups_list%>
	<%parse_sql_to_html: SELECT `subscriber`.`language` AS `lang` FROM `nl_subscriber` AS `subscriber` GROUP BY `lang`,templates/<%:modul%>/languages_list%>
	</td>



	<td class="error">&nbsp;&nbsp;</td>
</tr>
</form>
