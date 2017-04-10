<?php
	function DaysDifference($first, $second) {
		return round(((date("U", $second) - date("U",$first)) / (24 * 60 * 60)),0);
	}
	function GetSQLDate($front_date)
	{
		if (trim($front_date)=="")
		{
			$res = "0000-00-00";			
		}
		else 
		{
			$res = substr($front_date,6)."-".substr($front_date,3,2)."-".substr($front_date,0,2);
		}
		return $res;
	}
	function GetDateFromSQL($sql_date)
	{
		if (($sql_date=="")||(strpos($sql_date,"0000-00-00")===0))
			$res = "";
		else
			$res =  substr($sql_date,8,2)."-".substr($sql_date,5,2)."-".substr($sql_date,0,4);
		return $res;
	}

function dt($str_dt) 
{
	//print $str_dt; exit;
	if ( ($str_dt == '0000-00-00 00:00:00') || ($str_dt == '') ) 
		return 'N/A';
	return date(DATE_FORMAT_PHP,strtotime($str_dt));
}

/**
 *  Function convert_objecttime_to_unixtimelabel() get date in format like that : 14-08-2007  and return unix time label
 */
function convert_objecttime_to_unixtimelabel($object_time)
{
	if(preg_match('/^[0-3][0-9]\-[0-1][0-9]\-[0-9]{4,4}$/',$object_time))
	{
		$day = substr($object_time,0,2);
		$mounth = substr($object_time,3,2);
		$year = substr($object_time,6,4);
		$result = mktime(0,0,0,$mounth,$day,$year);
	}
	elseif(preg_match('/^[0-9]{4,4}\-[0-1][0-9]\-[0-3][0-9]$/',$object_time))
	{
		$day = substr($object_time,8,2);
		$mounth = substr($object_time,5,2);
		$year = substr($object_time,0,4);	
		$result = mktime(0,0,0,$mounth,$day,$year);

	}
	else
		$result = 0;

	//Adding zeto and convert to STRING for normal sorting in string-field

	if ($result >= 0)
		$result = strval($result);
	else 
		$result = '000000000000';
	
	for ($i==1; 12-strlen($result); $i++)
		$result = '0'.$result;

	if (strlen($result) > 12)
		$result = '999999999999'; 
	
	return $result;
}

/**
 *  Function convert_unixtimelabel_to_objecttime() get date in unix time label and return in format like that : 14-08-2007
 */
function convert_unixtimelabel_to_objecttime($unixtimelabel, $format_string = 'd-m-Y')
{
	$unixtimelabel = intval($unixtimelabel);
	return date($format_string,$unixtimelabel);
}

/**
 *  Function get_month_name($month [, $month_lang='RU', $LanguageCase='r']) return a name of month.
 *  $month - number of month (01, 02, ..., 12). $month_lang - language ('RU', 'EN'). $LanguageCase - case for russian language ('i', 'r')
 */

function get_month_name($month, $month_lang='RU', $LanguageCase='r', $coding_to='')
{
	global $language;

	//define start coding
	$coding_from = array(
				'EN' => 'windows-1252',
				'RU' => 'windows-1251',
				'UA' => 'windows-1251'
			);

	//define finist coding
	if($coding_to == '')
	{
		$coding_to = getCharset();
	}

	$result = date('M',$month);
	$month_names = array (
				 '01'  => array(
						'EN'=>array('i'=>'January'),
						'RU'=>array('i'=>'€нварь', 'r'=>'€нвар€'),
						'UA'=>array('i'=>'сiчень', 'r'=>'сiчн€')
					),
				 '02'  => array(
						'EN'=>array('i'=>'February'),
						'RU'=>array('i'=>'февраль', 'r'=>'феврал€'),
						'UA'=>array('i'=>'лютий', 'r'=>'лютого')
					),
				 '03'  => array(
						'EN'=>array('i'=>'March'),
						'RU'=>array('i'=>'март', 'r'=>'марта'),
						'UA'=>array('i'=>'березень', 'r'=>'березн€')
					),
				 '04'  => array(
						'EN'=>array('i'=>'April'),
						'RU'=>array('i'=>'апрель', 'r'=>'апрел€'),
						'UA'=>array('i'=>'квiтень', 'r'=>'квiтн€')
					),
				 '05'  => array(
						'EN'=>array('i'=>'May'),
						'RU'=>array('i'=>'май', 'r'=>'ма€'),
						'UA'=>array('i'=>'травень', 'r'=>'травн€')
					),
				 '06'  => array(
						'EN'=>array('i'=>'June'),
						'RU'=>array('i'=>'июнь', 'r'=>'июн€'),
						'UA'=>array('i'=>'червень', 'r'=>'червн€')
					),
				 '07'  => array(
						'EN'=>array('i'=>'July'),
						'RU'=>array('i'=>'июль', 'r'=>'июл€'),
						'UA'=>array('i'=>'липень', 'r'=>'липн€')
					),
				 '08'  => array(
						'EN'=>array('i'=>'August'),
						'RU'=>array('i'=>'август', 'r'=>'августа'),
						'UA'=>array('i'=>'серпень', 'r'=>'серпн€')
					),
				 '09'  => array(
						'EN'=>array('i'=>'September'),
						'RU'=>array('i'=>'сент€брь', 'r'=>'сент€бр€'),
						'UA'=>array('i'=>'вересень', 'r'=>'вересн€')
					),
				 '10'  => array(
						'EN'=>array('i'=>'October'),
						'RU'=>array('i'=>'окт€брь', 'r'=>'окт€бр€'),
						'UA'=>array('i'=>'жовтень', 'r'=>'жовтн€')
					),
				 '11'  => array(
						'EN'=>array('i'=>'November'),
						'RU'=>array('i'=>'но€брь', 'r'=>'но€бр€'),
						'UA'=>array('i'=>'листопад', 'r'=>'листопада')
					),
				 '12'  => array(
						'EN'=>array('i'=>'December'),
						'RU'=>array('i'=>'декабрь', 'r'=>'декабр€'),
						'UA'=>array('i'=>'грудень', 'r'=>'грудн€')
					)
				  );

	if (!array_key_exists($month_lang, $month_names[$month]))
		$month_lang = 'EN';

	if (!array_key_exists($LanguageCase, $month_names[$month][$month_lang]))
		$LanguageCase = 'i';

	$result = $month_names[$month][$month_lang][$LanguageCase];

	// Coding converting
	if($coding_to != $coding_from)
	{
		// If coding made without errors, then save result
		$new_result = iconv($coding_from[$language], $coding_to, $result);
		if($new_result !== false)
		{
			$result = $new_result;
		}
		
	} 
	
	return $result;	
}



