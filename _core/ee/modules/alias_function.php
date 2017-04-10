<?php 
function get_alias($uri, $tpl_sat='')
{
	$sql = '
		SELECT source_url
		  FROM permanent_redirect
		 WHERE target_url='.sqlValue($uri);
	$r = viewsql($sql, 0);

	if (mysql_num_rows($r) > 0)
	{
		$res = mysql_fetch_array($r);
		$result = $res['source_url'];
	}
	else
		$result = false;

	if ($result == false)
	{
		if (isset($tpl_sat) && $tpl_sat!='')
			$result = get_default_aliase_for_page($tpl_sat);

		if ($result == false)
			$result = $uri;
	}

	if (strpos($result, 'http:') === false)
		$result = EE_HTTP.$result;

	return $result;
}


/**
 * This function generate default URL-alias for indicated object by some rules.
 *
 * @param int $object_record_id	object id
 * @param str $object_view	template, which will be to show object-content
 * @param str $added_GET_vars	there are possible to add some variables through GET method
 * @param str $page_rule	there are possible to indicate not default rule for building an alias in this parameter
 * @param str $lang		language
 * @return str $alias		result default URL-alias like a static
 */

function get_default_alias_for_object($object_record_id, $object_view, $added_GET_vars='', $page_rule='', $lang='')
{
	return get_default_alias($object_record_id, $object_view, $page_rule, $lang, $view, $added_GET_vars);
}

/**
 * This function generate URL-alias for indicated object by some rules.
 *
 * @param int $object_record_id	object id
 * @param str $object_view	template, which will be to show object-content
 * @param str $added_GET_vars	there are possible to add some variables through GET method
 * @param str $page_rule	there are possible to indicate not default rule for building an alias in this parameter
 * @param str $lang		language
 * @return str $alias		result URL-alias like a static
 */

function get_alias_for_object($object_record_id, $object_view, $added_GET_vars='', $page_rule='', $lang='')
{
	global $language;

	$object_unique_name = Get_object_unique_name_by_record_id($object_record_id);

	$lang = ($lang!='') ? $lang : $language;

	if (checkAdmin() && get('admin_template') == 'yes')
	{
		$object_alias = 'index.php?t='.$object_view.
					  '&admin_template=yes'.
					  '&language='.$lang.
					  '&object_name='.Get_object_name_by_record_id($object_record_id).
					  '&object_id='.$object_record_id.
					  ( empty($object_unique_name) == 1?'':'&object_unic_name='.$object_unique_name ).
					  ( empty($added_GET_vars) == 1?'':'&'.$added_GET_vars );
	}
	else
	{
		$object_alias = get_default_alias_for_object($object_record_id, $object_view, $added_GET_vars, $page_rule, $lang);
	}
	return	$object_alias;
}


// incorrect word "aliase" in function name
function get_default_aliase_for_page($page_id, $page_rule='', $lang='')
{
	return get_default_alias_for_page($page_id, $page_rule, $lang);
}



function build_alias_string ($page_id, $language='', $page_rule='')
{
	global $default_language;
	if ($language == '' )
		$language = $default_language;
	$sql = 'SELECT IFNULL(p_content,p_strong) AS page_name, IFNULL(f_content,f_strong) AS folder FROM
		(SELECT
			 p.page_name as p_strong,
			 (SELECT val
			 	FROM content
			 	WHERE var = "page_name_" AND var_id = p.id
			 		AND (language = '.sqlValue($language).' OR language = '.sqlValue($default_language).') LIMIT 1) AS p_content,
			 (SELECT val
			 	FROM content
			 	WHERE var = "folder_path_" AND var_id = p.folder_id
			 		AND (language = '.sqlValue($language).' OR language = '.sqlValue($default_language).') LIMIT 1) as f_content,
			 (SELECT page_name FROM tpl_pages WHERE id  = p.folder_id) AS f_strong
		FROM v_tpl_page p
		WHERE  p.id='.sqlValue($page_id).') tmp_select';
	$r = ViewSQL($sql,0);
	list($page_name, $folder) = db_sql_fetch_row($r);

	$uris = array("?t=$page_name&language=$language",
					"?t=$page_id&language=$language",
					"?t=$page_name",
					"?t=$page_id");
	for ($i=0; $i<count($uris); $i++)
	{
		$sql = '
			SELECT source_url
			  FROM permanent_redirect
			 WHERE target_url='.sqlValue($uris[$i]).'
		';
		$r = viewsql($sql, 0);
		if (mysql_num_rows($r) > 0)
		{
			$res = mysql_fetch_array($r);
			return $res['source_url'];
		}
	}

	return get_default_aliase_for_page($page_id,'',$language);
}

/**
 * This function generate default URL-alias from site root directory(/language/folder/page_name:t_view.html kind) for indicated page and view by some rules.
 *
 * @param int|str $page_id	page id or page name
 * @param str $view		view folder (templates/VIEWS/view_folder)
 * @param str $lang		language
 * @return str $alias		result default URL-alias like a static
 */
function get_default_alias_for_view($page_id, $view, $lang = '', $nice_url = false)
{
	global $language;

	$lang = $lang ? $lang : $language;

	$view = get_system_view_name($view);

	if (CheckAdmin() && get('admin_template') == 'yes' && !$nice_url)
	{
		$alias = 'index.php?t='.$page_id.'&t_view='.$view.'&admin_template=yes&language='.$lang;
	}
	else
	{
		$alias = get_default_alias_for_page($page_id, config_var('views_rule'), $lang, $view);
	}
	return $alias;
}

/**
 * This function generate default URL-alias (http://somehost/language/folder/page_name:t_view.html kind) for indicated page and view by some rules.
 *
 * @param int|str $page_id	page id or page name
 * @param str $view		view folder (templates/VIEWS/view_folder)
 * @param str $lang		language
 * @return str $alias		result default URL-alias like a static
 */
function get_view_href($page_id, $view, $lang = '', $added_GET_vars = false)
{
	$query_string = '';
	$has_question = strpos($_SERVER['REQUEST_URI'], '?');
	if($has_question !== false && $GLOBALS['admin_template'] !='yes')
	{
		$query_string = substr($_SERVER['REQUEST_URI'], $has_question);
	}
	$added_GET_vars = ($added_GET_vars ? '?' . $added_GET_vars : '' );
	return EE_HTTP.get_default_alias_for_view($page_id, $view, $lang).htmlentities($added_GET_vars);
}

function get_system_view_name($view)
{

	if((int)$view != 0)
	{
		$new_view = getField('SELECT view_name FROM tpl_views WHERE id='.sqlValue($view));

		return ($new_view ? $new_view : $view);
	}
	else
	{
		$new_view = getField('SELECT view_name FROM tpl_views WHERE view_folder='.sqlValue($view));

		return ($new_view ? $new_view : $view);
	}

	return $view;
}
/**
 * This function checks default URL-alias for present in it all needed variables.
 *
 * @param str $alias		alias mask (<%:language%>/<%:page_name%> etc.)
 * @param str $alias_type	type of alias (object or page)
 * @return str			return empty string if all correct or error if not
 */
function check_default_alias_mask($alias,$alias_type,$trigger_error=true)
{
	$error = '';
	$alias_example = getField('SELECT val FROM config WHERE var=\''.($alias_type == 'object' ? 'object_' : '').'alias_rule_example\'');

	preg_match_all("|<%:(.*)%>|U",$alias_example,$alias_example_array);
	preg_match_all("|<%:(.*)%>|U",$alias,$alias_array);

	sort($alias_example_array[1],SORT_STRING);
	sort($alias_array[1],SORT_STRING);

	$difference = array_diff($alias_example_array[1],$alias_array[1]);
	if (is_array($difference) && count($difference) > 0)
	{
		$error = '<%:'.reset($difference).'%>';
	}
	$error =  ($error != '' ? 'Incorrect default '.$alias_type.' alias rule is used. '.$error.'-parameter is absent!' : '');
	if ($trigger_error && $error != '') 
	{
		trigger_error($error);
	}
	return $error;
}

