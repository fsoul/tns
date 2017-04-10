<?

function f_del_mail_inbox($pId)
{
	RunSQL('DELETE FROM mail_inbox WHERE id = "'.$pId.'";');
	return 1;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/
function f_del_mail_inboxs($pId)
{
	RunSQL('DELETE FROM mail_inbox WHERE id in('.sqlValuesList($pId).')');
	return 1;
}

function get_message_body($arr)
{
	$res = array();
	foreach ($arr as $k=>$v) $res[] = array('field_name'=>$k, 'field_value'=>$v);
	return parse_array_to_html($res, 'message_body_row');
}


