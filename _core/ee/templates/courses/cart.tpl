<%a_cart_init%><%include:header%>
        
<form name="cart_update" method="post" action="<%:EE_HTTP%>index.php?t=eshop/cart&language=<%getValueOf:language%><%print_is_admin_link%>">
<input type="hidden" name="t" value="<%:t%>"/>
<input type="hidden" name="t_back" value="<%:t_back%>"/>
<input type="hidden" name="language" value="<%:language%>"/>
<input type="hidden" name="cart_action" value="update"/>

    <table width="548" border="0" cellpadding="0" cellspacing="0" class="tablecheckout">
	  <thead>
        <tr class="">
          <td width="30" align="center"><%cms_e:qty_tbl_lbl%></td>
          <td width="50" align="center"><%cms_e:item_remove_tbl_lbl%></td>
          <td width="300"><%cms_e:item_name_tbl_lbl%></td>
          <td width="100" align="right"><%cms_e:item_unit_price_lbl%></td>
          <td width="100" align="right"><%cms_e:price_tbl_lbl%></td>
          <td></td>
        </tr>
	  </thead>
	  <tbody>
	<%a_print_cart_items%>			
	  </tbody>
	  <tfoot>
	  
        <tr>
          <td colspan="4" align="right"><strong><%cms_e:cart_amount_lbl%></strong></td>
          <td align="right"><strong><%tpl_money::amount_taxl%> <%cms:cart_carrency_lbl%></strong></td>
          <td></td>
        </tr>

        <tr>
          <td colspan="4" align="right"><strong><%cms_e:cart_VAT_lbl%></strong></td>
          <td align="right"><strong><%tpl_money::tax%> <%cms:cart_carrency_lbl%></strong></td>
          <td></td>
        </tr>
        
	  </tfoot>
   </table>
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableform">
   <tr><td>
		<input type="submit" name="Submit" value="<%cms:update%>" class="form-button"/><%text_edit_cms:update%>
		<input type="submit" name="Back" value="<%cms:contimue_shopping_lbl%>" class="form-button"/><%text_edit_cms:contimue_shopping_lbl%>
	</td><td colspan="12" align="right">
		<input type="submit" <%iif:<%session:shopping_items_count%>,,disabled="1"%>  name="Checkout" value="<%cms:checkout%>" class="form-button"/><%text_edit_cms:checkout%>		
	</td></tr>
   </table>
</form>

<%include:footer%>
