<?php

define('EE_URL_MAPPING_OBJECT_TABLE', 'url_mapping_object');
define('EE_URL_MAPPING_OBJECT_FIELD', 'map_url');
define('EE_URL_MAPPING_OBJECT_FIELD_PREFIX', 'map_url_');

function f_add_map_url($targetURL, $language, $tplView, $objectRecordId, $objectView)
{
	$f	= array('target_url' => $targetURL);
	if (is_url_map_exists($f))
	{
		return -1;
	}
	if (page_exists($targetURL))
	{
		return -2;
	}
	
	if ((int)$tplView == 0)
	{
		$tplView 	= get_tpl_view_id($tplView);
	}

	$source_url 	= um_get_source_url($language, $tplView, $objectRecordId, $objectView);

	if ((int)$objectView == 0)
	{
		$objectView	= get_tpl_file_id($objectView);
	}

	$sql = 'INSERT INTO
			'.EE_URL_MAPPING_OBJECT_TABLE.'
		SET
			target_url='.sqlValue($targetURL).',
			language='.sqlValue($language).',
			tpl_view='.($tplView == '' ? 'NULL' : sqlValue($tplView)).',
			object_record_id='.sqlValue($objectRecordId).',
			object_view='.sqlValue($objectView);

	f_add_permanent_redirect_object($source_url, $targetURL, $objectView);

	return RunSQL($sql);
}

function f_upd_map_url($targetURL, $language, $tplView, $objectRecordId, $objectView)
{
	$ret = false;
	
	if (page_exists($targetURL))
	{
		return -2;
	}

	$tplView 	= ((int)$tplView == 0 ? get_tpl_view_id($tplView) : $tplView);
	$objectView 	= ((int)$objectView == 0 ? get_tpl_file_id($objectView) : $objectView);

	$old_target_url = get_map_url($language, $tplView, $objectRecordId, $objectView);

	$sql = 'UPDATE
			'.EE_URL_MAPPING_OBJECT_TABLE.'
		SET
			target_url='.sqlValue($targetURL).'
		WHERE
			language='.sqlValue($language).'
			AND
			tpl_view'.($tplView == '' ? ' IS NULL' : ' = '.sqlValue($tplView)).'
			AND
			object_record_id='.sqlValue($objectRecordId).'
			AND
			object_view='.sqlValue($objectView);

	$ret = runSQL($sql);

	if ($ret)
	{
		f_upd_permananet_redirect_object($old_target_url, $targetURL);
	}

	return $ret;
}

function f_del_map_url($language, $tplView, $objectRecordId, $objectView)
{
	$tpl_view_su	= $tplView;
	$object_view_su = $objectView;

	$tplView 	= ((int)$tplView == 0 ? get_tpl_view_id($tplView) : $tplView);
	$objectView 	= ((int)$objectView == 0 ? get_tpl_file_id($objectView) : $objectView);

	$sql = 'DELETE FROM
				'.EE_URL_MAPPING_OBJECT_TABLE.'
			WHERE
				language='.sqlValue($language).'
				AND
				tpl_view'.($tplView == '' ? ' IS NULL' : ' = '.sqlValue($tplView)).'
				AND
				object_record_id='.sqlValue($objectRecordId).'
				AND
				object_view='.sqlValue($objectView);

	$ret = runSQL($sql);

	if ($ret)
	{
		$source_url = um_get_source_url($language, $tpl_view_su, $objectRecordId, $object_view_su);
		f_del_permanent_redirect_object(false, $source_url);
	}

	return $ret;
}

function f_save_map_url($targetURL, $language, $tplView, $objectRecordId, $objectView)
{
	$ret = false;

	if (trim($targetURL) == '')
	{
		$ret = f_del_map_url($language, $tplView, $objectRecordId, $objectView);
	}
	else if (page_exists($targetURL))
	{
		return -2;
	}
	else
	{
		$f = array(
				'language'		=> $language,
				'tpl_view'		=> get_tpl_view_id($tplView),
				'object_record_id'	=> $objectRecordId,
				'object_view'		=> get_tpl_file_id($objectView)
				);

		if (is_url_map_exists($f))
		{
			$ret = f_upd_map_url($targetURL, $language, $tplView, $objectRecordId, $objectView);
		}
		else
		{
			$ret = f_add_map_url($targetURL, $language, $tplView, $objectRecordId, $objectView);
		}
	}

	return $ret;
}

function is_map_url($URL)
{
	$ret 	= false;
	$URL	= parse_url($URL, PHP_URL_PATH);
	$f	= array('target_url' => $URL);

	if (is_url_map_exists($f))
	{
		$ret = true;
	}

	return $ret;
}

function is_url_map_exists($field_values)
{
	$ret = false;

	$sql = 'SELECT
			id
		FROM
			'.EE_URL_MAPPING_OBJECT_TABLE.'
		WHERE '."\r\n";

	foreach ($field_values as $key => $val)
	{
		$sql_where[] = $key.($val == '' ? ' IS NULL' : ' = '.sqlValue($val))."\r\n";
	}

	$where = implode(' AND ', $sql_where);

	$res = viewSQL($sql.$where);

	if (db_sql_num_rows($res) > 0)
	{
		$ret = true;
	}

	return $ret;
}

function get_url_map_field_details($field)
{
	$res = false;

	if (strpos($field, EE_URL_MAPPING_OBJECT_FIELD_PREFIX) === 0)
	{
		$res = array();

		$res['tpl_view'] 	= substr($field, strlen(EE_URL_MAPPING_OBJECT_FIELD_PREFIX));
		$res['field_name'] 	= EE_URL_MAPPING_OBJECT_FIELD;
	}

	return $res;
}

/* $t_view may t_view_name||t_view_id */
function get_map_url($lang, $t_view, $object_record_id, $object_view)
{
	global $language;
	$t_view_id 	= ((int)$t_view == 0 ? get_tpl_view_id($t_view) : $t_view);
	$object_view 	= ((int)$object_view == 0 ? get_tpl_file_id($object_view) : $object_view);

	$lang = (!isset($lang) || $lang == '') ? $language : $lang;

	$ret = false;

	$sql = 'SELECT 
			target_url
		FROM
			'.EE_URL_MAPPING_OBJECT_TABLE.' 
		WHERE
			language='.sqlValue($lang).'
			AND
			tpl_view'.($t_view_id == '' ? ' IS NULL' : ' = '.sqlValue($t_view_id)).'
			AND
			object_record_id='.sqlValue($object_record_id).'
			AND
			object_view='.sqlValue($object_view);

	if ($result = getField($sql))
	{
		$ret = $result;
	}

	return $ret;
}

function set_map_url_params($URL, &$language, &$tpl_view, &$object_record_id, &$object_view)
{
	$ret = false;

	$sql = 'SELECT
			language,
			tpl_view,
			object_record_id,
			object_view
		FROM
			'.EE_URL_MAPPING_OBJECT_TABLE.'
		WHERE
			target_url='.sqlValue($URL);

	$res = viewSQL($sql);

	if (db_sql_num_rows($res) > 0)
	{
		$row = db_sql_fetch_assoc($res);
		
		$language 		= $row['language'];
		$tpl_view 		= $row['tpl_view'];
		$object_record_id	= $row['object_record_id'];
		$object_view 		= $row['object_view'];

		if ($tpl_view == db_constant('DEFAULT_TPL_VIEW_ID'))
		{
			$tpl_view = false;
		}

		$ret = true;
	}
	
	return $ret;
}

function um_get_source_url($language, $tplView, $objectRecordId, $objectView)
{
	$source_url = false;

	if ((int)$tplView != 0)
	{
		$tplView	= get_system_view_name($tplView);
	}

	$tplView = (get_tpl_view_folder($tplView) == db_constant('DEFAULT_TPL_VIEW_FOLDER') ? '' : $tplView);

        $source_url = get_default_alias($objectRecordId, $objectView, '', $language, $tplView, '');

	return $source_url;
}



