<?

/**
 * ENGINE EXPRESS OBJECTS (in text just "objects")
 *
 * What is it?
 *
 * The method of creating customize modules is called "Object". Customize module it is module of CMS EngineExpress which was designed specially for customer and it must not be included into EngineExpress Core).
 *
 *
 * Why objects are uned?
 *
 * Object was designed to don't making changes into DB structure. Objects give possibility not to create new tables in DataBase. It's an universal method of saving and processing different data.
 *
 *
 * How to work with Objects? 
 *
 * - You must to image the object like real table in which you want to save data that you need.
 * - After that you need to create new object. It's possible to make it through admin-panel. (Object -> Objects Management -> Add Object...)
 * - Next step - the creating of fields needed for this object. (Object -> Object Fields Management -> Add Object Fields...)
 * - It was created data-model for saving data!
 * - For processing data you need to use different function which was designed special for Objects (like f_add_object_modul(), f_del_object_modul(), create_sql_view() and many more, which is described in this documentation).
 *
 *
 * What is "object templates" and how to work with it?
 *
 * For example you need to create NEWS on base object. And you wish that the URL for each one news-record was "beautiful" (without GET-parameters).
 * You would to design special universal template (*.tpl) for one news and connect it with your object.
 * It can be done in admin-panel (Object -> Objects Template -> Add Object Views...).
 * For generating "beautiful" URLs for objects you can used next function:  get_default_alias_for_object() and get_alias_for_object().
 *
 * 
 *
 *
 * This file contains functions for object modul.
 */
 
/**
 * Returns an array of all values for indicated field of indicated object.
 * 
 * @param string $object_name object name
 * @param string $field_name field name
 * @param string $lang language
 * @return array all value for object field
 */
function get_values_of_object_field($object_name, $field_name, $lang='', $record_id=null)
{
	$all_values_arr = array();

	global $language;
	$lang = ($lang=='') ? $language : $lang;

	$sql = 'SELECT
			value
		FROM
			`object_content`
		WHERE
			object_field_id =
				(
				 SELECT id
				 FROM `object_field`
				 WHERE object_id = 
					(
					 SELECT id
					 FROM `object`
					 WHERE name = '.sqlValue($object_name).' 
					)
				  AND object_field_name = '.sqlValue($field_name).'
				)	
		  AND
			language = '.sqlValue($lang);

	if (!is_null($record_id))
	{
		$sql.= ' AND object_record_id = '.sqlValue($record_id);
	}

	$sql_res = viewSQL($sql,0);

	while($rec = db_sql_fetch_array($sql_res))
	{
		$all_values_arr[] = $rec['value'];
	}

	return (!is_null($record_id) ? $all_values_arr[0] : $all_values_arr);
}

/**
 * Return object name by record id
 * @param string $record_id Record id
 * @return string Object Name on success or ''
 */
function Get_object_name_by_record_id($record_id)
{
	$record_id = intval($record_id);
	$sql = 'SELECT name FROM `object` WHERE id=(SELECT object_id FROM `object_record` WHERE id='.sqlValue($record_id).')';
	$res = GetField($sql);

	return strval($res);
}

/**
 * Searches object id by object name
 * @param string $object_name Object Name
 * @return int Object Id on success or FALSE
 */
function Get_object_id_by_name($object_name)
{
	$sql = 'SELECT id FROM object WHERE name = '.sqlValue($object_name);
	if (db_sql_num_rows(viewsql($sql, 0)) > 0)
	{
		return  GetField($sql);
	}
	else
	{
		return false;
	}
}

/**
 * Searches object field id by object field name
 * @param string $object_field_name Object Field Name
 * @param - int $object_id Id of Object
 * @return int Object Field Id on success or FALSE
 */
function Get_object_field_id_by_name($object_field_name, $object_id)
{
	$sql = 'SELECT id FROM `object_field` WHERE object_field_name = '.sqlValue($object_field_name).' AND object_id = '.sqlValue($object_id);

	if (db_sql_num_rows(viewsql($sql, 0)) > 0)
	{
		return  GetField($sql);   
	}
	else
	{
		return false;
	}
}

/**
 * Searches user name by user id
 * @param int $user_id Id of user
 * @return string name of user with Id = $user_id
 */
function get_user_name_by_id($user_id)
{
	return getField('SELECT name FROM users WHERE id = '.sqlValue($user_id));
}

/**
 * Searches user login by user id
 * @param int $user_id Id of user
 * @return string login of user with Id = $user_id
 */
function get_user_login_by_id($user_id)
{
	return getfield('SELECT login FROM users WHERE id ='.sqlValue($user_id));
}

/**
 * Counts number of fields of Object
 * @param string $object_name Object Name
 * @return int number of fields
 */
function count_num_fields ($object_name)
{
	return GetField('SELECT count(*) FROM object_field WHERE object_id = (SELECT id FROM object WHERE name = '.sqlValue($object_name).')');
}
/**
 * Counts number of records of Object
 * @param string $object_name Object Name
 * @return int number of records
 */
function count_num_records ($object_name)
{
	return GetField('SELECT count(*) FROM object_record WHERE object_id = (SELECT id FROM object WHERE name = '.sqlValue($object_name).')');
}

function Get_fields_by_object_id($object_id, $lang_depend_filter = false)
{
	$sql = 'SELECT object_field_name FROM object_field WHERE object_id = '.sqlValue($object_id);
	if($lang_depend_filter !== false)
	{   
		$sql .= ' AND one_for_all_languages = '.sqlValue($lang_depend_filter);
	}
	$r = viewSQL($sql);
	while($row = db_sql_fetch_array($r))
	{
		$object_fields[] = $row[0];
	}
	return $object_fields;
}

/**
 * Calls to function print_edit_cms_object() but replace line break tags with param $space
 * @param int $var
 * @param string $t
 * @param string $alt
 * @param $string $space
 * @return string Result of function print_edit_cms_object() with line break tags replaced. 
 */
function edit_cms_object($var, $t=0, $alt='', $space='', $lang='')
{
	return str_replace('<br/><br/>', $space, print_edit_cms_object($var, $t, $alt, $lang));
}

/**
 * Prints button. When button pressed - window with editor opens
 * @param int $var record id
 * @param string $t field name
 * @param string $alt alt for button image
 * @return string html code for print button
 */
function print_edit_cms_object($var, $t, $alt='', $lang='')
{
	global $UserRole;


	if ($alt == '')
	{
		$alt = $var;
	}

	$s = '';

	if (	checkAdmin() &&
		get('admin_template')=='yes' &&
		(
			$UserRole==ADMINISTRATOR
			||
			$UserRole==POWERUSER
		)
	)
	{
		$s = '<a href="#" onclick="openEditorObject(\''.$var.'\', \''.$t.'\', \''.$lang.'\'); return false;" title="Edit Page Content'.($alt==''?'':' of '.$alt).'"><img src="'.EE_HTTP.'img/cms_edit_bt.gif" width="43" height="16" alt="Edit Page Content'.($alt==''?'':' of '.$alt).'" border="0"/></a><br/><br/>';
	}

	return $s;
}

/**
 * Function made from cms(). Differs from cms() in saving information. All is saved not to table `content` but to table `object_content`.
 * @param int $record_id Record id
 * @param string $field_name Field name
 * @param string $user_language Language that is used
 * @global - string $admin_template 
 * @global - int UserRole - User Role. Camparing with constants to define User Type.
 * @global - string $language - language of current page
 * @global - string default_language - default language for website
 * @return string parsed data from table object_content 
 */
function cms_object($record_id, $field_name, $user_language='', $need_convert_from_utf=true)
{
	$s = '';

	if ($user_language == '')
	{
		global $language;

		$user_language = $language;
	}

	$object_id = GetField('SELECT object_id FROM object_record WHERE id='.sqlValue($record_id));
	$field_id = GetField('SELECT id FROM object_field WHERE object_field_name='.sqlValue($field_name).' AND object_id='.sqlValue($object_id));

	$sql = 'SELECT value FROM object_content WHERE object_record_id='.sqlValue($record_id).' AND object_field_id='.sqlValue($field_id);

	$rs = viewsql($sql, 0);

	if (db_sql_num_rows($rs) >= 1)
	{
		$sql.= ' AND language=%s';

		$rs = viewsql(sprintf($sql, sqlValue($user_language)));

		if (db_sql_num_rows($rs) < 1)
		{
			global $default_language;

			$user_language = $default_language;

			$rs = viewsql(sprintf($sql, sqlValue($user_language)));
		}

		if (db_sql_num_rows($rs) >= 1)
		{
			$r = db_sql_fetch_array($rs);
			$s.= parse2($r['value']);

			if (need_convert_from_utf($need_convert_from_utf))
			{
				$s = convert_from_utf($s, $user_language);
			}

			if (!check_admin_template())
			{
				$s = replace_links_by_get_href($s);
			}
		}
	}

	return $s;
}

/**
 * Uploads image to IMG_DIR directory;
 * @param string $s_name name of file to upload
 * @param string $s_add_path Path to upload image
 * @param string $s_file_name_save Name with which file must be saved
 * @return string Name of file if Success OR error if failed 
 */
function upload_object_image($s_field, $s_add_path='', $s_file_name_save=null)
{
	$ar_file_types['image/gif']=array (
			'im_create_func' => 'ImageCreateFromGif',
			'im_type' => 'Gif',
			'im_func' => 'ImageGif'
			);
	$ar_file_types['image/pjpeg']=
	$ar_file_types['image/jpeg']=array (
			'im_create_func' => 'ImageCreateFromJpeg',
			'im_type' => 'Jpg',
			'im_func' => 'ImageJpeg'
			);
	$ar_file_types['image/png']=
	$ar_file_types['image/x-png']=array (
			'im_create_func' => 'ImageCreateFromPng',
			'im_type' => 'Png',
			'im_func' => 'ImagePng'
			);

	$error = array();
	if($_FILES[$s_field]["size"] > EE_OBJ_IMAGE_SIZE_LIMIT)
	{
		$error[] = 'File ('.format_f_size($_FILES[$s_field]["size"]).') &gt; '.format_f_size(EE_OBJ_IMAGE_SIZE_LIMIT);
		return $error;
	}
	if($_FILES[$s_field]["size"] == 0)
	{
		$error[] = 'File size = 0';
		return $error;
	}
	if (!in_array($_FILES[$s_field]["type"], array_keys($ar_file_types)))
	{
		$error[] = 'Incorrect file type: '.$_FILES[$s_field]["type"];
		return $error;
	}

	// так файл назывался в оригинале
	$FileName = $_FILES[$s_field]["name"];

	if ($s_file_name_save!=null)
	{
		// выцепляем из имени файла расширение
		$FileExt = substr($FileName, strlen($FileName)-3, 3);
		// сохранять будем под указанным именем + расширение
		$FileName = $s_file_name_save.'.'.$FileExt;
	}

	$ImgFileName = $_FILES[$s_field]["tmp_name"];
	$ImgFileNamePr = $_FILES[$s_field]["tmp_name"];

	if (is_file($ImgFileName))
	{
		$type = $_FILES[$s_field]["type"];
		$im_orig = $ar_file_types[$type]['im_create_func']($ImgFileName);
		$im_type = $ar_file_types[$type]['im_type'];
		$im_func = $ar_file_types[$type]['im_func'];

		if (!isset($im_orig) || !ftpUpload($ImgFileName, $s_add_path.$FileName))
		{
			// если не вписываемся в допустимые габариты
			// то уменьшаем рисунок

			$error[] = 'Image file upload error: '.EE_FTP_PREFIX.EE_IMG_PATH.$FileName;
			return $error;

		}
	}
	return $FileName;
}

/**
 * Uploads file to IMG_DIR directory;
 * @param string $s_name name of file to upload
 * @param string $s_add_path Path to upload file
 * @param string $s_file_name_save Name with which file must be saved
 * @return string Name of file if Success OR error if failed 
 */
function upload_object_file($s_field, $s_add_path='', $s_file_name_save=null)
{
	$error = array();

	if ($_FILES[$s_field]["size"] > EE_OBJ_FILE_SIZE_LIMIT)
	{
		$error[] = 'File size ('.format_f_size($_FILES[$s_field]["size"]).') &gt; '.format_f_size(EE_OBJ_FILE_SIZE_LIMIT);
		return $error;
	}
	if ($_FILES[$s_field]["size"] == 0)
	{
		$error[] = 'File size = 0';
		return $error;
	}

	// так файл назывался в оригинале
	$FileName = $_FILES[$s_field]["name"];

	if ($s_file_name_save!=null)
	{
		// выцепляем из имени файла расширение
		$path_parts = pathinfo($FileName);
		$FileExt = $path_parts['extension'];
		// сохранять будем под указанным именем + расширение
		$FileName = $s_file_name_save.'.'.$FileExt;
	}

	$tmpFileName = $_FILES[$s_field]["tmp_name"];

	if (!is_file($tmpFileName) || !ftpUpload($tmpFileName, $s_add_path.$FileName))
	{
		$error[] = 'Image file upload error: '.EE_FTP_PREFIX.EE_IMG_PATH.$FileName;
		return $error;
	}
	return $FileName;
}

function handle_get_object_file($file_name)
{
	if (!checkAdmin() or !($UserRole==ADMINISTRATOR or $UserRole==POWERUSER or $UserRole==USER or $UserStatus==ADMINISTRATOR))
	{
		echo parse('norights');
		exit;
	}
	$file_path = EE_PATH.EE_IMG_PATH.$file_name;
	if(file_exists($file_path))
	{
		header("Content-Type: application/octet-stream");
		header("Content-Disposition: attachment; filename=\"".$file_name."\"");
		readfile($file_path);
		exit;
	}
}

function create_sql_select_fields($fields_list, $object_name, $for_templates_flag=0, $lang='', $all_languages=false)
{
	return 'SELECT '.$fields_list.' FROM ('.create_sql_view_by_name_for_fields($fields_list, $object_name, $for_templates_flag, $lang, $all_languages).') AS t';
}

function create_sql_view_by_name_for_fields($fields_list, $object_name, $for_templates_flag=0, $lang='', $all_languages=false)
{
	return create_sql_view_by_name($object_name, $for_templates_flag, $lang, $all_languages, $fields_list);
}

function create_sql_view_by_name_for_fields_filter_by_fields($fields_list, $field_filter, $object_name, $for_templates_flag=0, $lang='', $all_languages=false)
{
	return create_sql_view_by_name($object_name, $for_templates_flag, $lang, $all_languages, $fields_list, $field_filter);
}

function create_sql_view_by_name_filter_by_fields($field_filter, $object_name, $for_templates_flag=0, $lang='', $all_languages=false)
{
	return create_sql_view_by_name($object_name, $for_templates_flag, $lang, $all_languages, null, $field_filter);
}

/**
 * Function selects id of object by name from DB and calls to function create_sql_view()
 * @param string @object_name Object name
 * @return Calls function create_sql_view
 * $for_templates_flag - flag which indicated where would be used this function: if in html-template then must be equal "1", if in PHP-code then must be equal "0" or ignored
 */
function create_sql_view_by_name($object_name, $for_templates_flag=0, $lang='', $all_languages=false, $fields_list=null, $field_filter=array())
{
	$sql = create_sql_view(getField('SELECT id FROM object WHERE name='.sqlValue($object_name)), $lang, $all_languages, $fields_list, $field_filter);

	if ( $for_templates_flag == 1)
	{
		$sql = str_replace ( '\'', '\\\'', $sql);
		$sql = str_replace ( ',', '\,', $sql);
	}
	return $sql;
}

/**
*
*
*
*
**/
function create_lite_sql_view($object_id, $field, $lang)
{
	global $language, $edit;

	if ($lang=='')
	{
		$lang = $language;
	}
	
	$field_id = getField('SELECT id FROM object_field WHERE object_id='.sqlValue($object_id[0]).' AND object_field_name='.sqlValue($field));

	if (isset($object_id[$lang][$field_id]))
	{
		$i_val = $object_id[$lang][$field_id];
	}
	else
	{
		$i_val = '';
	}

	$sql = sqlValue($i_val).' AS '.sqlValue($lang.'__'.$field);

	//$sql = '(SELECT value FROM v_i_object WHERE object_field_id=\''.$field_id.'\' AND language=\''.$lang.'\' AND object_id=\''.$object_id.'\' AND object_record_id=\''.$edit.'\') AS \''.$lang.'_'.$field.'\'';

	return $sql;
}

function create_sql_view_for_fields($fields_list, $object_id, $lang='', $all_languages=false)
{
	return create_sql_view($object_id, $lang, $all_languages, $fields_list);
}

function create_sql_view_filter_by_fields($field_filter, $object_id, $lang='', $all_languages=false)
{
	return create_sql_view($object_id, $lang, $all_languages, null, $field_filter);
}

function create_sql_view_for_fields_filter_by_fields($fields_list, $field_filter, $object_id, $lang='', $all_languages=false)
{
	return create_sql_view($object_id, $lang, $all_languages, $fields_list, $field_filter);
}

/**
 * Generates base SQL query using which we will make queries for editing or showing information. 
 * @param int $object_id - id of object we are working with
 * @param string $lang - language we are want to work with while editing
 * @global - string $language - language we are using in forntpanel
 * @global - string $object_name - name of object
 * @global - array $object_fields - array of fields of object
 * @global - int $num_records - number of records for object
 * @global - array $error_message - array of error messages, that used to inform about error while doing some operation 
 * @return string SQL query 
 */
function create_sql_view($object_id, $lang='', $all_languages=false, $fields_list=null, $field_filter = array())
{
	global $language, $object_name, $object_fields, $num_records, $error_message;
	global $default_language;

	if ($lang=='')
	{
		$lang = $language;
	}

	$add_to_cache_name = "";

	if (!is_array($field_filter))
	{
		$field_filter = array();
	}

	if (count($field_filter) > 0)
	{
		foreach ($field_filter as $key=>$value)
		{
			$add_to_cache_name .= md5($key."=".$value);
		}
	}

	$obj_chache_file_name = ($all_languages ? 'all_lang_' : '').$lang.'_'.md5($fields_list).$add_to_cache_name.'_sql_view';

	if (check_obj_cache($object_id, $obj_chache_file_name))
	{
		return get_obj_cache($object_id, $obj_chache_file_name);
	}


	if ($all_languages==false)
	{
		$ar_languages = array($lang);
	}
	else
	{
		$sql_langs = '

			SELECT language_code
			  FROM v_language
		      ORDER BY default_language DESC
		';

		$ar_languages = SQLField2Array(viewsql($sql_langs, 0));
	}

	$num_fields = count_num_fields($object_name);
	$num_records = count_num_records($object_name);

	//инициализируем имена полей
	$sql_fields = '
         SELECT id, object_field_name, one_for_all_languages
           FROM object_field
          WHERE object_id='.sqlValue($object_id).'
        ';

	if (!is_null($fields_list))
	{
		$ar_fields_list = explode(',', $fields_list);
		array_walk($ar_fields_list, create_function('&$a', '$a = explode(\' \', trim($a)); $a = trim($a[0]);'));
		$sql_fields.= ' AND object_field_name IN (\''.implode('\', \'', $ar_fields_list).'\') ';
	}

	$sql_fields.= ' ORDER BY id';

	$rs = viewsql($sql_fields, 0);

	while($r = db_sql_fetch_assoc($rs))
	{
		$ar_field_names[$r["id"]] = array($r["object_field_name"], $r['one_for_all_languages']);
	}

	//если не получилось - значит ошибка при создании обьекта или полей - что и пишем
	if (empty($ar_field_names) OR !is_array($ar_field_names))
	{ 
		$error_message = '<table border=0 width=100%><tr><td class="navy" width="300" height="21" align="center">You have errors in configuring object. Visit <a href=_object.php>\'Object Managment\'</td></tr></table>';
		echo parse($modul.'/list_object_error');
		exit;
	}


	$ar_sql = array();
	$ar_sql[] = "\r\n".' SELECT '."\r\n".'        r.id AS \'record_id\'';
	$ar_filter_sql = array();

	$ar_where[] = '        r.object_id='.sqlValue($object_id);

	//для каждого поля начиная выбираем из object_content то, что нам необходимо
	foreach($ar_field_names as $k=>$v)
	{
		foreach($ar_languages as $key_lang)
		{
			$field_name_for_sql = $v[0].( $all_languages==true && $v[1]==0 ? '_'.$key_lang : '' );

			if (array_key_exists($v[0], $field_filter) && $field_filter[$v[0]] != '')
			{
				$ar_sql[]= '        obj_'.$field_name_for_sql.'.value AS \''.$field_name_for_sql.'\'';

				$ar_filter_sql[]= '	LEFT JOIN object_content obj_'.$field_name_for_sql.' 
							ON 
								obj_'.$field_name_for_sql.'.object_field_id = '.sqlValue($k).' 
							AND 
								obj_'.$field_name_for_sql.'.language='.sqlValue($key_lang).' 
							AND 
								obj_'.$field_name_for_sql.'.object_record_id=r.id';

				$ar_where[] = '        obj_'.$field_name_for_sql.'.value = '.sqlValue($field_filter[$v[0]]);
			}
			else
			{
        			$ar_sql[]= '
(
    SELECT object_content.value

      FROM object_content'.( $key_lang != $default_language ? '
INNER JOIN language
        ON object_content.language = language.language_code' : '' ).'

     WHERE object_content.object_field_id = '.sqlValue($k).'
       AND object_content.object_record_id = r.id
       AND object_content.language IN ('.sqlValue($key_lang).($key_lang != $default_language ? ', '.sqlValue($default_language).')

     ORDER BY language.default_language ASC

     LIMIT 0,1' : ')' ).'

) AS \''.$field_name_for_sql.'\'';

			}

			// if field is one for all languages - default language is quite enough
			if ($v[1]==1)
			{
				break;
			}
		}
	}
	
	if ($all_languages==false)
	{
		$ar_sql[] = '        '.sqlValue($lang).' AS language';
	}

	$sql = (implode(','."\r\n", $ar_sql))."\r\n".
	'   FROM'."\r\n".
	'        object_record r'."\r\n".
	(implode("\r\n", $ar_filter_sql))."\r\n".
	'  WHERE 1=1 AND '."\r\n".
	(implode("\r\n".'    AND ', $ar_where));

	cache_obj($object_id, $obj_chache_file_name, $sql);

	//возвращаем SQL запрос
	return $sql;
}

/**
 * Return object unique name by record id
 * @param int $record_id Record id
 * @param int $user_language user language
 * @return string Object Unique Name on success or ''
 */
function Get_object_unique_name_by_record_id($record_id, $user_language = null)
{
	global $language, $default_language;

	$is_one_for_all_lang = getField('SELECT one_for_all_languages FROM object_field WHERE object_id = 
						(SELECT object_id FROM object_record WHERE id='.sqlValue($record_id).')
						AND object_field_name = \'object_unique_name\'');

	if ($user_language == null)
	{
		$user_language = $language;
	}
	else
	{
		$user_language = $is_one_for_all_lang == '1' ? $default_language : $user_language;
	}
	$record_id = intval($record_id);
	$sql = ' SELECT 
			value 
		   FROM 
			object_content
		  WHERE 
			object_field_id = (
                                      		SELECT 
							id
	                                          FROM 
							object_field
						 WHERE 
							object_id = (
                                                           	     SELECT 
										object_id
                                                		       FROM 
										object_record
                                                                      WHERE 
										id='.sqlValue($record_id).'
								    )
								    
						   AND 
							object_field_name = \'object_unique_name\'
					  )
		    AND 
			language = '.sqlValue($user_language).' 
		    AND 
			object_record_id = '.sqlValue($record_id).'';

	$res = GetField($sql);
	return strval($res);
}

/**
 * Return record id by object unique name, if  
 * @param string $object_unique_name object unique name or object record id
 * @return int object record id
 */
function Get_object_record_id_by_unique_name($object_unique_name, $user_language = null, $object_field_name = 'object_unique_name')
{              
	global $language, $object_name;   

	if ($user_language == null)
	{
		$user_language = $language;
	}
		
	$sql = ' SELECT
			object_record_id
		   FROM
			object_content
		  WHERE
			value = '.sqlValue($object_unique_name).'
		    AND
			language = '.sqlValue($user_language).'
		    AND
			object_field_id = (SELECT id FROM object_field WHERE object_field_name = '.sqlValue($object_field_name).'

						    AND object_id = (SELECT id FROM object WHERE name = '.sqlValue($object_name).'))
		';

	$res = GetField($sql);

	if(!$res)
	{
		$res = $object_unique_name;
	}

	return  $res;
}

/**
* Return record_id for present $object_id, $field_name, $field_value and $language
*
*
*/

function get_object_record_id($object_id, $field_name, $field_value, $user_language = null)
{
	global $language;

	if ($user_language == null)
	{
		$user_language = $language;
	}

	$sql = 'SELECT 
			`oc`.`object_record_id`
		FROM
			`object_content` `oc`

		INNER JOIN
			`object_record` `or`
		ON
			`oc`.`object_record_id` = `or`.`id`
		WHERE
			`oc`.`object_field_id` = (
				SELECT `id` FROM `object_field` 
				WHERE 
					`object_field_name` = '.sqlValue($field_name).' 
				AND 
					`object_id` = '.sqlValue($object_id).'
			)
		AND
			`oc`.`value` = '.sqlValue($field_value).'
		AND
			`oc`.`language` = '.sqlValue($user_language).'
		AND 
			`or`.`object_id` = '.sqlValue($object_id);
	
	$record_id = getField($sql);
	return $record_id;
}


?>