<script type="text/javascript">
	function check_status(val)
	{
		obj = document.fs.is_default;
		if (val == '0' && obj.checked == false) obj.disabled = true;
			else obj.disabled = false;
	}               
</script>

<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>" onChange="check_status(this.value)">

<%iif:<%check_lang_forwarding:<%:edit%>%>,1,<%iif:<%:op%>,3,<option value="0" <%iif:<%:<%:field_name%>%>,,selected%> <%iif:<%:<%:field_name%>%>,0,selected%>>Disabled%>,
	<option value="0" <%iif:<%:<%:field_name%>%>,,selected%> <%iif:<%:<%:field_name%>%>,0,selected%>>Disabled
%>
	<option value="1" <%iif:<%:<%:field_name%>%>,1,selected%>>Enabled
	<input type="hidden" name="lang_forw" value="<%iif:<%check_lang_forwarding:<%:edit%>%>,,,<%check_lang_forwarding:<%:edit%>%>%>">

</select><%iif:<%:op%>,3,,<%iif:<%check_lang_forwarding:<%:edit%>%>,1,<span class="error"> can't disabled it's used in DNS lang forwarding</span>%>%>
<%include:hidden_input_instead_of_disabled_select%>
