<?
//********************************************************************
	include_once('../lib.php');
//********************************************************************

//проверяем права 
check_modul_rights(array(ADMINISTRATOR, POWERUSER), 'Administration/Page Aliases');

// очищаем все сообщения
$msg=$error="";
// если в форме нажали на Apply - 
// проверить правильность заполнения и попытаться установить алиас
if (isset($_POST['submit']))
{
	// получить оригинал из самой формы
	$orig=$_POST['orig'];
	$alias=$_POST['alias'];
	$alias = preg_replace('/[^0-9a-zA-Z\.\-\_\!\~\/]/','',$alias);
	$alias = preg_replace('/^\//','',$alias);
	if ($alias!="")
	{
		$db_orig=set_alias($alias, $orig);
		if ($db_orig==$orig)
		{
			// если удалось установить алиас для этого URL'а
			win_close();
		}
		else
		{
			$error='Alias <b>"'.$alias.'"</b> already reserved for URL <b>"'.$db_orig.'"</b>';
			$error.="<br>Enter another alias...";
		}
	}
	else
	{
		$error="Enter not empty alias...";
	}
}
else
{
	$url = $REQUEST_URI;
	$url = substr($url, strpos($url,'=')+1);
	$url = substr($url, strpos($url,'=')+1);
	if (!empty($_GET['del'])) $url = substr($url, strpos($url,'=')+1);
	$url = substr($url,strpos($url,'?'));
	$orig = clear_uri($url);
}

if (isset($_GET['del']))
{
	$sql = 'DELETE FROM aliase WHERE id = '.sqlValue($_GET['del']);
	$res = runsql($sql);
}

function print_list()
{
	global $orig, $b_color;

	$sql = 'select * from aliase where original = '.sqlValue($orig).' order by alias asc';
	$rs = viewsql($sql);
	$s='';
	$c=0;
	while($r = db_sql_fetch_array($rs))
	{
		$s.='<tr bgcolor="'.$b_color[$c].'">';
		$c=1-$c;
		$s.='<td align="center" class="table_data">'.$r['original'].'</td>';
		$s.='<td align="center" class="table_data">'.$r['alias'].'</td>';
		$s.='<td align="center" class="table_data">';
		$s.='<a href="#" onclick="del(\''.$r['id'].'\', \''.strtoupper($r['alias']).'\')"><img src="'.EE_HTTP.'img/delBt.gif" alt="<%cons:GRID_DEL%>" title = "<%cons:GRID_DEL%>" width="15" height="15"  border="0" /></a>';
		$s.='</td>';
		$s.='</tr>';
	}
	return $s;
}

function win_close()
{
?>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<html>
	<body>
	<script language="JavaScript">
	    window.parent.closePopup('yes');
	</script>
	</body>
	</html>
<?
	die();
}

?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Set alias</title>
	<link rel=stylesheet href="../css/admin_panel_style.css" type="text/css">
<?echo print_admin_js();?>
</head>
<script language="JavaScript">
function del(code, name) {
    frm=document.forms[0];
    if(confirm('Delete '+name+'?')) {
        frm.action='alias.php?del='+code+'&alias_default=<?echo $alias_default;?>'+'&orig=<?echo $orig;?>';
        frm.submit();
    } else return false;
}
</script>
<body bgcolor="#ffffff">
<table width="100%" border=0 cellpadding="0" cellspacing="0">
	<tr>
		<td id="admin_popup_header">Set alias</td>
	</tr>
</table>
<form name="form1" method="post" action="?">

<table style="border: 1px solid #333333; margin: 3px;" width="500" cellpadding="0" cellspacing="0" border="0" class="tableborder">
    <tr bgcolor="#eeeeee">
        <td align="center" class="table_header"><b>Page</b></td>
        <td align="center" class="table_header"><b>Alias</b></td>
        <td align="center" class="table_header"><b>Delete</b></td>
    </tr>
    <tr bgcolor="092869"><td colspan="5"></td></tr>
    <? echo print_list();?>
</table>
</form>
<br>
<form name="form2" method="post" action="?">
<table style="border: 1px solid #333333; margin: 3px;" width="500" cellspacing="0" cellpadding="0" border="0" class="table_data">
    <tr bgcolor="#eeeeee">
        <td colspan="2" align="center" class="table_header"><b>Add new alias</b></td>
    </tr>
	<tr>
		<td style="padding: 3px;">Current page:</td>
		<input size="50" type="hidden" name="orig" value="<?if (!empty($orig)) echo $orig;?>">
		<td class="header"><?=$orig?></td>
	</tr>
	<tr>
		<td style="padding: 3px;">Default alias:</td>
		<input size="50" type="hidden" name="alias_default" value="<?if (!empty($alias_default)) echo $alias_default;?>">
		<td class="header"><?if (!empty($alias_default)) echo $alias_default;?></td>
	</tr>
	<tr>
		<td style="padding: 3px;">Alias for current page</td>
		<td><input size="50" type="text" name="alias" value="<?if (!empty($alias)) echo $alias;?>"></td>
	</tr>
	<tr>
		<td style="padding: 3px;" colspan="2" align="center">
		<input class="button" type="submit" name="submit" value="Add"> <input class="button" type="button" name="reset" value="Close" onclick="window.parent.closePopup(<? if (!empty($del)) echo '\'yes\'';?>)">
		</td>
	</tr>
<?	if($msg!='') {?>
		<tr><td><?=$msg?></td></tr>
<?	}
	if($error!='') {?>
		<tr bgcolor="#F0F0F0"><td class="error" colspan="2" align="center"><?echo $error?></td></tr>
<?	}?>
</table>
</form>
<script language="JavaScript">document.form2.alias.focus()</script>
</body>
</html>