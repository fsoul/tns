<?php
		global $modul, $fields, $caption, $mandatory, $readonly, $size, $type, $form_row_style, $form_row_type;
		global $op, $enum_table, $enum_field;

		if (	!array_key_exists('record_id', $type)
			||
			empty($type['record_id'])
		)
		{
			//The type of field 'record_id' must be always!
			$type['record_id'] = 'string';
		}

		for ($i=0; $i<count($fields); $i++)
		{
			$fields_list[$i]['field_name']	= $fields[$i];
			$fields_list[$i]['caption']	= $caption[$fields[$i]];
			$fields_list[$i]['mandatory']	= (is_array($mandatory) && in_array($fields[$i], $mandatory));
			$fields_list[$i]['readonly']	= (is_array($readonly) && in_array($fields[$i], $readonly));
			$fields_list[$i]['size']	= $size[$fields[$i]];
			$fields_list[$i]['type']	= $type[$fields[$i]];
			$fields_list[$i]['row_style']	= $form_row_style[$fields[$i]];
			$fields_list[$i]['row_type']	= $form_row_type[$fields[$i]];
			$fields_list[$i]['field_num'] 	= $i+1;

			if (!empty($enum_table) && !empty($enum_field))
			{
				$fields_list[$i]['enum_table'] = $enum_table[$fields[$i]];
				$fields_list[$i]['enum_field'] = $enum_field[$fields[$i]];
			}
		}
		return parse_array_to_html($fields_list, 'templates/'.$modul.'/edit_fields');

?>