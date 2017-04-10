<?
// Function for export to excel of grid-based pages
function print_export_list() 
{
	include(EE_ADMIN_PATH.'print_list_init_vars.php');
	$rs = viewsql($sql, 0);
	global $caption;
	$s = '';
	$j=0;
	$rows = array();
	while($r=db_sql_fetch_row($rs))
	{
		$row_field = array();
		for($i=0; $i<count($r); $i++)
		{
			$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
			$row_field[$i]['field_align'] = $align[$fields[$i]];
			$row_field[$i]['field_value'] = vsprintf($ar_grid_links[$fields[$i]], $r);
			$field_names[$i]['field_value']=$caption[$fields[$i]];
		}
			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));
			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/list_row_field_excel');
		$rows[$j]['id'] = $r[0];
		$rows[$j]['name'] = SaveQuotes($r[1]);
		$j++;
	}
	$s = parse_array_to_html($field_names,'templates/list_row_head_excel');
	$s .= parse_array_to_html($rows, 'templates/list_row_excel');
		return $s;
}

//if $is_boolean=0 returns array of values
function check_if_in_mapping($record_name, $record_id, $is_boolean=1)
{
	$where = '';
	if($is_boolean)
	{
		$where = ' WHERE res.'.$record_name.'='.sqlValue($record_id).' LIMIT 1';
	}
	$sql = 'SELECT res.'.$record_name.' FROM('.create_sql_view_by_name('news_mapping').') AS res'.$where;
	$rs = viewSQL($sql);
	$return = ($is_boolean)?0:array();
	if(db_sql_num_rows($rs) > 0)
	{
		$ret = array();
		while($res = db_sql_fetch_assoc($rs))
		{
			$ret[] = $res[$record_name];
		}
		$return = ($is_boolean)?1:$ret;
	}
	return $return;
}

function sort_seo_grid_fields_by_users_wish($ar_meta_default, $prefix='')
{
	// fields reordering
	$mata_tags_order_numbers =  unserialize(cms('matatags_order_numbers'));
	if (!is_array($mata_tags_order_numbers))
	{
		$mata_tags_order_numbers = array();
	}
	asort($mata_tags_order_numbers, SORT_NUMERIC);
	$fields_sorted_part = array();
	foreach($mata_tags_order_numbers as $k=>$v)
	{
		if(in_array($prefix.$k, $ar_meta_default))
		{
			$fields_sorted_part[] = $prefix.$k;
			unset($ar_meta_default[array_search($prefix.$k, $ar_meta_default)]);
		}
	}

	return array_merge($ar_meta_default, $fields_sorted_part);
}

function check_if_delete_enabled($modul)
{
	global $disable_delete;
	$return = false;
	if (	$modul != '_seo' 
		&& 
		$modul != '_object_seo' 
		&& 
		$modul != '_mailing' 
		&& 
		$modul != '_mail_inbox' 
		&& 
		$modul != '_alt_tags' 
		&& 
		(!isset($disable_delete) || $disable_delete == false)
	)
	{
		$return = true;
	}
	return $return;
}

