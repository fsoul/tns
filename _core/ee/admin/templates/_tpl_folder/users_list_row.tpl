<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Access Edit</title>
    	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
	<!--<script src="<%:EE_HTTP%>js/calendar.js"></script>-->
	<script type="text/javascript" src="<%:EE_HTTP%>js/xml_http_request.js"></script>

	<script type="text/javascript">

var editableId = null;
var tempRow;
var xmlHttp = createXmlHttpRequestObject();
var content_access = new Array();
var tpl_folder_url = '';

content_access[1] = 'Read only';
content_access[2] = 'Edit';
content_access[3] = 'Publish';
content_access[4] = 'Full';

function editId(id, editMode, cancel)
{
	var row = document.getElementById(id).cells;
	if(editMode)
	{
		if(editableId) editId(editableId, false, false);
		save(id);
		row[2].innerHTML = '<select id="folder_access_mode">' + print_option(row[2].innerHTML) + '</select>';
		row[3].innerHTML = '<a href="#" ' + 'onclick="updateRow(\'' + id + '\')"><img src="<%:EE_HTTP%>img/editBt.gif" border="0" title="Update" /></a>&nbsp;&nbsp;<a href="#" onclick="editId(\'' + id + '\',false, true); return false;"><img src="<%:EE_HTTP%>img/undo.gif" border="0" title="Cancel" /></a>';
		editableId = id;
	}
	else
	{       if(cancel)
		{
			row[2].innerHTML = tempRow[2];
		}
		else
		{
			ca = document.getElementById('folder_access_mode').value;
			row[2].innerHTML = content_access[ca];
		}             
		row[3].innerHTML = '<a href="#" onclick="editId(\'' + id + '\',true, false)"><img src="<%:EE_HTTP%>img/usr_folder_edit.gif" border="0" title="Edit" /></a>';

		editableId = null;
	}
}

function save(id)
{
	var tr = document.getElementById(id).cells;
	tempRow = new Array(tr.length);	
	for(var i=0; i<tr.length; i++)
		tempRow[i] = tr[i].innerHTML;
}

function undo(id)
{
	var tr = document.getElementById(id).cells;
	for(var i=0; i<tempRow.length; i++)
		tr[i].innerHTML = tempRow[i];
		editableId = null;
}

function print_option(val)
{
	var s = '';

	for(var i = 1; i < content_access.length; i++)
	{
		if(val == content_access[i])
		{
			s += '<option value=' + i + ' selected>' + content_access[i] + '</option>';
		}
		else
		{
			s += '<option value=' + i + '>' + content_access[i] + '</option>';
		}
	}
	return s;
}

function updateRow(user_id)
{
	user_id = user_id.replace('user_folder_access_mode_','');
	if (xmlHttp && (xmlHttp.readyState == 4 || xmlHttp.readyState == 0))
	{
		var query = tpl_folder_url + "<%:EE_ADMIN_URL%>_tpl_folder.php?op=update_row&user_id=" + user_id + "&folder_id=<%:folder_id%>&folder_access_mode=" + document.getElementById('folder_access_mode').value;
		xmlHttp.open("GET", query, true);
		xmlHttp.onreadystatechange = handleUpdatingRow;
		xmlHttp.send(null);
	}
}

function handleUpdatingRow()
{
	if(xmlHttp.readyState == 4)
	{
		if(xmlHttp.status == 200)
		{
			response = xmlHttp.responseText;
			if (response.indexOf("ERRNO") >= 0
				|| response.indexOf("error") >= 0
				|| response.length == 0)
				alert(response.length == 0 ? "Server serror." : response);
			else
				editId(editableId, false, false);
				//alert(response);

		}
		else
		{
			undo(editableId);
			alert("Error on server side.");
		}
	}
}

</script>

</head>

<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" border=0 cellpadding="0" cellspacing="0">
	<tr>
		<td id="admin_popup_header"><div style="float:right;"><a style="text-decoration:none; color:#fff;" href="javascript:window.parent.closePopup();">X</a></div><%getValueOf:pageTitle%></td>
	</tr>
</table>
<br>
<table width="500" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr><th align="left">&nbsp;&nbsp;&nbsp;List of users that have access to folder: <span class="error"><%:folder_id%></span></th></tr>
</table>
<br>
<table width="500" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr>

<form id="user_folder_access_mode_form">
<table width="500" border="0">
<tr>
	<th>User login:</th>
	<th>Default access:</th>
	<th width="150">Access:</th>
	<th>Action:</th>
</tr>
<%row%
<tr id="user_folder_access_mode_<%:user_id%>" align="center" height="22">
	<td><%:login%></td>
	<td><%:default_access%></td>
	<td><%iif:<%:access%>,,<%:default_access%>,<%:access%>%></td>
	<td><a href="#" onclick="editId('user_folder_access_mode_<%:user_id%>', true, false); return false;"><img src="<%:EE_HTTP%>img/usr_folder_edit.gif" border="0" title="Edit" /></a></td>
</tr>
%row%>
</table>


</tr>
</table>
<br>
<table>
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="moduls_list_save">
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="30">&nbsp;&nbsp;
		<%include:buttons/btn_close_popup%>&nbsp;
	</td>
</tr>
</form>
</table>
</body>
</html>
