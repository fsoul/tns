<?php

//*************************************************************
// 	   Checks if language is language forwarding
//*************************************************************
function check_lang_forwarding($lang)
{              

	$sql= 'select * from dns where language_forwarding = "'.$lang.'" and status="1"';

	$query_res = db_sql_query($sql);	

	return (db_sql_num_rows($query_res) > 0);
}
                                
//*************************************************************
// 		Checks status of language
//*************************************************************
function check_status_of_language($lang)
{
	$sql = "SELECT status FROM v_language WHERE language_code = '$lang'";

	return (getField($sql));		
}

//check possibility turn draft mode
function check_possibility_turn_on_dm($dns_id)
{
	return	(bool) $db_res = getField('SELECT count(*) FROM dns WHERE status = 1 AND id <> '.$dns_id.' AND draft_mode = 0');
}

