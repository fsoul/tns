<?php

function set_folder_permission($fromFolder, $to)
{
	//set User Access
	
	$r = viewSQL('SELECT val, var_id FROM content WHERE page_id='.sqlValue($fromFolder).' AND var="folder_access_mode_"');
	if(db_sql_num_rows($r) > 0)
	{
		while($row = db_sql_fetch_array($r))
		{
			save_cms('folder_access_mode_'.$row['var_id'], $row['val'], $to);
		}
	}
	
}

function check_content_access_by_arr($arr, $edit = null)
{
	$ua = $_SESSION['UserAccess'];

	$am = get_access_mode($edit);

       	if(is_array($arr))
	{
		for($i=0; $i < count($arr); $i++)
		{
			if(($am == null && $ua == $arr[$i]) || ($am != null && $am == $arr[$i]))
			{
				return true;
			}
		}
	}
	else
	{
		return true;
	}

	return false;
}

function check_content_access($checking_access_level, $checking_access_level2 = null, $checking_access_level3 = null, $edit = null)
{
	$arr[] = $checking_access_level;
	if($checking_access_level2 != null)
		$arr[] = $checking_access_level2;
	if($checking_access_level3 != null)
		$arr[] = $checking_access_level3;

	return check_content_access_by_arr($arr, $edit);
}

function check_frontend_folder_access_by_group($folder)
{
	$folderId = getField('SELECT id FROM v_tpl_path_content WHERE folder='.sqlValue($folder));

	$group_access = getField('SELECT group_access FROM tpl_pages WHERE id=' . sqlValue($folderId));

	if($group_access == 1 || $group_access == 0)
	{
		return true;
	}

	$search_engine_list = get_search_engine_list();

	if (	(
		is_search_engine($search_engine_list) ||
		is_refer_from_search_engine($search_engine_list)) &&
		se_index()
	)
	{
		register_session_for_searchengines();
		return true;
	}

	if(isset($_SESSION['UserRole']) && $_SESSION['UserRole'] === '3')
	{
		return true;
	}
	else if(isset($_SESSION['UserId']))
	{
		if ($folderGroup = get_folder_groups($folderId))
		{
			for($i = 0; $i < count($_SESSION['UserGroups']); $i++)
			{
				if(in_array($_SESSION['UserGroups'][$i], $folderGroup))
					return true;
			}
		}
	}

	return false;
}

function register_session_for_searchengines()
{
	$_SESSION['UserBrowser'] 	= '';
	$_SESSION['UserIP'] 		= USER_IP;
	$_SESSION['UserAccess'] 	= CA_READ_ONLY;
	$_SESSION['already_checked'] 	= true;
	$_SESSION['startTime'] 		= time();
	$_SESSION['lastTime'] 		= $_SESSION['startTime'];
	$_SESSION['login'] 		= 'Search_engine_machine';
	$_SESSION['pass'] 		= '';
	$_SESSION['UserId'] 		= '';
	$_SESSION['UserName'] 		= 'Guest';
	$_SESSION['UserRole'] 		= USER;
	$_SESSION['UserGroups'] 	= array();
}

function get_user_content_access($userId)
{
	if($ca = getField('SELECT content_access FROM users WHERE id='.sqlValue($userId)))
	{
		return $ca;
	}
	return false;
}

function get_access_mode($edit)
{
	return getField('SELECT val FROM content WHERE page_id='.sqlValue($edit).' AND var="folder_access_mode_" AND var_id='.sqlValue($_SESSION['UserId']));
}

function get_user_groups()
{
	$arr = array();
	
	if (isset($_SESSION['UserId']))
	{
		$sql = 'SELECT
				group_code
			FROM
				user_groups
			JOIN
				user_group
			ON 
				user_groups.id = user_group.group_id
			WHERE
				user_id = '.sqlValue($_SESSION['UserId']);

		$res = viewSQL($sql);

		if (db_sql_num_rows($res) > 0)
		{
			while ($row = db_sql_fetch_row($res))
			{
				$arr[] = $row[0];
			}
		}
	}

	return $arr;
}

function getUserRole($userId)
{
	return getField('SELECT role FROM users WHERE id='.sqlValue($userId));
}

function get_folder_groups($folderId)
{
	$sql = 'SELECT group_code
		FROM
			user_groups
		JOIN
			folder_group
		ON 
			user_groups.id = folder_group.group_id
		WHERE
			folder_id = '.sqlValue($folderId);

	$r = viewSQL($sql);

	if(db_sql_num_rows($r) > 0)
	{
		while($row = db_sql_fetch_row($r))
		{
			$arr[] = $row[0];
		}
	}
	else
	{
		$arr = false;
	}
	return $arr;
}

function get_search_engine_list()
{
	$search_engine_list = get_config_var('search_engine_list');

	$search_engine_list = explode("\r\n", $search_engine_list);

	for ($i = 0; $i < count($search_engine_list); $i++)
	{
		if (strpos($search_engine_list[$i], '-') > 0)
		{
			$i_array = explode('-', $search_engine_list[$i]);
			
			$search_engine_ua	= $i_array[0];
			$refer 			= $i_array[1];
		}
		else
		{
			$search_engine_ua	= $search_engine_list[$i];
			$refer			= '';
		}

		$new_search_engine_list[$i]['search_engine_ua'] = $search_engine_ua;
		$new_search_engine_list[$i]['refer']		= $refer;
	}

	return $new_search_engine_list;

}

function is_search_engine($search_engine_list)
{
	$user_agent	= '';
	$user_agent 	= $_SERVER['HTTP_USER_AGENT'];

	for ($i = 0; $i < count($search_engine_list); $i++)
	{
		if (strpos($user_agent, $search_engine_list[$i]['search_engine_ua']) !== false)
		{
			return true;
		}
	}

	return false;
}

function is_refer_from_search_engine($search_engine_list)
{
	$refer	= ($_SERVER['HTTP_REFERER'] ? $_SERVER['HTTP_REFERER'] : '');

	if (strpos($refer, 'http://') === 0)
	{		
		$refer = substr($refer, 7);
	}

	$slash_pos = strpos($refer, '/');
	if ($slash_pos !== false)
	{
		$refer = substr($refer, 0, $slash_pos);
	}

	for ($i = 0; $i < count($search_engine_list); $i++)
	{
		if (strpos($refer, $search_engine_list[$i]['refer']) === 0)
		{
			return true;		
		}
	}

	return false;
}

function se_index()
{
	global $t;

	$page_name = substr($t, strrpos($t, '/') + 1);

	$sql = 'SELECT 1 FROM v_tpl_page_content WHERE page_name=' . sqlValue($page_name) . ' AND for_search = 1';
	$se_index = getField($sql);

	if ($se_index)
	{
		return true;
	}

	return false;
}

