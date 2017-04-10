<%row%
<tr>
          <td align="center"><input name="q[<%:ar_key%>]" type="text" value="<%:count%>" /></td>
          <td align="center"><a href="#" onclick="document.cart_update['q[<%:ar_key%>]'].value='0'; document.cart_update.submit();"><img src="images/checkout-delete.gif" alt="Delete" width="17" height="17" border="0" /></a></td>
          <td><strong class="blue"><%:name%></strong><br />#<%:ar_key%></td>
          <td align="right"><strong class="red"><%tpl_money::amount%> <%cms_e:cart_carrency_lbl%></strong></td>
		  <td align="right"><strong class="red"><%tpl_money:<%tpl_mult::amount,<%:count%>%>%> <%cms_e:cart_carrency_lbl%></strong></td>          
          <td width="10%"></td>
</tr>
%row%>
<!--
<%row_empty%
<tr><td colspan="4" align="center"><%cms_e:cart_empty%></td></tr>
%row_empty%>
-->
