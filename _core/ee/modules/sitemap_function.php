<?

function print_sitemap($tpl, $permit_groups = false, $addsExcludeRule = false)
{
//	$result_array_satellite = get_satellite_sitemap($permit_groups);
	$result_array = get_satellite_sitemap($permit_groups);
//	$result_array_object = get_object_sitemap('', '', ($addsExcludeRule ? json_decode($addsExcludeRule, true) : array()));
//	$result_array = array_merge($result_array_satellite,$result_array_object);

	return parse_array_to_html($result_array, $tpl);
}

/**
 * Generate SATELLITE SITEMAP array
 */
function get_satellite_sitemap($permit_groups = false)
{
	if (dns_disabled()) return '';

	$rs = get_satellite_sitemap_query($permit_groups);

	$result= array();
	$ind = 0;
	$time = 0;

	while($r = db_sql_fetch_assoc($rs))
	{
		$i_page_id	 = $r['id'];
		$i_language_code = $r['language_code'];

		$location = get_sitemap_location($i_page_id, $i_language_code);
 
		$time = get_sitemap_edit_time($ind, $result, $location, $r['edit_date'], $r['content_last_edit_time']);

		$result[$ind]["location"] 	= urlencode_list($location);
		$result[$ind++]["lastmod"] 	= date("Y-m-d", $time);
	}

	return $result;
}

function get_satellite_sitemap_query($permit_groups = false)
{
	global $language;

	$rs = false;

	if ($permit_groups)
	{
		$permit_group_arr = explode(';', $permit_groups);
		$sql_part = '
			IF (group_access=1,
				1,
				(SELECT
					COUNT(*)
				FROM
					folder_group
				WHERE
					folder_id=p.folder_id
					AND
					group_id IN (	SELECT
								id
							FROM
                                      				user_groups
                                			WHERE
                                      				group_code IN('.sqlValuesList($permit_group_arr).')
                                		     )
				)
      			) AS access';
	}
	else
	{
		$sql_part = '
			IF (group_access=1,1,0) AS access';
	}

	$sql_content_last_edit_time  = '( SELECT
							MAX(edit_date)
		 			    FROM
							content
					   WHERE 
							language=p.language
							AND
							page_id=p.id) AS content_last_edit_time,';

	$sql_language_and = ((get('t') && $language) ? ' AND p.language ='.sqlValue($language) : '');

	$sql = 'SELECT
			p.id,
			p.edit_date,
			'.$sql_content_last_edit_time.'
			p.folder_id,
			p.language as language_code,
			'.$sql_part.'
		FROM
			v_tpl_page_content p

		LEFT JOIN
      			v_language l
		ON
      			l.language_code = p.language
		WHERE
			p.for_search = 1
			AND
			l.status = 1
			AND
			p.tpl_id <> 0'.$sql_language_and;

	$sql = 'SELECT * FROM ('.$sql.') AS sitemap WHERE access = 1';

	$rs = ViewSQL($sql, 0);

	return $rs;
}

function get_sitemap_edit_time(&$point, $sitemap_array, $location, $page_edit_date, $content_last_edit_date)
{
	$content_last_edit_date = (empty($content_last_edit_date) ? 0 : strtotime($content_last_edit_date));
	$time2 = max(strtotime($page_edit_date), $content_last_edit_date);

	if ($location == $sitemap_array[$point-1]["location"])
	{
		unset($result[$point-1]);
		$point--;
		$time2 = max($time2, $time);
	}
	
	$time = $time2;

	return $time;
}

function get_sitemap_location($page_id, $language_code)
{
	$loc = '';
//	$loc = htmlentities(get_href($page_id, $language_code));
	$loc = get_href($page_id, $language_code);
//var_dump($loc);
	$loc = preg_replace("'(?<!:)//'is", '/', $loc);		

	return $loc;
}

/**
 * Generate OBJECT SITEMAP array
 *
 *
 * @param $addsExcludeRule array Applied for extended excluding of objects link from sitemap.
 * Example: You want exclude from sitemap "Flexstore shop" object links by some parameter "visible"
 * So, you must define $addsExcludeRule as array('<%:object_name%>' => array(<%:object_field%> => <%:value%>));
 *
 */
function get_object_sitemap($added_GET_vars='', $page_rule='', $addsExcludeRule=array())
{
	global $default_language, $language;

	$sql_language_and = ((get('t') && $language) ? ' AND v_language.language_code ='.sqlValue($language) : '');

	$sql = 'SELECT
			object_record.id	as object_id,
			object_record.object_id as i_object_id,
			tpl_files.id		as object_view_id,
			tpl_files.file_name	as object_view,
			object_record.last_update	as edit_date,
			v_language.language_code	as language_code
		FROM
			object_template

		INNER JOIN
			object_record

		USING(object_id)
			INNER JOIN
				tpl_files
			ON 
				object_template.template_id = tpl_files.id

			INNER JOIN
				object
			ON 
				object_template.object_id = object.id,

			v_language
		WHERE
			v_language.status = \'1\'
			'.$sql_language_and.'
		ORDER BY
			object_id,
			object_view,
			language_code';
	
	$rs = ViewSQL($sql,0);

	$result= array();
	$ind = 0;
	while($r = db_sql_fetch_assoc($rs))
	{
		if (	check_exclude_object_by_tpl($r['i_object_id'], $r['object_view_id']) == 0 &&
			check_exclude_object_by_var($addsExcludeRule, $r['i_object_id'], $r['object_id']) == 0
		)
		{
			if(check_obj_cache($r['object_id'], $r['object_view'].$r['language_code'].'sitemap_links'))
			{		
				$loc = get_obj_cache($r['object_id'], $r['object_view'].$r['language_code'].'sitemap_links');
			}
			else
			{
				$loc = htmlentities(EE_HTTP_SERVER.EE_HTTP_PREFIX.get_default_alias_for_object($r['object_id'], $r['object_view'], $added_GET_vars, $page_rule, $r['language_code']));
				cache_obj($r['object_id'], $r['object_view'].$r['language_code'].'sitemap_links', $loc);
			}
	
			$loc = preg_replace("'(?<!:)//'is",'/',$loc);
			$edit_time = $r['edit_date'];
			$edit_time = (empty($edit_time)?0:strtotime($edit_time));
       	
			$result[$ind]["location"] = urlencode_list($loc);
			$result[$ind++]["lastmod"] = date("Y-m-d",$edit_time);
		}
	}
	return $result;
}

/**
* If you want to list more than 50,000 URLs (or 10MB (10,485,760) when uncompressed), you must create multiple Sitemap files.
*
*
*/
function print_sitemapindex($tpl)
{
	// create simple *.gz sitemap files
	$filename_arr = create_sitemap_gz_files();
	for($i = 0; $i < count($filename_arr); $i++)
	{
		$new_array[$i]['loc'] 		= $filename_arr[$i];
		$new_array[$i]['lastmod'] 	= date("Y-m-d");
	}
	return parse_array_to_html($new_array, $tpl);
}

/**
*  Cenerate Sitemap simple file.
*
*  @return array *.gz sitemap filename
**/
function create_sitemap_gz_files()
{
	$result_array = array();
	$result_array = array_merge($result_array, get_satellite_sitemap());
	$result_array = array_merge($result_array, get_object_sitemap());

	// Если в массиве более SITEMAP_LIMIT_URLS (50000) URLs, то разбиваем массив
	$count_arr = count($result_array);
	
	if($count_arr > EE_SITEMAP_LIMIT_URLS)
	{
		$chunked_arr = array_chunk($result_array, EE_SITEMAP_LIMIT_URLS);
		$count_sitemap = count($chunked_arr);
		if($count_sitemap > EE_SITEMAP_NUMBER)
		{
			$count_sitemap = EE_SITEMAP_NUMBER;
		}
	}
	else
	{
		$chunked_arr[] = $result_array;
		$count_sitemap = count($chunked_arr);
	}

	for($i = 0; $i < $count_sitemap; $i++)
	{
		$arr = $chunked_arr[$i];

		$sitemap_filename = 'sitemap'.($i + 1).'.xml.gz';

		if(sitemap_array_to_file($arr, $sitemap_filename))
		{
			$sitemap_gz_filename_arr[] = $sitemap_filename;
		}
	}
	return $sitemap_gz_filename_arr;
}

/**
*  @param array $array			- source array that will be convert to file $filename.
*  @param str $filename			- filename that will be create
*
**/
function sitemap_array_to_file($array, $filename)
{
	$source = '<?xml version="1.0" encoding="UTF-8"?>';
	$source .= '<urlset xmlns="http://www.google.com/schemas/sitemap/0.84">';
	$source .= parse_array_to_html($array, 'sitemap_entry');
	$source .= '</urlset>';

	if (touch_dir(EE_SITEMAPINDEX_PATH))
	{
		if($gz = gzopen(EE_SITEMAPINDEX_PATH.$filename, 'w9'))
		{
			gzwrite($gz, $source);
			gzclose($gz);
			return true;	
		}
	}
	return false;
}

/**
*  Clean sitemapindex directory
*
**/
function sitemapindex_files_delete()
{
	if (touch_dir(EE_SITEMAPINDEX_PATH))
	{
		if ($dh = opendir(EE_SITEMAPINDEX_PATH))
		{
			while ($file = readdir($dh))
			{
				delete_file(EE_SITEMAPINDEX_PATH.$file);
			}

			closedir($dh);
		}
	}
}


//$ar_list - one string or array of string in which we must perform replace
//$searches - one element or array of elements what must be encoded in string
function urlencode_list($string, $searches = ' ')
{
	if (!is_array($searches))
	{
		$searches = array($searches);
	}

	$replaces = array_map('rawurlencode', $searches);

	if (!is_array($string))
	{
		$string = str_replace($searches, $replaces, $string);
	}
	else
	{
		for ($i = 0; $i < sizeof($string); $i++)
		{
			$string[$i] = str_replace($searches, $replaces, $string[$i]);
		}
	}

	return $string;
}

function check_exclude_object($object_id)
{
	$sitemap_obj_conf = unserialize(config_var('sitemap_obj_config'));

	if (isset($sitemap_obj_conf[$object_id]))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

function check_exclude_object_by_tpl($object_id, $object_tpl)
{
	$sitemap_obj_conf = unserialize(config_var('sitemap_obj_config'));

	if (!is_array($sitemap_obj_conf[$object_id]))
	{
		$sitemap_obj_conf[$object_id] = array();
	}

	if (in_array($object_tpl, $sitemap_obj_conf[$object_id]))
	{
		return 1;

	}
	else
	{
		return 0;
	}
}

function check_exclude_object_by_var($addsExcludeRule, $object_id, $record_id)
{
	$ret = 0;

	foreach ($addsExcludeRule as $excludeObjectName => $params)
	{
		if (Get_object_id_by_name($excludeObjectName) == $object_id)
		{
			foreach($params as $key => $val)
			{
				$val2 = '';
       	
				if ($object_field_id = Get_object_field_id_by_name($key, $object_id))
				{
					$sql = 'SELECT
							value
					 	  FROM
							object_content
						 WHERE 
							object_record_id='.sqlValue($record_id).' 
							AND 
							object_field_id='.$object_field_id;
		
					$val2 = getField($sql);
				}

				if (is_array($val) && in_array($val2, $val))
				{
					$ret = 1;
					break;
				}
				else if (!is_array($val) && $val2 == $val)
				{
					$ret = 1;
					break;
				}
			}
		}
		else
		{
			break;
		}
	}

	return $ret;
}

