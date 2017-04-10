<select name="<%:field_name%>" <%iif::op,1,<%iif:<%check_possibility_turn_on_dm:<%:id%>%>,1,,disabled="disabled"%>%>>
	<option value="0" <%iif:<%:<%:field_name%>%>,0,selected%>><%cons:GRID_DISABLED%>
	<option value="1" <%iif:<%:<%:field_name%>%>,1,selected%>><%cons:GRID_ENABLED%>
</select> <%iif::op,1,<%iif:<%check_possibility_turn_on_dm:<%:id%>%>,1,,<span class="error">one DNS must be without DRAFT MODE.</span>%>%>

