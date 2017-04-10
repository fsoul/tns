<?

	function f_add_gallery($pDate, $pTitle, $pDescription, $pStatus, $pStaticWidth, $pStaticHeight)
	{
		$res_id = RunSQL('INSERT INTO gallery SET gallery_date = CURDATE(), gallery_title = "'.trim($pTitle).'",
		   	gallery_description = "'.trim($pDescription).'", gallery_status = "'.intval($pStatus).'",
		   	gallery_image_w = "'.trim($pStaticWidth).'",gallery_image_h = "'.intval($pStaticHeight).'";');

		return $res_id;
	}

	function gallery_image_clear_flag($pGalleryId)
	{
		RunSQL('UPDATE gallery_image SET is_gallery_image = NULL WHERE gallery_id = "'.trim($pGalleryId).'";');
	}

	function f_add_gallery_image($pFileName, $pTitle, $pDescription, $pIsGalleryImg, $pGalleryId)
	{
		if ($pIsGalleryImg != 0)
			gallery_image_clear_flag($pGalleryId);
		else
			$pIsGalleryImg = 'NULL';

	 $res_id = RunSQL('INSERT INTO gallery_image SET
	 		image_filename = "'.trim($pFileName).'", image_title = "'.trim($pTitle).'",
	  	image_description = "'.trim($pDescription).'", is_gallery_image = '.$pIsGalleryImg.',
			gallery_id = "'.$pGalleryId.'";');

		return $res_id;
	}

	function f_del_gallery($pId)
	{
		RunSQL('DELETE FROM gallery_image WHERE gallery_id = "'.$pId.'";');
		RunSQL('DELETE FROM gallery WHERE id = "'.$pId.'";');
		return 1;
	}

	function f_del_gallery_image($pId)
	{
		RunSQL('DELETE FROM gallery_image WHERE id = "'.$pId.'";');
		return 1;
	}
	
	/*
	** Deletes selected items on grid
	** $pId - array of [selected] items ids
	*/
	function f_del_gallerys($pId)
	{          	
		RunSQL('DELETE FROM gallery_image WHERE gallery_id in('.sqlValuesList($pId).')');
		RunSQL('DELETE FROM gallery WHERE id in('.sqlValuesList($pId).')');
		return 1;
	}
        
	/*
	** Deletes selected items on grid
	** $pId - array of [selected] items ids
	*/
	function f_del_gallery_images($pId)
	{
		RunSQL('DELETE FROM gallery_image WHERE id in('.sqlValuesList($pId).')');
		return 1;
	}    
	function f_upd_gallery_image($pId, $pFileName, $pTitle, $pDescription, $pIsGalleryImg, $pGalleryId)
	{
		if ($pIsGalleryImg != 0 && $pIsGalleryImg != null)
			gallery_image_clear_flag($pGalleryId);
		else
			$pIsGalleryImg = 'NULL';

		RunSQL('UPDATE gallery_image SET image_filename = "'.trim($pFileName).'",
	  	 	image_title = "'.trim($pTitle).'",
		   	image_description = "'.trim($pDescription).'",
		   	is_gallery_image = '.$pIsGalleryImg.',
				gallery_id = '.$pGalleryId.'
		  WHERE id = "'.$pId.'";');

		return $pId;
	}

	function f_upd_gallery($pId, $pDate, $pTitle, $pDescription, $pStatus)
	{
		RunSQL('UPDATE gallery SET gallery_title = "'.trim($pTitle).'",
	  	 	gallery_description = "'.trim($pDescription).'",
				gallery_status = "'.$pStatus.'"
		  WHERE id = "'.$pId.'";');
		return $pId;
	}

?>