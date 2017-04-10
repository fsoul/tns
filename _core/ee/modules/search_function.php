<?php
/**
 * ������� ��� ��������� ��������� ��������� ���� ��������
 * ������������ � ������ get_search_results ��� ���������� �� ��������
 *
 * @param array $ar1 ��������� 1
 * @param array $ar2 ��������� 2
 * @return ���������� 0 ��� 1
 */
function cmp_function($ar1,$ar2)
{
	if ($ar1['rank']>$ar2['rank'])
		return -1;
	else if ($ar1['rank']<$ar2['rank'])
	{
		$ar1 = $ar2;
		return 1;
	}
	return 0;
}
/**
 * ������� ��������� ���������� ������� $search_results_sorted � $search_results ������������ ������
 * ���������� - �� ��������, � ������� ������������ ���� �� ���� �� ����.
 * @param string $search_str ������ ������
 * @param unknown_type $language ���� ��� ������ , ���� �������� �� ����������, �� ������ �� ����� �� ���������
 */
function get_search_results($search_str,$language="")
{
	$search_str = preg_replace("/[\n\r\s|]+/is"," ",$search_str);
	$search_str = preg_replace("/ /","|",$search_str);

	if (strlen($search_str)<=get_config_var("search_minimal_characters_to_search"))
	{
		global $is_short_search_str;
		$is_short_search_str = 1;
		return;
	}
	global $t,  $search_results_sorted;
	global $default_language;
	global $search_results_count;

	$search_results_sorted = array();

	if ($page_t==$t)
		return;

	if ($language=="")
	{
		$language = $default_language;
	}

	$res = array();
	$r = ViewSQL("SELECT * FROM v_search_tpl_pages WHERE language_code='".$language."'");

	$rank_page_name = get_config_var("search_rate_page_name");
	$rank_page_title = get_config_var("search_rate_page_title");
	$rank_page_keywords = get_config_var("search_rate_page_keywords");
	$rank_page_content = get_config_var("search_rate_page_content");
	$rank_media_library = get_config_var("search_rate_media_library");

	$search_results = array();
	$page_t = $t;
	$i=0;

	while($f = db_sql_fetch_assoc($r))
	{
		global $remove_tags_with_content, $remove_tags_except;

	  $f['meta_title'] = cms('meta_title', $f['language_code'], $f['id']);
	  $f['meta_description'] = cms('meta_description', $f['language_code'], $f['id']);
	  $f['meta_keywords'] = cms('meta_keywords', $f['language_code'], $f['id']);

		$tpl_page_rank = 0;
		$t = $f["id"];
		$_GET['t'] = $f["id"];
		$GLOBALS['t'] = $f["id"];

		$html = get_body_clear_text(parse($t), $remove_tags_with_content, $remove_tags_except);
		$temp = array();
		$tpl_page_rank = $rank_page_name*preg_match_all("/".$search_str."/i",$f["page_name"],$temp)+
						 $rank_page_title*preg_match_all("/".$search_str."/i",$f["meta_title"],$temp)+
						 $rank_page_keywords*preg_match_all("/".$search_str."/i",$f["meta_keywords"],$temp)+
						 $rank_page_content*preg_match_all("/".$search_str."/i",$html,$temp);

		if ($tpl_page_rank != 0)
		{
			$search_results[$i]["link"]  = EE_HTTP.get_default_aliase_for_page($f["id"]);
			$search_results[$i]["title"] = $f["meta_title"];
			$search_results[$i]["rank"]  = $tpl_page_rank;
			$i++;
		}
	}

	$search_results_count = count($search_results);

	uasort($search_results, "cmp_function");//���������� �����������
	$i = 0;
	foreach ($search_results as $key=>$value)
		$search_results_sorted[$i++] = $value;

	$t = $page_t;
	return;
}
/**
 * ���������� ���������� ������ $search_results_sorted � �������, ������� ������������ ����������
 *
 * @param unknown_type $tpl ������ ��� ����������� ������ ����������
 * @return ��������� �������
 */

function show_search_results($tpl)
{
	global $search_results_sorted;
	return parse_array_to_html($search_results_sorted, $tpl);
}

?>