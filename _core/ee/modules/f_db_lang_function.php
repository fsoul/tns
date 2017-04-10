<?

function f_add_lang($pLanguageCode, $pLanguageUrl, $pLanguageName, $pLanguageLinkTitle, $pLEncode, $pPaypalLang, $pStatus, $pDefault)
{
	$ret = 0;
	$pDefault = (int)$pDefault;

	if (db_sql_num_rows(ViewSQL('SELECT 1 FROM language WHERE language_code = '.sqlValue($pLanguageCode))) > 0)
	{
		$ret = -1;
	}

	if (db_sql_num_rows(ViewSQL('SELECT 1 FROM language WHERE language_name = '.sqlValue($pLanguageName))) > 0)
	{
		$ret = -2;
	}
	
	if (db_sql_num_rows(ViewSQL('SELECT 1 FROM language WHERE language_url = '.sqlValue($pLanguageUrl))) > 0)
	{
		$ret = -3;
	}

	if ($ret == 0)
	{
		RunSQL('
			INSERT INTO language
			(language_code, language_url, language_name, l_encode, paypal_lang, language_of_browser, status, default_language)
			values
			('.sqlValue($pLanguageCode).', '.sqlValue($pLanguageUrl).', '.sqlValue($pLanguageName).', '.sqlValue($pLEncode).', '.sqlValue($pPaypalLang).', '.sqlValue('%['.$pLanguageCode.']%').', '.sqlValue($pStatus).', '.sqlValue($pDefault).')
		');

		
		if (1===db_sql_affected_rows()) // record was added successfully
		{
			if ($pDefault != 0)
			{
				f_set_default_lang($pLanguageCode);
			}

			// delete sitemap.xml cache
			delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

			$ret = $pLanguageCode;
		}
		else
		{
			// Some sql error here
			$ret = -4;
		}
	}
			
	return $ret;
}

function f_del_lang($pId)
{
	// если удаляем язык добавляем обязательно редирект
	add_lang_redirect($pId);
	//
	RunSQL('DELETE FROM language WHERE language_code = '.sqlValue($pId).' AND default_language<>1');
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

function f_del_langs($pId)
{
	// если удаляем язык добавляем обязательно редирект
	foreach($pId as $langCode)
	{
		add_lang_redirect($langCode);
	}
	//
	RunSQL('DELETE FROM language WHERE language_code in('.sqlValuesList($pId).') AND default_language<>1');
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}


function f_upd_lang($pLanguageCode, $pLanguageUrl, $pLanguageName, $pLanguageLinkTitle, $pLEncode, $pPaypalLang, $pStatus, $pDefault, $pLangKey)
{
	$ret = 0;
	if (db_sql_num_rows(ViewSQL('SELECT 1 FROM language WHERE language_name = '.sqlValue($pLanguageName).' AND language_code <> '.sqlValue($pLangKey))) > 0)
		$ret = -3;
	$pDefault = (int)$pDefault;

	if ($ret == 0)
	{		
		$sql = 'UPDATE
				`language`
			SET
				`language_code`=' . sqlValue($pLanguageCode) . ',
				`language_url`=' . sqlValue($pLanguageUrl) . ',
				`language_name`=' . sqlValue($pLanguageName) . ',
				`l_encode`=' . sqlValue($pLEncode) . ',
				`paypal_lang`=' . sqlValue($pPaypalLang) . ',
				`status`=' . sqlValue($pStatus) . ',
				`default_language`=' . sqlValue($pDefault) . '
			WHERE
				`language_code`=' . sqlValue($pLangKey);

		set_time_limit(120);

		$ret = RunSQL($sql);

		if ($ret)
		{
			update_media_structure_by_lang($pLangKey, $pLanguageCode);
			update_img_filename(EE_PATH.EE_MEDIA_PATH, $pLangKey, $pLanguageCode);
			update_img_filename(EE_PATH.EE_IMG_PATH, $pLangKey, $pLanguageCode);
		}
	}

	if ($pDefault != 0)
		f_set_default_lang($pLanguageCode);

	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

function f_set_default_lang($pLanguageCode)
{
	if (db_sql_num_rows(ViewSQL('SELECT 1 FROM language WHERE language_code = '.sqlValue($pLanguageCode))) > 0)
	{
		RunSQL('UPDATE language SET default_language = 0 WHERE language_code <> '.sqlValue($pLanguageCode));
		RunSQL('UPDATE language SET default_language = 1 WHERE language_code = '.sqlValue($pLanguageCode));

		return 1;
	}
	else
		return -1;
}

function update_media_structure_by_lang($pLangKey, $pLanguageCode)
{
	$sql = 'SELECT page_id, var_id, val, val_draft FROM content WHERE var=\'media_\'';

	$res = viewSQL($sql);

	if (db_sql_num_rows($res) > 0)
	{
		$update_array = array();

		while ($row = db_sql_fetch_assoc($res))
		{
			$update_draft 		= false;
			$structure 		= unserialize($row['val']);
			$is_structure_null = is_null($row['val']);
			$draft_structure 	= unserialize($row['val_draft']);
			$is_draft_structure_null = is_null($row['val_draft']);

			if (
				(!$is_structure_null && update_image_structure_by_lang($structure, $pLangKey, $pLanguageCode))
				||
			    (!$is_draft_structure_null && update_image_structure_by_lang($draft_structure, $pLangKey, $pLanguageCode))
			)
			{	
				$update_sql = 'UPDATE 
							content 
						SET
							val = ' . ($is_structure_null) ? 'NULL' : sqlValue(serialize($structure)) . ',
							val_draft = ' . ($is_draft_structure_null) ? 'NULL' : sqlValue(serialize($draft_structure)) . '
						WHERE
							page_id=\''.$row['page_id'].'\'
							AND
							var=\'media_\'
							AND
							var_id=\''.$row['var_id'].'\'';
				runSQL($update_sql);	
			}
		}
	}
}

function update_image_structure_by_lang(&$structure, $pLangKey, $pLanguageCode)
{
        $image_structure = $structure['images'];

	if (is_array($image_structure) && array_key_exists($pLangKey, $image_structure))
	{
		$new_image_structure = array();

		foreach ($image_structure as $key => $val)
		{
			$new_image_structure[str_replace($pLangKey, $pLanguageCode, $key)] = str_replace($pLangKey, $pLanguageCode, $val);

			$structure['images'] = $new_image_structure;
		}

		return true;
	}

	return false;
}

function update_img_filename($path, $pLangKey, $pLanguageCode)
{
	$imageFilePattern = "/([a-z0-9_-]+)(".$pLangKey.")([a-z0-9_-]+)?\.([a-z]{2,3})/i";

	if ($dh = opendir($path))
	{
		$file_array = array();
		// получаем список файлов и папок в каталоге
		while (false !== ($file = readdir($dh)))
		{ 
			// оставляем только файлы
        	if (is_file($path . '/' . $file))
			{
				if (preg_match($imageFilePattern, $file, $result))
				{
					$new_filename = str_replace($pLangKey, $pLanguageCode, $file);

					rename($path.$file, $path.$new_filename);
				}
        	}
    	}
    	closedir($dh);
	}
}

?>