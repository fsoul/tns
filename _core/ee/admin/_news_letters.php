<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 650;
	$add_popup_height = 275;
	$popup_width = 800;
	$popup_scroll = '1';
	$config_vars = array(
				array('field_name'=>'SMTP_host'),
				array('field_name'=>'default_active_period'),
				array('field_name'=>'mail_character_set'));

	if (!defined('ADMIN_MENU_ITEM_NEWS_LETTERS')) define('ADMIN_MENU_ITEM_NEWS_LETTERS', 'Mailing/Newsletters');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_NEWS_LETTERS);

	if ($op === 'preview_attachment')
	{
		list($fname, $content) = db_sql_fetch_row(ViewSQL('SELECT file_name, file_content FROM nl_attachments WHERE id='.sqlValue($_GET['at_id']),0));
		if (!empty($content))
		{
			header('Content-Type: application/octet-stream');
			header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
			header('Content-disposition: attachment; filename="'.$fname.'"');
			echo $content;
			exit;
		}
	}
	if ($op === 'delete_attachment')
	{
		nl_del_attachment($_GET['at_id']);
		$op = '1';
		$admin_template='yes';
//		header('Location: '.$modul.'.php?op=1&admin_template=yes&edit='.$edit);
//		exit;
	}

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихся от установленных по-умолчанию
	//
	// только список (grid)
	//скрыть столбец
 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра
	// выравнивание
	$align['id']='right';
	//цвет
	$ar_grid_links['status']='<span style="color:red; margin-left:18px">%5$s</span>';
	// стиль столбца
	// оформление самого значения в гриде
	$ar_grid_links['subject'] = '<%%cms:news_letter_subject_%'.(array_search('id',$fields)+1).'$s%%>';
	// стиль строки поля формы
	// размер поля
	// доступно только для чтения
	// обязательны для заполнения
	$mandatory = array('from_name', 'subject', 'from_email');
	// тип поля ввода

	$caption['finish_date'] = 'Finish Date';

///////////////////
	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

///////////////////
	if (empty($srt)) $srt='';
///////////////////
	$ar_usl[] = 'srt='.$srt;

///////////////////
	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
	function print_list($export='')
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


	// список полей в окне редактирования
	function print_fields()
	{
		return include('print_fields.php');
	}


	function edit() {
		global $modul, $edit, $error, $language, $added;

		if ($added)
		{
			echo '<script>
					parent.document.getElementById(\'admin_popup\').style.height=\'540px\';
					parent.document.getElementById(\'admin_popup\').style.top=\'20%\'
			      </script>';
		}
		if (!is_array($error) || post('refresh'))
		{
			$error=array();
		}
		$sql='SELECT * FROM v_nl_email WHERE email_id='.sqlValue($edit);
		$info=db_sql_fetch_assoc(viewsql($sql, 0));
		//vdump($info['body'], '$info[body]');
		if(post('refresh')) {
			foreach ($info as $var=>$val) {
				global $$var;
				$$var = $_POST[$var];
				//msg ($$var, $var);
			}
			reset($info);
			if($email_subject=='')
			$error['email_subject']='Subject must be not empty<br>';
		} else {
			foreach ($info as $var=>$val) {
				global $$var;
				$$var = $val;
			}
			reset($info);
		}
		if(post('refresh') or get('reload')=='yes') {
			if(count($error)==0)
                        {
				nl_email_edit (
				$email_id,
				$email_from_name,
				$email_from_email,
				'',//$email_subject
				$email_tpl,
				'',//$email_body
				$email_header,
				$finish_date
				);

				if (post('upload') && !empty($_FILES['add_attachment']))
				{
					$new_at_id = nl_add_attachment($email_id, basename($_FILES['add_attachment']['name']), $_FILES['add_attachment']['tmp_name']);
					header('Location: '.$modul.'.php?op=1&admin_template=yes&edit='.$edit);
					exit;
				}
			}
			close_popup('yes');
		}
		return parse_tpl($modul.'/edit');
	}
	
	function add() {
		global $modul, $error;
		$error=array();
		$sql = 'show columns from v_nl_email';
		$rs = viewsql($sql, 0);
		while ($sql_res = db_sql_fetch_assoc($rs))
		{
                  	$field_name = $sql_res['Field'];
                	global $$field_name;
			if(post('refresh'))
				$$field_name=post($field_name);
			else
				$$field_name = '';
		}
		if(post('refresh')) {
			if(empty($email_from_name)) $error['email_from_name'] = 'From Name field must be not empty<br>';
			if(empty($email_from_email)) $error['email_from_email'] = 'From Email field must be not empty<br>';
			if(!preg_match('|^[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]{2,6}$|i', $email_from_email)) $error['email_from_email'] = 'From email is not correct<br>';
			if(empty($email_subject)) $error['email_subject'] = 'Subject must be not empty<br>';
			if(count($error)==0) {
				$res = nl_email_add (
					$email_from_name,
					$email_from_email,
					'',//$email_subject
					$email_tpl,
					'',//$email_body
					$email_header,
					$finish_date,
					USER_IP,
					date(DATETIME_FORMAT_PHP)
					);
				save_cms('news_letter_subject_'.$res, $email_subject);
				header('Location: '.$modul.'.php?op=1&edit='.$res.'&load_cookie=true&admin_template=yes&added='.$res);
				exit;
			}
		}
		return parse_tpl($modul.'/edit');
	}

	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $edit;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);
		if (!empty($edit))
		{
			return edit();
		}
		else
		{
			return add();
		}
	}

	function del() {
		global $del;
		global $modul;
		nl_email_delete($del);
		header('Location: '.$modul.'.php?load_cookie=true');
	}

	function send_letters() {
		global $modul, $language;
		$sql = 'SELECT language_code FROM language WHERE status=1 AND language_code<>""';
		$langs_res = viewSql($sql);
		if(db_sql_num_rows($langs_res)>0)
		{
			while($row = db_sql_fetch_assoc($langs_res))
			{
				$language = $row['language_code'];
				foreach($_POST['group_ids'] as $group_id)
				{
					nl_email_group_send($_GET['edit'], $group_id);
				}
			}
		}
		close_popup('yes');
	}

	function send_test_letter() {
		global $b_color, $modul, $edit, $ftpServer, $httpServer, $httpPrefix, $imgPath;
		global $pageTitle, $PageName, $error;
		global $modul, $language;

		$error = array();
		$sql='select * from v_nl_email where email_id='.$edit;
		$info=db_sql_fetch_assoc(viewsql($sql, 0));
		$email_subject = get_email_param('subject', $edit, array($language));
		$email_subject = (!empty($email_subject) ? $email_subject : $info["email_subject"] );
		$email_body = get_email_param('body', $edit, array($language));         
		$ins_id_mail = ms_test_mail_add($edit);
		$ins_id_rcp = ms_test_recipient_add($_POST["email_test"], $ins_id_mail,3);
		$res = send_letter($ins_id_rcp);
		if ($res !== true)
		{
			$error['email_test'] = "The letter was not sent. ".$res;
		}
		else
		{
			$error['email_test_succ'] = "The letter was successfully sent.";
		}
		return save();
	}

	function parse_client ($tpl) {
		global $ignore_admin;
		$ignore_admin = 1;
		$res = parse($tpl);
		$ignore_admin = 0;
		unset($ignore_admin);
		return $res;
	}

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'nl_email_add',
				'ms_recipient_add',
				'send_letter',
				'mail'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v_nl_email',
				'nl_subscriber',
				'ms_status',
				'ms_mail'),
			'db_funcs'  => array (),
			'config_vars' => $GLOBALS['config_vars'],
			'send_mail' => array()
		);

		return parse_self_test($ar_self_check);
	}

	function edit_config()
	{
		global  $size;
		$size = '';
		return include('print_edit_config.php');
	}

	include ('rows_on_page.php');

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
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		//		case '4': echo view();break;
		case '5': send_letters();break;
		case '6': echo send_test_letter();break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'config': echo edit_config(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>
