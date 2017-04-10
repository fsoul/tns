<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	if (!defined('ADMIN_MENU_ITEM_HTML_VALIDATION')) define('ADMIN_MENU_ITEM_HTML_VALIDATION', 'Administration/HTMLvalidation');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_HTML_VALIDATION);

	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}


// HTML Validation (HV)


global $time_label, $html_valid_address, $url_check, $valid_pages_counter, $pages_amount;

$time_label = time();

$html_valid_address = 'http://validator.w3.org';

$url_check = 'check?uri=';

/**
 * Return ARRAY by URL of SITE-MAP in XML
 */
function HV_XML_into_ARRAY($xml_url) 
{
	$xml_data = @file_get_contents($xml_url);

	$res_array = array();

	$xml_l = xml_parser_create();
	xml_parse_into_struct($xml_l, $xml_data, $res_array);
	xml_parser_free($xml_l);

	$link_array = array();
	foreach($res_array as $k => $v)
	{
		if(strtolower($res_array[$k]['tag']) == 'loc')
		{
			$link_array[] = $res_array[$k]['value'];
		}
	}

	return $link_array;
}


/**
 * Function validate all pages and print result
 */
function HV_validate_all_pages($xml_url)
{
	global $pages_amount, $html_valid_address, $url_check, $valid_pages_counter;

	$text = '';

	$links_arr = HV_XML_into_ARRAY($xml_url);

	$pages_amount = count($links_arr);
	$valid_pages_counter = 0;

	foreach($links_arr as $k => $v)
	{
		$lp1 = '<div><b><a style="color:';
                $lp2 = '"; href="'.$html_valid_address.'/'.$url_check;
                $lp3 = '" target="_blank">';
                $lp4 = '</a></b></div>'."\r\n";

		if(check_url_on_validator($v))
		{
			$valid_pages_counter++;
			$text .= $lp1.'#060'.$lp2.$v.$lp3.$v.' - VALID'.$lp4;
		}
		else
		{
			$text .= $lp1.'#A00'.$lp2.$v.$lp3.$v.' - INVALID'.$lp4;
		}
		echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		flush();
	}

	return $text; 
}

function ee_urlencode($url)
{
	$ar_url = explode('/', $url);

	foreach($ar_url as $i => $str)
	{
		$ar_url[$i] = urlencode($str);
	}

	return implode('/', $ar_url);
}

/**
 * Functions for checking on W3 validator
 * Input string $_url
 * Input string $html_valid_address address of html validator site
 * Input string $check_method :
 * Work in two modes
 * post_content getting the page content ang post to the w3 validator. (providing the source code)
 * get_method get the link to the w3 validator.
 * Function returns the position of Valid Check server response. (true) if was not found return false
 */
function check_url_on_validator($_url, $html_valid_address = 'http://validator.w3.org', $check_method = 'post_content')
{
	global $error;

	$isvalid = false;

	switch ($check_method) 
	{
	//option post is used for check server even if it localy hosted
		case 'post_content':
		{
			$_url = parse_url($_url);

			$html_valid_address = parse_url($html_valid_address);
			$html_valid_address = $html_valid_address[host];
			//$fp_get_page_for_test = fsockopen($_url[host], 80, $errno, $errstr, 30);

			if (defined('EE_APACHE_LOGPASS'))
			{
				$myvar = "Authorization: Basic " . base64_encode(EE_APACHE_LOGPASS) . "\r\n";
			}
			else
			{
				$myvar = '';
			}

			$opts = array(
				'http'=>array(
				'method'=>"GET",
				'header'=>$myvar
				)
			);

			$context = stream_context_create($opts);
	
			$_url['path'] = ee_urlencode($_url['path']);

			$_doca_from_site = file_get_contents($_url['scheme']."://".$_url['host'].$_url['path'], false, $context);

			if (!$_doca_from_site)
			{
				$error['validator'] .= "Error was occured when try get the " . $_url . " $errstr ($errno)<br />\n";
			}
			else
			{

				$boundary = substr(rand(1147483, 2147483) . rand(0147483, 2147483), 0, 14);
			
				$data_to_site = "----$boundary\r\n";
				$data_to_site .= 'Content-Disposition: form-data; name="uploaded_file"; filename="'.rand(0147483, 2147483).'.html"' . "\r\n";
				$data_to_site .= 'Content-Type: text/html'."\r\n\r\n";
				$data_to_site .= $_doca_from_site . "\r\n\r\n";
				$data_to_site .= "----$boundary\r\n";
				$data_to_site .= 'Content-Disposition: form-data; name="doctype"' . "\r\n\r\n";
				$data_to_site .= "Inline\r\n\r\n";
				$data_to_site .= "----$boundary\r\n";
				$data_to_site .= 'Content-Disposition: form-data; name="ss"' . "\r\n\r\n";
				$data_to_site .= "1\r\n\r\n";
				$data_to_site .= "----$boundary\r\n";
				$data_to_site .= 'Content-Disposition: form-data; name="group"' . "\r\n\r\n";
				$data_to_site .= "0\r\n\r\n";
				$data_to_site .= "----$boundary\r\n";
				$data_to_site .= 'Content-Disposition: form-data; name="user-agent"' . "\r\n\r\n";
				$data_to_site .= 'W3C_Validator/1.606'."\r\n\r\n";
				$data_to_site .= "----$boundary--\r\n";
			
				$header = "POST /check HTTP/1.1\r\n";
				$header .= "Host: validator.w3.org\r\n";
				$header .= "User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; uk; rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4 (.NET CLR 3.5.30729)\r\n";
				$header .= "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n";
				$header .= "Accept-Language: uk,ru;q=0.8,en-us;q=0.5,en;q=0.3\r\n";
				$header .= "Accept-Encoding: gzip,deflate\r\n";
				$header .= "Accept-Charset: windows-1251,utf-8;q=0.7,*;q=0.7\r\n";
				$header .= "Keep-Alive: 300\r\n";
				$header .= "Connection: keep-alive\r\n";
				$header .= "Referer: http://validator.w3.org/check\r\n";
				$header .= "Cookie: W3C-checklink=recursive&on&depth&20&hide_type&all\r\n";
				$header .= "Content-Type: multipart/form-data; boundary=" . $boundary . "\r\n";
				$header .= "Content-Length: " . strlen($data_to_site) . "\r\n";
				$header .= "\r\n";
				$_doca_from_site = '';
				$fp_to_w3_validator = fsockopen($html_valid_address, 80, $errno, $errstr, 30);

				if (!$fp_to_w3_validator)
				{
					$error['validator'] .= "Error occured when trying to post content (" . $_url[path] . ") to " . $html_valid_address . " $errstr ($errno)<br />\n";
				}
				else
				{
					fwrite($fp_to_w3_validator, $header . $data_to_site);
					$_doca_from_site = '';
					while (!feof($fp_to_w3_validator))
					{
						$_doca_from_site = $_doca_from_site . fgets($fp_to_w3_validator, 128);
					}

					fclose($fp_to_w3_validator);

					//finds the answer from server
					if(strrpos( $_doca_from_site , 'X-W3C-Validator-Status: Valid' )==true) 
					{
						$isvalid=true;
					}
				}

			} //end of else		

		} //end of case

		break;
	
		//option get_method used when the validator server will check the url.
		case 'get_method':
		{
			$url_check = 'check?uri=';
			// In TITLE (<title>...</title>) must be label "[Valid]" if the URL is valid.
			$label_if_valid = "[Valid]";
			$result = @file_get_contents($html_valid_address . '/' . $url_check . $url);
			$valid_pos = strpos($result, $label_if_valid);
			if($valid_pos !== false)
			{
				$title_start_pos = strpos($result, '<title>');
				$title_end_pos   = strpos($result, '</title>');
				if($title_start_pos !== false && $title_end_pos !== false && $valid_pos > $title_start_pos && $valid_pos < $title_end_pos)
				{
					$isvalid = true;
				}
			}
		}
		break;
		
		default: 
		{
			$isvalid = false;
		}
		break;
	//end of switch
	}
	return $isvalid;
}


function HV_run_test()
{
	global $pages_amount, $url_check, $valid_pages_counter, $time_label;

	$res = '';

	if($_POST)
	{
		//Set unlimit time
		set_time_limit(0);

		$res = HV_validate_all_pages($_POST['input_url']);
	
		$time_label = time() - $time_label;
		$res .=  '<hr/><div><i>Spent time: <b>'.$time_label.' second</b></i><br /><br />'.
			 '<span style="color:#060;"><i>Valid pages: <b>'.$valid_pages_counter.'</b></i></span><br />'.
			 '<span style="color:#A00;"><i>Invalid pages: <b>'.($pages_amount - $valid_pages_counter).'</b></i></span><br />'.
			 '<i>Total pages: <b>'.$pages_amount.'</b></i></div>';
	}
	return $res;
}

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array();

		return parse_self_test($ar_self_check);
	}
	
	switch ($op)
	{
		default:
		case '0': echo parse($modul.'/list'); break;
		case 'self_test': echo print_self_test(); break;
	}
?>