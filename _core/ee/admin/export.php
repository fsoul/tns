<?
	$modul = basename(__FILE__, '.php');
	if(!isset($op)) $op=0;
//********************************************************************
	include_once('../lib.php');
	include('../lib/archive/archive.php');
//********************************************************************
	if(!checkAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}

	if($_POST['back']) // в окне редактирования нажата кнопка [Назад]
	{
		$url = 'Location: '.$modul.'.php?load_cookie=true';
		header($url);
		exit;
	}

	function copy_file($file, $folder)
	{
		if ((strpos($file,EE_HTTP) !== false) || (strpos($file,'http://') === false))
		{
			mkdirtree(EE_PATH.$folder.substr(str_replace(EE_HTTP,'',$file),0,strrpos(str_replace(EE_HTTP,'',$file), '/')));
			@copy((strpos($file,EE_HTTP) !== false) ? str_replace(EE_HTTP,EE_PATH,$file) : EE_PATH.$file, EE_PATH.$folder.str_replace(EE_HTTP,'',$file));
		}
		else
		{
			mkdirtree(EE_PATH.$folder);
			@copy($file, EE_PATH.$folder.substr($file,strrpos($file,'/'),(strpos($file,'?') ? strpos($file,'?') : strlen($file))));
		}
	}

	function export_to_files($params)
	{
		global $ignore_admin, $admin_template, $modul, $admin_menu, $menuType, $UserRole, $export_run, $language, $t;
		global $total_export_external_file_count, $default_language;

		$folder = $params['folder'];
		$prefix = $params['prefix'];
		$download_content = $params['download_content'];
		$total_export_external_file_count = 0;

		$all_languages = viewsql('SELECT * FROM v_language ORDER BY language_code');
		$lang = array();

		while($al=mysql_fetch_array($all_languages))
		{
			$lang[$al['language_code']] = $al['language_name'];
		}

		$admin_menu_bak = $admin_menu;
		$sql = ViewSQL('select id from v_tpl_page');

		while ($r = mysql_fetch_array($sql))
		{
			foreach($lang as $l_code => $l_name)
			{
				$language = $l_code;
				$admin_menu = $admin_template = '';
				$ignore_admin = $export_run = 1;
				$t = $r['id'];

				$html = parse($r['id']);

				$html = preg_replace('/(src=")\/([^"]*)(")/i','${1}'.EE_HTTP.'${2}${3}',$html);

				preg_match_all('/(<script[^>]*src=")([^"]*)("[^>]*>)/i',$html,$regs);
				foreach($regs[2] as $script)
				{
				  if (strpos($script,'http://') !== false && $download_content && (strpos($script,EE_HTTP) === false))
				  {
						copy_file($script, $folder.'js');
						$html = str_replace($script, $prefix.'js'.substr($script,strrpos($script,'/')), $html);
						$total_export_external_file_count++;
					}
					else
						copy_file($script, $folder);
				}

				preg_match_all('/(<img[^>]*src=")([^"]*)("[^>]*>)/i',$html,$regs);
				foreach($regs[2] as $img)
				{
				  if (strpos($img,'http://') !== false && $download_content && (strpos($img,EE_HTTP) === false))
				  {
						copy_file($img, $folder.'img');
						$html = str_replace($img, $prefix.'img'.substr($img,strrpos($img,'/')), $html);
						$total_export_external_file_count++;
					}
					else
						copy_file($img, $folder);
				}

				$html = preg_replace('/(<form[^>]*target=")([^"]*)("[^>]*>)/i','${1}${3}', $html);
				$html = preg_replace('/(<form[^>]*target=\')([^\']*)(\'[^>]*>)/i','${1}${3}', $html);
				$html = preg_replace('/(onclick=")([^"]*)(")/i','', $html);
				$html = preg_replace('/(onclick=\')([^\']*)(\')/i','', $html);

				$aliase = get_default_aliase_for_page($r['id']);

				if ($language == $default_language)
				{
					$aliase = str_replace($l_code.'/','',$aliase);
				}

				$html = str_replace(EE_HTTP.$default_language.'/',EE_HTTP,$html);
				$html = str_replace(EE_HTTP,$prefix,$html);

				$html = str_replace($prefix.'\'',$prefix.'Home.html\'',$html);
				$html = str_replace($prefix.'"',$prefix.'Home.html"',$html);

				if ((strpos($aliase,'/') !== false)&&(!file_exists(EE_PATH.$folder.substr($aliase,0,strrpos($aliase, '/')))))
					mkdirtree(EE_PATH.$folder.substr($aliase,0,strrpos($aliase, '/')));

				$html_f = fopen(EE_PATH.$folder.$aliase,'w');
				fwrite($html_f, $html);
				fclose($html_f);
			}
		}

		mkdirtree(EE_PATH.$folder.'/css');
		@copy(EE_PATH.'css/style.css', EE_PATH.$folder.'/css/style.css');

    /* parse css */
		$css_file = EE_PATH.'css/style.css';
		$css = file_get_contents($css_file);
		$css_file = fopen(EE_PATH.$folder.'/css/style.css','w');
		preg_match_all('/(url[^;]*\(.)([^\)]*)(.\)[^;]*;)/i',$css,$regs);
		foreach($regs[2] as $img) copy_file($img, $folder);
		$css = preg_replace('/(url\(.)(\/)/','${1}'.$prefix,$css);
		fwrite($css_file, $css);
		fclose($css_file);
    /* /parse css */

		$ignore_admin = 0;
		$admin_template = yes;
		$export_run = 0;
		$admin_menu = $admin_menu_bak;
	}

	if ($_POST['export'])
	{
	  $export_folder = preg_replace('/([^a-zA-Z0-9\.\_\-\!\(\)\[\[\/])/i','',$_POST['export_folder']);
	  $export_base_folder = preg_replace('/([^a-zA-Z0-9\.\:\_\-\!\(\)\[\[\/])/i','',$_POST['export_base_folder']);
		$export_folder = ($export_folder == '') ? 'export/' : $export_folder;
		$export_base_folder = ($export_base_folder == '') ? '/' : $export_base_folder;
		$download_content = isset($_POST['download_content']) ? true : false;

		if (file_exists(EE_PATH.$export_folder."export.zip"))
			rmrf(EE_PATH.$export_folder."export.zip");

		export_to_files(
			array(
				'folder' => $export_folder,
				'prefix' => $export_base_folder,
				'download_content' => $download_content
				)
			);

		$total = dir_size(EE_PATH.$export_folder);
		$total_export_size = get_filesize($total['totalsize']);
		$total_export_dir_count = $total['dir_count'];
		$total_export_file_count = $total['file_count'];

		if (isset($_POST['archive_content']))
		{
			$export_archive = new zip_file(EE_PATH."export.zip");
			$export_archive->set_options(
				array(
					'recurse' => 1,
					'overwrite' => 1,
					'storepaths' => 1,
					'base_dir' => EE_PATH
					)
				);
			$export_archive->add_files('../'.$export_folder."*");
			$export_archive->create_archive();

			if (file_exists(EE_PATH."export.zip"))
			{
				rmrf(EE_PATH.$export_folder);
				mkdirtree(EE_PATH.$export_folder);
				rename(EE_PATH."export.zip", EE_PATH.$export_folder."export.zip");
				$export_archive_size = get_filesize(filesize(EE_PATH.$export_folder."export.zip"));
				$export_download_link = EE_HTTP.$export_folder."export.zip";
				$export_archived = 1;
				$export_compression_rate = substr(($total['totalsize'] / filesize(EE_PATH.$export_folder."export.zip")),0,3);
			}
		}

		echo parse($modul.'/done');
	}
	else
	{
		$export_folder = 'export/';
		$export_base_folder = '/';
		echo parse($modul.'/list');
	}

?>