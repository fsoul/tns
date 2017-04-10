<style type="text/css">
	.cms_link_label {padding:0 5px; float:left; width:150px; clear:left; text-align:right;}
	.cms_link_block {padding:3px; float:left;}
</style>

<script type="text/javascript">
<!--
function select_selected_item(selector_id, item_value) {
	if(item_value == '') return;
	var selector = document.getElementById(selector_id);
	for(i=0;i<selector.options.length;i++) {
		if (selector.options[i].value==item_value) {
			selector.options[i].selected=true;
		}
	}
}

function set_active_link_chooser_mode(type, sufix) {
	if(!sufix) {
		sufix = "";
	}
	document.getElementById("static_link_value_id"+sufix).style.display=(type=="static_link"?"block":"none");	
	document.getElementById("sat_page_value_id"+sufix).style.display=(type=="sat_page"?"block":"none");	
	select_selected_item("link_type"+sufix, type);
}

function show_needed_sel_URL_block(is_diff_urls_per_view) {
	document.getElementById("link_type").style.display=(is_diff_urls_per_view ? "none" : "inline");
	document.getElementById("different_view_links_block").style.display=(is_diff_urls_per_view ? "block":"none");
	document.getElementById("diff_urls_per_t_view").checked=(is_diff_urls_per_view ? true:false);
	document.getElementById("same_view_links_block_values").style.display=(is_diff_urls_per_view ? "none":"block");
}

var t_view_v_array = new Array();
//-->
</script>

<div class="cms_link_block" id="same_view_links_block" style="clear:left;">
	<div class="cms_link_block">
	<div class="cms_link_label">URL:</div>
	<select name="link_type" id="link_type" onchange="set_active_link_chooser_mode(this.value)">
		<option value="sat_page">Satellite page</option>
		<option value="static_link">Custom URL</option>
	</select>
	</div>
	<div id="same_view_links_block_values" style="float:left; display:block;">
		<div class="cms_link_block" id="static_link_value_id" style="display:none;"><input type="text" name="url_link" value="<%getValueOf:url_link%>" style="width:400px;"></div>
		<div class="cms_link_block" id="sat_page_value_id" style="display:none;"><%get_satelite_list:400,<%:satelit_link%>%></div>
	</div>
</div>

<div class="cms_link_block" style="clear:left;">
<input type="checkbox" name="diff_urls_per_t_view" id="diff_urls_per_t_view" value="1" onchange="show_needed_sel_URL_block(this.checked)" /> Different URLs for diffent template-view-versions
</div>

<div class="cms_link_block" id="different_view_links_block" style="clear:left;">
	<!--%generate_view_version_url_fields%-->
</div>

<script type="text/javascript">
<!--
onload = function () {
	set_active_link_chooser_mode("<%iif::link_type,,sat_page,<%:link_type%>%>");
	show_needed_sel_URL_block(<%iif::diff_urls_per_t_view,1,true,false%>);
	for(var i=0; i<t_view_v_array.length; i++) {
		set_active_link_chooser_mode(t_view_v_array[i][1], "_"+t_view_v_array[i][0]);
	}
}

//-->
</script>
