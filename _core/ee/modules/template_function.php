<?
/**
 * Checkeing for ZIP functionality (Standart && PclZip.library)
 */
function zip_enabled()
{
	if (!function_exists('zip_open'))
	{
		if (file_exists(EE_CORE_PATH.'lib/pclzip.lib.php'))
		{
			return true;

		}
		else
		{
			return false;
		}
	}
	else
	{
		return true;
	}
}

function mod($num,$base)
{
	return (($num/$base)==((int)($num/$base)));
}

/*
 * вставляет текст темплита в текущую позицию без парсинга
 */
function paste($tpl)
{
	// если в имени tpl-ки нет каталогов и т.д.
	//  - значит это просто имя файла, добавляем каталог
	if (strpos($tpl, '/')===false)
	{
		$tpl = 'templates/'.$tpl;
	}

	$tpl.= '.tpl';

	// иначе - что передали, то и вставляем
	return get_custom_or_core_file_contents($tpl);
}

function js_clear($str)
{
	$str = str_replace('\'', '', $str);
	$str = str_replace('"', '', $str);
	return $str;
}

function tpl_add($a, $b)
{
	return $a+$b;
}

function tpl_sub($a, $b)
{
	return $a-$b;
}

function tpl_mult($a, $b)
{
	return $a*$b;
}

function tpl_div($a, $b)
{
	if ($b!=0) return $a/$b;
	else return '0-devision error';
}

function tpl_modulus($var_1, $var_2)
{
 	return $var_1%$var_2;
}


function case_title($txt)
{
	return strtoupper(substr($txt,0,1)).substr($txt,1);
}

// каждое слово с прописной буквы
// остальные буквы строчные
function case_title_all($txt)
{
	$arr = explode(' ', strtolower($txt));
	foreach($arr as $key=>$val)
		$arr[$key] = case_title($val);
	return implode(' ', $arr);
}

function tpl_in_array ($val, $arr_name)
{
 	global $$arr_name;
	$arr = $$arr_name;
	if (is_array($arr))
		return in_array($val, $arr);
	else
		return (strpos($arr, $val));
}

function tpl_in_list ($val, $list, $delim=',')
{
	$arr = explode($delim, $list);
	return in_array(trim($val), $arr);
}

// возвращает строку вида
// имя_массива[]=1-й_эл-т_массива&...имя_массива[]=n-й_эл-т_массива
function tpl_array2str ($arr_name)
{
 	global $$arr_name;
	$arr = $$arr_name;
	$s = array();
	foreach ($arr as $val) {
		$s[] = $arr_name.'[]='.$val;
	}

	return implode('&', $s);
}

// возвращает i-й элемент массива $$arr_name
function tpl_array ($arr_name, $i=null)
{
	global $$arr_name;
	$arr = $$arr_name;
	if ($i==null)
		return $arr;
	else
		return $arr[$i];
}

function checkAdm()
{
	checkAdmin();
	return '';
}

function get($var)
{
	return get_array_var($_GET, $var);
}

function post($var)
{
	return get_array_var($_POST, $var);
}

function cookie($var)
{
	return get_array_var($_COOKIE, $var);
}

function server($var)
{
	return get_array_var($_SERVER, $var);
}

function session($var)
{
	return get_array_var($_SESSION, $var);
}

function isset_get($var)
{
	return isset_array_var($_GET, $var);
}

function isset_globals($var)
{
	return isset_array_var($GLOBALS, $var);
}

function isset_post($var)
{
	return isset_array_var($_POST, $var);
}

function isset_cookie($var)
{
	return isset_array_var($_COOKIE, $var);
}

function isset_server($var)
{
	return isset_array_var($_SERVER, $var);
}

function isset_session($var)
{
	return isset_array_var($_SESSION, $var);
}



/**
 * iif() - logical compare in html-templates
 *
 * Syntax: iif($value,
 *			$value1, $value1true,
 *			$value2, $value2true,
 *			...
 *			$value_else)
 *
 * Description:
 *
 * 	Function iif() is used for organization logical compare in html-templates.
 *	If $value equal $value1 then function return $value1true,
 *	if $value equal $value2 then function return $value2true,
 *	if $value equal no one next value then function return $value_else.
 *
 *
 * Examples of use in templates:
 *
 * 	<%iif:3,4,true,false%>	//<!-- result: "false" -->
 * 	<%iif:1,2,3,4,5,6,7,8%>	//<!-- result: "8" -->
 * 	<%iif:1,2,3,1,5,6,7,8%>	//<!-- result: "5" -->
 *
 *      <%setValueOf:language,RU%>  //<!--Like the same - $language='RU'; -->
 * 	<%iif:<%GetValueOf:language%>,RU,Russian,Another_Language%> //<!-- result: "Russian" -->
 *      (this example can be more simply:<%iif::language,RU,Russian,Another_Language%> )
 *
 *
 * Example of using iif() and include() in same time:
 *
 *	<%include:<%iif:<%:language%>,RU,ru_page,en_page%>%>			// It`s right!
 *	<%iif:<%:language%>,RU,<%include:ru_page%>,<%include:en_page%>%>        // It`s wrong! Because not possible to use include() in iif().
 *
 *	<%include:<%iif::a,5,including_page,%>%>	// It`s right!
 *	<%iif::a,5,include:<%including_page%>,%>	// It`s wrong!
 *
 *
 * Old description:
 *
 *	 working like
 *	 switch($arr_args[0])
 *	 {
 *		case $arr_args[1]: return $arr_args[2];
 *		case $arr_args[3]: return $arr_args[4];
 *		//...
 *		default: return $arr_args[last];
 * 	}
 */
function iif()
{
	$num_args = func_num_args();

	if ($num_args<3)
	{
		return 'Minimum 3 args for tpl_switch function...';
	}

	$arr_args = func_get_args();

	if ($num_args%2)
	{
		// add empty default value
		$arr_args[] = '';
	}

	for ($i=1; $i<$num_args-1; $i+=2)
		if ($arr_args[0]==$arr_args[$i])
		{
			return $arr_args[$i+1];
		}

	// return default value
	return $arr_args[count($arr_args)-1];
}

function checkValueOf($var, $val, $res, $res_else='')
{
	global $$var;
	if ($$var==$val) return $res;
	else return $res_else;
}

function inv($width, $height=0)
{
	return '<img src="'.EE_HTTP.'img/inv.gif" width="'.$width.'" height="'.$height.'" border="0" alt=""/>';
}

function include_if($var, $val, $tpl, $else_tpl='')
{
	global $$var;
	$s='';

	if ($$var==$val) $t=$tpl;
	else $t=$else_tpl;

	if ($t!='') $s=parse($t);

	return $s;
}


/**
 * setValueOf() - Apropriation for variable certain value.
 *
 * Syntax: setValueOf($variable, $value)
 *
 *  Description:
 *
 *	This function appropriate for $variable value $value.
 *
 * Examples of use in templites:
 *
 *	<%SetValueOf:id,3%>		//<!--Like the same in PHP:" $id = 3; "-->
 *	<%SetValueOf:message,Yes%> 	//<!--Like the same in PHP:" $message = 'Yes'; "-->
 *
 *	<%SetValueOf:language,<%iif::lang,,RU,EN%>%>
 *	//<!--Like the same in PHP:"
 *
 *		if ($lang == '')
 *		{
 *			$lang = 'RU';
 *		}
 *		else
 *		{
 *			$lang = 'EN';
 *		}
 *	"-->
 *
 *
 * Old description:
 *
 *	Установим в указанную переменную указанное значение
 *
 */
function setValueOf($name_of_global_variable, $value_of_global_variable)
{
	global $$name_of_global_variable;
	$$name_of_global_variable = $value_of_global_variable;
}

function date_to_text($date)
{
	list($year,$month,$day) = split ('[/.-]', $date);
	$s=$day.' ';
	switch($month)
	{
		case '01': $s.='января';break;
		case '02': $s.='февраля';break;
		case '03': $s.='марта';break;
		case '04': $s.='апреля';break;
		case '05': $s.='мая';break;
		case '06': $s.='июня';break;
		case '07': $s.='июля';break;
		case '08': $s.='августа';break;
		case '09': $s.='сентября';break;
		case '10': $s.='октября';break;
		case '11': $s.='ноября';break;
		case '12': $s.='декабря';break;
	}
	$s.=' '.$year;
	return $s;
}

function message_title()
{
	$s='';
	switch($_GET['op'])
	{
		case 'u_reminder': $s='Напомнить пароль';break;
		case 'register': $s='Регистрация';break;
		case 'u_update': $s='Мои данные';break;
		case 'new_order': $s='Добавление нового заказа';break;
	}
	return $s;
}

//	Обрезаем строку
function cut($str, $num = 0, $delta = 0)
{
//	global $MAX_CHARS;
	if ($num == 0 OR $num < $delta)
	{
		$num = config_var('MAX_CHARS');;
	}

	$s = preg_replace('/<br/?><br/?>/i', '', $str);
	$s = preg_replace('/^<br/?>/i', '', $s);
	$s = preg_replace('/<br/?>/i', ' ', $s);

	$s = strip_tags($s);

	$M = max(($num - $delta), 0);

	if (strlen(trim(strip_tags($s))) > $M)
	{
		$pos = strpos($s, ' ', $M);

		if ($pos)
		{
			$s = substr($s, 0, $pos);
		}

		return $s.'...';
	}
	else
	{
		return $s;
	}
}

function cut_by_name($var_name,$num=0,$delta=0)
{
	global $$var_name;
	return cut($$var_name,$num,$delta);
}

function site_info()
{
	$s=trim(getError('auth'));
	if($s=='') $s=date_to_text(date('Y-m-d'));
	return $s;
}

function print_cms_field($name='aComment',$width=600,$height=250,$toolbar='Basic')
{
	global $$name;

	// 6446
	include_once(EE_CORE_PATH.'fck_custom/fckeditor.php');
	$oFCKeditor = new EE_FCKeditor($name);
	$oFCKeditor->ToolbarSet=$toolbar;
	$oFCKeditor->Width=$width;
	$oFCKeditor->Height=$height;
	$oFCKeditor->UserFilesPath=EE_FILE_PATH;
	$oFCKeditor->Value=dcd($$name);
	$oFCKeditor->CanUpload=true;	// Overrides fck_config.js default configuration
	$oFCKeditor->CanBrowse=true;	// Overrides fck_config.js default configuration
	$oFCKeditor->BasePath=EE_HTTP_PREFIX.'fckeditor/' ;		// '/FCKeditor/' is the default value so this line could be deleted.
	$oFCKeditor->Config["CustomConfigurationsPath"]=EE_HTTP.'fck_custom/myconfig.php';
	return $oFCKeditor->CreateHtml();
}

// возвращает аттрибут bgcolor="<чередующийся цвет>"
// аргумент - индекс цвета для первого раза
function tr_bgcolor ($i=0)
{
	global $tr_bgcolor_i;
	$bg_colors = array("#ffffff", "#ededfd");

	if (!isset($tr_bgcolor_i))
	{
		$tr_bgcolor_i=$i;
	}
	else
	{
		$tr_bgcolor_i=1-$tr_bgcolor_i;;
	}
	return ' bgcolor="'.$bg_colors[$tr_bgcolor_i].'" ';
}


function constant_name($str)
{
	return strtoupper(str_replace(array(' ', '"', '\''), array('_', '_', '_'), trim($str)));
}

/*
** Check's if $value is defined constant and returns value of this constant.
** Example: cons('my first constant');
** Input: 'my first constant';
** Output: value of MY_FIRST_CONSTANT;
*/
function cons($value)
{
	$constant_name = constant_name($value);

	if (defined($constant_name))
	{
		return constant($constant_name);
	}
	else
	{
		return $value;
	}
}

/*
 * Функции для совместимости с предыдущими проектами.
 * В новом движке вполне могут быть реализованы прямо в темплите.
 */
function big_cms($vtag_value)
{
	return strtoupper($vtag_value);
}

function s_class($vtag_value)
{
	return status_class($vtag_value);
}

//function edit_image($vtag_value)
//{
//	return print_edit_img_bt($vtag_value);
//}

function edit_doc($vtag_value)
{
	return print_edit_pdf_bt($vtag_value);
}

function getBigValueOf($vtag_value)
{
	return strtoupper(getValueOf($vtag_value));
}

function menu_class2($vtag_value)
{
	return menu_class($vtag_value,'lmenu','almenu');
}

function paste_file($file_name)
{
	$fname = substr($file_name,(strrpos($file_name,'/')+1));
	$mime_type = (PMA_USR_BROWSER_AGENT == 'SAFARI' ? 'application/octet-stream' : 'application/octet-stream');

//	header('Content-Type: ' . $mime_type);
//	header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
//	header('Content-disposition: attachment; filename="'.$fname.'"');
	$url = $file_name;
	$file_name = str_replace(EE_HTTP,EE_PATH,$file_name);
	if (!check_file($file_name))
	{
			header('Status: 404 Not found');
			exit();
	}
	else
	{
		if (filesize($file_name) >= MAX_MEDIA_DIRECT_OUTPUT_SIZE)
		{
			header('Status: 301 Moved Permanently');
			header('Location: ' . $url);
			exit();
			return '';
		}
		else
		{
			$__pasted_file = fopen($file_name,'r');
			$__output = '';
			while (!feof($__pasted_file)) {
				$__output .= fgets($__pasted_file, DIRECT_OUTPUT_BUFF_SIZE);
			}
			fclose($__pasted_file);
			return $__output;
		}
	}
//	exit();
}

/**
	Enhanced image editor
	* @param $picture_name - alias of the image (e.g. 'logo')
	* @return string - <a> + <img> tags and, if administrator privilegies, image edit button
	*/
function edit_image($picture_name)
{
	global $language, $UserRole, $imgPath;
	global $default_language;

	$s = '';
	list($var, $var_id) = get_var_id($picture_name);
	$res = viewsql('select val from content where var = '.sqlValue($var).' and var_id = '.sqlValue($var_id), 0);
	if(db_sql_num_rows($res)>0)
	{
		$row = db_sql_fetch_assoc($res);
		$picture_vars = unserialize($row['val']);


	if (isset($picture_vars['link']['type']) &&	$picture_vars['link']['type'] != 'open_none')
	{
		if ($picture_vars['link']['type'] == 'open_url')
			$s.= '<a href="'.$picture_vars['link']['url'].'" ';

		elseif ($picture_vars['link']['type'] == 'open_sat_page')
		{
			$link = '?t='.$picture_vars['link']['sat'].'&language='.$language;
			$aliase = EE_HTTP.get_default_aliase_for_page($picture_vars['link']['sat']);

			if ($aliase != false and get('admin_template')!='yes')
				$link = $aliase;

			$s.= '<a href="'.$link.'" ';
		}

		if ($picture_vars['link']['opentype'] == '_blank')
			$s.=' target="_blank"';
		else
			$s.=' target="_self"';

		//Adding title to link
		if(!empty($picture_vars['alts'][$language]))
		{
			$s.=' title="'.$picture_vars['alts'][$language].'"';
		}

		//Adding XITI-attributes
		if(EE_LINK_XITI_ENABLE)
		{
			$xitiClickType	= isset($picture_vars['link']['xitiClickType'])	? $picture_vars['link']['xitiClickType'] : '';
			$xitiS2		= isset($picture_vars['link']['xitiS2'])	? $picture_vars['link']['xitiS2'] : '';
			$xitiLabel	= isset($picture_vars['link']['xitiLabel'])	? $picture_vars['link']['xitiLabel'] : '';
			$s .= ' '.stick_xiti_attribute($xitiClickType, $xitiS2, $xitiLabel).' ';
		}


		$s.='>';
	}
	if (	empty($picture_vars['images'][$language])
		or
		!fileExists($picture_vars['images'][$language])	)
	{
		$picture_vars['images'][$language] = $picture_vars['images'][$default_language];
	}

	if (empty($picture_vars['images'][$language]))
		$picture_vars['images'][$language] = $picture_name;

	if (fileExists($picture_vars['images'][$language]))
	{
		$s.= '<img src="'.EE_HTTP.EE_IMG_PATH.$picture_vars['images'][$language].'" border="0" alt="'.(empty($picture_vars['alts'][$language]) ? $picture_vars['alts'][$default_language] : $picture_vars['alts'][$language]).'" ';

		if (	$picture_vars['size_x'] != 0 &&
			$picture_vars['size_y'] != 0	)
		{
			$s.= 'width="'.$picture_vars['size_x'].'" height="'.$picture_vars['size_y'].'"';
		}

		$s.='/>';
	}

	if (	$picture_vars['link']['type'] != 'open_none' &&
		isset($picture_vars['link']['type'])	)
	{
		$s.= '</a>';
	}
	}
	if (checkAdmin() && $UserRole==ADMINISTRATOR && get('admin_template')=='yes')
	{
		$s.='<div style="text-align:left; margin:-16px 0px 0px 0px;"><a href="#" onclick="edit_img_lang(\''.$picture_name.'\');return false"><img src="'.EE_HTTP.'img/cms_edit_img.gif" width="43" height="16" alt="'.ADMIN_EDIT_IMAGE.''.$picture_name.'" title="'.ADMIN_EDIT_IMAGE.''.$picture_name.'" border="0"/></a></div>';
	}
	return $s;
}

/**
 *  Function media_insert($object_type, $object_name, $just_controller=0, $page_dependent=1) uses to control media on design.
 *  With help it, there is possible to change media on front-end from admin-panel
 *
 *  $object_type	- type of media ("flash", "images", "doc")
 *  $object_name	- name (or id) of media
 *  $page_dependent	- flag, which indicate that then media must me dependent of page or not (by default it is dependent (= 1) )
 *  $just_controller	- if $just_controller = 0 then we will see just control-button without image (by default = 0, it's mean that we will see button and image)
 *
 *  To get URL of media use function get_media_url();
 */
function media_insert($object_type, $object_name, $just_controller=0, $page_dependent=1, $additional_params = '', $property_position_top=MEDIA_PROPERTY_POSITION_TOP, $property_position_right=MEDIA_PROPERTY_POSITION_RIGHT)
{
	global $language, $media_image_lang_bar, $i_name, $UserRole;
	global $media_file, $media_border, $media_height, $media_width, $media_unit_type, $media_alt, $picture_vars, $media_unit_type;
	global $media_show_menu, $media_quality, $media_bgcolor, $t, $ignore_admin_media, $tag_params;
	global $get_as_tag;

	global $t;
	$tmp_t = $t;

	$get_as_tag = 1;
	$s = '';
	
	$tag_params = $additional_params;
	$ignore_admin_media = 1;
	/*
	** Т.к. картинка медии не зависит от языка, третий параметр функции cms (,,language), передаем пустую строку.
	*/
	$__m_data = unserialize(cms('media_inserted_'.$object_name,($page_dependent==1)?$t:'', '', 1, 0));

	$__m_data['link']['media_title'] = cms('media_title_'.$object_name, ($page_dependent == 1 ? $t : 0), $language, 1, 0);

	$media_id = ( array_key_exists('media_id', $__m_data) ? $__m_data['media_id'] : null );

	media_get($object_type, $media_id, $__m_data);


	//If there is needs just control-button...
	$s = '';
	if( $just_controller == 0)
	{
		$s = parse_media($media_id);
	}

	if (checkAdmin() && ($UserRole==ADMINISTRATOR || $UserRole==POWERUSER) && get('admin_template')=='yes' && !check_content_access(CA_READ_ONLY))
	{
		if ($object_type != 'flash')
		{
		        //New style position of edit image button
			$s.='<div style="margin: '.($media_id ? '-20px' : '0px').' 0px 0px 0px">';
			$s.='&nbsp;<a href="#" onclick="page_dependent='.$page_dependent.'; media_insert(\''.$object_name.'\');return false"><img src="'.EE_HTTP.'img/cms_edit_img.gif" width="43" height="16" alt="'.ADMIN_EDIT_OBJECT.''.$object_name.'" title="'.ADMIN_EDIT_OBJECT.''.$object_name.'" border="0"/></a>';
			if ($media_id != 0) $s.='<div style="margin: '.$property_position_top.' 0px 0px '.$property_position_right.';"><a style="padding: 0px 3px 2px 0px; color:#000; background: #fff; border: 1px solid #f00;" href="'.EE_HTTP.'index.php?admin_template='.get('admin_template').'&t='.$media_id.'&t_back_refer='.$t.'">&nbsp;Media&nbsp;properties</a></div>';
			$s.='</div>';
		}
		else
		{
			//  Old style position of edit image button
			if ($s != '')
			{
				// check if found media really exists in tpl_pages
				// if it was deleted - no link to media properties will be printed
				$s.= ' &nbsp;<a href="'.EE_HTTP.'index.php?admin_template='.get('admin_template').'&t='.$media_id.'&t_back_refer='.$t.'">&nbsp;Media&nbsp;properties</a>';
			}
			$s.= ' &nbsp;<a href="#" onclick="media_insert(\''.$object_name.'\');return false"><img src="'.EE_HTTP.'img/cms_edit_img.gif" width="43" height="16" alt="'.ADMIN_EDIT_OBJECT.''.$object_name.'" title="'.ADMIN_EDIT_OBJECT.''.$object_name.'" border="0"/></a>';
		}
	}

	$t = $tmp_t;

	return $s;
}


// Try to include templates one by one. If none of templates exists - do nothing
function try_include()
{
	global $admin, $ignore_admin;

	$params = func_get_args();

	foreach ($params as $tpl)
	{
		if ($admin and $ignore_admin!==1)
		{
			$fileh = EE_ADMIN_PATH."templates/".$tpl.'.tpl';
		}
		else
		{
			$fileh = EE_PATH."templates/".$tpl.'.tpl';
		}

		$fileh = get_custom_or_core_file_name($fileh);

		if (file_exists($fileh) and filesize($fileh)>0)
		{
			// don't look in DB because of it's about real template
			return parse_tpl($tpl);
		}
	}
}

// evaluates function $func_name with arguments, that are global variables.
// Names of this global variables passed though other arguments of function
// safe to run from template
function eval_function_tpl($func_name)
{
	$params = func_get_args();
	array_shift($params);
	$args = array();
	foreach ($params as $v)
	{
		global $$v;
//		$args[] = "'".str_replace("'", "\\'", $$v)."'";
		$args[] = "$".$v;
	}
	return eval('return '.$func_name.'('.implode(',',$args).');');
}


/**
 * Return id-number of default page if it exist. If default page not exist, function return id of first in list page.
 */
function get_default_page_id()
{
	return getField('SELECT defaultpage.id
				FROM
					((select id from tpl_pages where default_page=1 limit 0,1)
					UNION
					(select id from tpl_pages order by id limit 0,1))
					AS defaultpage
				LIMIT 0,1');
}

/**
 * Get page_name to start page
 */

function get_page_name_to_start_page()
{
	return getField('SELECT page_name FROM v_tpl_page where default_page=1 LIMIT 0,1');
}

/**
 * Execute php-file and return the result
 */
function include_php($filename, $int_res=false)
{
	$res = include($filename);
	$res = ($res === 1 && $int_res===false)?'':$res;
	return $res;
}

/**
 * Return content of file
 */
function include_js($filename)
{
	return file_get_contents($filename);
}


function tpl_escape_coma()
{
	if (func_num_args() > 0)
	$__args = func_get_args();

	return implode('\,',$__args);
}

/**
 *
 * Проверяем, существует ли файл $src
 * если да - рисуем кнопочку при наведении на которую покажем рисунок
 * иначе кнопочку с альт-предупреждением что просмотр картинки невозможен
 *
 */
function display_preview_button($src)
{
	$src_path = str_replace(EE_HTTP, EE_PATH, $src);

	if (check_file($src_path))
	{
		$res = '<span onmouseover="ddrivetip(\'<img src=\\\''.$src.'\\\'>\')" onMouseout="hideddrivetip()"><img src="'.EE_HTTP.'img/camera.gif"></span>';
	}
	else
	{
		$res = '<img alt="'.cons('No preview').'" title="'.cons('No preview').'" src="'.EE_HTTP.'img/camera_p.gif">';
	}

	return $res;
}



/**
 * This function can be used in templates for print some messages just for Administrators (in back-end)
 * Example: <%admin_msg:Please\, insert some content:%>
 */
function admin_msg($message)
{
	$text = '';

	if( checkAdmin() and get('admin_template')=='yes')
	{
		$text = $message;		
	}	

	return $text;
}

//Function set folder in folders list of pages or medias edit windows from get array
function getFolderFromGet()
{
	global $field_name, $$field_name;
	if(empty($$field_name) && !empty($_GET[$field_name]))
	{
		$$field_name = $_GET[$field_name];
	}
}

//Function make possible to stick xiti-attributes to the link
function stick_xiti_attribute($xitiClickType, $xitiS2, $xitiLabel)
{
	$res = '';
	if(EE_LINK_XITI_ENABLE
		&& $xitiClickType != ''
	)
	{
		$res = 'onclick="xt_med(\'C\',\''.$xitiS2.'\',\''.$xitiLabel.'\',\''.$xitiClickType.'\')"';
	}

	return $res;
}

function rem()
{
	return '';
}

function remark()
{
	return '';
}

function comment()
{
	return '';
}

function is_in_backend_pages()
{
	global $UserRole;

	return (check_admin_template() && ($UserRole==ADMINISTRATOR || $UserRole==POWERUSER));
}

/**
 * Sets allowed uri params to global array $tpl_allowed_uri_params_list
 */
function set_allowed_uri_params_list()
{
    //allowed params disabled. All allowed
//	if ($ar_params = func_get_args())
//	{
//		global $tpl_allowed_uri_params_list;
//
//		if (is_array($tpl_allowed_uri_params_list))
//		{
//			foreach ($ar_params as $val)
//			{
//				$tpl_allowed_uri_params_list[] = $val;
//			}
//		}
//		else
//		{
//			$tpl_allowed_uri_params_list = $ar_params;
//		}
//	}
}


