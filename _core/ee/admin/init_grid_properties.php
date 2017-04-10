<?
	$sort_function = $check_pattern = $caption = $captions = $mandatory = $hidden = $readonly = $form_row_style = $form_row_type = array();

	for (	$i=0;	$i<count($fields);
		/* '<' - it's an Illegal character;
		** bug id = 7208;
		*/
		$check_pattern[$fields[$i]] = array('^[^<]*$', 'Illegal characters in '.$fields[$i]),
		$align[$fields[$i]] = 'left',
		$valign[$fields[$i]] = 'top',
		$size_filter[$fields[$i]] = (strpos(strtolower($fields[$i]), 'datetime') !== false 
						? strlen(date(str_replace('%','',DATETIME_FORMAT_MYSQL))) :
							(strpos(strtolower($fields[$i]), 'date') !== false
						? strlen(date(str_replace('%','',DATE_FORMAT_MYSQL))) :
							(strpos(strtolower($fields[$i]), 'time') !== false
						? strlen(date(str_replace('%','',TIME_FORMAT_MYSQL))) : 
							($fields[$i] == 'id' || substr($fields[$i],-3) == '_id')
						? '5' : '25'))),
		//$size_filter[$fields[$i]] = '25',
		$type_filter[$fields[$i]] = 'text',
		$grid_col_style[$fields[$i]] = '',
		$size[$fields[$i]] = '70',
		$type[$fields[$i]] = 'text',
		$form_row_style[$fields[$i]] = '',
		$form_row_type[$fields[$i]] = '',

		$caption[$fields[$i]] = case_title(str_replace('_', '&nbsp;', str_replace(ltrim($modul,'_').'_', '', $fields[$i]))),
		$sort[$i+1] = $fields[$i],
		$sort_function[$fields[$i]] = ' %s ',

		// условие where для запроса
		$filter_function[$fields[$i]] = (
			strpos(strtolower($fields[$i]), 'datetime') !== false
			?
			db_dt_field_format('%s', DATETIME_FORMAT_MYSQL_PRINTF)
			:
			(	strpos(strtolower($fields[$i]), 'date') !== false
				?
				db_dt_field_format('%s', DATE_FORMAT_MYSQL_PRINTF)
				:
				(	strpos(strtolower($fields[$i]), 'time') !== false
					?
					db_dt_field_format('%s', TIME_FORMAT_MYSQL_PRINTF)
					:
					' %s '
				)
			)
		),

		$ar_grid_links[$fields[$i]] = '%'.(++$i).'$s'
	);

	/* Automatic calculation of $popup_height
	** based on fields number in edit-view.
	** bug id = 7109, added '@', because v'.$modul.'_edit exists not for all modules.
	*/
	if (!isset($popup_height))
	{
		$popup_height = ($count_of_edit_fields+4)*30;
	}

?>