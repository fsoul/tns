<html>
<head>
	<title>Website pages metatags export</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>

<body>
<div id="seo" style="margin: 2px 10px;">
<div style="height:31px" class="header">Metatags export</div>
<form
method="POST"
enctype="multipart/form-data" 
action="<%:EE_ADMIN_URL%><%:modul%>.php?op=export_to_csv"
name="form1"
>

<input type="hidden" name="refresh" value="yes">

<br>Select character encoding to export:<br>
<span style="color:red;">(Warning: characters, not supported in chosen encoding(language) will be stripped off the export list)</span><br>
<select name="export_lang">
<%parse_sql_to_html:SELECT CONCAT(l_encode\,\'(\'\,language_name\,\')\') as option_text\, language_code as option_value FROM v_language,templates/option%>
</select><br><br><br>

<input onclick="window.parent.closePopup('<%iif:<%getError:csv_file%>,,no,yes%>'); return false;" style="cursor: hand" type="button" accessKey="<%CONSTANT:BUT_ACCESS_KEY_BACK%>" value="<%CONSTANT:BUT_LABEL_BACK%>" name="back" class="button">&nbsp;
<%include:buttons/btn_export_meta%><br><br>

</form>

</div>
</body>

</html>