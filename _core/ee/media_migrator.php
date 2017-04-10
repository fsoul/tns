<?php

/**
 * 	Media inserts Migrator
 *
 * @version 1.0.0.0
 * @author Alexandr Rusakevich
 *
 */

include_once './lib.php';

$__old_media_inserts = '
	select c.var in_name, c.var_id vid, c.page_id, c.val as mid,c1.val ar from content c
	  LEFT JOIN content c1 ON c1.var = "media_" && c1.var_id = c.val
	where c.var like "media_insert_%"
';


$res = ViewSQL($__old_media_inserts, 1);

while ($row = db_sql_fetch_assoc($res))
{
	$__m_data = unserialize($row['ar']);
	$__m_data['link'] = $__m_data['link'];
	$__m_data['media_id'] = $row['mid'];
	$__var_name = str_replace('media_insert_', 'media_inserted_',$row['in_name']);
	if (cms($__var_name.$row['vid'],$row['page_id']) == '' && is_numeric($row['mid']))
	{
		save_cms($__var_name.$row['vid'],serialize($__m_data),$row['page_id']);
		msg('"'.$row['in_name'].$row['vid'].'" => "'.$__var_name.$row['vid'].'" success!', 'Migration');
	}
	else
		msg('"'.$row['in_name'].$row['vid'].'". "'.$__var_name.$row['vid'].'" already exists', 'Skiped');
}

die('Good');

