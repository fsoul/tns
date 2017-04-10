<pre>
<?

include('../_core/ee/lib.php');

$resp = ap_resp_init();
//var_dump($resp);

echo(ap_survey_history2());

function ap_survey_history2($current_page=1)
{
	$oci = ap_oci_init();

	if (is_object($oci))
	{
		$sql = '

                SELECT
                       complete_date AS survey_date,
                       project_name AS survey_title,
                       point_num AS survey_points,
                       0 AS points_convertion

                  FROM access_panel.v_respondent_project
                 WHERE 1=1
                   AND respondent_id = '.($oci->sqlValue(6851)).'
                   AND is_complete = 1
                ';

		$sql2 = '

                 UNION

                SELECT
                       convert_date AS survey_date,
                       \''.cons('Points convertion').'\' AS survey_title,
                       point_num AS survey_points,
                       write_off_type_id AS points_convertion
                ';

		$sql2_from = '

                  FROM access_panel.v_point_convertion
                 WHERE respondent_id = '.($oci->sqlValue(6851)).'

                ';

		$sql_order = '

                 ORDER BY 1 DESC

                ';

		if ($oci->getField('SELECT NVL(COUNT(*),0) '.$sql2_from))
		{
			$sql.= $sql2.$sql2_from;
		}

		$sql.= $sql_order;

vdump($sql, 'sql');
		$ar = $oci->get_query_as_array($sql);
	}
	else
	{
		$ar = array(
/*
			array('survey_title'=>'Побутова технiка', 'survey_points'=> '50', 'survey_date'=>'01.02.2003', 'points_convertion'=>0),
			array('survey_title'=>'Використання балiв', 'survey_points'=> '52', 'survey_date'=>'07.08.2009', 'points_convertion'=>1),
			array('survey_title'=>'Технiка побутова', 'survey_points'=> '51', 'survey_date'=>'04.05.2006', 'points_convertion'=>0),
			array('survey_title'=>'Побутова технiка', 'survey_points'=> '50', 'survey_date'=>'01.02.2003', 'points_convertion'=>0),
			array('survey_title'=>'Використання балiв', 'survey_points'=> '51', 'survey_date'=>'04.05.2006', 'points_convertion'=>1),
			array('survey_title'=>'Технiка не побутова', 'survey_points'=> '52', 'survey_date'=>'07.08.2009', 'points_convertion'=>0),
			array('survey_title'=>'Побутова технiка', 'survey_points'=> '50', 'survey_date'=>'01.02.2003', 'points_convertion'=>0),
			array('survey_title'=>'Технiка побутова', 'survey_points'=> '51', 'survey_date'=>'04.05.2006', 'points_convertion'=>1),
			array('survey_title'=>'Побутова технiка', 'survey_points'=> '50', 'survey_date'=>'01.02.2003', 'points_convertion'=>0),
			array('survey_title'=>'Технiка побутова', 'survey_points'=> '51', 'survey_date'=>'04.05.2006', 'points_convertion'=>1),
			array('survey_title'=>'Технiка не побутова', 'survey_points'=> '100', 'survey_date'=>'07.08.2009', 'points_convertion'=>0),
*/
		);
	}
vdump($ar, '$ar');

	if (count($ar))
	{
		foreach($ar as $i => $ar_row)
		{
			$ar[$i]['survey_title'] = conv_from_utf($ar[$i]['survey_title']);
		}

//function parse_array_to_html($arr, $tpl, $current_page=null, $rows_on_page=null, $tpl_navigation=null)
		if (count($ar)<=SURVEY_HISTORY_ROWS_ON_PAGE)
		{
			$current_page = null;
		}

//function navigation($rows_total, $rows_on_page = 1, $current_page = 1, $tpl = 'templates/navigation/default', $pages_in_block = 10, $page_id = null)
		$res = parse_array_to_html($ar, 'survey_history_row', $current_page, SURVEY_HISTORY_ROWS_ON_PAGE, 'survey_history_navigation', SURVEY_HISTORY_PAGES_IN_BLOCK, getValueOf('t'));
	}
	else
	{
		$res = parse('survey_history_no_info');
	}

	return $res;
}


