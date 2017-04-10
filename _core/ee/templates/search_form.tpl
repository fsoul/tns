<form method="get" name="fs" action="#">
	<%cms:search_title%><input type="text" name="search_str" value="<%getHtmlOf:search_str%>" class="fr_input">&nbsp;<a href="#" onclick="document.fs.submit()"><%cms:search_button_text%><%edit_cms:search_button_text%><%img_btn:search_button_image%></a>
	<input type="hidden" name="t" value="<%:t%>">
	<input type="hidden" name="language" value="<%:language%>">
</form>
