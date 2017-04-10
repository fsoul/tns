<%row%
	<%iif:
		:no_access_groups,,
		<%iif::group_access,1,
			,
			<%iif:
				:check_user,0,
				<option value="<%:id%>"><%:group_name%></option>,
			%>
		%>
		<%iif:
			<%tpl_in_array:<%:id%>,user_groups_sel%>,1,
			<option value="<%:id%>"><%:group_name%></option>,
		%>
	%>
%row%>