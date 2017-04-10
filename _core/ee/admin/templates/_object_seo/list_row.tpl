<%row%
<tr <%tr_bgcolor%>>

<%:row_fields%>

	<%iif:<%:op%>,export_excel,,
		<%tpl_escape_coma:
			<td>&nbsp;</td>
			<td align="center" height="25" class="table_data">
				<%include:<%:modul%>/list_row_object_link%>
				<%include:<%:modul%>/list_row_object_edit%>
				<%include:<%:modul%>/list_row_meta_preview%>
			</td>
		%>

	%>
</tr>
%row%>
<!--
<%row_empty%
<tr><td align="center" colspan="20" height="30"><%words:<%cons:No_records_found%>%></td></tr>
%row_empty%>
-->
