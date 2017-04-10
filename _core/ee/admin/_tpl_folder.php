<?
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'folder';
	
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

//	$count = db_sql_fetch_assoc(ViewSQL('SELECT COUNT(*) AS cnt FROM v_tpl_path_content',0));
//	if ($count['cnt'] == 0)
//		update_folder_hierarhi();


	$popup_height = 500;
	$popup_scroll = true;

	if (!defined('ADMIN_MENU_ITEM_TPL_FOLDER')) define('ADMIN_MENU_ITEM_TPL_FOLDER', 'Content/Satellite Page folders');

	//провер€ем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_TPL_FOLDER);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихс€ от установленных по-умолчанию

	// только список (grid)
	//скрыть столбец
	$hidden['page_count'] = 0;
	$hidden= array('lang');
 	// размер пол€ фильтра в списке
	$size_filter['id'] = 3;

	// «аголовки
	$caption['page_name'] = 'Folder name';
	$caption['page_description'] = 'Folder description';
	$caption['folder_id'] = 'Parent folder';
	$caption['group_access'] = '';
	$caption['folder_groups'] = '';

	$type_filter['language'] = 'select_distinct';


	// тип фильтра

	// выравнивание
	$align['id']='right';

	// стиль столбца

	// оформление самого значени€ в гриде
	$ar_grid_links['folder'] = '<table border="0"><tr><td><img src="'.EE_HTTP.'img/folder<%%iif:%'.
	(array_search('folder',$fields)+1).
	'$s,0,,_doc%%>.gif"></td><td colspan="2">%'.
	(array_search('folder',$fields)+1).
	'$s</td></tr><%%parse_sql_to_html:
	SELECT * FROM (
	(SELECT page_name\,	0 AS type\, language
		FROM v_tpl_folder_content
     		WHERE folder_id="%'.
			(array_search('id',$fields)+1).
			'$s"
     	ORDER BY page_name)
	UNION (SELECT page_name\,
      CASE
      WHEN tpl_id IS NULL THEN 0
      WHEN tpl_id IS NOT NULL AND type = 0 THEN 1
      WHEN tpl_id IS NOT NULL AND type = 1 THEN 2
      END AS type\, language
      FROM v_tpl_non_folder_content
     WHERE folder_id="%'.
	(array_search('id',$fields)+1).
	'$s" having type <> 0
     ORDER BY page_name)) tmp_sel
     WHERE language = "<%%:language%%>"
	,templates/_tpl_folder/pages_list_row%%></td></tr></table>';
	//var_dump($ar_grid_links['folder']);

	// только окно редактировани€
	// стиль строки пол€ формы

	// размер пол€

	// доступно только дл€ чтени€

	// об€зательно дл€ заполнени€

	$mandatory=array('page_name');

	// список полей по группам
	$fields_group['general'] = array('id',
 					 'page_name',
					 'page_description',
					 'create_date',
					 'edit_date',
					 'folder_id',
					 'for_search',
					 'owner_name',
					 'is_locked');
	$fields_group['group_access'] = array('group_access', 'folder_groups');

	// тип пол€ ввода
	$type['id'] = "string";
	$type['create_date'] = "string";
	$type['edit_date'] = "string";
	$type['owner_name'] = "string";
	$type['folder_id'] = 'select_tpl_folder';
	$type['for_search'] = 'checkbox';
	$type['is_locked'] = 'checkbox';
	$type['page_name'] = 'folder_name';
	$type['group_access'] = 'select_group_access';
	$type['folder_groups'] = 'select_user_groups';

	// восстанавливаем значени€ фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// дл€ сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// подписи к колонкам списка (grid-а)

	// туда же
	function print_captions()
	{
		return include('print_captions.php');
	}

	// пол€ фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
	function print_list()
	{
		global $language;
		include('print_list_init_vars_apply_filter.php');
		$sql = 'SELECT * from v'.$modul.'_grid' . $where . ' AND language = ' . sqlValue($language) . ' ' . $order;
		$tot = getsql('count(*) from v'.$modul.'_grid '.$where . ' AND language = ' . sqlValue($language), 0);

		include('print_list_limit_sql.php');

		$rs = viewsql($sql, 0 );

		$s = '';
		$j=0;
		$rows = array();
		while($r=db_sql_fetch_row($rs))
		{
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
				//$row_field[$i]['field_value'] = vsprintf($ar_grid_links[$fields[$i]], $r);
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field');
			$rows[$j]['items_count'] = $r[5];
			$rows[$j]['id'] = $r[0];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row');

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}


	// список полей в окне редактировани€
	function print_fields()
	{
		return include('print_fields.php');
	}
	// список полей в окне редактировани€ по группам.
	function print_fields_by_group()
	{
		return include('print_fields_by_group.php');
	}

	// добавление/сохранение записи
	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit, $default_language;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');
		include ('prepare_multi_lang_page_name.php');
		if ($for_search === '' )
			$for_search = 1;

		$field_values['folder_groups'] = post('access_groups');
                
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
				msg('restore');
			}
			$__new_page_name['general'] = $page_name_general;
			if ($page_name_general != '' && $__new_page_name[$default_language] != '' && isset($error['page_name']))
				unset($error['page_name']);
			else {
				vdump($page_name_general, '$page_name_general');
				vdump($default_language,'$default_language');
			}
			if (count($error)==0)
			{
				if (empty($edit)) // New object
				{
					unset($field_values['id']);
					unset($field_values['create_date']);
					unset($field_values['edit_date']);
					unset($field_values['owner_name']);
					$db_function = 'f_add'.$modul;
					
					$res = $db_function($field_values['page_name'],
							$field_values['page_description'],
							$field_values['folder_id'],
							$field_values['for_search'],
							$field_values['is_locked'],
							$field_values['group_access'],
							$field_values['folder_groups']);
				}
				else
				{
					unset($field_values['create_date']);
					unset($field_values['edit_date']);
					unset($field_values['owner_name']);
					$db_function = 'f_upd'.$modul;
					
					$res = $db_function($field_values['id'],
							$field_values['page_name'],
							$field_values['page_description'],
							$field_values['folder_id'],
							$field_values['for_search'],
							$field_values['is_locked'],
							$field_values['group_access'],
							$field_values['folder_groups']);

				}
//				vdump($field_values, '$field_values');

				if ($res < 0)
				{
					$error['id'] = 'DataBase error';
				}
				else
				if (post('save_add_more'))
				{
					$folder_id = !empty($_GET['folder_id'])?'&folder_id='.$_GET['folder_id']:'';
					header ('Location: '.$modul.'.php?op=3&added='.$res.$folder_id);
					exit;
				}
				else
				{
					close_popup('yes');
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

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'f_add'.$modul,
				'f_upd'.$modul,
				'f_del'.$modul,
				'mysql_query'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit',
				'tpl_pages',
				'access_mode',
				'folder_group',
				'content_access'
			),
			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}
	function print_users_list($edit)
	{
		global $modul;
		echo parse_sql_to_html('SELECT u.id AS user_id,
					       '.$edit.' AS folder_id,
					       u.login,
					       (SELECT ca.content_access_name FROM content_access ca WHERE ca.id = u.content_access LIMIT 0,1) AS default_access,
					       (SELECT ca.content_access_name FROM content_access ca WHERE ca.id =(SELECT c.val FROM content c WHERE c.page_id='.sqlValue($edit).' AND c.var=\'folder_access_mode_\' AND c.var_id=u.id)) AS access FROM users u', 'templates/'.$modul.'/users_list_row');
	}

	function update_folder_access_mode($folderId, $userId, $folderAccessMode)
	{
		if(getUserRole($userId) < ADMINISTRATOR)
		{
			update_subfolders_access_mode($folderId, $userId, $folderAccessMode);
		}
      		return "OK";
	}

	function update_subfolders_access_mode($folderId, $userId, $folderAccessMode)
	{
		// save_cms for sub folder
		save_cms('folder_access_mode_'.$userId, $folderAccessMode, $folderId);
		// del_cms for sub folder
		if(get_user_content_access($userId) == $folderAccessMode)
		{
			del_cms('folder_access_mode_'.$userId, null, $folderId);
		}
		$r = viewSQL('SELECT id FROM tpl_pages WHERE folder_id=' . sqlValue($folderId));
		if(db_sql_num_rows($r) > 0)
		{
			while($subFolder = db_sql_fetch_assoc($r))
			{
				update_subfolders_access_mode($subFolder['id'], $userId, $folderAccessMode);
			}
		}
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
			if(check_content_access(CA_READ_ONLY,null,null,$edit))
			{
				header($ulr);
				break;
			}
			echo save();
			break;
		case '2':
			if(check_content_access(CA_READ_ONLY,null,null,$del))
			{
				header($url);
				break;
			}
			del();
			break;
		case '3':
			if(check_content_access(CA_READ_ONLY,null,null,$edit))
			{
				header($url);
				break;				
			}
			echo save();break;
		case 'del_sel_items':
			del_selected_items($modul);
			echo parse($modul.'/list');
			break;
		case 'users_list':
			if(check_content_access(CA_READ_ONLY,CA_EDIT,CA_PUBLISH,$edit))
			{
				header($url);
				break;
			}
			echo print_users_list($edit);
			break;
		case 'update_row':
			if(check_content_access(CA_READ_ONLY,CA_EDIT,CA_PUBLISH,$edit))
			{
				header($url);
				break;
			}
			echo update_folder_access_mode($folder_id, $user_id, $folder_access_mode);
			break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>
