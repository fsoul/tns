<?
	$modul = basename(__FILE__, '.php');
	if(!isset($op)) $op=0;
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!checkAdmin() or ($UserRole!=ADMINISTRATOR and $UserRole!=POWERUSER))
	{
		echo parse('norights');
		exit;
	}

	if (get('f_name'))
	{
//msg($f_name, '$f_name 0');
		$f_name = $_GET['f_name'] = reduce_path_to_canonical($_GET['f_name']);
//msg($f_name, '$f_name 1');
		$folders = explode('/', $f_name);
		$top_folder = $folders[1];

		if (!check_folder_permissions(trim($top_folder, ' /'), $UserId))
		{
			echo parse('norights');
			exit;
		}
	}

	if (!empty($save))
	{
//msg(2);
		$error = array();
		$aName = $f_name.'/'.$aName;

		$new_path = check_file_name($aName);

//msg($new_path, '$new_path');
		if (check_dir($new_path))
		{
			$error['aName'] = 'Target Directory "'.$aName.'" already exists';
		}
		else
		{
			$new_path = rtrim($new_path, '/');
//msg($new_path, '$new_path');

			$pos = strrpos($new_path, '/');

			if ($pos != 0)
			{
				$pf = substr($new_path, 0, $pos);
			}
//msg($pf, 'pf');

			if (check_dir(add_file_path($pf)))
			{
//msg(3);
				$res = ftp_create_folder(add_img_path($new_path));
			}
			else
			{
//msg(4);
				$error['aName'] = 'Directory name is invalid !';
//vdump($res, '$res');
			}
		}

		if (count($error)==0)
		{
?>
<script language="JavaScript">
	window.parent.closePopup('yes');
</script>
<?			exit;
		}
//vdump($error, '$error');
	}

//********************************************************************
	if ($op==2)
	{
		$pageTitle = 'Delete Folder error';

		$full_path = add_file_path($f_name.'/');
//vdump($full_path, '$full_path');

		if (check_dir($full_path))
		{
//vdump($full_path, '$full_path');
			$fld = walk_dir($full_path);
			$flf = walk_file($full_path);

			if (count($fld)>0 or count($flf)>0)
			{
				$error = 'Directory "'.$f_name.'" is not empty';
				echo parse_popup($modul.'/error');
				exit;
			}
			else
			{
				$res = ftp_delete_folder($full_path);
//vdump($res, '$res');
//exit;
				header('Location: _files.php?folder='.$_GET['folder']);
				exit;
			}
		}
		else
		{
			$error = 'Directory "'.$f_name.'" is not exists';
			echo parse_popup($modul.'/error');
			exit;
		}
	}
	else
	{
		$pageTitle = 'Add Folder to "'.$f_name.'"';
		echo parse_popup($modul.'/list');
	}




?>