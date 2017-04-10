<?
	$modul = basename(__FILE__, '.php');
//********************************************************************
	$admin_template = 'yes';
	
	include_once('../lib.php');

	$modul_title = 'Form builder';

	include('url_if_back.php');

	$popup_height = 260;

	check_modul_rights(array(ADMINISTRATOR, POWERUSER), 'Administration/'.str_to_title($modul));

	unset($sql);

	include('object_inits.php');

	$hidden = array('form_config', 'language');
	
	$align['content']='center';
	
	$size_filter['record_id'] = 15;
	$size_filter['content'] = 15;
	$size_filter['form_config'] = 15;

	$caption['content'] = 'Form';
	
	$ar_grid_links['content'] = '<a href="javascript:openPopup(\''.$modul.'.php?op=preview&edit=%'.(array_search('record_id',$fields)+1).'$s%\&admin_template=yes\',900,700,1)"><img src="'.EE_HTTP.'img/menu/mailing.gif" alt="Show" align="top" border="0" height="16" width="16"></a>';

	$mandatory = array('form_name');

	$type['record_id'] = "string";
	$type['form_name'] = "text";
	$type['form_config'] = "string";
	$type['content'] = "string";
	$type['language'] = "string";

	load_stored_values($modul);
	
	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;
	
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
		return object_print_list($export);
	}

	// список полей в окне редактирования
	function print_fields()
	{
		global $serialized;
		$serialized = get_form_attr(0, 0);

		return include('print_fields.php');
	}
	
	//редактирование записи
	function edit()
	{
		global $object_id, $modul, $language;
		
		if(!empty($_POST['ids']))
		{
			//finds ids of fields
			$ids = unserialize($_POST['ids']);
			$content = array();
			//get config fields related to current field
			for($i=0; $i<sizeof($ids); $i++)
			{
				$content[$i]['id'] = $ids[$i];
				foreach($_POST as $key => $value)
				{
					if(preg_match("/(.*)?(".$ids[$i].")+$/", $key, $matches))
					{
						$content[$i][$matches[1]] = $value;
					}
				}
			}
			//print_r($content);exit;
			//сохраняем информацию в БД
			$db_fields['record_id'] = htmlspecialchars(trim($_POST['fb_form_id']), ENT_QUOTES);
			$db_fields['form_name'] = htmlspecialchars(trim($_POST['fb_form_name']), ENT_QUOTES);
			
			$db_fields['form_config'] = serialize(array(
				'fb_send_to_email' => $_POST['fb_send_to_email'],
				'fb_dest_email' => $_POST['fb_dest_email'],
				'fb_from_email' => $_POST['fb_from_email'],
				'fb_email_charset' => $_POST['fb_email_charset'],
				'fb_send_to_user' => $_POST['fb_send_to_user'],
				'fb_store_in_db' => $_POST['fb_store_in_db'],
				'fb_thanks_page' => $_POST['satelit'],
				//'fb_form_method' => $_POST['fb_form_method'],
				'fb_for_registered' => $_POST['fb_for_registered'],
				'fb_for_registered_message_type' => $_POST['fb_for_registered_message_type'],
				'fb_for_registered_template' => $_POST['fb_for_registered_template'],
				'fb_submit_once_message_type' => $_POST['fb_submit_once_message_type'],
				'fb_submit_once_template' => $_POST['fb_submit_once_template'],
				'fb_submit_once' => $_POST['fb_submit_once'],
				'fb_form_action' => $_POST['fb_form_action']
			));
			//print_r($content);exit;
			$db_fields['content'] = serialize($content);
			$db_fields['language'] = $language;
			$insert_id = f_upd_object_modul($db_fields, Get_object_id_by_name('formbuilder'));
			
			if(isset($_POST['save_and_continue']))
			{
				header('Location: '.$_SERVER['HTTP_REFERER']);
			}
			else
			{
				header('Location: '.$modul.'.php');
			}
			exit;
			//return object_save($object_id);
		}
		else
		{//for resoring values
			//deviant
			/////$sql = create_sql_view_by_name('formbuilder');
			/////$sql = 'SELECT * FROM('.$sql.') AS formbuilder WHERE record_id='.sqlValue($id).' LIMIT 0,1';
			/////$rs = viewSql($sql);
			/////$res = db_sql_fetch_assoc($rs);
			//$form_config = unserialize($res['form_config']);
			/////global $content;
			////$content = unserialize($res['content']);
			echo parse($modul.'/formbuilder_edit');
		}
	}
	
	//добавление
	function add()
	{
		global $object_id, $modul, $language, $error;

		
		if (post('refresh'))
		{
			if(empty($_POST['form_name'])) $error['form_name'] = 'This filed is mandatory';
			if(count($error)==0)
			{
				//сохраняем информацию в БД
				$db_fields['record_id'] = '';
				$db_fields['form_name'] = htmlspecialchars(trim($_POST['form_name']), ENT_QUOTES);
				$db_fields['form_config'] = '';
				$db_fields['content'] = '';
				$db_fields['language'] = $language;
				$res = f_add_object_modul($db_fields, Get_object_id_by_name('formbuilder'));

				if (post('save_add_more'))
				{
					echo '<script type="text/javascript">window.parent.location="'.EE_HTTP.EE_ADMIN_SECTION.$modul.'.php?op=1&edit='.$res.'";</script>';
					exit;
				}
				else
				{
					close_popup('yes');
				}
			}
		}
		echo parse_popup($modul.'/add_form');
	}
	
	function copy_formbuilder_form()
	{
		handle_copy_formbuilder_form();
		echo parse($modul.'/list');
	}

	// удаление
	function del()
	{
		return object_del();
	}
	
	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (),
			'php_ini' => array (),
			'constants' => array (),
			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}
	
	include ('rows_on_page.php');

	function get_modul_list($modul)
	{
		return get_object_yui_list($modul);
	}
	function print_yui_captions($full='no')
	{
		return include('print_yui_captions.php');
	}
	
//********************************************************************
	switch($op)
	{
		default:
		case '0': echo parse_tpl($modul.'/list'); break;
		case '1': echo edit();break;//edit
		case '2': del();break;
		case '3': echo add();break;//add
		case 'del_sel_items': del_selected_items('object'); echo parse($modul.'/list'); break;
		case 'preview': echo parse_tpl($modul.'/preview_form');break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'copy_form': copy_formbuilder_form(); break;
		case 'export_2_xml': handle_export_2_xml(); break;
		case 'xml_import': handle_xml_import();break;
		
		case 'export_form_to_csv':
			header('Content-Type: application/vnd.ms-excel');
			$form_name = media_to_file_name(urldecode($form_name));
			header('Content-Disposition: attachment; filename="'.$form_name.'.csv"');
			echo parse_tpl($modul.'/export_form_to_csv');
			break;

		case 'export_excel': header('Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
			echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows('object'); echo get_modul_list($modul); break;
	}
?>