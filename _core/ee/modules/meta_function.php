<?

function head_commentary_row($var)
{
	return meta_content_filter(getValueOf($var));
}

function sql_noquotes($val)
{
	return "REPLACE(REPLACE(REPLACE(REPLACE($val,'\'',''),'\\\"',''),'\\\\',''),'&#039;','')";
}

function get_title_sql($id, $row_language, $var_id = 0)
{
	global $object_id;
	if(!empty($object_id))
	{
		$meta_pos = 18;
		$where = 'var like "default_obj_meta_%%"';
	}
	else
	{
		$meta_pos = 14;
		$where = 'var like "default_meta_%%"';
	}

	$sql = 'SELECT substring(var,'.$meta_pos.') AS meta_name,

	CASE (
		SELECT COUNT(*)
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$row_language.'\'
		   AND sub_content.var = substring(content.var,9)
		   AND (
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		   AND sub_content.'.val_field_name().' IS NOT NULL
		   AND sub_content.'.val_field_name().' <> \'\'
		)
	WHEN 0 THEN
	    	    %s
	ELSE (
		SELECT %s
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$row_language.'\'
		   AND sub_content.var = substring(content.var,9)
		   AND (
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		ORDER BY sub_content.var_id DESC
		LIMIT 0, 1
		)
	END AS meta_content

   FROM content
  WHERE '.$where.'
    AND substring(var,'.$meta_pos.') = "title"
    AND language=\''.$row_language.'\'';
	return $sql;
}

function get_commentary_sql($id, $row_language, $var_id = 0)
{
	global $object_id;
	if(!empty($object_id))
	{
		$meta_pos = 18;
		$where = 'var like "default_obj_meta_%%"';
	}
	else
	{
		$meta_pos = 14;
		$where = 'var like "default_meta_%%"';
	}

	$sql = 'SELECT substring(var,'.$meta_pos.') AS meta_name,

	CASE (
		SELECT COUNT(*)
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$row_language.'\'
		   AND 
			(
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		   AND sub_content.var = substring(content.var,9)
		   AND sub_content.'.val_field_name().' IS NOT NULL
		   AND sub_content.'.val_field_name().' <> \'\'
		)
	WHEN 0 THEN
	    	    %s
	ELSE (
		SELECT %s
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$row_language.'\'
		   AND 
			(
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		   AND sub_content.var = substring(content.var,9)
		ORDER BY sub_content.var_id DESC
		LIMIT 0, 1
		)
	END AS meta_content

   FROM content
  WHERE '.$where.'
    AND substring(var,'.$meta_pos.') = "commentary"
    AND language=\''.$row_language.'\'';
	return $sql;
}

function get_meta_sql($id, $lang, $var_id = 0)
{
	global $object_id;
	if(!empty($object_id))
	{
		$meta_pos = 18;
		$where  = 'var like "default_obj_meta_%%"';
	}
	else
	{
		$meta_pos = 14;
		$where = 'var like "default_meta_%%"';
	}

	$sql = 'SELECT substring(var,'.$meta_pos.') AS meta_name,

	CASE (
		SELECT COUNT(*)
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$lang.'\'
		   AND sub_content.var = substring(content.var,9)
		   AND 
			(
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		   AND sub_content.'.val_field_name().' IS NOT NULL
		   AND sub_content.'.val_field_name().' <> \'\'
		)
	WHEN 0 THEN
	    	    %s
	ELSE (
		SELECT %s
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$lang.'\'
		   AND sub_content.var = substring(content.var,9)
		   AND 
			(
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		ORDER BY sub_content.var_id DESC
		LIMIT 0, 1
		)
	END AS meta_content

   FROM content
  WHERE '.$where.'
    AND substring(var,'.$meta_pos.') IN ("description", "keywords")
    AND language=\''.$lang.'\'

UNION

 SELECT substring(var,'.$meta_pos.') AS meta_name,

	CASE (
		SELECT COUNT(*)
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$lang.'\'
		   AND sub_content.var = substring(content.var,9)
		   AND 
			(
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		   AND sub_content.'.val_field_name().' IS NOT NULL
		   AND sub_content.'.val_field_name().' <> \'\'
		)
	WHEN 0 THEN
	    %s
	ELSE (
		SELECT %s
		  FROM content AS sub_content
		 WHERE sub_content.page_id=\''.$id.'\'
		   AND sub_content.language=\''.$lang.'\'
		   AND sub_content.var = substring(content.var,9)
		   AND 
			(
				sub_content.var_id=\''.$var_id.'\'
				OR
				sub_content.var_id=\'0\'
			)
		ORDER BY sub_content.var_id DESC
		LIMIT 0, 1
		)
	END AS meta_content

   FROM content
  WHERE '.$where.'
    AND substring(var, '.$meta_pos.') NOT IN ("description", "keywords", "title", "commentary", "")
    AND language=\''.$lang.'\'';

    return $sql;
}

function print_page_meta_title()
{
	global $t, $language;
	$_t = get_tpl_id_for_object();

	$sql = sprintf(get_title_sql(((int)$t)==$t ? $t : getField('select id from v_tpl_page_content where page_name=\''.$t.'\''),$language,$_t),
    		sql_noquotes(val_field_name()),
    		sql_noquotes('sub_content.'.val_field_name()));

	return parse_sql_to_html($sql, 'head_meta_title_row');
}

//Function returns commentary row from SEO module in HTML commentary
function print_page_commentary()
{
	global $t, $language, $object_id;

	$_t = null;

	if (!empty($object_id))
	{
		$id = Get_object_record_id_by_unique_name($object_id);
		$_t = get_tpl_id_for_object();
	}
	else if (strcmp((int)$t, $t) !=0)
	{
		$id = getField('SELECT id FROM v_tpl_page_content WHERE page_name='.sqlValue($t));
	}
	else
	{
		$id = $t;
	}

	$commentary_sql = get_commentary_sql($id, $language, $_t);

	$sql = sprintf($commentary_sql, val_field_name(), 'sub_content.'.val_field_name());

	return parse_sql_to_html($sql, 'head_commentary_row');
}

function count_page_id_for_seo() 
{
	global $t, $language, $object_id;

	if (!empty($object_id))
	{
		$pn = $object_id;
	}
	else
	{
		$pn = $t;
	}

	$i_page_id = ((int)$pn)==$pn ? $pn : getField('select id from v_tpl_page_content where page_name=\''.$pn.'\'');

	return $i_page_id; 
}

function get_tpl_id_for_object()
{
	global $t, $object_id;

	$_t = 0;

	if (!empty($object_id))
	{
		$_t = get_tpl_file_id($t);
	}
	return $_t;
}

function get_sql_for_page_meta_tags($i_page_id, $language, $var_id = 0)
{
	$sql = sprintf
	(
		get_meta_sql($i_page_id, $language, $var_id),
    		val_field_name(),
    		'sub_content.'.val_field_name(),
    		val_field_name(),
    		'sub_content.'.val_field_name()
	);

	return $sql;
}

function print_page_meta_tags()
{
	global $language;
	global $view_template_not_find;
	global $t, $object_id;
		
	$_t = get_tpl_id_for_object();
	$html = '';
	$search_html = '';
	$meta_tag_array = array();
	
	$i_page_id 	= count_page_id_for_seo();
	$sql 		= get_sql_for_page_meta_tags($i_page_id, $language, $_t);
	
	$res = viewSQL ($sql, 0);
	
	if (db_sql_num_rows($res))
	{
		$i = 0;
		$meta_tag_names = array();
		while ($row = db_sql_fetch_assoc($res))
		{
			$meta_tag_array[$i]['meta_name'] = $row['meta_name'];
			$meta_tag_array[$i]['meta_content'] = meta_content_filter($row['meta_content']);
			$meta_tag_names[$i] = $row['meta_name'];
			$i++;
		}
		// only in case if we have not Meta tag Robots
		if (!array_key_exists('robots', $meta_tag_names))
		{
			$for_search = getField('SELECT for_search FROM tpl_pages WHERE id=\''.$i_page_id.'\'');
			$noindex_html = '<meta name="Robots" content="noindex, nofollow" />';
			
			global $object_id;
			if(($for_search == 0 || $view_template_not_find) && empty($object_id))
			{
				$search_html = $noindex_html;
			}
		}
		$meta_tag_array = sort_seo_meta_tag($meta_tag_array);
		
		$html = parse_array_to_html($meta_tag_array, 'head_meta_tag_row').$search_html;
	}
	
	return $html;
}

function get_page_meta_tags_array($escape_ent = false)
{
	global $language;

	$_t = get_tpl_id_for_object();
	$i_page_id = count_page_id_for_seo();

	$sql = get_sql_for_page_meta_tags($i_page_id, $language, $_t);

	$sql_res = viewSQL($sql);
	$res_tegs_arr = array();
	while($arr_res = db_sql_fetch_assoc($sql_res))
	{                         
		$meta_name = strtolower($arr_res['meta_name']);

		if ($escape_ent)
		{
			$res_tegs_arr[$meta_name] = htmlspecialchars($arr_res['meta_content'], ENT_QUOTES);
		}
		else
		{
			$res_tegs_arr[$meta_name] = meta_content_filter($arr_res['meta_content']);
		}
	}

	return $res_tegs_arr;	
}


function preview_page_meta_tags($id, $row_language, $obj=false, $file_name=false)
{
	if ($obj)
	{
		global $object_id;
		$object_id = $id;
		$file_id = getField('SELECT id FROM tpl_files WHERE file_name='.sqlValue($file_name));
	}		      
	$sql = sprintf(get_commentary_sql(((int)$id)==$id ? $id : getField('select id from v_tpl_page_content where page_name=\''.$id.'\''),$row_language),
    		val_field_name(),
    		'sub_content.'.val_field_name());
 	$result = parse_sql_to_html($sql, 'templates/_seo/list_row_page_commentar_row');

	$sql = sprintf(get_title_sql($id, $row_language),
 		val_field_name(),
 		'sub_content.val');
	$result .= parse_sql_to_html($sql, 'templates/_seo/list_row_title_preview_row');

	$sql = sprintf(get_meta_sql($id,$row_language,(isset($file_id) ? $file_id : false)),
 		val_field_name(),
 		'sub_content.'.val_field_name(),
 		val_field_name(),
 		'sub_content.'.val_field_name());
	$result .= parse_sql_to_html($sql, 'templates/_seo/list_row_meta_preview_row');

	return $result;
}

function get_page_title()
{
	global $dns_draft_status;
	global $admin_template;

	if ($dns_draft_status == true || (config_var('use_draft_content') == true && checkAdmin() && $admin_template == 'yes'))
	{
		return DRAFT_MODE_TITLE;
	}

	global $t, $language, $object_id;
	$_t = get_tpl_id_for_object();

	if(empty($object_id))
	{
		$var = 'meta_title';
		$pn = $t;
		$default_val = 'default_meta_title';
	}
	else
	{
		global $object_name;
		$var = 'obj_meta_title';
		$pn = Get_object_record_id_by_unique_name($object_id);
		$default_val = 'default_obj_meta_title';
	}

	$_title_1 = cms($var.(!empty($object_id) ? $_t : ''), $pn, $language, true, true, !empty($object_id));
	$_title_2 = cms($var, $pn, $language, true, true, !empty($object_id), 0);

	$title = ($_title_1 ? $_title_1 : $_title_2);

	if (empty($title))
	{
		$title = cms($default_val);
	}

	return meta_content_filter($title);
}

function sql_get_all_meta()
{
	return '
		  SELECT var FROM content WHERE var = \'meta_commentary\'
		UNION
		  SELECT var FROM content WHERE var = \'meta_title\'
		UNION
		  SELECT var FROM content WHERE var = \'meta_keywords\'
		UNION
		  SELECT var FROM content WHERE var = \'meta_description\'
		UNION

		  SELECT
			 var
		    FROM content
		   WHERE var REGEXP "^meta_"
		     AND var NOT IN (\'meta_title\', \'meta_keywords\', \'meta_description\', \'meta_commentary\', \'\')
			AND var <> \'meta_\' 
			  ORDER BY var ASC
	';
}

function sql_get_all_obj_meta()
{
		return '
		  SELECT var FROM content WHERE var = \'obj_meta_commentary\'
		UNION
		  SELECT var FROM content WHERE var = \'obj_meta_title\'
		UNION
		  SELECT var FROM content WHERE var = \'obj_meta_keywords\'
		UNION
		  SELECT var FROM content WHERE var = \'obj_meta_description\'
		UNION

		  SELECT
			 var
		    FROM content
		   WHERE var REGEXP "^obj_meta"
		     AND var NOT IN (\'obj_meta_title\', \'obj_meta_keywords\', \'obj_meta_description\', \'obj_meta_commentary\', \'\')
			  ORDER BY var 
	';

}

/**
 * Check if such tag already exists
 * @param  string $meta_tag_name Checking meta tag
 * @return bool
 */
function is_meta_tag_exists($meta_tag_name)
{	 
	return (bool) getField('SELECT count(var) FROM content WHERE var = \''.$meta_tag_name.'\'');
}

function sort_seo_meta_tag(array $array)
{
	$new_array = array();
	
	$meta_tags_order_numbers =  unserialize(cms('metatags_order_numbers'));

	if (is_array($meta_tags_order_numbers))
	{
		asort($meta_tags_order_numbers, SORT_NUMERIC);
		$i = 0;
		foreach($meta_tags_order_numbers as $metatag_name => $number)
		{
			if (isset($array[$metatag_name]))
			{
				$new_array[$i] 	= array('meta_name' 	=> $metatag_name,
							'meta_content' 	=> $array[$metatag_name]);
				$i++;
			}
		}
	}
	else
	{
		$new_array = $array;
	}

	return $new_array;
}

function meta_content_filter($meta_content)
{
	$meta_content = htmlentities($meta_content, ENT_QUOTES, 'UTF-8');
	$meta_content = str_replace('&amp;', '&', $meta_content);

	return $meta_content;
}

function meta_content_preview_filter($meta_content)
{
	$meta_content = htmlentities($meta_content, ENT_QUOTES, 'UTF-8');
	$meta_content = str_replace('&', '&amp;', $meta_content);
	$meta_content = str_replace('\\', '\\\\', $meta_content);

	return htmlspecialchars($meta_content);
}

?>