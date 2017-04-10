<?
		global $page, $modul, $fields, $size_filter, $type_filter, $grid_col_style, $click, $align, $valign, $hidden;
		global $enum_table, $enum_field;
		global $readonly;

		// если был применен фильтр
		if (!empty($_POST['refresh']))
		{
			foreach ($_POST as $key=>$val)
			{
				// берем из поста поля фильтра
				if (strpos($key, 'filter_') === 0
					and trim($val) != '')
				{
					// и инициал-ем соотв-е глоб-е пер-е
					global $$key;
					$$key = $val;
				}
			}
		}

		$filters_list = array();
		for ($i=0; $i<count($fields); $i++)
		{
			$filters_list[$i]['field_name']	= $fields[$i];
			$filters_list[$i]['field_size']	= $size_filter[$fields[$i]];
			$filters_list[$i]['type']	= $type_filter[$fields[$i]];
			$filters_list[$i]['readonly']	= in_array($fields[$i], $readonly);
			$filters_list[$i]['col_style']  = $grid_col_style[$fields[$i]];
			$filters_list[$i]['filter_align']  = $align[$fields[$i]];
			$filters_list[$i]['filter_valign']  = $valign[$fields[$i]];
			$filters_list[$i]['enum_table'] = $enum_table[$fields[$i]];
			$filters_list[$i]['enum_field'] = $enum_field[$fields[$i]];
			$filters_list[$i]['field_num'] 	= $i+1;
		}

		$filters_list = remove_by_keys($filters_list, array_keys(array_intersect($fields, $hidden)));

		return parse_array_to_html($filters_list, EE_ADMIN_PATH.'templates/'.$modul.'/list_filters');
?>