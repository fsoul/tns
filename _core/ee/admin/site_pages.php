<?
	$modul='site_pages';
	if(!isset($op)) $op=0;
//********************************************************************
	include_once('../lib.php');
	include('statistic_function.php');
//********************************************************************
//
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
	$default_marks = default_marks();
	
	function init_pages()
	{
		global $default_marks, $user_type, $site_pages;
		if(empty($user_type)) $user_type = 5;
		$sql = 'select * from stat_site_pages';
		$rs = db_sql_query($sql);
		
		while ($r = db_sql_fetch_array($rs))
		{
			$marks = unserialize(stripslashes($r['marks']));
			if(!is_array($marks)) $marks = $default_marks;
			$site_pages[$r['id']] = array('link' => $r['alias'], 'marks'=>$marks);
		}
	}

	function pages_list()
	{
		global $user_type, $site_pages;
		$sql = 'select * from stat_site_pages';
		$rs = db_sql_query($sql);
		if(is_array($site_pages)) {
			while (list($r_id, $values) = each($site_pages))
			{
				$marks = $values['marks'];
				$link = $values['link'];
				$txt .= '<tr>';
				$txt .= '<td><a href="'.$link.'" target="_blank">'.$link.'</a></td>';
				$txt .= '<td>'.$marks[$user_type].'</td>';
				$txt .= '<td><input type="text" name="page_mark['.$r_id.']" size="10" value="'.$marks[$user_type].'"></td>';
				$txt .= '</tr>';
			}
		}
		return $txt;
	}

	function update_marks()
	{
		global $user_type, $site_pages;
		$marks = $_POST['page_mark'];

		if(is_array($marks)){
			while(list($page_id, $mark) = each($marks))
			{
				$page_mark = $site_pages[$page_id]['marks'];
				$site_pages[$page_id]['marks'][$user_type] = $mark;
				
				$str_page_mark = addslashes(serialize($site_pages[$page_id]['marks']));
				$sql_update = 'update stat_site_pages set marks = "'.$str_page_mark.'" where id = '.$page_id;			
				db_sql_query($sql_update);
			}
		}
	}
	
	init_pages();

	update_marks();

	echo parse($modul.'/list');
?>
