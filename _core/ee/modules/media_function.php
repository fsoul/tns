<?

/**
 * Вывод списка языков и полей
 *
 * @param string $media_type Тип медиа
 * @return string шаблон списка языков
 */
	function media_print_lang_bar($media_type = 'images')
	{
		global $lang, $lng, $default_language;
		global $picture_vars, $size_y, $size_x, $size_unit_type, $modul;

		for($i=0;$i<count($lang);$i++)
		{
			$p_arr[$i]['media_type'] = $media_type;
			$lang_code = array_key_exists('Code',$lang[$i]) ? $lang[$i]['Code'] : "";
			$p_arr[$i]['media_lang_code'] = $lang_code;
			if (array_key_exists('alts',$picture_vars) && array_key_exists($lang_code,$picture_vars['alts']))
			{
				$res = $picture_vars['alts'][$lang_code];
				$p_arr[$i]['media_alt'] = htmlspecialchars($res, ENT_QUOTES);
			}
			else
			{
				$p_arr[$i]['media_alt'] = "";
			}
			$p_arr[$i]['lang_name'] = isset($lang[$i]['Name']) ? $lang[$i]['Name'] : "";
			$p_arr[$i]['lang_defalut'] = ($lang_code == $default_language) ? 1 : 0;
			$p_arr[$i]['size_y'] = $size_y;
			$p_arr[$i]['size_x'] = $size_x;
			$p_arr[$i]['size_unit_type'] = $size_unit_type;
			if (array_key_exists('images',$picture_vars) && !isset($picture_vars['images'][$lang_code]))
			{
				$picture_vars['images'][$lang_code] = "";
			}
			$image_name = get_media_picture_name($picture_vars['images'][$lang_code]);
			$image_title = $picture_vars['images'][$lang_code].($image_name==$picture_vars['images'][$lang_code]?'':' <span style="color:red;">(draft)</span>');
			$p_arr[$i]['image_name'] = (!empty($image_name) && fileExists(EE_MEDIA_FILE_PATH.$image_name)) ? $image_name : 0;
			$p_arr[$i]['image_title'] = (!empty($image_name) && fileExists(EE_MEDIA_FILE_PATH.$image_name)) ? $image_title : 0;
		}
		$s = parse_array_to_html($p_arr, 'media_lang_bar');

		return $s;
	}

/**
 * Генерация имени файла по имени медиа
 *
 * @param string $str Название текущей медиа
 * @return string Имя файла
 */
	function media_to_file_name($str)
	{
		$str = str_replace(' ','_',$str);
		$str = preg_replace('/[^0-9a-zA-Z\.\-\_\!\~\/\\]/i','',$str);
		return $str;
	}

/**
 * Сохранение\загрузка данных о медиа
 *
 * @param string $picture_name Название медиа
 * @param array $picture_vars Опциональный параметр - параметры медиа. Если он задан, то информация сохраняется
 * @return array Параметры медиа
 */
	function media_manage_vars($picture_name, $picture_vars = array())
	{
		if (!empty($picture_vars))
		{
			// Поле $language должно быть пустым, так как
			// описание МЕДИИ храниться в сереализированном массиве, и в нем реализована зависимость от языка
			save_cms($picture_name, serialize($picture_vars), 0, '');
		}
		else
		{

			// Поле $language должно быть пустым, так как
			// описание МЕДИИ храниться в сереализированном массиве, и в нем реализована зависимость от языка
			$res = cms($picture_name, '', '', 1, 0);
			if (!empty($res)) $picture_vars = unserialize($res);
		}
		return $picture_vars;
	}

/**
 * Инициализация текущей медиа
 *
 * @param int $media_id Опциональный параметр - id media
 * @return none
 */
	function media_init_vars($media_id = -1)
	{
		global $lang, $picture_vars, $size_y, $size_x, $size_default_x, $size_default_y, $size_unit_type, $size_default_unit_type;
		global $default_language, $i_name, $default_language, $size_default;
		global $image_link, $open_same, $open_new, $image_sat, $url_text, $t;
		global $media_show_menu, $media_quality, $media_bgcolor;

		$media_id = $media_id == -1 ? $t : $media_id;

		$sql = 'SELECT * FROM v_media WHERE id='.sqlValue($media_id);

		$rs = ViewSQL($sql, 0);

		$media_params = db_sql_fetch_array($rs);

		$i_name =  'media_'.$media_id;

		$picture_vars = media_manage_vars($i_name);

		$media_show_menu = isset_array_var($picture_vars, 'show_menu');
		$media_quality = isset_array_var($picture_vars, 'quality');
		$media_bgcolor = isset_array_var($picture_vars, 'bgcolor');

		//комментируем блок кода в котором всем рисункам давались значения рисунка для языка по умолчанию


//		if (fileExists(EE_MEDIA_FILE_PATH.$picture_vars['images'][$default_language]))
//		{
//			$size=get_image_size(EE_MEDIA_FILE_PATH.$picture_vars['images'][$default_language]);
//			$size_x=$size[0];
//			$size_y=$size[1];
//		} else {
			$size_x='0';
			$size_y='0';
			$size_unit_type='px';
//		}

		$size_default_x = $size_x;
		$size_default_y = $size_y;
		$size_default_unit_type = $size_unit_type;

		$picture_vars['size_x'] = (is_array($picture_vars) && array_key_exists('size_x',$picture_vars)) ? $picture_vars['size_x'] : $size_x;
		$picture_vars['size_y'] = (is_array($picture_vars) && array_key_exists('size_y',$picture_vars)) ? $picture_vars['size_y'] : $size_y;

		if (	$picture_vars['size_x'] == $size_x
			and
			$picture_vars['size_y'] == $size_y
			or
			empty($picture_vars['size_x'])
			or
			empty($picture_vars['size_y'])
		)
		{
			$size_default = 'default';
		}
		else
		{
			$size_x = $picture_vars['size_x'];
			$size_y = $picture_vars['size_y'];
			$size_unit_type = $picture_vars['size_unit_type'];
			$size_default = 'custom';
		}

		$all_languages = viewsql('SELECT * FROM v_language ORDER BY language_code',0);
		$lang = array();
		$i = 0;

		while ($al = db_sql_fetch_array($all_languages))
		{
			$lang[$i]['Code'] = $al['language_code'];
			$lang[$i++]['Name'] = $al['language_name'];
		}
	}

/**
 * Сохранение в массив параметров медиа переменных flash-ролика
 *
 * @return none
 */
	function media_manage_flash()
	{
		global $picture_vars;
		$picture_vars['show_menu'] = post('media_show_menu');
		$picture_vars['quality'] = post('media_quality');
		$picture_vars['bgcolor'] = post('media_bgcolor');
	}

/**
 * Сохранение в массив параметров медиа переменных изображения
 *
 * @return none
 */
	function media_manage_image()
	{
		global $picture_vars, $i_name, $lang;

		for($i=0;$i<count($lang);$i++)
		{
			$lang_alt_field = 'lang_alt_'.$lang[$i]['Code'];
			global $$lang_alt_field;
			if ($$lang_alt_field != '')
			{
				$res = $$lang_alt_field;
				$picture_vars['alts'][$lang[$i]['Code']] = $res;
			}
		}
	}

	function get_media_picture_name($name)
	{
		$picture_name = substr($name,0,(strpos($name,'.'))).content_field_suffix().substr($name, strrpos($name,'.'));
		if(!check_file(EE_MEDIA_FILE_PATH.$picture_name)) $picture_name = $name;
		return $picture_name;
	}
	function save_media_picture_name($name)
	{
		$picture_name = substr($name,0,(strpos($name,'.'))).content_field_suffix().substr($name, strrpos($name,'.'));
		return $picture_name;
	}

	/**
	 * Returt valid size for media
	 */
	function validate_media_size($size)
	{
		return abs(trim(intval($size)));
	}


/**
 * Подготовка к сохранению параметров медиа
 *
 * @param string $media_type Тип медиа
 * @return none
 */
	function media_manage($media_type)
	{
		//die();
		global $lang, $picture_vars, $size_y, $size_x, $size_default_x, $size_default_y, $size_unit_type, $size_default_unit_type;
		global $default_language, $i_name, $default_language, $size_default;
		global $image_link, $open_same, $open_new, $image_sat, $url_text;
		global $media_image_lang_bar,$save, $picture_vars, $t, $t_back_refer;

		media_init_vars();

		for($i=0;$i<count($lang);$i++)
		{
			$delete_img = 'delete_img_'.$lang[$i]['Code'];
			global $$delete_img;
			if ($$delete_img != '')
			{
//				httpDeleteFile(EE_MEDIA_FILE_PATH.$picture_vars['images'][$lang[$i]['Code']]);
				unset($picture_vars['images'][$lang[$i]['Code']]);
				media_manage_vars($i_name, $picture_vars);
				RunSQL("UPDATE tpl_pages SET edit_date=NOW() WHERE id=".$t,0);
			}
		}

		if (!empty($_POST['save']) or !empty($_POST['upload']))
		{
			if (isset($image_size) && $image_size == 'default')
			{
				$picture_vars['size_x'] = $size_default_x;
				$picture_vars['size_y'] = $size_default_y;
				$picture_vars['size_unit_type'] = $size_default_unit_type;
			}
			else
			{
				$picture_vars['size_x'] 	= validate_media_size(post('f_size_x'));
				$picture_vars['size_y'] 	= validate_media_size(post('f_size_y'));
				$picture_vars['size_unit_type'] = post('f_size_unit_type');
			}

			for($i=0;$i<count($lang);$i++)
			{
				$lang_alt_field = 'lang_alt_'.$lang[$i]['Code'];
				$file_field = 'nfile_'.$lang[$i]['Code'];

				if (isset($$lang_alt_field))
				{
					$res = $$lang_alt_field;
					$picture_vars['alts'][$lang[$i]['Code']] = $res;
				}

				if (!empty($_FILES[$file_field]['tmp_name']))
				{
/*					if ((!isset($picture_vars['images'][$lang[$i]['Code']]))||($picture_vars['images'][$lang[$i]['Code']] == ''))
						$picture_vars['images'][$lang[$i]['Code']] = media_to_file_name($i_name).'_'.$lang[$i]['Code'].substr($_FILES[$file_field]['name'],strrpos($_FILES[$file_field]['name'],'.')); */
					$__name = getField('SELECT page_name FROM v_media WHERE id = ' . sqlValue($t));

					$picture_name = $picture_vars['images'][$lang[$i]['Code']] = media_to_file_name($__name . '_'.$t.'_'.$lang[$i]['Code'].substr($_FILES[$file_field]['name'],strrpos($_FILES[$file_field]['name'],'.')));

					//$picture_name = save_media_picture_name($picture_vars['images'][$lang[$i]['Code']]);
					if(!@ftpUpload($_FILES[$file_field]['tmp_name'],EE_MEDIA_PATH.$picture_name))
					{
						global $error;
						$error['media_manage_error'] = "Error in FTP-uploading. Please check FTP-configuration.";
					}
				}
			}

			if ($media_type == 'images')
				media_manage_image();
			elseif ($media_type == 'flash')
				media_manage_flash();

			media_manage_vars($i_name, $picture_vars);
			RunSQL("UPDATE tpl_pages SET edit_date=NOW() WHERE id=".$t,0);
			if (!empty($_POST['save']) && $GLOBALS['op'] !== 'add_zip')
			{
				if(isset($_GET['from']) && $_GET['from'] == 'assets')
					header('Location: '.EE_ADMIN_URL.'_assets.php');
				else
				{
					if(empty($t_back_refer))
					{
						header('Location: '.EE_ADMIN_URL.'_media.php?load_cookie=true');
					}
					else
					{
						header('Location: '.EE_HTTP.'index.php?admin_template=yes&t='.$t_back_refer);
					}
				}
			}
		}
		media_init_vars();
		if (!array_key_exists('op',$GLOBALS) || $GLOBALS['op'] !== 'add_zip') $media_image_lang_bar = media_print_lang_bar($media_type);
	}


/**
 * Function parse_media($media_id) parses a media if it exist.
 * Otherwise this function  return empty string.
 */
function parse_media($media_id)
{
	// check if found media really exists in tpl_pages
	// if it was deleted - no images will be printed
	$media_id = check_media_id($media_id);

	if (!empty($media_id))
		$res = parse($media_id);
	else
		$res = '';

	return $res;
}

/**
 * Check if asked media really exists in database.
 * @param media_id int id of media to check
 * @return media_id if media with mentioned id exists, NULL otherwise
 */
function check_media_id($media_id)
{
	return getField('select id from v_media where id='.sqlValue($media_id));
}

/**
 * Вывод медиа (инициализация переменных)
 *
 * @param string $media_type Тип медиа
 * @param int $media_id Опциональный параметр - id media
 * @return none
 */
	function media_get($media_type, $media_id = -1, $media_insert_data = null)
	{		
		global $language, $media_image_lang_bar, $i_name, $media_name, $default_language;
		global $media_show_menu, $media_quality, $media_bgcolor, $get_as_tag, $media_link_on;
		global $media_file, $media_border, $media_height, $media_unit_type, $media_width, $media_alt, $picture_vars, $media_title;
		global $media_link_url, $media_link_open_type;

		$media_image_lang_bar = $media_name = $media_show_menu = $media_quality = $media_bgcolor = $media_link_on = $media_file = $media_border = $media_height = $media_unit_type = $media_width = $media_alt = $media_title = $media_link_url = $media_link_open_type = '';

		global $is_preview;

		if ($media_id != -1)
		{
			$media_id == check_media_id($media_id);
		}

		// don't even try to show {not existed media in any mode} or {doc-type media in preview mode}
		if (	empty($media_id)
				||
				$media_type=='doc' && $is_preview==1
		)
		{
			return;
		}

		$preview_width = MEDIA_PREVIEW_WIDTH;

		($media_id == -1) ? media_init_vars() : media_init_vars($media_id);

		if (!array_key_exists('images',$picture_vars))
		{
			$picture_vars['images'] = array();
		}

		if (	array_key_exists($default_language,$picture_vars['images'])
			&&
			(!isset($picture_vars['images'][$language])
			||
			($picture_vars['images'][$language] == ''))
		)
		{
			$picture_vars['images'][$language] = $picture_vars['images'][$default_language];
		}

		$media_name = media_to_file_name($i_name);

		$media_file = '';

		if ($get_as_tag==1 && empty($is_preview) && get('admin_template') != 'yes')
		{
			$media_file = EE_HTTP.get_default_aliase_for_page($media_id,'',$language);
		}
		else
		{
			// see task 9521
			if (array_key_exists($language,$picture_vars['images']) && trim(get_media_picture_name($picture_vars['images'][$language]))!=="")
			{
				$media_file = EE_MEDIA_PATH.get_media_picture_name($picture_vars['images'][$language]);

				if (check_file(EE_PATH.$media_file))
				{
					$media_file = EE_HTTP.$media_file;
				}
				else
				{
					$media_file = '';
				}
			}
		}

		if ($media_file != '')
		{

		//Gets media (image/flash) link properties
		if ($media_insert_data == null)
		$media_insert_data = $picture_vars;

		if (	array_key_exists('link',$media_insert_data)
			&&
			isset($media_insert_data['link']['type'])
			&&
			$media_insert_data['link']['type'] != 'open_none'
		)
		{
				$media_link_on = true;
				if ($media_insert_data['link']['type'] == 'open_url')
				{
					$media_link_url = $media_insert_data['link']['url'];
				}
				elseif ($media_insert_data['link']['type'] == 'open_sat_page')
				{
					$media_insert_data['link']['sat'] = array_key_exists('sat',$media_insert_data['link'])
										?
										$media_insert_data['link']['sat']
										:
										"";

					$aliase = get_href($media_insert_data['link']['sat']);

					if ($aliase != false and get('admin_template') != "yes")
					{
						$media_link_url = $aliase;
					}
					else
					{
						$media_link_url = '?t='.$media_insert_data['link']['sat'].'&language='.$language.'&admin_template=yes';
					}
				}

				if (isset_array_var($media_insert_data['link'],'opentype') == '_blank')
				{
					$media_link_open_type = "_blank";
				}
				else
				{
					$media_link_open_type = "_self";
				}

				//Getting XITI-attributes
				if(EE_LINK_XITI_ENABLE)
				{
					global $xitiClickType, $xitiS2, $xitiLabel;

					$xitiClickType	= isset($media_insert_data['link']['xitiClickType'])	? $media_insert_data['link']['xitiClickType'] : '';
					$xitiS2		= isset($media_insert_data['link']['xitiS2'])		? $media_insert_data['link']['xitiS2'] : '';
					$xitiLabel	= isset($media_insert_data['link']['xitiLabel'])	? $media_insert_data['link']['xitiLabel'] : '';
				}
				// media title
				$media_title = isset_array_var($media_insert_data['link'],'media_title');
			}
			else
			{
				$media_link_on = false;
			}

			if (array_key_exists($language,$picture_vars['images']) && ($media_type == 'images' || $media_type == 'flash'))
			{
				$media_picture_name = get_media_picture_name($picture_vars['images'][$language]);

				if ($media_picture_name == '')
				{
					global $langEncode;

					foreach($langEncode as $lang=>$encode)
					{
						if ($lang == $language)
						{
							continue;
						}
						if (array_key_exists($lang,$picture_vars['images']))
						{
							$media_picture_name = get_media_picture_name($picture_vars['images'][$lang]);
						}

						if ($media_picture_name != '')
						{
							break;
						}
					}
				}

				$size = get_image_size(EE_MEDIA_FILE_PATH.$media_picture_name);
				$size_x = $size[0];
				$size_y = $size[1];

				$media_height = ((int)$picture_vars['size_y'] > 0) ? $picture_vars['size_y'] : $size_y;
				$media_width = ((int)$picture_vars['size_x'] > 0) ? $picture_vars['size_x'] : $size_x;
				$media_unit_type = isset($picture_vars['size_unit_type']) ? $picture_vars['size_unit_type'] : 'px';

				$media_height = (int)(($is_preview==1 && $media_width>0)?($preview_width/$media_width*$media_height):$media_height);
				$media_width = ($is_preview==1)?$preview_width:$media_width;
			}

			if ($media_type == 'images')
			{
				$media_border = empty($picture_vars['border'])?0:$picture_vars['border'];
//				$res = convert_from_utf($picture_vars['alts'][$language],$language);
//				if (empty($res)) $res = $picture_vars['alts'][$language];
				if (	array_key_exists('alts', $picture_vars) &&
					array_key_exists($language, $picture_vars['alts'])
				)
				{
					$media_alt = $picture_vars['alts'][$language];
				}
			}
			elseif ($media_type == 'flash')
			{
				$media_show_menu = isset_array_var($picture_vars, 'show_menu');
				$media_quality = isset_array_var($picture_vars, 'quality');
				$media_bgcolor = isset_array_var($picture_vars, 'bgcolor');
			}
		}
	}

/**
 * Инициализация медиа из шаблона (дабы не перекрывать уже проинициализированные пер-е)
 *
 * @param string $media_type Тип медиа
 * @return none
 */
function media_get2($media_type)
{
	global $ignore_admin_media;

	if ($ignore_admin_media != 1)
	{
		media_get($media_type);
	}
}

function upload_media_zip($file_field)
{
	global $default_language, $t, $lang, $__new_page_name;

	function create_media_name(&$value, $key, $ind)
	{
		if ($ind == 1)
		{
			$value .= '_'.$ind;
		}
		else
		{
			$value = substr($value, 0, strrpos($value, '_')).'_'.$ind;
		}
	}

	if ($_FILES[$file_field]["size"] == 0)
	{
		$error[] = 'File size = 0';
		return $error;
	}

	$zip_header = get_zip_header($_FILES[$file_field]["tmp_name"]);	

	if (mime_content_type_ext($_FILES[$file_field]["name"]) != 'application/zip' || $zip_header != ZIP_HEADER_SIGNATURE)
	{         
		$error[] = 'Incorrect file type: '.$_FILES[$file_field]["type"];
		return $error;
	}

	$lang = array(0=>array('code'=>$default_language));
	$lang_alt_field = 'lang_alt_'.$default_language;
	global $$lang_alt_field;


	$$lang_alt_field = $_POST['alt_tag'];

	if ($zip = zip_open($_FILES[$file_field]["tmp_name"]))
	{
		$ind = 1;
		while ($zip_entry = zip_read($zip))
		{
			$s_filename = zip_entry_name($zip_entry);
			$file_size = zip_entry_filesize($zip_entry);

			if (zip_entry_open($zip, $zip_entry, "r"))
			{
				$buf = zip_entry_read($zip_entry, zip_entry_filesize($zip_entry));
				zip_entry_close($zip_entry);

				$unziped = $_FILES[$file_field]["tmp_name"].'.unziped';
				$im_file_handler = fopen($unziped, "w");
				fwrite($im_file_handler, $buf);
				fclose($im_file_handler);

				$_FILES['nfile_'.$default_language] = array (
					'name' =>	$s_filename,
					'type' =>	mime_content_type_ext($unziped),
					'tmp_name' =>	$unziped,
					'error' =>	0,
					'size' =>	$file_size
				);

				array_walk($__new_page_name, 'create_media_name', $ind);

				$t = f_add_media($_POST['page_name'] = '__new_page_name', $_POST['media_description'], $_POST['template'], $_POST['folder']);

				media_manage('images');

				$ind++;
			}
		}
		zip_close($zip);
	}
}

/**
 * Function check if current media is chosen.
 * Return FALSE if media was not chosen, and return file-name with path in another case.
 */
function get_media_url($object_type, $object_name, $page_dependent=1)
{
	global $language, $media_image_lang_bar, $i_name, $UserRole;
	global $media_file, $media_border, $media_height, $media_unit_type, $media_width, $media_alt, $picture_vars, $media_id;
	global $media_show_menu, $media_quality, $media_bgcolor, $t, $ignore_admin_media, $tag_params;
	global $get_as_tag;

	$res = '';
	$get_as_tag = 1;
	$ignore_admin_media = 1;

	$__media_data = unserialize(cms('media_inserted_'.$object_name, ($page_dependent==1)?$t:'', '', 1, 0));

	// media title, depend on lanaguge
	$media_title = cms('media_title_'.$object_name, ($page_dependent == 1 ? $t : 0), $language, 1, 0);
	$__media_data['link']['media_title'] = $media_title;

	media_get($object_type, $media_id = $__media_data['media_id'],$__media_data);

	$media_id = check_media_id($media_id);

	if (!empty($media_id))
		$res = $media_file;
	else
		$res = false;

	return $res;
}

	function get_media_file_by_id($id)
	{
		global $default_language;
		global $popup_x, $popup_y;

		$picture_vars = media_manage_vars('media_'.$id);
                $res = $key_language = '';

		if (is_array($picture_vars['images']))
		{
			if (	array_key_exists($default_language, $picture_vars['images']) &&
				!empty($picture_vars['images'][$default_language]) &&
				check_file(EE_PATH.EE_MEDIA_PATH.$picture_vars['images'][$default_language])
			)
			{
		    	$key_language = $default_language;
			}
			else
			{
				foreach ($picture_vars['images'] as $key_language=>$val)
				{
					if (check_file(EE_PATH.EE_MEDIA_PATH.$picture_vars['images'][$key_language]))
					{
						break;
					}
					else
					{
						$key_language = '';
					}
				}
			}
		}

		if ($key_language != '')
		{
			$tmp = EE_MEDIA_PATH.$picture_vars['images'][$key_language];

			list($popup_x, $popup_y) = get_image_size(EE_PATH.$tmp);

			$res = EE_HTTP.$tmp;
		}

		return $res;
	}
	
	function print_assets_preview_source($id, $lng = null)
	{
		global $admin, $get_as_tag, $is_preview, $t, $language;
		
		$admin = 0;
		$get_as_tag = 1;
		$is_preview = 1;
		$t = $id;
		$original_language = $language;
		if(!is_null($lng))
		{
			$language = $lng;
		}
		$ret = js_clear(parse($id));
		$language = $original_language;
		//удаляем параметры alt и title
		$ret = preg_replace("/((.?)alt=+)||((.?)title=+)/is", '', $ret);
		//Получаем размеры изображений
		list($img_x, $img_y) = get_image_size(get_media_file_by_id($id));
		
		if($img_x < EE_GALLERY_THUMBNAIL_W)//если размер изображения меньше минимального выводим его с истиными размерами
		{
			//example: <img src=http://localhost/ee3.2/media/ghnmgh_57_EN.jpg border=0 height=213 width=200 title= alt= />
			$ret = preg_replace("/([\s]?width=[\"]?[\d]+[\"]?[^>\s]*)+||([\s]?height=[\"]?[\d]+[\"]?[^>\s]*)+/is", '', $ret);
		}
		
		$ret = str_replace("\r", " ", $ret);
		$ret = str_replace("\n", " ", $ret);

		$ret = trim($ret);

		$admin = 1;
		$get_as_tag = 0;
		$is_preview = 0;

		return $ret;
	}

?>