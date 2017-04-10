<?php
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL.
* http://www.2k-group.com
*/
?>
<?
//**************************************************************************************
//							FTP function
//**************************************************************************************

/**
 * Connect to the FTP server and login as some FTP-user
 * @param string $server - FTP-server to be connected to, cfg.php mentioned by default
 * @param string $user - user to be logged in, cfg.php mentioned by default
 * @param string $pass - password to be logged with, cfg.php mentioned by default
 * @return mixed resource id if connection and login was successfully, false otherwise
 * @see ftp_touch_dir_writable()
 * @see createFtpFolder()
 * @see cleanFolder()
 * @see deleteFile()
 * @see ftpUpload()
 * @see ftpChmod()
 */
function ftp_connect_login($server = EE_FTP_SERVER, $user = EE_FTP_USER, $pass = EE_FTP_PASS)
{
	if (!($conn_id = ftp_connect($server)))
	{
		trigger_error('Ftp connection has failed! Attempted to connect to "'.$server.'"');

	        $ret = false;
	}
	elseif (!($login_result = ftp_login($conn_id, $user, $pass)))
	{
		trigger_error('Ftp login has failed! Attempted to login for user "'.$user.'" to "'.$server.'"');

		ftp_close($conn_id);

	        $ret = false;
	}
	else
	{
		$ret = $conn_id;
	}

	return $ret;
}

//	Функция для создания каталога
function ftp_create_folder($new)
{
	return createFtpFolder($new);
}

//	Функция для создания каталога
function createFtpFolder($new, $conn_id=null)
{
	if (is_resource($conn_id) || ($conn_id = ftp_connect_login()))
	{
		if ($upload = ftp_mkdir($conn_id, $folder = add_ftp_prefix($new)))
		{
			$result = true;
		}
		else
		{
			trigger_error('Can not create folder "'.$folder.'"');

			$result = false;
		}

		ftp_close($conn_id);
	}
	else
	{
	        $result = false;
	}

	return $result;
}


//	Функция для переименования файлов
function ftp_rename_file($old_file, $new_file, $conn_id=null)
{
	if (is_resource($conn_id) || $conn_id = ftp_connect_login())
	{
		$old_file = add_img_path($old_file);
		$new_file = add_img_path($new_file);

		if (fileExists($new_file))
		{
			trigger_error('Can\'t rename file "'.$old_file.'" to "'.$new_file.'": file with the same name already exists.');
		}
		elseif ($rename = ftp_rename($conn_id, add_ftp_prefix($old_file), add_ftp_prefix($new_file)))
		{
			$ret = true;
		}
		else
		{
			trigger_error('Error of renaming file "'.$old_file.'" to "'.$new_file.'"');

			$ret = false;
		}

		ftp_close($conn_id);
	}
	else
	{
		$ret = false;
   	}

	return $ret;
}


//	Функция для удаления каталогов
function ftp_delete_folder($dir, $conn_id=null)
{
	if (is_resource($conn_id) || ($conn_id = ftp_connect_login()))
	{
		$dir = add_file_path($dir);

		if (check_dir(add_path($dir)))
		{
			$dir = add_ftp_prefix($dir);
			$dir = rtrim($dir, '/');

			if ($result = ftp_rmdir($conn_id, $dir))
			{
				$ret = true;
			}
			else
			{
				trigger_error('Can\'t delete directory "'.$dir.'". Verify if it\'s empty.');

				$ret = false;
			}
		}
		else
		{
			trigger_error('"'.$dir.'" is not directory');

			$ret = false;
		}

		ftp_close($conn_id);
	}
	else
	{
		trigger_error('Can\'t connect to FTP-server');

		$ret = false;
 	}

	return $ret;
}

//	Функция для очистки каталогов для удаления
function ftp_clean_folder($fname, $mask='.', $conn_id=null)
{
	return cleanFolder($fname, $mask='.', $conn_id);
}

//	Функция для очистки каталогов для удаления
function cleanFolder($fname, $mask='.', $conn_id=null)
{
	if (is_resource($conn_id) || ($conn_id = ftp_connect_login()))
	{
		$fname = add_img_path($fname);

	 	ftp_chdir($conn_id, $ftp_prefix_fname = add_ftp_prefix($fname));

		$nFiles = ftp_nlist($conn_id, '');

		for ($i=0; $i<count($nFiles); $i++)
		{
			if (is_file($for_check = EE_PATH.$fname.$nFiles[$i]) and preg_match('/'.$mask.'/i', $nFiles[$i]))
			{
				ftp_delete($conn_id, $ftp_prefix_fname.$nFiles[$i]);
			}
			elseif (is_dir($for_check))
			{
				cleanFolder($for_check);
			}
		}

		ftp_close($conn_id);

		$ret = true;
	}
	else
	{
		$ret = false;
 	}

	return $ret;
}

//	Функция для удаления файла по ФТП
function ftp_delete_file($fname, $conn_id=null)
{
	return deleteFile($fname, $conn_id);
}
//	Функция для удаления файла по ФТП
function deleteFile($fname, $conn_id=null)
{
	if (empty($fname))
	{
		return;
	}

	$fname = add_img_path($fname);

	// bug_id = 10465
	$fname = add_path($fname);

	if (fileExists($fname))
	{
		if (is_resource($conn_id) || $conn_id = ftp_connect_login())
		{
			if (ftp_delete($conn_id, add_ftp_prefix($fname)))
			{
				$ret = true;
			}
			else
			{
				trigger_error('Can\'t delete file "'.$fname.'" via FTP');

				$ret = false;
			}

			ftp_close($conn_id);
		}
		else
		{
			$ret = false;
		}
	}
	else
	{
		trigger_error('File "'.$fname.'" is not exists');

		$ret = false;
   	}

	return $ret;
}

//	Функция загрузки файла через ФТП
function ftp_upload($old, $new, $conn_id=null)
{
	return ftpUpload($old, $new, $conn_id);
}

//	Функция загрузки файла через ФТП
function ftpUpload($old, $new, $conn_id=null)
{
	if (is_resource($conn_id) || $conn_id = ftp_connect_login())
	{
		$new = add_img_path($new);

		if (fileExists($new))
		{
			ftp_delete($conn_id, add_ftp_prefix($new));
		}

		if ($upload = ftp_put($conn_id, add_ftp_prefix($new), $old, FTP_BINARY))
		{
			$ret = true;
		}
		else
		{
			trigger_error('Ftp upload has failed!');

			$ret = false;
		}

		ftp_close($conn_id);
	}
	else
	{
		$ret = false;
   	}

	return $ret;
}


function itemImageExists($fname)
{
	global $path_to_item;

	$fm = $path_to_item.EE_IMG_PATH.$fname;

	if (check_file($fm))
	{
		return true;
	}
	else
	{
		return false;
	}
}

/*
* Chmod by FTP
**/
function ftpChmod($ftp_path, $mode, $conn_id=null)
{
	if (is_resource($conn_id) || $conn_id = ftp_connect_login())
	{
		$mode = octal_string_to_integer($mode);

		if (ftp_site($conn_id, 'CHMOD '.vsprintf('%o', $mode).' '.(add_ftp_prefix($ftp_path))) !== false)
		{
		        $ret = true;
		}
		else 
		{		
		        $ret = false;
		}

		ftp_close($conn_id);
	}
	else
	{
	        $ret = false;
	}

	return $ret;
}



/**
 * Checks if file exists, if not exists - creates it if can
 * FTP based functions are used
 * so should be used for files used by site via FTP
 * @param string $file - file to be checked/created
 * @param integer $mode - mode to be assigned to file
 * @return boolean true if file exists/created {and mode assigned if not is null}, false otherwise
 * @see _self_test_ftp_file_exists()
 * @see _self_test_ftp_file_attributes()
 */
function ftp_touch_file($file, $mode=null, $conn_id=null)
{
	$path_file = add_path($file);

	if (check_file($path_file))
	{
		$res = true;
	}
	elseif (check_dir($path_file))
	{
		trigger_error('Can\'t use "'.(add_ftp_prefix($file)).'" as file - directory with the same name already exists.');

		$res = false;
	}
	elseif (ftp_create_file($file, $conn_id))
	{
		$res = true;
	}
	else
	{
		trigger_error('Can\'t create file "'.(add_ftp_prefix($file)).'"');
	}

	if ($mode != null && $res == true)
	{
		$mode = octal_string_to_integer($mode);

		if (ftpChmod($file, $mode, $conn_id))
		{
			clearstatcache();
		}
		else
		{
			trigger_error('Can\'t set mode '.$mode.' to file "'.(add_ftp_prefix($file)).'"');

			$res = false;
		}
	}

	return $res;
}


function ftp_create_file($file, $conn_id = null)
{
	$tmp = tmpfile();

	if (is_resource($conn_id) || ($conn_id = ftp_connect_login()))
	{
		if (ftp_fput($conn_id, add_ftp_prefix($file), $tmp, FTP_BINARY))
		{
			$result = true;
		}
		else
		{
			trigger_error('Can not create file "'.$file.'"');

			$result = false;
		}

		ftp_close($conn_id);
	}
	else
	{
	        $result = false;
	}

	fclose($tmp);

	return $result;
}


/**
 * Checks if directory exists, if not exists - creates if can
 * FTP based functions are used
 * so should be used for directories used by site via FTP (usersimage etc)
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @see _self_test_ftp_dir_exists()
 * @see _self_test_ftp_dir_attributes()
 */
function ftp_touch_dir($dir, $mode=null, $conn_id=null)
{
	$path_dir = add_path($dir);

	if (check_dir($path_dir))
	{
		$res = true;
	}
	elseif (check_file($path_dir))
	{
		trigger_error('Can\'t use "'.(add_ftp_prefix($dir)).'" as directory - file with the same name already exists.');

		$res = false;
	}
	elseif (ftp_create_folder($dir, $conn_id))
	{
		$res = true;
	}
	else
	{
		trigger_error('Can\'t create directory "'.(add_ftp_prefix($dir)).'"');
	}

	if ($mode != null && $res == true)
	{
		$mode = octal_string_to_integer($mode);

		if (ftpChmod($dir, $mode, $conn_id))
		{
			clearstatcache();
		}
		else
		{
			trigger_error('Can\'t set mode '.$mode.' to directory "'.(add_ftp_prefix($dir)).'"');

			$res = false;
		}
	}

	return $res;
}



/**
 * Checks if directory exists and is writeable, if not exists - creates if can
 * FTP based functions are used
 * so should be used for directories used by site via FTP (usersimage etc)
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @used ftp_touch_dir()
 */
function ftp_touch_dir_writable($dir, $mode=null, $conn_id=null)
{
	$dir = add_ftp_prefix($dir);

	if (ftp_touch_dir($dir, $mode, $conn_id))
	{
		// create temporary directory name unexists in $dir
		while (file_exists($tmp_dir_name = rtrim($dir, '/').'/'.'tmp_'.(rand())));

		if (ftp_touch_dir($tmp_dir_name, $conn_id))
		{
			$close_connect = false;

			if (is_resource($conn_id) || ($conn_id = ftp_connect_login() && ($close_connect=true)))
			{
				$tmp_dir_name = ($tmp_dir_name);

				if (!ftp_rmdir($conn_id, $tmp_dir_name))
				{
					trigger_error('Can\'t delete temporary directory "'.$tmp_dir_name.'"');
				}

				if ($close_connect)
				{
					ftp_close($conn_id);
				}
			}

			$res = true;
		}
		else
		{
			trigger_error('Directory "'.$dir.'" is not writeable. Check it\'s owner and rights');

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
 * Alias for ftp_touch_dir_writable()
 */
function ftp_touch_dir_writeable($dir, $mode=null, $conn_id=null)
{
	return ftp_touch_dir_writable($dir, $mode, $conn_id);
}


/**
 * The same as ftp_touch_dir(), just another default value for $mode
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @used ftp_touch_dir()
 */
function ftp_touch_dir_chmod($dir, $mode = EE_DEFAULT_DIR_MODE, $conn_id=null)
{
	return ftp_touch_dir($dir, $mode, $conn_id);
}

/**
 * The same as ftp_touch_dir_writable(), just another default value for $mode
 * @param string $dir - directory to be checked/created
 * @param integer $mode - mode to be assigned to directory
 * @return boolean true if direcory exists/created {and mode assigned if not is null}, false otherwise
 * @used ftp_touch_dir_writable()
 */
function ftp_touch_dir_writable_chmod($dir, $mode = EE_DEFAULT_DIR_MODE, $conn_id=null)
{
	return ftp_touch_dir_writable($dir, $mode, $conn_id);
}

/**
 * Alias for ftp_touch_dir_writable_chmod()
 */
function ftp_touch_dir_writeable_chmod($dir, $mode = EE_DEFAULT_DIR_MODE, $conn_id=null)
{
	return ftp_touch_dir_writable_chmod($dir, $mode, $conn_id);
}

/**
 * Alias for ftp_touch_dir_writable_chmod()
 */
function ftp_touch_dir_chmod_writable($dir, $mode = EE_DEFAULT_DIR_MODE, $conn_id=null)
{
	return ftp_touch_dir_writable_chmod($dir, $mode, $conn_id);
}

/**
 * Alias for ftp_touch_dir_writable_chmod()
 */
function ftp_touch_dir_chmod_writeable($dir, $mode = EE_DEFAULT_DIR_MODE, $conn_id=null)
{
	return ftp_touch_dir_writable_chmod($dir, $mode, $conn_id);
}



/**
 * Converts dir's path/name to full path started from file system root
 * @param string $dir - directory to be converted
 * @return string full directory path
 * @see add_ftp_prefix()
 * @see ftp_touch_dir()
 */
function add_path($dir)
{
//vdump($dir, 'add_path($dir)');
//vdump(EE_FTP_PREFIX, 'EE_FTP_PREFIX');
	// add file-system related path if is absent
	if (strpos($dir, EE_PATH) !== 0)
	{
		// remove ftp-related prefix if is there
		if (strpos($dir, EE_FTP_PREFIX) === 0)
		{
			$dir = substr($dir, strlen(EE_FTP_PREFIX));
		}
//vdump($dir, 'dir 1');
//vdump(EE_PATH, 'EE_PATH');

		$dir = EE_PATH.$dir;
	}
//vdump($dir, 'dir 2');

	$dir = reduce_path_to_canonical($dir);
//vdump($dir, 'dir 3');

	return $dir;
}


/**
 * Converts dir's path/name to path started from FTP root
 * @param string $dir - directory to be converted
 * @return string directory path started from FTP root
 * @see add_path()
 * @see ftp_touch_dir()
 * @see ftp_touch_dir_writable()
 * @see createFtpFolder()
 * @see ftpUpload()
 * @see ftpChmod()
 */
function add_ftp_prefix($dir)
{
	// remove file-system related path if is there
	if (strpos($dir, EE_PATH) === 0)
	{
		$dir = substr($dir, strlen(EE_PATH));
	}

	// add ftp-related prefix if is absent
	if (strpos($dir, EE_FTP_PREFIX) !== 0)
	{
		$dir = EE_FTP_PREFIX.$dir;
	}

	$dir = reduce_path_to_canonical($dir);

	return $dir;
}

/**
 * Converts file's path/name to path started from EE_FILE_PATH (==EE_PATH.EE_IMG_PATH)
 * @param string $fname - filename to be converted
 * @return string file path started from EE_FILE_PATH
 * @see ...
 */
function add_file_path($fname)
{
	if (strpos($fname, EE_FILE_PATH) !== 0)
	{
		if (strpos($fname, EE_PATH) === 0)
		{
			$fname = substr($fname, strlen(EE_PATH));
		}

		if (strpos($fname, EE_IMG_PATH) === 0)
		{
			$fname = substr($fname, strlen(EE_IMG_PATH));
		}

		$fname = EE_FILE_PATH.$fname;
	}

	$fname = reduce_path_to_canonical($fname);

	return $fname;
}

/**
 * Converts file's path/name to path started from EE_IMG_PATH
 * @param string $fname - filename to be converted
 * @return string file path started from EE_IMG_PATH
 * @see deleteFile()
 * @see ftpUpload()
 */
function add_img_path($fname)
{
	if (	strpos($fname, EE_IMG_PATH) !== 0 &&
		strpos($fname, EE_MEDIA_PATH) !== 0 &&
		strpos($fname, '/'.EE_IMG_PATH) !== 0 &&
		strpos($fname, '/'.EE_MEDIA_PATH) !== 0
	)
	{
		$fname = EE_IMG_PATH.$fname;
	}

	$fname = reduce_path_to_canonical($fname);

	return $fname;
}

/**
 * Converts file's path/name to path started from EE_MEDIA_PATH
 * @param string $fname - filename to be converted
 * @return string file path started from EE_MEDIA_PATH
 */
function add_media_path($fname)
{
	if (	strpos($fname, EE_IMG_PATH) !== 0 &&
		strpos($fname, EE_MEDIA_PATH) !== 0
	)
	{
		$fname = EE_MEDIA_PATH.$fname;
	}

	$fname = reduce_path_to_canonical($fname);

	return $fname;
}

?>