<script language="JavaScript">
function meta_tag_onChange(tag_input, tag_name, tag_lang, tag_page_id)
{
	tag_input.style.color = '#0a0';
	var fr;
	fr = document.getElementById('iframe1');
	fr.src = '<%:EE_ADMIN_URL%>seo_meta_tag_edit.php?var=' + tag_name + '&val=' + tag_input.value + '&language=' + tag_lang + '&page_id=' + tag_page_id;
}
</script>