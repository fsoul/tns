<?php
		global $language, $sort_function;
		$sortBy = (isset($_GET['sort']) ? $_GET['sort'] : 'id');
		$sortDir = (isset($_GET['dir']) ? $_GET['dir'] : 'ASC');
		$startIndex = (isset($_GET['startIndex']) ? $_GET['startIndex'] : 0);
		$rowsPerPage = (isset($_GET['results']) ? $_GET['results'] : 25);
		//для модулей _seo, _object_seo, _alt_tags запрос формируется в модуле - объявляем глобально чтобы иметь к нему доступ
		if ($modul == '_seo' || $modul == '_object_seo' || $modul == '_alt_tags')
		{
			global $sql, $meta_sql, $page_name_alias;
		}
		elseif ($modul == '_styles')
		{
			global $style_text;
		}
		elseif ($modul == '_news')
		{
			global $sql;
			$filtered_news_view = '(SELECT * FROM v'.$modul.'_grid '.($GLOBALS["channel_id"]?'WHERE CHANNEL_ID = "'.$GLOBALS["channel_id"].'"':'').') as q';
			$sql = 'SELECT * from '.$filtered_news_view;
		}
		include('print_list_init_vars_apply_filter.php');
		if ($modul == '_object_seo' || $modul == '_seo' || $modul == '_alt_tags')
		{
			$tot = db_sql_num_rows(viewsql($sql, 0));
		}
		elseif ($modul == '_tpl_page')
		{
			$sql .= ' AND language = ' . sqlValue($language);
			$tot = getsql('count(*) from v'.$modul.'_grid '.$where . ' AND language = ' . sqlValue($language), 0);
		}
		elseif ($modul == '_news')
		{
			$filtered_news_view = '(SELECT * FROM v'.$modul.'_grid '.($GLOBALS["channel_id"]?'WHERE CHANNEL_ID = "'.$GLOBALS["channel_id"].'"':'').') as q';
			$sql = 'SELECT * from '.$filtered_news_view;
			$tot = getsql('count(*) from '.$filtered_news_view.$where, 0);
		}
		else
		{
			$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);
		}

		$sql .= ' ORDER BY '.sprintf($sort_function[$sortBy],$sortBy).' '.$sortDir.' LIMIT '.$startIndex.','.$rowsPerPage;
		
		$rs = viewsql($sql, 1);
		$j=0;
		//$cell = array();
		//$needle_array = array("\r\n",PHP_EOL,"\n");
		//$replace_array = array('','','<br/>');
		if (db_sql_num_rows($rs) > 0)
		{
		while ($rows = db_sql_fetch_row($rs))
		{
			//$cells = array();
			if ($modul == '_object_seo' || $modul == '_seo')
			{
				list($lang_code) = db_sql_fetch_row(ViewSQL("SELECT language_code FROM v_language WHERE language_code='".$rows[array_search(($modul == '_seo' ? 'language_name' : 'language'),$fields)]."'",0));
			}

			if ($modul == '_permanent_redirect')
			{
				if ($rows[array_search('target_url',$fields)] == '')
				{
					if ($rows[array_search('t_view',$fields)] == '' || $rows[array_search('t_view',$fields)] == db_constant('DEFAULT_TPL_VIEW_ID'))
					{
						$rows[array_search('target_url',$fields)] = get_href($rows[array_search('page_id',$fields)], $rows[array_search('lang_code',$fields)]);
					}
					else
					{
						$rows[array_search('target_url',$fields)] = get_view_href($rows[array_search('page_id',$fields)], $rows[array_search('t_view',$fields)], $rows[array_search('lang_code',$fields)]);
					}
				}
			}

			for ($i=0; $i<count($fields); $i++)
			{
				if (in_array($fields[$i],$hidden))
				{
					continue;
				}
				if ($modul == '_styles' && $fields[$i] == 'sample_text')
				{
					$style_text = '';
					foreach (unserialize($rows[$i]) as $k=>$v)
					{
						$style_text .= ' '.$k.': '.$v.';';
					}
				}

				if ($modul == '_object_seo' || $modul == '_seo')
				{
					$ret = str_replace("&amp;","&",$rows[$i]);
	
					$array = array(
					        'value'		=> $ret,
						'fieldname' 	=> $fields[$i],
						'lang_code'	=> $lang_code,
						'record_id'	=> $rows[0],
						'tpl'		=> $rows[3],
							'ent_value'	=> htmlentities($rows[$i], ENT_QUOTES, 'UTF-8')
					);

					$cell_array[$j][$fields[$i]] = parse2(vsprintf($ar_grid_links[$fields[$i]], $array));
					unset($array);
				}
				else
				{
					$cell_array[$j][$fields[$i]] = parse2(vsprintf($ar_grid_links[$fields[$i]], $rows));
				}
			}

			if ($modul == '_dns')
			{
				$isCDN = is_cdn_server($rows[0]);

				if ($isCDN == 1)
				{
					$cell_array[$j]['dns_cdn_server'] = getField('SELECT GROUP_CONCAT(dns SEPARATOR \', \') FROM dns WHERE cdn_server='.sqlValue($rows[0]));
				}
				else
				{
					$cell_array[$j]['dns_cdn_server'] = 0;
				}
			}

			if ($modul == '_user')
			{
				$cell_array[$j]['modules_list'] = (int)($rows[array_search('role',$fields)] == POWERUSER);
				$cell_array[$j]['folder_access'] = (int)($rows[array_search('role',$fields)] == POWERUSER);
			}
			if ($modul == '_tpl_folder')
			{
				$cell_array[$j]['folder_access'] = 1;
			}
			if (
				($modul == '_lang' && getField('SELECT default_language FROM v_language WHERE language_code=\''.$rows[0].'\'') == 1)
				||
				($modul == '_tpl_file' && getField('SELECT COUNT(id) FROM tpl_pages WHERE tpl_id="'.$rows[0].'"') > 0)
				||
				($modul == '_tpl_folder' && $rows[array_search('items_count',$fields)] > 0)
			)
			{
				$cell_array[$j]['del'] = 0;
				$cell_array[$j]['checkbox'] = 0;
			}
			elseif ($modul != '_object_seo' && $modul != '_seo')
			{
				$cell_array[$j]['del'] = 1;
				$cell_array[$j]['checkbox'] = 1;
			}
			elseif ($modul == '_object_seo')
			{
				$cell_array[$j]['obj_link'] = get_alias_for_object($rows[0],$rows[3],'','',$rows[4]);
				$cell_array[$j]['seo_preview'] = str_replace('"','&amp;quot;',preview_page_meta_tags($rows[0],$rows[4],true));
			}
			elseif ($modul == '_seo')
			{
				$cell_array[$j]['edit'] = str_replace('"','&amp;quot;',preview_page_meta_tags($rows[0],$rows[2]));
			}

			/*
			 * Disable delete button for default view
			 * and for used in permanent_redirect views
			 * bug_id=11478
			 */
			if ($modul == '_tpl_views')
			{
				$error_message = '';

				if (db_constant('DEFAULT_TPL_VIEW_ID') == $rows[0])
				{
					$error_message = cons('Default view can not be deleted');
				}
				elseif (getField('
                                          SELECT
                                                 COUNT(*)
                                            FROM
                                                 permanent_redirect
                                           WHERE
                                                 t_view = '.sqlValue($rows[0])
					)
				)
				{
					$error_message = cons('Used view can not be deleted');
				}

				$cell_array[$j]['del'] = array((strlen($error_message)==0), $error_message);
			}


			if ($modul == '_tpl_page' && check_content_access(CA_READ_ONLY,'','',$rows[0]) != '')
			{
				$cell_array[$j]['edit'] = 0;
			}
			if ($modul == '_media')
			{
				$media_image = get_media_file_by_id($rows[0]);
				if ($media_image == '')
				{
					$cell_array[$j]['image_preview'] = 0;
				}
				else
				{
					$cell_array[$j]['image_preview'] = $media_image;
				}
			}

			if ($modul == '_object_content')
			{
				$cell_array[$j++]['hidden_id'] = $rows[0].':'.$rows[1].':'.$rows[array_search('language',$fields)];
			}
			else
			{
				$cell_array[$j++]['hidden_id'] = $rows[0];
			}
		}//end while
		}//end if
		$pages_return['recordsReturned'] = count($cell_array);
		$pages_return['totalRecords'] = (int)$tot;
		$pages_return['startIndex'] = (int)$startIndex;
		$pages_return['sort'] = $sortBy;
		$pages_return['dir'] = $sortDir;
		$pages_return['pageSize'] = (int)$rowsPerPage;
		$pages_return['records'] = $cell_array;

		return json_encode($pages_return);


?>