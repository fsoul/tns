<?
	$modul='file';
	if(!isset($op)) $op=0;
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!checkAdmin() or !($UserRole==ADMINISTRATOR or $UserRole==POWERUSER or $UserStatus==ADMINISTRATOR))
	{
		echo parse('norights');
		exit;
	}

	if (get('f_name'))
	{
		$f_name = $_GET['f_name'] = '/'.ltrim($f_name, '/');

		$folders = explode('/', $f_name);
		$top_folder = $folders[1];

		if (!check_folder_permissions(trim($top_folder,' /'), $UserId))
		{
			echo parse('norights');
			exit;
		}
	}

	global $f_name, $error, $folder, $admin_template, $aFile;

	$f_name = ltrim($f_name, '/');

if (empty($close))
{
	if (!empty($save))
	{
		$admin_template = $_POST['admin_template'];
		$error = '';

//msg($op, '$op');
		switch($op)
		{
			case '0':

			$old_path = $f_name;
//msg($old_path, '$old_path');
			$new_path = check_file_name($aFile);

			$new_path = rtrim($new_path, '/');
//msg($new_path, '$new_path');

			if (check_file($new_path))
			{
//vdump(check_file($new_path), 'check_file('.$new_path.')');

				$error = 'Target file "'.$aFile.'" already exists';
			}
			else
			{

//msg($new_path, '$new_path 1');
//msg($new_path, '$new_path 2');
				$pos = strrpos($new_path, '/');

				if ($pos != 0)
				{
					$pf = substr($new_path, 0, $pos);
				}
				else
				{
					$pf = '';
				}
//msg($pf, '$pf');
//vdump(add_file_path($pf), 'add_file_path('.$pf.')');

				if (check_dir(add_file_path($pf)))
				{
					$res = ftp_rename_file($old_path, $new_path);
//vdump($res, '$res');
				}
				else
				{
					$error = 'There is no such Target Directory "'.$pf.'"';
//msg($error, '$error');
				}
			}

                        break;


			case '1':
//vdump($_FILES, 'FILES');
			for ($i = 0; $i < (getCorrectFileNumber()); $i++) //	foreach ($_FILES as $k=>$file)
			{
		  		$aFile = $_FILES['file_'.$i]['tmp_name'];
//msg($aFile, '$aFile');
				if ($aFile)
				{
//msg($f_name, '$f_name');
					$file_name = $_FILES['file_'.$i]['name'];
//msg($file_name, '$file_name');
	                        	
					// change all illegal symbols to underscores
					$new_path = check_file_name($f_name.'/'.$file_name);
//msg($new_path, '$new_path');
					if ($_FILES['file_'.$i]['size']==0)
					{
						$error = 'File "'.$file_name.'" upload error';
					}
					else
					{
						$res = ftp_upload($aFile, $new_path);
//vdump($res, '$res');
					}
				}
			}

			break;
		}

		if ($error=='')
		{
			header('Location: file.php?close=true');
			exit;
		}
		else
		{
			$error = '<tr><td bgcolor="#EFEFDE" colspan="2" class="error" height="20" align="center">'.$error.'</td></tr>';
		}
	}

	if ($op==0)
	{
		$pageTitle = 'Rename/Move File:&nbsp;&nbsp;'.$f_name;
	}
	else
	{
		$pageTitle = 'Add File to folder "'.((empty($f_name)?'/':$f_name)).'"';
	}
//********************************************************************
	if ($op==0)
	{
		echo parse($modul.'/rename');
	}
	elseif ($op==2)
	{
		$pageTitle = 'Delete File error';
		$old_path = $f_name;

		if ($check = check_file(add_file_path($old_path)))
		{
			$res = ftp_delete_file($old_path);
			header('Location: _files.php?folder='.$_GET['folder']);
			exit;
		}
	}
	else
	{
		echo parse_popup($modul.'/list');
	}
}
else
{?><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<script language="JavaScript">
	window.parent.closePopup('yes');
</script>
</body>
</html>
<?}


function getCorrectFileNumber()
{
	return (substr(key($_FILES), strpos(key($_FILES), '_')+1));

}

?>