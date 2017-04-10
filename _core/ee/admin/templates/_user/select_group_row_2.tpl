<%row%
	<%iif:
		:available_groups_sel,,
	        <%iif:
			:check_user,1,
			<option value="<%:id%>"><%:group_name%></option>,
			<%iif::op,3,,%>
		%>,
		<%iif:<%tpl_in_array:<%:id%>,available_groups_sel%>,1,
			<option value="<%:id%>"><%:group_name%></option>,
		%>
	%>
%row%>