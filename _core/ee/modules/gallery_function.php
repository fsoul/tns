<?
	function gallery_save($i_id, $s_date, $s_title, $s_description, $i_status)
	{
		if (empty($i_id))
			$res = gallery_add($s_date, $s_title, $s_description, $i_status);
		else
			$res = gallery_edit($i_id, $s_date, $s_title, $s_description, $i_status);

		return $res;
	}

	function gallery_add($s_date, $s_title, $s_description, $i_status)
	{
		$sql = array (
			'gallery_add',
			spValue($s_date),
			spValue($s_title),
			spValue($s_description),
			((int)$i_status)
		);
		return GetSQL($sql);
	}

	function gallery_edit($i_id, $s_date, $s_title, $s_description, $i_status)
	{
		$sql = array (
			'gallery_edit',
			$i_id,
			spValue($s_date),
			spValue($s_title),
			spValue($s_description),
			((int)$i_status)
		);
		return GetSQL($sql);
	}

	function gallery_delete($i_id)
	{
		deleteFile(EE_GALLERY_DIR.$i_id);

		$sql = array ('gallery_delete', $i_id);
		return GetSQL($sql);
	}

	/**
	* Builds page navigation ruler for gallery (1,2,3,4 etc)
	*/

	function gallery_navigator_links($current_item, $count_items, $show_items, $gallery_id, $added_GET_vars ='',$object_template = 'object_template')
	{
		$total_pages = ceil($count_items/$show_items);
                $gallery_image_ids = gallery_get_correction_array_of_images_ids($gallery_id);   
		$active_page = ceil(array_search($current_item, $gallery_image_ids)/$show_items);
		$s = '';
		for($i = 1; $i <= $total_pages; $i++)
		{
			if((int) $active_page == $i)
			{
				$s.= '<span class="num_ruler_inactive" >'.$i.'</span>&nbsp;';
			}
			else
			{
				$s.= '<a class="num_ruler" href = \''.EE_HTTP.get_alias_for_object($gallery_image_ids[$i],$object_template, $added_GET_vars).'\'>'.$i.'</a>'.'&nbsp;';
			}
		}
		return $s;
	}

/**
 * Generates galery navigation. Last parametr is used as templete for Previous / Next buttons
 * 	Default template is in /_core/ee/templates/navigation/gal_next_prev.tpl
 * In template you can use variables
 * 		is_gallery_first_item (bool)
 * 		is_gallery_last_item (bool)
 * 		gallery_prev_item_link (string)
 * 		gallery_next_item_link (string)
 *
 * @param int $current_item
 * @param int $gallery_id
 * @param string $object_template
 * @param string $templeate_name
 *
 * @return string
 */
function gallery_navigator_np($current_item, $gallery_id, $added_GET_vars='', $object_template = "object_template", $template_name = 'navigation/gal_next_prev')
{
	$gallery_image_ids = gallery_get_correction_array_of_images_ids($gallery_id);

	if(!is_array($gallery_image_ids) || $gallery_image_ids[array_search(reset($gallery_image_ids),$gallery_image_ids)] == (int) $current_item)
	{
		setValueOf('is_gallery_first_item', 1);
	}
	else
	{
		setValueOf('gallery_prev_item_link', EE_HTTP.get_alias_for_object($gallery_image_ids[array_search($current_item,$gallery_image_ids)-1],$object_template, $added_GET_vars));
	}

	if(!is_array($gallery_image_ids) || $gallery_image_ids[array_search(end($gallery_image_ids),$gallery_image_ids)] == (int) $current_item)
	{
		setValueOf('is_gallery_last_item',1);
	}
	else
	{
		setValueOf('gallery_next_item_link', EE_HTTP.get_alias_for_object($gallery_image_ids[array_search($current_item,$gallery_image_ids)+1],$object_template, $added_GET_vars));
	}


	return parse($template_name);
}


       	/**
	* Return page number that image belongs
	*/

	function gallery_get_image_page($first_item, $current_item, $gallery_id, $show_items)
	{
		$gallery_image_ids = gallery_get_correction_array_of_images_ids($gallery_id);		
		return	ceil(array_search($current_item, $gallery_image_ids)/$show_items);
	}

	/*
	* Returns corrected array of images ids [for navigator]
	*/
	function gallery_get_correction_array_of_images_ids($gallery_id, $order_by = 'publish_date', $sort_order = 'DESC')
	{
		$rs = viewsql('SELECT record_id FROM ( '.create_sql_view_by_name('gallery_image').' ) v  WHERE v.gallery_id='.((int) $gallery_id).' ORDER BY v.'.$order_by.' '.$sort_order, 0);
		$counter = 1;
		$gallery_image_ids = false;
		while ($r = db_sql_fetch_assoc($rs))
		{                                  
			$gallery_image_ids[$counter++] = $r['record_id'];
		}
		return $gallery_image_ids;
	}


	/*
	* Returns gallery id of image;
	* $image_id - current image; $object_name - object of gallery images
	**/
	function get_image_gallery_id($image_id, $object_name)
	{
		return  getField('SELECT gallery_id FROM ( '.create_sql_view_by_name_for_fields('gallery_id', $object_name).' ) v  WHERE v.record_id='.sqlValue($image_id));
	}

	/*
	* Returns count images of gallery
	**/
	function get_count_images_of_gallery($gallery_id, $object_name)
	{
		return getField('SELECT COUNT(*) FROM ( '.create_sql_view_by_name_for_fields('gallery_id', $object_name).' ) v  WHERE v.gallery_id='.sqlValue($gallery_id));
	}

	/*
	* Returns fields value of object
	**/
	function get_object_field_value($object_field, $object_id, $object_name)
	{
		return getField('SELECT v.'.$object_field.' FROM ('.create_sql_view_by_name_for_fields($object_field, $object_name).') v WHERE v.record_id = '.sqlValue($object_id));
	}

	/*
	* Returns fields value of object
	**/
	function get_gallery_image($gallery_id)
	{
		return getField('SELECT v.image_filename  FROM ('.create_sql_view_by_name_for_fields('image_filename, gallery_id, is_gallery_image', 'gallery_image').') v WHERE v.gallery_id = '.sqlValue($gallery_id).' AND v.is_gallery_image = 1');
	}

	function get_first_image_of_gallery($gallery_id)
	{
		return	reset(gallery_get_correction_array_of_images_ids($gallery_id));
	}

	function get_gallery_image_urls_sql($gallery_id)
	{
		return 'SELECT v.image_filename
			FROM ('.create_sql_view_by_name_for_fields('image_filename, gallery_id, item_order', 'gallery_image').') v
			WHERE v.gallery_id = '.sqlValue($gallery_id).'
			ORDER BY CAST(v.item_order AS UNSIGNED)';
	}

	function get_first_gallery_image_url($gallery_id)
	{
		$file_name = getField(get_gallery_image_urls_sql($gallery_id).' LIMIT 0,1');
		return EE_HTTP.EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id.'/'.$file_name;

	}

	function create_gallery_image_urls_tpl($gallery_id, $tpl)
	{
		$sql_res = viewsql(get_gallery_image_urls_sql($gallery_id));
		$arr_res = array();
		while($res = db_sql_fetch_assoc($sql_res))
		{
			$arr_res[]['image_url'] = EE_HTTP.EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id.'/'.$res['image_filename'];
		}
		return parse_array_to_html($arr_res, $tpl);
	}

	function get_gallery_random_image_url($gallery_id)
	{
		$file_name = getField(
				'SELECT image_filename
					FROM ('.create_sql_view_by_name_for_fields('record_id, gallery_id, image_filename', 'gallery_image').') img
						INNER JOIN (SELECT gallery_id gallery_id_from_gal, gallery_status
							FROM ('.create_sql_view_by_name_for_fields('record_id, gallery_id, gallery_status', 'gallery').') g
							WHERE g.gallery_status=1
								AND g.gallery_id = '.sqlValue($gallery_id).'
							) gal
						ON img.gallery_id = gal.gallery_id_from_gal
					ORDER BY RAND()
					LIMIT 0,1'
		);

		return EE_HTTP.EE_IMG_PATH.EE_GALLERY_DIR.$gallery_id.'/'.$file_name;
	}
?>