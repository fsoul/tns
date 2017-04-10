<script language="JavaScript">
function lock_page(obj, page_id)
{
	if (!confirm('Are you sure want to change lock state of page?')) return false;
	var fr;
	fr = document.getElementById('iframe1');
	fr.src = '<%:EE_ADMIN_URL%>_tpl_page.php?op=lock&t=' + page_id;
}
</script>