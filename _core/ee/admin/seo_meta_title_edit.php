<?

	include_once('../lib.php');

	if (!CheckAdmin() or $UserRole != ADMINISTRATOR)
	{
		echo parse('norights');exit;
	}

	// sorting start
	global $seo_unsortable_fields_list;
	$seo_unsortable_fields_list = array('id', 'page_name', 'language_name', 'object_name', 'file_name', 'language');

	// get order numbers of meta-tags
	$mata_tags_order_numbers =  unserialize(cms('metatags_order_numbers'));
	global $metatag_order_number;
	$metatag_order_number = isset($mata_tags_order_numbers[get('meta_tag_name')]) ? intval($mata_tags_order_numbers[get('meta_tag_name')]) : 0;
	// sorting end

	if ($object === 'true')
	{
		$i_content_var = 'default_obj_meta_';
		$meta_var = 'obj_meta_';

	}
	else
	{
		$i_content_var = 'default_meta_';
		$meta_var = 'meta_';
	}

	$pageTitle = (empty($meta_tag_name) ? 'Add ' : 'Edit ').'Metatag';
	$ar_meta_default = array('commentary', 'title', 'keywords', 'description');

	function print_language_bar()
	{
		
		$sql = "SELECT language_code FROM v_language";
		$res = ViewSQL($sql, 0);

		while ($row = db_sql_fetch_row($res))
		{
			$arr[]['r_lang']=$row[0];
		}

		return parse_array_to_html($arr, 'templates/meta_title_lang_row');
	}

	
	if (post('refresh'))
	{

		// saving order numbers of meta-tags
		$mata_tags_order_numbers[post('meta_tag_name_new')] = intval(post('meta_tag_order_number'));
		save_cms('metatags_order_numbers', serialize($mata_tags_order_numbers));
		publish_cms_on_page(0, 'matatags_order_numbers');

		$_POST['meta_tag_name_new'] = str_replace(';', '', $_POST['meta_tag_name_new']);
		  
		if ( $_POST['meta_tag_name_new']=='' )
			$error['meta_tag_name_new'] = EMPTY_ERROR;

		if (	in_array($_POST['meta_tag_name'], $ar_meta_default) && 
			$_POST['meta_tag_name']!=$_POST['meta_tag_name_new']	)
		{
			$error['meta_tag_name_new'] = 'You can\'t modify default tags!';
		}

		if (is_meta_tag_exists($meta_var.$_POST['meta_tag_name_new']) && $_POST['meta_tag_name']!=$_POST['meta_tag_name_new'])
		{
			$error['meta_tag_name_new'] = 'Such meta tag already exists!';
		}

		if ( preg_match('/[^a-z]+/i', trim(post('meta_tag_name_new'))) !== 0 )
		{
			$error['meta_tag_name_new'] = '<b>Incorrect name format of meta tag. You can use "a-z" symbols only.</b>';
		}

		if (count($error)==0)
		{
			// if insert of new tag
			if (post('meta_tag_name') == '')
			{
				$meta_tag_name = post('meta_tag_name_new');

				$sql = "SELECT language_code FROM v_language";
				$res = ViewSQL($sql);
				while (list($r_lang) = db_sql_fetch_row($res))
				{				
					if (post('meta_tag_name_new_value_'.$r_lang) != '')
					{
						$new_value = post('meta_tag_name_new_value_'.$r_lang);
					}
					else 
					{
						$new_value = '';
					}

					$var = $i_content_var.$meta_tag_name;
					save_cms($var, $new_value, 0, $r_lang);
					publish_cms_on_page(0, $var);
				}

				$default_page_id = getField('SELECT min(id) FROM `tpl_pages` WHERE `default_page`=1');

				if (!is_null($default_page_id))
				{
					save_cms($meta_var.$meta_tag_name, '', $default_page_id);
					publish_cms_on_page($default_page_id, $meta_var.$meta_tag_name);
				}
			}
			// if update of existing tag
			else
			{                              
				if ($_POST['meta_tag_name'] != $_POST['meta_tag_name_new'])
				{
					rename_cms($meta_var.$_POST['meta_tag_name'], $meta_var.$_POST['meta_tag_name_new']);
					rename_cms($i_content_var.$_POST['meta_tag_name'], $i_content_var.$_POST['meta_tag_name_new']);
				}

				if ($_POST['meta_tag_name'] == EE_CHANGE_FREQUENCY_TAG)
				{
					save_config_var(EE_CHANGE_FREQUENCY_TAG, $_POST[EE_CHANGE_FREQUENCY_TAG]);
				}
				else
				{
					$sql = "SELECT language_code FROM v_language";
					$res = ViewSQL($sql);

					while (list($r_lang) = db_sql_fetch_row($res))
					{					
						$new_value = post('meta_tag_name_new_value_'.$r_lang);
						// see new save_cms()-function interface
						save_cms($i_content_var.$_POST['meta_tag_name_new'], $new_value, 0, $r_lang);
						publish_cms_on_page(0, $i_content_var.$_POST['meta_tag_name_new']);
					}
				}
			}
?>
<script>               
	window.parent.closePopup('yes');
</script>
<?		}
		else
		
			echo parse_popup('meta_title_edit');
	}
	else
	{
		echo parse_popup('meta_title_edit');
	}
?>