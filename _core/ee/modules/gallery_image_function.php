<?
	function gallery_image_save($i_id, $s_filename, $s_title, $s_description, $i_is_gallery_img, $i_gallery_id)
	{
		if (empty($i_id))
			$res = gallery_image_add($s_filename, $s_title, $s_description, $i_is_gallery_img, $i_gallery_id);
		else
			$res = gallery_image_edit($i_id, $s_filename, $s_title, $s_description, $i_is_gallery_img, $i_gallery_id);

		return $res;
	}

	function gallery_image_add($s_filename, $s_title, $s_description, $i_is_gallery_img, $i_gallery_id)
	{
		$sql = array (
			'gallery_image_add',
			spValue($s_filename),
			spValue($s_title),
			spValue($s_description),
			spValue((!empty($i_is_gallery_img))),
			spValue($i_gallery_id)
		);
		return GetSQL($sql);
	}

	function gallery_image_edit($i_id, $s_filename, $s_title, $s_description, $i_is_gallery_img, $i_gallery_id)
	{
		$sql = array (
			'gallery_image_edit',
			$i_id,
			spValue($s_filename),
			spValue($s_title),
			spValue($s_description),
			spValue((!empty($i_is_gallery_img))),
			spValue($i_gallery_id)
		);
		return GetSQL($sql);
	}

	function gallery_image_delete($i_id)
	{
		$sql = array ('gallery_image_get_galleryid', $i_id);
		$gallery_id = GetSQL($sql);

		$sql = array ('gallery_image_get_filename', $i_id);
		$file_name = GetSQL($sql);

		deleteFile(EE_GALLERY_DIR.$gallery_id.'/'.$file_name);
		deleteFile(EE_GALLERY_DIR.$gallery_id.'/_'.$file_name);

		$sql = array ('gallery_image_delete', $i_id);
		return GetSQL($sql);
	}

?>