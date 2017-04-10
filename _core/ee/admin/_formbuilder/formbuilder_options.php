<?php
	$modul='formbuilder_options';

//********************************************************************
	include_once('../lib.php');
//********************************************************************

//—оздаем дл€ каждого свойства option отдельное cms поле с именами
//fb_opt_value{option_id}, fb_opt_title{option_id}a, fb_opt_text{option_id}a
//где будем хранить value, title и text option'а.
//» отдельные cms пол€ дл€ значени€ какой из option'ов €вл€етс€ выбранным с именем fb_sel_opt{sel_id}a
//а также дл€ значени€ какой option €вл€етс€ пустым полем с именем fb_emp_opt{sel_id}a

	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR)
	{
		echo parse('norights');
		exit;
	}
	
	global $lang, $select_id, $option_id, $option_value, $option_title, $option_text, $is_selected, $is_empty;
	
	//get values
	$select_id = (!empty($_GET['select_id']))?$_GET['select_id']:'';
	$option_id = (!empty($_GET['option_id']))?$_GET['option_id']:'';
	$lang = (!empty($_GET['lang']))?$_GET['lang']:$lang;
	
	if (isset($_POST['save']))
	{
		save_cms('fb_opt_text'.$option_id.'a', $_POST['option_text']);
		save_cms('fb_opt_title'.$option_id.'a', $_POST['option_title']);
		save_cms('fb_opt_value'.$option_id.'a', $_POST['option_value']);
		
		if((cms('fb_sel_opt_'.$lang.$select_id.'a') == $option_id && empty($_POST['option_selected'])) || !empty($_POST['option_selected']))
		{
			save_cms('fb_sel_opt_'.$lang.$select_id.'a', $_POST['option_selected']);
		}
		
		if((cms('fb_emp_opt_'.$lang.$select_id.'a') == $option_id && empty($_POST['option_empty'])) || !empty($_POST['option_empty']))
		{
			save_cms('fb_emp_opt_'.$lang.$select_id.'a', $_POST['option_empty']);
		}
		finish();
	}
	
	$option_value = cms('fb_opt_value'.$option_id.'a');
	$option_title = cms('fb_opt_title'.$option_id.'a');
	$option_text = cms('fb_opt_text'.$option_id.'a');
	
	$is_selected = cms('fb_sel_opt_'.$lang.$select_id.'a');
	$is_empty = cms('fb_emp_opt_'.$lang.$select_id.'a');
	
	echo parse_popup($modul.'/edit');
	

	function finish()
	{
?>
<script language="JavaScript">
window.parent.closePopup('no');
</script>
<?
	}
	
	function print_avail_languages()
	{
		global $lang, $t, $cms_name;
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

?>