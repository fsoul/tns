<?
	$modul='search_stat';
	if(!isset($op)) $op=0;
	if(empty($page)) $page=1;
	if(empty($srt)) $srt='';
	if(empty($click)) $click=-1;
	if(!empty($back)) {
		header('Location: search_stat.php?load_cookie=true');
		exit;
	}
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
	$sort[1]='regdate';
	$sort[2]='user_ip';
	$sort[3]='query';
	load_stored_values('search_stat');
	$order=getSortOrder();
	function print_list() {
		global $MAX_ROWS_IN_ADMIN, $HTTP_POST_VARS, $page, $srt, $b_color, $order;
		global $fDate, $fIp, $fQuery;
		if($HTTP_POST_VARS['refresh']) {
			$fDate=$HTTP_POST_VARS['fDate'];
			$fIp=$HTTP_POST_VARS['fIp'];
			$fQuery=$HTTP_POST_VARS['fQuery'];
		}
		$sql='select * from search_stat';
		$usl='';
		$where='';
		if($fDate!='') {$where.='regdate regexp "'.$fDate.'" and ';$usl.='fDate='.$fDate.'&';}
		if($fIp!='') {$where.='user_ip regexp "'.$fIp.'" and ';$usl.='fIp='.$fIp.'&';}
		if($fQuery!='') {$where.='query regexp "'.$fQuery.'" and ';$usl.='fQuery='.$fQuery.'&';}
		if($usl!='') $usl=substr($usl,0,-1);
		store_values($usl,'search_stat');
		if($where!='') $sql.=' where '.substr($where,0,-5);
		$sql.=$order;
		$rs=db_sql_query($sql);
		$tot=db_sql_num_rows($rs);
		if(ceil($tot/$MAX_ROWS_IN_ADMIN)<$page) $page=1;
		$rs=db_sql_query($sql.' limit '.(($page-1)*$MAX_ROWS_IN_ADMIN).','.$MAX_ROWS_IN_ADMIN);
		$s='';
		$c=0;
		while($r=db_sql_fetch_array($rs)) {
			$s.='<tr bgcolor="'.$b_color[$c].'">';
			$c=1-$c;
			$s.='<td height="25" align="center" class="table_data">'.$r['regdate'].'</td>';
			$s.='<td class="table_data">'.$r['user_ip'].'</td>';
			$s.='<td class="table_data">'.$r['query'].'</td>';
			$s.='<td align="center" class="table_data">';
			$s.='</td>';
			$s.='</tr>';
		}
		if($tot>$MAX_ROWS_IN_ADMIN) $s.=navigation($tot,'search_stat.php?op=0&load_cookie=true', $MAX_ROWS_IN_ADMIN);
		return $s;
	}
//********************************************************************
	switch($op) {
		default:
		case '0': echo parse($modul.'/list');break;
	}
?>
