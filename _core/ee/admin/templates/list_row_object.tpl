<%row%
<tr <%tr_bgcolor%>>

<%:row_fields%>

	<td>&nbsp;</td>
	<td align="center" height="25" class="table_data">
	<nobr>
	<%try_include:<%:modul%>/preview_btn%>
<!--	<%include:<%iif::modul,_channel,list_row_channel_news_btn%>%> -->
	<%include:<%iif::modul,_tpl_file,list_row_tpl_preview%>%>
	<%include:<%iif::modul,browser,,<%:modul%>/list_row_edit<%iif::modul,_news_letters,,_popup%>_btn%>%>
	<%include:<%iif::modul,browser,,_error_page,,_mail_inbox,,<%:modul%>/list_row_del_btn%>%>
	<%include:<%iif::modul,_seo,,_error_page,,list_row_sel_del%>%>		
	</nobr>
	</td>
</tr>
%row%>

<!--
<%row_empty%
<tr><td align="center" colspan="20" height="30"><%words:<%cons:No_records_found%>%></td></tr>
%row_empty%>
-->
