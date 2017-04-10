<?php

	define('EE_PERMANENT_REDIRECT_OBJECT_TABLE', 'permanent_redirect_object');

	function f_add_permanent_redirect($source_url, $target_url, $page_id, $lang_code, $t_view)
	{
		if(getField('SELECT COUNT(*) FROM permanent_redirect WHERE source_url='.sqlValue($source_url)) > 0)
		{
			return -1;
		}

		if((int)$t_view == 0)
		{
			if($get_view = getField('SELECT id FROM tpl_views WHERE view_folder='.sqlValue($t_view)))
			{
				$t_view = $get_view;
			}
			else
			{
				$t_view = 'NULL';
			}
		}
		$sql = 'INSERT INTO 
					permanent_redirect 
				SET 
					source_url = '.sqlValue($source_url).',
					target_url = '.sqlValue($target_url).',
					page_id = '.spValue($page_id).',
					lang_code = '.spValue($lang_code).',
					t_view = '.spValue($t_view);
		$res = runSQL($sql);
		return $res;
	}

	function f_upd_permanent_redirect($id, $source_url, $target_url, $page_id, $lang_code, $t_view)
	{
		// prepare url to <%:language%>/<%:page_folder%>/<%:page_name%>.html view.
		//$source_url = prepare_source_url($source_url);
		//$target_url = prepare_source_url($target_url);
                if (getField('SELECT COUNT(*) FROM permanent_redirect WHERE source_url='.sqlValue($source_url).' AND id<>'.sqlValue($id)) > 0)
		{
			return -1;
		}

		if ((int)$t_view == 0)
		{
			if ($get_view = getField('SELECT id FROM tpl_views WHERE view_folder='.sqlValue($t_view)))
			{
				$t_view = $get_view;
			}
			else
			{
				$t_view = 'NULL';
			}
		}

		$sql = 'UPDATE 
				permanent_redirect
			SET
				source_url = '.sqlValue($source_url).',
				target_url = '.sqlValue($target_url).',
				page_id = '.spValue($page_id).',
				lang_code = '.spValue($lang_code).',
				t_view = '.spValue($t_view).'
			WHERE id = '.sqlValue($id);

		$res = runSQL($sql);

		return $res; 
	}
	
	function f_del_permanent_redirect($pId)
	{
		RunSQL('DELETE FROM permanent_redirect WHERE id = '.sqlValue($pId));
		return 1;
	}
	
	function f_del_permanent_redirects($pId)
	{
		RunSQL('DELETE FROM permanent_redirect WHERE id in('.sqlValuesList($pId, true).')');
		return 1;
	}

	function add_lang_redirect($langCode)
	{
		if(get_config_var('auto_add_redirect_on_language') && $_GET['auto_redirect_add'] == 'true')
		{
			// строим редиректы для каждой страници, c языка который удалили на дефаултный язык и вьюшек
			//
			$default_language = getField('SELECT language_code FROM v_language WHERE default_language="1"');
			//
			$view_sql = 'SELECT id FROM tpl_views';
			$v_res = viewSQL($view_sql);

			$view_array = array();
			while($v_row = db_sql_fetch_assoc($v_res))
			{
				$view_array[] = $v_row['id'];
			}

			$page_sql = 'SELECT tpl_pages.id FROM tpl_pages INNER JOIN tpl_files ON tpl_pages.tpl_id = tpl_files.id WHERE tpl_files.type="0"';
			$p_res = viewSQL($page_sql);
			while($p_row = db_sql_fetch_assoc($p_res))
			{
				$pID = $p_row['id'];
				// для каждой страници
				for($i = 0; $i < sizeof($view_array); $i++)
				{
					if ($view_array[$i] == db_constant('DEFAULT_TPL_VIEW_ID'))
					{
						$source_url = get_default_alias_for_page($pID, '', $langCode);
					}
					else
					{
						$source_url = get_default_alias_for_view($pID, $view_array[$i], $langCode, true);
					}

					f_add_permanent_redirect($source_url, '', $pID, $default_language, $view_array[$i]);
				}
			}
		}
	}

	function add_page_redirect($pID, $pPageName)
	{
		// если страница переименована и включена опция автоматического добаления редиректа - добавляем его
		if(get_config_var('auto_add_redirect_on_page') && $_POST['auto_redirect_add'] == 'true')
		{
			//
			$view_sql = 'SELECT id FROM tpl_views';
			$v_res = viewSQL($view_sql);

			$view_array = array();
			while($v_row = db_sql_fetch_assoc($v_res))
			{
				$view_array[] = $v_row['id'];
			}
			//
			$sql = 'SELECT val, language FROM content WHERE var="page_name_" AND var_id='.sqlValue($pID);
			//
			$res = viewSQL($sql);
			// формируем массив имен страници по языку "которая еще не переименована"
			while($row = db_sql_fetch_assoc($res))
			{
				$temp_array[$row['language']] = $row['val'];
			}
			// массив имен страницы по языку который мы получили от формы редактирования
			$original_temp_arr = $pPageName;

			unset($original_temp_arr['general']);

			foreach($original_temp_arr as $lang => $page)
			{
				// если страница была переименована добавляем редирект для каждого с вида (views)
				if($page != $temp_array[$lang])
				{
					for($i = 0; $i < sizeof($view_array); $i++)
					{
						if($view_array[$i] == db_constant('DEFAULT_TPL_VIEW_ID'))
						{
							$source_url = get_default_alias_for_page($pID, '', $lang);
						}
						else
						{
							$source_url = get_default_alias_for_view($pID, $view_array[$i], $lang, true);
						}

						f_add_permanent_redirect($source_url, '', $pID, $lang, $view_array[$i]);
					}
				}
			}
		}
	}

	function add_folder_permanent_redirect($folderId, $folderNamesArray)
	{
		if(get_config_var('auto_add_redirect_on_page') && $_POST['auto_redirect_add'] == 'true')
		{
			//
			$view_sql 	= 'SELECT id FROM tpl_views';
			$v_res 		= viewSQL($view_sql);

			$view_array 	= array();
			while($v_row = db_sql_fetch_assoc($v_res))
			{
				$view_array[] = $v_row['id'];
			}

			// get folder names before update
			$res_folder = viewSQL('SELECT val, language FROM content WHERE var=\'page_name_\' AND var_id='.sqlValue($folderId));
			while ($row = db_sql_fetch_assoc($res_folder))
			{
				$temp_array[$row['language']] = $row['val'];
			}

			unset($folderNamesArray['general']);

			foreach($folderNamesArray as $lang => $page)
			{
				// if folder was renamed
				if ($page != $temp_array[$lang])
				{
					//get all pages in folder and add redirect for it.
					$res_pages = viewSQL('SELECT id FROM tpl_pages WHERE folder_id='.sqlValue($folderId));
					while ($row = db_sql_fetch_array($res_pages))
					{
						$pageId = $row['id'];

						for($i = 0; $i < sizeof($view_array); $i++)
						{
							if ($view_array[$i] == db_constant('DEFAULT_TPL_VIEW_ID'))
							{
								$source_url = get_default_alias_for_page($pageId, '', $lang);
							}
							else
							{

								$source_url = get_default_alias_for_view($pageId, $view_array[$i], $lang, true);
							}
							f_add_permanent_redirect($source_url, '', $pageId, $lang, $view_array[$i]);
						}
					}
				}
			}
		}
	}

	function prepare_source_url($source_url)
	{
		$source_url = trim($source_url);
		if(strpos($source_url, EE_HTTP) == 0)
		{
			return str_replace(EE_HTTP, '', $source_url);
		}
		// --
		if(preg_match("/(http:\/\/||https:\/\/)?([a-zA-Z0-9_\.-\/\\]+\.[^html]{2,4})/i", $source_url))
		{
			if(strpos($source_url, 'http://') == 0)
			{
				$source_url = str_replace('http://', '', $source_url);
			}
			if(strpos($source_url, 'https://') == 0)
			{				
				$source_url = str_replace('https://', '', $source_url);
			}
		}
		if(strpos($source_url, '/') == 0)
		{
			$source_url = substr($source_url, strpos($source_url, '/')+1);
		}

		return $source_url;
	}

	// objects

	function f_add_permanent_redirect_object($source_url, $target_url=false, $language=false, $tpl_view=false, $object_record_id=false, $object_view=false)
	{
		$ret = false;
		$set = false;

		if ($target_url)
		{
			$set = 'target_url='.sqlValue($target_url);
		}
		elseif ($language && 
			$tpl_view && 
			$object_record_id && 
			$object_view)
		{
			$set =' language='.sqlValue($language).',
				tpl_view='.sqlValue($tpl_view).',
				object_record_id='.sqlValue($object_record_id).',
				object_view='.sqlValue($object_view);

		}

		if ($set)
		{
			$sql = 'INSERT INTO 
					'.EE_PERMANENT_REDIRECT_OBJECT_TABLE.'
				SET
					source_url='.sqlValue($source_url).',
					'.$set;

			$ret = runSQL($sql);
		}

		//add one more permanent_redirect record for original name of page
		if (is_object_in_db($objectRecordId))
		{
			$object_urls = array();
			$alias_rule = str_replace("<%:", "<%:new_", config_var('object_views_rule'));
			$GLOBALS['new_object_name'] = Get_object_name_by_record_id($objectRecordId);
			$GLOBALS['new_object_folder'] = config_var('object_folder', $language);
			$GLOBALS['new_object_view'] = $objectView;
			$GLOBALS['new_object_id']  = $objectRecordId;
			$sql = 'SELECT language_code FROM v_language';
			$res = viewSql($sql);
			if(db_sql_num_rows($res)>0)
			{
				while($row = db_sql_fetch_assoc($res))
				{
					$GLOBALS['new_language'] = $row['language_code'];
					$GLOBALS['new_t_view'] = '{replace}';
					$object_urls[] = str_replace('.{replace}', '', parse2($alias_rule));
					$sql = 'SELECT view_name FROM tpl_views';
					$res2 = viewSql($sql);
					if(db_sql_num_rows($res2)>0)
					{
						while($row2 = db_sql_fetch_assoc($res2))
						{
							$GLOBALS['new_t_view'] = $row2['view_name'];
							$object_urls[] = parse2($alias_rule);
						}
					}
				}
			}
			foreach($object_urls as $source_url)
			{
				runSql('INSERT INTO '.EE_PERMANENT_REDIRECT_OBJECT_TABLE.' SET source_url='.sqlValue($source_url).', '.$set);
			}
		}

		return $ret;
	}

	function f_del_permanent_redirect_object($id=false, $source_url=false, $language=false, $tpl_view=false, $object_record_id=false, $object_view=false)
	{
		$ret 	= false;
		$where 	= false;

		if ($id)
		{
			$where = 'id='.sqlValue($id);
		}
		else if ($source_url)
		{
			$where = 'source_url='.sqlValue($source_url);
		}
		else if (	$language &&
				$tpl_view &&
				$object_record_id &&
				$object_view)
		{
			$where = 'language='.sqlValue($language).'
				  AND
 				  tpl_view='.sqlValue($tpl_view).'
				  AND
				  object_record_id='.sqlValue($object_record_id).'
				  AND
				  object_view='.sqlValue($object_view);
		}

		if ($where)
		{
			$sql = 'DELETE FROM 
					'.EE_PERMANENT_REDIRECT_OBJECT_TABLE.'
				WHERE
					'.$where.'
				LIMIT 1';

			$ret = runSQL($sql);
		}

		return $ret;
	}

	function f_upd_permananet_redirect_object($old_target_url, $new_target_url)
	{
		$ret 	= false;
		//UPDATE permanent_redirect_object p SET target_url='test-1.html' WHERE target_url='test.html'
		$upd_sql = '	UPDATE
					'.EE_PERMANENT_REDIRECT_OBJECT_TABLE.'
				SET
					target_url='.sqlValue($new_target_url).'
				WHERE
					target_url='.sqlValue($old_target_url);

		if (runSQL($upd_sql))
		{
			$ret = f_add_permanent_redirect_object($old_target_url, $new_target_url);
			f_del_permanent_redirect_object(false, $new_target_url);
		}

		return $ret;
	}

	// Remove cycle redirects 
	function regulate_permanent_redirect($page_id)
	{
		$forbidden_ids	= false;
		$forbidden_urls	= get_permanent_redirect_urls($page_id);

		$sql_list = sqlValuesList($forbidden_urls);

		$sql = 'SELECT 
				`id` 
			  FROM 
				`permanent_redirect` 
			 WHERE 
				`source_url` 
			    IN (' . $sql_list . ')';

		$res = viewSQL($sql);

		if (db_sql_num_rows($res))
		{
			while ($row = db_sql_fetch_array($res))
			{
				$forbidden_ids[] = $row['id'];
			}
		}

		if ($forbidden_ids)
		{
			f_del_permanent_redirects($forbidden_ids);
		}
	}
	// get urls form source permanent redirect
	function get_permanent_redirect_urls($page_id)
	{
		global 	$geted_aliases;
		$geted_aliases = array();

		$urls 	= array();
		$views	= array();

		// get array of tpl views
		$sql_views = 'SELECT view_name, view_folder FROM tpl_views';
		$res_views = viewSQL($sql_views);
		if (db_sql_num_rows($res_views))
		{
			$i = 0;
			while ($row = db_sql_fetch_array($res_views))
			{
				$views[$i]['folder'] = $row['view_folder'];
				$views[$i++]['name'] = $row['view_name'];
			}
		}
		// language array
		global $langEncode;
		$language_array = array_keys($langEncode);

		if (is_array($views))
		{
			for ($i = 0; $i < count($views); $i++)
			{
				if ($views[$i]['folder'] == db_constant('DEFAULT_TPL_VIEW_FOLDER'))
				{
					for($j = 0; $j < count($language_array); $j++)
					{
						$href 	= get_default_alias_for_page($page_id, '', $language_array[$j]);
						$urls[] = prepare_source_url($href);
					}
				}
				else
				{
					for($j = 0; $j < count($language_array); $j++)
					{
						$vhref 	= get_default_alias_for_page($page_id, '', $language_array[$j], $views[$i]['name']);
						$urls[] = prepare_source_url($vhref);
					}
				}				
			}
		}
		else
		{
			for($j = 0; $j < count($language_array); $j++)
			{
				$href 	= get_href($page_id, $language_array[$j]);
				$urls[] = prepare_source_url($href);
			}
		}

		return $urls;
	}	


