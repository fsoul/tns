<?
	if (count($_GET))
	{
		include_once('../lib.php');

		$modul = '_seo';

		if (!CheckAdmin() or $UserRole != ADMINISTRATOR)
		{
			echo parse('norights');
			exit;
		}

		$internal_id 	= $_GET['page_id'];
		$internal_var 	= $_GET['var'];
		$val 		= $_GET['val'];
		$lang  		= $_GET['language'];
		$object_view	= $_GET['obj_view'];
		$object_tpl_id 	= get_tpl_file_id($object_view);

		$val = urldecode($val);

		// bug_id=9293
		// save NULL instead of empty string for meta-tags
		$val = ( trim($val)=='' ? null : $val );

		$prefix = 'meta_';

		if (isset($_GET['obj_seo']))
		{
			$prefix = 'obj_'.$prefix;
		}

		if ($f_details = get_url_map_field_details($internal_var))
		{
			$internal_t_view 	= $f_details['tpl_view'];
			$internal_var		= $f_details['field_name'];
		}

		switch ($internal_var)
		{
			case EE_URL_MAPPING_OBJECT_FIELD:
				$val = prepare_source_url($val);
				if (f_save_map_url($val, $lang, $internal_t_view, $internal_id, $object_view) === -2)
				{
					echo 'PAGE_EXISTS';
				}
				else
				{
					echo '';
				}
				break;
			default:
				// notice that in ee.3.3 save_cms()-args "desc", "full_desc" and "get_var_id" has default values - null, null and 1 accordingly
				save_cms($prefix.$internal_var.($object_tpl_id ? $object_tpl_id : ''), $val, $internal_id, $lang);
				break;
		}
	}
?>