<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;

//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 500; 

	if (!defined('ADMIN_MENU_ITEM_FILES')) define('ADMIN_MENU_ITEM_FILES','Resources/File Manager|10');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_FILES);
	if (get('folder'))
	{
		$folders = explode('/',$folder);
		$top_folder = $folders[1];
		if (!check_folder_permissions(trim($top_folder,' /'), $UserId)) {echo parse('norights');exit;}
	}
	$sort[1]='id';
	$sort[2]='fileType';
	$sort[3]='name';
	load_stored_values($modul);
	$order=getSortOrder();

//********************************************************************
//********************************************************************
function file_list()
{
	// todo: rewrite all function using parse_array/sql_to html
	global $folder, $folderIcon, $doc_section, $modul, $UserRole, $UserId;

	$files = array();
	$pf = '';
	if ($folder!='')
	{
		$folder = str_replace('..','',$folder);
		$folder = str_replace('//','/',$folder);
		$pos = strrpos($folder,'/');

		if ($pos!=0)
		{
			$pf = substr($folder,0,$pos);
		}
	}
	$folder.= '/';
	$folder = str_replace('//','/',$folder);

	if (!file_exists(EE_FILE_PATH.$folder) or !is_dir(EE_FILE_PATH.$folder))
	{
		$folder = '/';
	}

	$fld = walk_dir(EE_FILE_PATH.$folder);
	$flf = walk_file(EE_FILE_PATH.$folder);

	$admin = true;
	$html_img_lst = '<tr>';

	if ($admin)
	{
		$html_img_lst.= '<td>'.inv(15).'</td><td>'.inv(15).'</td>';
	}

	$html_img_lst.= '<td width="22px">&nbsp;</td><td height="20"><a href="?t=index">'.print_f_icon('', '_folder', '.').'</a></td>
<td>&nbsp;<a href="?t=index">.</a></td>
<td>&nbsp;</td><td width="100%">&nbsp;</td>
</tr>
';

	$html_img_lst.= '<tr>';

	if ($admin)
	{
		$html_img_lst.= '<td>'.inv(15).'</td><td>'.inv(15).'</td>';
	}

	$html_img_lst.= '<td width="22px">&nbsp;</td><td height="20" width="16"><a href="?t=index&folder='.$pf.'">'.print_f_icon('', '_folder', '..').'</a></td>
		<td>&nbsp;<a href="?t=index&folder='.$pf.'">..</a></td>
		<td>&nbsp;</td><td>&nbsp;</td>
	</tr>';

	if (is_array($fld))
	{
		natcasesort($fld);

		foreach ( $fld as $file)
		{
			if ($folder == '/' && !check_folder_permissions($file, $UserId))
			{
				continue;
			}

			$file = preg_replace("#//+#", '/', $file);
			$folder_urs_alt = '"'.cons('Assign users for folder').' &quot;'.$file.'&quot;"';
			$folder_del_alt = '"'.cons('Delete folder').' &quot;'.$file.'&quot;"';
			$html_img_lst.= '<tr>
<td>'.			(($UserRole == ADMINISTRATOR && $folder == '/')?'<a href="#" onclick="openPopup(\''.EE_ADMIN_URL.$modul.'.php?op=set_permissions&folder='.$file.'\', 400, 100)"><img src="'.EE_HTTP.'img/menu/user.gif" width="16" height="16" alt='.$folder_urs_alt.' title='.$folder_urs_alt.' border="0"></a>':'&nbsp;').'</td>
<td>'.			(($UserRole == ADMINISTRATOR || $folder != '/')?'<a href="#" onclick="del_folder(\''.$folder.$file.'\')"><img src="'.EE_HTTP.'img/delBt.gif" width="15" height="15" alt='.$folder_del_alt.' title='.$folder_del_alt.' border="0"></a>&nbsp;&nbsp;':'&nbsp;').'</td>
<td><input type = "checkbox" name = "selected_items[]" value = "'.$folder.$file.'" /></td>
<td height="20" width="16"><a href="?t=index&folder='.$folder.$file.'">'.print_f_icon('', '_folder', $file).'</a></td>
<td nowrap="1">&nbsp;<a href="?t=index&folder='.$folder.$file.'">'.$file.'</a>&nbsp;&nbsp;</td>
<td>&nbsp;</td><td width="100%" class="error">'.getError($folder.$file).'&nbsp;</td>
</tr>
';
		}
	}

	if (is_array($flf) && ($folder != '/' || $UserRole == ADMINISTRATOR))
	{
		natcasesort($flf);

		foreach ($flf as $file)
		{
			$file = preg_replace("#//+#", '/', $file);

			$html_img_lst.= '<tr>';

			if ($admin)
			{
				$html_img_lst.= '
<td>&nbsp;</td><td><a href="#" onclick="del_file(\''.$folder.$file.'\')"><img src="'.EE_HTTP.'img/delBt.gif" width="15" height="15" alt="delete" title="Delete File '.$file.'" border="0"></a></td>
<td><input type="checkbox" name="selected_items[]" value="'.$folder.$file.'"/></td>';

			}

			$html_img_lst.='
<td height="20" width="16">'.print_f_icon(getFileType(EE_FILE_PATH.$folder.$file)).'</td>
<td nowrap="1">&nbsp;<a href="'.($file_link = substr(EE_FILE_HTTP.$doc_section,0,-1).$folder.$file).'" target="_blank">'.$file.'</a>&nbsp;&nbsp;</td>
<td align="right" style="padding:0px 20px;">'.format_f_size(filesize(EE_FILE_PATH.$folder.$file)).'</td><td nowrap="1">'.$file_link.'</td>
</tr>
';
		}
	}
	return $html_img_lst;
}

function set_permisions()
{
	global $UserRole, $modul, $folder, $pageTitle;

	$pageTitle = 'Assign users for folder /'.$folder.'/';

	if ($UserRole < ADMINISTRATOR)
	{
		echo parse('norights');
		exit;
	}

	if (post('refresh'))
	{
		$r = ViewSQL('SELECT * FROM users WHERE role='.sqlValue(POWERUSER));

		while ($row = db_sql_fetch_assoc($r))
		{
			if (post('user_'.$row['id']) == 1)
			{
				set_folder_permissions($folder, $row['id'], true);
			}
			else
			{
				set_folder_permissions($folder, $row['id'], false);
			}
		}

		close_popup('yes');
	}
	else
	{
		return parse_popup($modul.'/set_permissions');
	}
}

function del()
{
	if (array_key_exists('selected_items', $_POST))
	{
		foreach($_POST['selected_items'] as $value)
		{
			$f_from_manager = add_file_path($value);

			if (check_file($f_from_manager))
		        {
				$res = ftp_delete_file($value);
			}
			elseif (check_dir($f_from_manager))
			{
				if (!($res = ftp_delete_folder($value)))
				{
					global $error;

					$error[$value] = 'Can\'t delete folder. Verify if it\'s empty.';
				}
			}
		}
	}
}



function print_self_test()
{
	global $modul;

	$ar_self_check[$modul] = array (

		'php_functions' => array (
			'file_list'),
		'php_ini' => array (),
		'constants' => array (
			'EE_FILE_PATH'),
		'db_tables' => array (),
		'db_funcs'  => array (),

		'ftp_dir_exists' => array(
			EE_IMG_PATH
		),

		'ftp_dir_attributes' => array(
			EE_IMG_PATH => EE_DEFAULT_DIR_MODE
		)
	);

	return parse_self_test($ar_self_check);
}

	switch ($op)
	{
		default:
		case '0':
			echo parse($modul.'/list');
			break;

		case 'delete_selected':
			del();

			global $error;

			if (is_array($error) && count($error)>0)
			{
				echo parse($modul.'/list');
			}
			else
			{
				// 10447
				// prevent post-form resending
				header('Location: '.EE_URI);
			}

			break; 

		case 'self_test':
			echo print_self_test();
			break;

		case 'set_permissions':
			echo set_permisions();
			break;
	}

?>