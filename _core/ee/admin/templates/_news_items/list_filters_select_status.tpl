<select name="filter_<%:field_name%>">
	<option value="">All</option>
	<option value="0"<%iif:<%:filter_<%:field_name%>%>,0, selected="selected"%>><%cons:draft%></option>
	<option value="1"<%iif:<%:filter_<%:field_name%>%>,1, selected="selected"%>><%cons:published%></option>
	<option value="2"<%iif:<%:filter_<%:field_name%>%>,2, selected="selected"%>><%cons:archive%></option>
</select>
