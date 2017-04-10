<?php
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL.
* http://www.2k-group.com
*/

$modul = basename(__FILE__, '.php');

if (!isset($op))
{
	$op=0;
}
//********************************************************************
include_once('../lib.php');
//********************************************************************
if (!CheckAdmin() or $UserRole!=ADMINISTRATOR)
{
	echo parse('norights');
	exit;
}
//vdump($language);
//vdump($_GET['language']);
$t = $_GET['t'];
$op = ( empty($op) ? 0 : $op );
$pr_id = $_GET['pr_id'];

global $page_dependent;
global $language;

if (empty($i_name))
{
	$close=true;
}

	/*
	** Creates or updates media structure
	*/
	function manage_picture_vars($picture_name, $picture_vars = array())
	{

		if (!empty($picture_vars))
		{
			// strange code in general...
			$db_pictures_vars = unserialize(cms($picture_name, 0, '', 1, 0));
			$db_pictures_vars['link'] = $picture_vars['link'];
			$picture_vars = $db_pictures_vars;
			save_cms($picture_name, serialize($picture_vars), 0, '');
		}
		else
		{
			if ($ar_picture_vars = cms($picture_name, 0, '', 1, 0))
			{
				$picture_vars = unserialize($ar_picture_vars);
			}
		}
		return $picture_vars;
	}
        /*
	** Initialize media (picture) link properties like
	*/
	function init_vars()
	{
		global $lang, $picture_vars, $size_y, $size_x, $size_default_x, $size_default_y;
		global $default_language, $i_name, $default_language, $size_default, $t;
		global $image_link, $open_same, $open_new, $image_sat, $url_text, $nmediaid, $page_dependent;
		//
		global $media_title, $language;

		//Gets media name to initialize media properties in edit window.
		$media_insret_data = unserialize(cms('media_inserted_'.$i_name, $page_dependent == 1 ? $t : 0, '', 1, 0));

		if ($media_insret_data !== false )
		{
	        	$media_name = 'media_'.$media_insret_data['media_id'];
	                //$media_name = 'media_'.getField('SELECT val FROM content WHERE var =\'media_inserted_'.$i_name.'\'');

			$picture_vars = manage_picture_vars($media_name);

			$image_link = $media_insret_data['link']['type'];
			if (!$image_link)
				$image_link = 'open_none';
			elseif($image_link == 'open_url')
				$url_text = $media_insret_data['link']['url'];
			elseif($image_link == 'open_sat_page')
				$image_sat = $media_insret_data['link']['sat'];

			if ($media_insret_data['link']['opentype'] == '_blank')
			{
				$open_new = 'selected';
				$open_same = '';
			}
			else
			{
				$open_new = '';
				$open_same = 'selected';
			}

			// media_title, depend on language
			$media_title = cms('media_title_'.$i_name, $page_dependent == 1 ? $t : 0, $language, 1, 0);
			//media_title
			//$media_insret_data['link']['media_title'] = $media_title;

			//INIT XITI-attributes
			if(EE_LINK_XITI_ENABLE)
			{
				global $xitiClickType, $xitiS2, $xitiLabel;
				$xitiClickType	= isset($media_insret_data['link']['xitiClickType']) ? $media_insret_data['link']['xitiClickType'] : '';
				$xitiS2		= isset($media_insret_data['link']['xitiS2']) ? $media_insret_data['link']['xitiS2'] : '';
				$xitiLabel	= isset($media_insret_data['link']['xitiLabel']) ? $media_insret_data['link']['xitiLabel'] : '';
			}
		}
	}

	function print_preview_source($id)
	{
		global $admin, $get_as_tag, $is_preview, $t;

		$admin=0;
		$get_as_tag=1;
		$is_preview=1;
		$t=$id;

		$ret = str_replace("\r"," ",js_clear(parse_media($id)));
		$ret = trim(str_replace("\n"," ",$ret));
		return $ret;

		$admin=1;
	}

if ($op == 'get_preview' && !empty($pr_id))
{
	echo print_preview_source($pr_id);
	exit;
}
else
{
  init_vars();
}

if(empty($close))
{
	if($save)
	{

		/*
		** Saves media link properties to media structure.
		*/
		if ($open_none != '')
		{
			$media_insret_data['link']['type'] = 'open_none';
		}
		elseif ($open_url != '')
		{
			$media_insret_data['link']['type'] = 'open_url';
			$media_insret_data['link']['url'] = $f_url_text;
		}
		elseif ($open_sat_page != '')
		{
			$media_insret_data['link']['type'] = 'open_sat_page';
			$media_insret_data['link']['sat'] = $satelit;
		}
		$media_insret_data['link']['opentype'] = $open_type;

		//Adding xiti-attributes
		if(EE_LINK_XITI_ENABLE)
		{
			$media_insret_data['link']['xitiClickType']	= post('xitiClickType');
			$media_insret_data['link']['xitiS2']		= post('xitiS2');
			$media_insret_data['link']['xitiLabel']		= post('xitiLabel');
		}

		// media title
		$media_title = post('media_title');
		//$media_insret_data['link']['media_title'] = post('media_title');


		//Absolute URL syntax checking
		if (!empty($f_url_text) && (!preg_match("/^(https?://|javascript:)/i", $f_url_text) ))
		{
			$url_syntax_error = true;
			$image_link = 'open_url';
		}
		else
		{
			//manage_picture_vars('media_'.$nmediaid, $picture_vars);
			$media_insret_data['media_id'] = $nmediaid;
			$media_insret_data = serialize($media_insret_data);

			/*
			** “.к. картинка медии не зависит от €зыка, четвертый параметр функции save_cms (,,,lng), передаем пустую строку.
			*/
			//  огда медиа странице-независима, то как ID должен передаватс€ ноль "0", а не пуста€ строка "''"
			save_cms('media_inserted_'.$i_name, $media_insret_data, ( $page_dependent==1 ? $t : 0 ), '', 'Media id for object '.$i_name.' on page '.( $page_dependent==1 ? $t : '' ));

			// media title, depend on language
			save_cms('media_title_'.$i_name, $media_title, ($page_dependent == 1 ? $t : 0), $language, 'Media id for object '.$i_name.' on page '.( $page_dependent==1 ? $t : '' ));

			if(check_cache_enabled())
   			{     
				$aliase = get_default_aliase_for_page($nmediaid);
				$full_aliase = get_full_name_cache_from_aliase($aliase);
				// if file not deleted in /cache - try delete file in /cache/limit_cache
				if(!delete_file($full_aliase))
				{
					delete_file(get_full_name_cache_from_aliase($aliase, '', true));
				}
			}
			header('Location: img.php?close=true');
			exit;
		}
	}

	/*
	** “.к. картинка медии не зависит от €зыка, третий параметр функции cms (,,language), передаем пустую строку.
	*/

	$__media_insert_data = unserialize(cms('media_inserted_'.$i_name, ( $page_dependent==1 ? $t : '' ), '', 1, 0));
	$__media_insert_data['link']['media_title'] = cms('media_title_'.$i_name, $page_dependent == 1 ? $t : 0, $language, 1, 0);

	$cur_id = $__media_insert_data['media_id'];

	$cur_media_sql = 'SELECT 
				CONCAT_WS(\'/\', IF(`folder` = \'/\', \'\', `folder`),`media_name`) AS media_name 
			FROM 
				v_media_grid 
			WHERE 
				id=' . sqlValue($cur_id) . ' 
				AND 
				language=' . sqlValue($language);
	global $current_media;
	$current_media = getField($cur_media_sql);

	echo parse_popup($modul.'/list');

}
else
{
	echo '<script language="JavaScript">window.parent.closePopup(\'yes\');</script>';
}
?>