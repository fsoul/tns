<%row%
<tr <%tr_bgcolor%>>

		<%:row_fields%>
	<td>&nbsp;</td>
	<td align="center" height="25" class="table_data" nowrap="1">
		<%try_include:<%:modul%>/modul_cache_buttons_for_all_lng%>            
		<%try_include:<%:modul%>/modul_buttons%>
		<%try_include:<%:modul%>/preview_btn%>
		<%try_include:<%:modul%>/folder_access_btn%>
		<%include:<%iif::modul,_tpl_file,list_row_tpl_preview%>%>
		<%include:<%iif::modul,_tpl_folder,<%:modul%>/,%><%iif::modul,browser,,list_row_edit<%iif::modul,_news_letters,,_popup%>_btn%>%>
		<%try_include:<%:modul%>/moduls_list_btn%>
	</td>
	<td align="center">
		<%include:<%iif:<%:items_count%>,0,<%:modul%>/list_row_del_btn,list_row_del_btn_disabled%>%>
	</td>
	<td>
		<%include:<%iif:<%:items_count%>,0,list_row_sel_del,list_row_sel_del_disabled%>%>
	</td>
</tr>

%row%>
<!--
<%row_empty%
<tr><td align="center" colspan="20" height="30"><%words:<%cons:No_records_found%>%></td></tr>
%row_empty%>
-->
