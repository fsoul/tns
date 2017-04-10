<input 
	style="margin:10px;"
	type="text"
	name="<%:cms_field_instance_name%>[]"
	size="50"
	value="<%htmlentities:<%:<%:cms_field_instance_name%>%>,:ENT_COMPAT,UTF-8%>"
	<%iif:<%:cms_field_instance_name%>,cms_val_for_default_language,disabled%>
/>