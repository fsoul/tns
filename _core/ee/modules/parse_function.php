<?
/**
 * This function get URLs-address and try to parse it.
 * First it try to find needed satellite-page by its alias-rules.
 * If the satellite-page is not found, the function try to find object-record by alias-rule.
 * @param str $alias got URL address
 * @param str $alias_rule the alias-rule for comparison
 * @return bool If the function returns the TRUE, it means that URL was parsed successfully. In another case it means that ULR is not according with the alias-rule and we must to show the 404-error.
 */
function parse_system_alias($alias, $alias_rule, $specific_rules = null)
{	
	global $default_language;
	global $t_type;
	// http://teamtrack.2kgroup.com/view.php?id=0011932
	$alias = parse_url($alias, PHP_URL_PATH);

	// определяем регулязное выражение для замены любой переменной в $alias_rule(правиле псевдонима)
	$reg = '([0-9a-zA-Z_%\.-]+)';
	// если не указана страничка (http://www.somehost.com/folder/subfolder/) то...
	if (!preg_match('/^'.$reg.'\.([a-zA-Z]{3,4}+)$/i', substr($alias, strrpos($alias, '/')+1)))
	{
		$last_alias_symbol = substr(strrev($alias), 0, 1);
		// проверяем последний символ...
		// если последний символ не слеш, 
		// то проверяем ниличие странички или папки с таким названием
		if ($last_alias_symbol != '/')
		{
			$f_p = substr($alias, (strrpos($alias, '/') ? (strrpos($alias, '/') + 1) : 0));
			// если пользователь имеет ввиду папку(при этом в конце url не поставил слеш)
			// добавляем слеш и "пустышку"
			if (db_sql_num_rows(ViewSQL('SELECT id FROM v_tpl_folder_content WHERE page_name='.sqlValue($f_p).';')) > 0)
			{
				$alias .=  '/__page_name_replacement__.html';
			}
		}
		// иначе просто добавляем "пустышку"
		else
		{
			$alias .= '__page_name_replacement__.html';
		}
	}
	// заменяем '<%:page_type%>' на соответствующее регулярное выражение
	if (strpos($alias_rule, '<%:page_type%>'))
	{
		$alias_rule = str_replace('<%:page_type%>','([a-zA-Z]+)',$alias_rule);
	}
	else if (strpos($alias_rule, '.htm'))
	{
		$alias_rule = str_replace(array('.html', '.htm'), '.([a-zA-Z]+)', $alias_rule);
	}

	// збрасуем начало поиска переменных в $alias_rule(правиле псевдонима) на ноль
	$tagClose = 0;
	// инициализируем масив $ar_tags[] и первому елементу($ar_tags[0]) присваеваем $alias_rule
	$ar_tags[] = $alias_rule;
	$i = 0;
	// производим разбор $alias_rule(правила псевдонима)
	// получая 3 масив:
	// $ar_alias_mask[], $ar_alias_mask2[], елементами которых есль промежуточные стринговые значения меджу логическими переменными, такими как язык, имя папки, страницы
	// $ar_alias_mask2[] отличается от $ar_alias_mask[], тем что не первое не содержит промежуточного стринговоно значения после имени папки;
	// и масив $ar_tags[], последующим елементам которого присваюются именна переменных, используемых в $alias_rule.

	while (($tagOpen = strpos($alias_rule, '<%:', $tagClose)) !== false)
	{
		$ar_alias_mask[] = str_replace(array('/','.'),array('\/','\.'),substr($alias_rule, $tagClose ? $tagClose+2 : 0, $tagOpen-($tagClose ? $tagClose+2 : 0)));

		if ($ar_tags[$i] != 'page_folder')
		{
			$ar_alias_mask2[] = str_replace(array('/','.'),array('\/','\.'),substr($alias_rule, $tagClose ? $tagClose+2 : 0, $tagOpen-($tagClose ? $tagClose+2 : 0)));
		}

		$tagClose = strpos($alias_rule, '%>', $tagOpen);
		$ar_tags[$i+1] = $tag = substr($alias_rule, $tagOpen + 3, $tagClose - $tagOpen - 3);

		if (isset($specific_rules) && !empty($specific_rules) && isset($specific_rules[$tag])) // If we have predefenid regexp - use it
		{
			$ar_alias_mask[] = $specific_rules[$tag];

			if ($ar_tags[$i] != 'page_folder')
			{
				$ar_alias_mask2[] = $specific_rules[$tag];
			}
		}
		else
		{
			$ar_alias_mask[] = $reg;

			if ($ar_tags[$i] != 'page_folder')
			{
				$ar_alias_mask2[] = $reg;
			}
		}

		$i++;
	}

	$ar_tags[] = 'page_type';

	$ar_alias_mask[] = '\.'.substr($alias_rule, $tagClose ? $tagClose+3 : 0);
	$ar_alias_mask2[] = '\.'.substr($alias_rule, $tagClose ? $tagClose+3 : 0);

	// генерим регулярные выражения для url-строки с именем папки ($alias_mask), и без имени папки ($alias_mask2),
	// на основе полученых данных из $ar_alias_mask[] и $ar_alias_mask2[]
	$alias_mask = '/^'.implode('', $ar_alias_mask).'$/i';
	$alias_mask2 = '/^'.implode('', $ar_alias_mask2).'$/i';
	//vdump($alias_mask, '$alias_mask');
	//vdump($alias_mask2, '$alias_mask2');
	//vdump($alias_rule);
	//vdump($alias);
	// если url-строка совпадает с первым рег. выраж.($alias_mask) то ...
	// (здесь и должен словится url для обьектов, если он совпал с регулярным выражением)
	if ($res = preg_match($alias_mask, $alias, $ar_regs))
	{
		for ($i=1; $i<count($ar_regs); $i++)
		{
			// инициализация глобальных переменных
			// имена которых получены из $alias_rule,
			// а значения из текущего url (такие как язык, имя папки или файла)
			$var = $ar_tags[$i];
			global $$var;
			$$var = urldecode($ar_regs[$i]);
		}
	}
	// если url-строка совпадает со вторым рег. выраж.($alias_mask2) то ...
	elseif ($res = preg_match($alias_mask2, $alias, $ar_regs))
	{
		// инициализация всех глобальных кроме 'page_folder' переменных
		// имена которых получены из $alias_rule кроме,
		// а значения из текущего url (такие как язык, имя папки или файла)
		$ar_tags_tmp = array();
		foreach($ar_tags as $k=>$v)
		{
		  	if ($v != 'page_folder')
			{
		  		$ar_tags_tmp[] = $v;
			}
		}

		$ar_tags = $ar_tags_tmp;
		for ($i=1; $i<count($ar_regs); $i++)
		{
			$var = $ar_tags[$i];
			global $$var;
			$$var = urldecode($ar_regs[$i]);
		}
	}

	/*
	** Checking 'language' if in  [hттp://hostname/language/folder/page.html]
	** 'language' something else, not [EN|FR|NL etc].
	*/

	$check_language = getField('SELECT language_code FROM v_language where language_url ='.sqlValue(is($language)));

	if (!$check_language)
	{
		$language = $default_language;
		return false;
	}
	else
	{
		$language = $check_language;
	}

	// если не указана страничка и она была заменена "пустышкой", то...
	if (is($page_name) == '__page_name_replacement__')
	{
		// ищем дефаулт страницу в жаной папке. если такой нет то берем любую страницу в данной папке
		if (is_null($page_folder))
		{
			$sql_page_folder = ' IS NULL ';
		}
		else
		{
			$sql_page_folder = ' =' . sqlValue($page_folder);
		}

		$sql = '

                 SELECT
                        page_name 

                   FROM 
                        v_tpl_page_content
              LEFT JOIN v_tpl_path_content
                     ON v_tpl_page_content.folder_id = v_tpl_path_content.id

                  WHERE folder '.$sql_page_folder.' 
                    AND v_tpl_page_content.language = '.sqlValue($language).' 

                  ORDER
                     BY default_page DESC,
                        page_name ASC

                  LIMIT
                        0,1
                ';

		if ($page_name = getField($sql))
		{
			header('Location: '.get_href($page_folder.'/'.$page_name), true, 301);
			exit;
		}
		else
		{
			unset($page_name);
		}
	}

	$res_tpl = $res_obj = false;
	// если сравнение по рег. выраж. прошло успешно, то ...
	if ($res)
	{
		// SQL- запрос для проверки наличие взятой из url комбинации папка/файл в БД
		// select folder_id for folder name by language in content table
		// folder_id usually one only
		$folder_id = getField('
                 SELECT
                        var_id
                   FROM
                        content
                  WHERE
                        (
                         language = '.sqlValue($language).'
                         OR
                         language = '.sqlValue($default_language).'
                        )
                    AND var = \'folder_path_\'
                    AND val '.sqlValueWhere(is($page_folder)).'

                  LIMIT
                        0,1
                ');

		if (!empty($page_folder) && is_null($folder_id)) {
			$folder_id = '';
		}

		$sql_folder_id = sqlValueWhere(is($folder_id));

		// page_id may more than one...
		$page_id_sql = '

                SELECT
                       var_id
                  FROM
                       content
            INNER JOIN tpl_pages
                    ON content.var_id=tpl_pages.id

                 WHERE
                       (
                        content.language = '.sqlValue($language).'
                        OR
                        content.language = '.sqlValue($default_language).'
                       )
                   AND content.var = \'page_name_\'
                   AND content.val '.sqlValueWhere(is($page_name)).'
                   AND tpl_pages.tpl_id IS NOT NULL
		';


		$page_id_res = viewSQL($page_id_sql);
		$page_info_array = array();
		//
		if (db_sql_num_rows($page_id_res) > 0)
		{
			while ($row = db_sql_fetch_array($page_id_res))
			{
				$page_id_array[] = $row[0];
			}

			foreach ($page_id_array as $simple_page_id)
			{
				$sql_get_tpl = 'SELECT id, type FROM v_tpl_non_folder WHERE id='.sqlValue($simple_page_id).' AND folder_id '.$sql_folder_id;

				$r = viewSQL($sql_get_tpl, 0);

				if (db_sql_num_rows($r))
				{
					$row = db_sql_fetch_assoc($r);

					$page_info_array[$row['type']] = $row['id'];
					
					$res_tpl = true;
				}
			}
		}
		//
		if (!$res_tpl)
		{
			$f_id = getField('SELECT id FROM tpl_pages WHERE page_name ='.sqlValue($page_folder).' AND tpl_id IS NULL LIMIT 0,1');

			$s = 'SELECT 
					* 
				FROM 
					tpl_pages 
			       WHERE 
					page_name='.sqlValue($page_name).'
					AND
					folder_id' . ( is_null($f_id) && is_null($page_folder) ? ' IS NULL' : '='.sqlValue($f_id));

			$r = viewSQL($s);

			if (db_sql_num_rows($r)>0)
			{
				$res_tpl = true;
			}
		}
		//
		if ($res_tpl)
		{
			// если такая комбинация существует в БД, то определяем тип докуменка
			if (is_media_type($page_type))
			{
				$t_type = 1;
				$p_id = $page_info_array[1];
			}
			else
			{
				$t_type = 0;
				$p_id = $page_info_array[0];
			}

			if ($t_type == 1)
			{
				$picture_vars = media_manage_vars('media_'.$p_id);

				if (	!isset($picture_vars['images'][$language])
					||
					($picture_vars['images'][$language] == '')
				)
				{
					$picture_vars['images'][$language] = $picture_vars['images'][$default_language];
				}

				$image_name = $picture_vars['images'][$language];
				$ext = substr($image_name, strrpos($image_name,'.')+1);

				if ($ext != $page_type)
				{
					$res_tpl = false;
				}
			}
			// если тип не определен и не равен 'html' либо 'htm', то возвращаем false
			else if (!is_page_type($page_type))
			{
				$res_tpl = false;
			}
		}

		// Если проверка на совпадение url с сателитной страницей не прошла,
		// то проверим совпадение для обьекта
		if (!$res_tpl)
		{
			$res_obj = true;

			// Проверяем совпадение $object_folder, для идентификации url как действительно для обьекта
			if (!(isset($object_folder) && ($object_folder == config_var('object_folder', strtoupper($language)))))
			{
				$res_obj = false;
			}
			// SQL- запрос для проверки наличие в БД информации об обьекте взятой из url
			if (($res_obj == true) && isset($object_name) && isset($object_id) && isset($object_view))
			{
				$res_obj = is_object_in_db($object_id, $object_view);
			}
		}

	}

	//>>>>>>>>>>>>>>>>>> 0011516 >>>>>>>>>>>>>>>>
	if (is($t_view) && ($res_tpl || $res_obj))
	{
		$template_name = ($object_view ? $object_view : getField('SELECT tf.file_name FROM tpl_pages t LEFT JOIN tpl_files tf ON t.tpl_id = tf.id WHERE t.id='.sqlValue($page_info_array[0])));
		// $t_view -> view_folder_name
		if (check_accessible_template_view($template_name, $t_view) === false)
		{
			header('HTTP/1.1 301 Moved Permanently');
			header('Location: '.($object_view ? EE_HTTP.get_default_alias(Get_object_record_id_by_unique_name($object_id), $object_view, '', '', '') : get_href($page_info_array[0])), 301);
			exit;
		}
	}
	//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	// Если проверка коректности url прошла успешно либо для сателитных страниц, либо для обьектов,
	// то возвращаем соответствующий позитивный результат
	$res = ( $res_tpl ? $res_tpl : $res_obj );
	return $res;
}

/**
 * This function check if indicated object really saved in DB.
 * (проверим существует ли такой обьект вообще)
 * @param int $object_id ID of object
 * @return bool
 */
function is_object_in_db($object_record_id, $object_template_name)
{
	$res_obj = true;
	// проверим наличие записи с нужным id

	$sql_get_obj = 'SELECT
				ot.id
			 FROM
				object_template ot
		    LEFT JOIN
				object_record o
			   ON
				o.object_id = ot.object_id
		    LEFT JOIN
				tpl_files t
			   ON
				t.id = ot.template_id
			WHERE
				o.id = '.sqlValue(Get_object_record_id_by_unique_name($object_record_id)).'
			  AND
				t.file_name='.sqlValue($object_template_name);

	// проверяем наличие записи
	$r = viewSQL($sql_get_obj,0);
	// если нет, то возвращаем false
	if (db_sql_num_rows($r)==0)
	{
		// значит нет в обьекте записи с таким id
		$res_obj = false;
	}
	return $res_obj;
}

/**
 * parse_sql_to_html() - insert result of SQL-query into html-templates
 *
 * Syntax: parse_sql_to_html( $SQL_query, $html_template_row [, $current_page, $rows_on_page, $tpl_navigation ] )
 *
 *
 * Description:
 *
 *	Function parse_sql_to_html() execute SQL-query $SQL_query and for each one row make a variables with name of fields of SQL-result table.
 *	It variables posible to use in html-template $html_template_row which called for each one row.
 *	Variables $current_page, $rows_on_page, $tpl_navigation is used in case when very match rows and better to show it not all at time but to show by parts.
 *	$current_page defined number of current page. $rows_on_page defined max number of rows on pages. $tpl_navigation defined html-template for navigation.
 *
 *	Attention: In SQL-query, and other text-values need to process next chars: "'" and "," like that "\'" and "\,".
 *
 *
 * Examples of use in templates:
 *
 *	<!--Write in main template-->
 *
 *		<%parse_sql_to_html:SELECT id\, name FROM table
 *				   ,rowtemplate%>
 *
 *
 *	<!--Write in template with name "rowtemplate.tpl"-->
 *		<%row%
 *			<!--This part will be repeated row each one row-->
 *			<%:id%> - <%:name%>
 *		%row%>
 *
 *		<%row_empty%
 *			<!--This part will be colled in case if SQL-query return empty result-->
 *			"Empty result!"
 *		%row_empty%>
 *
 *
 */

function parse_sql_to_html($sql, $tpl, $current_page=null, $rows_on_page=null, $tpl_navigation=null)
{
	$sql_res = viewsql($sql, 0);

	$html = '';

	if ($sql_res)
	{
		$html = parse_sqlres_to_html($sql_res, $tpl, $current_page, $rows_on_page, $tpl_navigation);
		db_sql_free_result($sql_res);
	}

	return $html;
}

function parse_sqlres_to_html($sql_res, $tpl, $current_page=null, $rows_on_page=null, $tpl_navigation=null)
{
	$arr = SQLRes2Array($sql_res);

	if (array_key_exists('row', $arr))
	{
		$arr_row = $arr['row'];
	}
	else
	{
		$arr_row = array();
	}

	return parse_array_to_html($arr_row, $tpl, $current_page, $rows_on_page, $tpl_navigation);
}


/**
 * parse_array_to_html() - insert array into html-templates
 *
 * Syntax: parse_array_to_html( $array, $html_template_row [, $current_page, $rows_on_page, $tpl_navigation ] )
 *
 *
 * Description:
 *
 * 	Function parse_array_to_html() for each one row of array make a variables with name of key of fields of this array.
 *	It variables posible to use in html-template $html_template_row which called for each one row.
 *	Variables $current_page, $rows_on_page, $tpl_navigation is used in case when very match rows and better to show it not all at time but to show by parts.
 *	$current_page defined number of current page. $rows_on_page defined max number of rows on pages. $tpl_navigation defined html-template for navigation.
 *
 *	This function can't be called from html-templates.
 *
 * Old description:
 *
 *	если постраничные выборки организованы на уровне SQL -
 *	навигацию рисовать отдельно
 */
function parse_array_to_html($arr, $tpl, $current_page=null, $rows_on_page=null, $tpl_navigation='templates/navigation/default', $pages_in_block=10, $page_id=null)
{
	global $ignore_admin, $admin;
	// because extension is not used in include() function
	$tpl.= '.tpl';

	// если в имени tpl-ки нет каталогов и т.д.
	//  - значит это просто имя файла, добавляем каталог
	if (strpos($tpl, '/')===false)
	{
		$tpl = 'templates/'.$tpl;
	}

	if (strpos($tpl, EE_PATH) === false)
	{
		$tpl = ($admin and $ignore_admin!==1) ? EE_ADMIN_PATH.$tpl : EE_PATH.$tpl;
	}

	$tpl = get_custom_or_core_file_name($tpl);

	// иначе - что передали, то и открываем
	$tpl_text = file_get_contents($tpl);

	$teg_row_start = '<%row%';
	$teg_row_end = '%row%>';

	// если в файле нет начала блока - парсим файл целиком
	// в надежде найти его после парсинга (вдруг там include)
	if (strpos($tpl_text, $teg_row_start)===false)
	{
		$tpl_text = parse2($tpl_text);
	}

	$teg_row_empty_start = '<%row_empty%';
	$teg_row_empty_end = '%row_empty%>';
	$pos_row_empty_start = strpos($tpl_text, $teg_row_empty_start);
	$pos_row_empty_end = strpos($tpl_text, $teg_row_empty_end);
	$tpl_text_row_empty = '';

	if ($pos_row_empty_start !== false and $pos_row_empty_end !== false)
	{
		$tpl_text_row_empty = substr($tpl_text, $pos_row_empty_start+strlen($teg_row_empty_start), $pos_row_empty_end-$pos_row_empty_start-strlen($teg_row_empty_end));
		$tpl_text = str_replace($teg_row_empty_start.$tpl_text_row_empty.$teg_row_empty_end, '', $tpl_text);
	}

	$pos_row_start = strpos($tpl_text, $teg_row_start);
	$pos_row_end = strpos($tpl_text, $teg_row_end);
	$tpl_text_header = substr($tpl_text, 0, $pos_row_start);
	$tpl_text_row = substr($tpl_text, $pos_row_start+strlen($teg_row_start), $pos_row_end-$pos_row_start-strlen($teg_row_end));
	$tpl_text_footer = substr($tpl_text, $pos_row_end+strlen($teg_row_end));

	$s='';

	if (count($arr)==0)
	{
		return parse2($tpl_text_header.$tpl_text_row_empty.$tpl_text_footer);
	}

	if (	!is_array($arr)
		||
		!array_key_exists(0, $arr)
		||
		!is_array($arr[0])
	)
	{
		$tmp = array(); $tmp = $arr;
		$arr = array(); $arr[0] = $tmp;
	}

	//- global $rows_total;
    // parse2($tpl_text_header).$s.parse2($tpl_text_footer)
	$rows_total = count($arr);

	if ($rows_on_page == null)
	{
		$rows_on_page = getValueOf('MAX_ROWS_IN_ADMIN');
	}

	$row_start = ($current_page == null ? 0 : $rows_on_page * ($current_page - 1));
	$row_end = ($current_page == null ? $rows_total : min($rows_on_page * $current_page, $rows_total) );

	global $row_num;
	for ($i=$row_start; $i<$row_end; $i++)
	{
		if (is_array($arr[$i]) and count($arr[$i]))
		{
			foreach ($arr[$i] as $key=>$val)
			{
				global $$key;
				$$key = $val;
			}
		}
		else
		{
			$tpl_text_row = $tpl_text_row_empty;
		}

		$row_num = $i+1;
		$s.= parse2($tpl_text_row);
	}

	if ($tpl_text_header || $tpl_text_footer)
	{
		$s = parse2($tpl_text_header).$s.parse2($tpl_text_footer);
	}

	if ($current_page != null)
	{
		$s.= navigation($rows_total, $rows_on_page, $current_page, $tpl_navigation, $pages_in_block, $page_id);
	}

	return $s;
}

//
function parse_array_name_to_html($arr_name, $tpl, $current_page=null, $rows_on_page=null, $tpl_navigation=null, $clear_array = false)
{
	global $$arr_name;

	$arr = $$arr_name;

	if (!is_array($arr))
	{
		$arr = array();
	}

	foreach ($arr as $k=>$v)
	{
		$arr[$k]['ar_key'] = $k;
	}

	$arr = renumber_array($arr);

	$ret_val = parse_array_to_html($arr, $tpl, $current_page, $rows_on_page, $tpl_navigation);

	if ($clear_array)
	{
		$$arr_name = null;
	}

	return $ret_val;
}

function parse_array_function_to_html($func_name, $tpl, $current_page=null, $rows_on_page=null, $tpl_navigation=null)
{
	$arr = $func_name();
	if (!is_array($arr)) $arr = array();
	foreach ($arr as $k=>$v) $arr[$k]['ar_key'] = $k;
	$arr = renumber_array($arr);
	return parse_array_to_html($arr, $tpl, $current_page, $rows_on_page, $tpl_navigation);
}

function parse_string_to_array_html($str, $tpl, $separator=" ")
{
	$arr=explode($separator,$str);
	$result = array();
	foreach ($arr as $k=>$v) {
		$result[$k]["ar_index"] = $k;
		$result[$k]["ar_value"] = $v;
	}
	return parse_array_to_html($result,$tpl);
}
function parse_enum_to_html($enum_table, $enum_field, $enum_tpl, $enum_value = 0)
{
	$enum_list = db_sql_show_enum_params($enum_table, $enum_field);
	foreach ($enum_list as $k=>$v)
	{
		$enum_lst[$k]['enums'] = $v;
		$enum_lst[$k]['id'] = $k+1;
		if (($enum_value == $k+1) or ($enum_value == $v))
			$enum_lst[$k]['selected'] = 'selected';
		else
			$enum_lst[$k]['selected'] = '';
	}
	return parse_array_to_html($enum_lst, $enum_tpl);
}

function set_content_type($type)
{
	$type = strtolower($type);

	global $content_type;

	$search_array = unserialize(EE_FILE_TYPES);
	$search_array = array_merge($search_array['media'], $search_array['page']);

	if (isset($search_array[$type]))
	{
		$type_str = $search_array[$type];
	}

	if (!empty($type_str))
	{
		$content_type = $type_str;
	} else {
		$content_type = 'text/html';
	}
}


function replace_amps($str)
{
	//если URL медии /m&s.jpg то на выходе мы получим /m&amp;s.jpg
	//поэтому если замену и надо производить, по после знака ?
	//кстати чтобы обойти это правиль можно использовать одинарные кавычки
	$numlinks = preg_match_all("/<[^<>]+?(href|src)=\"[^\?]*?(\?[^\"]*?)?\"[^<>]*?>/si",$str,$links,PREG_PATTERN_ORDER);

	$newlinks = array();
	$strings = $links[2];
	$out_str = $str;
	for($i = 0; $i < $numlinks; $i++)
	{
		$out = str_replace('&','&amp;',$strings[$i]);
		$out = str_replace('&amp;amp;','&amp;',$out);
		$out_str = str_replace($strings[$i], $out, $out_str);
	}
	$out_str = str_replace(' & ', ' &amp; ', $out_str);
	return $out_str;
}

// parse csv-fle row by row and return it as array
function parse_csv_file($csv_file_name, $delimiter = ",", $enclosure = '"', $length = 102400)
{
	$ar_rows = array();

	$handle = fopen($csv_file_name, "r");

	while (($data = fgetcsv($handle, $length, $delimiter, $enclosure)) !== false)
	{
		//PHP-doc: A blank line in a CSV file will be returned as an array comprising a single null field,
		//         and will not be treated as an error.
		if ($data == array(''))
		{
			// So let we skip empty rows by own hands
			continue;
		}
		$ar_rows[] = $data;
	}

	fclose($handle);

	return $ar_rows;
}

function is_media_type($type)
{
	$type = strtolower($type);

	$ret = false;

	$ee_files_type	= unserialize(EE_FILE_TYPES);

	if (isset($ee_files_type['media']) && array_key_exists($type, $ee_files_type['media']))
	{
		$ret = true;
	}

	return $ret;
}

function is_page_type($type)
{
	$type = strtolower($type);

	$ret = false;

	$ee_files_type	= unserialize(EE_FILE_TYPES);

	if (isset($ee_files_type['page']) && array_key_exists($type, $ee_files_type['page']))
	{
		$ret = true;
	}

	return $ret;
}

?>