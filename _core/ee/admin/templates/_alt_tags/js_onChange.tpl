<script language="JavaScript">
function alt_tag_onChange(tag_input, tag_media_id, tag_lang)
{
	tag_input.style.color = '#0a0';
	var fr;
	fr = document.getElementById('iframe1');
	fr.src = '<%:EE_ADMIN_URL%>alt_tag_edit.php?val=' + tag_input.value + '&language=' + tag_lang + '&page_id=' + tag_media_id;
}
</script>