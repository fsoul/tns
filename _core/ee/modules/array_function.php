<?php

function array_multisort_by_keys($ar, $sort_a_d = SORT_ASC, $sort_r_n_s = SORT_REGULAR)
{
	$ar_keys = array();

	foreach ($ar as $key=>$val)
	{
		if (is_array($val) && array_key_exists('Sort', $val))
		{
			$ar_keys[$key] = $val['Sort'];
		}
		else
		{
			$ar_keys[$key] = null;
		}
	}

	array_multisort($ar_keys, $sort_a_d, $sort_r_n_s);

	$ar_res = array();
	foreach ($ar_keys as $k=>$v)
	{
		$ar_res[$k] = $ar[$k];
	}
	return $ar_res;
}

function array_filter_by_value_simple($ar, $check_key, $check_val)
{
	$ar_res = array();

	foreach($ar as $key=>$val)
	{
		if ($val[$check_key] == $check_val)
		{
			$ar_res[$key] = $val;
		}
	}

	return $ar_res;
}

function array_to_associate($arr)
{
	$res = array();
	foreach($arr as $v)
	{
		$split = explode('=>',$v);
		if (count($split)==2) $res[trim($split[0])] = trim($split[1]);  
	}
	return $res;
}

function array_filter_by_value($ar, $f, $check_val)
{
	$ar_res = array();

	foreach($ar as $key=>$val)
	{
		if ($f($val, $check_val))
		{
			$ar_res[$key] = $val;
		}
	}

	return $ar_res;
}

function array_keys_int($arr)
{
	$res = array();
	$keys = array_keys($arr);
	for($i=0; $i<count($keys); $i++)
		if (is_integer($keys[$i])) $res[] = $keys[$i];

	return $res;
}

function array_keys_assoc($arr)
{
	$res = array();
	$keys = array_keys($arr);
	for($i=0; $i<count($keys); $i++)
		if (!is_integer($keys[$i])) $res[] = $keys[$i];

	return $res;
}

// перенумеровывает элементы массива целочисленными индексами попорядку
// используется для приведения в порядок массивов,
// из которых были удалены нек-е элементы
function renumber_array($arr)
{
	$res = array();
	if (is_array($arr))
		foreach ($arr as $key=>$val)
			$res[] = $val;

	return $res;
}

// удаляет из массива $arr элементы,
// индексы которых есть в массиве $remove_keys 
// возвращаемый массив, который по умолчанию перенумеровывается
function remove_by_keys($arr, $remove_keys, $renumber = true)
{
	if (is_array($remove_keys))
	{
		foreach ($remove_keys as $key)
		{
			unset($arr[$key]);
		}
	}
	
	if($renumber == true)
	{
		$arr = renumber_array($arr);
	}

	return $arr;
}


