<?

	function dir_to_array($dir, $mask='', $ar_black_list=array())
	{
		// if something wrong is passed to function as $ar_black_list -
		// let it be an empty array for no errors in next code
		if (!is_array($ar_black_list))
		{
			$ar_black_list = array();
		}

		$arr = array();

		$handle=opendir($dir);

		while (false!==($file=readdir($handle)))
		{
			if($file!="." and $file!="..")
			{
				if (	preg_match('/'.$mask.'/i', $file) and
					!in_array($file, $ar_black_list)
				)
				{
					$arr[] = $file;
				}
			}
		}
		closedir($handle);

		return $arr;
	}
