<?
function mime_content_type2($file)
{
	return mime_content_type_ext($file);
}

// If object call upload_image_zip, $object_call = true; 
function upload_image_zip ($i_gallery_id, $s_field, $s_add_path='', $s_file_name_save=null, $i_thumbnail_width=100, $i_max_width=1000000, $gallery_size_params=null, $object_call = false)
{
	$ar_file_types = array ('application/x-zip-compressed'=>'', 'application/zip'=>'');


	if($_FILES[$s_field]["size"] == 0) {
		$error[] = 'File size = 0';
		return $error;
	}

        $zip_header = get_zip_header($_FILES[$s_field]["tmp_name"]);

	if(mime_content_type_ext($_FILES[$s_field]["name"]) != 'application/zip' || $zip_header != ZIP_HEADER_SIGNATURE)
	{
		$error[] = 'Incorrect file type: '.$_FILES[$s_field]["type"];
		return $error;
	}

	if (function_exists('zip_open'))
	{             
		$zip = @zip_open($_FILES[$s_field]["tmp_name"]);
		if(!$zip)
		{
			return array(true);
		}
		
		//init start order in the current gallery
		$item_order_counter = get_next_order('gallery_image', 'item_order', $i_gallery_id);

		while ($zip_entry = zip_read($zip))
		{
			$s_description =
		        "Name:               " . ($s_filename = $s_title = zip_entry_name($zip_entry)) . "\n".
		        "Actual Filesize:    " . ($file_size = zip_entry_filesize($zip_entry)) . "\n";

			if (zip_entry_open($zip, $zip_entry, "r"))
			{

				$buf = zip_entry_read($zip_entry, zip_entry_filesize($zip_entry));
				zip_entry_close($zip_entry);

				$unziped = $_FILES[$s_field]["tmp_name"].'.unziped';
				$im_file_handler = fopen($unziped, "w");
				fwrite($im_file_handler, $buf);
				fclose($im_file_handler);

				$_FILES['load_image'] = array (
					'name' =>	$s_filename,
					'type' =>	mime_content_type_ext($s_filename),
					'tmp_name' =>	$unziped,
					'error' =>	0,
					'size' =>	$file_size
				);


				$res = upload_image('load_image', $s_add_path, $s_file_name_save, EE_GALLERY_THUMBNAIL_W, EE_GALLERY_MAX_W, EE_GALLERY_MAX_H, $gallery_size_params);

				if (is_array($res))
				{

					$error[$s_field] = $res[0];
				}
				else
				{   	
					if($object_call === true)
					{
						$__record_id = gallery_image_object_save(0, $s_filename, $s_title, $s_description, null, $i_gallery_id, null, $item_order_counter++);
					}
					else
					{
						f_add_gallery_image($s_filename, $s_title, $s_description, 0, $i_gallery_id);
					}
				}
			}
		}
		zip_close($zip);
	}
	elseif(file_exists(EE_CORE_PATH.'lib/pclzip.lib.php'))                                       	
	{ 	
		/*
		* Alternative zip extractor;
		* pclzip.lib.php - class of pclzip;
		* $my_tmp_dir - temp dir;
		*/
		include EE_CORE_PATH.'lib/pclzip.lib.php'; 
		$zip_object = new PclZip($_FILES[$s_field]["tmp_name"]);
		$my_tmp_dir =  dirname($_FILES[$s_field]["tmp_name"]).'/'.session_id();
		mkdir($my_tmp_dir);
		$file_list = $zip_object->extract($my_tmp_dir);	
		foreach ($file_list as $file)
		{
		  	$s_description =
			"Name:               " . ($s_filename = $s_title = $file['stored_filename']) . "\n".
		        "Actual Filesize:    " . ($file_size = $file['size']) . "\n";
			$_FILES['load_image'] = array (
				'name' =>	$s_filename,
				'type' =>	mime_content_type_ext($s_filename),
				'tmp_name' =>	$file['filename'],
				'error' =>	0,
				'size' =>	$file_size
			);
			$res = upload_image('load_image', $s_add_path, $s_file_name_save, EE_GALLERY_THUMBNAIL_W, EE_GALLERY_MAX_W, EE_GALLERY_MAX_H,$gallery_size_params);

				if (is_array($res))
				{

					$error[$s_field] = $res[0];
				}
				else
				{   	
					if($object_call === true)
					{
						$__record_id = gallery_image_object_save(0, $s_filename, $s_title, $s_description, null, $i_gallery_id, null);
					}
					else
					{
						f_add_gallery_image($s_filename, $s_title, $s_description, 0, $i_gallery_id);
					}
				}
		unlink($file['filename']);		
		}	
		rmdir($my_tmp_dir);
	}	
	return $res;
}                   

function check_image_size_for_galary($imageData, $galeryData)
{
	if (is_array($galeryData))
	{
		if (isset($galeryData['static_width']) && intval($galeryData['static_width']) > 0 && $galeryData['static_width'] != $imageData['x'])
			return false;
		if (isset($galeryData['static_height']) && intval($galeryData['static_height']) > 0 && $galeryData['static_height'] != $imageData['y'])
			return false;
	}

	return true;
}

function upload_image($s_field, $s_add_path='', $s_file_name_save=null, $i_thumbnail_width=100, $i_max_width=1000000, $i_max_height=1000000,$gallery_size_params= null)
{
vdump($i_thumbnail_width, '$i_thumbnail_width');
vdump($i_max_width, '$i_max_width');
vdump($i_max_height, '$i_max_height');

	$ar_file_types['image/gif']=array (
			'im_create_func' => 'ImageCreateFromGif',
			'im_type' => 'Gif',
			'im_func' => 'ImageGif'
			);
	$ar_file_types['image/pjpeg']=
	$ar_file_types['image/jpeg']=array (
			'im_create_func' => 'ImageCreateFromJpeg',
			'im_type' => 'Jpg',
			'im_func' => 'ImageJpeg'
			);
	$ar_file_types['image/png']=
	$ar_file_types['image/x-png']=array (
			'im_create_func' => 'ImageCreateFromPng',
			'im_type' => 'Png',
			'im_func' => 'ImagePng'
			);

	$error = array();

	if($_FILES[$s_field]["size"] > 1024*3*1024)
	{
		$error[] = 'File size &gt; 3Mb';
		return $error;
	}
	if($_FILES[$s_field]["size"] == 0)
	{
		$error[] = 'File size = 0';
		return $error;
	}
	if (!in_array($_FILES[$s_field]["type"], array_keys($ar_file_types)))
	{

		$error[] = 'Incorrect file type: '.$_FILES[$s_field]["type"];
		return $error;
	}

	// так файл назывался в оригинале
	$FileName = $_FILES[$s_field]["name"];

	if ($s_file_name_save!=null)
	{
		// выцепляем из имени файла расширение
		$FileExt = substr($FileName, strlen($FileName)-3, 3);
		// сохранять будем под указанным именем + расширение
		$FileName = $s_file_name_save.'.'.$FileExt;
	}

	$ImgFileName = $_FILES[$s_field]["tmp_name"];
	$ImgFileNamePr = $_FILES[$s_field]["tmp_name"];

	if (is_file($ImgFileName))
	{
		$type = $_FILES[$s_field]["type"];

		$im_orig = $ar_file_types[$type]['im_create_func']($ImgFileName);
		$im_type = $ar_file_types[$type]['im_type'];
		$im_func = $ar_file_types[$type]['im_func'];

		switch ($_FILES[$s_field]["type"])
		{
			case 'image/gif':
				$im_orig = ImageCreateFromGif($ImgFileName);
				$im_type = 'Gif';
				$im_func = 'ImageGif';
			break;

			case 'image/jpeg' :
			case 'image/pjpeg':
				$im_orig = ImageCreateFromJpeg($ImgFileName);
				$im_type = 'Jpg';
				$im_func = 'ImageJpeg';
			break;
			case 'image/png':
			case 'image/x-png':
				$im_orig = ImageCreateFromPng($ImgFileName);
				$im_type = 'Png';
				$im_func = 'ImagePng';
			break;

		}

		if (isset($im_orig))
		{
			// если картинка не проходит проверку на статические
			// размеры галереи, выдаем ошибку
			if(!check_image_size_for_galary(array('x'=>imageSX($im_orig),'y'=>imageSY($im_orig)),$gallery_size_params))
			{
				$error[] = 'Image size error: it should have ' .
					(is_array($gallery_size_params) && isset($gallery_size_params['static_width'])? 'width ' . $gallery_size_params['static_width'] . 'px ' :'') .
					(is_array($gallery_size_params) && isset($gallery_size_params['static_height'])? 'height ' . $gallery_size_params['static_height'] . 'px':'');
				return $error;
			}

			// если не вписываемся в допустимые габариты
			// то уменьшаем рисунок
msg(imageSX($im_orig), 'imageSX($im_orig)');
msg(imageSY($im_orig), 'imageSY($im_orig)');
			if (	imageSX($im_orig) > $i_max_width
				or
				imageSY($im_orig) > $i_max_height )
			{
msg(1);
				// упрощаем допустимые габариты до квадрата
				 //$i_max_width = $i_max_height = max ($i_max_width, $i_max_height);
vdump($i_max_width, '$i_max_width');
vdump($i_max_height, '$i_max_height');
				// если ширина меньше высоты (вертикальный img)
				// то пересчитаем допустимую ширину т.о.,
				// чтобы вписаться по высоте
				if (imageSX($im_orig) < imageSY($im_orig))				
					$i_max_width = imageSX($im_orig) / (imageSY($im_orig) / min ($i_max_width, $i_max_height));
//					$i_max_width = imageSX($im_orig) / (imageSY($im_orig) / $i_max_width);

//vdump($i_max_width, '$i_max_width');
//vdump($i_max_height, '$i_max_height');
				ImageCopyResized_2File($im_orig, $i_max_width, $ImgFileName, $im_func);
			}



			if (!ftpUpload($ImgFileName, $s_add_path.$FileName))
			{
				$error[] = 'Image file upload error: '.EE_FTP_PREFIX.EE_IMG_PATH.$FileName;
				return $error;
			}

			if (imageSX($im_orig) < imageSY($im_orig))
			{
				$i_thumbnail_width = $i_thumbnail_width / (imageSY($im_orig) / imageSX($im_orig));
			}

			ImageCopyResized_2File($im_orig, min($i_thumbnail_width, imageSX($im_orig)), $ImgFileNamePr, $im_func);

			ImageDestroy($im_orig);

			if (!ftpUpload($ImgFileNamePr, $s_add_path.'_'.$FileName))
			{
				$error[] = 'Thumbnail file upload error: '.EE_FTP_PREFIX.EE_IMG_PATH.'_'.$FileName;
				return $error;
			}
		}
	}
	return $FileName;
}

function ImageCopyResized_2File($image_orig, $image_width, $image_filename, $image_function)
{
//msg($image_width, '$image_width');
	$image_height = imageSY($image_orig)/(imageSX($image_orig)/$image_width);
//msg($image_height, '$image_height');

	$image = ImageCreateTrueColor($image_width, $image_height);
	ImageCopyResampled($image, $image_orig, 0, 0, 0, 0, imageSX($image)+1, imageSY($image)+1, imageSX($image_orig), imageSY($image_orig));
	$image_function($image, $image_filename);
	ImageDestroy($image);
}

/* Checking header of zip file,
	zip file begins with 50 4b 03 04 bytes */
function get_zip_header($file_name)
{
	$zip_header = '';
	if(check_file($file_name))
	{
		$fp = fopen($file_name, 'rb');		
		for($i = 0; $i < 4; $i++)
		{
			$zip_header.= dechex(ord(fgetc($fp)));
		}                           
		fclose($fp);                                                  		
	}
	else
	{
		$zip_header = false;
	}
	return $zip_header;
}


function get_next_order($object_name, $order_field_name, $gallery_id)
{

	if($object_name{0} == '_')
	{
		$object_name = substr($object_name,1);
	}		


	$object_id = Get_object_id_by_name($object_name);

	        $sql = 'SELECT max(CAST(item_order as DECIMAL)) FROM 
		('.create_sql_view_for_fields_filter_by_fields('record_id, gallery_id, '.$order_field_name,'gallery_id = '.$gallery_id, $object_id).') 
		v WHERE v.gallery_id = '.$gallery_id;

	$res = (int) getField($sql);		
	return ++$res;
}


?>
