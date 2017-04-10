<div style="text-align:left; padding:10px;">
<input type="hidden" name="type" value="form" />
<div style="padding:5px; float:left; clear:left; width:100px;"><label for="link_type">Form:</label></div>
<div style="padding:5px; float:left">
<select name="<%:cms_field_instance_name%>" style="width:400">
<option value=""></option>
<%get_formbuilder_forms_list:<%:<%:cms_field_instance_name%>%>%>
</select>
</div>