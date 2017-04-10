<?
	function get_image_size($file_name)
	{
		if (check_file($file_name) && filesize($file_name))
			$res = getimagesize($file_name);
		else
			$res = array(
				0, 0, 0, "", "bits"=>0, "channels"=>0, "mime"=>""
			);

		return $res;
	}

	function get_img_size_html($file_name)
	{
		$ret = get_image_size($file_name);
		return $ret[3];
	}

?>