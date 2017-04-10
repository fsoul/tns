<?
$edit_styles = array(
array('name' => 'float', 'type' => 'text'),
array('name' => 'color', 'type' => 'color'),
array('name' => 'background', 'type' => 'text'),
array('name' => 'background-color', 'type' => 'color'),
array('name' => 'font-size', 'type' => 'text', 'group' => 'font'),
array('name' => 'font-weight', 'type' => 'select', 'group' => 'font', 'values' => array('normal','bold','bolder','lighter')),
array('name' => 'font-style', 'type' => 'select', 'group' => 'font', 'values' => array('normal','italic','oblique')),
array('name' => 'font-family', 'type' => 'text', 'group' => 'font'),
array('name' => 'margin-top', 'type' => 'text', 'group' => 'margin'),
array('name' => 'margin-bottom', 'type' => 'text', 'group' => 'margin'),
array('name' => 'margin-left', 'type' => 'text', 'group' => 'margin'),
array('name' => 'margin-right', 'type' => 'text', 'group' => 'margin'),
array('name' => 'padding-top', 'type' => 'text', 'group' => 'padding'),
array('name' => 'padding-bottom', 'type' => 'text', 'group' => 'padding'),
array('name' => 'padding-left', 'type' => 'text', 'group' => 'padding'),
array('name' => 'padding-right', 'type' => 'text', 'group' => 'padding'),
array('name' => 'border-top', 'type' => 'text', 'group' => 'border'),
array('name' => 'border-bottom', 'type' => 'text', 'group' => 'border'),
array('name' => 'border-left', 'type' => 'text', 'group' => 'border'),
array('name' => 'border-right', 'type' => 'text', 'group' => 'border')
);

function get_dynamic_css()
{
	global $edit_styles;
	$r = ViewSQL('SELECT * FROM styles',0);
	$arr = array();
	while ($row = db_sql_fetch_assoc($r))
	{
			$style_text = '';
			foreach (unserialize($row['declaration']) as $k=>$v)
			{
//				if ($edit_styles[$k]['type']=='color') $v = '#'.$v;
				$style_text .= '	'.$k.': '.$v.';
';	
			}
			$row['declaration'] = $style_text;
			$arr[] = $row;
	}
	$ret = parse_array_to_html($arr,EE_PATH.'templates/style/dynamic_styles');
	return $ret;
}
function get_dynamic_style_xml() {
	global $edit_styles;
	$r = ViewSQL('SELECT * FROM styles',0);
	$arr = array();
	while ($row = db_sql_fetch_assoc($r))
	{
			$arr[] = $row;
	}
	$ret = parse_array_to_html($arr,EE_PATH.'templates/style/dynamic_styles_xml');
	return $ret;
}

?>