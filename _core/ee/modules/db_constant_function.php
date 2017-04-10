<?php

/**
 *
 * If it is necessary to obtain from DB some data, unchangable during one connection
 * - it is better to store this data to the constant.
 *
 * Use this function instead of simple constants pre-definition to prevent situation
 * when constant will not be used in whole executed code
 * and so DB-query would be used in vain.
 *
 * @param string Name of constant to store some database value in it
 * @return mixed Result of some DB-query execution (should be prevently added to array $ar_db_queries)
 */
function db_constant($constant_name)
{
	$ar_db_queries = array
	(
		'DEFAULT_TPL_VIEW_ID'	=>	'SELECT id FROM tpl_views WHERE is_default=1',
		'DEFAULT_TPL_VIEW_FOLDER'	=>	'SELECT view_folder FROM tpl_views WHERE is_default=1'
	);

	$constant_name = strtoupper($constant_name);

	if (	!defined($constant_name) &&
		array_key_exists($constant_name, $ar_db_queries)
	)
	{
		define($constant_name, getField($ar_db_queries[$constant_name]));
	}

	return constant($constant_name);
}


