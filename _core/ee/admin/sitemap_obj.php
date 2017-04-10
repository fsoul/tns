<?php
	$modul='sitemap_obj';

	include_once('../lib.php');

	if (!CheckAdmin() || $UserRole != ADMINISTRATOR)
	{
		echo parse('norights');
		exit;
	}


	function get_object_list($tpl, $error = 1)
	{
		global $modul;

		$sql = 'SELECT 
				o.*
			  FROM 
				object o
		    INNER JOIN
				object_template ot
			    ON
				o.id = ot.object_id
		      GROUP BY
				o.id';

		$res = viewSQL($sql);

		if (db_sql_num_rows($res) > 0)
		{
			$ret = parse_sqlres_to_html($res, $tpl);
		}
		else
		{
			$ret = ($error == 1 ? 'No any object. Visit <a href=_object.php>\'Object Managment\'' : '');
		}

		return $ret;
	}

	function get_object_templates($obj_id)
	{
		global $modul;

		$ret = 'No templates.';

		$sql = 'SELECT
				tpl_files.id AS tpl_id,
				object_template.object_id,
				tpl_files.file_name
			  FROM 
				object_template
		     LEFT JOIN
				tpl_files
			    ON
				tpl_files.id = object_template.template_id
			 WHERE
				object_template.object_id = '.sqlValue($obj_id);

		$res = viewSQL($sql);

		if (db_sql_num_rows($res) > 0)
		{
				$ret = parse_sqlres_to_html($res, $modul.'/template_list_row');
		}

		return $ret;
	}

	if (isset($_POST['reload']))
	{
		$sitemap_config = serialize($_POST['object_tpls']);

		save_config_var('sitemap_obj_config', $sitemap_config);

		echo '	<script language="">
				window.parent.closePopup(\'yes\');
			</script>';
	}
	else
	{
		echo parse_popup($modul.'/list', '', false);
	}

?>