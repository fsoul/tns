<?php
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'permanent redirect';

//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

       	$popup_height = ($count_of_edit_fields+count($langEncode)+1)*30;
	$popup_height_zip = ($count_of_edit_fields+count($langEncode)+4)*30;
	$popup_scroll = 'true';
	$edit_config_width = 700;
	$config_vars = array (
		array (

		'field_name' => 'auto_add_redirect_on_page',
		'type' => 'checkbox_disable',
		'field_title' => 'Automatically add redirect on page or folder renaming'

		),
		array (

		'field_name' => 'confirm_add_redirect_on_page',
		'type' => 'checkbox',
		'field_title' => 'Confirm about adding url on page or folder renaming'

		),
		array (

		'field_name' => 'auto_add_redirect_on_language',
		'type' => 'checkbox_disable',
		'field_title' => 'Automatically add redirect on language renaming or deleting'

		),

		array (

		'field_name' => 'confirm_add_redirect_on_language',
		'type' => 'checkbox',
		'field_title' => 'Confirm about adding url on language renaming or deleting'

		)

	);


	if (!defined('ADMIN_MENU_ITEM_PERMANENT_REDIRECT')) define('ADMIN_MENU_ITEM_PERMANENT_REDIRECT', 'Administration/Permanent redirect');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_PERMANENT_REDIRECT);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)
	//скрыть столбец
	//$hidden[] = '';
	if (config_var('use_draft_content')==0) $hidden[] = 'in_draft_state';
	// размер поля фильтра в списке
	$size_filter['id'] = 3;

	// тип фильтра
	$type_filter['in_draft_state'] = 'select_DP';
	$hidden = array('page_id', 'lang_code', 't_view');

	// выравнивание
	 $filter_function['edit_date'] = 'DATE_FORMAT( %s, \''.DATETIME_FORMAT_MYSQL_PRINTF.'\')';

	$align['id']='right';
	// стиль столбца
	$grid_col_style['in_draft_state'] = 'text-align:center;width:5px';
	// оформление самого значения в гриде

	/*if(!check_content_access(CA_READ_ONLY))
	{
		foreach ($ar_grid_links as $k=>$v)
			$ar_grid_links[$k] =
			"<a href=\"".EE_HTTP.'index.php?admin_template=yes&t=%'.	
			(array_search('id', $fields)+1).'$s">%'.
			(array_search($k, $fields)+1).'$s</a>';
	}
	$ar_grid_links['in_draft_state'] = '<img border="0" src="'.EE_HTTP.'img/<%%iif:%'.(array_search('in_draft_state',$fields)+1).'$s,Yes,'.
		'draft,<%%iif:<%%:is_draft_file%%>,1,draft,published%%>'.
		'%%>_page.gif">';*/

	// только окно редактирования
	// стиль строки поля формы

	// размер поля


	// доступно только для чтения

	// обязательно для заполнения
	$mandatory=array('source_url');

	// тип поля ввода
	$type['id'] 		= 'string';
	$type['page_id'] 	= 'select_tpl_page';
	$type['url']		= 'url';
	$type['lang_code'] 	= 'select_lang_code';
	$type['target_url']	= 'target_url';
	$type['t_view'] 	= 'select_view';
	$type['source_url']	= 'source_url';

	$caption['target_url'] 	= 'Target page:';
	$caption['page_id'] 	= '<input type="radio" name="open_sat_page" onClick="javascrip:edit_current(\'open_sat_page\'); document.getElementById(\'target_url\').innerHTML = \'\';"><label for="open_sat_page">'.SATELLITE_PAGE.'</label>';
	$caption['url']  	= $op ? '<input type="radio" name="open_url" onClick="javascript:edit_current(\'open_url\')"><label for="open_url">URL</label>' : 'Satelite page';
	$caption['lang_code']	= 'Language';
	$caption['t_view']	= 'View';

	//onblur='check_source_url();';

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// подписи к колонкам списка (grid-а)

/**
 * Подписи к колонкам списка
 *
 * @return string Шаблон заголовка списка
 */
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}
	
	// список (grid)
	function print_list($export='')
	{
		global $default_language;
		global $language;
		
		include('print_list_init_vars_apply_filter.php');

		$sql = 'SELECT * FROM v'.$modul.'_grid' . $where . $order;
		$tot = getsql('count(*) from v'.$modul.'_grid '.$where , 0);

		include('print_list_limit_sql.php');

		$rs = viewsql($sql, 1);

		$s = '';
		$j=0;
		$rows = array();
		while($r = db_sql_fetch_assoc($rs))
		{
			if($r['target_url'] == '')
			{
				if($r['t_view'] == '' || $r['t_view'] == db_constant('DEFAULT_TPL_VIEW_ID'))
				{
					$r['target_url'] = get_href($r['page_id'], $r['lang_code']);
				}
				else
				{
					$r['target_url'] = get_view_href($r['page_id'], $r['t_view'], $r['lang_code']);
				}
			}
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);

			$rows[$j]['id'] 	= $r['id'];

			if(strpos($r['target_url'], 'http://') != 0)
			{
				$rows[$j]['target_url'] = EE_HTTP.$r['target_url'];
			}
			elseif(strpos($r['target_url'], 'https://') != 0)
			{
				$rows[$j]['target_url'] = EE_HTTP.$r['target_url'];
			}
			else
			{
				$rows[$j]['target_url'] = $r['target_url'];
			}
			$j++;
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}


/**
 * Вывод полей списка
 *
 * @return string Строка списка
 */
	function print_fields()
	{
		return include('print_fields.php');
	}

/**
 * Сохранение записи
 *
 * @return string Шаблон редактирования записи
 */
	function save()
	{
		global $modul, $op;
		global $pageTitle, $PageName, $error, $language;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit;
		global $__new_page_name;
		global $default_language;
		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');
		//
		if (post('refresh'))
		{
			unset($field_values);

                        $check_source_url = check_source_url();

			if($check_source_url < 0)
			{
				
				if($check_source_url == -1)
				{
					$error['source_url'] = 'Source URL could not be empty';
				}
				elseif($check_source_url == -2 && empty($edit))
				{
					$error['source_url'] = 'Warning: such URL already configered for another page. Please setup another URL';
				}
				elseif($check_source_url == -3)
				{
					$error['source_url'] = 'Source URL could not be applied for existed page';
				}
				elseif($check_source_url == -4)
				{
					$error['source_url'] = 'Incorrect Source URL. Please enter Source URL as example. Example: pagename_language.html';
				}
			}

			if(!empty($edit))
			{
				$field_values['id'] = $_POST['id'];			
			}

			$field_values['source_url'] = $_POST['source_url'];

			if(isset($_POST['open_sat_page']) && $_POST['open_sat_page'] == 'on')
			{
				$field_values['target_url'] 	= '';
				$field_values['page_id'] 	= $_POST['satelit'];
				$field_values['lang_code'] 	= $_POST['lang_code'];

				if (!isset($_POST['tpl_view']))
				{
					$field_values['t_view'] = db_constant('DEFAULT_TPL_VIEW_FOLDER');
				}
				else
				{
					$field_values['t_view'] = $_POST['tpl_view'];
				}
			}
			else
			{
				$field_values['target_url'] 	= $_POST['url'];

				$field_values['page_id'] 	= '';
				$field_values['lang_code'] 	= '';
				$field_values['t_view'] 	= '';				

			}
			if (count($error)==0)
			{
				if(empty($edit))
				{
					$db_function = 'f_add'.$modul;
				}
		        	else
				{
					$db_function = 'f_upd'.$modul;
				}

				$res = RunNonSQLFunction($db_function, $field_values);

				if ($res < 0)
				{
					$error['id'] = 'Such source URL already exists';
				}
				else
				{
					if (post('save_add_more'))
					{
						header ('Location: '.$modul.'.php?op=3&added='.$res);
						exit;
					}
					else
					{ 
						close_popup('yes');
					}
				}
			}
		}
		else
		{
			global $i_target_url;

			if(strpos($target_url, 'http://') !== 0)
			{
				$i_target_url = EE_HTTP.$target_url;
			}
			elseif(strpos(target_url, 'https://') !== 0)			
			{			
				$i_target_url = EE_HTTP.$target_url;
			}
		}
		return parse($modul.'/edit');
	}

/**
 * Удаление записи
 *
 * @return none
 */
	function del()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del'.$modul, array($del));

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
				'f_del'.$modul),
			'php_ini' => array (),
			'db_tables' => array (
				'permanent_redirect'),
			'db_viewes' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit'),
			'run_function'  => array (
				'check_dublicated_source_url',
				'check_correct_target_url',
				'check_source_url_mapped_to_existed_page')
		);

		return parse_self_test($ar_self_check);
	}

	function print_preview_source($id)
	{
		$ret = str_replace("\r"," ",js_clear(parse($id)));
		$ret = trim(str_replace("\n"," ",$ret));
		return $ret;
	}

	// проверяем на наличие дублирования source_url'ов
	function check_dublicated_source_url()
	{
		$sql = 'SELECT COUNT( DISTINCT source_url ) AS dis_val, COUNT( source_url ) AS val FROM permanent_redirect';
		$res = viewSQL($sql);
		$row = db_sql_fetch_assoc($res);
		if($row['dis_val'] == $row['val'])
		{
			return true;
		}
		return false;
	}

	// проверяем правильность всех target URL'ов
	function check_correct_target_url()
	{
		$sql = 'SELECT target_url FROM permanent_redirect';
		$res = viewSQL($sql);
		while($row = db_sql_fetch_assoc($res))
		{
			if(check_target_url($row['target_url']) && $row['target_url'] != '')
			{
				return false;
			}
		}
		return true;
	}

	// функция которая проверяет не ссылаються ли source_url на доступные страницы (т.е. те которые есть в satelite pages)
	// проверка правильности source_url
	function check_source_url_mapped_to_existed_page()
	{
		$sql = 'SELECT source_url FROM permanent_redirect';
		$res = viewSQL($sql);
		while($row = db_sql_fetch_assoc($res))
		{
			if( parse_system_alias($row['source_url'], config_var('alias_rule'), array('page_folder' => '([\/0-9a-zA-Z_%\.-]+)')) ||
			    parse_system_alias($row['source_url'], config_var('object_alias_rule')) || 
			    parse_system_alias($row['source_url'], config_var('views_rule')))
			{
				return false;
			}
		}
		
		return true;
	}

//**********************************************************************************************************************

	function check_source_url()
	{
		$source_url = prepare_source_url($_POST['source_url']);

		if(strpos($source_url, '/') === 0)
		{
			$source_url = substr($source_url, 1);
		}

		if(empty($source_url))
		{
			return -1;
		}
		elseif(getField('SELECT COUNT(*) FROM permanent_redirect WHERE source_url='.sqlValue($source_url)) > 0)
		{
			return -2;
		}
		elseif( parse_system_alias($source_url, config_var('alias_rule'), array('page_folder' => '([\/0-9a-zA-Z_%\.-]+)')) ||
			parse_system_alias($source_url, config_var('object_alias_rule')) || 
			parse_system_alias($source_url, config_var('views_rule')))
		{			
			return -3;
		}
		/*
		elseif(strpos($source_url, '.htm') === false && strpos($source_url, '.xml') === false)
		{
			return -4;
		}
		*/
		else
		{
			return 0;
		}
	}

	function check_target_url($i_target_url  = false)
	{
		$target_url = $i_target_url ? $i_target_url : $_POST['target_url'];
		$target_url = prepare_source_url($target_url);

		if(empty($target_url))
		{
			return -1;
		}
		elseif( !parse_system_alias($target_url, config_var('alias_rule'), array('page_folder' => '([\/0-9a-zA-Z_%\.-]+)')) &&
			!parse_system_alias($target_url, config_var('object_alias_rule')) && 
			!parse_system_alias($target_url, config_var('views_rule')) &&
			!is_map_url($target_url)
		)
		{
			return -2;
		}
		return 0;
	}

	function  get_target_url()
	{
		if (!isset($_POST['view']) || $_POST['view'] == db_constant('DEFAULT_TPL_VIEW_ID'))
		{
			return get_href($_POST['page'], $_POST['language']);
		}                      	
		else
		{
			return get_view_href($_POST['page'], $_POST['view'], $_POST['language']);
		}
	}

	function edit_config()
	{
		return include('print_edit_config.php');
	}
	function get_modul_list($modul)
	{
		return include('get_yui_list.php');
	}
	function print_yui_captions($full='no')
	{
		return include('print_yui_captions.php');
	}

//********************************************************************
	switch($op)
	{
		default:
		case '0': echo parse($modul.'/list');break;
		case '1':
			if(check_content_access(CA_READ_ONLY))
			{
				header($url);
				break;
			}
			echo save();
			break;
		case '2':
			if(check_content_access(CA_READ_ONLY))
			{
				header($url);
				break;
			}
			del();
			break;
		case '3':
			if(check_content_access(CA_READ_ONLY))
			{
				header($url);
				break;
			}
			echo save();
			break;

		case 'del_sel_items':
			if(check_content_access(CA_READ_ONLY))
			{
				header($url);
				break;
			}
			del_selected_items($modul);
			echo parse($modul.'/list');
			break;

		case 'config':
			echo edit_config();
			break;

		case 'check_source_url': print check_source_url();  break;
		case 'check_target_url': print check_target_url(); break;
		case 'get_target_url': print get_target_url(); break;

		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>