<html>
<head>
	<title>Subscribers import</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>

<body>
<div style="margin: 2px 10px;">
<form
method="POST"
enctype="multipart/form-data" 
action="<%:EE_ADMIN_URL%><%:modul%>.php?op=import_from_csv"
name="form1"
onSubmit="
	if (this.csv_file.value.substr(this.csv_file.value.length-3).toLowerCase() != 'csv')
	{
		alert ('Please, select .csv-file...');
		return false;
	}
"
>

<input type="hidden" name="refresh" value="yes">

<br>Select group to import subscribers into:<br><br>
<%include:<%:modul%>/edit_fields_select_group%><br><br>

<br>Select .csv-file for import:<br><br>
<input type="file" name="csv_file"><br><br><br>

<input onclick="window.parent.closePopup('<%iif:<%getError:csv_file%>,,no,yes%>'); return false;" style="cursor: hand" type="button" accessKey="<%CONSTANT:BUT_ACCESS_KEY_BACK%>" value="<%CONSTANT:BUT_LABEL_BACK%>" name="back" class="button">&nbsp;
<%include:buttons/btn_import%><br><br>

</form>

<div class="error"><%getError:csv_file%></div>
</div>
</body>

</html>