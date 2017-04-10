<?php
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL.
* http://www.2k-group.com
*/
?>
<?

// explode text part and tail numeric part of var (some_456_string_123)
// to text(mixed) var (some_456_string_) and numeric var_id (123 or 0 if no numbers at the tail)
function get_var_id($var)
{
	// по єтй маске будем разбирать:
	// нас интересуют циферки в конце ([0-9]+)$'
	// перед кот-ми хоть одна не цифра, перед которой все что угодно '^(.*[^0-9])
	$mask = '^(.*[^0-9])([0-9]+)$';
	// сюда сложим результат
	$arr_ereg = array();
	// разносим чиселки в конце и все что перед ними в соотв-нно var_id и var
    $res = preg_match('/'.$mask.'/', $var, $arr_ereg);
	if ($res !== false && $res > 0){
		$var = $arr_ereg[1];
		$var_id = $arr_ereg[2];
	}else // нет чиселок в конце
	{
		$var_id = 0; // var осталось як було - вся переменная
	}

	return array($var, $var_id);
}

function del_cms_by_mask($var)
{
        runsql('DELETE FROM content WHERE var REGEXP "'.$var.'"', 0);
}

/**
 * Function deletes CMS.
 */
function del_cms($var, $lng=null, $page_id=null, $get_var_id = true)
{
	// explode text part and numeric part of var (some_string_123)
	// to text var (some_string_) and numeric var_id (123)
	if ($get_var_id === true)
	{
		list($var, $var_id) = get_var_id($var);
	}
	else
	{
		$var_id = 0;
	}

	// Если язык не конкретизирован, то удаляем CMS для всех языков, иначе - только для данного языка

	$sql = '
		DELETE
		  FROM content
		 WHERE var='.sqlValue($var).'
		   AND var_id='.sqlValue($var_id).'
	';

	if ($lng !== null)
	{
		$sql .= ' AND language = '.sqlValue($lng);
	}

	if ($page_id !== null)
	{
		$sql .= ' AND page_id = ' . sqlValue($page_id);
	}

	runsql($sql, 0);
}

function content_field_suffix()
{
	global $dns_draft_status;

	if ($dns_draft_status == true)
	{
		return '_draft';
	}
	else
	{
	        return ((
			config_var('use_draft_content')=='1' &&
			(get('admin_template')=='yes' || !empty($GLOBALS['modul'])) &&
			checkAdmin()
			) ? '_draft' : ''
		);
	}
}

function val_field_name()
{
	return 'val'.content_field_suffix();
}

function edit_date_field_name()
{
	return 'edit_date'.content_field_suffix();
}

/**
 * Function saves CMS.
 */
function save_cms($var, $val, $page_id=0, $lng=null, $short_desc=null, $full_desc=null, $get_var_id=1)
{
	// explode text part and numeric part of var (some_string_123)
	// to text var (some_string_) and numeric var_id (123)

	$af_rows = 0;

	if ($get_var_id == 1)
	{
		list($var, $var_id) = get_var_id($var);
	}
	else
	{

		$var_id = 0;
	}

	if ($lng===null)
	{
	        global $language;
		$lng = $language;
	}

	if ($short_desc===null)
	{
		$short_desc = $var.( $var_id > 0 ? $var_id : '' );
	}

        // ищем в контенте соотв. запись для текущего языка
        $rs = viewsql('

		SELECT '.val_field_name().'
		  FROM content
		 WHERE var='.sqlValue($var).'
		   AND var_id='.sqlValue($var_id).'
		   AND language='.sqlValue($lng).'
		   AND page_id='.sqlValue($page_id).'
	', 1);

        if (db_sql_num_rows($rs) < 1) // если нет такой - создаем
	{
                runsql ('

		 INSERT INTO
			content
		    SET
			'.val_field_name().'='.sqlValueSet($val).',
			'.(val_field_name()=='val'?'val_draft='.sqlValueSet($val).',':'').'
			short_desc='.sqlValueSet($short_desc).',
			full_desc='.sqlValueSet($full_desc).',
			var='.sqlValue($var).',
			var_id='.sqlValue($var_id).',
			language='.sqlValue($lng).',
			page_id='.sqlValue($page_id).',
			'.edit_date_field_name().'=NOW()
		', 0);
	}
        else        // если же есть - обновляем значение
	{
                runsql ('

		 UPDATE
			content
		    SET
			'.val_field_name().'='.sqlValueSet($val).',
			val_draft='.sqlValueSet($val).',
			'.edit_date_field_name().'=NOW(),
			edit_date_draft=NOW(),
			short_desc='.sqlValue($short_desc).',
			full_desc='.sqlValue($full_desc).'
		  WHERE
			var='.sqlValue($var).'
		    AND var_id='.sqlValue($var_id).'
		    AND language='.sqlValue($lng).'
		    AND page_id='.sqlValue($page_id).'

		', 0);

	}

	$af_rows = db_sql_affected_rows();

	if ($page_id > 0)
	{
		$sql = 'SELECT val FROM content WHERE var="edit_user" AND page_id='.sqlValue($page_id);
		$upd = (db_sql_num_rows(viewsql($sql, 0)) > 0);

		$sql = ( $upd ? 'UPDATE' : 'INSERT INTO' ).'
			content
			SET
				val='.sqlValue(session('login')).( $upd ? ' WHERE ':', ').'
				page_id='.sqlValue($page_id).($upd?' AND ':', ').'
				var="edit_user"
		';
		RunSQL($sql, 0);
	}

	if (check_cache_enabled())
   	{       
		delete_files_by_mask(get_full_name_cache_from_id($page_id, '', false, false).'*.html');		    		
	}

	return $af_rows;
}

/**
 * Function renames CMS.
 */
function rename_cms($var_name, $var_name_new)
{
	$sql = '
		 UPDATE	content
		    SET var = '.sqlValue($var_name_new).'
		  WHERE var = '.sqlValue($var_name).'
	';

	runsql($sql);
}

function save_cms_desc($var, $desc, $page_id=0, $lng=null)
{
	// explode text part and numeric part of var (some_string_123)
	// to text var (some_string_) and numeric var_id (123)
	list($var, $var_id) = get_var_id($var);

	if ($lng===null)
	{
	        global $language;
		$lng = $language;
	}

        // ищем в контенте соотв. запись для текущего языка
        $val = getField('SELECT val FROM content WHERE var='.sqlValue($var).' AND var_id='.sqlValue($var_id).' AND language='.sqlValue($lng).' AND page_id='.sqlValue($page_id), 0);
	// обновляем текущим val и нов-м desc
	save_cms($var.$var_id, $val, $page_id, $lng, $desc);
}

function create_cms($var, $page_id=0, $lng=null)
{
	// explode text part and numeric part of var (some_string_123)
	// to text var (some_string_) and numeric var_id (123)
	list($var, $var_id) = get_var_id($var);

	if ($lng===null)
	{
	        global $language;
		$lng = $language;
	}

        // ищем в контенте соотв. запись для текущего языка
        $rs = viewsql('
		SELECT val
		  FROM content
		 WHERE var='.sqlValue($var).'
		   AND var_id='.sqlValue($var_id).'
		   AND language='.sqlValue($lng).'
		   AND page_id='.sqlValue($page_id).'
	', 0);

        if (db_sql_num_rows($rs)<1) // если нет такой - создаем с пустым значением
	{
                runsql('
			INSERT INTO
				content
			SET
				var='.sqlValue($var).',
				var_id='.sqlValue($var_id).',
				language='.sqlValue($lng).',
				page_id='.sqlValue($page_id).',
				short_desc='.sqlValue($var.$var_id).'
		', 0);
	}
}

/**
 * Control-button for setting a FCK-editor. (Show content and button in the end). Controller is a page-independent.
 */
function e_cms($var)
{
	return edit_cms2($var).' '.cms($var);
}

/**
 * Control-button for setting a FCK-editor. (Show first button and after the content). Controller is a page-independent.
 */
function cms_e($var)
{
	return cms($var).' '.edit_cms2($var);
}

/**
 * Control-button for setting a FCK-editor. (Show content and button in the end). Controller is a page-dependent.
 */
function e_page_cms($var, $alt='', $sp='')
{
	return edit_page_cms($var).' '.page_cms($var, $alt, $sp);
}

/**
 * Control-button for setting a FCK-editor. (Show first button and after the content). Controller is a page-dependent.
 */
function page_cms_e($var, $alt='', $sp='')
{
	return page_cms($var).' '.edit_page_cms($var, $alt, $sp);
}

function getSlashOf($name)
{
	return addslashes(getHtmlOf($name));
}

/**
 * Convert to html special chars. It works like php-function htmlspecialchars with argument ENT_QUOTES.
 */
function getHtmlOf($name)
{
	return htmlspecialchars(getValueOf($name),ENT_QUOTES);
}

/**
 * Control-button for setting a MEDIA. (Show image and button). Controller is a page-independent.
 */
function media($object_type, $object_name, $property_position_top=MEDIA_PROPERTY_POSITION_TOP, $property_position_right=MEDIA_PROPERTY_POSITION_RIGHT)
{
	return media_insert($object_type, $object_name, 0, 0, '', $property_position_top, $property_position_right);
}

/**
 * Control-button for setting a MEDIA. (Show image and button). Controller is a page-dependent.
 */
function page_media($object_type, $object_name, $property_position_top=MEDIA_PROPERTY_POSITION_TOP, $property_position_right=MEDIA_PROPERTY_POSITION_RIGHT)
{
	return media_insert($object_type, $object_name, 0, 1, '', $property_position_top, $property_position_right);
}

/**
 * Control-button for setting a MEDIA. (Show just button). Controller is a page-independent.
 */
function media_control($object_type, $object_name, $property_position_top=MEDIA_PROPERTY_POSITION_TOP, $property_position_right=MEDIA_PROPERTY_POSITION_RIGHT)
{
	return media_insert($object_type, $object_name, 1, 0, '', $property_position_top, $property_position_right);
}

/**
 * Control-button for setting a MEDIA. (Show just button). Controller is a page-dependent.
 */
function page_media_control($object_type, $object_name, $property_position_top=MEDIA_PROPERTY_POSITION_TOP, $property_position_right=MEDIA_PROPERTY_POSITION_RIGHT)
{
	return media_insert($object_type, $object_name, 1, 1, '', $property_position_top, $property_position_right);
}

// возвращает cms-значение переменной, полученной конкатенацией $t и $var
// т.е. значение будет свое для каждой страницы (tpl)
function page_cms($var, $def_var='')
{
	global $t;

	$val = cms($var, $t);

	// если получилось пустое значение и есть что вернуть вместо него
	if ($val=='' && $def_var!='')
		return getValueOf($def_var);
	// иначе полученное значение, независимо от того, пусто ли оно
	else	return $val;
}

/**
 * Return the link, which was set with help function edit_page_link($var, $alt='')
 */
function cms_page_link($var, $user_language='', $sat_page_always_static_url=false)
{
	global $t;

	return cms_link($var, $t, $user_language, $sat_page_always_static_url);
}

/**
 * Return the link, which was set with help function edit_link($var, $alt='')
 */
function cms_link($var, $t='', $user_language='', $sat_page_always_static_url=false)
{
	global $language, $t_view;
	$user_language =  $user_language ? $user_language : $language;

	$val = cms($var, $t, null, 1 ,0);
	$link_info_arr = unserialize($val);

	// Define $sufix if this is t_view-version link
	if(isset($link_info_arr['diff_urls_per_t_view']) && ($link_info_arr['diff_urls_per_t_view']=='1'))
	{
		$t_view_for_links = getField('SELECT view_name FROM tpl_views WHERE view_folder='.sqlValue($t_view ? $t_view : db_constant('DEFAULT_TPL_VIEW_FOLDER')).' LIMIT 0,1');
	}
	$sufix = isset($t_view_for_links)&&($t_view_for_links!='') ? '_'.$t_view_for_links : '';

	// Define link depending by $link_type
	$link_type = $link_info_arr['type'.$sufix];
	switch ($link_type)
	{
		case 'sat_page': $res = EE_HTTP.((is_admin_template() && $sat_page_always_static_url==false) ? '?admin_template=yes&t='.$link_info_arr['sat'.$sufix].'&language='.$user_language : get_default_aliase_for_page($link_info_arr['sat'.$sufix], '', $user_language)); break;
		case 'static_link': $res = $link_info_arr['link'.$sufix]; break;
		default: $res = "#";
	}
	return $res;
}

function cms_by_type($var)
{
	$s = cms($var.'_'.cms($var.'_type'));
	return $s;
}

function cms_page_lang($var)
{
	global $page_language;
	return cms($var, $page_language);
}

/**
 * returns CMS short_desc.
 */
function cms_desc($var, $t = '', $user_language = null)
{
	return cms($var, $t, $user_language, false);
}

/**
 * Function return CMS value.
 */
function cms($var, $t = '', $user_language = null, $get_val_field = true, $need_convert_from_utf = true, $obj = false)
{
	// explode text part and numeric part of var (some_string_123)
	// to text var (some_string_) and numeric var_id (123)
	list($var, $var_id) = get_var_id($var);

	global $admin_template, $UserRole, $language, $default_language;

	$t = intval($t);

	if ($t != '')
	{
		// если $obj = true, то проверяем есть ли record_id который равен $t.(Object SEO, title)
		// проверяем есть ли страница под номером $t
		$res_count = getField('

                SELECT COUNT(*)
                  FROM '.( $obj ? 'object_record' : 'tpl_pages' ).'
                 WHERE id='.sqlValue($t).'

		', 0, 0);

		// если нет - возвращаем пустую строку
		if ($res_count == 0)
		{
			return '';
		}
		// иначе єто $t действительно номер странички
		else
		{
			$page_id = $t;
		}
	}
	else
	{
		$page_id = 0;
	}

	if ($user_language===null)
	{
		$user_language = $language;
	}

	$sql = '
                SELECT '.( $get_val_field ? val_field_name() : 'short_desc' ).'
                  FROM content
                 WHERE var='.sqlValue($var).'
                   AND var_id='.sqlValue($var_id).'
                   AND page_id='.sqlValue($page_id).( $get_val_field ? '
                   AND '.val_field_name().' IS NOT NULL ' : '' ).'
        ';

	$rs = viewsql($sql, 1);

	if (($db_sql_num_rows = db_sql_num_rows($rs)) < 1)
	{
		return '';
	}
	else
	{
		$sql = str_replace('%', '%%', $sql);

		$sql.= '           AND language=%s
		';

		// try to find in mentioned language content
		$rs = viewsql(sprintf($sql, sqlValue($user_language)), 0);
		// if was not found -
		if (db_sql_num_rows($rs) < 1)
		{
			// try to find in default language content
			$rs = viewsql(sprintf($sql, sqlValue($default_language)), 0);
		}

		// if was not found - return nothing
		if (db_sql_num_rows($rs) < 1)
		{
			return '';
		}
		// if was found - parse it, change links (if necessary), convert and return
		else
		{
			$r = db_sql_fetch_array($rs);
			$s = parse2($r[val_field_name()]);

			// bug_id=12282

			// We need to convert content before urls replacing
			//   to prevent cyrilic symbols removing from content
			//   on converting from UTF phase.

			// So, let at first convert content from UTF
			//   with urls like ?t=... inside
			//   and only after that we will replace such urls
			//   by there get_href(...)-aliases

			// PS: I don't remember what is need to check if it's admin section (YuriB make it),
			// but now we realy need to convert content in back office, for example in media list
			// so let comment next string and if errors will occure - fix situation by another way
//			if (!(strpos(EE_PHP_SELF, EE_HTTP_PREFIX.EE_ADMIN_SECTION) !== false || !empty($modul)))
//var_dump($var);
			if (need_convert_from_utf($need_convert_from_utf))
			{
				$s = convert_from_utf($s, $language);
			}

			// if we are looking for val or val_draft on front-end
			// - let change all links by default page aliases
			if ($get_val_field == true)
			{
				$s = replace_links_by_get_href($s);
			}

			return $s;
		}
	}
}

function replace_links_by_get_href($s)
{
	$numlinks = preg_match_all("|<a[^<>]+?href=\"(.*?((index.php)?\?([\d\w&;+-=\[\]]*))?)\"[^<>]*?>|si", $s, $links, PREG_PATTERN_ORDER);

	$newlinks = array();
	$strings = $links[4];

	for ($i = 0; $i < $numlinks; $i++)
	{
		preg_match("|t=([\d\w-]+)|i", $strings[$i], $p_info_t);
		$link_t = ( array_key_exists(1, $p_info_t) ? $p_info_t[1] : null );
		preg_match("|language=(\w+)|i", $strings[$i], $p_info_l);
		$link_lang = ( array_key_exists(1, $p_info_l) ? $p_info_l[1] : null );

		if (	$link_t==''
			||
			$link_lang==''
			||
			strpos(str_replace(array($p_info_t[0], $p_info_l[0]), array('', ''), $strings[$i]), "=") !== false
		)
		{
			continue;
		}

		$p_alias = get_href($link_t, '', $link_lang);

		// bug_id=10358
		$newlinks[$i] = str_replace($links[1][$i], $p_alias, $links[0][$i]);

		$s = str_replace($links[0][$i], $newlinks[$i], $s);
	}

	return $s;
}

//**********************************************************
function parse_qyery_string($value)
{
	global $QUERY_STRING;

	$atts = '';
	$att = explode("&",$QUERY_STRING);

	for ($i=0; $i<count($att); $i++)
	{
		if ($att[$i]!='' and !preg_match('/^/i'.$value.'=',$att[$i]))
		{
			$atts.= $att[$i].'&';
		}
	}
	return $atts;
}

function prepare_str($str)
{
	$s = preg_replace('/"/', '\"', killSlashes($str));
	$s = preg_replace("/'/", '&rsquo;', $s);

	return $s;
}

function clear_admin_uri ($uri)
{
	// убираем все префиксы "от админа"
	$uri = str_replace("admin_template=yes&amp;", "", $uri);
	$uri = str_replace("&amp;admin_template=yes", "", $uri);
	$uri = str_replace("admin_template=yes&", "", $uri);
	$uri = str_replace("&admin_template=yes", "", $uri);
	$uri = str_replace("?admin_template=yes", "", $uri);

	return $uri;
}

function is_admin_template()
{
	global $admin_template;

	if ($admin_template == 'yes')
	{
		return true;
	}
	else
	{
		return false;
	}
}

function clear_uri ($uri)
{
	return clear_admin_uri ($uri);
}

function mask_uri ($var)
{
	// убираем все спец-символы, на которые реагирует index.php
	$var = str_replace('?','_',$var);
	$var = str_replace('&','_',$var);

	return $var;
}

/**
 * This function return page cms text by it id with html special chars
 */
function get_htmlchars_page_cms($cms_id)
{
	$text = page_cms($cms_id);

	return htmlspecialchars($text,ENT_QUOTES);
}

/**
 * This function return cms text by it id with html special chars
 */
function get_htmlchars_cms($cms_id)
{
	$text = cms($cms_id);

	return htmlspecialchars($text,ENT_QUOTES);
}

if (!function_exists('htmlspecialchars_decode'))
{
	function htmlspecialchars_decode($text)
	{
		return strtr($text, array_flip(get_html_translation_table(HTML_SPECIALCHARS)));
	}
}

?>