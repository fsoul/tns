<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%getValueOf:pageTitle%></title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js:0%>
<script type="text/javascript">
function add_row()
{
	cur_row = document.getElementById('row_'+cur_num);
	if (cur_row != undefined)
	{
		cur_row.lastChild.innerHTML = '&nbsp;&nbsp;<input type="button" value="Delete" onClick="delete_row(' + cur_num + ')"/>';
		cur_row.firstChild.innerHTML = '&nbsp;&nbsp;' + cur_num;
	}

	new_num = cur_num + 1;
	cur_num = new_num;
	new_row = document.createElement( 'tr' );
	new_row.id = 'row_'+new_num;
	new_td = document.createElement( 'td' );
	new_td.innerHTML = '&nbsp;&nbsp;<span style="color:#00cc00; font-size:130%; font-weight:bold">*<'+'/span>';
	new_td.height = 30;
	new_row.appendChild(new_td);
	new_td = document.createElement( 'td' );
	new_td.innerHTML = '&nbsp;&nbsp;<input type="text" name="link_title_'+new_num+'" size="30"/>';
	new_row.appendChild(new_td);
	new_td = document.createElement( 'td' );
	new_td.innerHTML = '<input type="text" name="link_href_'+new_num+'" size="50"/>';
	new_row.appendChild(new_td);
	new_td = document.createElement( 'td' );
	new_td.innerHTML = '&nbsp;&nbsp;<input type="button" value="Add" onClick="add_row()"/>';
	new_row.appendChild(new_td);
	document.getElementById('row_add').parentNode.insertBefore( new_row, document.getElementById('row_add') );
}
function delete_row(num)
{
	row = document.getElementById('row_'+num);
	row.parentNode.removeChild(row);
}
</script>
</head>

<body>
<div id="dhtmltooltip2"></div>
<div id="whole_page_content">
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="<%:op%>">
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr>
	<td><%inv:20,1%></td>
	<td height="30" class="table_data">&nbsp;&nbsp;Link title</td>
	<td>Link URL</td>
</tr>
<tr style="background-color:#000;">
	<td><%inv:20,1%></td>
	<td><%inv:200,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>
<%setValueOf:row_num,0%>
<%row%
<tr id="row_<%:row_num%>">
	<td>&nbsp;&nbsp;<%:row_num%></td>
	<td height="30" class="table_data">&nbsp;&nbsp;<input type="text" name="link_title_<%:row_num%>" size="30"  value="<%:title%>"/></td>
	<td><input type="text" name="link_href_<%:row_num%>" size="50" value="<%:URL%>"/></td>
	<td>&nbsp;&nbsp;<input type="button" value="delete" onClick="delete_row(<%:row_num%>)"/></td>
</tr>
<%setValueOf:last_row_number,<%:row_num%>%>
%row%>
<tr id="row_add">
	<td height="30" class="table_data" colspan="4">&nbsp;&nbsp;
		<%include:buttons/btn_close_popup%>&nbsp;
		<%include:buttons/btn_save%>&nbsp;
	</td>
</tr>
</table>
</form>
<script type="text/javascript">cur_num = <%iif::last_row_number,,0,:last_row_number%>; add_row();</script>
</div>
</body>
</html>