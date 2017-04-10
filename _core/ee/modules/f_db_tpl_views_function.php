<?php


function f_add_tpl_views($pViewName, $pViewFolder, $pViewDescription, $pViewIcon, $pIsDefault=false)
{
	if (empty($pViewName))
	{
		$pViewName = $pViewFolder;
	}

	if (empty($pViewDescription))
	{
		$pViewDescription = $pViewFolder;
	}
	
	if (db_sql_num_rows(ViewSQL('SELECT id FROM tpl_views WHERE view_name = '.sqlValue($pViewName))) > 0)
	{
		return -1;
	}

	if (db_sql_num_rows(ViewSQL('SELECT id FROM tpl_views WHERE view_folder = '.sqlValue($pViewFolder))) > 0)
	{
		return -2;
	}

	// if we need to set it as default one - 
	// we must previously unset current default view
	if ($pIsDefault)
	{
		// in real is_default can be not 1 but any other not null value
		// so, let we just unset all views except of just added
		RunSQL('UPDATE tpl_views SET is_default=NULL WHERE is_default IS NOT NULL');
	}

	$l_id = RunSQL(

	'INSERT INTO tpl_views
                 SET
                     view_name = '.sqlValue($pViewName).',
                     view_folder = '.sqlValue($pViewFolder).',
                     description = '.sqlValue($pViewDescription).',
                     icon = '.sqlValue($pViewIcon).',
                     is_default = '.( $pIsDefault ? '1' : 'NULL' )
	);

	return $l_id;
}

function f_del_tpl_views($pId)
{
	$is_default = getField('SELECT is_default FROM tpl_views WHERE id = '.sqlValue($pId));

	if ($is_default)
	{
		// default view can't be deleted
		$result = -1;
	}
	else
	{
		$del_img = getField('SELECT icon FROM tpl_views WHERE id = '.sqlValue($pId));

		RunSQL('DELETE FROM tpl_views WHERE id = '.sqlValue($pId));

		deleteFile($del_img);
		deleteFile('_'.$del_img);

		$result = 1;
	}

	return $result;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/
function f_del_tpl_viewss($ar_pId)
{
	$ar_res = array();

	if (is_array($ar_pId))
	foreach($ar_pId as $pId)
	{
		$ar_res[$pId] = f_del_tpl_views($pId);
	}

	return $ar_res;
}

function f_upd_tpl_views($pID, $pViewName, $pViewFolder, $pViewDescription, $pViewIcon, $pIsDefault=false)
{
	if (db_sql_num_rows(ViewSQL('SELECT id FROM tpl_views WHERE view_name = '.sqlValue($pViewName).' AND id <> '.sqlValue($pID))) > 0)
	{
		return -1;
	}

	if (db_sql_num_rows(viewSQL('SELECT id FROM tpl_views WHERE view_folder = '.sqlValue($pViewFolder).' AND id <> '.sqlValue($pID))) > 0)
	{
		return -2;
	}

	if ($pIsDefault)
	{
		RunSQL('UPDATE tpl_views SET is_default = NULL WHERE id <> '.sqlValue($pID));
	}

	// Notice, that you can't unset default view - set some other to default instead
	// and current default will be unsetted automatically (see code above)

	RunSQL(

	'UPDATE
                tpl_views
            SET
                view_name = '.sqlValue($pViewName).',
                view_folder = '.sqlValue($pViewFolder).',
                description = '.sqlValue($pViewDescription).',
                icon = '.sqlValue($pViewIcon).( $pIsDefault ? ',
                is_default = 1' : '').'
          WHERE
                id = '.sqlValue($pID)
	);

	return 1;
}

function get_tpl_view_id($view_name = '')
{
	$ret = false;

	$sql = 'SELECT
                       id
                  FROM
                       tpl_views

                 WHERE '.(empty($view_name) ? '
                       is_default = 1' : '
                       view_name = '.sqlValue($view_name)).'
	';

	if ($result = getField($sql))
	{
		$ret = $result;
	}

	return $ret;
}

function get_tpl_view_folder($view_name)
{
	return getField('SELECT view_folder FROM tpl_views WHERE view_name='.sqlValue($view_name));
}

function create_view_folder($view_folder)
{
	if (	touch_dir(EE_PATH.'templates/VIEWS') &&
		touch_dir(EE_PATH.'templates/VIEWS/'.$view_folder)
	)
	{
		$result = true;
	}
	else
	{
		$result = false;
	}

	return $result;
}

?>