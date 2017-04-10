<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Sitemap Object properties</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js%>

<style>
ul, #objectList
{
	padding: 0px 0px 0px 5px;
}
ul li
{
	list-style-type: none;
	padding-bottom: 2px;
	cursor: pointer;
}

ul li input
{
	margin-bottom: 0px;
}

ul li.selected
{
	background-color: #666666;
	color: #FFF;
}
</style>

<script type="text/javascript">

// show template list of object
function select_obj(el)
{
	var obj_tpl_list_id = 'object_templates_' + el.id.replace(/[^0-9]/g, '');
	var childNodes = el.parentNode.getElementsByTagName('LI');

	for (var i = 0; i < childNodes.length; i++)
	{
		var ch_el 		= childNodes[i];
		var obj_tpls_list_id	= 'object_templates_' + ch_el.id.replace(/[^0-9]/g, '');

		ch_el.className = '';
		document.getElementById(obj_tpls_list_id).style.display = 'none';
	}

	el.className = 'selected';

	document.getElementById(obj_tpl_list_id).style.display 	= 'block';
	document.getElementById(obj_tpl_list_id).style.top 	= el.offsetTop - 12;
}

function select_object_by_tpl(el, obj_id)
{
	var obj_checkbox_id = 'object_checkbox_' + obj_id;

	var stay_checked 	= false;
	var obj_tpl_list_id 	= 'object_templates_' + obj_id;
	var tpl_list 		= document.getElementById(obj_tpl_list_id);

	var li_list = tpl_list.getElementsByTagName('LI');

	for (var i = 0; i < li_list.length; i++)
	{
		var input = li_list[i].childNodes[0];
		if (input.checked)
		{
			stay_checked = true;
			break;
		}
	}

	if (stay_checked)
	{
		document.getElementById(obj_checkbox_id).checked = true;
	}
	else
	{
		document.getElementById(obj_checkbox_id).checked = false;
	}
}

function select_object_tpl(el, obj_id)
{
	
	var obj_tpl_list_id 	= 'object_templates_' + obj_id;
	var tpl_list 		= document.getElementById(obj_tpl_list_id);
	var checked 		= el.checked;

	var li_list = tpl_list.getElementsByTagName('LI');

	for (var i = 0; i < li_list.length; i++)
	{
		var input = li_list[i].childNodes[0];
		input.checked = checked;
	}
}


</script>

</head>

<body>
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">

<form name="fd" method="POST">

	<input type="hidden" name="reload" value="true">
	<br />
	<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
		<tr>
			<td width="300" valign="top" align="left">
				<ul id="objectList">
					<strong>Object list</strong><br />
					Notice: Marked objects will <span style="color: red; font-weight: bold;">not get</span> into the sitemap.
					<%get_object_list:<%:modul%>/object_list_row%>
				</ul>
			</td>
			<td valign="top" align="left">
				<%get_object_list:<%:modul%>/object_tpl_list_row,0%>
			</td>
		</tr>
		<tr bgcolor="#092869"><td colspan="3"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td></tr>
	</table>
	<br />

	&nbsp;&nbsp;<%include:buttons/btn_close_popup%>&nbsp;&nbsp;<%include:buttons/btn_save%>
</form>

</body>
</html>