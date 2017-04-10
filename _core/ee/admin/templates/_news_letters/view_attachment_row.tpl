<%row%
<br /><b><%:row_num%>:</b>&nbsp;&nbsp;<%:file_name%> (size - <%size_hum_read:<%:length%>%>)&nbsp;<a href="<%:modul%>.php?op=preview_attachment&at_id=<%:id%>"><img style="vertical-align:top;" src="<%:EE_HTTP%>img/doc.gif" border="0"></a>
<%include_if:email_status,draft,<%:modul%>/del_button%>
<br />
%row%>
