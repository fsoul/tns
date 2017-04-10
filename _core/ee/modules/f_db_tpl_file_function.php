<?

function f_add_tpl_file($pFileName, $pFileDescription, $pCachable)//Deviant add: parameter $pFileDescription
{
	if (mysql_num_rows(ViewSQL('SELECT id FROM tpl_files WHERE file_name LIKE "'.$pFileName.'";')) > 0)
		return -1;

	$l_id = RunSQL('INSERT INTO tpl_files SET file_name = "'.$pFileName.'", description = "'.$pFileDescription.'", cachable = "' . ((int)$pCachable) . '", type=0;');
	                                                                                                                             
	return $l_id;
}

function f_del_tpl_file($pId)
{
	if(getField('SELECT COUNT(id) FROM tpl_pages WHERE tpl_id="'.$pId.'"') == 0)
	{
		RunSQL('DELETE FROM url_mapping_object WHERE object_view = "'.$pId.'";');
		RunSQL('DELETE FROM tpl_files WHERE id = "'.$pId.'";');
	}
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/

function f_del_tpl_files($pId)
{
	//проверяем есть ли на основании темплита страница
	foreach($pId as $id)
	{
		f_del_tpl_file($id);
	}
}


function f_upd_tpl_file($pID, $pFileName, $pFileDescription, $pCachable)//Deviant add: parameter $pFileDescription
{
	if (mysql_num_rows(ViewSQL('SELECT id FROM tpl_files WHERE file_name = "'.$pFileName.'" AND id <> '.$pID.';')) > 0)
		return -1;

	RunSQL('UPDATE tpl_files SET file_name = "'.$pFileName.'", description = "'.$pFileDescription.'", cachable = "' . ((int)$pCachable) . '" WHERE id = "'.$pID.'";');

	RunSQL('UPDATE tpl_pages SET cachable = "' . ((int)$pCachable) . '" WHERE tpl_id = "' . $pID . '"');

	return 1;
}

function get_tpl_file_id($tpl_name)
{
	return getField('SELECT id FROM tpl_files WHERE file_name = '.sqlValue($tpl_name));
}

?>