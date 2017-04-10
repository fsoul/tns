<%row%
    <tr bgcolor="#ededfd">
        <td valign="top" width="10%" height="20" class="table_data" style="padding-left: 10px;">
		<br><b><a href="<%:EE_ADMIN_PATH%><%:modul_name%>.php"><%:modul_name%></a></b><br>&nbsp;
	</td>
        <td valign="top" width="10%">
		<br><span style="color: #<%iif:<%:modul_check_result%>,1,0a0,f00%>; font-weight:bold;"><%iif:<%:modul_check_result%>,1,PASS,FAIL%>ED</span>
	</td>
        <td valign="top" width="70%">
		<%:modul_check_message%>
        </td>
        <td valign="top" width="10%">&nbsp;
		<%:modul_check_result_action%>
        </td>
    </tr>
%row%>
