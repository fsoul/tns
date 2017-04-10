<?

	$modul = basename(__FILE__, '.php');

//	$modul_title = $modul;
	$modul_title = 'POLL List';
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');
	$popup_height	= 560; 
	$popup_scroll = true;

	global $characterSet;
	$characterSet="utf-8";

	if (!defined('ADMIN_MENU_SURVEY_QUESTION')) define('ADMIN_MENU_SURVEY_QUESTION', 'Resources/Surveys/Manage');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 

	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_SURVEY_QUESTION);

	$object_id = Get_object_id_by_name('question');

	// главный список полей
	// по нему работают все функции
	
        include('object_inits.php');

	// установка свойств по-умолчанию

	//скрыть столбец
	$hidden = array('text_instead_hidden_results');

	//caption of gallery object fields

        // тип поля ввода
	$type['record_id'] = "string";	//The type of field 'record_id' must be always!
	$type['active'] = "checkbox";
	$type['date'] = "string";
	$type['hide_results'] = "checkbox";

	// return JS language array
	function get_js_lang_arr()
	{
		$res = 'new Array(';

		$sql_res = viewSQL('SELECT language_code FROM v_language WHERE status=1', 0);
		while($lang_res = db_sql_fetch_assoc($sql_res))
		{
			$res .= '"'.$lang_res['language_code'].'",';
		}

		$res = substr($res, 0, -1).')';

		return $res;
	}

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// подписи к колонкам списка (grid-а)

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
		return include('print_fields.php');
	}
 

	function get_answers_edition($question_id)
	{
		$res = '';

		$lang_list = SQLField2Array(viewsql('SELECT language_code FROM v_language WHERE status=1', 0));

		if(!empty($question_id))
		{
			$answer_object_id = Get_object_id_by_name('answer');
			$lang_list = SQLField2Array(viewsql('SELECT language_code FROM v_language WHERE status=1', 0));
			$sql = 'SELECT *
				FROM ('.create_sql_view($answer_object_id, '', true).') answer
				WHERE  answer.question_id = '.sqlValue($question_id);

			$sql_res = viewSQL($sql, 0);
			global $current_answer_number; 
			$current_answer_number = 0;
        		while($answer_arr = db_sql_fetch_assoc($sql_res))
			{
				$current_answer_number++;
				$res .= '<div style="margin:5px; background-color:#E2E2FD;" id="answer_div_id_'.$current_answer_number.'">Answer:<br />';
				foreach($lang_list as $next_lang)
				{
					$res .= $next_lang.' <input type="text" name="answer_text_'.$next_lang.'[]" value="'.(isset($answer_arr['answer_'.$next_lang]) ? $answer_arr['answer_'.$next_lang] : '').'" /><br />';
				}
				$res .= '<span style="cursor:pointer; font-weight:bold;" onclick="document.getElementById(\'answer_div_id_'.$current_answer_number.'\').innerHTML=\'\'; document.getElementById(\'answer_div_id_'.$current_answer_number.'\').outerHTML=\'\';">[-]</span></div>';
			}
		}

		return $res;
	}


	function del_object_answers_by_question_id($question_id)
	{
		$answer_object_id = Get_object_id_by_name('answer');

		//Kill all old answers
		$sql = 'SELECT record_id
			FROM ('.create_sql_view($answer_object_id).') answer
			WHERE  answer.question_id = '.sqlValue($question_id);

		$sql_res = viewSQL($sql, 0);
       		while($answer_arr = db_sql_fetch_assoc($sql_res))
		{
			f_del_object_modul($answer_arr['record_id']);
		}
	}


	function del_object_surveys_by_question_id($question_id)
	{
		$sql = 'SELECT record_id
			FROM ('.create_sql_view(Get_object_id_by_name('survey')).') t
			WHERE  t.question_id = '.sqlValue($question_id);

		$sql_res = viewSQL($sql, 0);
       		while($arr = db_sql_fetch_assoc($sql_res))
		{
			f_del_object_modul($arr['record_id']);
		}
	
	}


	function save($object_id)
	{       
		global $language;
		global $edit, $added;

		//If is't adding, then create empty question
		$record_id = intval(post('record_id'));

		if( ($record_id==0) && isset($_POST['edit']) && (post('edit')==0) )
		{
			//Save date
			$_POST['date'] = date('Y-m-d H:i:s (T)');

			$field_arr = array
				(		
				'record_id'	=>	$record_id,
				'question'	=>	'',
				'active'	=>	'',
				'date'		=>	post('date'),
				'language'	=>      $language                                                                                    
				);

			$question_record_id = f_add_object_modul($field_arr, $object_id);	

			$edit = $question_record_id;
			$added = $question_record_id;
			$record_id = $question_record_id;
			$_POST['record_id'] = $question_record_id;
			$_POST['edit'] = $question_record_id;
		}


		//get language list
		$lang_list = array();
		$lang_list = SQLField2Array(viewsql('SELECT language_code FROM v_language WHERE status=1', 0));

		//Save answers
		if(isset($_POST['answer_text_'.$language]))
		{
			$answer_object_id = Get_object_id_by_name('answer');

			//Kill all old answers
	                del_object_answers_by_question_id($edit);

			foreach($_POST['answer_text_'.$language] as $k=>$v)
			{
				//Save Answer for global language
				$field_arr = array
					(		
					'record_id'	=>	0,
					'question_id'	=>	$edit,
					'answer'	=>	$v,
					'language'	=>	$language                                                                                    
					);
				$current_answer_id = f_add_object_modul($field_arr, $answer_object_id);	

				//Save Answer for each one language
				foreach($lang_list as $next_lang)
				{
					if($next_lang != $language)
					{
						$answer_text_for_next_answer = isset($_POST['answer_text_'.$next_lang][$k]) ? $_POST['answer_text_'.$next_lang][$k] : '';
						$field_arr = array
							(		
							'record_id'	=>	$current_answer_id,
							'question_id'	=>	$edit,
							'answer'	=>	$answer_text_for_next_answer,
							'language'	=>	$next_lang                                                                                    
							);
						f_upd_object_modul($field_arr, $answer_object_id);	
					}
				}
			}
		}

		global $error;
		if(isset($error['record_id']))
		{
			$error['record_id'] = 'The answers can not be repeated!';
		}

		return object_save($object_id);
	}

	function del($del_gall_dir = null)
	{


		global $del;			

		//Deleting all answers and all connected records from survey
		if($del)
		{
			//delete records from answer
			del_object_answers_by_question_id($del);
			
			//delete records from survey
			del_object_surveys_by_question_id($del);
		}

		return object_del();		
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
//				'upload_image',
//				'zip_open',
//				'zip_read',
//				'zip_entry_name',
//				'zip_entry_open',
//				'zip_entry_read',
//				'zip_entry_filesize',
//				'zip_entry_close',
//				'zip_close'
						),
			'php_ini' => array (),
			'constants' => array (
//				'EE_GALLERY_DIR',
//				'EE_GALLERY_C',
//				'EE_GALLERY_R',
//				'EE_GALLERY_CxR'
				),
			'db_funcs'  => array (),
			'dir_attributes' => array(
//				EE_IMG_PATH => '777',
//				EE_IMG_PATH.'gallery' => '777'
						)
		);

		return parse_self_test($ar_self_check);
	}
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
		case '0': echo parse($modul.'/list');break;
		case '1': echo save($object_id);break;
		case '2': del();break;
		case '3': echo save($object_id);break;
		case 'del_sel_items': del('registered_users');del_selected_items('object');echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
//		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
//					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
//					echo parse('export_excel');
//		case 'export_to_csv':
//			header( 'Content-Type: application/vnd.ms-excel' );
//			header( 'Content-Disposition: attachment; filename="'.$modul.'.csv"' );
//			echo parse('export_csv');
//			break;
//		case 'import_from_csv': echo import_object_from_csv(); break;
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': object_del_rows(); echo get_modul_list($modul); break;
	}

?>