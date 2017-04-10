<tr class="homeCardCaption">
	<td width="4%"><%cms:cart_qty_lbl%><%edit_cms:cart_qty_lbl%></td>
	<td width="5%"><%cms:cart_remove_lbl%><%edit_cms:cart_remove_lbl%></td>
	<td width="100%"><%cms:cart_item_lbl%><%edit_cms:cart_item_lbl%></td>
	<td width="27%"><%cms:cart_price_lbl%><%edit_cms:cart_price_lbl%></td>
</tr>
<%row%
<tr class="homeCard">
	<td><input type="text" style="width:40px; text-align:right" name="q[<%:shopping_item_id%>]" value="<%:shopping_item_count%>"></td>
	<td align="center"><input type="checkbox" name="d[<%:shopping_item_id%>]" value="1"></td>
	<td align="left">
		<nobr>&nbsp;<%:shopping_item_name%><nobr>
	</td>
	<td align="right"><%:shopping_item_cost%>&nbsp;<%cms:cart_carrency_lbl%><%edit_cms:cart_carrency_lbl%></td>
</tr>
%row%>

<!--
<%row_empty%
<tr><td colspan="4" align="center"><%cms_e:cart_empty%></td></tr>
%row_empty%>
-->
