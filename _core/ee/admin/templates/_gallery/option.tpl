<%row% 
<option value="<%:option_value%>" 
	<%iif:<%:option_value%>,<%:option_value_test%>,selected%>><%convert_unixtimelabel_to_objecttime:<%:option_text%>,d-m-Y%>
</option> 
%row%>
