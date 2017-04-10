<?php
$remove_tags_with_content = array("script","style");
$remove_tags_except = array("");

function remove_tags_with_content($html, $tags2remove)
{
	foreach ($tags2remove as $tagname) {
		$html = preg_replace("|<\s*".$tagname."[^<>]*>.*?</\s*".$tagname."[^<>]*>|is","",$html);
	}
	return $html;
}

function remove_tags($html, $except_tags)
{
	return strip_tags($html,"<".join(">,<",$except_tags).">");
}

function clear_html_chars ($html) {
	$html = preg_replace("/&\w{2,10}?;/is"," ",$html); // ������ html ��������� (&nbsp;, &quot; � �.�.) �� �������
	$html = preg_replace("/&#[abcdef\d]{2,6}?;/is"," ",$html); // ������ �������� ���������� ����� ���� �� ������� (���� &#90;)
	return $html;
}

function get_clear_text($html, $remove_tags_with_content, $remove_tags_except)
{
	//text conversion
//		$html = preg_replace("/[\n\r]+/is"," ",$html); // ������ ��������� ������ �� ������� 
	$html = remove_tags_with_content($html,$remove_tags_with_content);
	$html = remove_tags($html,$remove_tags_except); 
//	$html = strip_tags($html,"<".join(">,<",$remove_tags_except).">");
	$html = preg_replace("/[\n\r\s|]+/is"," ",$html); // ������ ������������� ��������, ��������� ������
	$html = trim($html);
	return $html;
}

function get_body_clear_text($html,$remove_tags_with_content,$remove_tags_except)
{
	//cut body
	//$linebreaks = array("\n","\r");
	//$html = str_replace($linebreaks,"",$html);
	if (preg_match('|<\s*body[^<>]*>(.*)</\s*body[^<>]*>|is',$html,$results)>0) {
		$html = $results[1];	
	} else {
		$html ="";
	}
	$html = get_clear_text($html, $remove_tags_with_content, $remove_tags_except);
	return clear_html_chars($html);
}

?>