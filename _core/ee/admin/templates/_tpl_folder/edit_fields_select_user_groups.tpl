<br />
<table>
	<tr>
		<td valign="top">
			<center>User Groups who has an access</center>
			<select id="access_groups" name="access_groups[]" multiple <%iif::op,3,disabled%> <%iif::edit,,,<%iif:<%getField:SELECT group_access FROM tpl_pages WHERE id="<%:edit%>" AND tpl_id IS NULL%>,1,disabled,%>%>>
			<%parse_sql_to_html:
				SELECT user_groups.id\, user_groups.group_name
				<%iif::edit,,,\\, IF(folder_group.folder_id\\,1\\,0) AS check_user%>
				<%iif::edit,,,\\, (SELECT group_access FROM tpl_pages WHERE id=<%:edit%> AND tpl_id IS NULL) AS group_access%>
				FROM user_groups
				<%iif::edit,,,LEFT JOIN (SELECT * FROM folder_group WHERE folder_id=<%:edit%>) AS folder_group
				ON user_groups.id = folder_group.group_id GROUP BY user_groups.group_name%>,templates/<%:modul%>/select_group_row_2%>
			</select>
		</td>
		<td  valign="middle" align="center">
			<input type="button" value=">>" onclick="i_move('access_groups', 'no_access_groups')" /><br /><br />
			<input type="button" value=">" onclick="i_move_select('access_groups', 'no_access_groups')" /><br /><br />
			<input type="button" value="<" onclick="i_move_select('no_access_groups', 'access_groups')" /><br /><br />
			<input type="button" value="<<" onclick="i_move('no_access_groups', 'access_groups')" />
		</td>
		<td  valign="top">
			<center>User Groups who has no acccess</center>
			<select id="no_access_groups" name="no_access_groups[]" multiple <%iif::op,3,disabled%> <%iif::edit,,,<%iif:<%getField:SELECT group_access FROM tpl_pages WHERE id="<%:edit%>" AND tpl_id IS NULL%>,1,disabled,%>%>>
			<%parse_sql_to_html:
				SELECT user_groups.id\, user_groups.group_name
				<%iif::edit,,,\\, IF(folder_group.folder_id\\,1\\,0) AS check_user%>
				<%iif::edit,,,\\, (SELECT group_access FROM tpl_pages WHERE id=<%:edit%> AND tpl_id IS NULL) AS group_access%>
				FROM user_groups
				<%iif::edit,,,LEFT JOIN (SELECT * FROM folder_group WHERE folder_id=<%:edit%>) AS folder_group
				ON user_groups.id = folder_group.group_id GROUP BY user_groups.group_name%>,templates/<%:modul%>/select_group_row_1%>
			</select>
		</td>
	</tr>
</table>