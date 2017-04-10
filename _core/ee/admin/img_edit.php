<?
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL.
* http://www.2k-group.com
*/
	$modul='img_edit';
	if(!isset($op)) $op=0;

//********************************************************************
	include_once('../lib.php');
//********************************************************************

	function print_lang_bar() {
		global $lang, $lng, $i_name, $default_language, $picture_vars, $size_y, $size_x;

		$s='';
		for($i=0;$i<count($lang);$i++)
		{
			if ($lang[$i]['Code'] == $default_language)
				$in_s = ' (default) ';
			else
				$in_s = '';

			$s.='
				<tr>
					<td bgcolor="#ebebeb" colspan="2" height="5">&nbsp;&nbsp;<b>Language: '.$lang[$i]['Name'].' '.$in_s.' </b></td>
				</tr>
			';

			$image_name = $picture_vars['images'][$lang[$i]['Code']];

			if (!empty($image_name) && fileExists($image_name))
			{
				$s.='
					<tr>
						<td>URL: </td>
						<td><span onmouseover="ddrivetip(\'<img src=&quot;'.EE_HTTP.EE_IMG_PATH.$image_name.'&quot;';

				if (($size_y != 0) and ($size_x != 0))
					$s.= ' height=&quot;'.($size_y).'&quot; width=&quot;'.($size_x).'&quot;';

				$s.='>\')" onMouseout="hideddrivetip()"><b>'.EE_IMG_PATH.$image_name.'</b></span> <input type="submit" name="delete_img_'.$lang[$i]['Code'].'" value="" style="cursor:hand; background-image:url('.EE_HTTP.'img/delBt.gif);padding:0px;width:16px;margin:0px;border:0;color:#ffffff;" ></td>
					</tr>
				';
			}
			else
			{
				$s.='
					<tr>
						<td>Image:</td>
						<td><input type="file" name="nfile_'.$lang[$i]['Code'].'">&nbsp;&nbsp;<input type="submit" value="Upload" name="save" class="button" style="width:82px;">&nbsp;</td>
					</tr>
				';
			}

			$s.='
				<tr>
					<td>Alt-tag:</td>
					<td><input type="text" style="width:272px;" name="lang_alt_'.$lang[$i]['Code'].'" value="'.$picture_vars['alts'][$lang[$i]['Code']].'"></td>
				</tr>
			';
		}
		return $s;
	}

	function manage_picture_vars($picture_name, $picture_vars = array())
	{       
		list($var, $var_id) = get_var_id($picture_name);                                                     
		if (!empty($picture_vars))
		{                                                    

			//$res = viewsql('select val from content where var = "'.$var.'" and var_id = "'.$var_id.'"',0);
			$res = cms($picture_name, 0, '', 1, 0);

			if(empty($res))
			{
				save_cms($picture_name, serialize($picture_vars), 0, '');
			}
			else
			{
				db_sql_query('update content set val = '.sqlValue(serialize($picture_vars)).' where var = "'.$var.'"and var_id = "'.$var_id.'"',0);
			}
		}
		else
		{
			$res = cms($picture_name, 0, '', 1, 0);
			if(!empty($res))
			{
				$picture_vars = unserialize($res);
			}
		}
		return $picture_vars;
	}

	function init_vars()
	{
		global $lang, $picture_vars, $size_y, $size_x, $size_default_x, $size_default_y;
		global $default_language, $i_name, $default_language, $size_default;
		global $image_link, $open_same, $open_new, $image_sat, $url_text;

		$picture_vars = manage_picture_vars($i_name);

		if (fileExists($picture_vars['images'][$default_language]))
		{        
			$size=@getimagesize(EE_FILE_PATH.$picture_vars['images'][$default_language]);
			$size_x=$size[0];
			$size_y=$size[1];
		} else {
			$size_x='0';
			$size_y='0';
		}

		$size_default_x = $size_x;
		$size_default_y = $size_y;

		if (	$picture_vars['size_x'] == $size_x and
			$picture_vars['size_y'] == $size_y
			or
			empty($picture_vars['size_x'])
			or
			empty($picture_vars['size_y'])	)
		{
			$size_default = 'default';
		}
		else
		{
			$size_x = $picture_vars['size_x'];
			$size_y = $picture_vars['size_y'];
			$size_default = 'custom';
		}

		$all_languages = viewsql('SELECT * FROM v_language ORDER BY language_code');
		$lang = array();
		$i = 0;
		while($al = db_sql_fetch_array($all_languages))
		{
			$lang[$i]['Code']=$al['language_code'];
			$lang[$i++]['Name']=$al['language_name'];
		}

		$image_link = $picture_vars['link']['type'];
		if (!$image_link)
			$image_link = 'open_none';
		elseif($image_link == 'open_url')
			$url_text = $picture_vars['link']['url'];
		elseif($image_link == 'open_sat_page')
			$image_sat = $picture_vars['link']['sat'];

		if ($picture_vars['link']['opentype'] == '_blank')
		{
			$open_new = 'selected';
			$open_same = '';
		}
		else
		{
			$open_new = '';
			$open_same = 'selected';
		}

		//INIT XITI-attributes
		if(EE_LINK_XITI_ENABLE)
		{
			global $xitiClickType, $xitiS2, $xitiLabel;
			$xitiClickType	= isset($picture_vars['link']['xitiClickType'])	? $picture_vars['link']['xitiClickType'] : '';
			$xitiS2		= isset($picture_vars['link']['xitiS2'])	? $picture_vars['link']['xitiS2'] : '';
			$xitiLabel	= isset($picture_vars['link']['xitiLabel'])	? $picture_vars['link']['xitiLabel'] : '';
		}
  }

/**********************************************************************/

	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR or empty($i_name))
	{
		echo parse('norights');
		exit;
	}

	$i_type = $_GET['i_type'];
	$i_type = ($i_type == 'undefined')||($i_type == '') ? 'show' : $i_type;

	init_vars();

	for($i=0;$i<count($lang);$i++)
	{
		$delete_img = 'delete_img_'.$lang[$i]['Code'];
		if (isset($$delete_img))
		{
			deleteFile($picture_vars['images'][$lang[$i]['Code']]);
			$picture_vars['images'][$lang[$i]['Code']] = '';
			manage_picture_vars($i_name, $picture_vars);
			init_vars();
		}
	}

	if(!empty($save))
	{
		if ($image_size == 'default')
		{
			$picture_vars['size_x'] = $size_default_x;
			$picture_vars['size_y'] = $size_default_y;
		}
		else
		{
			$picture_vars['size_x'] = $_POST['f_size_x'];
			$picture_vars['size_y'] = $_POST['f_size_y'];
		}

		if ($open_none != '')
			$picture_vars['link']['type'] = 'open_none';
		elseif ($open_url != '')
		{
			$picture_vars['link']['type'] = 'open_url';
			$picture_vars['link']['url'] = $f_url_text;
		}
		elseif ($open_sat_page != '')
		{
			$picture_vars['link']['type'] = 'open_sat_page';
			$picture_vars['link']['sat'] = $satelit;
		}
		$picture_vars['link']['opentype'] = $open_type;

		//Adding xiti-attributes
		if(EE_LINK_XITI_ENABLE)
		{
			$picture_vars['link']['xitiClickType']	= post('xitiClickType');
			$picture_vars['link']['xitiS2']		= post('xitiS2');
			$picture_vars['link']['xitiLabel']		= post('xitiLabel');
		}

		for($i=0;$i<count($lang);$i++)
		{
			$lang_alt_field = 'lang_alt_'.$lang[$i]['Code'];
			$file_field = 'nfile_'.$lang[$i]['Code'];

			if (isset($$lang_alt_field))
			{
				$picture_vars['alts'][$lang[$i]['Code']] = $$lang_alt_field;
			}

			if (!empty($_FILES[$file_field]['tmp_name']))
			{
				if (!isset($picture_vars['images'][$lang[$i]['Code']]) or $picture_vars['images'][$lang[$i]['Code']] == '')
					$picture_vars['images'][$lang[$i]['Code']] = $i_name.'_'.$lang[$i]['Code'].substr($_FILES[$file_field]['name'],strrpos($_FILES[$file_field]['name'],'.'));
				httpUpload($_FILES[$file_field]['tmp_name'],EE_FILE_PATH.$picture_vars['images'][$lang[$i]['Code']]);
			}
		}
		manage_picture_vars($i_name, $picture_vars);
		init_vars();
	}
	else
	{
		if($_POST['cms_selector'])
			$cms_name=$_POST['cms_selector'];
	}

	echo parse_popup($modul.'/list');
?>