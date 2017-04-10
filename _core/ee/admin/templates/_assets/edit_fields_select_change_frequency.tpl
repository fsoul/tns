<select <%iif::readonly,,,disabled%> name="<%:field_name%>">
	<option value="">Please select</option>
	<option value="always" <%iif:<%:<%:field_name%>%>,always,selected%>>always</option>
	<option value="hourly" <%iif:<%:<%:field_name%>%>,hourly,selected%>>hourly</option>
	<option value="daily" <%iif:<%:<%:field_name%>%>,daily,selected%>>daily</option>
	<option value="weekly" <%iif:<%:<%:field_name%>%>,weekly,selected%>>weekly</option>
	<option value="monthly" <%iif:<%:<%:field_name%>%>,monthly,selected%>>monthly</option>
	<option value="yearly" <%iif:<%:<%:field_name%>%>,yearly,selected%>>yearly</option>
	<option value="never" <%iif:<%:<%:field_name%>%>,never,selected%>>never</option>
</select>
<%include:hidden_input_instead_of_disabled_select%>
