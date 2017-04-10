<?

function f_add_styles($elem, $class, $title, $declaration)
{
	$ret = 0;
	if (mysql_num_rows(ViewSQL('SELECT id FROM styles WHERE title = "'.$title.'"',0)) > 0)
		$ret = -1;
	if (mysql_num_rows(ViewSQL('SELECT id FROM styles WHERE element = "'.$elem.'" AND class = "'.$class.'"',0)) > 0)
		$ret = -2;

	if ($ret == 0)
		$ret = RunSQL('INSERT INTO styles SET title = "'.$title.'", element = "'.$elem.'", class = "'.$class.'",
			declaration = "'.$declaration.'"',0);

	f_del_styles_cache();

	return $ret;
}

function f_del_styles($pId)
{
	RunSQL('DELETE FROM styles WHERE id = "'.$pId.'";');
	f_del_styles_cache();

	return 1;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/

function f_del_styless($pId)
{
	RunSQL('DELETE FROM styles WHERE id in('.sqlValuesList($pId).')');
	f_del_styles_cache();

	return 1;
}


function f_upd_styles($pId, $elem, $class, $title, $declaration)
{
	$tmp = 1;
	if (mysql_num_rows(ViewSQL('SELECT id FROM styles WHERE title = "'.$title.'" AND id <>'.$pId,0)) > 0)
		$tmp = -1;
	if (mysql_num_rows(ViewSQL('SELECT id FROM styles WHERE element = "'.$elem.'" AND class = "'.$class.'" AND id <>'.$pId,0)) > 0)
		$tmp = -2;
msg($declaration,'declaration');
	if ($tmp > 0) {
		RunSQL('UPDATE styles SET title = "'.$title.'", element = "'.$elem.'", class = "'.$class.'",
			declaration = "'.$declaration.'" WHERE id = "'.$pId.'";',0);
		$tmp = $pId;
	}
	f_del_styles_cache();

	return $tmp;
}



function f_del_styles_cache()
{               
	delete_file(EE_PATH.'css/dynamic_style.css');
	delete_file(EE_PATH.'/_core/ee/css/dynamic_style.css');
}

