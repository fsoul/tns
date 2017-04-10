<?
function DateTime2SQL ($a)
{
	return $a[year].'-'.$a[mon].'-'.$a[mday].' '.$a[hours].':'.$a[minutes].':'.$a[seconds];
}

function SQLDate2Local($s)
{
	global $date_format_for_sql;
	$sql = "SELECT DATE_FORMAT('".$s."',".$date_format_for_sql.")";
	//print $sql; exit;
	$res = db_sql_fetch_array(ViewSQL($sql, 0));
	return $res[0];   	
}

function SQLRes2Array ($res)
{
	$ret = array();
	while ($row = db_sql_fetch_assoc($res)) $ret['row'][] = $row;
	return $ret;
}

function SQLRes2FullArray ($res)
{
	$ret = array();
	while ($row = db_sql_fetch_array($res)) $ret['row'][] = $row;
	return $ret;
}

function SQLField2Array ($res, $field_num=0)
{
	$ret = array();
	while ($row = db_sql_fetch_row($res)) $ret[] = $row[$field_num];
	return $ret;
}

function SaveQuotes($s)
{
	return addslashes(str_replace("\"","''",$s));
} 

//Function strip http://, https:// & www. url prefix
function getClearUrl($s)
{
	$s = strtolower($s);
	$pos = strpos($s, 'http://');
	if($pos !== false) $s = substr($s, 7);
	$pos = strpos($s, 'https://');
	if($pos !== false) $s = substr($s, 8);
	$pos = strpos($s, 'www.');
	if($pos !== false) $s = substr($s, 4);
	return $s;
}

/**
 * Returns integer number
 * @param string $a
 * @return integer if $a can be recognized as octal number, otherwise argument without changes
 * @see touch_dir()
 * @see ftp_touch_dir()
 */
function octal_string_to_integer($a)
{
	if (is_string($a) && preg_match("/^[0-7]+$/", $a))
	{
		$a = (int)base_convert($a, 8, 10);
	}

	return $a;
}

/**
 * Strip mentioned text from the beginning of a string 
 * @param string $str - string the text to be stripped from
 * @param string $charset - stripped text
 */
function ltrim_str($str, $charset)
{
	if (($pos = strpos($str, $charset)) === 0)
	{
		$str = substr($str, strlen($charset));
	}

	return $str;
}

/**
 * Strip mentioned text from the end of a string 
 * @param string $str - string the text to be stripped from
 * @param string $charset - stripped text
 * @use ltrim_str()
 */
function rtrim_str($str, $charset)
{
	return strrev(ltrim_str(strrev($str), strrev($charset)));
}

/**
 * Strip mentioned text from the beginning and end of a string 
 * @param string $str - string the text to be stripped from
 * @param string $charset - stripped text
 * @use ltrim_str()
 * @use rtrim_str()
 */
function trim_str($str, $charset)
{
	return rtrim_str(ltrim_str($str, $charset), $charset);
}


?>