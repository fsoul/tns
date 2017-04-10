<?php

require_once(EE_CORE_PATH.'modules/securimage_class.php');

class AccessPanel_Securimage extends Securimage {

	var $image_width = 84;
	var $image_height = 24;
	var $code_length = 6;
	var $font_size = 10;
	var $text_minimum_distance = 11;
	var $text_maximum_distance = 12;
	var $use_list_from_db  = false;
	var $text_x_start = 14;


	public function enable_use_list_from_db()

	{
		$this->set_use_list_from_db(true);
	}

	public function disable_use_list_from_db()
	{
		$this->set_use_list_from_db(false);
	}

	public function set_use_list_from_db($s)
	{
		$this->use_list_from_db = (bool)$s;
	}

	public function set_image_width($s)
	{
		if (($s=(int)$s)>0)
		{
			$this->image_width = $s;
		}
	}

	public function set_image_height($s)
	{
		if (($s=(int)$s)>0)
		{
			$this->image_height = $s;
		}
	}

	public function set_code_length($s)
	{
		if (($s=(int)$s)>0)
		{
			$this->code_length = $s;
		}
	}

	public function set_font_size($s)
	{
		if (($s=(int)$s)>0)
		{
			$this->font_size = $s;
		}
	}

	public function set_text_minimum_distance($s)
	{
		if (($s=(int)$s)>0)
		{
			$this->text_minimum_distance = $s;
		}
	}

	public function set_text_maximum_distance($s)
	{
		if (($s=(int)$s)>0)
		{
			$this->text_maximum_distance = $s;
		}
	}

	public function set_text_x_start($s)
	{
		if (($s=(int)$s)>0)
		{
			$this->text_x_start = $s;
		}
	}

	public function set_image_bg_color($s)
	{
		$this->image_bg_color = $s;
	}

/*

  var $image_type = SI_IMAGE_JPG;
  var $charset = 'ABCDEFGHKLMNPRSTUVWYZ23456789';
  var $wordlist_file = 'words.txt';
  var $use_wordlist  = false;
  var $use_gd_font = false;
  var $gd_font_file = 'gdfonts/crass.gdf';
  var $gd_font_size = 5;
  var $ttf_file = EE_CAPTCHA_FONT_FILE;
  var $text_x_start = 8;
  var $text_angle_minimum = -5;
  var $text_angle_maximum = 5;
  var $image_bg_color = "#606851";
  var $use_multi_text = false;
  var $multi_text_color = "#0a68dd,#f65c47,#8d32fd";
  var $use_transparent_text = false;
  var $text_transparency_percentage = 15;
  var $draw_lines = false;
  var $line_color = "#80BFFF";
  var $line_distance = 5;
  var $line_thickness = 1;
  var $draw_angled_lines = false;
  var $draw_lines_over_text = false;
  var $arc_linethrough = false;
  var $arc_line_colors = "#8080ff";
  var $audio_path = './audio/';
*/


	function output()
	{
		header("Cache-Control: no-store, no-cache, must-revalidate"); 
		header("Expires: " . date("r"));
																																																							
		switch($this->image_type)
		{
			case SI_IMAGE_JPG:
				header("Content-Type: image/jpeg");
				imagejpeg($this->im, null, 90);
				break;

			case SI_IMAGE_GIF:
				header("Content-Type: image/gif");
				imagegif($this->im);
				break;

			default:
				header("Content-Type: image/gif");
				imagepng($this->im);
				break;
		}

		imagedestroy($this->im);
	}

}

