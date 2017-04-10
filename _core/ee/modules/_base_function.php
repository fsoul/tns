<?

if (!function_exists('get_array_var'))
{
	function get_array_var($arr, $var)
	{
		return ( empty($arr[$var]) ? false : $arr[$var] );
	}
}

if (!function_exists('isset_array_var'))
{
	function isset_array_var($arr, $var)
	{
		return ( isset($arr[$var]) ? $arr[$var] : null );
	}
}

 

/**
 * ¬озвращает линк на страницу $page_name
 * в формате либо админки, либо фронтенда
 */
function get_href($page_name='', $lang_language='')
{
	global $language;
	global $object_name;
	global $object_id;

	$lang_language = ($lang_language == '') ? $language : $lang_language;


	if ($page_name == '')
	{
		$href = '';
	}
	else
	{
		$href = EE_HTTP;

		if (check_admin_template())
		{
			$href .= 'index.php?t='.$page_name.'&admin_template=yes&language='.$lang_language;
		}
		else
		{
			$href.= get_default_alias_for_page($page_name, '', $lang_language);
		}
	}
//var_dump($href);
	return $href;
}

function get_default_alias_for_page($page_id, $page_rule='', $lang='', $view='')
{
	return get_default_alias($page_id, '', $page_rule, $lang, $view);
}

/**
 * @return array List of accessible templates which contains into "/templates/VIEW/$view_folder_name" folder
 */

function create_accessible_view_template_list($view_folder_name)
{
	global $accessible_view_templates;

	if (isset($cache_view_templates_array))
	{
		$view_templates_array = $accessible_view_templates;
	}
	else
	{
		$view_templates_array = array();
		$dir = EE_PATH.'templates/VIEWS/'.$view_folder_name;

		if (file_exists($dir))
		{
			$handle = opendir($dir);
			while (false !== ($file = readdir($handle)))
			{
				if ($file != '.' && $file != '..')
				{
					$view_templates_array[$view_folder_name][] = str_replace('.tpl', '', $file);
				}
			}
		}

		$accessible_view_templates = $view_templates_array;
	}

	return $accessible_view_templates = $view_templates_array;
}

/* used in get_default_alias() */
function check_accessible_page_view($page_id, $view_name)
{
	global $page_file, $object_view;

	$template_name = getField('SELECT tf.file_name FROM tpl_pages t LEFT JOIN tpl_files tf ON t.tpl_id = tf.id WHERE t.id='.sqlValue($page_id));

	$ret = check_accessible_template_view($template_name, $view_name);

	return $ret;
}

/* using in parse_system_alias */
function check_accessible_template_view($template_name, $view_name)
{
	// by default any view page unaccessible
	$ret = false;

	$view_folder_name = get_tpl_view_folder($view_name);

	if (!is_null($view_folder_name)) // if it's no default view check accessible
	{
		$accessible_view_templates = create_accessible_view_template_list($view_folder_name);
		if (	isset($accessible_view_templates[$view_folder_name]) &&
			in_array($template_name, $accessible_view_templates[$view_folder_name])
		)
		{
			$ret = true;
		}
	}

	return $ret;
}

/**
* Get default alias for satellite and object pages
* @param integer|string $id - object record id or satellite page id (name)
* @param string $object_view - object template filename
* @param string $page_rule - alias rule
* @param string $lang - language code
* @param string $view - sattellite page rule. By default "html".
* @param string $added_GET_vars - get query string
*
* @return string Return alias for page
*/
//	return get_default_alias($page_id, '', $page_rule, $lang, $view, '');
function get_default_alias($id, $object_view = '', $page_rule = '', $lang = '', $view = '', $added_GET_vars = '')
{
	global 	$geted_aliases,    // if we have more than two link on page
		$default_language, //
		$language; 	   //

	global $default_view_name;
	/* Set view start */
	if (is($view_name) == '')
	{
//var_dump('_1');
		global $t_view;
		$view_name = (is_null($t_view) ? null : get_system_view_name($t_view));
	}

	if (	$view_name &&
		check_accessible_page_view($id, $view_name) === false
	)
	{
//var_dump('_2');
		$view_name = null;
	}
	/* Set view end */

	if (	$object_view && 
		$map_url = get_map_url(( $lang ? $lang : $language ), $view_name, $id, $object_view)
	)
	{
//var_dump('_3');
		return $map_url;
	}

	$alias_rule_prefix = ($object_view ? 'object_' : '' );

	if ($page_rule == '')
	{
//var_dump('_4');
		$page_rule 		= config_var($alias_rule_prefix . ($view_name ? 'views' : 'alias') .'_rule');
	}

	// overwrites page rule variables as they may interfere with the system global variables.
	$page_rule 	= str_replace("<%:", "<%:new_", $page_rule);
	// set page rule globals variables for parsing
	// for page: 	$new_language, $new_page_file, $new_page_folder, $new_page_name [, $new_t_view];
	// for object: 	$new_language, $new_object_folder, $new_object_name, $new_object_view, $new_object_id [, $new_t_view];

	preg_match_all("|<%:(.*)%>|U", $page_rule, $page_rule_vars);

	for ($i = 0; $i < count($page_rule_vars[1]); $i++)
	{
		$var = $page_rule_vars[1][$i];
		global $$var;
	}

        $new_language 	= ( $lang ? $lang : $language );
	$new_t_view 	= $view_name;
	$alias_name 	= $alias_rule_prefix.$id.(isset($object_view) ? '_'.$object_view : '').'_'.(is_null($new_t_view) ? '' : $new_t_view) . '_' . $new_language; //add $prefix to alias name (task #0011070)

	if (isset($geted_aliases[$alias_name]))
	{
//var_dump('_5');
		$alias = $geted_aliases[$alias_name];
	}
	else
	{
//var_dump('_6');
		// set object alias variables
		if ($object_view)
		{
//var_dump('_7');
			$new_object_name	= Get_object_name_by_record_id($id);
			$object_unique_name	= Get_object_unique_name_by_record_id($id, $new_language);

			if (is_object_in_db($id, $object_view))
			{
//var_dump('_8');
				$new_object_folder = config_var('object_folder', $new_language);
				$new_object_view   = $object_view;
				$new_object_id     = empty($object_unique_name) == 1 ? $id : $object_unique_name;
			}
		}
		else
		{
//var_dump('_9');
			// check satellite page in DB
			$rs = query_alias_info($id, $new_language);
//var_dump('_9.1');
			// if no such page in database - create standart URL (possible page_id is tpl-file name)
			if (db_sql_num_rows($rs) == 0)
			{
//var_dump('_10');
				$alias = 'index.php?t=' . $id . '&language=' . $new_language . ((is_null($new_t_view) || empty($new_t_view)) ? '' : '&t_view=' . $new_t_view);
			}
			else
			{
				// set page rule variables
				$f = db_sql_fetch_assoc($rs);

				$__page_id 		= $f['id'];
				$new_page_file 		= $f['file_name'];
				$new_page_folder 	= $f['folder'];
				$new_page_name 		= $f['page_name'];

                                // media > replace extension
				if ($f['type'] == 1)
				{
//var_dump('_12');
					$picture_vars = media_manage_vars('media_' . $id);

					if (    !isset($picture_vars['images'][$lang])
						||
						($picture_vars['images'][$lang] == '')
					)
					{
//var_dump('_13');
						if (	is_array($picture_vars) &&
							array_key_exists('images', $picture_vars) &&
							is_array($picture_vars['images']) &&
							array_key_exists($default_language, $picture_vars['images'])
						)
						{
//var_dump('_14');
							$picture_vars['images'][$lang] = $picture_vars['images'][$default_language];
						}
						else
						{
//var_dump('_15');
							$picture_vars['images'][$lang] = '';
						}
					}
	               	
					$image_name 	= $picture_vars['images'][$lang];
					$ext 		= substr($image_name, strrpos($image_name, '.')+1);
				}
			}
		}

		// bug_id = 10568
		global $ar_language_urls;

		if (empty($ar_language_urls))
		{
//var_dump('_16');
			$sql = 'SELECT language_code, language_url FROM v_language';

			$rs = viewsql($sql, 0);

			while ($row = db_sql_fetch_array($rs))
			{
				$ar_language_urls[$row['language_code']] = $row['language_url'];
			}
		}

		// in $new_language > language_code replace by language_url.
		// In time parsing link must contain language_url but not language_code. Examlpe: language_code > CN, language_url zs-CN

		// bug_id = 10568
		if (is_array($ar_language_urls) && array_key_exists($new_language, $ar_language_urls))
		{
//var_dump('_17');
			$new_language = $ar_language_urls[$new_language];
		}
                // create alias by appropriate rule
		if (!isset($alias))
		{
//var_dump('_18');
			$new_page_type = ($f['type'] == 1 ? $ext : $f['extension']);

			$alias = parse2($page_rule);

			// add addition GET-vars
			$added_GET_vars = ($added_GET_vars ? '?' . $added_GET_vars : '' );
			$alias .= htmlentities($added_GET_vars);
			$alias = del_first_slash($alias);
//vdump($alias, '$alias');
			// cache alias name
			$geted_aliases[$alias_name] = $alias;
		}
	}

	return $alias;
}


function query_alias_info($page, $lang = '', $extension = '')
{
	global 	$page_type,
		$t_type;

	if (is_null($page))
	{
		return false;
	}

	global  $page_name, $language, $default_language;

	if ($lang == '')
	{
		$lang = ( $language == '' ? $default_language : $language );
	}

	if (!is_numeric($page))
	{
		preg_match('/(([\/0-9a-zA-Z_% \.-]+)\/|)([0-9a-zA-Z_% &\.-]+)/ism', urlencode($page), $path_info);

//vdump($path_info, '$path_info');

		$path_info[3] = urldecode($path_info[3]);
		$path_info[2] = urldecode($path_info[2]);

		$pname = $path_info[3];
		$fname = $path_info[2];
//vdump($pname, '$pname');
//vdump($fname, '$fname');

		$sql = '

                SELECT
                       content.var_id
                  FROM
                       content
            INNER JOIN tpl_pages
                    ON content.var_id=tpl_pages.id

	    LEFT JOIN tpl_files
		   ON tpl_files.id=tpl_pages.tpl_id

                 WHERE
                       content.var="page_name_"
                   AND content.val='.sqlValue($pname).'
                   AND (
                        content.language = '.sqlValue($lang).'
                        OR
                        content.language = '.sqlValue($default_language).'
                       )
                   AND tpl_pages.tpl_id IS NOT NULL
		   AND tpl_files.type=' . sqlValue($t_type) . '
                   AND IF((SELECT COUNT(var_id) FROM content WHERE var="folder_path_" AND language = '.sqlValue($lang).' AND (IF("'.$fname.'" = "",val IS NULL,val = '.sqlValue($fname).')) LIMIT 1) > 0,tpl_pages.folder_id = (SELECT var_id FROM content WHERE var="folder_path_" AND language = '.sqlValue($lang).' AND val='.sqlValue($fname).' LIMIT 1),tpl_pages.folder_id IS NULL)
                ';

		$res = viewSQL($sql, 0);

		if (	db_sql_num_rows($res) > 1 
			&& !($page_type == 'html' || $page_type == 'htm' || $page_type == 'xml'))
		{
			while ($row = db_sql_fetch_assoc($res))
			{
				if (check_media_id($row['var_id']))
				{
					$row['var_id'] = $row['var_id'];
					break;
				}
			}
		}
		else
		{
			$row = db_sql_fetch_assoc($res);
		}

		$page = $row['var_id'];
		//save compability with very old versions
		if ($page == '')
		{
			//cut off folders (pages without templates)
			//leave media!!! 
			$page = getField('SELECT tp.id
						FROM tpl_pages AS tp
						WHERE tp.page_name='.sqlValue($pname).'
						AND tp.tpl_id IS NOT NULL
						LIMIT 1');
		}
	}

	$and = '';

	if (	$extension &&
		intval($extension) == 0 &&
		is_page_type($page_type)
	)
	{
		$and = ' AND p.extension='.sqlValue($extension);
	}

	$sql = 'SELECT
			p.id,
	  		`type`,
			file_name,
			extension,
	  		IFNULL(
				(
				 SELECT val 
				 FROM content
				 INNER JOIN v_language
				 ON content.language = v_language.language_code
				 WHERE var="page_name_"
				 AND var_id=p.id
				 AND 
				 (
					language = '.sqlValue($lang).'
					OR
					language = '.sqlValue($default_language).'
				 )  
				 ORDER BY v_language.default_language ASC LIMIT 1
  				 ),
				p.page_name
			) AS page_name,
  			IFNULL(
				(
				 SELECT val 
  				 FROM content
				 INNER JOIN v_language
				 ON content.language = v_language.language_code
				 WHERE var="folder_path_"
				 AND var_id=p.folder_id
				 AND 
				 (
					language = '.sqlValue($lang).'
					OR
					language = '.sqlValue($default_language).'
				 )
				 ORDER BY v_language.default_language ASC LIMIT 1
				),
				(
				 SELECT page_name
      				 FROM tpl_pages
      				 WHERE id = p.folder_id
				)
  			) AS folder,
			for_search,
  			page_description,
    			group_access
			FROM tpl_pages p
			INNER JOIN tpl_files f ON p.tpl_id = f.id
			WHERE p.id='.sqlValue($page).$and;
//var_dump($sql);
	return viewsql($sql, 0);
}


/**
 * getValueOf() - return value of variable or constant
 *
 * Syntax: getValueOf($name_of_global_variable, [ $vars_only ])
 *
 *  Description:
 *
 *	This function return value of variable or constant with name $name_of_global_variable.
 *	if $vars_only is "true" then function not will be return a value of constant with name $name_of_global_variable.
 *	GetValueOf() is one of the main function in this module that is why is posible to call it in html-templates like that:
 *		<%getValueOf:variable%> ,
 *		<%:variable%> ,
 *		and simply in expression
 *		:variable
 *
 *
 * Examples of use in templites:
 *
 *	<%GetValueOf:3%>		//<!--Return:3.   In analogy with PHP:" echo 3; "-->
 *	<%GetValueOf:Yes%> 		//<!--Return:Yes. In analogy with PHP:" echo 'Yes'; "-->
 *	<%:3%>				//<!--Return:3.   In analogy with PHP:" echo 3; "-->
 *	<%:Yes%> 			//<!--Return:Yes. In analogy with PHP:" echo 'Yes'; "-->
 *
 * 	<%setValueOf:a,1%>
 * 	<%setValueOf:b,2%>
 * 	<%setValueOf:c,3%>
 *	<%iif::a,1,:b,:c%>
 *	//<!--Like the same in PHP:"
 *		$a=1;
 *		$b=2;
 *		$c=3;
 *		if (a==1)
 *			echo $b;
 *		else
 *			echo $c;
 *	"-->
 *
 * Old description:
 *
 *	Ѕудем возвращать значение запрошенной переменной
 *
 */
function getValueOf($name_of_global_variable, $vars_only=false, $need_convert_from_utf = true)
{
	// провер€ем, есть ли така€ константа
	if (defined($name_of_global_variable) && !$vars_only)
	{
		$res = constant($name_of_global_variable);
	}
	else
	{
		global $$name_of_global_variable;

		if (isset($$name_of_global_variable))
		{
			$res = $$name_of_global_variable;
		}
		else
		{
			$res = '';
		}
	}

	if (need_convert_from_utf($need_convert_from_utf))
	{
		global $language;
		$res = convert_from_utf($res, $language);
	}

	return $res;
}


function del_first_slash($alias)
{
		$alias = str_replace('//', '/', $alias);

		// remove first slash if it exists, because of slash is present in end of EE_HTTP
		// and all links should be used only after EE_HTTP
		if ($alias[0] == '/')
		{
			$alias = substr($alias, 1);
		}

		return $alias;
}


function check_admin_template()
{
	global $admin_template;

	if ($admin_template=='yes' && !function_exists('CheckAdmin'))
	{
		require_once(EE_CORE_PATH.'modules/admin_autorize_function.php');
	}

	return (int)($admin_template=='yes' && CheckAdmin());
}


/**
 * [ Checks | Compare ] query string of current request with setted for this page allowed query list.
 * @param string $request_page - request uri of current page.
 * @param array $allowed_uri_params_list - allowed params list for current request page.
 * @param boolean $mail_report - if set and query string contains extra params, than mail report.
 * @return boolean|string if query string does not contain extra params then return false else return only allowed query string 
 * @see get_url_query_list
 * @see remove_by_keys
 */
function check_url_allowed_query($request_page, $allowed_uri_params_list, $mail_report = false) 
{
    //disabled
    die('check_url_allowed_query disabled');
	$uri_query_str = false;

	if (
		($request_uri_query_params = get_url_query_list($request_page))
			&&
		($skipped_uri_params = array_diff(array_keys($request_uri_query_params), $allowed_uri_params_list))
	   )
	{
		$allowed_uri_params = remove_by_keys($request_uri_query_params, $skipped_uri_params, false);
		$uri_query_str = ($allowed_uri_params) ? '?'.http_build_query($allowed_uri_params) : '';
	}

	//on development phase
	if ($mail_report && $uri_query_str !== false)
	{
		trigger_error(URL_QUERY_STRING_WARNING.$request_page, E_USER_WARNING);
	}

	return  $uri_query_str;
}

/**
 * Get url query list
 * @param string $url - current url
 * @param boolean $only_params - if set than return array of params else array of params-values.
 * @return boolean|string return false or url params
 */
function get_url_query_list($url, $only_params = false)
{                 
	global $page_extensions;

	$result = false;
	parse_str(parse_url($url, PHP_URL_QUERY), $url_query_list);
	$is_page = (bool) (array_search(pathinfo(parse_url($url, PHP_URL_PATH), PATHINFO_EXTENSION), $page_extensions) !== false);

	if ($url_query_list && $is_page)
	{
		if ($only_params)
		{
			$result  = array_keys($url_query_list);
		}
		else
		{
			$result  = $url_query_list;
		}
	}
       
	return $result;
}


function is(&$var)
{
	return ( isset($var) ? $var : null );
}



/*
** Return array of language encoding with keys of language code
** langEncode['language_code'] = language_encode
*/
function get_Array_Language_Encode()
{
        $langEncode = array();

	$lang_res = db_sql_query('SELECT language_code, l_encode FROM v_language');

	while($temp_array_encode = db_sql_fetch_array($lang_res))
	{
	        $langEncode[$temp_array_encode['language_code']] = $temp_array_encode['l_encode'];
	}

	return $langEncode;
}
