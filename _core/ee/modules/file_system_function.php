<?

/*
 * Delete all files in directory
 */
function clear_dir($dir_name)
{
	if (!file_exists($dir_name))
	{
		trigger_error('Directory you try to clear is not exists: '.$dir_name);

		$result = false;
	}
	elseif (!is_dir($dir_name))
	{
		trigger_error($dir_name.' is file, not directory - it is impossible to delete files from it.');

		$result = false;
	}
	elseif (!is_writeable($dir_name))
	{
		trigger_error('Directory '.$dir_name.' is not writeable, it is impossible to delete files from it.');

		$result = false;
	}
	elseif ($dh = opendir($dir_name))
	{
		while ($file = readdir($dh))
		{
			delete_file($dir_name.$file);
		}

		closedir($dh);

		$result = true;
	}
	else
	{
		trigger_error('Can\'t open directory '.$dir_name.'.');

		$result = false;
	}

	return $result;
}

function get_file_extension($file)
{
	if (strpos($file, '.')===false)
	{
		$ext = '';
	}
	else
	{
		$ar_ext = explode('.', $file);
		$ext = $ar_ext[count($ar_ext)-1];
	}

	return $ext;
}


/**
 *  This function was written, because the function mime_content_type works not always. 
 */
function mime_content_type_ext($file)
{
	$result = 'application/octet-stream';

	$ext = get_file_extension($file);

	foreach (file(EE_MIMETYPES_FILE) as $line)
	{
		if (preg_match('/^([^#]\S+)\s+.*'.$ext.'.*$/i', $line, $m))
		{
			$result = $m[1];
			break;
		}
	}

	return $result;
}



function walk_dir($dir_path)
{
	$retval = array();

	if ($dir = opendir($dir_path))
	{
		while (false !== ($file = readdir($dir)))
		{
			if ($file[0]==".")
			{
				continue;
			}

			if (is_dir($dir_path.$file))
			{
				$retval[] = $file;
			}
		}

		closedir($dir);
	}

	return $retval;
}

function walk_file($file_path)
{
	$retval = array();
	if($dir=opendir($file_path))
	{
		while(false !== ($file = readdir($dir)))
		{
			if($file[0]==".") continue;
			if(is_file($file_path.$file)) $retval[]=$file;
		}
		closedir($dir);
	}
	return $retval;
}

function check_folder_permissions($folder, $user)
{
	if (db_sql_num_rows(ViewSQL('SELECT * FROM users WHERE id='.sqlValue($user).' AND role='.sqlValue(ADMINISTRATOR), 0)) == 1)
		return true;

	$permissions = config_var('folder_permissions');

	if (!empty($permissions))
		$permissions = unserialize($permissions);

	if (!empty($permissions[$folder][$user]))
		return true;
	else
		return false;
}

function set_folder_permissions($folder, $user, $val)
{
	$permissions = config_var('folder_permissions');

	if (!empty($permissions))
		$permissions = unserialize($permissions);

	if (db_sql_num_rows(ViewSQL('SELECT * FROM users WHERE id='.sqlValue($user).' AND role='.sqlValue(POWERUSER), 0)) == 0)
		return false;

	$permissions[$folder][$user] = $val;

	save_config_var('folder_permissions', serialize($permissions));

	return true;
}

function format_f_size($f_size)
{
	if($f_size>=1024*1024) $s=sprintf("%01.3f",($f_size/(1024*1024))).'&nbsp;Mb';
	else if($f_size>=1024) $s=sprintf("%01.3f",($f_size/1024)).'&nbsp;Kb';
	else $s=sprintf("%01.0f",$f_size).'&nbsp;b';
	return $s;
}

function print_f_icon($fname,$id=0,$alt='')
{
	if ($id == 0 and $fname != '')
	{
		$fileinfo = pathinfo($fname);
		$fext = $fileinfo['extension'];
		switch ($fext)
		{
			case 'pdf': $id = 2; break;
			case 'doc':
			case 'wri':
			case 'rtf': $id = 3; break;
			case 'gif': $id = 4; break;
			case 'jpg':
			case 'jpeg': $id = 5; break;
			case 'txt': $id = 6; break;
			case 'csv':
			case 'xls': $id = 9; break;
			case 'ppt': $id = 10; break;
			case 'zip':
			case 'tgz':
			case 'gz':
			case '7z':
			case 'lha':
			case 'rar': $id = 11; break;
			default: $id = '_default';break;
		}
	}
	$ic = 'ic'.$id.'.gif';
	return '<img src="'.EE_HTTP.'img/ico/'.$ic.'" width="16" height="16" border="0" alt="'.$alt.'">';
}

function check_file_name($fname)
{
	$s = '';
	$name = stripcslashes($fname);
	$name = str_replace('../', '', $name);
	$s = preg_replace('/[^ 0-9a-zA-Z\.\_\!\~\/\\-]/', '_', $fname);

	return $s;
}

function httpUpload($old, $new)
{
	httpDeleteFile($new);
	$upload=move_uploaded_file($old, $new);
	if(!$upload)
	{
		return false;
	}
	chmod($new, 0755);
	return true;
}

//	Функция определения типа загружаемого файла
function getFileType($fname)
{
	$img=@getimagesize($fname);
	switch($img[2])
	{
		case 1: $type='.gif';break;
		case 2: $type='.jpg';break;
		case 3: $type='.png';break;
		case 4: $type='.swf';break;
		case 5: $type='.psd';break;
		case 6: $type='.bmp';break;
		default: $type=strrchr($fname,'.');
	}
	return $type;
}

function fileExists($fname)
{
	if (strpos($fname, EE_PATH) !== 0)
	{
		$fm = add_file_path($fname);
	}
	else
	{
	  	$fm = $fname;
	}

	return check_file($fm);
}

//	Функция проверки наличия файла.
function check_file($fm)
{
	return (file_exists($fm) and is_file($fm));
}

//	Функция проверки наличия каталога.
function check_dir($fm)
{
	return (file_exists($fm) and is_dir($fm));
}

//	Функция проверки доступности для записи файла.
function check_file_writable($fm)
{
	return (is_writable($fm) and is_file($fm));
}
//	alias
function check_file_writeable($fm)
{
	return check_file_writable($fm);
}

//	Функция проверки доступности для записи каталога.
function check_dir_writable($fm)
{
	return (is_writable($fm) and is_dir($fm));
}
//	alias
function check_dir_writeable($fm)
{
	return check_dir_writable($fm);
}

function httpDeleteFile($fname)
{
//	echo $fname;
	if (fileExists($fname))
		unlink($fname);
}


function mkdirtree($tree)
{
	$tree = explode('/',$tree);
	$create = '';
	foreach ($tree as $fldr)
	{
	  $create .= $fldr."/";
		if(!file_exists($create))
			mkdir($create);
	}
}

function get_filesize($size)
{
  global $size_units;
	if ($size <= 0)
		return '0 '.$size_units[0];
	for ($i=5; $i>=0; $i--)
	{
		$s = number_format($size/pow(1024, $i), 1);
		if($s >= 1)
			return $s." ".$size_units[$i];
	}
	return '-1 '.$size_units[0];
}

function GetFileList($path)
{
	$path = rtrim($path, '/\\');

	$d = $f = array();

	if ($hndl = opendir($path))
	{
		while (($file = readdir($hndl)) !== false)
		{
			if ($file[0] != '.')
			{
				$path_file = $path.'/'.$file;

				if (is_file($path_file))
				{
					$f[] = $file;
				}
				elseif (is_dir($path_file))
				{
					$d[] = $file;
				}
			}
		}

		closedir($hndl);
	}

	// it is necessary for sorting all dirs before files
	$a = array_merge($d, $f);

	return $a;
}

function dir_size($dir)
{
	$dir = rtrim($dir, '/\\');

	$totalsize = 0;
	$dir_count = 0;
	$file_count = 0;

	foreach (GetFileList($dir) as $filename)
	{
		$dir_filename = $dir.'/'.$filename;

		if (is_dir($dir_filename))
		{
			$dir_size = dir_size($dir_filename);
			$totalsize += $dir_size['totalsize'];
			$dir_count += $dir_size['dir_count'];
			$file_count += $dir_size['file_count'];
			$dir_count++;
		}
		elseif (check_file($dir_filename))
		{
			$totalsize += filesize($dir_filename);
			$file_count++;
		}
	}

	return	array(
		'totalsize' => $totalsize,
		'dir_count' => $dir_count,
		'file_count' => $file_count
		);
}

function rmrf($name)
{
	if (is_dir($name))
	{
		foreach(GetFileList($name) as $filename)
		{
			$name_filename = $name.'/'.$filename;

			if (is_dir($name_filename))
			{
				rmrf($name_filename);
			}
			else
			{
				unlink($name_filename);
			}
		}

		rmdir($name);
	}
	else
	{
		unlink($name);
	}
}

function size_hum_read($size){
/*
Returns a human readable size
*/
	$i=0;
	if (empty($size)) $size=0;
	$iec = array("B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB");
	while (($size/1024)>1) {
		$size=$size/1024;
		$i++;
	}
	return substr($size,0,strpos($size,'.')+4).$iec[$i];
}

/*
*  Copy file from source path to destination path
*
**/
function copy_file($source_path, $destination_path, $overwrite_if_exist = false)
{

	$res = true;
	if (!check_dir(dirname($destination_path)))
	{
		trigger_error('Destination folder ('.$destination_path.')  does not exists.');
		$res = false;
	}
	else if (!is_writable(dirname($destination_path)))
	{
		trigger_error('Destination folder ('.$destination_path.')  is not writeable.');
		$res = false;
	}
	else if (!check_file($source_path))
	{
		trigger_error('Source file ('.$source_path.')  does not exists.');
		$res = false;
	}
	else if (check_file($destination_path))
	{
		if ($overwrite_if_exist)
		{
			if (delete_file($destination_path))
			{
				$res = true;
			}
			else
			{
				trigger_error('Destination file can not be overwritten');  
				$res = false;
			}
		}
		else
		{
			trigger_error('Such file  ('.$destination_path.') already exists');
			$res = false;
		}
	}


	if ($res && copy($source_path, $destination_path))
	{
		$res = true;
	}

	return $res;
}


/**
 * Checks if file exists, if not exists - creates it if can
 * file system based functions are used
 * so should be used for files used by site not via FTP (CACHE etc)
 * @param string $file - file to be checked/created
 * @param integer $mode - mode to be assigned to file
 * @return boolean true if file exists/created {and mode assigned if not is null}, false otherwise
 * @see _self_test_file_exists()
 */
function touch_file($file, $mode = null)
{
	if (check_file($file))
	{
		$res = true;
	}
	elseif (check_dir($file))
	{
		trigger_error('Can\'t use "'.$file.'" as file - directory with the same name already exists.');

		$res = false;
	}
	elseif (touch($file))
	{
		$res = true;
	}
	else
	{
		trigger_error('Can\'t create file "'.$file.'"');

		$res = false;
	}

	if ($res == true && $mode != null)
	{
		$res = ee_chmod($file, $mode);
	}

	return $res;
}

/**
 * Checks if directory exists, if not exists - creates if can
 * file system based functions are used
 * so should be used for directories used by site not via FTP (CACHE etc)
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @see _self_test_dir_exists()
 * @see _self_test_dir_attributes()
 * @see check_cache_enabled()
 */
function touch_dir($dir, $mode = null)
{
	if (check_dir($dir))
	{
		$res = true;
	}
	elseif (check_file($dir))
	{
		trigger_error('Can\'t use "'.$dir.'" as directory - file with the same name already exists.');

		$res = false;
	}
	elseif (mkdir($dir))
	{
		$res = true;
	}
	else
	{
		trigger_error('Can\'t create directory "'.$dir.'"');

		$res = false;
	}

	if ($res == true && $mode != null)
	{
		$res = ee_chmod($dir, $mode);
	}

	return $res;
}


/**
 * Checks if directory exists and is writeable, if not exists - creates if can
 * file system based functions are used
 * so should be used for directories used by site not via FTP (CACHE etc)
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @used touch_dir()
 */
function touch_dir_writable($dir, $mode = null)
{
	$res = (touch_dir($dir, $mode) && is_writable($dir));

	return $res;
}

/**
 * Alias for touch_dir_writable()
 */
function touch_dir_writeable($dir, $mode = null)
{
	return touch_dir_writable($dir, $mode);
}


/**
 * The same as touch_dir(), just another default value for $mode
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @used touch_dir()
 */
function touch_dir_chmod($dir, $mode = EE_DEFAULT_DIR_MODE)
{
	return touch_dir($dir, $mode);
}

/**
 * The same as touch_dir_writable(), just another default value for $mode
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @used touch_dir_writable()
 */
function touch_dir_writable_chmod($dir, $mode = EE_DEFAULT_DIR_MODE)
{
	return touch_dir_writable($dir, $mode);
}

/**
 * Alias for touch_dir_writable_chmod()
 */
function touch_dir_writeable_chmod($dir, $mode = EE_DEFAULT_DIR_MODE)
{
	return touch_dir_writable_chmod($dir, $mode);
}

/**
 * Alias for touch_dir_writable_chmod()
 */
function touch_dir_chmod_writable($dir, $mode = EE_DEFAULT_DIR_MODE)
{
	return touch_dir_writable_chmod($dir, $mode);
}

/**
 * Alias for touch_dir_writable_chmod()
 */
function touch_dir_chmod_writeable($dir, $mode = EE_DEFAULT_DIR_MODE)
{
	return touch_dir_writable_chmod($dir, $mode);
}


/*
** Deletes file
** $fname - filename
*/
function delete_file($fname)
{
	if (file_exists($fname) && is_file($fname))
	{
		if (unlink($fname))
		{
			$res = true;
		}
		else
		{
			trigger_error('Can\'t delete file "'.$fname.'"');

			$res = false;
		}
	}
	else
	{
		$res = false;
	}

	return $res;
}


/**
 * moved here from _files.php
 * Deletes folder with all subfolders and files inside recursively
 * @param string $folder - directory to be delete with all content
 * @used delete_folder()
 */
function delete_folder($folder)
{
	$handle = opendir($folder);

	while ($file = readdir($handle))
	{
		if (!(((strlen($file) == 1) && (($file == '.'))) || ((strlen($file) == 2) && (($file == '..')))))
		{
			if (is_file($folder.'/'.$file))
			{
				unlink($folder.'/'.$file);
			}
			elseif (is_dir($folder.'/'.$file))
			{
				delete_folder($folder.'/'.$file);
			}
		}
	}

	closedir($handle);

	rmdir($folder);
}

/**
 * Deletes file[s] by mask
 * @param string $file_mask - file mask like: c:\folder1\folder2\logo*.php or just file like logo*.php (then used current dir) 
 * @used delete_file()
 */
function delete_files_by_mask($file_mask)
{            
	if ($file_mask && ($arr_files = glob($file_mask)))
	{   
		foreach ($arr_files as $filename)
		{
			delete_file($filename);
		}
	}
}

// Alias of delete_files_by_mask
function delete_file_by_mask($file_mask)
{
	delete_files_by_mask($file_mask);
}

function remove_dir($dir)
{ 
        $res = false;

	if (!check_dir($dir))
	{
		trigger_error('Can\'t delete directory '.$dir.' it doesn\'t  exist');
	}
	else if (!check_dir_writable($dir))
	{
		trigger_error('Can\'t delete directory '.$dir.' permission denied');
	}
	else
	{
		$res = rmdir($dir);
	}

	return $res;
}


function file_perms_oct($file)
{
	$res = fileperms($file);
	$res = decoct($res);
	$res = substr($res, 2);

	return $res;
}

function file_perms_int($file)
{
	$res = file_perms_oct($file);
	$res = octal_string_to_integer($res);

	return $res;
}



function ee_chmod($file, $mode)
{
	$mode = octal_string_to_integer($mode);

	if ($mode != file_perms_int($file))
	{
		if (chmod($file, $mode))
		{
			// it is unconditionally necessary here!
			// many filesystem related functions further using
			// will not work correctly without this!
			// tested on fileperms(), see _self_test_dir_attributes()
			clearstatcache();

			$res = true;
		}
		else
		{
			trigger_error('Can\'t change "'.$file.'" '.( is_file($file) ? 'file' : 'directory' ).' mode to '.sprintf('%o', $mode));

			$res = false;
		}
	}
	else
	{
		$res = true;
	}

	return $res;
}


