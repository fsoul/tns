<select name="filter_<%:field_name%>" style="width:40px;">
	<option value="%">All
	<option value="Yes" <%iif:<%strtolower:<%:filter_<%:field_name%>%>%>,yes,selected%>>Draft</option>
	<option value="No" <%iif:<%strtolower:<%:filter_<%:field_name%>%>%>,no,selected%>>Published</option>
</select>
