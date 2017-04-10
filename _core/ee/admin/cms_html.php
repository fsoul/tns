<?	$admin=true;
	$UserRole=0;
	$modul='cms_html';
	if(!isset($op)) $op=0;
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (	!CheckAdmin()
		||
		(	$UserRole!=ADMINISTRATOR &&
			$UserRole!=POWERUSER
		)
	)
	{
		echo parse('norights');
		exit;
	}

	$baseHref='<BASE href="'.EE_HTTP.'">';
	$page_id = intval($_GET['t']);
	$type = empty($_GET['type'])?'html':$_GET['type'];

	if (empty($close) and !empty($lang) and !empty($cms_name))
	{
		if ($save)
		{
			$txt = $cms_value;

			if ($type=='text' || $type=='longtext')
			{
				$txt = strip_tags($txt);
			}

			$aFieldName = trim($_POST['aFieldName']);
			$lang = trim($_POST['lang']);
			runsql('UPDATE content SET val="'.$txt.'", short_desc="'.$aFieldName.'" WHERE language="'.$lang.'" AND var="'.$cms_name.'" AND page_id='.$page_id);
			if ($_POST['nextlang'] == '')
			{
				header('Location: cms_html.php?close=true'.(!empty($_GET['popup2'])?'&popup2=true':''));
				exit;
			}
			else
			{
				$lang = $_POST['nextlang'];
			}
		}

		$rs = viewsql('SELECT * FROM content WHERE var='.sqlValue($cms_name).' AND language='.sqlValue($lang).' AND page_id='.sqlValue($page_id));

		if (db_sql_num_rows($rs) < 1)
		{
			runsql('INSERT INTO content(var,val,short_desc,language,page_id) VALUES("'.$cms_name.'","","'.$cms_name.'","'.$lang.'",'.$page_id.')');
			$rs = viewsql('SELECT * FROM content WHERE var="'.$cms_name.'" AND language="'.$lang.'"');
		}

		$r = db_sql_fetch_array($rs);
		function field_name()
		{
			global $r;
			return $r['short_desc'];
		}

		function print_big_cms_field()
		{
			global $r, $type;
			if ($type == 'text')
			{
				return '<input style="margin:10px;" type="text" name="cms_value" size="50" value="'.htmlspecialchars(strip_tags($r['val']), ENT_QUOTES).'">';
			}
			else
			{
				return '<textarea cols="90" rows="24" name="cms_value">'.$r['val'].'</textarea>';
			}
		}

		function print_avail_languages()
		{
			global $lang, $t, $cms_name;
			$res = '';

			$tpl = '<a href="%s" style="padding:5px;%s" onclick="document.fd.nextlang.value=\'%s\'; document.fd.save.click()">%s</a>';

			$sql = 'SELECT language_code, status FROM v_language';
			$r = ViewSQL($sql, 0);

			while ($row=db_sql_fetch_assoc($r))
			{
				$style = '';
				if ($row['status']==0)
				{
					$style='color:#999;';
				}

				if ($row['language_code'] == $lang)
				{
					$style='color:red;';
				}

				$href = '#'; //'cms.php?cms_name='.$cms_name.'&admin_template=yes&t='.$t.'&lang='.$row['language_code'];
				$res.= sprintf($tpl, $href, $style, $row['language_code'], $row['language_code']);
			}
			return $res;
		}
//********************************************************************
		echo str_replace('cms.php', 'cms_html.php', parse_popup($modul.'/list'));
	}
	else
	{
?>

<script type="text/javascript">
	window.parent.closePopup('yes');
</script>

<?
	}
?>