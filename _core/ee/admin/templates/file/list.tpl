<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%:pageTitle%></title>
<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<script src="<%getValueOf:EE_HTTP%>js/multifile.js"></script>
<script language="JavaScript"  type="text/javascript">
function check() {
	frm=document.fi;
	if(multi_selector.count == 1) alert("Please, select file for upload");
	else frm.submit();
}
</script>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<%print_admin_js:0%>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0">
<div id="whole_page_content">
<center>
<form name="fi" action="file.php" method="post" enctype="multipart/form-data">
<input type="hidden" name="f_name" value="<%getValueOf:f_name%>">
<input type="hidden" name="op" value="<%getValueOf:op%>">
<input type="hidden" name="save" value="true">
<input type="hidden" name="admin_template" value="<%getValueOf:admin_template%>">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr>
		<td bgcolor="#092869" colspan="2"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr bgcolor="#EFEFDE">
		<td class="CmsMainText" height="30">&nbsp;&nbsp;<b>Select file</b> (max size <%ini_get:post_max_size%>)</td>
		<td>	<input id="my_file_element" type="file" name="file_0" ></td>


	</tr>
	<tr>
		<td bgcolor="#EFEFDE" colspan="2"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr bgcolor="#EFEFDE"><td colspan="2">
	<!-- This is where the output will appear -->
	<div id="ee_files_list"></div>
	<script>
		<!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
		var multi_selector = new MultiSelector( document.getElementById( 'ee_files_list' ) );
		<!-- Pass in the file element -->
		multi_selector.addElement( document.getElementById( 'my_file_element' ) );
	</script>
	</td></tr>
<%getValueOf:error%>
</table><br><input type="button" value="Save" name="save" class="button" onclick="check()">&nbsp;&nbsp;<input type="button" value="Cancel" class="button" onclick="window.parent.closePopup()">
</form></center><br/>
</div>
<script type="text/javascript">set_sizes_by_content();</script>
</body>
</html>
