<%row%
<tr <%tr_bgcolor%>>

		<%:row_fields%>
	<td>&nbsp;</td>
	<td align="center" height="25" class="table_data" nowrap="1">
		<%include:<%:modul%>/list_row_edit_popup_btn%>
	</td>
	<td align="center">
		<%include:<%:modul%>/list_row_del_btn%>
	</td>
	<td>
		<%include:<%iif::modul,_seo,,_error_page,,_object_seo,,list_row_sel_del%>%>		
	</td>
</tr>

%row%>
<!--
<%row_empty%
<tr><td align="center" colspan="20" height="30"><%words:<%cons:No_records_found%>%></td></tr>
%row_empty%>
-->
