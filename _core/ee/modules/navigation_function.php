<?php

//        Генерация строки навигации
function navigation($rows_total, $rows_on_page = 1, $current_page = 1, $tpl = 'templates/navigation/default', $pages_in_block = 10, $page_id = null)
{
	if (empty($rows_on_page))
	{
		$rows_on_page = 1;
	}

	if (empty($pages_in_block))
	{
		$pages_in_block = 10;
	}

	$s = '';

	$totPages = ceil($rows_total / $rows_on_page);

	$URL = $_SERVER["QUERY_STRING"];

	if (empty($URL))
	{
		$URL = 't='.get('t').'&language='.getValueOf('language');
	}

	$arr = array();
	$url_params = array();

	parse_str($URL, $arr);

	$ar_standart_param = array('srt', 'click', 'page', 'load_cookie');

	foreach ($arr as $key=>$val)
	{
		if (!in_array($key, $ar_standart_param))
		{
			$url_params[] = ($key.'='.$val);
		}
	}

	$url_params[] = 'load_cookie=true';

	if (is_null($page_id))
	{
		$URL = EE_SCRIPT_NAME;
	}
	else
	{
		$URL = get_href($page_id);
		$URL = trim_str($URL, EE_HTTP_SERVER);

		global $language;
		$URL = convert_to_utf($URL, $language);
	}

	$URL.= '?';


	if (checkAdmin() && count($url_params)>0)
	{
		$URL.= implode('&', $url_params).'&';
	}

	$current_page_block = ((int)(($current_page - 1) / $pages_in_block)) + 1;
	$first_page_in_current_page_block = ($current_page_block - 1) * $pages_in_block + 1;
	$last_page_in_current_page_block = min($totPages, $current_page_block * $pages_in_block);

	$arr = array();

	for ($i_arr=0, $i=$first_page_in_current_page_block-1; $i<$last_page_in_current_page_block; $i_arr++, $i++)
	{
	
		$arr[$i_arr]['page_url_first'] = $URL.'page=1';
		$arr[$i_arr]['page_url_prev'] = ($current_page > 1 ? $URL.'page='.($current_page - 1) : '');
		$arr[$i_arr]['page_url_prev_block'] = ($first_page_in_current_page_block > 1 ? $URL.'page='.($first_page_in_current_page_block - 1) : '');

		$arr[$i_arr]['page_url'] = ($current_page != ($i + 1) ? $URL.'page='.($i + 1) : '');

		$arr[$i_arr]['page_number'] = $i + 1;
		$arr[$i_arr]['page_url_next_block'] = ($last_page_in_current_page_block < $totPages ? $URL.'page='.($last_page_in_current_page_block + 1) : '');
		$arr[$i_arr]['page_url_next'] = ($current_page < $totPages ? $URL.'page='.($current_page + 1) : '');
		$arr[$i_arr]['page_url_last'] = $URL.'page='.$totPages;
		$arr[$i_arr]['first_displayed'] = $rows_on_page * ($current_page - 1) + 1;
		$arr[$i_arr]['last_displayed'] = ($rows_total<($rows_on_page * $current_page) ? $rows_total : $rows_on_page * $current_page);
		$arr[$i_arr]['rows_total'] = $rows_total;
		$arr[$i_arr]['pages_total'] = $totPages;
	}

	if ($rows_total == 0)
	{
		$arr[0]['pages_total'] = $arr[0]['first_displayed'] = $arr[0]['last_displayed'] = $arr[0]['rows_total'] = 0; 
	}

	$s = parse_array_to_html($arr, $tpl);
	
	return $s;
}

?>
