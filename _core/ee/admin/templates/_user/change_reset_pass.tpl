<%include:login_page_header%>
        <tr bgcolor="#F0F0F0"> 
            <td colspan="2" class="table_data" style="font-weight:bold;">Change your password</td>
        </tr>
        <tr bgcolor="#F0F0F0"> 
            <td class="table_data">Current password:</td>
            <td><input type="password" name="current" size="18" autocomplete="off" /></td>
        </tr>
        <tr bgcolor="#F0F0F0"> 
            <td class="table_data">New password:</td>
            <td><input type="password" name="newpass" size="18" autocomplete="off" /></td>
        </tr>
        <tr bgcolor="#F0F0F0"> 
            <td class="table_data">Confirm&nbsp;new&nbsp;password:</td>
            <td><input type="password" name="confnewpass" size="18" autocomplete="off" /></td>
        </tr>
        <tr bgcolor="#F0F0F0"> 
            <td colspan="2" align="left"> 
		<input type="hidden" value="change_reset_pass" name="op">
		<input type="hidden" value="<%:user%>" name="user">
                <input type="submit" name="submit" value="Change" class="button">
                <input type="submit" name="cancel" value="Cancel" class="button">
            </td>
        </tr>
<%include_if:error,,<%iif::new_conditions,yes,<%:modul%>/new_conditions,<%iif::login_expired,yes,<%:modul%>/login_expired,<%:modul%>/ch_mes%>%>,<%:modul%>/error%>
<%include:login_page_footer%>