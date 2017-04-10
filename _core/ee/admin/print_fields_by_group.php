<?php
		global $modul, $fields, $caption, $mandatory, $readonly, $size, $type, $form_row_style, $form_row_type;
		global $op, $enum_table, $enum_field;
		global $fields_group;
		global $first_sheet;
		
		$fields_html = '';                             	

		foreach($fields_group as $k => $v)
		{
			$i = 0;
			foreach($v as $v2)
			{
				$fields_list[$i]['field_name']	= $v2;
				$fields_list[$i]['caption']	= (isset($caption[$v2]) ? $caption[$v2] : false);
				$fields_list[$i]['mandatory']	= in_array($v2, $mandatory);
				$fields_list[$i]['readonly']	= in_array($v2, $readonly);
				$fields_list[$i]['size']	= (isset($size[$v2]) ? $size[$v2] : false);
				$fields_list[$i]['type']	= (isset($type[$v2]) ? $type[$v2] : false);
				$fields_list[$i]['row_style']	= (isset($form_row_style[$v2]) ? $form_row_style[$v2] : false);
				$fields_list[$i]['row_type']	= (isset($form_row_type[$v2]) ? $form_row_type[$v2] : false);
				$fields_list[$i]['field_num'] 	= $i+1;

				if (!empty($enum_table) && !empty($enum_field))
				{
					$fields_list[$i]['enum_table'] = $enum_table[$v2];
					$fields_list[$i]['enum_field'] = $enum_field[$v2];
				}
				$i++;
			}
			$arr[$k] = $fields_list;
			unset($fields_list);
		}

      		foreach($fields_group as $k => $v)
		{
			$fields_html .= '</table><div id="'.$k.'"><table width="100%" cellspacing="0" cellpadding="0" border="0">';
			$fields_html .= parse_array_to_html($arr[$k], 'templates/'.$modul.'/edit_fields');
			$fields_html .= '</table></div><table width="100%" cellspacing="0" cellpadding="0" border="0">';
		}
		if(!empty($first_sheet[0]) && !empty($first_sheet[1])) $fields_html .= '<script type="text/javascript">showDiv(\''.$first_sheet[0].'\'); hideDiv(\''.$first_sheet[1].'\')</script>';
		return $fields_html;
?>