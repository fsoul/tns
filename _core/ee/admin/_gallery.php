<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 500;

	if (!defined('ADMIN_MENU_ITEM_GALLERY'))
	{
		define('ADMIN_MENU_ITEM_GALLERY', 'Resources|250/Gallery');
	}

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_GALLERY);

	// главный список полей
	// по нему работают все функции

	if ($op == 'export_to_csv')
	{
		// необходимо передать доп-й аргумент в ф-ю create_sql_view()
		// с целью создать поля по всем яз?кам
		// но так как в текущей реализаци object_inits.php тупо инклудится в самом начале модулей,
		// то передать параметр как-то иначе кроме как через глобальную переменную весьма затруднительно

		global $create_sql_view_all_languages, $object_name;
		$create_sql_view_all_languages = true;
		$object_name = 'gallery_image';
	}

        include('object_inits.php');

	// установка свойств по-умолчанию
//	require ('set_default_grid_properties.php');

	$align['gallery_id']='right';
	$align['gallery_date']='left';
	$align['gallery_images']='right';

	$filter_function['gallery_date'] = 'DATE_FORMAT(FROM_UNIXTIME(%s), \'%%d-%%m-%%Y\')';
	$ar_grid_links['gallery_date'] = '<%%date:d-m-Y,%'.(array_search('gallery_date',$fields)+1).'$s%%>';

	if ($op != 'export_excel')
	{
		$ar_grid_links['gallery_title']='<a href="'.EE_ADMIN_URL.'_gallery_image.php?op=0&admin_template=yes&gallery_id=%'.(array_search('gallery_id',$fields)+1).'$s">%'.(array_search('gallery_title',$fields)+1).'$s</a>';
	}

	$ar_grid_links_getfield["gallery_images"] = 'SELECT count(*) FROM ( '.create_sql_view((int)GetField('SELECT id FROM object WHERE name="gallery_image"')).' ) v  WHERE v.gallery_id=\'%'.(array_search('gallery_id',$fields)+1).'$s\'';
        $sort_disabled = array('gallery_images', 'gallery_id');

	$ar_grid_links["gallery_status"] = '<%%iif:0,%'.(array_search('gallery_status',$fields)+1).'$s,Draft,<%%iif:1,%'.(array_search('gallery_status',$fields)+1).'$s,Published,<%%iif:2,%'.(array_search('gallery_status',$fields)+1).'$s,Archive%%>%%>%%>'; // array_search('status_of_news',$fields)+1;




	//скрыть столбец
	$hidden = array('record_id', 'language', 'load_gallery', 'gallery_image_h', 'gallery_image_w', 'item_description', 'item_guid');

	//caption of gallery object fields
	$caption['gallery_id'] = 'Gallery id';
	$caption['gallery_date'] = 'Date';
	$caption['gallery_title'] = 'Title';
	$caption['gallery_description'] = 'Description';
	$caption['gallery_status'] = 'Status';
	$caption['gallery_images'] = 'Images';
	$caption['gallery_image_h'] = "Static height";
	$caption['gallery_image_w'] = "Static width";

	$readonly=array('gallery_date' , 'gallery_images');

	$size['id']='10';
	$size['gallery_date']='30';

	$mandatory=array('gallery_title','gallery_description');

	$type_filter['gallery_status']='select_DPA';

	$type_filter['gallery_date']='date';
	$type_filter['gallery_images']='empty';

        // тип поля ввода
	$type['record_id'] = "string";
	$type['id'] = "string";
//	$type['gallery_images'] = "string";
	$type['gallery_image_h'] = "text";
	$type['gallery_image_w'] = "text";
	$type['gallery_id'] = "string";
	$type['gallery_date'] = 'date_object';
	$type['gallery_status']='select_DPA';
	$type['load_gallery']='file';
	$form_row_type['gallery_images'] = 'none';



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

	function save()
	{
		global $_POST, $b_color, $modul;
		global $pageTitle, $PageName, $FileID, $error, $aStatus;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit;
		global $url, $gallery_id;
		global $object_id;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		if (post('refresh'))
		{
			// if gallery has no one image then it can not be "Published"
			if(post('gallery_status')==1 
				&& (post('gallery_id')=='' 
					|| getField('SELECT count(*)
							FROM ('.create_sql_view_by_name_for_fields('gallery_id', 'gallery_image').') gallery_image
							WHERE gallery_image.gallery_id='.sqlValue($gallery_id)
					) == 0
				)
			)
			{
				$error['gallery_status'] = 'Gallery can not be "Published", because it has no one image';
			}

			$image_field = 'load_gallery';

			if (!empty($edit) && $_FILES[$image_field]['name'] != '')
			{
				$uploaded = upload_image_zip($gallery_id, $image_field, EE_GALLERY_DIR.$gallery_id.'/', null, EE_GALLERY_THUMBNAIL_W,EE_GALLERY_MAX_W,Array('static_width'=>$static_width,'static_height'=>$static_height), true);

				if (is_array($uploaded))
				{
					$error[$image_field] = $uploaded[0];
				}

				if (isset($error['record_id']))
				{
					unset($error['record_id']);
					$error['load_gallery'] = 'Such image(s) already exists';
				}
			}

			if (count($error)==0)
			{
				// unset($field_values['load_gallery']);
				$sql = 'SELECT max(CAST(v.gallery_id as UNSIGNED)) FROM ('.create_sql_view((int)GetField('SELECT id FROM object WHERE name="gallery"')).' ) v ';

				if (!$edit)
				{
					$res = getField($sql);

					if ($res == 0)
					{
						$_POST['gallery_id'] = $gallery_id = 1;
					}
					else
					{
						$_POST['gallery_id'] = $gallery_id = ++$res;
					}
				}

				if (!file_exists(EE_PATH.EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id))
				{	
					$res = createFtpFolder(EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id);
					if($res)
					{
						ftpChmod(EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id, '0777');
					}
				}
			}
		}		

		return object_save($object_id);		
	}

	function del()
	{
		global $del, $gallery_id;

		/**
		* $array_object_ids - Array of object records id
		* $gallery_image_ids -  record ids of images and record id of gallery
		**/

		$del = $_GET['del'];
		$del_array = explode('|',$del);
		$array_object_ids = ((is_array($del_array) && count($del_array) > 0) ? $del_array : array($del));

		for ($i=0; $i < count($array_object_ids); $i++)
		{
			$gallery_record_id = $array_object_ids[$i];

			$gallery_id = getField('
				SELECT v.gallery_id
				  FROM ( '.create_sql_view((int)GetField('SELECT id FROM object WHERE name="gallery"')).') v
				 WHERE v.record_id = '.sqlValue($gallery_record_id)
			);

			if ($gallery_images_ids = gallery_get_correction_array_of_images_ids($gallery_id))
			{
				array_push($gallery_images_ids, $gallery_record_id);
				$res_ids = $gallery_images_ids;
			}
			else
			{
				$res_ids[] = $gallery_record_id;
			}

			$gallery_path = EE_PATH.EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id.'/';		

			if (clear_dir($gallery_path))
			{
				remove_dir($gallery_path);
			}
			f_del_object_records($res_ids);
		}
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'upload_image',
				'zip_open',
				'zip_read',
				'zip_entry_name',
				'zip_entry_open',
				'zip_entry_read',
				'zip_entry_filesize',
				'zip_entry_close',
				'zip_close'
						),
			'php_ini' => array (),
			'constants' => array (
				'EE_GALLERY_DIR',
				'EE_GALLERY_C',
				'EE_GALLERY_R',
				'EE_GALLERY_CxR'),
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
		case 'del_sel_items':
			del();
			header($url);
			echo parse($modul.'/list');break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
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
	}
?>