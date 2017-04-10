<?

function DeleteItem($item_table,$item_fields,$item_id)
{
	foreach ($item_fields as $key=>$value)
	{
		$sql = 'DELETE FROM content WHERE var='.sqlValue($item_table.'_'.$item_id.'_'.$value);
		runsql($sql);
	}
}
function getMaxItemId($item_table, $item_identifier)
{
//	global $item_table;
	$sql = "SELECT MAX(CAST(SUBSTRING(var,".(strlen($item_table)+2).", (INSTR(var,'_".$item_identifier."')-".(strlen($item_table)+2).")) AS UNSIGNED)) as ".$item_identifier."
		  	FROM content
		 	WHERE INSTR(var,'_".$item_identifier."')>0 and INSTR(var,'".$item_table."_')>0";
	$r = db_sql_fetch_assoc(ViewSQL($sql));
//	$item_table = $r["id"]+1;
	return $r[$item_identifier]+1;		
}

function AddItem($item_table, $item_fields, $item_multilang_fields, $item_identifier,$lang="")
{
	global $default_language,$language;
	if ($lang=="")
		$lang=$default_language;
	$item = array();
	
	$item[$item_identifier] = getMaxItemId($item_table,$item_identifier);
	$_POST[$item_identifier] = $item[$item_identifier];
	$item_id = $item[$item_identifier];
		
	foreach ($item_fields as $key=>$value)
	{
		$item[$value] = $_POST[$value];
	}
	
	foreach ($item as $var=>$val)
	{
		$item_block_id = $item_table.'_'.$item_id.'_'.$var;

		if (in_array($var,$item_multilang_fields))
		{
			save_cms($item_block_id, $val, 0);
		}
		else 
		{
			save_cms($item_block_id, $val, 0, $default_language);
		}
	}
	return $item_id;
//	exit;
}

function EditItem($item_table, $item_fields, $item_multilang_fields,$item_identifier, $item_id,$lang="")
{
	global $default_language;
	if ($lang=="")
		$lang=$default_language;
//	global $news_fields, $news_table;
	$item = array();
	foreach ($item_fields as $key=>$value)
	{
		if ($value=="id")
			$item['id'] = intval($_POST['news_id']);
		else
			$item[$value] = $_POST[$value];
	}

	foreach ($item as $var=>$val)
	{
		$item_block_id = $item_table.'_'.$item_id.'_'.$var;

		if (in_array($var, $item_multilang_fields))
		{
			save_cms($item_block_id, $val, 0);
		}
		else 
		{
			save_cms($item_block_id, $val, 0, $default_language);
		}
	}
}
function GetItem($item_id, $item_view, $item_identifier,  $language="")
{
	global $default_language;

	if ($language=="")
	{
		$language = $default_language;
	}

	$r = db_sql_query("SELECT * FROM ".$item_view." WHERE ".$item_identifier."=".$item_id." AND language='".$language."'");
	$f = db_sql_fetch_assoc($r);
	foreach ($f as $key=>$value)
	{
		global $$key;
		$$key = $value;
	}
}

/*
// depricated ?
function CreateCustomView($view, $field_group_name, $field_group_fields, $field_group_date_fields, $date_format, $field_group_identifier, $add_sql_join, $debug=1)
{
//	global $news_table, $news_view, $news_fields, $default_language, $language, $news_date_format, $news_date_fields, $news_identifier;
	global $default_language;
	$name_id = "id";
	
	$sql = 'DROP VIEW IF EXISTS '.$view.';';
	$c = strlen($field_group_name)+2;
	db_sql_query($sql);
	if ($debug)
		echo $sql;
	$arr_sql = array();
	$arr_sql[] = '
	 	SELECT DISTINCT
			SUBSTRING(var,'.$c.', (LOCATE(\'_'.$field_group_identifier.'\',var)-'.$c.')) as '.$name_id.'
		';
	$arr_sql[] = 'lan.language_code as language';
	
	foreach ($field_group_fields as $key=>$value)
	{
		// if ($value=='news_order')
		// выбираем одну запись из 2-х возможных
		// - для текущего языка и языка по-умолчанию
		// при этом сортируем так, чтобы текущий язык шел первым
		// если для текущего нет - выберется то, что есть :)
		$arr_sql[] = '
				(select val
				from content
	 	  		where var = CONCAT('.sqlValue($field_group_name.'_').','.sqlValue($name_id).','.sqlValue('_'.$value).')
		    	and language in (lan.language_code, '.sqlValue($default_language).')
		  		order by CONCAT((case language when lan.language_code then \'0\' else \'1\' end),language) LIMIT 1
				) as '.$value;

		if (in_array($value, $field_group_date_fields))//date field
		{
			$arr_sql[] = '
			(select IF(val<>\'\',date_format(val,'.sqlValue($date_format).'),\'\')
				from content
	 	  		where var = CONCAT('.sqlValue($field_group_name.'_').','.sqlValue($name_id).','.sqlValue('_'.$value).')
		    	and language in (lan.language_code, '.sqlValue($default_language).')
		  		order by CONCAT((case language when lan.language_code then \'0\' else \'1\' end),language) LIMIT 1
				) as '.$value.'_d';
		}
	}
	
	$sql  = implode(",\n", $arr_sql);
	$sql.= $add_sql_join;
	$sql.='
	 	FROM content as c1, language as lan
		WHERE LOCATE('.sqlValue('_'.$field_group_identifier).',var)>0 and LOCATE('.sqlValue($field_group_name.'_').',var)>0 AND lan.status=1';
	$sql = 'CREATE VIEW '.$view.' AS 
			'.$sql.' ';
	db_sql_query($sql);
	if ($debug)
		echo $sql;	
//	echo $sql;	
}
*/


