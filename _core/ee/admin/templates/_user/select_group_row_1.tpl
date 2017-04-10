<%row%
	<%iif:
		:user_groups_sel,,
		<%iif:
			:check_user,0,
			<option value="<%:id%>"><%:group_name%></option>,
			<%iif::op,3,<option value="<%:id%>"><%:group_name%></option>%>
		%>,
		<%iif:
			<%tpl_in_array:<%:id%>,user_groups_sel%>,1,
			<option value="<%:id%>"><%:group_name%></option>,
		%>
	%>
%row%>