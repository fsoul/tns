<?
	$admin = true;
	$UserRole = 0;

	include_once('../lib.php');

	//todo: verify EE_URI for incorrect "../" etc and remove them
	/*
		IF EE_ADMIN_SECTION_IN_HTACCESS == cms

		/folder1/folder2_cms/cms_folder_3/site_cms/cms/dns.php?LANG=en
		
		1) Divide url:

			A - /folder1/folder2_cms/cms_folder_3/site_cms/
			B - dns.php
			C - ?LANG=en

		2)     A + EE_ADMIN_SECTION + B
	*/

	$url_arr = parse_url(EE_URL);

	//$url_arr['path'] examples: //localhost/rwclub/e-management/_contact_us.php or /rwclub/e-management/index.php
	$end_url = preg_replace('|^(http:\|https:)?(//)?('.EE_HTTP_HOST.')?('.EE_HTTP_PREFIX.')('.EE_ADMIN_SECTION_IN_HTACCESS.')(.*)|i', '$6', $url_arr['path']);

	$included_file_name = EE_PATH.EE_ADMIN_SECTION.$end_url;

	$result_file = get_custom_or_core_file_name($included_file_name);

	if (!check_file($result_file))
	{
		$result_url = EE_ADMIN_URL.'index.php';

		header('Location: '.$result_url);
	}
	else
	{
		include($result_file);
	}

	//Delete function for selected items in grid
	function del_selected_items($type_of_module = '')
	{
		switch($type_of_module)
		{
			case '_news_letters':
				$del_function = 'nl_emails_delete';break;
			case '_nl_subscribers':
				$del_function =	'nl_subscribers_delete';break;
			case 'object':
				$del_function =	'f_del_object_records';break;
			case 'object_content':
				/*
				** 'Object content' consists of two id's (id, record_id)
				** $id1 - array of id's; $id2 - array of record_id's
				*/
				foreach($_POST['selected_items'] as $value)
				{
				   list($id1[],$id2[]) = explode('|', $value);	
				}
				$del_function = 'f_del_object_contents';
				$double_id = true;break;
			default:
				$del_function = 'f_del'.$type_of_module.'s';

		}
		if(array_key_exists('selected_items', $_POST) && count($_POST['selected_items']) > 0)
		{            
			if($double_id)
				$del_function($id1, $id2);
			else
				$del_function($_POST['selected_items']);
		}
	}
	function del_selected_rows($type_of_module = '')
	{
		$del = $_GET['del'];
		$multi_id = false;
		$del_array = explode('|',$del);
		$del_items = ((is_array($del_array) && count($del_array) > 0) ? $del_array : array($del));
		switch($type_of_module)
		{
			case '_news_letters':
				$del_function = 'nl_emails_delete';break;
			case '_nl_subscribers':
				$del_function =	'nl_subscribers_delete';break;
			case 'object':
				$del_function =	'f_del_object_records';break;
			case '_object_content':
				/*
				** 'Object content' consists of two id's (id, record_id)
				** $id1 - array of id's; $id2 - array of record_id's
				*/
				
				$field_ids = $record_ids = $languages = array();
				foreach($del_items as $value)
				{
					list($field_ids[], $record_ids[], $languages[]) = explode(':', $value);	
				}
				$del_function = 'f_del_object_contents';
				$multi_id = true;
				break;
			default:
				$del_function = 'f_del'.$type_of_module.'s';

		}
		if($multi_id)
		{
			$del_function($field_ids, $record_ids, $languages);
		}
		else
		{
			$del_function($del_items);
		}
	}

?>