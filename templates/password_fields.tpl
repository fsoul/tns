
  <tr> 
    <td width="170" align="right"><%e_cms_cons:Password%></td>
    <td>&nbsp;</td>
    <td width="175px">
<%text_edit_cms:password_rules_error%>
      <input
        type="password"
        class="inputTxt"
        name="password"
        <%iif:<%getError:password%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms:password_rules_error%>"
      />
    </td>
    <td>&nbsp;</td>
    <td width="150px">&nbsp;</td>
  </tr>

  <tr> 
    <td align="right"><%e_cms_cons:Password confirm%></td>
    <td>&nbsp;</td>
    <td width="175px">
<%text_edit_cms:password_rules_error%>
      <input
        type="password"
        class="inputTxt"
        name="password_confirm"
        <%iif:<%getError:password_confirm%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms:password_rules_error%>"
      />
    </td>
    <td>&nbsp;</td>
    <td width="150px">&nbsp;</td>
  </tr>
