<?	$admin=true;
	$UserRole=0;
	$modul='cms_object';
	if(!isset($op)) $op=0;
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if(!CheckAdmin() or ($UserRole!=ADMINISTRATOR and $UserRole!=POWERUSER)) {echo parse('norights');exit;}
	$baseHref='<BASE href="'.EE_HTTP.'">';

if (empty($close) and !empty($lang))
{
	//$record_id must be got from $_GET for getting correct data for object-fields with "HTML" type
	$record_id = isset($_GET['record_id']) ? $_GET['record_id'] : $record_id;
	$record_id = intval($record_id);

	$object_id = GetField('SELECT object_id FROM object_record WHERE id='.intval($record_id));
	$field_id = GetField('SELECT id FROM object_field WHERE object_field_name='.sqlValue($id).' AND object_id='.intval($object_id));

	if (!empty($_POST['save']))
	{
		$txt = norm(encd(trim($_POST['cms_value'])));
		$lang = trim($_POST['lang']);
		$sql = '
			UPDATE object_content
			   SET value='.sqlValue($txt).'
			 WHERE language='.sqlValue($lang).'
			   AND object_record_id='.sqlValue($record_id).'
			   AND object_field_id='.sqlValue($field_id);
		;
		runsql($sql, 0);
		if ($_POST["nextlang"] == '') { header('Location: cms_object.php?close=true'.(!empty($_GET['popup2'])?'&popup2=true':'')); exit;}
			else $lang = $_POST['nextlang'];
	}

	$rs = viewsql('SELECT * FROM object_content WHERE object_record_id='.sqlValue($record_id).' AND language='.sqlValue($lang).' AND object_field_id='.sqlValue($field_id));

	if (db_sql_num_rows($rs) < 1)
	{
		runsql('
			INSERT INTO object_content
				(object_field_id, object_record_id, value, language)
			VALUES
				('.sqlValue($field_id).', '.sqlValue($record_id).', "", '.sqlValue($lang).')
		');

		$rs = viewsql('SELECT * FROM object_content WHERE object_record_id='.sqlValue($record_id).' AND language='.sqlValue($lang).' AND object_field_id='.sqlValue($field_id));
	}

	$r=db_sql_fetch_array($rs);

	function field_name() {
		global $r;
		return $r['object_record_id'];
	}
	function print_big_cms_field() {
		global $r, $lang;
		// 11633
		include_once(EE_CORE_PATH.'fck_custom/fckeditor.php');
		$oFCKeditor = new EE_FCKeditor('cms_value');		
		$oFCKeditor->ToolbarSet='Alloc';
		$oFCKeditor->Width='98%';
		$oFCKeditor->Height='550';
		$oFCKeditor->UserFilesPath=EE_FILE_PATH;
		$oFCKeditor->Value=dcd($r['value']);
		$oFCKeditor->CanUpload=true ;	// Overrides fck_config.js default configuration
		$oFCKeditor->CanBrowse=true ;	// Overrides fck_config.js default configuration
		$oFCKeditor->BasePath=EE_HTTP_PREFIX.'fckeditor/' ;		// '/FCKeditor/' is the default value so this line could be deleted.
		$oFCKeditor->Config["CustomConfigurationsPath"]=EE_HTTP.'fck_custom/myconfig.php';
		$oFCKeditor->Config['lang']=$lang;
		return $oFCKeditor->CreateHtml();
	}
	
	function print_avail_languages() {
		global $lang, $id, $record_id;
		$res = '';
		$tpl = '<a href="%s" style="padding:5px;%s" 
				onclick="document.fd.nextlang.value=\'%s\'; 
				document.fd.save.click()">%s</a>';
		$sql="SELECT language_code, status FROM v_language";
		$r = ViewSQL($sql,0);
		while ($row=db_sql_fetch_assoc($r)) {
			$style='';
			if($row['status']==0) $style='color:#999;';
			if($row['language_code'] == $lang) $style='color:red;';
			$href = '#'; //'cms.php?cms_name='.$cms_name.'&admin_template=yes&t='.$t.'&lang='.$row['language_code'];
			$res .= sprintf($tpl, $href, $style, $row['language_code'], $row['language_code']);
		}
		return $res;
	}
	
	//********************************************************************
	echo parse_popup($modul.'/list');
} else {

?>

<script language="JavaScript">
	window.parent.closePopup<? if (!empty($_GET['popup2'])) echo '2'; ?>('yes', 'true');
</script>

<?}?>
