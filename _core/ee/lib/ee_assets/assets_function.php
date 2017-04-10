<?php
//function returns ids of content which situated in specified folder
function print_next_previous_buttons()
{
	if(empty($_GET['for_search']))
	{
	global $langEncode, $previous_type, $next_type, $previous_id, $next_id, $popupHeight;
	$return = '';
	if(!isset($_COOKIE['_assets_expand_folder_id'])) $_COOKIE['_assets_expand_folder_id'] = 0;//?
	if(isset($_COOKIE['_assets_expand_folder_id']) && isset($_GET['prev_next']))
	{
		$sql = '';
		$where = ' WHERE folder_id'.((($_COOKIE['_assets_expand_folder_id']) == 0)?' IS NULL':' = '.sqlValue($_COOKIE['_assets_expand_folder_id']));
		$folder_pos = 'IF(folder_id IS NOT NULL, folder_id, 0) AS folder_pos';
		if(!empty($_COOKIE['_assets_display_medias']))
		{
			$where = '';
			$folder_pos = '0 AS folder_pos';
		}

		if (empty($_COOKIE['_assets_display_medias']) || (isset($_COOKIE['_assets_display_medias']) && $_COOKIE['_assets_display_medias'] != 'medias'))
			$sql = 'SELECT DISTINCT id, '.$folder_pos.', "_tpl_page" AS type FROM v_tpl_page_content'.$where;
		
		if($sql != '')
			$sql .= ' UNION ';
		
		if (empty($_COOKIE['_assets_display_medias']) || (isset($_COOKIE['_assets_display_medias']) && $_COOKIE['_assets_display_medias'] != 'pages'))
			$sql .= 'SELECT DISTINCT id, '.$folder_pos.', "_media" AS type FROM v_media_content'.$where;
		
		if($sql != '')
			$sql .= ' ORDER BY type, folder_pos, id';
		
		$rs = ViewSQL($sql);
		if(db_sql_num_rows($rs)>0)
		{
			$current_type = '';
			$previous_find = 0;
			$next_find = 0;
			$previous_id = '';
			$next_id = '';
			$previous_type = '';
			$next_type = '';
			while($res = db_sql_fetch_assoc($rs))
			{
				if($next_find)
				{
					$next_id = $res['id'];
					$next_type = $res['type'];
					$next_find = 0;
					break;
				}
				if($res['id'] == $_GET['edit'])
				{
					$current_type = $res['type'];
					$next_find = 1;
					$previous_find = 1;
				}
				if(!$previous_find)
				{
					$previous_id = $res['id'];
					$previous_type = $res['type'];
					$previous_find = 0;
				}
			}
			if($previous_id != '')
				$return .= parse_tpl('_assets/previous_button');//<a href="'.EE_ADMIN_URL.$previous_type.'.php?op=1&edit='.$previous_id.'&admin_template=yes&prev_next=1">'.ASSETS_PREVIOUS.'</a>
			
			if($next_id != '')
				$return .= parse_tpl('_assets/next_button');//<a href="'.EE_ADMIN_URL.$next_type.'.php?op=1&edit='.$next_id.'&admin_template=yes&prev_next=1">'.ASSETS_NEXT.'</a>';
			
			//Count height of page properties windows
			$popupHeight = '600';
			if($current_type =='_media')//Medias
			{
				$media_count_of_edit_fields = count(@db_sql_table_fields('v_media_edit'));
				$popupHeight = ($media_count_of_edit_fields+count($langEncode)+1)*30;//add 20px to height due to previous/next i
			}
			else if($current_type == '_tpl_page')//Pages
			{
				$page_count_of_edit_fields = count(@db_sql_table_fields('v_tpl_page_edit'));
				$popupHeight = ($page_count_of_edit_fields+count($langEncode)+4)*30 + 33;//add 33px due to tabs
			}
			//Folders
			$folder_popup_height = 500;
			$js = parse_tpl('_assets/height_js');
			
			$return = $return.$js;
		}
	}
	
	return $return;
	}
}
?>