<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>File Manager</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css">
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<%print_admin_js%>
	<script  type="text/javascript">
function check_selected()
{          
	var result;
	var checkboxobject = document.checkbox_form;
	for(i = 0;i < checkboxobject.length; i++)
	{
		if(checkboxobject.elements[i].type == 'checkbox')
		{                         
			if(checkboxobject.elements[i].checked == true)
			{
				result = true;
			}
		}
	}
	if(result == true)
	{                   
		if(confirm('<%:DELETE_SEL_GRID_ITEM_CONFIRM%>'))
		{
			document.checkbox_form.submit();
		}
	}           
	else
	{
		alert('<%:DELETE_SEL_GRID_ITEM_WARNING%>');
	} 
}

function del_file(name) {
	x=450;
	y=150;
	URL="file.php?op=2&folder=<%get:folder%>&f_name="+name;
	if(confirm("Delete file "+name+"?")) window.document.location = URL;
}
function add_file(path) {
	x=550;
	y=150;
	URL="file.php?op=1&f_name="+path;
	openPopup(URL,x,y);
}
function del_folder(name) {
	x=450;
	y=150;
	URL="folder.php?op=2&folder=<%get:folder%>&f_name="+name;
	if(confirm("Delete folder "+name+"?")) window.document.location = URL;
}
function add_folder(path) {
	x=450;
	y=150;
	URL="folder.php?op=1&f_name="+path;
	openPopup(URL,x,y);
}
	</script>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>

<body>
<div id="whole_page_content">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<%:admin_menu%>

<table width="100%" border=0>
    <tr><td class="header" width="300" height="31">Files</td></tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
    <tr bgcolor="#ededfd">
	
    <td>
	<span style="margin-left:18px;"><a href="" style="background:#eee; border:#eee" onClick = "check_selected(); return false;"><img src="<%:EE_HTTP%>img/del_btn.gif" width="24" height="24" alt="<%:DELETE_SEL_GRID_IMAGE_ALT%>" title = "<%:DELETE_SEL_GRID_IMAGE_ALT%>" border="0"></a></span>
			<%iif::folder,,,
				&nbsp;&nbsp;&nbsp;<a href="?t=index">Start Page</a>&nbsp;|&nbsp;Current Folder: <%:folder%>
			%>
    </td>
    <td align="right">
	<%include:<%iif::folder,,<%iif::UserRole,<%:ADMINISTRATOR%>,<%:modul%>/file_admin_button%>,<%:modul%>/file_admin_button%>%>
    </td></tr>
    <tr bgcolor="#092869"><td colspan="2"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1" alt=""/></td></tr>
		<tr><td>
			<table width="650" border="0">
		<form action="#" name="checkbox_form" method = "POST">
			<%file_list%>
			<input type = "hidden" name = "op" value = "delete_selected"/>
        	</form>	
			</table><br>
	 </tr></td>
</table>
</div>
</body>
</html>