<?
	$modul='page_meta';
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}

	$page_id = isset($_POST['t']) ? intval($_POST['t']) : intval($_GET['t']);

	$sql = 'SELECT 
			page_name,
			create_date,
			edit_date
		  FROM 
			v_tpl_page
		 WHERE 
			id='.sqlValue($page_id);

	$res = viewsql($sql, 0);


$current_enc = SQLField2Array(viewsql('SELECT l_encode FROM v_language WHERE language_name='.sqlValue($lang), 0));
$current_enc = $current_enc[0];

//Insert into language-drop-menu(<select><option...) value as "languge_code", and item-caption as "language_name";
$lang_select = parse_sql_to_html('SELECT 
					language_code as option_value,
					language_name as option_text,  
					'.sqlValue($lang).' as option_value_test
				  FROM v_language','templates/option');

$m_sql = '
		  SELECT DISTINCT var FROM content WHERE var = \'meta_title\'
		UNION
		  SELECT DISTINCT var FROM content WHERE var = \'meta_keywords\'
		UNION
		  SELECT DISTINCT var FROM content WHERE var = \'meta_description\'
		UNION

		  SELECT DISTINCT
			 var
		    FROM content
		   WHERE var REGEXP "^meta_"
		     AND var NOT IN (\'meta_title\', \'meta_keywords\', \'meta_description\')
	';
$ar_meta = SQLField2Array(viewsql($m_sql, 0));

$rows=array();
for ($j=0; $j<count($ar_meta);$j++)
		{

			$rows[$j]['meta_name'] = str_replace("meta_","",$ar_meta[$j]);
			$content = cms($ar_meta[$j], $page_id, $lang);
			if (empty($content)) $content = cms('default_'.$ar_meta[$j]);
			$ret = str_replace("&amp;","&",$content);
			$rows[$j]['meta_content'] = $ret;

			//$rows[$j]['meta_num'] = $j;
		}
		$page_meta_cont = parse_array_to_html($rows, 'templates/'.$modul.'/list_row_meta_preview_row');


if($row = db_sql_fetch_assoc($res))
	foreach($row as $key=>$val)
		$$key = $val;
else $page_name = 'Undefined page';

	if(!empty($save))
	{
		while(list($key, $val)=each($_POST))
		{
			$$key=trim($val);
		}
	
        	for ($j=0; $j<count($ar_meta); $j++)
		{
        		$metavar = trim($rows[$j]['meta_name']);

			$val = $$metavar;
//		$val = htmlentities($$metavar, ENT_NOQUOTES);
//		$val = str_replace('&amp;','&',$val);
//		$val = preg_replace('/[^\x09\x0A\x0D\x20-\x7F]/e', '"&#".ord($0).";"', $val);
//		$val = str_replace('&#38;','&amp;',$val);
			save_cms ('meta_'.$metavar, $val, $page_id, $newlang);

		}

		if (post('reload') == 'true')
		{
?>
	<script language="">
		window.parent.closePopup('yes');
	</script>

<?
}
} //else 	echo parse($modul.'/list');
if (empty($reload) || $reload != 'true') { echo parse_popup($modul.'/list', '', false); } ;
?>