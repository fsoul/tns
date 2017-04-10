<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>">

	<option value="second" <%iif:<%:<%:field_name%>%>,second,selected%>>second</option>
	<option value="minute" <%iif:<%:<%:field_name%>%>,minute,selected%>>minute</option>
	<option value="quarter" <%iif:<%:<%:field_name%>%>,quarter,selected%>>quarter</option>
	<option value="hour" <%iif:<%:<%:field_name%>%>,hour,selected%>>hour</option>
	<option value="day" <%iif:<%:<%:field_name%>%>,day,selected%>>day</option>

</select>
<%include:hidden_input_instead_of_disabled_select%>
