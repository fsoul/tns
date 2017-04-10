<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');
//********************************************************************

	include('url_if_back.php');

	$popup_height = 400; 
	$popup_scroll = '1'; 

	if (!defined('ADMIN_MENU_ITEM_MAILING')) define('ADMIN_MENU_ITEM_MAILING', 'Mailing/Mailing tools/Mail Reports');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_MAILING);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// CUSTOMISATION	
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)

	//скрыть столбец
	//$hidden = array('id');
	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра
	//$type_filter['viewed'] = 'select_YN';
	// выравнивание
	$align['id']='right';
	//$align['subject']='right';
	// стиль столбца

	// оформление самого значения в гриде
	function getMailTitle($id)
	{
		global $language;
		$sql = 'SELECT IF(subject = "", (SELECT val FROM content WHERE page_id="0" AND var="news_letter_subject_" AND var_id=v_ms_mail.original_id AND language='.sqlValue($language).'), subject) AS subject FROM v_ms_mail WHERE id='.sqlValue($id);
		$field = getField($sql);
		$title_arr = unserialize($field);
		if(is_array($title_arr) && array_key_exists($language, $title_arr))
		{
			$val = $title_arr[$language];
		}
		else
		{
			$val = cms('news_letter_subject_'.$id);
		}
		return $val;
	}
	
	$ar_grid_links['subject'] = '<%%getMailTitle:%'.(array_search('original_id',$fields)+1).'$s%%>';
	//$ar_grid_links['id']='<a href="'.EE_ADMIN_URL.$modul.'?op=4&edit='.
	//'%'.(array_search('id',$fields)+1).'$s'.
	//'">'.
	//'%'.(array_search('id',$fields)+1).'$s'.
	//'</a>';

	//$ar_grid_links['subject'] = '<%%cut:<%%html_entity_decode:%'.(array_search('subject',$fields)+1).'$s%%>,50%%>';

	// только окно редактирования
	// стиль строки поля формы

	// размер поля


	// доступно только для чтения

	// обязательно для заполнения
	//$mandatory=array('page_name','is_default','template','search');
	// тип поля ввода
	//$type['id'] = "string";
	//$type['add_info'] = "message_body";

	//$caption['add_info'] = 'Message body';

	$hidden[] = 'original_id';
	// END OF CUSTOMISATION	

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
	function print_captions($export = '')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
	function print_list($export = '')
	{
		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);

		include('print_list_limit_sql.php');

		$rs = viewsql($sql, 0);

		$s = '';
		$j=0;
		$rows = array();
		while($r=db_sql_fetch_row($rs))
		{
			$row_field = array();
			$r[4] = str_replace(',','\\,',$r[4]);
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
			$rows[$j]['id'] = $r[0];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);
		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;

  	}


	function view_mail()
	{
		global $edit, $http, $b_color, $language;

		$sql = 'SELECT
					id,
					IF(subject = "", (SELECT val FROM content WHERE page_id="0" AND var="news_letter_subject_" AND var_id=v_ms_mail.original_id AND language='.sqlValue($language).'), subject) AS subject,
					date_reg,
					IF(body = "", (SELECT val FROM content WHERE page_id="0" AND var="news_letter_body_" AND var_id=v_ms_mail.original_id AND language='.sqlValue($language).'), body) AS body,
					status,
					recipients_count
				FROM v_ms_mail
				WHERE id='.sqlValue($edit);
		$info=db_sql_fetch_assoc(viewsql($sql, 0));
                $s='';
                $c=0;
		foreach ($info as $var=>$val) {
			switch($var) {
				case 'subject':
				case 'body':
					$uns_res = unserialize($val);
					if(is_array($uns_res) && array_key_exists($language, $uns_res))
					{
						$val = $uns_res[$language];
					}
					else
					{
						$val = cms('news_letter_subject_'.$edit);
					}
				break;
			}
			$s.= '
			<tr bgcolor="'.$b_color[$c=1-$c].'">
				<td height="30">&nbsp;&nbsp;<b>'.str_replace('_', ' ', case_title($var)).'</b></td>
				<td>'.$val.'</td>
				<td></td>
			</tr>
		';
		}

		$sql = 'select r.recipient, n.language, r.status, r.date_update as update_date from v_ms_recipient AS r, nl_subscriber AS n where r.recipient_id=n.id and ms_mail_id='.sqlValue($edit);
		$rs = viewsql($sql, 0);
		$s.= '
		<tr bgcolor="'.$b_color[$c=1-$c].'">
			<td>&nbsp;</td>
			<td>
			<table width="100%" cellspacing="0" cellpadding="3" border="0">
		';
		if (db_sql_num_rows($rs)) {
			$c=1-$c;
			$s.= '<tr bgcolor="'.$b_color[$c=1-$c].'">';
			for($i=0; $i<db_sql_num_fields($rs); $i++) {
				$s.= '
					<td height="30"><b>'.str_replace('_', ' ', case_title(db_sql_field_name($rs, $i))).'<b></td>
					<td>&nbsp;&nbsp;</td>
				';
			}
		}
		$s.='</tr>';
		while($r = db_sql_fetch_assoc($rs)) {
			$s.= '<tr bgcolor="'.$b_color[$c=1-$c].'">';
			foreach ($r as $var=>$val) {
				$s.= '
					<td height="30">'.$val.'</td>
					<td>&nbsp;&nbsp;</td>
				';
			}
			$s.='</tr>';
		}
		$s.='	</table>
			</td>
			<td>&nbsp;</td>
		';

		return $s;
	}


	function view () {
		global $modul, $pageTitle, $PageName;
		$pageTitle = $PageName = 'Mailing System - Mail details and list of recipients';
		return parse($modul.'/view');
	}

	// список полей в окне редактирования
	function print_fields()
	{
		return include('print_fields.php');
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'mysql_query',
				'get_message_body'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit'
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
        switch($op) {
                default:
                case '0': echo parse($modul.'/list');break;
		case '4': echo view();break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel'); break;
		case 'get_list' : echo get_modul_list($modul); break;
	}
?>