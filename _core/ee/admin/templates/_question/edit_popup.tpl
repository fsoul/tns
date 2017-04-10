<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
    <!--- link rel="stylesheet" href="<%:EE_HTTP%>css/main.css" type="text/css" --->
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js%>

<script type="text/javascript">
function openEditor(f_name, t) {
	x=800;
	y=670;
	URL="<%:EE_ADMIN_URL%>cms.php?cms_name="+f_name+"&t="+t+"&lang=<%:language%>";
	window.parent.openPopup2(URL,x,y);
}
</script>

<script type="text/javascript">
function openEditorObject(r_id, id) {
	x=800;
	y=670;
	URL="<%:EE_ADMIN_URL%>cms_object.php?record_id="+r_id+"&id="+id+"&lang=<%:language%>";
	window.parent.openPopup2(URL,x,y);
}
</script>

<script src="<%:EE_HTTP%>js/calendar.js"></script>
</head>

<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr bgcolor="#ededfd"><td>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">

<input type="hidden" name="refresh" value="true">

<tr <%tr_bgcolor%> >
	<td><img src="<%:EE_HTTP%>img/inv.gif" width="200" height="1" alt=""/></td>
	<td><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1" alt=""/></td>
	<td width="100%"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1" alt=""/></td>
</tr>

<%print_fields:%>

<tr>
<!--answers---------------------------------------------------------------------------------------------------------->
	<td colspan="2" style="padding:10px;"><b>Answers:</b>
		<div id="dynamic_answers_list">
		<%get_answers_edition:<%:record_id%>%>
		</div>
		<span style="cursor:pointer; font-weight:bold;" onclick="add_one_more_answer();">[+]</span>	
		                                             	
		<script type="text/javascript">

			var $lang_arr = <%get_js_lang_arr:%>;

			var $last_answer=<%iif:<%:current_answer_number%>,,0,<%:current_answer_number%>%>;

			function add_answer_item($last_answer)
			{	
				var main_div = document.getElementById('dynamic_answers_list');
				//var answer_text_block='';

				//answer_text_block += "<div style=\"margin:5px; background-color:#E2E2FD;\" id=\"answer_div_id_"+$last_answer+"\">Answer: <br />";
				
				var answer_text_block = document.createElement('div');
				answer_text_block.setAttribute('id', 'answer_div_id_'+$last_answer);
				answer_text_block.style.margin = '5px';
				answer_text_block.style.backgroundColor = 'E2E2FD';
				var answer_text_text = document.createTextNode('Answer: ');
				answer_text_block.appendChild(answer_text_text);
				answer_text_block.appendChild(document.createElement('br'));
				
				for(var i=0; i<$lang_arr.length; i++)
				{
					//answer_text_block += $lang_arr[i]+" <input type=\"text\" name=\"answer_text_"+$lang_arr[i]+"[]\" value=\"\" /><br />";
					answer_text_block.appendChild(document.createTextNode($lang_arr[i]+' '));
					var answer_field = document.createElement('input');
					answer_field.setAttribute('type', 'text');
					answer_field.setAttribute('name', 'answer_text_'+$lang_arr[i]+'[]');
					answer_text_block.appendChild(answer_field);
					answer_text_block.appendChild(document.createElement('br'));
				}             

				//answer_text_block += "<span style=\"cursor:pointer; font-weight:bold;\" onclick=\"document.getElementById('answer_div_id_"+$last_answer+"').innerHTML=''; document.getElementById('answer_div_id_"+$last_answer+"').outerHTML='';\">[-]</span></div>";
				var delete_answer = document.createElement('span');
				delete_answer.style.cursor = 'pointer';
				delete_answer.style.fontWeight = 'bold';
				delete_answer.onclick = function() {
					main_div.removeChild(document.getElementById('answer_div_id_'+$last_answer));
				}
				delete_answer.appendChild(document.createTextNode('[-]'));
				answer_text_block.appendChild(delete_answer);
				
				//main_div.innerHTML = main_div.innerHTML + answer_text_block;
				main_div.appendChild(answer_text_block);
			}

			function add_one_more_answer()
			{	
				$last_answer++;
				add_answer_item($last_answer);
			}
		</script>
	</td>
<!------------------------------------------------------------------------------------------------------------------->
</tr>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
		<%include_if:modul,_mail_inbox,,buttons/btn_save%>&nbsp;
		<%include_if:op,3,<%:modul%>/btn_save_add_more%>&nbsp;
	</td>
</tr>

<tr>
	<td height="30" class="error" colspan="2">&nbsp;&nbsp;* - <%cons:Mandatory_Fields%></td>
	<td class="error">&nbsp;</td>

</tr>

</table>
</td>
</tr>
</table>
</form>
</body>
</html>