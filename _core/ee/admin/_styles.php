<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//	$modul_title = 'page';
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	if (!defined('ADMIN_MENU_ITEM_STYLE')) define('ADMIN_MENU_ITEM_STYLE', 'Content/Styles');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_STYLE);
	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');
	
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)

	//скрыть столбец
	$hidden = array();
 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра

	// выравнивание
	$align['id']='right';

	$type_filter['sample_text']='empty';

	//отключить сортировку
	$sort_disabled = array('sample_text'); 

	// стиль столбца

	// оформление самого значения в гриде
	$ar_grid_links['sample_text']='<%'.(array_search('element',$fields)+1).'$s style="<%%:style_text%%>">Sample text</%'.(array_search('element',$fields)+1).'$s>';

	// только окно редактирования
	// Размеры окна редактирования
	$popup_width = 900;
	$popup_height = 470; 
	// стиль строки поля формы

	// размер поля


	// доступно только для чтения

	// обязательно для заполнения
	$mandatory=array('title');
	// тип поля ввода
	$form_row_style['id'] = "display:none;";
	$type['declaration'] = 'styles_list';
	
	$size['element'] = '30';
	$size['class'] = '30';
	$size['title'] = '30';

	$caption['title'] = 'FCKEditor style title';
	$caption['declaration'] = 'CSS declaration';

	$form_row_type['declaration'] = 'nocaption';

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
	function print_captions()
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
	function print_list()
	{
		global $style_text;
		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);

		if (ceil($tot/$MAX_ROWS_IN_ADMIN)<$page)
			$page=1;

		if ($MAX_ROWS_IN_ADMIN > 0)
			$sql.= ' limit '.(($page-1)*$MAX_ROWS_IN_ADMIN).','.$MAX_ROWS_IN_ADMIN;
		else
			$MAX_ROWS_IN_ADMIN = $tot;

		$rs = viewsql($sql, 0 );

		$s = '';
		$j=0;
		$rows = array();
		while($r=db_sql_fetch_row($rs))
		{
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				if ($fields[$i] == 'sample_text')
				{
					$style_text = '';
					foreach (unserialize($r[$i]) as $k=>$v)
					{
						$style_text .= ' '.$k.': '.$v.';';
					}
				}
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field');
			$rows[$j]['id'] = $r[0];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row');

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}


	// список полей в окне редактирования
	function print_fields()
	{
		//global $edit;
		$res = include('print_fields.php');
		//if (!empty($edit)) $res .= parse($modul.'/sample_text');
		return $res;
	}

	// добавление/сохранение записи
	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit, $edit_styles;
		global $elem_title, $class_title, $style_text;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');
		if (empty($declaration))  $declaration = $info['declaration'];
		if (!empty($edit))
		{
			$elem_title = $element;
			$class_title = $class;
			$style_text = '';
			foreach (unserialize($declaration) as $k=>$v)
			{
				$style_text .= ' '.$k.': '.trim($v).';
';	
			}
		}
		if (post('refresh'))
		{
			if (empty($element) && empty($class)) $error['element'] = 'Your must define either element or class name';
			if (count($error)==0)
			{
				if (empty($edit)) // New object
				{
					unset($field_values['id']);
					$db_function = 'f_add'.$modul;
				}
				else
				{
					$db_function = 'f_upd'.$modul;
				}
				$declaration = array();
				if (empty($element)) $field_values['element'] = 'span'; 
				foreach ($edit_styles as $style)
				{
					if (!empty($_POST[$style['name']])) 
					{
						$declaration[$style['name']] =  $_POST[$style['name']];
						if ($style['type']=='color') $declaration[$style['name']] = '#'.$declaration[$style['name']];
					}
				}
				vdump($_POST,'decl');
				$field_values['declaration'] = serialize($declaration);
				$res = RunNonSQLFunction($db_function, $field_values);

				if ($res < 0)
				{
					$error['element'] = 'Page already exists';
				}
				else
				{
					if (post('save_add_more')) 
					{
						header ('Location: '.$modul.'.php?op=3&added='.$res);
						exit;
					} else if (post('save_continue')) {
						header ('Location: '.$modul.'.php?op=1&edit='.$res);
						exit;
					} else
						close_popup('yes');
				}
			}
		}
		return parse($modul.'/edit_popup');
	}

	// удаление
	function del()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del'.$modul, array($del));

		header($url);
	}

	include ('rows_on_page.php');

	function print_edit_styles($current=array())
	{
		global $edit_styles;

		//Words that exists in style tag and value contain the size.
		$style_tags_check_mes = array('margin', 'padding', 'border', 'size');

		$current = unserialize($current);
		$style_values=array();
		$res = '';
		$cur_group = '';
		foreach ($edit_styles as $style)
		{
			$style_name = $style['name'];
//			if (!empty($cur_group) && $style['group'] != $cur_group) $res .= '</table></td></tr>';
			if (!empty($style['group']))
			{
				if ($style['group'] != $cur_group)
				{
//					if (!empty($cur_group)) $res .= '</table></td></tr>';
//					$res .= '<tr><td>+'.$style['group'].'</td><td></td></tr>';
//					$res .= '<tr><td colspan="2"><table id="'.$style['group'].'" cellspacing="0">';
					$res .= 'aux1 = insFld(foldersTree, gFld("'.$style['group'].'", "javascript:undefined")); '."\n";
				} else {
					
				}
				$style_name = str_replace($style['group'].'-','',$style['name']);
				$cur_group = $style['group'];
			} else {
//				if (!empty($cur_group)) $res .= '</table></td></tr>';
			}
			
			if ($style['type'] == 'select')
			{
				$val = '<select name="'.$style['name'].'">';
				$arr = array(array('option_value' => '', 'option_value_test' => $current[$style['name']], 'option_text' => ''));
				foreach ($style['values'] as $v)
				{
					$arr[] = array('option_value' => $v, 'option_value_test' => $current[$style['name']], 'option_text' => $v); 
				}
				$val .= parse_array_to_html($arr,'templates/option');
				$val .= '</select>';
			} else if ($style['type'] == 'color') {
				$val = '#<input  type="text" name="'.$style['name'].'" value="'.ltrim($current[$style['name']],'#').'" size="13">';
			} else {
				if (preg_match("/(".implode('|',$style_tags_check_mes).")/i", $style['name'])) 
				{
					$onchangeFunc = 'onkeyup = "checkSizeVal(this)"';
				} 
				else 
				{
					$onchangeFunc = '';
				}

				$val = '<input  type="text" name="'.$style['name'].'" '.$onchangeFunc.'  value="'.$current[$style['name']].'" size="15">';
			}
			if (!empty($style['group'])) $parent_node = 'aux1'; else $parent_node = 'foldersTree';
//			$res .= '<tr><td>'.$style_name.':</td><td>'.$val.'</td></tr>';
			$res .= 'insDoc('.$parent_node.', gLnk("S", \''.$style_name.' : '.$val.'\', "javascript:undefined")); '."\n";
		}
//		if (!empty($style['group'])) $res .= '</table></td></tr>';
		return $res;
	}
	
	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'f_add'.$modul,
				'f_upd'.$modul,
				'f_del'.$modul,
				'mysql_query'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit',
				'v_tpl_file',
				'v_tpl_folder'
			),
			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}
	function get_modul_list($modul)
	{
		return include('get_yui_list.php');
	}
	function print_yui_captions($full='no')
	{
		return include('print_yui_captions.php');
	}
//********************************************************************
	switch($op)
	{
		default:
		case '0': echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>
