<?

function f_add_tpl_page($pPageName, $extension, $pPageDescription, $pDefaultPage, $pTplId, $pFolderId, $pSearch, $lock_status, $pCachable, $pUserId)
{
	global $$pPageName;
	$pPageName = $$pPageName;

	if (!isset($pFolderId) || $pFolderId == '') {
		$folder_check=' IS NULL';
		$pFolderId = 'NULL';
	} else {
		$folder_check = '='.$pFolderId;
	}

	$pDefaultPage = (int)$pDefaultPage;
	$pSearch = (int)$pSearch;

	if (is_tpl_cachable($pTplId) == '0')
	{
		$pCachable = '0';
	}

	if (mysql_num_rows(ViewSQL('SELECT id FROM tpl_pages WHERE page_name LIKE "'.$pPageName['general'].'" AND folder_id '.$folder_check.' AND tpl_id IS NOT NULL')) > 0)
		return -1;

	if(!is_unique_names($pPageName, $pTplId, $pFolderId))
	{
		return -1;
	}

	$res = mysql_fetch_assoc(RunSQL('SELECT name FROM users WHERE id = "'.$pUserId.'"'));
	$pUserName = $res['name'];
	
	$group_access = getField('SELECT group_access FROM tpl_pages WHERE id='.sqlValue($pFolderId).'LIMIT 0,1');
	if($group_access ==  null)
	{
		$group_access = 1;
	}

	$id = RunSQL('INSERT INTO tpl_pages SET
		page_name = '.sqlValue($pPageName['general']).',
		extension = '.sqlValue($extension).',
		page_description = '.sqlValue($pPageDescription).',
		default_page = "'.$pDefaultPage.'",
		tpl_id = "'.$pTplId.'",
		folder_id = '.$pFolderId.',
		create_date = NOW(),
		for_search = "'.$pSearch.'",
		owner_name = "'.$pUserName.'",
		is_locked = '.sqlValue((int)$lock_status).',
		group_access = '.sqlValue($group_access).',
		cachable = '.sqlValue((int)$pCachable).'
		;');

	set_folder_permission($pFolderId, $id);

	if ($pDefaultPage != 0)
		f_set_default_tpl_page($id, $pFolderId, $folder_check);
	if ($pPageName['general'] == '__replace_after_insert__')
		RunSQL('UPDATE tpl_pages SET page_name = '.sqlValue($id).' WHERE id = '.sqlValue($id));
	foreach ($pPageName as $key => $value)
	{
		if ($key != 'general' && $value != '')
		{
			save_cms('page_name_'.$id, $value, 0, $key);
			if (config_var('use_draft_content') == 1)
			{
				publish_cms_on_page(0, 'page_name_', $id);
			}
		}
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $id;
}

function f_del_tpl_page($pId)
{
	$return = false;
	if(db_sql_num_rows(viewSql('SELECT id FROM tpl_pages WHERE id = "'.$pId.'"')) > 0)
	{
		if (db_sql_num_rows(viewSql('SELECT id FROM tpl_pages WHERE id = "'.$pId.'" AND default_page<>0')) > 0)
		{
			$min_id = getField('SELECT MIN(id) FROM tpl_pages WHERE id <> "'.$pId.'";');
			RunSQL('UPDATE tpl_pages SET default_page = 1 WHERE id = "'.$min_id.'";');
		}

		//delete prmanent redirects
		RunSQL('DELETE FROM permanent_redirect WHERE page_id='.sqlValue($pId));
		
		//delete page
		RunSQL('DELETE FROM tpl_pages WHERE id = "'.$pId.'";');
		RunSQL('DELETE FROM content WHERE var = "page_name_" AND var_id = "'.$pId.'";');
		runSQL('DELETE FROM content WHERE var = "folder_access_mode_" AND page_id = "'.$pId.'";');

		$return = true;

		// delete sitemap.xml cache
		delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
	}

	return $return;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/

function f_del_tpl_pages($pId)
{
	$return = false;
	if(db_sql_num_rows(viewSQL('SELECT id FROM tpl_pages WHERE id in('.sqlValuesList($pId, true).')')) > 0)
	{
		if (db_sql_num_rows(viewSQL('SELECT id FROM tpl_pages WHERE id in('.sqlValuesList($pId, true).') AND default_page<>0')) > 0)
		{
			$min_id = getField('SELECT MIN(id) FROM tpl_pages WHERE id not in('.sqlValuesList($pId, true).')');
			RunSQL('UPDATE tpl_pages SET default_page = 1 WHERE id = "'.$min_id.'";');
		}

		//delete permanents redirects
		runSQL('DELETE FROM permanent_redirect WHERE page_id in('.sqlValuesList($pId, true).')');
		
		//delete pages
		runSQL('DELETE FROM tpl_pages WHERE id in('.sqlValuesList($pId, true).')');
		runSQL('DELETE FROM content WHERE var = "page_name_" AND var_id in('.sqlValuesList($pId, true).')');
		runSQL('DELETE FROM content WHERE var = "folder_access_mode_" AND page_id = "'.sqlValuesList($pId, true).'"');
		
		$return = true;

		// delete sitemap.xml cache
		delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
	}
	return $return;
}

function check_is_null($val){
	return is_null($val)?"NULL":'"'.$val.'"';
}

function f_copy_tpl_page($pId, $type)
{
	//Генерируем новое имя
	//$result = ViewSQL('SELECT * FROM tpl_pages WHERE id = "'.$pId.'";');
	$result = ViewSQL('SELECT * FROM tpl_pages, content WHERE tpl_pages.id = "'.$pId.'" AND content.var = "page_name_" AND content.var_id = tpl_pages.id;');
	$res = db_sql_fetch_assoc($result);

	$res['page_description'] = check_is_null($res['page_description']);
	$res['tpl_id'] 		= check_is_null($res['tpl_id']);
	$res['folder_id'] 	= check_is_null($res['folder_id']);
	$res['for_search'] 	= check_is_null($res['for_search']);
	$res['owner_name'] 	= check_is_null($res['owner_name']);
	$res['cachable'] 	= ($res['cachable'] === null ? 0 : $res['cachable']);

	//print_r($res); exit;

	if($res['group_access'] == null)
	{
		$res['group_access'] = 1;
	}
	$i=1;
	do
	{
		if($i < 2)
		{
			$prefix = 'copy_';
		}
		else
		{
			//$prefix = 'copy_['.$i.']_';
			$prefix = 'copy_'.$i.'_';
		}
		$i++;
		if($i>333) break;/////
		//$new_name = $prefix.$res['page_name'];
		$new_name = $prefix.$res['val'];
	//}while(mysql_num_rows(ViewSQL('SELECT id FROM tpl_pages WHERE page_name='.sqlValue($new_name).';')) > 0);
	}while(db_sql_num_rows(ViewSQL('SELECT page_id FROM content WHERE val='.sqlValue($new_name).' AND var = "page_name_";')) > 0);

	$copy_sql = 'INSERT INTO 
				tpl_pages 
			SET 
				page_name = '.sqlValue($new_name).', 
				page_description = '.$res['page_description'].',
				default_page = "0",
				create_date = NOW(),
				edit_date = NOW(),
				tpl_id = '.$res['tpl_id'].',
				folder_id = '.$res['folder_id'].',
				for_search = '.$res['for_search'].',
				owner_name = '.$res['owner_name'].',
				is_locked = "'.$res['is_locked'].'",
				group_access = "'.$res['group_access'].'",
				cachable = "'.$res['cachable'].'"';

	RunSQL($copy_sql);

	$new_id = db_sql_insert_id();
	
	//copy page name
	$result = ViewSQL('SELECT * FROM content WHERE var_id = "'.$pId.'" AND var = "page_name_";');
	if(db_sql_num_rows($result) > 0)
	{
		$value = array();
		while($res = db_sql_fetch_array($result))
		{
			$value[] = '("0", "page_name_", '.sqlValue($new_id).', '.sqlValue($new_name).', "page_name_'.addslashes($new_id).'", '.sqlValue($res['language']).', NOW(), '.sqlValue($new_name).', NOW())';
		}
		$values = implode(', ', $value);
		RunSQL('INSERT INTO content(page_id, var, var_id, val, short_desc, language, edit_date, val_draft, edit_date_draft) VALUES '.$values);
	}
	
	//if page is media copy files from FTP
	if(strtolower($type) == 'media')
	{
		//example (0, 'media_', 58, 'a:3:{s:6:"size_x";N;s:6:"size_y";N;s:6:"images";a:2:{s:2:"DE";s:16:"header_58_DE.jpg";s:2:"EN";s:16:"header_58_EN.jpg";}}', 'media_58', '', '2008-10-09 17:38:13', 'a:3:{s:6:"size_x";N;s:6:"size_y";N;s:6:"images";a:2:{s:2:"DE";s:16:"header_58_DE.jpg";s:2:"EN";s:16:"header_58_EN.jpg";}}', '2008-10-09 17:38:13'),
		$result = ViewSQL('SELECT * FROM content WHERE var_id = '.sqlValue($pId).' AND var="media_" LIMIT 1');
		if(db_sql_num_rows($result) > 0)
		{
			$res = db_sql_fetch_array($result);
			$media_prop = unserialize($res['val']);
			$images = array();
			$size_x = '';
			$size_y = '';
			if(is_array($media_prop['images']))
			{
				$size_x = $media_prop['size_x'];
				$size_y = $media_prop['size_y'];
				foreach($media_prop['images'] as $img_lang => $img_name)
				{
					$media_ext = '';
					$media_ext_pos = strpos($img_name, '.');
					if($media_ext_pos !== false)
					{
						$media_ext = substr($img_name, $media_ext_pos+1);
					}
					$new_media_name = $new_name.'_'.$new_id.'_'.$img_lang.'.'.$media_ext;
					$images[$img_lang] = $new_media_name;
					//copy files
					copy(EE_MEDIA_FILE_PATH.$img_name, EE_MEDIA_FILE_PATH.$new_media_name);
				}
			}
			//insert info about media into DB
			$media_properties = serialize(array('size_x' => $size_x, 'size_y' => $size_y, 'images' => $images));
			if(db_sql_num_rows(ViewSQL('SELECT var_id FROM content WHERE var_id = '.sqlValue($new_id).' AND var="media_" LIMIT 1')) == 0)
			{
				RunSQL('INSERT INTO content SET 
					page_id=0, 
					var="media_", 
					var_id="'.$new_id.'", 
					val=\''.$media_properties.'\', 
					short_desc="'.$res['short_desc'].'", 
					language="", 
					edit_date=NOW(), 
					val_draft=\''.$media_properties.'\', 
					edit_date_draft=NOW()');
			}
		}
	}
	
	//copy seo & content
	$result = ViewSQL('SELECT * FROM content WHERE page_id = "'.$pId.'" AND var <> "edit_user";');
		if(mysql_num_rows($result) > 0)
		{
		$value = array();
		while($res = db_sql_fetch_row($result))
		{
			for($i=0;$i<sizeof($res);$i++)
			{
				if($i < 1)
				{
					$res[$i] = sqlValue($new_id);
				}
				else
				{
					$res[$i] = sqlValue($res[$i]);
				}
			}
			$value[] = '('.implode(', ', $res).')';
		}
		$values = implode(', ', $value);
		RunSQL('INSERT INTO content VALUES '.$values);
	}
	
	//copy edit_user
	global $UserName;
	RunSQL('INSERT INTO content SET page_id = "'.$new_id.'", var = "edit_user", var_id = "0", val = '.sqlValue($UserName).', short_desc = NULL, language = "", edit_date = "0000-00-00 00:00:00", val_draft = NULL, edit_date_draft = NOW()');

	set_folder_permission($pId, $new_id);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
	
	return 1;
}

function f_copy_tpl_pages($pId)
{
	if(is_array($pId))
	{
		for($i=0;$i<sizeof($pId);$i++)
		{
			if(!check_content_access(CA_READ_ONLY,CA_EDIT,CA_PUBLISH,$pId[$i]))
			{
				f_copy_tpl_page($pId[$i], 'Page');
			}
		}
	}
	else
	{
		if(!check_content_access(CA_READ_ONLY,CA_EDIT,CA_PUBLISH,$pId))
		{
			f_copy_tpl_page($pId, 'Page');
		}
	}

	return 1;

}

function f_set_default_tpl_page($pId, $pFolderId, $folder_check)
{
	if (mysql_num_rows(ViewSQL('SELECT id FROM tpl_pages WHERE id = "'.$pId.'"')) > 0)
	{
		RunSQL('UPDATE tpl_pages SET default_page = 0 WHERE id <> "'.$pId.'" AND folder_id '.$folder_check);
		RunSQL('UPDATE tpl_pages SET default_page = 1 WHERE id = "'.$pId.'" AND folder_id '.$folder_check);	
		return 1;
	}
	else
		return -1;
}

function f_unset_default_tpl_page($pID, $checkDefaultPage)
{	
	if($checkDefaultPage > 0)
	{
		RunSQL('UPDATE tpl_pages SET default_page = 0 WHERE id = "'.$pID.'"');
	}
	return 1;
}

function f_upd_tpl_page($pID, $pPageName, $extension, $pPageDescription, $pDefaultPage, $pTplId, $pFolderId, $pSearch, $lock_status, $pCachable)
{
	global $$pPageName;
	$pPageName = $$pPageName;
	$is_publish_page = false;

	if(!is_unique_names($pPageName, $pTplId, $pFolderId, $pID))
	{
		return -1;
	}

	if (!isset($pFolderId) || $pFolderId == '' || ((int)$pFolderId) == 0)
	{
		$pFolderId = 'NULL';
		$folder_check = ' IS '.$pFolderId;
		$id_check = '';
	}
	else
	{
		$pFolderId = ((int)$pFolderId);
		$folder_check = '='.sqlValue($pFolderId);
		$id_check = ' AND id <> '.sqlValue($pFolderId);
	}

	$pDefaultPage = (int)$pDefaultPage;
	$pSearch = (int)$pSearch;

	if (is_tpl_cachable($pTplId) == '0')
	{
		$pCachable = '0';
	}

	if (	db_sql_num_rows(ViewSQL('
			SELECT id
			  FROM tpl_pages
			 WHERE id <> '.sqlValue($pID).'
			   AND page_name = '.sqlValue($pPageName['general']).'
			   AND folder_id '.$folder_check.'
			   AND tpl_id IS NOT NULL'
			)
		) > 0
	)
	{
		return -1;
	}

	$prFolderId = getField('SELECT folder_id FROM tpl_pages WHERE id = "'.$pID.'"');

	if (!isset($prFolderId) || $prFolderId == '' || ((int)$prFolderId) == 0 || $prFolderId == null)
	{
		$prFolderId = 'NULL';
	}
        $checkDefaultPage = mysql_num_rows(ViewSQL('SELECT id FROM tpl_pages WHERE default_page = 1 AND folder_id '.$folder_check));

	$group_access = getField('SELECT group_access FROM tpl_pages WHERE id='.sqlValue($pFolderId).'LIMIT 0,1');
	if($group_access ==  null)
	{
		$group_access = 1;
	}

	// add permanent_redirect
	if (is_page_draft($pID) == 0)
	{
		add_page_redirect($pID, $pPageName);
	}

	RunSQL('

	 UPDATE tpl_pages
	    SET
		page_name = '.sqlValue($pPageName['general']).',
		extension = '.sqlValue($extension).',
		page_description = '.sqlValue($pPageDescription).',
		default_page = '.sqlValue($pDefaultPage).',
		tpl_id = '.sqlValue($pTplId).',
		folder_id = '.$pFolderId.',
		for_search = '.sqlValue($pSearch).',
		is_locked = '.sqlValue((int)$lock_status).',
		group_access = '.sqlValue($group_access).',
		cachable = '.sqlValue((int)$pCachable).'
	  WHERE id = '.sqlValue($pID).' '.$id_check

	, 0);

	RunSQL('
		DELETE FROM content
		      WHERE var = "page_name_"
			AND var_id = '.sqlValue($pID)
	, 0);

	//
	set_folder_permission($pFolderId, $pID);

	foreach ($pPageName as $key => $value)
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

	// remove cycle redirects if it's was
	regulate_permanent_redirect($pID);

       	if ($pDefaultPage != 0)
	{
		if($prFolderId == $pFolderId)
		{
			f_set_default_tpl_page($pID, $pFolderId, $folder_check);
		}
		else
		{
			f_unset_default_tpl_page($pID, $checkDefaultPage);
		}
		
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

function is_unique_names($names_array, $tpl_id = false, $folder_id, $p_id = false)
{
	if($tpl_id ==  false)
	{
		$tpl_type = null;
	}
	else
	{	
		$tpl_type = get_tpl_type($tpl_id);
	}

	if($folder_id == '' || $folder_id == 'NULL')
	{
		$folder_check=' IS NULL';
		$folder_id = 'NULL';
	}
	else
	{
		$folder_check = '='.sqlValue($folder_id);
	}

	if($p_id)
	{
		$p_check = ' AND id <> '.sqlValue($p_id);
	}
	else
	{
		$p_check = '';
	}

	switch($tpl_type)
	{
		case '0':$table = 'v_tpl_page';
			$var = 'page_name_';
			break;
		case '1':$table = 'v_media';
                        $var = 'page_name_';
			break;
		case null: $table = 'v_tpl_folder';
			   $var = 'folder_path_';
			   break;
	}


	$page_id_array = array();

	$sql = 'SELECT id FROM '.$table.' WHERE folder_id'.$folder_check.$p_check;

	$res = viewSQL($sql);
	while($row = db_sql_fetch_assoc($res))
	{
		$page_id_array[] = $row['id'];
	}

	foreach($page_id_array as $var_id)
	{
		$sql_content = 'SELECT val, language FROM content WHERE var=\''.$var.'\' AND var_id=\''.$var_id.'\'';
		$res_content = viewSQL($sql_content);

		while($row_content = db_sql_fetch_assoc($res_content))
		{
			$array[$row_content['language']][$var_id] = strtolower($row_content['val']);
		}
	}

	if (is_array($names_array))
	foreach($names_array as $lang_org => $page_name_org)
	{
		$names_array_by_lang = $array[$lang_org];
		if(is_array($names_array_by_lang))
		{
			if(in_array(strtolower($page_name_org), $names_array_by_lang))
			{
				return false;
			}
		}
	}
	return true;	
}

function get_tpl_type($tpl_id)
{
	$sql = 'SELECT type FROM tpl_files WHERE id='.sqlValue($tpl_id);
	$res = viewSQL($sql);
	$row = db_sql_fetch_assoc($res);
	$type = $row['type'];

	return $type;
}

function is_page_cachable($pId)
{
	$cachable = array();

	$sql = 'SELECT 
			tpl_files.cachable AS file_cachable,
			tpl_pages.cachable AS page_cachable
		FROM 
			tpl_files
		JOIN 
			tpl_pages
		ON 
			tpl_files.id = tpl_pages.tpl_id

		WHERE tpl_pages.id = ' . sqlValue($pId) . ' LIMIT 0, 1';

	$res = viewSQL($sql);

	if (db_sql_num_rows($res) > 0)
	{
		$row = db_sql_fetch_assoc($res);

		$cachable['tpl'] 	= (int)$row['file_cachable'];
		$cachable['page'] 	= (int)$row['page_cachable'];

		return $cachable;
	}
	
	return false;
}

function is_tpl_cachable_by_page($pId)
{
	if ($array = is_page_cachable($pId))
	{
		if ($array['tpl'] == '1')
		{
			return true;
		}
	}

	return false;
}

function is_page_cachable_by_page($pId)
{
	if ($array = is_page_cachable($pId))
	{
		if ($array['page'] == '1')
		{
			return true;
		}
	}
	
	return false;
}

function is_tpl_cachable($tpl_id)
{
	if ((int)$tpl_id != $tpl_id)
	{
		$tpl_id = (int)getField('SELECT id FROM tpl_files WHERE file_name=' . sqlValue($tpl_id));
	}

	$sql = 'SELECT cachable FROM tpl_files WHERE id=' . sqlValue($tpl_id);

	return (int)getField($sql);
}

function page_exists($page_name)
{
	$ret = false;

	if (	parse_system_alias($page_name, config_var('alias_rule'), array('page_folder' => '([\/0-9a-zA-Z_%\.-]+)')) ||
		parse_system_alias($page_name, config_var('object_alias_rule')) || 
		parse_system_alias($page_name, config_var('views_rule'))
	) {
		$ret = true;
	}

	return $ret;
}



