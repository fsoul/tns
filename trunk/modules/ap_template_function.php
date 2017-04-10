<?

define('PAGES_IN_BLOCK', 5);

define('SURVEY_HISTORY_ROWS_ON_PAGE', 20);
define('SURVEY_HISTORY_PAGES_IN_BLOCK', PAGES_IN_BLOCK);

define('INVESTIGATIONS_ROWS_ON_PAGE', 3);
define('INVESTIGATIONS_PAGES_IN_BLOCK', PAGES_IN_BLOCK);

define('NEWS_ROWS_ON_PAGE', 5);
define('NEWS_PAGES_IN_BLOCK', PAGES_IN_BLOCK);

define('OPTION_VALUE_DEFAULT', '...'); // instead of -1, for text "..."
define('OPTION_VALUE_OTHER', '-'); // instead of 0, for text cons('Other')


function ap_numbers_to_options($from, $to, $current=null, $function_name=null, $reverse=false)
{
	for ($i=$from; $i<=$to; $i++)
	{
		$ar[$i-$from]['option_value'] = $i;
		$ar[$i-$from]['option_text'] = $i;
		$ar[$i-$from]['option_value_test'] = $current;

		if (function_exists($function_name))
		{
			$ar[$i-$from]['option_text'] = $function_name($ar[$i-$from]['option_text']);
		}
	}

	if ($reverse)
	{
		$ar = array_reverse($ar);
	}

	$res = parse_array_to_html($ar, 'option');

	return $res;
}

function ap_numbers_to_radio($from, $to, $input_name, $current=null, $function_name=null, $reverse=false)
{
    for ($i=$from; $i<=$to; $i++)
    {
        $ar[$i-$from]['option_value'] = $i;
        $ar[$i-$from]['option_text'] = $i;
        $ar[$i-$from]['option_value_test'] = $current;
        $ar[$i-$from]['input_name'] = $input_name;

        if (function_exists($function_name))
        {
            $ar[$i-$from]['option_text'] = $function_name($ar[$i-$from]['option_text']);
        }
    }

    if ($reverse)
    {
        $ar = array_reverse($ar);
    }

    $res = parse_array_to_html($ar, 'radio');

    return $res;
}

function ap_month_name($m)
{
	$m = (int)$m;

	$m = max($m, 1);
	$m = min($m, 12);

/*
	$ar_m = array(
	'JANUARY',
	'FEBRUARY',
	'MARCH',
	'APRIL',
	'MAY',
	'JUNE',
	'JULY',
	'AUGUST',
	'SEPTEMBER',
	'OCTOBER',
	'NOVEMBER',
	'DECEMBER'
	);
*/
	return conv_from_utf(cons(date("F", mktime(0, 0, 0, $m, 1, 2000))));
}

function conv_from_utf($str)
{
	return iconv('windows-1251', "utf-8//IGNORE", $str);
	//return $str;
}

function conv_utf($str)
{
    //return iconv("utf-8", getCharset().'//IGNORE', $str);
	return $str;
}

function ap_select_dictionary_options($id_field_name, $value_field_name, $selected_value=null, $from, $filter_field_name=null, $filter=null, $html_el='option', $input_name='')
{
    $ar = array();
    if($html_el == 'option') {
        $ar[] = array('option_value'=>OPTION_VALUE_DEFAULT, 'option_text'=>'...', 'option_value_test'=>$selected_value);
    }
    $dbRequest = initHttpReq();

    switch($from){
        case 'convert_type_list':
            $res = $dbRequest->dic_score_convert_type_list();
            $ar = option_format($res,'dic_score_convert_type_id','convert_type_name', $ar);
            break;
        case 'ap_dic_region':
            $res = $dbRequest->dic_region_list();
            $ar = option_format($res,'dic_region_id','region_name', $ar);
            break;
        case 'ap_dic_area':
            if(empty($filter))
                break;
            $res = $dbRequest->dic_area_list($filter);
            $ar = option_format($res,'dic_area_id','name',$ar);
            break;
        case 'ap_dic_city':
            if(empty($filter))
                break;
            $res = $dbRequest->dic_city_list($filter);
            $ar = option_format($res,'dic_city_id','city_name',$ar);
            break;
        case 'dic_info_source':
            $res = $dbRequest->dic_info_source_list();
            $ar = option_format($res,'dic_info_source_id','source_name',$ar);
            break;
    }

    if (!in_array($from, array('ap_dic_area', 'ap_dic_region', 'ap_dic_city', 'dic_inet_device')))
    {
        $ar[] = array('option_value'=>OPTION_VALUE_OTHER, 'option_text'=>cms_cons('Other'), 'option_value_test'=>$selected_value);
    }
	foreach($ar as $i => $ar_row)	{
		$ar[$i]['option_text'] = conv_from_utf($ar[$i]['option_text']);
		$ar[$i]['input_name'] = $input_name;
	}

	$res = parse_array_to_html($ar, $html_el);
	return $res;
}
function option_format($res, $option_value, $option_text, $ar){
    if(!is_array($ar)){
        $ar = array();
    }
    foreach($res as $key => $obj){
        $ar2 = array();
        $ar2['option_value'] = $res[$key][$option_value];
        $ar2['option_text'] = iconv('utf-8','windows-1251',$obj[$option_text]);
        $ar[] = $ar2;
    }
    return $ar;
}

function ap_select_city_options_from_region($filter=null)
{
    return;
    /*$ar[] = array('option_value'=>OPTION_VALUE_DEFAULT, 'option_text'=>'...');
    $oci = ap_oci_init();

    if (is_object($oci))
    {
        $sql = 'b36_director.access_package.set_district_restriction';
        $params = array('district_id_' => ((int)$filter));
        $res = $oci->sp($sql, $params, 0, 0);

        $sql = '

                SELECT MIN(region_id) AS value
                  FROM '.strtoupper('b36_director.v_region').'
              GROUP BY region_name';
        $regions = $oci->get_query_as_array($sql);
        //var_dump($regions, '$regions');

        foreach($regions as $reg_id) {
            $sql = 'b36_director.access_package.set_region_restriction';
            $params = array('region_id_' => ((int)$reg_id['value']));
            $res = $oci->sp($sql, $params, 0, 0);
        }
        $sql = '
                SELECT MIN(city_id) AS option_value,
                       city_name AS option_text
                  FROM '.strtoupper('b36_director.v_city').'
                  WHERE city_type_id = 6
              GROUP BY
                       city_name
                 ORDER
                    BY 2';
        $ar_query = $oci->get_query_as_array($sql);
       // var_dump($ar_query, '$ar_query');
        $ar_query[0]['option_value_test'] = $ar_query[0]['option_value'];
        $ar = array_merge($ar, $ar_query);
    }

    foreach($ar as $i => $ar_row)
    {
        $ar[$i]['option_text'] = conv_from_utf($ar[$i]['option_text']);
    }

    $res = parse_array_to_html($ar, 'option');

    return $res;*/
}

function ap_select_district_options($current=null)
{
	$return = ap_select_dictionary_options('dic_region_id', 'region_name', $current, 'ap_dic_region');

	return $return;
}

function ap_select_region_options($filter=null, $current=null)
{
	$return = ap_select_dictionary_options('dic_area_id', 'name', $current, 'ap_dic_area', 'dic_region_id', $filter);

	return $return;
}

function ap_select_city_options($filter=null, $current=null)
{
	return ap_select_dictionary_options('dic_city_id', 'city_name', $current, 'ap_dic_city', 'dic_area_id', $filter);
}

function ap_select_settlement_options($filter=null, $current=null)
{
	$return = ap_select_dictionary_options('settlement_id', 'settlement_name', $current, 'dic_settlement', 'dic_city_id', $filter);

	return $return;
}

function ap_select_street_options($filter=null, $current=null)
{
	return ap_select_dictionary_options('street_id', 'street_name', $current, 'dic_street', 'dic_settlement_id', $filter);
}

function ap_select_know_about_options($filter=null, $current=null)
{
    // we transfer language in filter field for this function
	//return ap_select_dictionary_options('dic_info_source_id', 'source_name_'.$filter, $current, 'dic_info_source');
	return ap_select_dictionary_options('dic_info_source_id', (strtolower($filter)=='ua'?'source_name':'source_name_ru'), $current, 'dic_info_source');
}

function ap_inet_device_options($filter=null, $current=null)
{
	return ap_select_dictionary_options('dic_inet_device_id', (strtolower($filter)=='ua'?'inet_device_name_ukr':'inet_device_name'), $current, 'dic_inet_device');
}

function ap_inet_device_radio($filter=null, $current=null)
{
	return ap_select_dictionary_options('dic_inet_device_id', (strtolower($filter)=='ua'?'inet_device_name_ukr':'inet_device_name'), $current, 'dic_inet_device', null, null, 'radio', 'using_machine');
}

function ap_check_hash_code()
{
	if (	array_key_exists('sid', $_GET) &&
		!empty($_GET['sid'])
	)
	{
		$resp = ap_resp_init();

		$res = (int)$resp->Reset_Password_Check_Hash_Code($_GET['sid']);
	}
	else
	{
		$res = 0;
	}

	return $res;
}

function nl2br_page_cms($var)
{
	return nl2br(page_cms($var));
}

function nl2br_cms($var)
{
	return nl2br(cms($var));
}


function ap_current_projects_list2($tpl='current_projects_row')
{
	return ap_current_projects_list(null, $tpl);
}


function ap_current_projects_list($rows_limit=null, $tpl='current_projects_row')
{
    global $language;
    $dbRequest = initHttpReq();
    $ar = $dbRequest ->active_project_list(ap_get_respondent_id());
    $ar = UTF2Win($ar);
	foreach($ar as $i => $ar_row)
	{
		$ar[$i]['project_name'] = ($language=='UA'?conv_from_utf($ar[$i]['poll_subject_ukr']):conv_from_utf($ar[$i]['poll_subject']));
		$ar[$i]['project_description'] = ($language=='UA'?conv_from_utf($ar[$i]['poll_invite_ukr']):conv_from_utf($ar[$i]['poll_invite_rus']));
	}

	return parse_array_to_html($ar, $tpl);
}

function UTF2Win($data){
    if(is_array($data)){
        foreach($data as $i => $field)
            $data[$i] = UTF2Win($field);
        return $data;
    }
    return iconv('utf-8','windows-1251',$data);
}

function ap_project_points_label($points)
{
    $ar_sufix['UA'][0]='iв';
    $ar_sufix['UA'][1]='';
    $ar_sufix['UA'][2]='а';
    $ar_sufix['UA'][3]='а';
    $ar_sufix['UA'][4]='а';
    $ar_sufix['UA'][5]='iв';
    $ar_sufix['UA'][6]='iв';
    $ar_sufix['UA'][7]='iв';
    $ar_sufix['UA'][8]='iв';
    $ar_sufix['UA'][9]='iв';

	$sufix = (int)substr(''.$points, -1);

	global $language;

	return $points.' '.cons('point').$ar_sufix[$language][$sufix];
}


function lipsum($count=1, $type=1, $offset=1)
{
	$txt = file_get_contents(EE_PATH.'lipsum.txt');

	switch($type)
	{
		default:
		case 1: // paragraphs
			$delimeter = "\r\n";
			$start_tag = '<p>';
			$end_tag = '</p>';
			$joiner = $end_tag.$start_tag;

			break;

		case 2:
			$delimeter = '.';
			$start_tag = '';
			$end_tag = $delimeter;
			$joiner = $delimeter.' ';

			break;

		case 3: // ?????
			$delimeter = ' ';
			$start_tag = '';
			$end_tag = '';
			$joiner = $delimeter;

			break;
	}

	$ar = explode($delimeter, $txt, $count+$offset);

	if ($offset>1)
	{
		array_splice($ar, 0, $offset-1);
	}

	unset($ar[$count]);

	$txt = $start_tag.implode($joiner, $ar).$end_tag;

	return $txt;
}


function ap_survey_history($current_page=1){
    global $language;

    $dbRequest = initHttpReq();
    $ar = $dbRequest ->complete_project_list(ap_get_respondent_id());
    //$ar = UTF2Win($ar);
    $ar = $ar['complete_project_list'];

    foreach($ar as $i => $val){
        $ar[$i]['survey_title'] = ($language == 'UA'?$ar[$i]['project_name_ukr']:$ar[$i]['project_name']);
        $ar[$i]['survey_title'] = iconv('utf-8','windows-1251',$ar[$i]['survey_title']);
        $ar[$i]['survey_date'] = date('d.m.Y',strtotime( $ar[$i]['complete_date'] ));
        $ar[$i]['survey_points'] = $ar[$i]['point_num'];
        $ar[$i]['points_convertion'] = $ar[$i]['data_type'];
    }
	if (count($ar)){
		foreach($ar as $i => $ar_row){
			$ar[$i]['survey_title'] = conv_from_utf($ar[$i]['survey_title']);
		}

		if (count($ar)<=SURVEY_HISTORY_ROWS_ON_PAGE){
			$current_page = null;
		}
		$res = parse_array_to_html($ar, 'survey_history_row', $current_page, SURVEY_HISTORY_ROWS_ON_PAGE, 'survey_history_navigation', SURVEY_HISTORY_PAGES_IN_BLOCK, getValueOf('t'));
	}
	else{
		$res = parse('survey_history_no_info');
	}

	return $res;
}

function show_points(){
    $dbRequest = initHttpReq();
    $ar = $dbRequest ->complete_project_list(ap_get_respondent_id());
    $ar = $ar['complete_total'];

    $res = parse_array_to_html($ar, 'show_points');

    return $res;
}

function ap_points_available(){

    $dbRequest = initHttpReq();
    $res = $dbRequest -> complete_project_list(ap_get_respondent_id());
    return $res['complete_total'][0]['balance_point_num'];
}


function ap_right_block_news($news_count=0)
{
	return ap_news_list(EE_PATH.'templates/menu/right_block_news_row', $news_count);
}

function ap_homepage_news_list($news_count=0, $current_page=null)
{
	return ap_news_list('homepage_news_list', $news_count, 0, null, $current_page=null);
}

function ap_news_detail($news_id)
{
	return ap_news_list('int_news_detail_row', 0, 0, $news_id);
}


function ap_news_list_other($current_page)
{
	$ar = ap_news_array(1000000, 1, null, $current_page);

	if (count($ar)==0)
	{
		$res = '';
	}
	else
	{
//$current_page = null;
		$res = parse_array_to_html($ar, 'int_news_list_other_row', $current_page, NEWS_ROWS_ON_PAGE, 'survey_history_navigation', NEWS_PAGES_IN_BLOCK, getValueOf('t'));

		$res =	parse('int_news_list_other_top').
			$res.
			parse('int_news_list_other_bottom');

	}

	return $res;
}


function ap_news_list($tpl, $news_count=0, $news_start_from=0, $news_id=null, $current_page=null)
{
	$ar = ap_news_array($news_count, $news_start_from, $news_id, $current_page);

	if (	!is_null($news_id) &&
		count($ar)==0
	)
	{
		parse_error_code('404');
	}

	$res = parse_array_to_html($ar, $tpl, $current_page, NEWS_ROWS_ON_PAGE, 'survey_history_navigation', NEWS_PAGES_IN_BLOCK, getValueOf('t'));

	return $res;
}

function ap_news_array($news_count=0, $news_start_from=0, $news_id=null, &$current_page=null)
{
	$sql = '
          SELECT
                 record_id AS news_id,
                 ap_news_img AS news_img,
                 ap_news_date AS news_date,
                 ap_news_title AS news_title,
                 ap_news_preview AS news_preview'.
	( !is_null($news_id) ? ',
                 ap_news_content AS news_content' : '' ).'

            FROM
                 ('.create_sql_view_by_name('ap_news').') AS ap_news'.
	( !empty($news_id) ? '
           WHERE record_id='.sqlValue($news_id) : '
           ORDER
              BY 3 DESC, 1 DESC'.( $news_count>0 || $news_start_from>0 ?'

           LIMIT '.($news_start_from>0 ? ($news_start_from-1).',' : '' ).$news_count : '' ).'
        ' ). '
        ';
//vdump($sql, '$sql');
	$ar = SQLRes2Array(viewsql($sql));
	if (is_array($ar) && array_key_exists('row', $ar))
	{
		$ar = $ar['row'];
	}
	else
	{
		$ar = array();
	}

	if (	count($ar) <= NEWS_ROWS_ON_PAGE
		||
		empty($current_page)
	)
	{
		$current_page = null;
	}

	return $ar;
}

function ap_ratings_detail($_id,$section=0)
{
    //return ap_ratings_list('int_news_detail_row', 0, 0, $news_id);
    $sql = '
          SELECT
                 record_id AS investigation_id,
                 ap_ratings_date AS investigation_date,
                 ap_ratings_title AS investigation_title,
                 ap_ratings_preview AS investigation_preview,
                 ap_ratings_content AS investigation_content

            FROM
                 ('.create_sql_view_by_name('ap_ratings').') AS ap_ratings
            WHERE ap_ratings_section = '.(int)$section.'
          '.( empty($_id) ? '' : '
           AND
                 record_id='.sqlValue($_id) ).'
           ORDER
              BY 2 DESC, 1 DESC

           LIMIT 0,1
        ';

    $ar = SQLRes2Array(viewsql($sql));
    $ar = $ar['row'];


    if (count($ar)==0 && !empty($_id))
    {
        parse_error_code('404');
    }

    $res = parse_array_to_html($ar, 'int_investigation_detail_row');

    return $res;
}

function ap_ratings_list($current_page,$section=0)
{
    $_id = get('id');

    $sql = '
          SELECT
                 record_id AS investigation_id,
                 ap_ratings_date AS investigation_date,
                 ap_ratings_title AS investigation_title,
                 ap_ratings_preview AS investigation_preview

            FROM
                 ('.create_sql_view_by_name('ap_ratings').') AS ap_ratings
            WHERE ap_ratings_section = '.(int)$section.'
          '.( empty($_id) ? '' : '
           AND
                 record_id!='.sqlValue($_id) ).'
           ORDER
              BY 2 DESC, 1 DESC
        ';

    $ar = SQLRes2Array(viewsql($sql));
    $ar = $ar['row'];


    if (empty($_id))
    {
        array_shift($ar);
    }

    if (count($ar) <= INVESTIGATIONS_ROWS_ON_PAGE)
    {
        $current_page = null;
    }

    if(count($ar)>0) {
        $res = parse_array_to_html($ar, 'int_ratings_list_row', $current_page, INVESTIGATIONS_ROWS_ON_PAGE, 'survey_history_navigation', INVESTIGATIONS_PAGES_IN_BLOCK, getValueOf('t'));
    } else {
        $res = '';
    }

    return $res;
}

function ap_ratings_detail_link($_id, $section = 0)
{
    if ($section == 1) {
        return ap_object_detail_link('ratings-news', $_id);
    } elseif ($section == 2) {
        return ap_object_detail_link('ratings-sports', $_id);
    } else {
        return ap_object_detail_link('ratings-auto', $_id);
    }
}

function ap_right_block($block_name, $page_flag=false)
{
	$ar[0] = array(
		'block_name'	=>	$block_name,
		'page_flag'	=>	( $page_flag ? 'page_' : '' )
	);

	return parse_array_to_html($ar, 'right_block');
}



function ap_news_detail_link($_id)
{
	return ap_object_detail_link('news', $_id);
}

function ap_investigation_detail_link($_id)
{
	return ap_object_detail_link('rezultaty_doslidzhen', $_id);
}

function ap_object_detail_link($page_unique_name, $obj_id)
{
	global $admin_template;

	if ($admin_template=='yes')
	{
		$sep = '&';
	}
	else
	{
		$sep = '?';
	}

	return get_href($page_unique_name).$sep.'id='.$obj_id;
}


function ap_investigations_list($current_page)
{
	$_id = get('id');

	$sql = '
          SELECT
                 record_id AS investigation_id,
                 ap_investigation_date AS investigation_date,
                 ap_investigation_title AS investigation_title,
                 ap_investigation_preview AS investigation_preview

            FROM
                 ('.create_sql_view_by_name('ap_investigation').') AS ap_investigations
          '.( empty($_id) ? '' : '
           WHERE
                 record_id!='.sqlValue($_id) ).'
           ORDER
              BY 2 DESC, 1 DESC
        ';

	$ar = SQLRes2Array(viewsql($sql));
	$ar = $ar['row'];


	if (empty($_id))
	{
		array_shift($ar);
	}

	if (count($ar) <= INVESTIGATIONS_ROWS_ON_PAGE)
	{
		$current_page = null;
	}

	$res = parse_array_to_html($ar, 'int_investigations_list_row', $current_page, INVESTIGATIONS_ROWS_ON_PAGE, 'survey_history_navigation', INVESTIGATIONS_PAGES_IN_BLOCK, getValueOf('t'));

	return $res;
}


function ap_investigation_detail($_id)
{
	$sql = '
          SELECT
                 record_id AS investigation_id,
                 ap_investigation_date AS investigation_date,
                 ap_investigation_title AS investigation_title,
                 ap_investigation_preview AS investigation_preview,
                 ap_investigation_content AS investigation_content

            FROM
                 ('.create_sql_view_by_name('ap_investigation').') AS ap_investigations
          '.( empty($_id) ? '' : '
           WHERE
                 record_id='.sqlValue($_id) ).'
           ORDER
              BY 2 DESC, 1 DESC

           LIMIT 0,1
        ';

	$ar = SQLRes2Array(viewsql($sql));
	$ar = $ar['row'];


	if (count($ar)==0)
	{
		parse_error_code('404');
	}

	$res = parse_array_to_html($ar, 'int_investigation_detail_row');

	return $res;

}


function file_ext($path)
{
	$path_parts = pathinfo($path);

	return strtolower($path_parts['extension']);
}


function text_edit_cms_cons($str)
{
	return text_edit_cms(constant_name($str));
}

function e_cms_cons($str)
{
	return text_edit_cms_cons($str).cms_cons($str);
}
function cms_for_js($str) {
    return str_replace("\r\n",'<br/>',cms($str));
}
function cms_cons($str)
{
//vdump($str);
//vdump(constant_name($str));

	$val = cms($var = constant_name($str));
//vdump($val);

	if (empty($val))
	{
		global $language;

		$val = cons($str);
//vdump($val);
		save_cms($var, convert_to_utf($val, $language));
	}

	return $val;
}

function inputPointsNumberTitle()
{
	return sprintf(cms_cons('Min %s, max %s, divisible by %s'), MIN_POINTS_FOR_CONVERTION, ap_points_available(), POINTS_FOR_CONVERTION_DIVISIBLE_TO);
}


function points_convertion_type($type_id)
{
	$ar_convertion_types = AccessPanel_Respondent::$ar_convertion_types;

	if (in_array($type_id, $ar_convertion_types))
	{
		$ar_convertion_types = array_flip($ar_convertion_types);
		$res = $ar_convertion_types[$type_id];
	}
	else
	{
		if ($type_id == 0)
		{
			$res = '';
		}
		else
		{
			$res = 'unknown_convertion_type_id';
			trigger_error($res.': '.$type_id, E_USER_NOTICE);
		}
	}

	return $res;
}


function count_post()
{
	return count($_POST);
}


function get_current_user_name_for_detipoisk()
{
	return (implode('/', explode(' ', trim(ap_get_respondent_fio()))));
}

function ap_get_plugin_answer($m)
{
    $m = (int)$m;

    $m = max($m, 1);
    $m = $m-1;
    $ar = explode(',',cms('cs_plugin_answers'));
    if(array_key_exists($m,$ar)) {
        return conv_from_utf($ar[$m]);
    } else {
        return 'undefined';
    }
}

function ap_get_browser_for_plugin()
{
    $ua = $_SERVER['HTTP_USER_AGENT'];

    if (stristr($ua,'opera') !== false) {
        $ret = 'Opera';
    } elseif (stristr($ua,'opr/') !== false) {
        $ret = 'Opera15';
    } elseif (stristr($ua,'msie') !== false) {
        $ret = 'IE';
    } elseif (stristr($ua,'trident/') !== false) {
        $ret = 'IE';
    } elseif (stristr($ua,'Android') !== false) {
        $ret = 'Android';
    } elseif (stristr($ua,'Mobile') !== false) {
        $ret = 'Mobile';
    } elseif (stristr($ua,'firefox') !== false) {
        $ret = 'Firefox';
    } elseif (stristr($ua,'chrome') !== false ) {
        $ret = 'Chrome';
    } elseif (stristr($ua,'safari') !== false) {
        $ret = 'unknown';
    }  else {
        $ret = 'unknown';
    }
    if (stristr($ua,'windows') === false && stristr($ua,'Linux') === false && stristr($ua,'Macintosh') === false && $ret != 'Chrome' && $ret != 'Android' ) {
        return 'unknown_os';
    } else {
        return $ret;
    }
}

function ap_is_plugin_authorized()
{
    return (ap_is_respondent_authorized())?1:0;
}
function ap_pugin_may_download()
{
    return (int)(is_admin_template() || (ap_is_plugin_authorized()==1 && ap_get_browser_for_plugin() != 'unknown' && ap_get_browser_for_plugin() != 'unknown_os'));
}

function ap_download_plugin_link($linkPage = false){
    if($linkPage == 'TNS_Top'){
        ///res(TNS_TOP_DOWNLOAD.urlencode(str_replace("%urlid%",$_SESSION['respondent']['urlid'],TNS_TOP_DOWNLOAD_PARAMS)));
        return 'href="'.TNS_TOP_DOWNLOAD.urlencode(str_replace("%urlid%",$_SESSION['respondent']['urlid'],TNS_TOP_DOWNLOAD_PARAMS)).'"';
    }
    elseif($linkPage == 'TNS_Browser'){
        $tnsBrowserlink = TNS_BROWSER_DOWNLOAD . urlencode(str_replace("%resp_id%",ap_get_respondent_id(),TNS_BROWSER_DOWNLOAD_REFERRER));
        return 'href="'.$tnsBrowserlink.'"';
    }
    $br = ap_get_browser_for_plugin();
    if($br == 'Chrome' && $br != 'Android') {
        $ret = 'onclick="chrome.webstore.install(undefined,undefined,function(err) {console.log(\'inline install failed: \' + err)})" href="https://chrome.google.com/webstore/detail/haikmmmjkcejaalkjbfobneapigfmldp"';
    } elseif ($br == 'Opera15') {
        $ret = 'href="https://addons.opera.com/extensions/details/cmeter-2"';
    } elseif ($br == 'Opera') {
        $ret = 'href="https://addons.opera.com/extensions/details/cmeter-counter"';
    } elseif ($br == 'Android') {
        $ret = 'href="'.EE_HTTP.'media/TNSBrowser.apk"';
    }
    else {
        $ret = 'href="'.EE_HTTP.'media/CMeter'.$br.'Setup.exe"';
    }
    return $ret;
}
function ap_download_plugin_title()
{
    global $language;
    $br = ap_get_browser_for_plugin();
    if(($br == 'Chrome' || $br == 'Opera15' || $br == 'Opera') && ($br != 'Android')) {
        $ret = $language=='UA' ? 'Встановити плагин' : 'Установить плагин';
    } elseif ($br == 'Android') {
        $ret = $language=='UA' ? 'Встановити браузер' : 'Установить браузер';
    } else {
        $ret = $language=='UA' ? 'Завантажити exe-файл TNS Plugin' : 'Загрузить exe-файл TNS Plugin';
    }
    return $ret;
}
function ap_download_plugin_if_needed()
{
	return;
    $br = ap_get_browser_for_plugin();
    if(2 == (int)$_POST['step_n'] && !array_key_exists('pl_downloaded_', $_SESSION)) {
        $_SESSION['pl_downloaded_'] = 1;
        //if($br=='Firefox' || $br=='Opera' || $br=='IE')
        if($br == 'Chrome' || $br == 'Opera15'){
            $ret = '<script>$(function(){downloadFile("'.EE_HTTP.'media/CMeter'.$br.'Setup.exe")})</script>';
            //$ret = '<script>$(function(){location.href = "https://chrome.google.com/webstore/detail/haikmmmjkcejaalkjbfobneapigfmldp"})</script>';
            $ret = '';
        } else {
            $ret = '<script>$(function(){location.href = "'.EE_HTTP.'media/CMeter'.$br.'Setup.exe"})</script>';
        }
    } else {
        $ret = '';
    }
    return $ret;
}

function ap_project_complete_result($code, $ctype){
    switch($code) {
        case -1:
            $res = nl2br_cms('project_no_params_text');
            break;
        case -2:
            $res = nl2br_cms('project_not_complete_text');
            break;
        default:
            switch($ctype) {
                case 1:
                    $res = nl2br_cms('project_complete_text_1');
                    break;
                case 2:
                    $res = nl2br_cms('project_complete_text_2');
                    break;
                case 3:
                    $res = nl2br_cms('project_complete_text_3');
                    break;
                default:
                    $res = nl2br_cms('project_complete_text_4');
                    break;
            }
			if($code > 0) $res .= sprintf(nl2br_cms('project_complete_text_score'),'<b>'.$code.'</b>');
			$res .= '<br/><br/>'.nl2br_cms('project_complete_text_ending');
            break;
    }
	$res = preg_replace('~(?<!href="mailto:|>)(?>[\w.-]+@(?:[\w-]+\.){1,3}[a-z]{2,6})(?!">|</a>)~i','<a href="mailto:$0">$0</a>', $res);
    return $res;
}

function auth_error(){
    if($_SESSION['auth_error'] == '201'){
        $res =  "<script>alert('".cms_cons('Your account is blocked')."');</script>";
    } elseif($_SESSION['auth_error'] == '202'){
        $res =  "<script>alert('".cms_cons('Your account is blocked')."');</script>";
    }elseif($_SESSION['auth_error'] == '203'){
        $res =  "<script>alert('".cms_cons('Email not confirmed')."');</script>";
    }elseif($_SESSION['auth_error'] == '204'){
        $res =  "<script>alert('".cms_cons('Unknown reason')."');</script>";
    }
    else $res = '';

    unset($_SESSION['auth_error']);
    return $res;
}

function ap_profile_anketa_answers($ar=null)
{
    global $language, $question_ar;
    if($ar == null) $ar = $question_ar;
    foreach($ar as $k=>$v) {
        $ar[$k]['label_class'] = 'inline';
        $ar[$k]['input_name'] = 'question_ans[]';
        $ar[$k]['option_value'] = $v['dic_answers_id'];
        $ar[$k]['option_text'] = conv_from_utf($language == 'RU'?$v['answer_rus']:$v['answer_ukr'],$language);
    }
    return parse_array_to_html($ar, 'radio');
}
function ap_profile_anketa_multiple($other_id = null, $ar=null)
{
    global $language, $question_ar;
    if($ar == null) $ar = $question_ar;
    foreach($ar as $k=>$v) {
        $ar[$k]['label_class'] = 'inline';
        $ar[$k]['input_name'] = 'question_ans[]';
        $ar[$k]['option_value'] = $v['dic_answers_id'];
        if($v['dic_answers_id'] == $other_id) {
            $ar[$k]['option_id'] = 'option_other';
        } else {
            $ar[$k]['option_id'] = 'answer_'.$v['dic_answers_id'];
        }
        $ar[$k]['option_text'] = conv_from_utf($language == 'RU'?$v['answer_rus']:$v['answer_ukr'],$language);
    }
    return parse_array_to_html($ar, 'checkbox');
}
function print_profile_table_row($ncol, $start = 0)
{
	global $next_profile_answer_id, $next_ruw_num;
	$ret = '';
	if($start == 0) {
		$ans_id = $next_profile_answer_id;
	} else {
		$ans_id = $start;
		$next_ruw_num = 0;
	}
	for($i=0;$i<$ncol;$i++) {
		$ret .= '<td><input type="radio" name="question_ans['.$next_ruw_num.']" id="a_'.$next_ruw_num.'_'.$ans_id.'" value="'.$ans_id.'"/><label for="a_'.$next_ruw_num.'_'.$ans_id.'"></label></td>';
		$ans_id++;
	}
	$next_profile_answer_id = $ans_id;
	$next_ruw_num++;
	return $ret;
}

function hide_for_devices($link){
    $ua = $_SERVER['HTTP_USER_AGENT'];

    if (stristr($ua,'Android') !== false) {
        $platform = 'Android';
    } elseif (stristr($ua,'Mobile') !== false) {
        $platform = 'Mobile';
    } else $platform = '';

    if(strpos($link,'TNS_Top.html') && $platform != 'Android'){//only for Android
        return 'hide';
    } else if (strpos($link,'TNS_Browser.html') && $platform != 'Android'){//only for Android
        return 'hide';
    }else if (strpos($link,'Plugin.html') && ($platform == 'Android' || $platform == 'Mobile')){//only for desctops
            return 'hide';
    } else return '';
}

function fix_bug_opera_mini(){
    if (stristr($_SERVER['HTTP_USER_AGENT'],'Opera Mini') !== false)
        echo '<span style="color:#ffffff">.<span>';
}