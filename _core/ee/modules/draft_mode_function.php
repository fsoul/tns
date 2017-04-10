<?

define ('SQL_PUBLISH_CONTENT',

' UPDATE content

     SET val = val_draft,
         edit_date = NOW()

   WHERE val_draft IS NOT NULL
     AND ( val <> val_draft COLLATE utf8_bin
           OR
           val IS NULL
         )
');

define ('SQL_REVERT_CONTENT',

' UPDATE
         content
     SET
         val_draft = val,
         edit_date_draft = NOW()
   WHERE
         (
	   val <> val_draft COLLATE utf8_bin
           OR
           (
             val_draft IS NULL AND val IS NOT NULL
           )
           OR
           (
             val_draft IS NOT NULL AND val IS NULL
           )
         )
');

define ('SQL_UPDATE_EDIT_USER',

' UPDATE
         content
     SET
         val = %1$s,
         val_draft = %1$s
   WHERE
         var = "edit_user"
');


function publish_revert_cms($sql_content, $sql_user = null)
{
	if (CheckAdmin())
	{
		runsql($sql_content, 0);

		if ($sql_user != null)
		{
			runsql($sql_user, 0);
		}
	}
}


function publish_cms_all()
{
	publish_revert_cms(SQL_PUBLISH_CONTENT, vsprintf(SQL_UPDATE_EDIT_USER, array(sqlValue(session('login')))));
	publish_media_all();
}

function publish_cms_on_page($page_id, $var=null, $var_id=null)
{
	// Cut media ids
	// as in content table under media ids may present different content 
	// (example from raymond-weil.com: page_id=733, var=media_*)
	$page_id = cut_media_ids($page_id);

	if (is_array($page_id))
	{
		$sql_page_id = ' AND page_id IN (' . sqlValuesList($page_id) . ')';
	}
	else
	{
		$sql_page_id = ' AND page_id = '.sqlValue($page_id);
	}

	if (is_null($var))
	{
		$sql_var = '';
	}
	else
	{
		$sql_var = ' AND var = '.sqlValue($var);
	}

	if (is_null($var_id))
	{
		$sql_var_id = '';
	}
	else
	{
		$sql_var_id = ' AND var_id = '.sqlValue($var_id);
	}

	publish_revert_cms(SQL_PUBLISH_CONTENT.$sql_page_id.$sql_var.$sql_var_id, vsprintf(SQL_UPDATE_EDIT_USER.$sql_page_id, array(sqlValue(session('login')))));
}

function publish_cms_common()
{
	publish_cms_on_page(0);
	publish_media_all();
}

function publish_all_cms() { publish_cms_all(); }
function publish_common_cms() {	publish_cms_common(); }

function revert_cms_all()
{
	publish_revert_cms(SQL_REVERT_CONTENT);
	revert_all_media();
}

function revert_cms_on_page($page_id)
{
	$page_id = cut_media_ids($page_id);

	if (is_array($page_id))
	{
		$sql_page_id = ' AND page_id IN (' . sqlValuesList($page_id) . ')';
	}
	else
	{
		$sql_page_id = ' AND page_id = '.sqlValue($page_id);
	}

	publish_revert_cms(SQL_REVERT_CONTENT.$sql_page_id);
}

function revert_cms_common()
{
	revert_cms_on_page(0);
	revert_all_media();
}

function revert_all_cms() { revert_cms_all(); }
function revert_common_cms() { revert_cms_common(); }



function publish_media_on_page($page_id)
{
	if (CheckAdmin())
	{
		$page_id = cut_media_ids($page_id);
		$arr = get_media_val_by_page($page_id);

		foreach ($arr as $v)
		{
			$__m_data = unserialize($v);
			list($var, $var_id) = get_var_id('media_'.$__m_data['media_id']);

			$where = '  AND val_draft IS NOT NULL
				    AND var='.sqlValue($var).'
				    AND var_id='.sqlValue($var_id);

			$sql = SQL_PUBLISH_CONTENT.$where;

			runsql($sql, 0);

			$picture_vars = media_manage_vars($v);
			if (is_array($picture_vars['images']))
			foreach ($picture_vars['images'] as $im)
			{
				if (get_media_picture_name($im) != $im)
				{
					httpDeleteFile(EE_MEDIA_FILE_PATH.$im);
					rename(EE_MEDIA_FILE_PATH.get_media_picture_name($im),EE_MEDIA_FILE_PATH.$im);
				}
			}
		}
	}
}

function revert_media_on_page($page_id)
{
	if (CheckAdmin())
	{
		$page_id = cut_media_ids($page_id);
		$arr = get_media_val_by_page($page_id);

		foreach ($arr as $v)
		{
			$__m_data = unserialize($v);

			$where = 'AND var='. sqlValue('media_'.$__m_data['media_id']);

			$sql = SQL_REVERT_CONTENT.$where;

			runsql($sql, 0);

			$picture_vars = media_manage_vars($v);
			if (is_array($picture_vars['images']))
			foreach ($picture_vars['images'] as $im)
			{
				if (get_media_picture_name($im) != $im) httpDeleteFile(EE_MEDIA_FILE_PATH.get_media_picture_name($im));
			}
		}
	}
}

function publish_media_all()
{
	if (CheckAdmin())
	{
		$arr = SQLField2Array(ViewSQL('SELECT CONCAT(\'media_\',id) FROM v_media',0));
		foreach ($arr as $v)
		{
			list($var, $var_id) = get_var_id($v);

			$where = '  AND val_draft IS NOT NULL
				    AND var='.sqlValue($var).'
				    AND var_id='.sqlValue($var_id);

			$sql = SQL_PUBLISH_CONTENT.$where;
			
			runSQL($sql, 0);

			$picture_vars = media_manage_vars($v);
			if (is_array($picture_vars['images']))
			foreach ($picture_vars['images'] as $im)
			{
				if (get_media_picture_name($im) != $im)
				{
					httpDeleteFile(EE_MEDIA_FILE_PATH.$im);
					rename(EE_MEDIA_FILE_PATH.get_media_picture_name($im), EE_MEDIA_FILE_PATH.$im);
				}
			}
		}
	}
}

function revert_media_all()
{
	if (CheckAdmin())
	{
		$arr = SQLField2Array(ViewSQL('SELECT CONCAT(\'media_\',id) FROM v_media', 0));
		foreach ($arr as $v)
		{
			list($var, $var_id) = get_var_id($v);

			$where = 'AND var='.sqlValue($var).'
				  AND var_id='.sqlValue($var_id);

			$sql = SQL_REVERT_CONTENT.$where;

			runSQL($sql, 0);

			$picture_vars = media_manage_vars($v);
			if (is_array($picture_vars['images']))
			foreach ($picture_vars['images'] as $im)
			{
				if (get_media_picture_name($im) != $im) httpDeleteFile(EE_MEDIA_FILE_PATH.get_media_picture_name($im));
			}
		}
	}
}

function cut_media_ids($page_id)
{
	if (is_array($page_id))
	{
		$page_ids 	= sqlValuesList($page_id);
		$arr_media 	= SQLField2Array(ViewSQL('SELECT id FROM v_media WHERE id IN (' . $page_ids . ')'));
		$page_id_array 	= array_diff($page_id, $arr_media);
	}

	return $page_id;
}

function get_media_val_by_page($page_id)
{
	$media_vals = array();

	if (is_array($page_id))
	{
		$sql_page_id = 'AND page_id IN (' . sqlValuesList($page_id) . ')';
	}
	else
	{
		$sql_page_id = 'AND page_id = ' . sqlValue($page_id);
	}

	$media_vals = SQLField2Array(ViewSQL('SELECT val FROM content c where var like \'media_inserted_%\' ' . $sql_page_id, 0));

	return $media_vals;
}

function is_page_draft($page_id)
{
	$ret = 0;

	$sql = 'SELECT 
			COUNT(page_id)
		FROM
			content
		WHERE 			
			(val <> val_draft COLLATE utf8_bin OR val IS NULL)
		AND
			content.page_id=\'0\'
		AND
			content.var=\'page_name_\'
		AND 
			content.var_id=' . sqlValue($page_id) . '
		AND 
			val_draft IS NOT NULL';

	if (getField($sql))
	{
		$ret = 1;
	}

	return $ret;
}

function publish_page($page_id)
{
	return publish_cms_on_page(0, 'page_name_', $page_id);
}

function publish_all_media() { publish_media_all(); }
function revert_all_media() { revert_media_all(); }

function publish_seo($is_object = false)
{
	$where = '  AND val_draft IS NOT NULL
		    AND var LIKE \''.($is_object ? 'obj_' : '').'meta_%\'';

	$sql = SQL_PUBLISH_CONTENT.$where;

	runsql($sql, 0);
}

function revert_seo($is_object = false)
{
	$where = '  AND val_draft IS NOT NULL
		    AND var LIKE \''.($is_object ? 'obj_' : '').'meta_%\'';

	$sql = SQL_REVERT_CONTENT.$where;

	runsql($sql, 0);
}

function is_seo_draft($page_id, $language, $tag, $is_obj = false)
{
	global $draft_tags;

	$ret = 0;

	if (!is_array($draft_tags))
	{
		$draft_tags = array();

		$check_draft_sql = 'SELECT
						page_id,
						var,
						language
				      FROM 
						content 
				     WHERE 
						var LIKE \'' . ($is_obj ? 'obj_' : '') . 'meta_%\' 
						AND val_draft IS NOT NULL 
						AND (
							val <> val_draft COLLATE utf8_bin
							OR 
							val IS NULL)';

		$check_draft_res = viewSQL($check_draft_sql);

		if (db_sql_num_rows($check_draft_res) > 0)
		{
			while ($row = db_sql_fetch_assoc($check_draft_res))
			{
				$_page_id = $row['page_id'];
				$_lang	 = $row['language'];
				$_tag	 = str_replace(($is_obj ? 'obj_' : '').'meta_', '', $row['var']);
       	
				$draft_tags[$_page_id][$_lang][] = $_tag;
			}
		}
	}

	if (	isset($draft_tags[$page_id][$language]) &&
		in_array($tag, $draft_tags[$page_id][$language])
	)
	{
		$ret = 1;
	}

	return $ret;
}


