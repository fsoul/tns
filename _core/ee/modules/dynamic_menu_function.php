<?

function prepare_menu_str($arr, $level = 1)
{
	global $UserRole;
//	checkAdmin();
	$ret = '';
//vdump($arr);
	if (is_array($arr))
	foreach($arr as $k => $v)
	{
		if (is_array($v) && (empty($v['UserRole']) || in_array($UserRole, explode(',', $v['UserRole']))))
		{
			for ($i=0; $i<$level; $i++)
			{
				$ret.= '.';
			}

			if (!array_key_exists('Link', $v))
			{
				$v['Link'] = '';
			}

			if (!array_key_exists('Hint', $v))
			{
				$v['Hint'] = '';
			}

			if (!array_key_exists('Icon', $v))
			{
				$v['Icon'] = '';
			}

			$ret .= '|'.substr($k, (strpos($k, '_')!==false?strpos($k, '_')+1:0)).'|'.$v['Link'].'|'.$v['Hint'].'|'.$v['Icon']."\r\n";

			if (array_key_exists('Submenu', $v))
			{
				$ret.= prepare_menu_str($v['Submenu'], $level+1);
			}
		}
	}

	return $ret;
}

function parse_modules_to_menu_array($ar_menu, $ar_black_list=array())
{
//vdump(EE_CORE_PATH.EE_ADMIN_SECTION);
	// if something wrong is passed to function as 2nd argument -
	// let it be an empty array for no errors in next code
	if (!is_array($ar_black_list))
	{
		$ar_black_list = array();
	}

	//todo: use function dir_to_array() instead of opendir

	// modules name array
	$admin_modules_arr 	 = array();
	// modules name position array (if is true then module in custom-part, else - in _CORE)  
	$admin_modules_is_custom = array();

	//First get all admin-modules (like admin/_*.php) from custom part if it exists.
	if(file_exists(EE_ADMIN_PATH))
	{
		$handle = opendir(EE_ADMIN_PATH);
		//Save them into array $admin_modules_arr
		while (false !== ($file = readdir($handle)))
		{
			$admin_modules_arr[] = $file;
			$admin_modules_arr_is_custom[] = true;
		}
	}

	//After that get admin-modules from _CORE part, and if module with such name already exist, then do not restore it again
	$handle = opendir(EE_CORE_ADMIN_PATH);
	//Add _CORE-modules into $admin_modules_arr
	while (false !== ($file = readdir($handle)))
	{
		if (!in_array($file, $admin_modules_arr))
		{
			$admin_modules_arr[] = $file;
			$admin_modules_arr_is_custom[] = false;
		}
	}

	foreach($admin_modules_arr as $key => $val)
	{
		if (	preg_match('/^_.*\.php$/i', $val) &&
			!in_array($val, $ar_black_list)
		)
		{
			$__new_admin_modules_arr[$key] = $val;
		}
	}

	$__count_loaded		= 0;
	$__count_all_modules	= count($__new_admin_modules_arr);

	foreach($__new_admin_modules_arr as $m_key => $file)
	{
		// pass UserRole and UserName for check_modul_rights()
		$post_url = (($admin_modules_arr_is_custom[$m_key]) ? EE_ADMIN_URL.$file : str_replace(EE_ADMIN_SECTION_IN_HTACCESS, EE_ADMIN_SECTION, EE_CORE_ADMIN_URL.$file));

		$tmp =  post_url(
			$post_url,
			array (	'op'=>'menu_array',
				'UserRole'=>$_SESSION['UserRole'],
				'UserName'=>$_SESSION['UserName']
			)
		);
		// Clear uncknown \n etc...
		$tmp = trim($tmp);

		if (!empty($tmp))
		{
			$__current_module 	= $file;
			$__count_loaded 	= $__count_loaded + 1;

			$_SESSION['__LOADED_MODULES__'] = $__count_all_modules.';'.$__count_loaded.';'.$__current_module;

			session_write_close();

			session_name(EE_HTTP_PREFIX);
			session_start();

			//get sort values from $tmp if it is indicate in format: <level1>[|<sort1>]/<level2>[|<sort2>]/<level3>[|<sort3>].
			//examples: "Artel|150/Works" it`s mean "Artel/Works" and sort=150 for level 1
			//          " News|500 / Day|1000 / Title|10"
			$ar_tmp = array();
			$ar_sort = array();
			$ar_name_sort = explode('/', $tmp);
			foreach($ar_name_sort as $v)
			{				
				$ar_buf = explode('|', $v);				
				$ar_tmp[] = $ar_buf[0];
				$ar_sort[] = (isset($ar_buf[1])) ? intval($ar_buf[1]) : 0;	
			}

			if ($ar_tmp[count($ar_tmp)-1] == 'popup')
			{
				$is_popup = true;
				array_pop($ar_tmp);
			} else $is_popup = false;

			$module_name = substr(basename($file, '.php'), 1);

			switch (count($ar_tmp))
			{
				case 1:
					$parent_menu = null;
					$menu_key = $ar_tmp[0];
					$sortvalue = $ar_sort[0];
					break;
       	
				case 2:
					$parent_menu = $ar_tmp[0];
					$menu_key = $ar_tmp[1];
	       	
					if (empty($ar_menu[$ar_tmp[0]]))
					{
						$ar_menu[$ar_tmp[0]] = array(
							'Icon' => str_replace(' ','_',strtolower($ar_tmp[0])).'.gif'
						);
					}
			
					if ($ar_sort[0] != 0)
					{
						$ar_menu[$ar_tmp[0]]['Sort'] = $ar_sort[0];
					}
				       	
					$sortvalue = $ar_sort[1];			       	
					break;

				case 3:

					$parent_menu = $ar_tmp[1];
					$menu_key = $ar_tmp[2];

					if (empty($ar_menu[$ar_tmp[0]]))
					{
						$ar_menu[$ar_tmp[0]] = array(
							'Icon' => str_replace(' ','_',strtolower($ar_tmp[0])).'.gif'
						);
					}

				 	if ($ar_sort[0] != 0)
					{
						$ar_menu[$ar_tmp[0]]['Sort'] = $ar_sort[0];
					}

					if (empty($ar_menu[$ar_tmp[1]]))
					{
						$ar_menu[$ar_tmp[1]] = array(
							'Icon' => str_replace(' ','_',strtolower($ar_tmp[1])).'.gif',
							'parent_menu' => $ar_tmp[0]
						);
					}

				 	if ($ar_sort[1] != 0)
					{
						$ar_menu[$ar_tmp[1]]['Sort'] = $ar_sort[1];
					}

					$sortvalue = $ar_sort[2];

					break;
			}

			$ar = array(
				'Link' => ($is_popup?'javascript:openPopup(\'':'').EE_ADMIN_URL.$file.($is_popup?'\',600,500,0);':''),
				'Hint' => $file.'-menu hint',
				'Icon' => $module_name.'.gif',

				'parent_menu' => $parent_menu,
			);

			if ($sortvalue != 0)
			{
				$ar['Sort'] = $sortvalue;
			}

			$ar_menu[$menu_key] = $ar;

			// add config menu item for current module
			if (check_file(($admin_modules_arr_is_custom[$m_key])?EE_ADMIN_PATH:EE_CORE_ADMIN_PATH.'templates/'.basename($file,'.php').'/edit_modul_config_row.tpl') && $parent_menu != 'Configuration')
			{
				$ar = array(
					'Link' => 'javascript:openPopup(\''.EE_ADMIN_URL.$file.'?op=config\',600,500,1);',
					'Hint' => $file.'-menu hint',
					'Icon' => $module_name.'.gif',
					'parent_menu' => 'Configuration',
				);
				$ar_menu[$menu_key.' Config'] = $ar;
			}

			$_SESSION['arr_admin_menu_titles'][$file] = $menu_key;
		}
	}

	$ar_menu = array_multisort_by_keys($ar_menu, SORT_DESC);

	$res = build_menu_tree($ar_menu);

	return $res;
}

function check_parent_menu($ar, $parent_menu_name)
{
	if (!array_key_exists('parent_menu',$ar))
		$tmp = '';
	else
		$tmp = $ar['parent_menu'];

	return ($tmp == $parent_menu_name);
}

function build_menu_tree($ar_menu, $parent_menu_name='')
{
	$ar_tree = array();

	$ar_tmp = array_filter_by_value($ar_menu, 'check_parent_menu', $parent_menu_name);

	if (is_array($ar_tmp) and count($ar_tmp)>0)
	{
		foreach ($ar_tmp as $menu_name=>$menu_properties)
		{
			unset($ar_menu[$menu_name]['parent_menu']);
			$ar_tree[$menu_name] = $ar_menu[$menu_name];
			$ar_tree[$menu_name]['Submenu'] = build_menu_tree($ar_menu, $menu_name);
		}                                              
	}
	else
	{
		$ar_tree = array(); //$ar_menu[$parent_menu_name];
	}

	return $ar_tree;
}

function generate_dyn_menu($ar_black_list=array())
{
	global $admin_template, $UserRole, $menuType, $admin_menu, $modul;
	global $page_folder, $page_name;

	if (is_in_admin() && CheckAdmin() && ($UserRole==ADMINISTRATOR or $UserRole==POWERUSER))
	   
	{
		include EE_CORE_PATH.'lib/dynamic_menu/browser_detection.php';
		include EE_CORE_PATH.'lib/dynamic_menu/phplib_class.php';
		include EE_CORE_PATH.'lib/dynamic_menu/layersmenu_class.php';

		if (!isset($_SESSION['arr_admin_menu']))
		{
			ini_set('max_execution_time', 0);
			//top level of dynamic menu items initialisation
			$_SESSION['arr_admin_menu'] = dynamic_menu_top_init() + generate_favorite_links();

			$_SESSION['arr_admin_menu'] = parse_modules_to_menu_array($_SESSION['arr_admin_menu'], $ar_black_list);
			foreach ($_SESSION['arr_admin_menu'] as $key => $val)
			{
				if (is_array($_SESSION['arr_admin_menu'][$key]['Submenu']))
				{
					ksort($_SESSION['arr_admin_menu'][$key]['Submenu'], SORT_STRING);
				}
			}
		}
		
		if ($menuType == 'DOM' || $menuType == 'OLD')
			$mid = new LayersMenu();
		else
			$mid = new PlainMenu();
		$menu_arr = $_SESSION['arr_admin_menu'];

		// todo: activate code below
//		if (!empty($modul)) unset($menu_arr['Administration']['Submenu']['Page properties'], $menu_arr['Administration']['Submenu']['Page Aliases']);

		$mid->setMenuStructureString(prepare_menu_str($menu_arr));
		$mid->parseStructureForMenu('homemenu');

		$admin_menu = '';

		if ($menuType == 'DOM' || $menuType == 'OLD')
		{
			$mid->newHorizontalMenu('homemenu');
			$admin_menu.= $mid->printHeader();
			$admin_menu.= $mid->printMenu('homemenu');
			$admin_menu.= $mid->printFooter();
		}
		else
		{
			$admin_menu.= '<table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td valign="top">';
			$admin_menu.= $mid->newPlainMenu('homemenu');
			$admin_menu.= '</td><td valign="top">';
			$admin_menu.= '</td></tr></table>';
		}
	}
}

function generate_favorite_links()
{
	$arr_links = config_var('favorite_links');
	if (!empty($arr_links))	$arr_links = unserialize($arr_links);
		else return array();
	$arr_menu = array();
	foreach ($arr_links as $k=>$v)
	{
		$domain_start = (strpos($v['URL'], '//')===false?0:(strpos($v['URL'], '//')+2));
		$domain_end = (strpos($v['URL'], '/', $domain_start+2)===false?strlen($v['URL']):strpos($v['URL'], '/', $domain_start+2));
		$icon_link = 'http://'.substr($v['URL'],$domain_start, $domain_end - $domain_start).'/favorite_links.gif';
		$arr_menu[$v['title']] = array (
						'Link' => $v['URL'].'" target="_blank',
						'Hint' => $v['title'],
						'Icon' => $icon_link,
						'parent_menu' => ADMIN_MENU_ITEM_FAVORITE_LINKS
					); 
	}
	return $arr_menu;
}


