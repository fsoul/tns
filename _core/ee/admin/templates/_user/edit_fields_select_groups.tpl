<table>
	<tr>
		<td valign="top">
			<center>All available groups</center>
			<select id="user_groups_sel" name="user_groups_sel[]" multiple>
			<%parse_sql_to_html:
				SELECT user_groups.id\, user_groups.group_name
				<%iif::edit,,,\\, IF(user_group.user_id\\,1\\,0) AS check_user%>
				FROM user_groups
				<%iif::edit,,,LEFT JOIN (SELECT * FROM user_group WHERE user_id=<%:edit%>) AS user_group
				ON user_groups.id = user_group.group_id GROUP BY user_groups.group_name%>,templates/<%:modul%>/select_group_row_1%>
			</select>
		</td>
		<td  valign="middle" align="center">
			<input type="button" value=">>" onclick="i_move('user_groups_sel', 'available_groups_sel')" /><br /><br />
			<input type="button" value=">" onclick="i_move_select('user_groups_sel', 'available_groups_sel')" /><br /><br />
			<input type="button" value="<" onclick="i_move_select('available_groups_sel', 'user_groups_sel')" /><br /><br />
			<input type="button" value="<<" onclick="i_move('available_groups_sel', 'user_groups_sel')" />
		</td>
		<td  valign="top">
			<center>User groups</center>
			<select id="available_groups_sel" name="available_groups_sel[]" multiple>
			<%parse_sql_to_html:
				SELECT user_groups.id\, user_groups.group_name
				<%iif::edit,,,\\, IF(user_group.user_id\\,1\\,0) AS check_user%>
				FROM user_groups
				<%iif::edit,,,LEFT JOIN (SELECT * FROM user_group WHERE user_id=<%:edit%>) AS user_group
				ON user_groups.id = user_group.group_id GROUP BY user_groups.group_name%>,templates/<%:modul%>/select_group_row_2%>
			</select>
		</td>
	</tr>
</table>