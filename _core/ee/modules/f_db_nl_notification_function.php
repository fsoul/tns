<?

function f_add_nl_notification($pPageName, $from_email)
{
	global $UserId;

	$pPageDescription = $pPageName;
	$pDefaultPage = 0;
	$pTplId = getField('SELECT id FROM tpl_files WHERE type=2');
	$pFolderId = 'NULL';
	$pSearch = 0;

	if (db_sql_num_rows(ViewSQL('SELECT id FROM tpl_pages WHERE page_name LIKE "'.$pPageName.'" AND folder_id IS NULL;')) > 0)
		return -1;

	$id = RunSQL('INSERT INTO tpl_pages SET
		page_name = "'.$pPageName.'",
		page_description = "'.$pPageDescription.'",
		default_page = "'.$pDefaultPage.'",
		tpl_id = "'.$pTplId.'",
		folder_id = '.$pFolderId.',
		create_date = NOW(),
		for_search = "'.$pSearch.'",
		owner_name = '.sqlValue(Get_user_name_by_id($UserId)).';');

	save_cms('nl_notification_from_email', $from_email, $id);

	return $id;
}

function f_del_nl_notification($pId)
{

	RunSQL('DELETE FROM tpl_pages WHERE id = "'.$pId.'";');
	return 1;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/
function f_del_nl_notifications($pId)
{

	RunSQL('DELETE FROM tpl_pages WHERE id in('.sqlValuesList($pId).')');
	return 1;
}


function f_upd_nl_notification($pID, $pPageName, $from_email)
{

	$pPageDescription = $pPageName;
	$pDefaultPage = 0;
	$pTplId = getField('SELECT id FROM tpl_files WHERE type=2');
	$pFolderId = 'NULL';
	$pSearch = 0;

	if (mysql_num_rows(ViewSQL('SELECT id FROM tpl_pages WHERE id <> "'.$pID.'" AND page_name = "'.$pPageName.'" AND folder_id IS NULL;')) > 0)
		return -1;

	RunSQL('UPDATE tpl_pages SET page_name = "'.$pPageName.'", page_description = "'.$pPageDescription.'",
		default_page = "'.$pDefaultPage.'",	tpl_id = "'.$pTplId.'", folder_id = '.$pFolderId.', for_search = "'.$pSearch.'"
	  WHERE id = "'.$pID.'";');

	save_cms('nl_notification_from_email', $from_email, $pID);

	return $pID;
}

?>