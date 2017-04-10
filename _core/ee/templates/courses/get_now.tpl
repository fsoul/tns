<form name="buy_course_<%:product_id%>" action="<%:EE_HTTP%>index.php?t=get_course_now&language=<%:language%>" method="post">
<input type="hidden" name="cart_action" value="add">
<input type="hidden" name="course_id" value="<%:product_id%>">
<input type="submit" border="0" class="button" value="<%cms:get_now%>"><%text_edit_cms:get_now%>
</form>
