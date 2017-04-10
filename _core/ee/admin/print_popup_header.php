<?php
	global $fields_group;

	foreach($fields_group as $key=> $val)
	{
		$fields_group_rev[] = $key;
	}
	//
	$i = 0;
	foreach($fields_group as $key => $val)
	{
		$temp_array[0] = $key;
		
		$array[$i]['show'] = array($key);
		$array[$i]['hide'] = array_diff($fields_group_rev, $temp_array);
		$i++;
	}

	function create_sheet($array)
	{
		global $fields_group_caption, $first_sheet;
		$html = "\r\n";
		foreach($array as $val)
		{
			if(!$first_sheet)
			{
				$first_sheet[0] = $val['show'][0];
				$first_sheet[1] = implode(':', $val['hide']);
			}
			$html .= '<li class="sl" id="'.$val['show'][0].'_sl"><a href="#" onClick="showDiv(\''.$val['show'][0].'\'); hideDiv(\''.implode(':', $val['hide']).'\'); return false;">'.($fields_group_caption[$val['show'][0]] ? $fields_group_caption[$val['show'][0]] : ucfirst(str_replace('_', ' ', $val['show'][0]))).'</a></li>'."\r\n";
		}
		return $html;
	}

	return '<ul class="ul_sl">'.create_sheet($array).'</ul>';
?>
