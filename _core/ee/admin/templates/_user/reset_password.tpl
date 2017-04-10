<%include:login_page_header%>
        <tr bgcolor="#F0F0F0"> 
            <td class="table_data">Login:</td>
            <td><input type="text" name="login" size="18"></td>
        </tr>
        <tr bgcolor="#F0F0F0"> 
            <td class="table_data">E-mail:</td>
            <td><input type="text" name="email" size="18"></td>
        </tr>
        <tr bgcolor="#F0F0F0"> 
            <td colspan="2" align="left"> 
		<input type="hidden" name="op" value="reset_password">
                <input type="submit" name="submit" value="Reset password" class="button">
                <input type="reset" name="Cancel" value="Cancel" class="button" onclick="location.replace('index.php')">
            </td>
        </tr>
<%include_if:error,,,<%:modul%>/error%>
<%include:login_page_footer%>