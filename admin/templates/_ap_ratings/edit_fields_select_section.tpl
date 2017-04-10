<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>">
	<option value="0" <%iif:<%:<%:field_name%>%>,,selected%> <%iif:<%:<%:field_name%>%>,0,selected%>>Auto</option>
	<option value="1" <%iif:<%:<%:field_name%>%>,1,selected%>>News</option>
	<option value="2" <%iif:<%:<%:field_name%>%>,2,selected%>>Sports</option>
</select>
<%include:hidden_input_instead_of_disabled_select%>