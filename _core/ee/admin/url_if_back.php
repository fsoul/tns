<?

	if(!isset($op)) $op='0';
	if(empty($page)) $page=1;
	if(empty($click)) $click=-1;
        if(empty($srt)) $srt='';

if(empty($url))
	$url = 'Location: '.$modul.'.php?load_cookie=true';

if(!empty($back)) // в окне редактирования нажата кнопка [Назад]
{
	if($modul=='_news_letters' && !empty($edit))
	{
                close_popup('yes');
	}
	elseif(isset($added) || $modul=='_styles') close_popup('yes');
	else close_popup('no');
}

	function close_popup($reload, $page_id = 0)
	{
		global $modul;
		if ($modul == '_media' && $page_id != 0)
		{
			$from = '';
			if(!empty($_POST['from']) && $_POST['from'] == 'assets')
				$from = '&from=assets';
			echo '<script type="text/javascript">window.parent.location="'.EE_HTTP.'index.php?t='.$page_id.'&admin_template=yes'.$from.'";</script>';
		}
		else 
			echo '<script type="text/javascript">window.parent.closePopup(\''.$reload.'\');</script>';
		exit;
	}


	$popup_width = 900;
	$count_of_edit_fields = is_table('v'.$modul.'_edit') ? count(db_sql_table_fields('v'.$modul.'_edit')) : 0;
	$popup_scroll = '0'; 
	$edit_config_width = 500;
?>