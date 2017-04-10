<html>
<head>
	<title>Website page metatag edit</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
	<script type="text/javascript">	        
		/*function checkIputSymbol(el) {
			var str = el.value.replace(/(^\s+)|(\s+$)/g, "");
			var reg = /[a-z]+/gi;
			var result=reg.test(str);
			if(!result && 
			   el.value != '' && 
			   '<%getError:meta_tag_name_new%>' != ''
			) {
				el.value = str.replace(/[^a-z]/gi, "");
				document.getElementById('tag_name').style.display = 'block';
			} else {
				document.getElementById('tag_name').style.display = 'none';	
			}
		}*/
	</script>	
</head>

<body>
<div id="seo" style="margin: 2px 10px;">
	<div style="height:31px" class="header"><%:pageTitle%></div>
	<form
		action=""
		name="form1"
		method="POST">
	<input type="hidden" name="refresh" value="yes" />
	<input type="hidden" name="meta_tag_name" value="<%:meta_tag_name%>" />
	<span class="error"><%getError:meta_tag_name_new%></span>
	<span id="tag_name" class="error" style="display: none;"><b>Incorrect name format of meta tag. You can use "a-z" symbols only.</b></span>
	<br />
	Tag name:<br>
	<input <%iif:<%tpl_in_array::meta_tag_name,ar_meta_default%>,1,readonly%> 
		style="width:300px" type="text" name="meta_tag_name_new" value="<%iif::meta_tag_name_new,,:meta_tag_name,:meta_tag_name_new%>">
	<%print_language_bar%>

	<%iif:<%tpl_in_array::meta_tag_name,seo_unsortable_fields_list%>,,
	<br />
	<br />
	Display order on grid:&nbsp;
	<input style="width:50px" type="text" name="meta_tag_order_number" value="<%:metatag_order_number%>">%>
	<br />
	<br />

	<a onclick="window.parent.closePopup(); return false;"><%include:buttons/btn_cancel%></a>&nbsp;
	<%include:buttons/btn_save%>&nbsp;
</form>

</div>
</body>

</html>