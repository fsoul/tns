<script type="text/javascript" language="JavaScript">
<!--
prev_type=0
function change_err_page_type(type) {
	prev_obj = document.getElementById('err_page_'+prev_type)
	prev_obj.style.display = 'none'
	prev_obj.name = ''
	prev_obj.disabled = true;
	obj = document.getElementById('err_page_'+type)
	obj.style.display = 'block'
	obj.disabled = false;
	obj.name = 'satelit'
	prev_type=type
}
type = <%iif:<%:<%:field_name%>%>,,0,<%:<%:field_name%>%>%>
-->
</script>
<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>" id="page_type_select" onchange="change_err_page_type(this.value)">
	<option value="0" <%iif:<%:<%:field_name%>%>,,selected%> <%iif:<%:<%:field_name%>%>,0,selected%>>Satelite Page</option>
	<option value="1" <%iif:<%:<%:field_name%>%>,1,selected%>>URL</option>
	<option value="2" <%iif:<%:<%:field_name%>%>,2,selected%>>Text</option>
</select>
<%include:hidden_input_instead_of_disabled_select%>
