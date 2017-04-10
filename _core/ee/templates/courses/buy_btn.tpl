<form name="buy_course_<%:product_id%>" action="<%:EE_HTTP%>index.php?t=courses/cart&language=<%:language%>" method="post">
<input type="hidden" name="cart_action" value="add">
<input type="hidden" name="course_id" value="<%:product_id%>">
<input type="submit" border="0" class="button" value="<%cons:Buy%>">
</form>
