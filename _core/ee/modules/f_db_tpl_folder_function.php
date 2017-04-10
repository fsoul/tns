<?

function f_add_tpl_folder($pFolder, $pDescr, $pParent, $pSearch, $pLocked, $pGroupAccess, $pUserGroups)
{
	global $$pFolder;
	$pFolder = $$pFolder;

	if ((mysql_num_rows(ViewSQL('SELECT id FROM v_tpl_folder WHERE page_name = '.sqlValue($pFolder['general']).'AND folder_id = '.sqlValue($pParent)))) > 0)
	{
		return -1;
	}

	if(!is_unique_names($pFolder, null, $pParent))
	{
		return -1;
	}

	if ($pSearch == '')
		$pSearch = 0;
	if ($pLocked == '')
		$pLocked = 0;

	$retval = RunSQL('INSERT INTO tpl_pages SET
				page_name = '.sqlValue($pFolder['general']).',
				page_description = "'.$pDescr.'",'
				. ($pParent > 0 ? 'folder_id = '.$pParent.',' : 'folder_id = NULL,') .
				'tpl_id = NULL,
				create_date = NOW(),
				for_search = "'.$pSearch . '",
				is_locked = "'.$pLocked . '",
				owner_name = '.sqlValue($_SESSION['UserName']).',
				group_access='.sqlValue($pGroupAccess).';');

	$r = viewSQL('SELECT id FROM tpl_pages WHERE folder_id=' . $retval);
	if(db_sql_num_rows($r) > 0)
	{
		while($subFolder = db_sql_fetch_assoc($r))
		{
			runSQL('UPDATE tpl_pages SET group_access='.sqlValue($pGroupAccess).' WHERE id='.sqlValue($subFolder['id']));
		}
	}

	if ($pFolder['general'] == '__replace_after_insert__')
		RunSQL('UPDATE tpl_pages SET page_name = '.sqlValue($retval).' WHERE id = '.sqlValue($retval));
	foreach ($pFolder as $key => $value)
		if ($key != 'general' && $value != '')
				save_cms('page_name_' . $retval, $value, 0, $key);

	if (config_var('use_draft_content') == 1)
	{
		publish_cms_on_page(0, 'page_name_', $retval);
	}

	if(is_array($pUserGroups))
	{
		foreach($pUserGroups as $k=>$v)
		{
			runSQL('INSERT INTO folder_group VALUES("'.$retval.'", "'.$v.'")');
		}
	}
	else
	{
		if($pUserGroups != '') runSQL('INSERT INTO folder_group VALUES("'.$retval.'", "'.$pUserGroups.'")');
	}

	update_folder_hierarhi();
	set_folder_permission($pParent, $retval);
	return $retval;
}


function f_del_tpl_folder($pId)
{
	RunSQL('DELETE FROM tpl_pages WHERE id = "'.$pId.'";');
	RunSQL('DELETE FROM content WHERE var_id = "'.$pId.'" AND var = "folder_path_";');
	update_folder_hierarhi();
	return 1;
}

/**
 * Deletes selected items on grid
 *
 * @param array $pId - array of [selected] items ids
 * @return int
 */
function f_del_tpl_folders($pId)
{
	RunSQL('DELETE FROM tpl_pages WHERE id in('.sqlValuesList($pId, true).')');
	RunSQL('DELETE FROM content WHERE var = "page_name_" AND var_id in('.sqlValuesList($pId, true).')');
	update_folder_hierarhi();
	return 1;
}

function f_upd_tpl_folder($pID, $pFolder, $pDescr, $pParent, $pSearch, $pLocked, $pGroupAccess, $pUserGroups)
{
	global $$pFolder;
	$pFolder = $$pFolder;

	if(!is_unique_names($pFolder, null, $pParent, $pID))
	{
		return -1;
	}

	if (mysql_num_rows(ViewSQL('SELECT id FROM tpl_pages WHERE page_name = '.sqlValue($pFolder['general']).' AND id <> '.sqlValue($pID) . 'AND folder_id = ' . sqlValue($pParent) . ' AND group_access='.sqlValue($pGroupAccess))) > 0)
		return -1;
	if (!preg_match('/^[0-9a-z_\-\. ]*$/ism',$pFolder['general']))
		return -1;
	if ($pSearch == '')
		$pSearch = 0;
	if ($pLocked == '')
		$pLocked = 0;

	// add permanent_redirect
	add_folder_permanent_redirect($pID, $pFolder);

	RunSQL('UPDATE tpl_pages SET
				page_name = '.sqlValue($pFolder['general']).',
				page_description = '.sqlValue($pDescr) .','
				. ($pParent > 0 ? 'folder_id = '.sqlValue($pParent).',' : ' folder_id =  NULL, ') .
				'tpl_id = NULL,
				for_search = '.sqlValue($pSearch).',
				is_locked = '.sqlValue($pLocked).',
				group_access = ' . sqlValue($pGroupAccess)  . '
 			WHERE id =  '.sqlValue($pID).' AND id <> '.sqlValue($pParent),0);
	$r = viewSQL('SELECT id FROM tpl_pages WHERE folder_id=' . $pID);
	if(db_sql_num_rows($r) > 0)
	{
		while($subFolder = db_sql_fetch_assoc($r))
		{
			runSQL('UPDATE tpl_pages SET group_access='.sqlValue($pGroupAccess).' WHERE id='.sqlValue($subFolder['id']));
		}
	}
	RunSQL('DELETE FROM content WHERE var = "page_name_" AND var_id = ' . sqlValue($pID),0);
	foreach ($pFolder as $key => $value)
	{
		if ($key != 'general' && $value != '')
		{
			save_cms('page_name_'.$pID, $value, 0, $key);
		}
	}

	if (config_var('use_draft_content') == 1)
	{
		publish_cms_on_page(0, 'page_name_', $pID);
	}

	runSQL('DELETE FROM folder_group WHERE folder_id="'.$pID.'"');
		if(is_array($pUserGroups))
		{
			foreach($pUserGroups as $k=>$v)
			{
				runSQL('INSERT INTO folder_group VALUES("'.$pID.'", "'.$v.'")');
			}
		}
		else
		{
			if($pUserGroups != '') runSQL('INSERT INTO folder_group VALUES("'.$pID.'", "'.$pUserGroups.'")');
		}	

	update_folder_hierarhi();
	set_folder_permission($pParent,$pID);
	return 1;
}

?>