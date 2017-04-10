<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	$url = 'Location: '.$modul.'.php?load_cookie=true&op=0'.( array_key_exists('gallery_id', $_GET) ? '&gallery_id='.$_GET['gallery_id'] : '' );

	include('url_if_back.php');


	if (!defined('ADMIN_MENU_ITEM_GALLERY_IMAGE'))
	{
		define('ADMIN_MENU_ITEM_GALLERY_IMAGE', 'Resources|250/Gallery Images');
	}

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_GALLERY_IMAGE);

	if ($op == 'export_to_csv')
	{
		// необходимо передать доп-й аргумент в ф-ю create_sql_view()
		// с целью создать поля по всем яз?кам
		// но так как в текущей реализаци object_inits.php тупо инклудится в самом начале модулей,
		// то передать параметр как-то иначе кроме как через глобальную переменную весьма затруднительно
		global $create_sql_view_all_languages;
		$create_sql_view_all_languages = true;
	}

	// здесь в?зовется ф-я create_sql_view(), она создаст глобальную переменную $sql
	include('object_inits.php');

	$popup_height = ($count_of_object_edit_fields+count($langEncode)+4)*30;
	$popup_scroll = '1';
	// установка свойств по-умолчанию


	$align['record_id']='right';

	$size['record_id']='10';

	$caption['record_id'] = 'id';
	$caption['gallery_id'] = 'Gallery';
	$caption['image_filename'] = 'Filename';
	$caption['image_title'] = 'Title';
	$caption['image_description'] = 'Description';
	$caption['load_image'] = 'Load image *';
	$readonly = array('image_filename');

	$object_where_clause = ( empty($gallery_id) ? '' : 'gallery_id = '.sqlValue($gallery_id) );

	//скрыть столбец
	$hidden = array('load_image', 'language', 'text_above_image', 'text_below_image');
	// тип поля ввода

	$type['is_gallery_image'] = "string";

//	$type['gallery_id'] = empty($gallery_id) ? "string" : "select_gallery_id" ;
	$type['gallery_id'] = 'select_gallery_type';

	$type['image_filename'] = 'filename';
	$type['record_id'] = 'string';
	$type['image_description']='textarea';
	$type['description_above_image']='html';
	$type['description_below_image']='html';
	$type['is_gallery_image']='checkbox';
//	$type['load_image'] = ($op == 3)?"file":"string";
	$type['load_image'] = 'file';
	$type['item_order'] = 'set_item_order';

	$type_filter['gallery_id'] = 'select_gallery_id';
	$type_filter['publish_date']='empty';

	//$ar_grid_links_getfield["gallery_id"] = 'SELECT v.'.getField('SELECT DISTINCT object_field_name FROM object_content a INNER JOIN object_field b ON b.id = a.object_field_id WHERE b.object_field_type = \'TEXT\' and b.object_id = '.sqlValue(getField('SELECT id FROM object WHERE name = \'gallery\'')).' limit 0,1 ').' FROM ('.create_sql_view_by_name('gallery').') as v where v.gallery_id = \'%'.(array_search('gallery_id',$fields)+1).'$s\'';
	$sort_disabled = array('gallery_id');

	$default_sort_field = 'item_order';
	$default_sort_order = 'ASC';
	$sort_function[$default_sort_field] = 'CAST(%s AS UNSIGNED)';


	$mandatory=array('image_title');

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// подписи к колонкам списка (grid-а)
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
		global $gallery_id;
		return object_print_list($export);
	}

	// список полей в окне редактирования
	function print_fields()
	{
		global $gallery_id;
		$gallery_id = (empty($gallery_id) ? $_GET['gallery_id'] : $gallery_id);

		global $fields;

		//Sorting fields in edit-popup
		$edit_popup_order = array(
					'image_title',
					'gallery_id',
					'image_filename',
					'load_image',
					'is_gallery_image',
					'image_filename',
					'text_above_image',
					'text_below_image',
					'TITLE',
					'DESCRIPTION',
					'KEYWORDS',
					'image_description'
					);

		$fields = sort_object_edit_fields_by_order_array($fields, $edit_popup_order);

		return include('print_fields.php');
	}

	function try_create_ftp_folder($folder)
	{
		$folder = str_replace('\\', '/', $folder);

		$folder = trim($folder, '/');

		if (file_exists(EE_PATH.$folder) && is_file(EE_PATH.$folder))
		{
			trigger_error('Can\'t create folder '.EE_PATH.$folder.' - file with the same name already exists.');

			$res = false;
		}
		elseif (!file_exists(EE_PATH.$folder))
		{
			$res = createFtpFolder($folder);

			if ($res)
			{
				ftpChmod($folder, '0777');
			}
		}
		else
		{
			$res = true;
		}

		return $res;
	}

	function save()
	{
		global $b_color, $modul;
		global $pageTitle, $PageName, $FileID, $error, $aStatus;
		global $modul;
		global $fields, $op;
		global $mandatory;
		global $edit;
		global $url, $gallery_id, $object_id;
		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		if (array_key_exists('old_item_order', $_POST)
			&&
		    array_key_exists('item_order', $_POST)
		   )
		{            
			set_order($_POST['old_item_order'].'_'.$_POST['item_order'], $modul, 'item_order', $gallery_id);
		}


		if (post('refresh'))
		{
			$image_field = 'load_image';

			if ($_FILES[$image_field]['name'] != '')
			{
				unset($error[$image_field]);

				@try_create_ftp_folder(EE_IMG_PATH.EE_GALLERY_DIR);

				@try_create_ftp_folder(EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id);

				$gallery_size_params = db_sql_fetch_array(ViewSQL('SELECT gallery_image_w as static_width, gallery_image_h as static_height FROM ('.create_sql_view((int)GetField('SELECT id FROM object WHERE name="gallery"')).') v WHERE v.record_id = \''.$gallery_id.'\'',0));
				$res = upload_image($image_field, EE_GALLERY_DIR.$gallery_id.'/', null, EE_GALLERY_THUMBNAIL_W, EE_GALLERY_MAX_W, EE_GALLERY_MAX_H,$gallery_size_params);


				if (is_array($res))
				{
					$error[$image_field] = $res[0];
				}
				else
				{
					$field_values['image_filename'] = $res;
					$_POST['image_filename'] = $res;
					$_POST['gallery_id'] = $gallery_id;
				}
			}
			elseif ($op == 3)
			{
				$error['load_image'] = 'Please specify file to upload';
			}

			if ($edit && post('old_gallery_id') && (post('old_gallery_id') != post('gallery_id')) )
			{
				$old_image_gallery_path = EE_GALLERY_IMAGE_FILE_PATH.$_POST['old_gallery_id'];
				$new_image_gallery_path = EE_GALLERY_IMAGE_FILE_PATH.$_POST['gallery_id'];

				$image_filename = '/'.$_POST['image_filename'];
				$image_preview_filename = '/_'.$_POST['image_filename'];

				if (copy_file($old_image_gallery_path.$image_filename, $new_image_gallery_path.$image_filename, true)
					&&
				    copy_file($old_image_gallery_path.$image_preview_filename, $new_image_gallery_path.$image_preview_filename, true)
				   )
				{
					delete_file($old_image_gallery_path.$image_filename);
					delete_file($old_image_gallery_path.$image_preview_filename);
				}
				else
				{
					delete_file($new_image_gallery_path.$image_filename);
					delete_file($new_image_gallery_path.$image_preview_filename);
					$_POST['gallery_id'] = $_POST['old_gallery_id'];
					$error['gallery_id'] = 'Error while copy to another gallery';
				}

				if (count($error) == 0)
				{
					$field_values['is_gallery_image'] = (int)(!empty($field_values['is_gallery_image']));
				}
			}
		}
		return object_save($object_id);
	}

	function del()
	{
		global $del;
		/**
		* $curr_gallery_dir - Current gallery id
		* $array_object_ids - Array of object records id
		* $gallery_image_ids - array of  ids
		**/

		$del = $_GET['del'];
		$del_array = explode('|',$del);
		$array_object_ids = ((is_array($del_array) && count($del_array) > 0) ? $del_array : array($del));

		for($i=0; $i < count($array_object_ids); $i++)
		{
			$image_filename = getField('select image_filename FROM ('.create_sql_view((int)GetField('SELECT id FROM object WHERE name="gallery_image"')).') v WHERE v.record_id = '.sqlValue($array_object_ids[$i]));
			$gallery_id = getField('select gallery_id FROM ('.create_sql_view((int)GetField('SELECT id FROM object WHERE name="gallery_image"')).') v WHERE v.record_id = '.sqlValue($array_object_ids[$i]));
			$gallery_image_ids[] = $array_object_ids[$i];
			$image_path = EE_PATH.EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id.'/'.$image_filename;
			if (check_file($image_path))
			{
				deleteFile(EE_GALLERY_DIR.$gallery_id.'/'.$image_filename);
				deleteFile(EE_GALLERY_DIR.$gallery_id.'/_'.$image_filename);
			}
		}
		f_del_object_records($gallery_image_ids);
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (),
			'php_ini' => array (),
			'constants' => array (
				'EE_IMG_PATH',
				'EE_GALLERY_THUMBNAIL_W',
				'EE_GALLERY_MAX_W',
				'EE_GALLERY_MAX_H'),
			'db_tables' => array (),
			'db_funcs'  => array (),

			'ftp_dir_exists' => array(
				EE_IMG_PATH,
				EE_IMG_PATH.'gallery'
			),

			'ftp_dir_attributes' => array(
				EE_IMG_PATH => EE_DEFAULT_DIR_MODE,
				EE_IMG_PATH.'gallery' => EE_DEFAULT_DIR_MODE
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

	function set_order($set_sequence, $object_name, $object_field_name, $gallery_id)
	{

		$return = false;
		if($object_name{0} == '_')
		{
			$object_name = substr($object_name,1);
		}		
		$object_id = Get_object_id_by_name($object_name);
        
		if ($set_sequence)
		{                 			
			$res = RunSQL('SELECT * FROM 
					('.create_sql_view_for_fields_filter_by_fields('record_id, gallery_id, '.$object_field_name,'gallery_id = '.$gallery_id, $object_id).') 
						v WHERE v.gallery_id = '.$gallery_id);
                        
			while ($r = db_sql_fetch_assoc($res))
			{
				$arr_val_order[$r[$object_field_name]] = $r['record_id'];
			}

			$order_arr = explode('_', $set_sequence);
			$srcPos = (int) $order_arr[0];
			$destPos = (int) $order_arr[1];
        
			if ((($increment_from = array_key_exists($destPos, $arr_val_order)) !== false) && ($destPos > 0 && $srcPos > 0) && ($srcPos != $destPos))
			{
				$buff[$destPos] = $arr_val_order[$srcPos];
				if ($srcPos < $destPos)
				{
					for ($i = $srcPos; $i < $destPos; $i++)
					{
						$tmp_arr[$i] = $arr_val_order[$i + 1];
					}
				}
				else
				{
					for ($i = $destPos; $i < $srcPos; $i++)
					{
						$tmp_arr[$i + 1] = $arr_val_order[$i];
					}
				}
				$tmp_arr[$destPos] = $buff[$destPos];
				ksort($tmp_arr);
        
			}
			unset($arr_val_order);

			if ($tmp_arr && is_array($tmp_arr))
			{         			
				$object_field_id = getField('SELECT id FROM object_field WHERE object_field_name = "'.$object_field_name.'" AND object_id = '.$object_id);

                                RunSQL('START TRANSACTION;');
				foreach ($tmp_arr as $k=>$v)
				{
        
					$sql = 'UPDATE object_content
						   SET value = '.$k.'
						 WHERE object_field_id = '.$object_field_id.'
			  			   AND object_record_id = '.$v.';';
					RunSQL($sql);
				}
                                RunSQL('COMMIT;');
				$return = true;
			}
		}

		return $return;
	}

//********************************************************************
	switch($op)
	{
		default:
		case '0': echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '2':
			del();
			header($url);
			break;
		case '3': echo save();break;
		case 'add_zip': echo add_zip();break;
		case 'del_sel_items':
			del();
			header($url);
			break;
		case 'self_test': echo print_self_test(); break;
		case 'rows_on_page': rows_on_page(); break;
		case 'export_excel':
			header( 'Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
			echo parse('export_excel');
			break;
		case 'export_to_csv':
			header( 'Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.csv"' );
			echo parse('export_csv');
			break;
		case 'import_from_csv': echo import_object_from_csv(); break;
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del(); echo get_modul_list($modul); break;
		case 'set_order':set_order((array_key_exists('set_order', $_GET)?$_GET['set_order']:false),$modul,'item_order', $_GET['gallery_id']); echo get_modul_list($modul); break;
	}
?>