<?

/**
 * Run sql function
 *
 * @param string $function_name - name of function
 * @param arrar $params - array of parameters
 * @return result
 */
function RunNonSQLFunction($function_name, $params)
{
	$func = 'return '.$function_name.' ('.Array2NonSQLstring($params).');';
	return eval($func);
}

function Array2NonSQLstring($arr)
{
	if (!is_array($arr))
	{
		print "Incorrect input parameter!!!";
		print var_dump(debug_backtrace());
	}
	$s = '';
	foreach ($arr as $k=>$v)
	{
		$s.=spValue($arr[$k]).",";
	}
	$s = substr($s,0,-1); // remove last comma
	return $s;
}

?>