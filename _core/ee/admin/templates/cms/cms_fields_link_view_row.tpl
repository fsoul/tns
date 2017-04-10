<%row%

<div class="cms_link_block" style="clear:left;">
	<div class="cms_link_block">
	<div class="cms_link_label"><b><%:view_name%></b> URL:</div>
	<select name="link_type_<%:view_name%>" id="link_type_<%:view_name%>" onchange="set_active_link_chooser_mode(this.value, '_<%:view_name%>')">
		<option value="sat_page">Satellite page</option>
		<option value="static_link">Custom URL</option>
	</select>
	</div>
	<div class="cms_link_block" id="static_link_value_id_<%:view_name%>" style="display:none;"><input type="text" name="url_link_<%:view_name%>" value="<%getValueOf:link_<%:view_name%>%>" style="width:400px;"></div>
	<div class="cms_link_block" id="sat_page_value_id_<%:view_name%>" style="display:none;"><%get_satelite_list:400,<%:satelit_link_<%:view_name%>%>,_<%:view_name%>%></div>
</div>

<script type="text/javascript">
<!--
t_view_v_array.push(["<%:view_name%>", "<%iif::type_<%:view_name%>,,sat_page,<%:type_<%:view_name%>%>%>"]);
//-->
</script>

%row%>