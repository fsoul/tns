<?

function f_add_media($pMediaName, $pMediaDescription, $pTplId, $pFolderId, $pCachable)
{
	return f_add_tpl_page(media_name_normalize($pMediaName), 'html', $pMediaDescription, 0, $pTplId, $pFolderId, 0, 0, $pCachable, $_SESSION['UserId']);
}

function f_del_media($pId)
{
	$return = false;
	if(f_del_tpl_page($pId))
	{
		$return = true;
		//delete media files from harddisc
		$media_val = getField('SELECT val FROM content WHERE var = "media_" AND var_id="'.$pId.'"');
		$media_content = unserialize($media_val);
		f_del_media_file($media_content);
		runSql('DELETE FROM content WHERE var = "media_" AND var_id="'.$pId.'"');
	}
	return $return;
}

function f_del_media_file($media_content)
{
	if(is_array($media_content))
	{
		if(array_key_exists('images', $media_content))
		{
			foreach($media_content['images'] as $value)
			{
				$res[] = deleteFile(add_media_path($value));
			}
		}
	}
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/
function f_del_medias($pId)
{
	$return = false;
	if(is_array($pId))
	{
		if(f_del_tpl_pages($pId))
		{
			$return = true;
			//delete media files from harddisc
			$media_vals = viewSql('SELECT val FROM content WHERE var = "media_" AND var_id IN ('.sqlValuesList($pId, true).')');
			if(db_sql_num_rows($media_vals) > 0)
			{
				while($media_val = db_sql_fetch_assoc($media_vals))
				{
					$media_content = unserialize($media_val['val']);
					f_del_media_file($media_content);
				}
				runSql('DELETE FROM content WHERE var = "media_" AND var_id IN ('.sqlValuesList($pId, true).')');
			}
		}
	}
	else
	{
		$return = f_del_media($pId);
	}
	return $return;
}


function f_upd_media($pID, $pMediaName, $pMediaDescription, $pTplId, $pFolderId, $pCachable)
{
	return f_upd_tpl_page($pID, media_name_normalize($pMediaName), 'html', $pMediaDescription, 0, $pTplId, $pFolderId, 0, 0, $pCachable);
}

/**
 * Function media_name_normalize() replace all not allowed chars to "_" in media-name
 */
function media_name_normalize($pMediaName)
{
	return preg_replace('/[^0-9a-zA-Z\_\-]/', '_', $pMediaName);
}

