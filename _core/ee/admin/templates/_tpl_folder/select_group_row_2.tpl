<%row%
	<%iif:
		:access_groups,,
		<%iif::group_access,1,
			<option value="<%:id%>"><%:group_name%></option>,
	        	<%iif:
				:check_user,1,
				<option value="<%:id%>"><%:group_name%><%:group_access%></option>,
				<%iif::op,3,<option value="<%:id%>"><%:group_name%></option>,%>
			%>
		%>,
		<%iif:<%tpl_in_array:<%:id%>,available_groups_sel%>,1,
			<option value="<%:id%>"><%:group_name%></option>,
		%>
	%>
%row%>