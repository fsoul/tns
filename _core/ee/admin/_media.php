<?
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'media';

//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

       	$popup_height = ($count_of_edit_fields+count($langEncode)+1)*30;
	$popup_height_zip = ($count_of_edit_fields+count($langEncode)+4)*30;
	$popup_scroll = '0';

	if (!defined('ADMIN_MENU_ITEM_MEDIA')) define('ADMIN_MENU_ITEM_MEDIA', 'Resources/Media/Media files');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_MEDIA);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)
	//скрыть столбец
	$hidden[] = 'language';
	if (config_var('use_draft_content')==0) $hidden[] = 'in_draft_state';
	// размер поля фильтра в списке
	$size_filter['id'] = 3;

	// тип фильтра
	$type_filter['in_draft_state'] = 'select_DP';
	$type_filter['cachable'] = 'select_YN';

	// выравнивание
	 $filter_function['edit_date'] = 'DATE_FORMAT( %s, \''.DATETIME_FORMAT_MYSQL_PRINTF.'\')';

	$align['id']='right';
	// стиль столбца
	$grid_col_style['in_draft_state'] = 'text-align:center;width:5px';
	// оформление самого значения в гриде

	if(!check_content_access(CA_READ_ONLY))
	{
		foreach ($ar_grid_links as $k=>$v)
			$ar_grid_links[$k] =
			"<a href=\"".EE_HTTP.'index.php?admin_template=yes&t=%'.	
			(array_search('id', $fields)+1).'$s">%'.
			(array_search($k, $fields)+1).'$s</a>';
	}
	$ar_grid_links['in_draft_state'] = '<img border="0" src="'.EE_HTTP.'img/<%%iif:%'.(array_search('in_draft_state',$fields)+1).'$s,Yes,'.
		'draft,<%%iif:<%%:is_draft_file%%>,1,draft,published%%>'.
		'%%>_page.gif">';
	// только окно редактирования
	// стиль строки поля формы

	// размер поля


	// доступно только для чтения

	// не обязательно для заполнения

	$mandatory=array('page_name', 'template');

	// тип поля ввода

	$type['id'] = "string";
	$type['media_description'] = "text";
	$type['template'] = "select_media_file";
	$type['folder'] = "select_media_folder";
	$type['size'] = "media_size";
	$type['zip_file_name'] = "file";
	$type['page_name'] = "page_name";
	$type['cachable'] = "checkbox";

	if ($op != 'add_zip')
	{
		$form_row_style['size'] = 'display:none';
		$form_row_style['alt_tag'] = 'display:none';
		$form_row_style['zip_file_name'] = 'display:none';
	}

	$caption['zip_file_name'] .= '*';
	$caption['in_draft_state'] = 'Status';
	$caption['page_name'] = 'Media name';
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
		global $default_language, $is_draft_file;
		global $language;
		include('print_list_init_vars_apply_filter.php');
		$sql = 'SELECT * from v'.$modul.'_grid' . $where . ' AND language = ' . sqlValue($language) . ' ' . $order;
		$tot = getsql('count(*) from v'.$modul.'_grid '.$where . ' AND language = ' . sqlValue($language), 0);

		include('print_list_limit_sql.php');

		$rs = viewsql($sql, 1);

		$s = '';
		$j=0;
		$rows = array();
		while($r=db_sql_fetch_row($rs))
		{
			$picture_vars = media_manage_vars('media_'.$r[0]);
			if (get_media_picture_name($picture_vars['images'][$default_language]) != $picture_vars['images'][$default_language]) $is_draft_file = 1;
				else $is_draft_file = '';
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
			$rows[$j]['id'] = $r[0];
			$rows[$j]['template'] = preg_replace("'media_(.*)\.tpl'", "\\1", $r[array_search('template', $fields)]);
			$rows[$j++]['name'] = SaveQuotes($r[1]);
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
		include ('prepare_multi_lang_page_name.php');
		if (post('refresh'))
		{                         			
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
				include ('presave_page_name.php');
				if ($op === 'add_zip')
				{
					$res = upload_media_zip('zip_file_name');
					if (is_array($res))
					{
						$error['zip_file_name'] = $res[0];
					}
					if (count($error)==0)
					{
						close_popup('yes');
					}
				} else {
					unset($field_values['size'], $field_values['alt_tag'], $field_values['zip_file_name']);
					if (empty($edit)) // New object
					{
						unset($field_values['id']);
						$db_function = 'f_add'.$modul;
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
						if (!empty($edit))
						{
							if(post('previous') || post('next'))
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
							else
							{
								close_popup('yes');
								exit;
							}
						}
						else
						{
							if (post('save_add_more'))
							{
								$prev_next = (post('prev_next'))?'&prev_next=1':'';
								$folder_id = !empty($_GET['folder'])?'&folder='.$_GET['folder']:'';
								header ('Location: '.$modul.'.php?op=3&added='.$res.$folder_id.$prev_next);
								exit;
							}
							else
							{
								close_popup('yes',$res);
							}
						}
						exit;
					}
				}
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
				'zip_open',
				'f_add'.$modul,
				'f_upd'.$modul,
				'f_del'.$modul,
				'mysql_query'),
			'php_ini' => array (),
			'constants' => array (
				'EE_MEDIA_PATH'),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit',
				'v_media_file'),
			'db_funcs'  => array (),

			'ftp_dir_exists' => array(
				EE_MEDIA_PATH,
			),

			'ftp_dir_attributes' => array(
				EE_MEDIA_PATH => EE_DEFAULT_DIR_MODE
			),

			'ftp_upload' => array ()
		);

		return parse_self_test($ar_self_check);
	}

	function print_preview_source($id)
	{
		$ret = js_clear(parse($id));

		$ret = str_replace("\r", " ", $ret);
		$ret = str_replace("\n", " ", $ret);

		$ret = trim($ret);

		return $ret;
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
		case 'add_zip':
			if(check_content_access(CA_READ_ONLY))
			{
				header($url);
				break;
			}
			echo save();
			break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'menu_array': echo 'Media/Media files';break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>