<?php
	$modul='menu_edit';

	if (!empty($back))
	{
		header('Location: user.php?load_cookie=true');
		exit;
	}

//********************************************************************
	include_once('../lib.php');
//set_mark('after lib.php');
//********************************************************************

	if (!CheckAdmin() or $UserRole!=ADMINISTRATOR)
	{
		echo parse('norights');
		exit;
	}

//set_mark('1');

	if (post('delete_img_active'))
	{
		deleteFile(cms('menu_'.get('menu_id').'_picture_active_'.get('edit')));
		del_cms('menu_'.get('menu_id').'_picture_active_'.get('edit'), post('lang'));
		header('Location: '.EE_ADMIN_URL.$modul.'.php?menu_id='.get('menu_id').'&edit='.get('edit').'&lang='.post('lang').'&type='.get('type').'&admin_template='.get('admin_template').'');
		exit;
	}
//set_mark('2');

	if (post('delete_img_inactive'))
	{
		deleteFile(cms('menu_'.$_GET['menu_id'].'_picture_inactive_'.get('edit')));
		del_cms('menu_'.get('menu_id').'_picture_inactive_'.get('edit'), post('lang'));
		header('Location: '.EE_ADMIN_URL.$modul.'.php?menu_id='.get('menu_id').'&edit='.get('edit').'&lang='.post('lang').'&type='.get('type').'&admin_template='.get('admin_template').'');
		exit;
	}
//set_mark('3');

	if ($type == 'delete')
	{
		echo "Deleting menu item...";

		$mn = new Menu($_GET['menu_id'],$lang);
		$mn->delete_menuitem($_GET['delete']);
		finish();
	}


	if ($type == 'add' || $type == 'edit')
	{
//set_mark('3.1');
		// strip all tags from code, lable, title
		$ar_fields_for_strip_tags = array('menu_name', 'menu_code', 'menu_title');
		foreach ($ar_fields_for_strip_tags as $field_for_strip_tags)
		{
			if (array_key_exists($field_for_strip_tags, $_POST))
			{
				$_POST[$field_for_strip_tags] = strip_tags($_POST[$field_for_strip_tags]);
			}
		}
//set_mark('3.2');

		// remove all non alphabetical/numbers/-/_ symbols from menu_code
		if (array_key_exists('menu_code', $_POST))
		{
			$pattern = "/([^a-zA-Z0-9_-])/i";
			$replacement = "";
			$_POST['menu_code'] = preg_replace($pattern, $replacement, $_POST['menu_code']);
		}		
//set_mark('3.3');
	}


	if ($type == 'edit')
	{
//set_mark('3.4');
		global $inactive_image, $active_image;

		$item_id = $_GET['edit'];

		$inactive_image = cms('menu_'.$_GET['menu_id'].'_picture_inactive_'.$item_id);
		$active_image = cms('menu_'.$_GET['menu_id'].'_picture_active_'.$item_id);

		if (trim($inactive_image) != '')
		{
			$inactive_image = '<br/><img src="'.$inactive_image.'" height="34" border="0" />';
		}

//set_mark('3.5');
		if (trim($active_image) != '')
		{
			$active_image = '<br/><img src="'.$active_image.'" height="34" border="0" />';
		}

		$mn = new Menu($_GET['menu_id'], $lang);
//set_mark('3.6');

		if (sizeof($_POST) || sizeof($_FILES))
		{
			$item['label'] = $_POST['menu_name'];
			$item['type'] = $_POST['m_type'];
			$item['url'] = ($_POST['url']=='on' ? $_POST['url_text'] : '');
			$item['sat'] = ($_POST['sat_page']=='on' ? $_POST['satelit'] : '');
			$item['open_type'] = $_POST['open_type'];
			$item['parent'] = $_GET['parent'];
			$item['order'] = intval($_POST['order']);
			$item['shadow'] = $_POST['shadow'];

			// menu title
			$item['title'] = $_POST['menu_title'];
			// menu code
			$item['code'] = $_POST['menu_code'];

			//XITI attributes editing
			$item = EE_LINK_XITI_ENABLE ? attach_xiti_attributes($item) : $item;
			
			$mn->update_menuitem($_GET['edit'], $item);

			$nfile_active = $_FILES['nfile_active']['tmp_name'];
			$nfile_inactive = $_FILES['nfile_inactive']['tmp_name'];
//set_mark('3.7');

			if ($nfile_active)
			{
				$tmpFileName = $_FILES['nfile_active']['name'];

				$fileName = 'menu_'.$_GET['menu_id'].'_'.$lang.'_active_'.$item_id.'.'.
					strtolower(substr($tmpFileName,strrpos($tmpFileName,".")+1,(strlen($tmpFileName) - strrpos($tmpFileName,".")-1)));

				ftpUpload($nfile_active,$fileName);

				save_cms('menu_'.$_GET['menu_id'].'_picture_active_'.$item_id, EE_HTTP_PREFIX.EE_IMG_PATH.$fileName,0,$lang);
			}
//set_mark('3.8');

			if ($nfile_inactive)
			{
				$tmpFileName = $_FILES['nfile_inactive']['name'];

				$fileName = 'menu_'.$_GET['menu_id'].'_'.$lang.'_inactive_'.$item_id.'.'.
					strtolower(substr($tmpFileName,strrpos($tmpFileName,".")+1,(strlen($tmpFileName) - strrpos($tmpFileName,".")-1)));

				ftpUpload($nfile_inactive,$fileName);

				save_cms('menu_'.$_GET['menu_id'].'_picture_inactive_'.$item_id, EE_HTTP_PREFIX.EE_IMG_PATH.$fileName,0,$lang);

			}
//set_mark('3.9');

			if ($_POST['nextlang'] == '')
			{
				finish();
			}
			else
			{
				$lang = $_POST['nextlang'];
	                	$mn = new Menu($_GET['menu_id'], $lang);
			}
//set_mark('3.10');
		}

		$cur = $mn->get_one_menu($_GET['edit']);

		$menu_label = htmlspecialchars($cur['label']);
		$menu_title = htmlspecialchars($cur['title']);

		$menu_code = $cur['code'];
		$m_type = $cur['type'];
		$order = $cur['order'];
		$shadow = $cur['shadow'];

//set_mark('3.11');
		if ($cur['open_type'] == 'self')
		{
			$open_same = 'selected';
		}
		else
		{
			$open_new = 'selected';
		}
//set_mark('3.11.1');

		//global variable for storing value what page id used as Satellite page
		$sattelite_page_id = '';
		
		if ($cur['sat'] != '')
		{
			$sattelite_page_id = $cur['sat'];
//set_mark('3.11.2.1');
//set_mark('3.11.2.2');
			$url_text = '';
//set_mark('3.11.2.3');
			$load = 'javascript:edit_current(\'sat\')';
//set_mark('3.11.2.4');
		}
		elseif ($cur['url'] != '')
		{
			$url_text = $cur['url'];
			$load = 'javascript:edit_current(\'url\')';
//set_mark('3.11.3');
		}
		else
		{
			$url_text = '';
			$load = 'javascript:edit_current(\'sat\')';
//set_mark('3.11.4');
		}
//set_mark('3.12');

		//globalize xiti parameters for sending needed data into template
		if (defined('EE_LINK_XITI_ENABLE') && EE_LINK_XITI_ENABLE)
		{
			$xitiClickType	= $cur['xitiClickType'];
			$xitiS2		= $cur['xitiS2'];
			$xitiLabel	= $cur['xitiLabel'];
		}
//set_mark('3.13');

		echo parse_popup($modul."/edit");
//set_mark('3.14');
	}
//set_mark('4');

	if ($type == 'add')
	{
		$mn = new Menu($_GET['menu_id'],$lang);

		if (sizeof($_POST))
		{
			$item['label'] = $_POST['menu_name'];
			$item['type'] = $_POST['m_type'];
			$item['url'] = ($_POST['url']=='on' ? $_POST['url_text'] : '');
			$item['sat'] = ($_POST['sat_page']=='on' ? $_POST['satelit'] : '');
			$item['open_type'] = $_POST['open_type'];
			$item['parent'] = $_GET['parent'];
			$item['order'] = intval($_POST['order']);
			$item['shadow'] = $_POST['shadow'];
			// menu title
			$item['title'] = $_POST['menu_title'];
			// menu code
			$item['code'] = $_POST['menu_code'];

			//XITI attributes adding
			$item = EE_LINK_XITI_ENABLE ? attach_xiti_attributes($item) : $item;

			$item_id = $mn->add_new_menuitem($item);

			$nfile_active = $_FILES['nfile_active']['tmp_name'];
			$nfile_inactive = $_FILES['nfile_inactive']['tmp_name'];

			if ($nfile_active)
			{
				$tmpFileName = $_FILES['nfile_active']['name'];
				$fileName = 'menu_'.$_GET['menu_id'].'_'.$lang.'_active_'.$item_id.'.'.
					strtolower(substr($tmpFileName,strrpos($tmpFileName,".")+1,(strlen($tmpFileName) - strrpos($tmpFileName,".")-1)));
				ftpUpload($nfile_active,$fileName);
				save_cms('menu_'.$_GET['menu_id'].'_picture_active_'.$item_id, EE_HTTP_PREFIX.EE_IMG_PATH.$fileName,0,$lang);

			}

			if ($nfile_inactive)
			{
				$tmpFileName = $_FILES['nfile_inactive']['name'];
				$fileName = 'menu_'.$_GET['menu_id'].'_'.$lang.'_inactive_'.$item_id.'.'.
					strtolower(substr($tmpFileName,strrpos($tmpFileName,".")+1,(strlen($tmpFileName) - strrpos($tmpFileName,".")-1)));
				ftpUpload($nfile_inactive,$fileName);
				save_cms('menu_'.$_GET['menu_id'].'_picture_inactive_'.$item_id, EE_HTTP_PREFIX.EE_IMG_PATH.$fileName,0,$lang);

			}

			if ($_POST['nextlang'] == '')
			{
				finish();
			}
			else
			{
				$lang = $_POST['nextlang'];	                
			}
		}

		$m = array();

		foreach ($mn->structure as $k=>$v)
		{
			if ($v['parent']==$_GET['parent'])
			{
				$m[$k] = $v['order'];
			}
		}

		$order = @max($m)+1;

		$open_same = 'selected';

		$load = 'javascript:edit_current(\'url\')';

		$mn = new Menu($_GET['menu_id'],$lang);

		if ($_POST['nexttype'] != '')
		{
			header('Location: '.EE_HTTP.EE_ADMIN_SECTION.'menu_edit.php?menu_id='.$_GET['menu_id'].'&edit='.$item_id.'&lang='.$_POST['nextlang'].'&type=edit&admin_template=yes');
		}
		else
		{
			echo parse_popup($modul."/edit");
		}
	}

	function attach_xiti_attributes($item)
	{
		$item['xitiClickType']	= post('xitiClickType');
		$item['xitiS2']		= post('xitiS2');
		$item['xitiLabel']	= post('xitiLabel');

		return $item;	
	}

	function finish()
	{
?>
<script language="JavaScript">
window.parent.closePopup('yes');
</script>
<?
	}

	function print_avail_languages()
	{
		global $lang, $t, $cms_name, $type;

		if ($type == 'add')
		{
			$nexttype = 'edit';
		}
		else
		{
   			$nexttype = $type;
		}

		$res = '';
		$tpl = '<a href="%s" style="padding:5px;%s"
				onclick="document.current.nextlang.value=\'%s\';
					document.current.nexttype.value=\'%s\';
					document.current.save.click()">%s</a>';
		$sql="SELECT language_code, status FROM v_language";
		$r = ViewSQL($sql, 0);

		while ($row=db_sql_fetch_assoc($r))
		{
			$style='';

			if ($row['status']==0)
			{
				$style='color:#999;';
			}

			if ($row['language_code'] == $lang)
			{
				$style='color:red;';
			}

			$href = '#'; //'cms.php?cms_name='.$cms_name.'&admin_template=yes&t='.$t.'&lang='.$row['language_code'];
			$res .= sprintf($tpl, $href, $style, $row['language_code'], $nexttype, $row['language_code']);
		}

		return $res;
	}

//set_mark('END');

//echo get_total_benchmark_time('111');

?>