<?

function f_add_dns($pDns, $pComment, $pStatus, $pLanguage_forwarding, $pDraft_mode, $pCDN_server)
{
	$ret = 0;
	if (!$pIcq) $pIcq='NULL';
	if (mysql_num_rows(ViewSQL('SELECT id FROM dns WHERE dns = "'.$pDns.'";', 0)) > 0)
		$ret = -1;

	if ($ret == 0)
	{
		$sql = 'INSERT INTO 
					dns 
				SET 
					dns = "'.$pDns.'", 
					comment = '.sqlValue($pComment).', 
					Status = "'.$pStatus.'" , 
					language_forwarding = "'.$pLanguage_forwarding.'", 
					draft_mode = "'.$pDraft_mode.'",
					cdn_server='.sqlValueSet($pCDN_server);

		$ret = RunSQL($sql, 0);
	}

	return $ret;
}

function f_del_dns($pId)
{
	RunSQL('DELETE FROM dns WHERE id = "'.$pId.'";', 0);
	return 1;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/
function f_del_dnss($pId)
{
	RunSQL('DELETE FROM dns WHERE id in('.sqlValuesList($pId).')');
}

function f_upd_dns($pId, $pDns, $pComment, $pStatus, $pLanguage_forwarding, $pDraft_mode, $pCDN_server)
{
	$tmp = 1;
	                              
	if (!$pIcq)
		$pIcq='NULL';

	if (mysql_num_rows(ViewSQL('SELECT id FROM dns WHERE dns = "'.$pDns.'" AND id <> "'.$pId.'"', 0)) > 0)
		$tmp = -3;

	if ($tmp > 0)
	{
		$sql = 'UPDATE 
				dns 
			   SET 
				dns = "'.$pDns.'",
				comment = '.sqlValue($pComment).',
				Status = "'.$pStatus.'",
				language_forwarding = "'.$pLanguage_forwarding.'",
				draft_mode = "'.$pDraft_mode.'",
				cdn_server = '.sqlValueSet($pCDN_server).'
			 WHERE 
				id = "'.$pId.'"';

		RunSQL($sql);
		$tmp = $pId;
	}

	return $tmp;
}

function get_cdn_server()
{
	$sql = 'SELECT dns FROM dns WHERE id = (SELECT cdn_server FROM dns WHERE dns='.sqlValue(EE_HTTP_HOST).')';

	return getField($sql);
}


