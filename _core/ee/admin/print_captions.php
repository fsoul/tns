<?
		global $modul, $caption, $captions, $grid_col_style, $fields, $hidden, $align, $sort_disabled;

		if (!is_array($sort_disabled))
			$sort_disabled = array();

		for ($i=0; $i<count($fields); $i++)
		{
			$captions[$fields[$i]]['caption'] = $caption[$fields[$i]];
			$captions[$fields[$i]]['col_style'] = $grid_col_style[$fields[$i]];
			$captions[$fields[$i]]['caption_align'] = $align[$fields[$i]];
			$captions[$fields[$i]]['field_name'] = $fields[$i];
			$captions[$fields[$i]]['field_num'] = $i+1;
			$captions[$fields[$i]]['sorting'] = (in_array($fields[$i], $sort_disabled)) ? 0 : 1;
		}

		$captions = remove_by_keys($captions, $hidden);

		return parse_array_to_html($captions, EE_ADMIN_PATH.'templates/'.$modul.'/list_captions'.$export);
?>