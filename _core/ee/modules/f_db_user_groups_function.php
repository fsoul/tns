<?

function f_add_user_groups($pGroupName, $pGroupCode)
{
	if (db_sql_num_rows(viewSQL('SELECT id FROM user_groups WHERE group_name LIKE "'.$pGroupName.'";')) > 0)
	{
		return -1;
	}

	if (db_sql_num_rows(viewSQL('SELECT id FROM user_groups WHERE group_code = '.sqlValue($pGroupCode))) > 0)
	{
		return -2;
	}

	$sql = 'INSERT INTO user_groups SET group_name = '.sqlValue($pGroupName).', group_code='.sqlValue($pGroupCode).';';

	$l_id = RunSQL($sql);

	return $l_id;
}

function f_del_user_groups($pId)
{
	RunSQL('DELETE FROM user_groups WHERE id = "'.$pId.'";');

	return 1;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/

function f_del_user_groupss($pId)
{
	RunSQL('DELETE FROM user_groups WHERE id in('.sqlValuesList($pId).')');
	return 1;
}


function f_upd_user_groups($pID, $pGroupName, $pGroupCode)
{

	if (mysql_num_rows(viewSQL('SELECT id FROM user_groups WHERE group_name = "'.$pGroupName.'" AND id <> '.$pID.';')) > 0)
	{
		return -1;
	}

	RunSQL('UPDATE user_groups SET group_name = "'.$pGroupName.'" WHERE id = "'.$pID.'";');

	return 1;
}



