<form name="paypal_<%:id%>" action="<%:EE_HTTP%>index.php?t=eshop/cart&amp;language=<%getValueOf:language%>" method="post">
					<input type="hidden" name="cart_action" value="add" />
					<input type="hidden" name="t_back" value="<%server:QUERY_STRING%>" />
					<input type="hidden" name="item_name" value="<%:product_name%>" />
					<input type="hidden" name="item_number" value="<%:article%>" />
					<a class="minicart" href="#" onclick="document.paypal_<%:id%>.submit();" >
					<span>Add to cart</span>
					</a>
</form>