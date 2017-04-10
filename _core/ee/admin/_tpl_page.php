<?
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'page';
//********************************************************************
	include_once('../lib.php');
	
	include('url_if_back.php');

	$popup_height = ($count_of_edit_fields+count($langEncode)+4)*30;
	$popup_scroll = true;
	$edit_config_width = 700;
	$config_vars = array (
		array (

		'field_name' => 'use_draft_content',
		'type' => 'checkbox_alert'

		),

		/*9083*/
		array (

		'field_name' => 'ee_cache_html',
		'type' => 'checkbox_cache_alert'

		),
		array (

		'field_name' => 'google_analytics',
		'size' => '70',
		'type' => 'textarea'

		),

		array (

		'field_name' => 'alias_rule',
		'size' => '70',
		'field_title' => 'Default alias rule'

		),
		array (

		'field_name' => 'antispam_security',
		'type' => 'checkbox',
		'field_title' => 'Anti-Spam Security'

		)

	);

	if (!defined('ADMIN_MENU_ITEM_TPL_PAGE')) define('ADMIN_MENU_ITEM_TPL_PAGE', 'Content|300/Satellite pages');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_TPL_PAGE);
	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');
	
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)

	//скрыть столбец
	$hidden = array('is_default', 'edit_date', 'edit_date_draft');
	if (config_var('use_draft_content')==0)
	{
		$hidden[] = 'in_draft_state';
		$hidden[] = 'edit_user';
	}
 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра
	$type_filter['default_page'] = 'select_Y';
	$type_filter['for_search'] = 'select_Y';
	$type_filter['in_draft_state'] = 'select_DP';
	$type_filter['language'] = 'select_distinct';

	$type_filter['locked'] = $type_filter['cachable'] = 'select_YN';

	// выравнивание
	$align['id']='right';
	// стиль столбца
	$grid_col_style['default_page'] = 'width:5px';
	$grid_col_style['in_draft_state'] = 'text-align:center;width:5px';
	$grid_col_style['locked'] = 'text-align:center;width:5px';
	// оформление самого значения в гриде
	if(!check_content_access(CA_READ_ONLY))
	{
		$ar_grid_links['id']='<a href="'.EE_HTTP.'index.php?t='.
		'%'.(array_search('id',$fields)+1).'$s'.
		'&admin_template=yes">'.
		'%'.(array_search('id',$fields)+1).'$s'.
		'</a>';

		$ar_grid_links['page_name']='<a href="'.EE_HTTP.'index.php?t='.
		'<%%iif:%'.(array_search('folder',$fields)+1).'$s,/,,<%%substr:%'.(array_search('folder',$fields)+1).'$s,1%%>/%%>'.
		'%'.(array_search('page_name',$fields)+1).'$s'.
		'&admin_template=yes">'.
		'%'.(array_search('page_name',$fields)+1).'$s'.
		'</a>'.
		'<%%iif:%'.(array_search('is_default',$fields)+1).'$s,1, ( default )%%>';
	}

	$ar_grid_links['in_draft_state'] = '<img border="0" src="'.EE_HTTP.'img/'.
		'<%%iif:%'.(array_search('in_draft_state',$fields)+1).'$s,Yes,draft,published%%>'.
		'_page.gif" onmouseout="hideddrivetip()" onmouseover="ddrivetip(\''.
		'<%%iif:%'.(array_search('in_draft_state',$fields)+1).'$s,Yes,'.
		'<%%iif:%'.(array_search('edit_date_draft',$fields)+1).'$s,,,Last edited at %'.(array_search('edit_date_draft',$fields)+1).'$s%%>,'.
		'<%%iif:%'.(array_search('edit_date',$fields)+1).'$s,,,Published at %'.(array_search('edit_date',$fields)+1).'$s%%>%%> '.
		'<%%iif:%'.(array_search('edit_user',$fields)+1).'$s,,,by %'.(array_search('edit_user',$fields)+1).'$s%%>'.
		'\')"/>';

	$ar_grid_links['locked'] = '<%%iif:%'.(array_search('locked',$fields)+1).'$s,Yes,<img src="'.EE_HTTP.'img/lock.gif"/>%%>';
	// только окно редактирования
	// стиль строки поля формы

	// размер поля

	// список полей по группам /* 8671  */
	global $fields_group;
	global $fields_group_caption;

	$fields_group['general'] = array('id',
 					 'page_name',
					 'extension',
					 'page_description',
					 'is_default', 
					 'template',
					 'folder',
					 'search',
					 'page_locked',
					 'cachable');

	$fields_group['redirect_links'] = array('redirect_links');

	$fields_group_caption['general'] 	= 'General';
	$fields_group_caption['redirect_links'] = 'Redirect links';

	//include('print_popup_header.php');

	//print ucfirst(str_replace('_', ' ', 'redirect_links')); 
	//exit;

	// доступно только для чтения

	// обязательно для заполнения
	$mandatory=array('page_name', 'template');
	// тип поля ввода
	$type['id'] 		= "string";
	$type['is_default'] 	= "checkbox";
	$type['template'] 	= "select_tpl_file";
	$type['folder'] 	= "select_tpl_folder";
	$type['search'] 	= "checkbox";
	$type['page_locked'] 	= "checkbox";
	$type['edit_date'] 	= "string_edit_date";
	$type['page_name'] 	= "page_name";
	$type['redirect_links'] = "select_redirect_link";
	$type['cachable'] 	= "checkbox";
	$type['extension']	= 'select_extension';

	// title полей
	$caption['search'] = "Index / (no Index)";

	$form_row_type['edit_date'] = 'nocaption';
	$form_row_type['edit_date_draft'] = 'none';
	$form_row_type['edit_user'] = 'none';
	$form_row_type['in_draft_state'] = 'none';

	$caption['in_draft_state'] = 'Status';

	global $viewArray;
	$i_sql = 'SELECT view_name, icon FROM v_tpl_views';
	$i_rs = viewsql($i_sql, 0);
	$ii = 0;
	while($row = db_sql_fetch_assoc($i_rs))
	{
		$viewArray[$ii]['view_name'] = $row['view_name'];
		$viewArray[$ii]['icon'] = $row['icon'];
		$ii++;
	}

	//$check_pattern['page_name'] = array('^[a-zA-Z_][<a-zA-Z0-9_-]*$', 'Illegal characters in page name');
	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	//
	function print_popup_header()
	{
		return include('print_popup_header.php');
	}

	//
	function print_fields_by_group()
	{
		return include('print_fields_by_group.php');
	}

	// список (grid)
	function print_list($export='')
	{
		global $language;
		include('print_list_init_vars_apply_filter.php');

		$sql = 'SELECT * from v'.$modul.'_grid' . $where . ' AND language = ' . sqlValue($language) . ' ' . $order;
		$tot = getsql('count(*) from v'.$modul.'_grid '.$where . ' AND language = ' . sqlValue($language), 0);

                include('print_list_limit_sql.php');

		$rs = viewsql($sql, 0);
		$s = '';
		$j=0;
		$rows = array();
		while($r=db_sql_fetch_assoc($rs))
		{
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
				//2 field of Page Description
				if($i == 2)
					$row_field[$i]['field_value'] = htmlspecialchars($row_field[2]['field_value']);
			}
			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
			$rows[$j]['id'] = $r['id'];
			$rows[$j]['status'] = $r['in_draft_state'];
			$rows[$j]['edit_date'] = $r['edit_date'];
			$rows[$j]['edit_date_draft'] = $r['edit_date_draft'];
			$rows[$j]['edit_user'] = $r['edit_user'];
			if(check_cache_enabled())
			{
				$cache_content = get_content_of_current_cache(get_full_name_cache_from_aliase(get_default_aliase_for_page($rows[$j]['id'])), '', true);

				if($cache_content!==false)
				{
					$delete_all_cache_image = 1;
					$rows[$j]['cache_status'] = 'Yes';
				}
				else
				{
				   	$rows[$j]['cache_status'] = '';
				}

			}
			$rows[$j]['copy_type'] = 'Page';
			$rows[$j++]['name'] = SaveQuotes($r['page_name']);
		}

		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');         
		return $s;
	}


	// список полей в окне редактирования
	function print_fields()
	{
		global $fields;

		return include('print_fields.php');
	}

	// добавление/сохранение записи
	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory, $default_language;
		global $edit;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');

		include ('prepare_multi_lang_page_name.php');

		if (post('refresh'))
		{
			global $__new_page_name;
			$__new_page_name = array();
			foreach ($__lang_list as $__lang)
			{
				$__field_name = 'page_name_' . $__lang;
				$__new_page_name[$__lang] = $_POST[$__field_name];
			}
			$field_values['page_name'] = '__new_page_name';
			if ($page_name_general == '')
			{
			 	if (isset($edit) && !empty($edit))
					$page_name_general = $edit;
				else
					$page_name_general = '__replace_after_insert__';
			}
			$__new_page_name['general'] = $page_name_general;
			if ($page_name_general != '' && $__new_page_name[$default_language] != '' && isset($error['page_name']))
				unset($error['page_name']);
			else
			{
				vdump($page_name_general, '$page_name_general');
				vdump($__new_page_name, '$__new_page_name');
				vdump($error,'$error');
				vdump($__new_page_name[$default_language], '$__new_page_name[$default_language]');
				vdump($default_language, '$default_language');
			}
			if (count($error)==0)
			{
				if (empty($edit)) // New object
				{
					unset($field_values['id']);
					$db_function = 'f_add'.$modul;
					$field_values['user_id'] = $_SESSION['UserId'];
				}
				else
				{
					$db_function = 'f_upd'.$modul;
				}
				                                                      
				$res = RunNonSQLFunction($db_function, $field_values);

				if ($res < 0)
				{
					$error['id'] = 'Page already exists';
				}
				else
				{
					if (post('save_add_more'))
					{
						$prev_next = (post('prev_next'))?'&prev_next=1':'';
						$folder_id = !empty($_GET['folder'])?'&folder='.$_GET['folder']:'';
						$next_type = !empty($_POST['next_type'])?$_POST['next_type']:'_tpl_page';
						header ('Location: '.$next_type.'.php?op=3&added='.$res.$folder_id.$prev_next);
						exit;
					} 
					else if(post('previous') || post('next'))
					{
						$passed_item = 'next_item';
						$passed_type = post('next_type');
						if(post('previous'))
						{
							$passed_item = 'previous_item';
							$passed_type = post('previous_type');
						}
						header ('Location: '.$passed_type.'.php?op=1&edit='.post($passed_item).'&admin_template=yes&prev_next=1');
						exit;
					}
					else close_popup('yes');
				}
			}
		}
		return parse($modul.'/edit');
	}

	// удаление
	function del()
	{

		global $del, $modul, $url;

		RunNonSQLFunction('f_del'.$modul, array($del));

		header($url);
	}
	
	//копирование страницы
	function copy_page()
	{

		global $copy, $modul, $url, $type;

		RunNonSQLFunction('f_copy'.$modul, array($copy, $type));

		header($url);
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'f_add'.$modul,
				'f_upd'.$modul,
				'f_del'.$modul,
				'publish_cms_on_page',
				'publish_all_cms',
				'mysql_query'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit',
				'v_tpl_file',
				'v_tpl_folder',
				'tpl_views'
			),
			'db_funcs'  => array (),
			'config_vars' => $GLOBALS['config_vars'],
			'custom_query' => array(
				array('query'=>'SELECT COUNT(*) FROM tpl_pages WHERE default_page="1"', 'result' => '1', 'message'=>'1 default page must be defined')
			),

			'dir_exists' => array(
				EE_CACHE_DIR,
			),

			'dir_attributes' => array(
				EE_CACHE_DIR => EE_DEFAULT_DIR_MODE,
			),

			'ftp_dir_exists' => array(
				EE_IMG_PATH,
				EE_MEDIA_PATH,
			),

			'ftp_dir_attributes' => array(
				EE_IMG_PATH => EE_DEFAULT_DIR_MODE,
				EE_MEDIA_PATH => EE_DEFAULT_DIR_MODE,
			)
		);


		return parse_self_test($ar_self_check);
	}

	function edit_config()
	{
		/*9083*/

		if (	post('refresh') &&

			(config_var('use_draft_content') != $_POST['use_draft_content']
			 ||
			 config_var('ee_cache_html') != $_POST['ee_cache_html']
			)
		)
		{
			if ($_POST['use_draft_content'] == '1')
			{
				revert_all_cms();
			}
			else
			{
				publish_all_cms();
			}

			if ($_POST['ee_cache_html'] != '1')
			{
				delete_cache();
			}
			// delete sitemap.xml cache
			delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
		}

		return include('print_edit_config.php');
	}

	function change_lock_state($t)
	{
		RunSQL('UPDATE tpl_pages SET is_locked = 1-is_locked WHERE id='.sqlValue($t));
	}

	function refresh_page_date()
	{
		$refresh_date_sql = 'UPDATE tpl_pages SET edit_date = NOW() WHERE id IN ';

		$pages=array();

		foreach(post('selected_items') as $v)
		{
			$pages[] = intval($v);
		}
		$refresh_date_sql .= '('.implode (',', $pages).')';

		return runSQL($refresh_date_sql.$refreshing_pages);
	}
	
	function copy_sel_items(){
		if(array_key_exists('selected_items', $_POST) && count($_POST['selected_items']) > 0)
		{            
			f_copy_tpl_pages($_POST['selected_items']);
		}
	}

	function get_view_page_row()
	{
		global $viewArray, $modul;
		$html = '';
		for($i = 0; $i < count($viewArray); $i++)
		{
			$html .= parse_array_to_html($viewArray[$i],'templates/'.$modul.'/views_row');
		}
		return $html;
	}
//--------------------------------------------------------------------------------------------------------//
	// получение target URL
	function get_target_url($page_id, $lang_code, $t_view)
	{
		if($view =='' || $view == 'html')
		{
			return get_href($page_id, $lang_code);
		}                      	
		else
		{
			return get_view_href($page_id, $t_view, $lang_code);
		}
	}
	// список редиректов
	function get_redirect_list()
	{
		global $modul, $edit;
		return parse_sql_to_html('SELECT id AS redirect_id, source_url, page_id, lang_code, t_view, (SELECT id FROM tpl_views WHERE view_folder="html") AS t_view_default FROM permanent_redirect WHERE page_id = '.sqlValue($edit), 'templates/'.$modul.'/permanent_redirect_list_row');
	}
	// получаем данные для формы редактирования
	function get_edit_redirect_data($id)
	{
		$sql = 'SELECT source_url, page_id, lang_code, t_view FROM permanent_redirect WHERE id='.sqlValue($id).' LIMIT 0, 1';
		$res = viewSQL($sql);

		$row = db_sql_fetch_assoc($res);

		$row['target_url'] = get_target_url($row['page_id'], $row['lang_code'], $row['t_view']);
		return '{
				"source_url" : "'.$row['source_url'].'", 
				"target_url" : "'.$row['target_url'].'",
				"page_id" : "'.$row['page_id'].'",
				"lang_code" : "'.$row['lang_code'].'",
				"t_view" : "'.$row['t_view'].'"
			}';

	}
	//
	function get_extension_list($selected)
	{
		global $modul;

		$array 			= unserialize(EE_FILE_TYPES);

		$i = 0;
		foreach($array['page'] as $key => $val)
		{
			$array_to_parse[$i]['content_type'] = $key;
			$array_to_parse[$i]['selected'] = $selected;
			$i++;
		}

		return parse_array_to_html($array_to_parse, $modul.'/extension_row');
	}
	//********************************************************************
	switch($op)
	{
		case 'lock':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT, CA_PUBLISH), $t))
			{
				header($url);
				break;
			}
			change_lock_state($t);
			break;

		case 'publish':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT), $t))
			{
				header($url);
				break;
			}
			publish_cms_on_page($t);
			delete_cache($t);
			sitemapindex_files_delete();
			if (get('media'))
			{
				publish_media_on_page($t);
			}
			header($url);
			break;

		case 'revert':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT), $t))
			{
				header($url);
				break;
			}
			revert_cms_on_page($t);
			if (get('media'))
			{
				revert_media_on_page($t);
			}
			header($url);
			break;

		case 'publish_all':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT)))
			{
				header($url);
				break;
			}
			publish_all_cms();
			delete_cache();
			sitemapindex_files_delete();
			header($url);
			break;

		case 'publish_common':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT)))
			{
				header($url);
				break;
			}
			publish_common_cms();
			delete_cache();
			sitemapindex_files_delete();
			header($url);
			break;

		case 'revert_all':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT)))
			{
				header($url);
				break;
			}
			revert_all_cms();
			header($url);
			break;

		case 'revert_common':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT)))
			{
				header($url);
				break;
			}
			revert_common_cms();
			header($url);
			break;

		case 'delete_all_cache':
			if(check_content_access(CA_READ_ONLY, CA_EDIT, CA_PUBLISH))
			{
				header($url);
				break;
			}
			delete_cache();
			header($url);
			break;

		case 'delete_page_cache_for_all_lng':
			if(check_content_access(CA_READ_ONLY, CA_EDIT, CA_PUBLISH, $t))
			{
				header($url);
				break;
			}
			delete_cache($t);
			header($url);
			break;

		case 'refresh_page_date':
			if(check_content_access(CA_READ_ONLY, CA_EDIT, CA_PUBLISH))
			{
				header($url);
				break;
			}
			refresh_page_date();
			header($url);
			break;

		//case 'delete_page_cache':
		//	delete_cache($t, $language);
		//	header($url);
		//	break;

		default:

		case '0':
			echo parse($modul.'/list');
			break;

		case '1':
			if(check_content_access_by_arr(array(CA_READ_ONLY), $edit))
			{
				header($url);
				break;
			}
			delete_cache($edit);
			sitemapindex_files_delete();
			echo save();
			break;

		case '2':
			if(check_content_access_by_arr(array(CA_READ_ONLY), $edit))
			{
				header($url);
				break;
			}
			del();
			delete_cache($edit);
			sitemapindex_files_delete();
			break;

		case '3':
			if(check_content_access_by_arr(array(CA_READ_ONLY), $edit))
			{
				header($url);
				break;
			}
			delete_cache($edit);
			sitemapindex_files_delete();
			echo save();
			break;

		case 'copy':
			if(check_content_access_by_arr(array(CA_READ_ONLY, CA_EDIT, CA_PUBLISH), $copy))
			{
				header($url);
				break;
			}
			copy_page();
			sitemapindex_files_delete();
			break;

		case 'copy_sel_items':
			copy_sel_items();
			sitemapindex_files_delete();
			echo parse($modul.'/list');
			break;

		case 'del_sel_items':
			del_selected_items($modul);
			sitemapindex_files_delete();
			echo parse($modul.'/list');
			break;

		case 'rows_on_page':
			rows_on_page();
			break;

		case 'self_test':
			echo print_self_test();
			break;

		case 'config':
			echo edit_config();
			break;

		case 'export_excel':
			header( 'Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
			echo parse('export_excel');

		//------------------------------- AJAX SECTION ----------------------------------//
		case 'get_edit_redirect_data':
			global $redirect_id;
			echo get_edit_redirect_data($redirect_id);
			break;

		case 'upd_redirect':
			echo f_upd_permanent_redirect($id, $source_url, $target_url, $page_id, $lang_code, $view);
			break;

		case 'add_redirect':
			echo f_add_permanent_redirect($source_url, $target_url, $page_id, $lang_code, $view);
			break;

		case 'delete_redirect':
			echo f_del_permanent_redirect($item);
			break;

		case 'delete_selected_items':
			echo f_del_permanent_redirects(explode(';', $items));
			break;

		case 'get_redirect_list':
			echo get_redirect_list();
			break;

		case 'is_tpl_cachable':
			echo is_tpl_cachable($_POST['tpl_id']);
			break;
		//-------------------------------------------------------------------------------//
	}

?>