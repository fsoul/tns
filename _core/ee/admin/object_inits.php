<?
/**
 * Contains inits for administration of objects (like Products [products.php], Software [software.php]
 * List of variables that are initialized here:<br>
 * $object_name - string - name of object<br>
 * $object_id - int - id of object<br>
 * $stat_fields - array - array of field names, that will contain the same data for any language<br>
 * $html_fields - array - array of field names, that will contain data in html format<br>
 * $img_fields - array - array of field names, that will contain link to image file<br>
 * $non_stat_fields - array - array of field names, that will contain data, that would differ depending on language, but not in html format or not a picture<br>
 * $fields - array - array of fields<br>
 */
	/*
	* This is in the case when we are using export csv from gallery, when we pass global variable $object_name
	* in this case it's 'gallery_image'.
	* In other cases $object_name = substr($modul,1);
	*/
	$object_name = empty($object_name)?substr($modul,1):$object_name;

	$count_of_object_edit_fields = db_sql_num_fields(ViewSQL(create_sql_view_by_name($object_name).' limit 0', 0));

	$object_id = (int)GetField('SELECT id FROM object WHERE name='.SqlValue($object_name));

	//Инициализируем массив полей, не зависящих от языка
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE (object_field_type in (\'id\', \'foreign_key\', \'date\') OR (one_for_all_languages = 1)) AND object_id='.sqlValue($object_id), 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$stat_fields[] = $r["object_field_name"];
	}
	$stat_fields[] = 'record_id';

	//Инициализируем массив HTML полей
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_field_type=\'html\' AND object_id='.sqlValue($object_id), 0);
	while($r = db_sql_fetch_assoc($rs))
	{
		$html_fields[] = $r["object_field_name"];
	}

	//Инициализируем массив IMAGE полей
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_field_type=\'image\' AND object_id='.sqlValue($object_id), 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$img_fields[] = $r["object_field_name"];
	}

	//Инициализируем массив FILE полей
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_field_type=\'file\' AND object_id='.sqlValue($object_id), 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$file_fields[] = $r["object_field_name"];
	}

	//Инициализируем массив полей, зависящих от языка, но не рисунок и не html
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_field_type not in (\'id\', \'foreign_key\', \'date\', \'html\') AND object_id='.sqlValue($object_id).' order by id', 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$non_stat_fields[] = $r["object_field_name"];
	}
/*
	//проверяем наличиие полей foreign_key, присваиваем поле в массив, которому соответствует его родитель
	$rs=viewsql('SELECT object_field_name FROM object_field WHERE object_field_type=\'foreign_key\' AND object_id='.sqlValue($object_id).' order by id',0);
	while($r=db_sql_fetch_assoc($rs))
	{
		$stat_fields[]=$r["object_field_name"];
	}
*/
/**
 * File contains functions for administrating objects.
*/
	require ('object_functions.php');

	//If sql query is already exist (was created earlier in modul) not create it 
	if (!isset($sql))
	{
		// так как в текущей реализаци object_inits.php тупо инклудится в самом начале модулей,
		// то передать параметр как-то иначе кроме как через глобальную переменную весьма затруднительно
		// соотв-нно проверяем, если он установлен (например для експорта в csv) - то используем
		if (isset($create_sql_view_all_languages) && $create_sql_view_all_languages === true)
		{
			$sql = create_sql_view($object_id, '', $create_sql_view_all_languages);
		}
		else
		{
			$sql = create_sql_view($object_id);
		}

		//если ошибка в создании обьектов/полей - возвращаем ошибку
		if ($sql == 'error')
		{
			object_print_list(null, 'error');
			exit;
		}

		if (isset($ar_edit_sql_where) && is_array($ar_edit_sql_where))
		{
			$w = ' AND ';
			$ar = array();

			foreach($ar_edit_sql_where as $k => $v)
			{
				$ar[] = $k . '=' . sqlValue($v);	
			}

			$w.= implode(' AND ', $ar);

			$sql.= $w;
		}

		//инициализируем массив fields по вьюхе
		$sql = 'SELECT * FROM (' . $sql . ') AS v ';
	}


	$obj_fields_cache_name = 'object_fields'.((is($edit) != '' || $op == 3) ? '_for_edit' : '_for_grid');

	if (check_obj_cache($object_id, $obj_fields_cache_name))
	{
		// it will take us about 0.09 sec. with cache created
		$fields	= unserialize(get_obj_cache($object_id, $obj_fields_cache_name));
	}
	else
	{
		// let use empty result set without records - we need just fields names here
		$sql_for_fields = preg_replace('/WHERE([ \t\r\n]+)1([ \t\r\n]*)=([ \t\r\n]*)1/', 'WHERE 1=0', $sql);
		// it will take us about 0.19 sec. without caching...
		$fields = db_sql_query_fields_for_empty_request($sql_for_fields);
		cache_obj($object_id, $obj_fields_cache_name, serialize($fields));
		// ... and about 0.09 sec. with cache created (next iterations)
	}

	//если данных нет - инициализируем по табл. object_field
	if (empty($fields))
	{
		$fields = array();
		$fields[] = 'record_id';

		$rs = viewsql('SELECT id, object_field_name FROM object_field WHERE object_id='.sqlValue($object_id).' order by id', 0);
		while ($r = db_sql_fetch_assoc($rs))
		{
			$fields[$r["id"]] = $r["object_field_name"];
		}

		$fields = renumber_array($fields);
	}

	// Sets default properties for grid on page in admin panel.
	require ('init_grid_properties.php');

	//инициализируем типы полей из табл. object_field
	foreach($fields as $k=>$v)
	{
		$type[$v] = strtolower(GetField('SELECT object_field_type FROM object_field WHERE object_field_name='.SQLValue($v).' AND object_id='.SQLValue($object_id)));
		//если тип foreign_key OR id - ставим тип текст
		if (	$type[$v]=='id'
			||
			$type[$v]=='foreign_key'
		)
		{
			$type[$v]='text';
		}

		//если рисунок - заменяем имя файла на рисунок камеры -- при наведении ddrivetip
		if ($type[$v]=='image')
		{
			$ar_grid_links[$v] = '<%%display_preview_button:'.EE_HTTP.EE_IMG_PATH.'%'.($k+1).'$s%%>';
			$type_filter[$v] = "readonly";
		}

		if ($type[$v] == 'file')
		{
			$ar_grid_links[$v] = '<a href="'.EE_HTTP.'action.php?action=get_object_file&file=%'.($k+1).'$s>%'.($k+1).'$s</a>';
			$type_filter[$v] = "readonly";
		}

		//устанавливаем настройки по умолчанию для полей типа DATE
		if ($type[$v]=='date') 
		{
			$type_filter[$v]   = "by_date";
			$ar_grid_links[$v] = '<%%date:'.DATE_FORMAT_PHP.',<%%intval:%'.($k+1).'$s%%>%%>';
			$type[$v]          = "date_object";
			$size[$v]	   = "10";
		}
	}

?>