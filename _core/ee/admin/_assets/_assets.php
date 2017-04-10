<?
$time_start = microtime(true);
	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');
	
	$for_search = (isset($_REQUEST['search_query']))?'1':'0';
	
	//assets parameters
	$cookies_prepend = '';//in standart mode of assets manager and its light version different count of fields
	//so stored values of fields are incorrect in different versions, so we need to have different cookies for
	//width of fileds, presorting field and ascedding of this filed
	
	//Insert link to page in FCK editor
	$return_pages_for_fck = isset($_GET['return_pages_for_fck'])?$_GET['return_pages_for_fck']:0;
	if(isset($_POST['return_pages_for_fck']))
	{
		$return_pages_for_fck = $_POST['return_pages_for_fck'];
	}
	//Insert id of media into select media dialog
	$return_medias_for_insert = isset($_GET['return_medias_for_insert'])?$_GET['return_medias_for_insert']:0;
	if(isset($_POST['return_medias_for_insert']))
	{
		$return_medias_for_insert = $_POST['return_medias_for_insert'];
	}
	//Insert page id for menu item sattelite page
	$return_pages_for_menu = isset($_GET['return_pages_for_menu'])?$_GET['return_pages_for_menu']:0;
	if(isset($_POST['return_pages_for_menu']))
	{
		$return_pages_for_menu = $_POST['return_pages_for_menu'];
	}
	
	if(isset($_REQUEST['return_pages_for_fck']) || isset($_REQUEST['return_medias_for_insert']))
	{
		$cookies_prepend = 'light_';
	}
	
	$show_admin_menu = isset($_GET['show_admin_menu'])?$_GET['show_admin_menu']:1;
	$show_module_title_and_options = isset($_GET['module_title_and_options'])?$_GET['module_title_and_options']:1;
	$show_big_options = isset($_GET['big_options'])?$_GET['big_options']:1;
	$show_folder_menu = isset($_GET['folder_menu'])?$_GET['folder_menu']:1;
	$show_content_menu = isset($_GET['content_menu'])?$_GET['content_menu']:1;
	$show_group_by_options = isset($_GET['group_by_options'])?$_GET['group_by_options']:1;
	//table rows
	$hide_checkbox = isset($_GET['hide_checkbox'])?$_GET['hide_checkbox']:0;
	$hide_page_edit = isset($_GET['hide_page_edit'])?$_GET['hide_page_edit']:0;
	$hide_page_autor = isset($_GET['hide_page_autor'])?$_GET['hide_page_autor']:0;
	$hide_view = isset($_GET['hide_view'])?$_GET['hide_view']:0;
	$hide_index = isset($_GET['hide_index'])?$_GET['hide_index']:0;
	$hide_cachable = isset($_GET['hide_cachable'])?$_GET['hide_cachable']:0;
	$hide_preview = isset($_GET['hide_preview'])?$_GET['hide_preview']:0;
	$hide_page_action = isset($_GET['hide_page_action'])?$_GET['hide_page_action']:0;
	
	//for css styles
	$assets_lists_padding_top = 113;//158
	if(!$show_admin_menu)
	{
		$assets_lists_padding_top -= 72;//72
	}
	if(!$show_module_title_and_options)
	{
		$assets_lists_padding_top -= 0;//38+2//40
	}

	//$modul_title = str_replace(' ','',str_to_title($modul));
	$modul_title = 'Assets';

	include('url_if_back.php');

	$edit_config_width = 700;
	$config_vars = array (
		array (

		'field_name' => 'use_draft_content',
		'type' => 'checkbox_alert'

		),
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

		'field_name' => 'change_frequency',
		'size' => '70',
		'type' => 'select_change_frequency',
		'field_title' => 'Default change frequency for page'

		),

		array (

		'field_name' => 'antispam_security',
		'type' => 'checkbox',
		'field_title' => 'Anti-Spam Security'

		)

	);
	//Count height of page properties windows
	//Pages
	$page_count_of_edit_fields = count(@db_sql_table_fields('v_tpl_page_edit'));
	$page_popup_height = ($page_count_of_edit_fields+count($langEncode)+4)*30 + 33;//add 33px due to tabs
	//Medias
	$media_count_of_edit_fields = count(@db_sql_table_fields('v_media_edit'));
	$media_popup_height = ($media_count_of_edit_fields+count($langEncode)+1)*30;
	//Folders
	$folder_popup_height = 500;
	
	$popup_scroll = '1';

	if (!defined('ADMIN_MENU_ITEM_TPL_ASSETS')) define('ADMIN_MENU_ITEM_TPL_ASSETS', 'Content/'.str_to_title($modul));

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_TPL_ASSETS);

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	///$srt = -3;//По какому полю сортируем
	
	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	//unset($sort);
	//$sort[1] = 'form_name';
	
	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();
	
//	msg($order); exit;

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

	function get_recursive_folders_ids($id, &$res_arr)
	{
		$sql = 'SELECT id FROM v_tpl_folder_content WHERE folder_id='.sqlValue($id);
		$rs = viewSQL($sql);
		if(db_sql_num_rows($rs)>0)
		{
			while($res = db_sql_fetch_assoc($rs))
			{
				$res_arr[] = $res['id'];
				get_recursive_folders_ids($res['id'], $res_arr);
			}
		}
	}
	
	//отображаем список папок
	function print_folders()
	{
		global $language, $return_medias_for_insert;
		// Если переменная "display_medias" не пустая выводим только root папку
		if(empty($_COOKIE['_assets_display_medias']) || $return_medias_for_insert)//если мы вставляем медию в диалог выбора медиq, то мы не учитываем настройки группировки, поскольку там нет опции смены группировки
		{
			// Если человек попал на эту страницу по get параметру page, развернем для него папки до текущей
			if(isset($_GET['folder']) || isset($_GET['page']))
			{
				//Если нам передали page, находим его родительскую папку
				if(isset($_GET['page']))
				{
					$curr_page_id = (int)$_GET['page'];
					$sql = 'SELECT DISTINCT `folder_id` AS `curr_folder_id` FROM `v_tpl_page_content` WHERE `id`="'.addslashes($curr_page_id).'"';
					//echo $sql; exit;
					$rs = viewsql($sql, 0);
					if(db_sql_num_rows($rs) > 0)
					{
						$curr_folder_id = db_sql_result($rs,0,'curr_folder_id');
					}
					else
					{
						$curr_folder_id = 0;//файл не существует
					}
				}
				else
				{
					$sql = 'SELECT DISTINCT `id` FROM `v_tpl_folder` WHERE `id`="'.addslashes((int)$_GET['folder']).'"';
					//echo $sql; exit;
					$rs = viewsql($sql, 0);
					if(db_sql_num_rows($rs) > 0)
					{
						$curr_folder_id = (int)$_GET['folder'];
					}
					else
					{
						$curr_folder_id = 0;//папка не существует
					}
				}
				//Находим все папки родители
				while(!is_null($curr_folder_id) && $curr_folder_id >= 0)
				{
					$sql = 'SELECT DISTINCT `folder_id` AS `par_folder_id` FROM `v_tpl_folder` WHERE `id`="'.addslashes($curr_folder_id).'"';
					//echo $sql; exit;
					$rs = viewsql($sql, 0);
					if(db_sql_num_rows($rs) > 0)
					{
						$curr_folder_id = db_sql_result($rs,0,'par_folder_id');
						$curr_folder_id = (is_null($curr_folder_id))?'0':$curr_folder_id;//root
						if(isset($_COOKIE['_assets_expand_folder_'.$curr_folder_id])) $_COOKIE['_assets_expand_folder_'.$curr_folder_id] = '1';
						else setcookie('_assets_expand_folder_'.$curr_folder_id, rawurlencode('1'), time() + 4 * 7 * 24 * 60 * 60, EE_HTTP_PREFIX);
					}
					else
					{
						break;
					}
				}
			}
			
			$include_root_folder = 1;
			$in = '';
			if(isset($_POST['folder_id']))
			{
				if($_POST['folder_id'] !='0')
				{
					$include_root_folder = 0;
					//find elements which exist in current folder
					$inserted_folders = array();
				
					get_recursive_folders_ids((int)$_POST['folder_id'], $inserted_folders);
				
					$in = 'AND 1=0';//not found
					if(sizeof($inserted_folders)>0)
					{
						$in = 'AND `f`.`id` IN ('.implode(', ', $inserted_folders).')';
					}
				}
				else
				{
					$include_root_folder = 0;
				}
				
			}
			//Нам надо отсортировать папки по именам
			$sql = 'SELECT `f`.* ,
						CONCAT("/", `p`.`folder`) AS folder_path,
						IF( `f`.`folder_id` IS NOT NULL, (
							SELECT `f2`.`page_name`
							FROM `v_tpl_folder_content` AS `f2`
							WHERE `f2`.`id` = `f`.`folder_id` AND `language` = '.sqlValue($language).'
							GROUP BY `f2`.`id`
						), "/" ) AS `parent_folder`,
						IF(`f`.`folder_id` IS NOT NULL, CONCAT("tmpNode_", `f`.`folder_id`), "tmpNode_0") AS `parent`,
						IF(`f`.`folder_id` IS NOT NULL, `f`.`folder_id`, 0) AS `parent_id`,
						IF(`f`.`is_locked` !=0 , "Yes", "No") AS `locked`,
						IF(
							(SELECT items_count FROM `v_tpl_folder_grid` AS `fg` WHERE `fg`.`id`=`f`.`id` AND `fg`.`language`='.sqlValue($language).')=0,1,0
						) AS `empty`
					FROM `v_tpl_folder_content` AS `f` LEFT JOIN `v_tpl_path_content` AS `p`
					ON `f`.`id` = `p`.`id`
					WHERE `f`.`language` = `p`.`language`
					AND `f`.`language` = '.sqlValue($language).'
					'.$in.'
					GROUP BY `f`.`id`
					ORDER BY `folder_path`, `parent`, `f`.`id`';
			//echo $sql; exit;
			$rs = viewsql($sql, 0);
			//Узнаем открыта ли root папка
			$expanded = (isset($_COOKIE['_assets_expand_folder_0']) && $_COOKIE['_assets_expand_folder_0']) ? 'true' : 'false';
			//Выводим root папку
			if($include_root_folder)
			{
				$ret = "var myobj_0 = { label: \"<span>/</span>\", id:\"0\", href: null, pos:1 };"."\n";
				$ret .= 'var tmpNode_0 = new YAHOO.widget.TextNode(myobj_0, tree.getRoot(), '.$expanded.');'."\n";
			}
			//YUI treeview считает папки по порядку начиная с 1 = root
			//Мы же считаем их по id папки из БД
			//чтобы привести все к идиному виду
			
			$i = 2;//считаем позици папки
			if(!empty($_POST['startPosition'])){
				$i = (int)$_POST['startPosition']+1;
			}
			while($res=db_sql_fetch_assoc($rs))
			{
				$delete_text_value = "Delete folder";
				$delete_text = "<a href=\\\"javascript:cannotDeleteFolder('".$res['page_name']."');\\\">".$delete_text_value."</a>";
				if($res['empty'])
				{
					$delete_text = "<a href=\\\"javascript:deleteFolder(".$res['id'].",'".$res['page_name']."');\\\">".$delete_text_value."</a>";
				}
				//Узнаем открыта ли папка
				$expanded = (isset($_COOKIE['_assets_expand_folder_'.$res['id']]) && $_COOKIE['_assets_expand_folder_'.$res['id']]) ? 'true' : 'false';
				//Выводим папки
				//сначало было так, подсказки появлялись при наведении
				//$ret .= "var myobj_".$res['id']." = { label: \"<span onmouseover=\\\"clearTimeout(tm1); ddrivetip('<b>".add4slashes($res['page_name'])."</b><br><i>".add4slashes($res['page_description'])."</i><br><br>Parent folder: ".add4slashes($res['parent_folder'])."<br>Created: ".$res['create_date']." by ".add4slashes($res['owner_name'])."<br>Modified: ".$res['edit_date']."<br><br><table border=0 cellpadding=0 cellspacing=0><tr><td>Security: All</td><td><img src=\\\\'".EE_HTTP.EE_HTTP_PREFIX_CORE."img/doc_user.gif\\\\' align=top width=16 height=16 alt=\\\\'\\\\' style=\\\\'margin-left: 16px;\\\\'>&nbsp;<a href=\\\\'#\\\\'>Change the access</a></td></tr></table>Locked: ".$res['locked']."<br><br><img src=\\\\'".EE_HTTP.EE_HTTP_PREFIX_CORE."img/edit/doc_edit.gif\\\\' align=top width=16 height=16 alt=\\\\'\\\\'>&nbsp;<a href=\\\\'javascript:openFolderPopup(".$res['id'].");\\\\'>Edit folder properties</a><br><img src=\\\\'".EE_HTTP.EE_HTTP_PREFIX_CORE."img/copy.gif\\\\' align=top width=16 height=16 alt=\\\\'\\\\'>&nbsp;<a href=\\\\'#\\\\'>Copy the folder</a><br><img src=\\\\'".EE_HTTP.EE_HTTP_PREFIX_CORE."img/edit/doc_delete.gif\\\\' align=top width=16 height=16 alt=\\\\'\\\\'>&nbsp;".$delete_text."')\\\" onmouseout=\\\"tm1 = setTimeout('hideddrivetip()',500);\\\">".add4slashes($res['page_name'])."</span>\", id:\"".$res['id']."\", href: null };"."\n";
				
				//если попытатся заново объявить переменую которая существует получим сообщение об ошибке
				
				$ret .= "myobj_".$res['id']." = { label: \"<span>".htmlspecialchars($res['page_name'], ENT_QUOTES)."</span>\", id:\"".$res['id']."\", href:null, pos:\"".$i."\" };"."\n";
				$ret .= 'tmpNode_'.$res['id'].' = new YAHOO.widget.TextNode(myobj_'.$res['id'].', '.$res['parent'].', '.$expanded.');'."\n";
				//Запоминаем соответствие номерам папок в БД порядковых номеров YUI
				//Выводим всплывающий текст
				$ret .= "nodeText_".$res['id']." = \"".
				"<b>".htmlspecialchars($res['page_name'], ENT_QUOTES)."</b><br>".
				"<i>".htmlspecialchars($res['page_description'], ENT_QUOTES)."</i><br><br>".
				"Parent folder: ".htmlspecialchars($res['parent_folder'], ENT_QUOTES)."<br>".
				"Created: ".htmlspecialchars($res['create_date'], ENT_QUOTES)." by ".htmlspecialchars($res['owner_name'], ENT_QUOTES)."<br>".
				"Modified: ".htmlspecialchars($res['edit_date'], ENT_QUOTES)."<br><br>".
				//////////"<table border=0 cellpadding=0 cellspacing=0><tr><td>Security: All</td><td><img src='".EE_HTTP.EE_HTTP_PREFIX_CORE."img/doc_user.gif' align=top width=16 height=16 alt='' style='margin-left: 16px;'>&nbsp;<a href='#'>Change the access</a></td></tr></table>".
				"Locked: ".htmlspecialchars($res['locked'], ENT_QUOTES)."<br><br>".
				"<img src='".EE_HTTP.EE_HTTP_PREFIX_CORE."img/edit/doc_edit.gif' align=top width=16 height=16 alt=''>&nbsp;<a href='javascript:openFolderPopup(".$res['id'].",".$res['parent_id'].");'>Edit folder properties</a><br>".
				//////////"<img src='".EE_HTTP.EE_HTTP_PREFIX_CORE."img/copy.gif' align=top width=16 height=16 alt=''>&nbsp;<a href='#'>Copy the folder</a><br>".
				"<img src='".EE_HTTP.EE_HTTP_PREFIX_CORE."img/edit/doc_delete.gif' align=top width=16 height=16 alt=''>&nbsp;".$delete_text."<br>".
				"\";"."\n";
				$i++;
			}
		}
		// Если переменная "display_medias" не пустая выводим только root папку
		else if(empty($_REQUEST['rand']))//if we in plain mode, we already output root folder, if we output it one more time then click on folder we would have 2 root folders
		{
			$ret = "var myobj_0 = { label: \"<span>/</span>\", id:\"0\", href: null, pos:1 };"."\n";
			$ret .= 'var tmpNode_0 = new YAHOO.widget.TextNode(myobj_0, tree.getRoot(), false);'."\n";
		}
		
		if(!empty($GLOBALS['return_folders_in_ajax']))
		{
			echo $ret;
			exit;
		}
		else
		{
			return $ret;
		}
		
	}
	
	//проверяем есть ли закешированая страница или медия
	function check_page_cached($id)
	{                   
		if(check_if_exists_other_lng_cache($id))
		{
			return 'Yes (<a href=\'javascript:deletePageCache('.$id.');\'>Remove from cache</a>)';
		}
		return 'No';
	}
	
	function get_assets_content(&$tbl, $field, $folder_id)
	{
		global $language, $return_medias_for_insert, $s_langs;
		
		//is we use "display medias" option show all content in root folder
		$folder_pos = 'IF(`main`.`folder_id` IS NOT NULL, `main`.`folder_id`, 0) AS folder_pos';
		if(!empty($_COOKIE['_assets_display_medias']) && !$return_medias_for_insert)
		{
			$folder_pos = '0 AS folder_pos';
			$where_folder = '';//all
		}
		else
		{
			$where_folder = ($folder_id == '0')?' IS NULL':'='.sqlValue($folder_id);
			$where_folder = 'AND `main`.`folder_id`'.$where_folder;
		}
		
		if($return_medias_for_insert)//show only flash & images medias
		{
			$where_folder .= ' AND `main`.`file_name`<>'.sqlValue('media_doc');
		}
		
		//select ids of pages and medias which satisfy search conditions
		if(isset($_REQUEST['search_query']))
		{
			$search_query = $_REQUEST['search_query'];
			
			if(empty($s_langs) || !is_array($s_langs))
			{
				$sql = 'SELECT `language_code` FROM `language` WHERE `status`=1';
				$rs = viewSQL($sql);
				$s_langs = array();
				if(db_sql_num_rows($rs)>0)
				{
					while($res = db_sql_fetch_assoc($rs))
					{
						$s_langs[] = $res['language_code'];
					}
				}
			}
			
			$page_ext = array('html');
			$media_ext = array(
				array(
					'jpg',
					'jpeg',
					'gif',
					'png'
				),
				array('swf'),
				array('doc')
			);
			$media_ext_merge = array_merge($media_ext[0], $media_ext[1], $media_ext[2]);
			$where = '';
			//проверяем не передали ли нам строку адреса вида http://localhost/ee3.2/EN/second_folder/third_folder/very_long_page.html?
			/*
			array (
			  0 => 'http://localhost/ee3.2/EN/second_folder/third_folder/very_long_page.html',
			  1 => 'http://',
			  2 => 'localhost',
			  3 => 'ee3.2',
			  4 => 'EN',
			  5 => 'second_folder/third_folder/',
			  6 => 'second_folder/third_folder',
			  7 => 'very_long_page',
			  8 => '.',
 			  9 => 'html',
			  10 => '',
			)
			*/
			preg_match("/^(http:\/\/|https:\/\/)?(".EE_HTTP_HOST.")?[\/]?(".trim(EE_HTTP_PREFIX, '/').")?[\/]?(".implode('|', $s_langs).")[\/]+((.*)[\/]+)?(.*)(\.)+(".implode('|', array_merge($page_ext, $media_ext_merge)).")+(\?|$)+/i", $search_query, $matches); 
			//url search
			if(array_key_exists(4, $matches) && !empty($matches[4]))//language found
			{
				$where .= ' AND `c`.`language`='.sqlValue($matches[4]);
			}
			if(array_key_exists(6, $matches) && !empty($matches[6]))//folder found
			{
				$where .= ' AND `pc`.`folder`='.sqlValue($matches[6]);
			}
			if(array_key_exists(7, $matches) && !empty($matches[7]))//file found
			{
				$where .= ' AND `c`.`val`='.sqlValue($matches[7]);
			}
			if(array_key_exists(9, $matches) && !empty($matches[9]))//extension found
			{
				//Находим тип файла
				$page_type_sql = ' AND `f`.`type`%s1';
				if(in_array($matches[9], $page_ext))
				{
					$match_type = 0;//page
					$where .= sprintf($page_type_sql, '<>');
				}
				else
				{
					$match_type = 1;//media
					$where .= sprintf($page_type_sql, '=');
				}
				
				//Находим id шаблона медии
				if($match_type)
				{
					$sql = 'SELECT `id` FROM `tpl_files` WHERE `type`=1 ORDER BY `file_name` DESC';
					$rs = viewSQL($sql);
					$tpl_types = array();
					if(db_sql_num_rows($rs)>0)
					{
						while($res = db_sql_fetch_assoc($rs))
						{
							$tpl_types[] = $res['id'];
						}
						if(in_array($matches[8], $media_ext[0]))
						{
							$where_url .= ' AND `p`.`tpl_id`='.sqlValue($tpl_types[0]);
						}
						if(in_array($matches[8], $media_ext[1]))
						{
							$where_url .= ' AND `p`.`tpl_id`='.sqlValue($tpl_types[1]);
						}
						if(in_array($matches[8], $media_ext[2]))
						{
							$where .= ' AND `p`.`tpl_id`='.sqlValue($tpl_types[2]);
						}
					}
				}
			}
			
			//simple search
			if($where == '')
			{
				$where = sprintf(' AND (`p`.`id` = "%1$s"
					OR `p`.`page_description` LIKE "%%%1$s%%"
					OR `p`.`owner_name` LIKE "%%%1$s%%"
					OR `p`.`page_name` LIKE "%%%1$s%%"
					OR `c`.`val` LIKE "%%%1$s%%")', $search_query);
			}
			
			if($return_medias_for_insert)
			{
				$where .= ' AND (`f`.`type`="1" AND `f`.`file_name`<>"media_doc")';
			}
			
			$sql = 'SELECT DISTINCT `p`.`id`
				FROM `tpl_files` as `f`
				LEFT JOIN `tpl_pages` AS `p` ON (
					`f`.`id`=`p`.`tpl_id`
				)
				LEFT JOIN `v_tpl_path_content` AS `pc` ON (
					`p`.`folder_id`=`pc`.`id`
				)
				LEFT JOIN `content` AS `c` ON (
					`pc`.`language`=`c`.`language`
					AND `c`.`var`="page_name_"
					AND `c`.`var_id`=`p`.`id`
				) WHERE `p`.`id` IS NOT NULL '.$where;
				//echo $sql;exit;
			$rs = viewSQL($sql);
			if(db_sql_num_rows($rs)>0)
			{
				$find_ids = array();
				while($res = db_sql_fetch_assoc($rs))
				{
					$find_ids[] = $res['id'];
				}
				$where_folder = 'AND `main`.`id` IN('.implode(', ',$find_ids).')';//find
			}
			else
			{
				$where_folder = 'AND 1=0';//not find
			}
		}
		
		$sql = 'SELECT *,
				IF(`main`.`type`=0, "Page", "Media") AS `page_type`,
				(SELECT `f`.`page_name` FROM `v_tpl_folder_content` AS `f` WHERE `f`.`id`=`main`.`folder_id` AND `f`.`language` = '.sqlValue($language).') AS `folder`,
				(SELECT `f2`.`folder` FROM `v_tpl_folder_grid` AS `f2` WHERE `f2`.`id`=`main`.`folder_id` AND `f2`.`language` = '.sqlValue($language).') AS `folder_path`,
				IF(`main`.`is_locked`=0, "No", "Yes") AS `locked`,
				(SELECT `in_draft_state` FROM v_tpl_non_folder_statistic v_st WHERE v_st.id=main.id) AS `in_draft_state`,
				'.$folder_pos.'
				FROM `'.$field.'` AS `main`
				WHERE `main`.`language` = '.sqlValue($language).'
				'.$where_folder.'
				GROUP BY `main`.`id`
				ORDER BY `folder_pos`, `main`.`id`';
		//echo $sql; exit;
		$rs = viewsql($sql, 0);
		while($res=db_sql_fetch_assoc($rs))
		{
			$tbl[] = $res;
		}
	}
	
	function media_exists($media_id)
	{
		//find media url
		global $language;
		$sql = 'SELECT val FROM content WHERE var="media_" AND var_id='.sqlValue($media_id).' ORDER BY var_id LIMIT 0,1';
		$rs = getField($sql);
		$res = unserialize($rs);
		$media_path = EE_PATH.EE_MEDIA_PATH.$res['images'][$language];
		if(!check_file($media_path)) return false;
		return true;
		
	}
	
	//Выводим страницы и медии
	function show_pages_n_media($tbl)
	{
		global $language, $modul, $return_pages_for_fck, $return_medias_for_insert, $return_pages_for_menu, $for_search;

		$cell = array();//строки
		$labels = array();//текст при правом щелчке мыши
		$block = '';//результат, список страниц для таблицы
		$f_id = 0;//номер страниц в папках

		for ($i=0; $i<sizeof($tbl); $i++)
		{

			if (is_null($tbl[$i]['folder']))
			{
				$tbl[$i]['folder'] = '/';
			}
			else
			{
				$tbl[$i]['folder'] .= '/';
			}

			//check if is published
			$publish = '';//media
			$publish_grid = '';
			$edit_url = 'javascript:openMediaPopup('.$tbl[$i]['id'].','.$for_search.');';//media

			if (array_key_exists('page_type', $tbl[$i]) && $tbl[$i]['page_type'] == 'Page')//page
			{
				if (array_key_exists('in_draft_state', $tbl[$i]) && $tbl[$i]['in_draft_state'] == 'Yes' && config_var('use_draft_content') == 1)
				{
					$publish = "<tr><td>Published: No</td><td><img src=\'".EE_HTTP.EE_HTTP_PREFIX_CORE."img/publish_a.gif\' align=top width=16 height=16 alt=\'\' style=\'margin-left: 16px;\'>&nbsp;<a onclick=\'return publish_confirm(this.href)\' href=\'".EE_ADMIN_URL.$modul.".php?op=publish&amp;t=".$tbl[$i]['id']."&amp;admin_template=yes\'>Publish page</a></td></tr>";
					$publish_grid = '<a onclick=\"return publish_confirm(this.href)\" title=\"Publish page content\" href=\"'.EE_ADMIN_URL.$modul.'.php?op=publish&amp;t='.$tbl[$i]['id'].'&amp;admin_template=yes\"><img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/publish_a.gif\" width=\"16\" height=\"16\" alt=\"'.PUBLISH.'\" title=\"'.PUBLISH.'\" border=\"0\"/></a><a onclick=\"return revert_confirm(this.href)\" title=\"Revert page content\" href=\"'.EE_ADMIN_URL.$modul.'.php?op=revert&amp;t='.$tbl[$i]['id'].'&amp;admin_template=yes\"><img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/unpublish_a.gif\" width=\"16\" height=\"16\" alt=\"'.REVERT.'\" title=\"'.REVERT.'\" border=\"0\"/></a>';
				}
				else
				{
					$publish = '<tr><td>Published: Yes</td><td>&nbsp;</td></tr>';
					$publish_grid = "";
				}

				if (is_page_draft($tbl[$i]['id']) == 1)
				{
					$publish_grid .= '&nbsp;&nbsp;<a onclick=\"return publish_confirm(this.href)\" title=\"Publish page\" href=\"'.EE_ADMIN_URL.$modul.'.php?op=publish_page&amp;t='.$tbl[$i]['id'].'&amp;admin_template=yes\"><img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/publish_a.gif\" width=\"16\" height=\"16\" alt=\"Publish page\" title=\"Publish page\" border=\"0\"/></a>';
				}

				$edit_url = "javascript:openPagePopup(".$tbl[$i]['id'].",".$for_search.");";
			}
			
			$is_template_deleted = '';
			$page_template = htmlspecialchars($tbl[$i]['file_name'], ENT_QUOTES);
			if($tbl[$i]['tpl_id'] == 0)
			{
				$is_template_deleted = "<img align=\\\"top\\\" src=\\\"".EE_HTTP."img/warning.gif\\\" height=16 width=16 alt=\\\"".ASSETS_TEMPLATE_NOT_EXISTS."\\\" title=\\\"".ASSETS_TEMPLATE_NOT_EXISTS."\\\" border=0>&nbsp;";
				$page_template = '<em>'.ASSETS_TEMPLATE_NOT_EXISTS.'</em>';
			}
			
			$preview = '<div align=center><a href=\"'.EE_HTTP.'index.php?t='.$tbl[$i]['id'].'\" target=\"_blank\"><img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/doc_web.gif\" alt=\"'.ASSETS_VIEW_PAGE.'\" title=\"'.ASSETS_VIEW_PAGE.'\" border=\"0\"></a></div>';

			if ($tbl[$i]['page_type'] == 'Media')
			{
				$preview = '<div align=center><img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/camera_p.gif\" alt=\"'.ASSETS_NO_PREVIEW.'\" title=\"'.ASSETS_NO_PREVIEW.'\" border=\"0\"></div>';

				if ($tbl[$i]['file_name'] == 'media_image' && media_exists($tbl[$i]['id']))
				{
					$preview = '<div align=center><img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/camera.gif\" alt=\"'.ASSETS_VIEW_MEDIA.'\" title=\"'.ASSETS_VIEW_MEDIA.'\" onmouseover=\"ddrivetip(\''.print_assets_preview_source($tbl[$i]['id']).'\');\" onmouseout=\"hideddrivetip();\" border=\"0\"></div>';
				}
			}
			
			$page_name_href = EE_HTTP.'index.php?t='.$tbl[$i]['id'].'&amp;admin_template=yes&amp;from=assets';//on click go to page edit
			if($return_pages_for_fck)
			{
				$page_name_href = 'javascript:addLinkToFCK('.$tbl[$i]['id'].');';//on click insert link to fck editor
			}
			else if($return_medias_for_insert)
			{
				$page_name_href = 'javascript:insertMediaId('.$tbl[$i]['id'].',\"'.media_to_file_name($tbl[$i]['folder_path'].'/'.$tbl[$i]['page_name']).'\");';//on click insert media id to parent hidden field
			}
			else if($return_pages_for_menu)
			{
				$page_name_href = 'javascript:insertPageId('.$tbl[$i]['id'].',\"'.media_to_file_name($tbl[$i]['folder_path'].'/'.$tbl[$i]['page_name']).'\", \"'.get('arg_sufix').'\");';//on click insert page id into menu edit hiffen field
			}
			
			//Формируем строки
			$cell[] = "{checkbox:\"<div align=center><input name='selected_items[]' value='".htmlspecialchars($tbl[$i]['id'], ENT_QUOTES)."' type='checkbox' title='".htmlspecialchars($tbl[$i]['page_name'], ENT_QUOTES)."'></div>\",
			pageName:\"<span style='display: none; visibility: hidden;'>".htmlspecialchars($tbl[$i]['page_name'], ENT_QUOTES)."</span><span>".$is_template_deleted."<a href='".$page_name_href."'>".htmlspecialchars($tbl[$i]['page_name'], ENT_QUOTES)."</a></span>\",
			pageDescription:\"".htmlspecialchars($tbl[$i]['page_description'], ENT_QUOTES)."\",
			pageType:\"".htmlspecialchars($tbl[$i]['page_type'], ENT_QUOTES)."\",
			pageTemplate:\"".$page_template."\",
			pageEdit:\"".htmlspecialchars($tbl[$i]['edit_date'], ENT_QUOTES)."\",
			pageAutor:\"".htmlspecialchars($tbl[$i]['owner_name'], ENT_QUOTES)."\",
			view:\"<div align=center>".get_assets_view_list(htmlspecialchars($tbl[$i]['file_name']), $tbl[$i]['id'], media_to_file_name($tbl[$i]['page_name']), $tbl[$i]['type'])."</div>\",
			index:\"<div align=center>".(htmlspecialchars($tbl[$i]['for_search'], ENT_QUOTES) ? '<img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/web_search2.gif\" width=\"16\" heigth=\"16\" alt=\"'.ASSETS_PAGE_INDEXING_ENABLED.'\" title=\"'.ASSETS_PAGE_INDEXING_ENABLED.'\" />' : '<img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/web_search2_disabled.gif\" width=\"16\" heigth=\"16\" alt=\"'.ASSETS_PAGE_INDEXING_DISABLED.'\" title=\"'.ASSETS_PAGE_INDEXING_DISABLED.'\" />')."</div>\",
			cachable:\"<div align=center>" . (htmlspecialchars($tbl[$i]['cachable'], ENT_QUOTES) ? '<img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/cache/cache_exists_row.gif\" width=\"16\" heigth=\"16\" alt=\"'.ASSETS_CACHABLE.'\" title=\"'.ASSETS_CACHABLE.'\" />' : '<img src=\"'.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/cache/cache_exists_row_gray.gif\" width=\"16\" heigth=\"16\" alt=\"'.ASSETS_NOT_CACHABLE.'\" title=\"'.ASSETS_NOT_CACHABLE.'\" />') . "</div>\",
			preview:\"" . $preview . "\",
			pageDraftMode:\"<div align=center>" . $publish_grid . "</div>\",
			pageAction:\"<div align=center><a href='".$edit_url."'><img src='".EE_HTTP.EE_HTTP_PREFIX_CORE."img/edit/doc_edit.gif' align=top width=16 height=16 alt='".ASSETS_EDIT."' title='".ASSETS_EDIT."' border=0></a><a href=\\\"javascript:deletePage(".$tbl[$i]['id'].",'".$tbl[$i]['page_name']."','".$tbl[$i]['page_type']."');\\\"><img src='".EE_HTTP.EE_HTTP_PREFIX_CORE."img/edit/doc_delete.gif' align=top width=16 height=16 alt='".ASSETS_DELETE."' title='".ASSETS_DELETE."' border=0></a></div>\"}";
			//Формируем текст при правом щелчке мыши
			$live_version_text = '';
			if($tbl[$i]['page_type'] == 'Page'){$live_version_text = '<img src=\''.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/published_page.gif\' align=top width=16 height=16 alt=\'\'>&nbsp;<a href=\''.EE_HTTP.'index.php?t='.$tbl[$i]['id'].'\' target=\'_blank\'>View live version</a><br>';}
			
			//Если переменная "display_medias" не пустая то имитируем ситуацию когда все страницы и медии находятся в одной таблице
			$folder_position = htmlspecialchars($tbl[$i]['folder_pos'], ENT_QUOTES);
			if(!empty($_COOKIE['_assets_display_medias']))
			{
				$folder_position = 0;
			}
			
			$labels[] = '"'.
			'<b>'.htmlspecialchars($tbl[$i]['page_name'], ENT_QUOTES).'</b><br>'.
			'<i>'.htmlspecialchars($tbl[$i]['page_description'], ENT_QUOTES).'</i><br><br>'.
			'Folder: '.htmlspecialchars($tbl[$i]['folder'], ENT_QUOTES).'<br>'.
			'Template: '.$page_template.'<br>'.
			'Created: '.htmlspecialchars($tbl[$i]['create_date'], ENT_QUOTES)." by ".htmlspecialchars($tbl[$i]['owner_name'], ENT_QUOTES).'<br>'.
			'Modified: '.htmlspecialchars($tbl[$i]['edit_date'], ENT_QUOTES).'<br><br>'.
			'Cached: '.check_page_cached($tbl[$i]['id']).'<br>'.
			'<table border=0 cellpadding=0 cellspacing=0 style=\"border: 0px none #FFF !important;\">'.$publish.
			//////////'<tr><td>Security: All</td><td><img src=\''.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/doc_user.gif\' align=top width=16 height=16 alt=\'\' style=\'margin-left: 16px;\'>&nbsp;<a href=\'#\'>Change the access</a></td></tr>'.
			'</table>'.
			'Locked: '.htmlspecialchars($tbl[$i]['locked'], ENT_QUOTES).'<br><br>'.
			'<img src=\''.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/edit/doc_edit.gif\' align=top width=16 height=16 alt=\'\'>&nbsp;<a href=\''.EE_HTTP.'index.php?t='.$tbl[$i]['id'].'&amp;admin_template=yes&amp;from=assets\' target=\'_blank\'>Edit '.strtolower($tbl[$i]['page_type']).' content</a><br>'.
			'<img src=\''.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/doc_history.gif\' align=top width=16 height=16 alt=\'\'>&nbsp;<a href=\''.$edit_url.'\'>Edit '.strtolower($tbl[$i]['page_type']).' properties</a><br>'.
			'<img src=\''.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/copy.gif\' align=top width=16 height=16 alt=\'\'>&nbsp;<a href=\'javascript:copyPage('.$tbl[$i]['id'].', \"'.$tbl[$i]['page_name'].'\", \"'.$tbl[$i]['page_type'].'\");\'>Copy '.strtolower($tbl[$i]['page_type']).'</a><br>'.
			'<img src=\''.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/edit/doc_delete.gif\' align=top width=16 height=16 alt=\'\'>&nbsp;<a href=\'javascript:deletePage('.$tbl[$i]['id'].', \"'.$tbl[$i]['page_name'].'\", \"'.$tbl[$i]['page_type'].'\");\'>Delete '.strtolower($tbl[$i]['page_type']).'</a><br>'.
			//////////'<img src=\''.EE_HTTP.EE_HTTP_PREFIX_CORE.'img/doc_web.gif\' align=top width=16 height=16 alt=\'\'>&nbsp;<a href=\'#\'>Preview draft version</a><br>'.
			$live_version_text.
			'"';
			$f_id++;
		}
		
		$pages_return = 'YAHOO.example.Data = {'."\n".'pages: ['.implode(",\n", $cell).']'."\n".'};';
		
		$label_return = 'var pageLabelTexts = new Array('.implode(',', $labels).');';
		if(!empty($GLOBALS['return_pages_in_ajax']))//return xml
		{
			//if we return all pages content in 1 element we cant get it on client side because getElementById('node').nodeValue returns in Mozilla only 4 Kb
			$dom = new DOMDocument("1.0");
			$node = $dom->createElement("root");
			$parnode = $dom->appendChild($node);
			
			header("Content-type: text/xml"); 
			
			foreach($cell as $c)
			{
				$textnode = $dom->createTextNode("\r\n");
				$newtextnode = $parnode->appendChild($textnode);
				
				$c = replace_dangerous_xml_symbols($c);
				$node = $dom->createElement("pages", $c);
  				$newnode = $parnode->appendChild($node);
			}
			foreach($labels as $l)
			{
				$textnode = $dom->createTextNode("\r\n");
				$newtextnode = $parnode->appendChild($textnode);
				
				$l =replace_dangerous_xml_symbols($l);
				$node = $dom->createElement("labels", $l);
  				$newnode = $parnode->appendChild($node);
			}
			
			echo $dom->saveXML();
			exit;
		}
		else //return plain
		{
			return $pages_return.$label_return;
		}
	}
	
	function replace_dangerous_xml_symbols($text)
	{
		$text = str_replace("&nbsp;", "&#160;", $text);
		$text = str_replace("&", "&amp;", $text);
		return $text;
	}
	
	//отображаем список страниц
	function print_pages()
	{
		global $language, $return_medias_for_insert, $return_pages_for_menu;
		
		if(!empty($GLOBALS['return_pages_in_ajax']) && isset($_POST['folder_id'])) //return result for ajax
		{
			$folder_id = (int)$_POST['folder_id'];
		}
		else //just loaded page, non ajax
		{
			$folder_id = (isset($_COOKIE['_assets_expand_folder_id']))?$_COOKIE['_assets_expand_folder_id']:'0';
		}
		$tbl = array();//Неформатированые значения из БД
		//А что если пользователь хочет видет только медии в root таблице? Учитываем.
		if (empty($_COOKIE['_assets_display_medias']) || (isset($_COOKIE['_assets_display_medias']) && $_COOKIE['_assets_display_medias'] != 'medias'))
		{
			//pages
			if(!$return_medias_for_insert)
			{
				get_assets_content($tbl, 'v_tpl_page_content', $folder_id);
			}
		}
		//А что если пользователь хочет видет только страницы в root таблице? Учитываем.
		if (empty($_COOKIE['_assets_display_medias']) || (isset($_COOKIE['_assets_display_medias']) && $_COOKIE['_assets_display_medias'] != 'pages') || $return_medias_for_insert)
		{
			//media
			if(!$return_pages_for_menu)
			{
				get_assets_content($tbl, 'v_media_content', $folder_id);
			}
		}
		
		//Отсортируем массив по полю folder_pos
		// Obtain a list of columns
		$folder_pos = array();
		foreach ($tbl as $key => $row)
		{
			$folder_pos[$key] = $row['folder_pos'];
		}
		// Sort the data with folder_pos ascending
		// Add $tbl as the last parameter, to sort by the common key
		if(sizeof($folder_pos)>0)
		{
			array_multisort($folder_pos, SORT_ASC, $tbl);
		}
		//Выводим страницы и медии вместе
		return show_pages_n_media($tbl);
	}

	// список полей в окне редактирования
	function print_fields()
	{
		return include('print_fields.php');
	}

	// добавление/сохранение записи
	function save()
	{
		//global $object_id;
		//return object_save($object_id);
	}

	// удаление папки
	function assets_delete_folder()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del_tpl_folder', array($del));

		header($url);
	}

	// удаление файла
	function delete_page()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del_tpl_page', array($del));

		header($url);
	}

	//удаление медии
	function delete_media()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del_media', array($del));

		header($url);
	}

	include ('rows_on_page.php');

	//копирование страницы
	function copy_page()
	{
		global $copypage, $modul, $url, $type;

		RunNonSQLFunction('f_copy_tpl_page', array($copypage, $type));

		header($url);
	}

	//Обновляем время модификации страницы
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

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'access_mode'
			),
			'db_funcs'  => array (),
			'pages_on_nonexisting_templates'  => array ()
		);

		return parse_self_test($ar_self_check);
	}

	function edit_config()
	{
		$use_draft_content 	= (isset($_POST['use_draft_content']) ? $_POST['use_draft_content'] : '0');
		$use_cache		= (isset($_POST['use_cache']) ? $_POST['use_cache'] : '0');
		$after_save_action	= (isset($_POST['DM_Action']) ? $_POST['DM_Action'] : '');

		if (post('refresh') && (config_var('use_draft_content') != $use_draft_content || config_var('ee_cache_html') != $use_cache))
		{
			if ($after_save_action == 'publish_all')
			{
				publish_all_cms();
			}
			else if ($after_save_action == 'revert_all')
			{
				revert_all_cms();
			}

			if ($_POST['use_cache'] != '1')
			{
				delete_cache();
			}
			// delete sitemap.xml cache
			delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
		}

		return include('print_edit_config.php');

	}
	
	function move_files()
	{
		//error_reporting(E_ALL);
		global $modul;
		if (post('refresh'))
		{
			if(is_array($_POST['files']) && isset($_POST['folder']))
			{
			$_POST['files'] = array_map("sqlValue", $_POST['files']);
			$files = implode(',', $_POST['files']);
			$folder_id = (empty($_POST['folder']))?'NULL':sqlValue($_POST['folder']);
			RunSQL('UPDATE tpl_pages SET folder_id = '.$folder_id.' WHERE id IN('.$files.')', 0);
			}
			close_popup('yes');
		}
		return parse($modul.'/move_files');
	}
	
	// список полей в окне редактирования
	function print_move_files_fields()
	{
		global $fields, $hidden, $mandatory, $readonly, $type, $caption;
		$fields = array('selected_files', 'folder');
		$hidden = array();
		$mandatory = array('tpl_folder');
		$type['folder'] = "select_tpl_folder";
		$type['selected_files'] = "empty";
		$caption['folder'] = "Select destination folder";
		$selected_files = explode(',', $_GET['selected_files']);
		$selected_files_caption = '<p>&nbsp;&nbsp;Selected files</p><ul>'."\n";
		if(is_array($selected_files))
		{
			foreach($selected_files as $file)
			{
				$res = explode('=', $file);
				$selected_files_caption .= '<li>'.$res[0].'</li><input type="hidden" name="files[]" value="'.$res[1].'">'."\n";
			}
		}
		$selected_files_caption .= '</ul>'."\n";
		$caption['selected_files'] = $selected_files_caption;
		$mandatory = $readonly = array();//for disable warning in print_fields.php file
		return include('print_fields.php');
	}
	
	//Узнаем id последней открытой папки
	function get_curr_folder_id()
	{
		if(isset($_GET['folder']) || isset($_GET['page']))//параметр $_GET['folder'] важнее $_COOKIE['_assets_expand_folder_id']
		{
			if(isset($_GET['page']))
			{
				$sql = 'SELECT IF(folder_id IS NULL, 0, folder_id) AS folder_id FROM `v_tpl_page_content` WHERE `id`="'.addslashes((int)$_GET['page']).'" GROUP BY `folder_id` ORDER BY `folder_id` LIMIT 0,1';
				//echo $sql; exit;
				$rs = viewsql($sql, 0);
				if(db_sql_num_rows($rs) > 0)
				{
					return db_sql_result($rs, 0, 'folder_id');;
				}
				else
				{
					return 0;//файл не существует
				}
			}
			else
			{
				$sql = 'SELECT `id` FROM `v_tpl_folder` WHERE `id`=\''.addslashes((int)$_GET['folder']).'\' GROUP BY `id` ORDER BY `id` LIMIT 0,1';
				//echo $sql; exit;
				$rs = viewsql($sql, 0);
				if(db_sql_num_rows($rs) > 0)
				{
					return (int)$_GET['folder'];
				}
				else
				{
					return 0;//папка не существует
				}
			}
		//Если человек попал на страницу впервые надо для него развернуть все папки до текущей
		//этим займется функция expand_folders()
		}
		else if(isset($_COOKIE['_assets_expand_folder_id']))
		{
			return $_COOKIE['_assets_expand_folder_id'];
		}
		else
		{
			return '0';
		}
	}
	
	function get_folder_content()
	{
		$GLOBALS['return_pages_in_ajax']=1;
		print_pages();
	}
	
	function get_folders_list()
	{
		$GLOBALS['return_folders_in_ajax']=1;
		print_folders();
	}
	
	function assets_search()
	{
		get_folder_content();
	}
	
	function get_assets_view_list($tpl, $page_id, $page_name, $type)
	{
		if($type) return;//if media skip search
		
		global $assets_view_list_array, $modul;

		if (empty($assets_view_list_array))
		{
			$assets_view_list_array = create_assets_view_list();
		}

		$result = '';

		$j = 0;
		$row_result = array();

		for ($i=0; $i < sizeof($assets_view_list_array); $i++)
		{
			if(is_array($assets_view_list_array[$i]))
			{
				$str_path_format = EE_PATH."%s".'templates/VIEWS/'.$assets_view_list_array[$i]['view_folder'].'/'.$tpl.'.tpl';

				if (file_exists(sprintf($str_path_format, ''))
					||
			   		file_exists(sprintf($str_path_format, EE_HTTP_PREFIX_CORE)))
				{
					$row_result[$j]['id'] = $page_id;
					$row_result[$j]['name'] = $page_name;
					foreach($assets_view_list_array[$i] as $key => $value)
					{
						$row_result[$j][$key] = $value;
					}
					$j++;
				}
			}
		}

		$result .= parse_array_to_html($row_result, 'templates/'.$modul.'/views_row');

		return trim($result);
	}
	
	//Перегоняем sql результат в массив
	function create_assets_view_list()
	{
		$sql = 'SELECT view_name, icon, view_folder FROM tpl_views';
		$res = viewSQL($sql);
		$result = array();
		
		if(db_sql_num_rows($res) > 0)
		{
			while($row = db_sql_fetch_assoc($res))
			{
				$result[] = array('view_name'=>$row['view_name'], 'icon'=>$row['icon'], 'view_folder'=>$row['view_folder']);
			}
		}
		
		return $result;
	}

	//function determine what type should be deleted - page or media and call function for this operations
	function delete_selected_items_by_type()
	{
		if(array_key_exists('selected_items', $_POST) && count($_POST['selected_items']) > 0)
		{
			$items_in_db = viewSql('SELECT id, type FROM v_tpl_non_folder WHERE id in('.sqlValuesList($_POST['selected_items'], true).')');
			if(db_sql_num_rows($items_in_db) > 0)
			{
				$page_items = $media_items = array();
				while($item_in_db = db_sql_fetch_assoc($items_in_db))
				{
					if($item_in_db['type'] == '1')
					{
						$media_items[] = $item_in_db['id'];
					}
					else
					{
						$page_items[] = $item_in_db['id'];
					}
				}
				if(sizeof($page_items) > 0)
				{
					f_del_tpl_pages($page_items);
				}
				if(sizeof($media_items) > 0)
				{
					f_del_medias($media_items);
				}
			}
		}
	}

//********************************************************************
	switch ($op)
	{
		default:
		case '0':
			$assets_list = parse_tpl($modul.'/assets_list');
			echo $assets_list;
			break;

		case '1': echo save();break;
		case 'delete_folder': assets_delete_folder();break;
		case 'delete_page': delete_page();break;
		case 'delete_media': delete_media();break;
		case 'del_sel_items':delete_selected_items_by_type();echo parse($modul.'/assets_list');break;
		case 'copy_page':copy_page();break;
		case 'delete_all_cache': delete_cache();header($url);break;
		case 'refresh_page_date':refresh_page_date();header($url);break;
		case 'delete_page_cache_for_all_lng':delete_cache($t);header($url);break;//
		case '3': echo save();break;
		case 'publish':
			publish_cms_on_page($t);
			delete_cache($t);
			if (get('media'))
			{
				publish_media_on_page($t);
			}
			header($url);
			break;
		case 'revert':
			revert_cms_on_page($t);
			if (get('media'))
			{
				revert_media_on_page($t);
			}
			header($url);
			break;
		case 'publish_page':
			publish_page($t);
			if (get('media'))
			{
				publish_media_on_page($t);
			}
			header($url);
			break;
		case 'publish_all':
			publish_all_cms();
			delete_cache();
			sitemapindex_files_delete();
			header($url);
			break;
		case 'revert_all':
			revert_all_cms();
			header($url);
			break;
		case 'publish_common':
			publish_common_cms();
			delete_cache();
			sitemapindex_files_delete();
			header($url);
			break;
		case 'revert_common':
			revert_common_cms();
			header($url);
			break;
		case 'publish_sel_items':
			publish_cms_on_page($selected_items);
			publish_media_on_page($selected_items);
			delete_cache($t);
			header($url);
			break;
		case 'revert_sel_items':
			revert_cms_on_page($selected_items);
			revert_media_on_page($selected_items);
			header($url);
			break;

		case 'config': echo edit_config(); break;
		case 'move_files': echo move_files(); break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'get_folder_content': get_folder_content(); break;
		case 'get_folders_list': get_folders_list(); break;
		case 'search': assets_search(); break;

		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
	}
	
$time_end = microtime(true);
$time = $time_end - $time_start;
echo '<!-- script run '.$time.' seconds -->';
?>