<?php
/**
 * Module with folders functionality
 *
 * @package engineExpress
 * @version 1.0.0.0
 */


/**
 * Updates folders hierarhi
 *
 */
function update_folder_hierarhi($delete = true)
{
	if ($delete)
	{
		RunSQL('DELETE FROM content WHERE var = "folder_path_"', 0);
		// delete sitemap.xml cache
		delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
	}

	$rows = ViewSQL('SELECT id, language FROM v_tpl_folder_content', 0);

	while ($row = db_sql_fetch_assoc($rows))
	{
		$folder_id = $row['id'];
		$folder_path = trim((f_get_folder_path($folder_id, $row['language'])),'/');
		save_cms('folder_path_' . $folder_id, $folder_path, 0, $row['language']);

		if (config_var('use_draft_content') == 1)
		{
			publish_cms_on_page(0, 'folder_path_', $folder_id);
		}
	}
}

/**
 * Function for recursivly building folder path
 *
 * @param int $__folder_id
 * @param string $__lang
 * @return string
 */
function f_get_folder_path($__folder_id, $__lang)
{
	$row = db_sql_fetch_assoc(ViewSql('
		SELECT page_name as folder_name, folder_id as parent_folder
		FROM v_tpl_folder_content
		WHERE id = '.sqlValue($__folder_id).'
			AND language = '.sqlValue($__lang), 0));
	$parent_id = $row['parent_folder'];
	$folders = array();
	$folders[] = $row['folder_name'];

	while ($parent_id != NULL || $parent_id != 0)
	{
		$row = db_sql_fetch_assoc(ViewSql('
			SELECT page_name as folder_name, folder_id as parent_folder
			FROM v_tpl_folder_content
			WHERE id = ' . sqlValue($parent_id).'
			AND language = '.sqlValue($__lang), 0));
		$parent_id = $row['parent_folder'];
		$folders[] = $row['folder_name'];
	}
	return implode('/', array_reverse($folders));
}


