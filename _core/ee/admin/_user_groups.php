<?
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'user_groups';
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 145; 

	if (!defined('ADMIN_MENU_ITEM_USR_GROUPS')) define('ADMIN_MENU_ITEM_USR_GROUPS', 'Administration/Users Groups');

	//�஢��塞 �ࠢ� � ��ࠡ��뢠�� op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_USR_GROUPS);

	// ������ ᯨ᮪ �����
	// �� ���� ࠡ���� �� �㭪樨

	// ��⠭���� ᢮��� ��-㬮�砭��
	require ('set_default_grid_properties.php');

	// ��⠭���� ᢮���, �⫨������ �� ��⠭�������� ��-㬮�砭��

	// ⮫쪮 ᯨ᮪ (grid)
	//����� �⮫���

 	// ࠧ��� ���� 䨫��� � ᯨ᪥
	$size_filter['id'] = 3;
	
	// ⨯ 䨫���
	

	// ��ࠢ�������
	$align['id']='right';
	


	// �⨫� �⮫��
	
	// ��ଫ���� ᠬ��� ���祭�� � �ਤ�
	
	// ⮫쪮 ���� ।���஢����
	// �⨫� ��ப� ���� ���

	// ࠧ��� ����

	$type['group_code'] = ($op == 1 ? 'string' : 'text');

	// ����㯭� ⮫쪮 ��� �⥭��

	// ��易⥫쭮 ��� ����������

	$mandatory=array('group_name', 'group_code');

	// ⨯ ���� �����
		$type['id'] = "string";
	// ����⠭�������� ���祭�� 䨫���, ���஢��, ��࠭���
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// ��� ���஢�� � sql-�����
	if ($op == 0) $order = getSortOrder();

	// ������ � �������� ᯨ᪠ (grid-�)
	
	// �㤠 ��
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// ���� 䨫��� � grid-�
	function print_filters()
	{
		return include('print_filters.php');
	}

	// ᯨ᮪ (grid)
	function print_list($export='')
	{
		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);

		include('print_list_limit_sql.php');

		$rs = viewsql($sql, 0 );

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
				$row_field[$i]['field_value'] = vsprintf($ar_grid_links[$fields[$i]], $r);
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

	// ᯨ᮪ ����� � ���� ।���஢����
	function print_fields()
	{
		return include('print_fields.php');
	}

	// ����������/��࠭���� �����
	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');

		if (post('refresh'))
		{
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

				$res = RunNonSQLFunction($db_function, $field_values);

				if ($res < 0)
				{
					$error['id'] = 'DataBase error';
				}
				else
				{
					if (post('save_add_more')) 
					{
						header ('Location: '.$modul.'.php?op=3&added='.$res);
						exit;
					} else close_popup('yes');
				}
			}
		}
		return parse($modul.'/edit');
	}

	// 㤠�����
	function del()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del'.$modul, array($del));

		header($url);
	}

	include ('rows_on_page.php');

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
				'folder_group',
				'user_group',
				'user_groups'
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