<?
//if enabled draft mode for dns
if($dns_draft_status)
{ 
	header("Location:".EE_HTTP); 
	exit;
}
  $admin=true;
//********************************************************************
//vdump(CheckAdmin(), 'CheckAdmin()');
//vdump($UserRole, '$UserRole');
//vdump(USER, 'USER');
//********************************************************************
if(CheckAdmin() and $UserRole>USER)
{
	$url = EE_HTTP.'index.php?admin_template=yes';
//vdump($url, '$url');
//exit;

	header('Location: '.$url);

	exit;
}
if(!empty($_POST['login']) and !empty($_POST['pass'])) {
//***********************************************************************************
//                          Проверка авторизации
//***********************************************************************************
	$where = ' WHERE login = '.sqlValue($_POST['login']).'
		   and passw = '.sqlValue(md5($_POST['pass'])).'
		   and role > '.USER.'
		   and status = '.ENABLED;
	$sql = '
		SELECT resetpassw
		  FROM users'.$where;

	$rs = viewsql($sql,0);
	list($reset) = db_sql_fetch_array($rs);
	
	if($reset==1)
	{
		header('Location: _user.php?op=change_reset_pass&user='.$_POST['login']);
		exit;
	}
	if (autorize($_POST['login'], md5($_POST['pass'])))
	{
		//bug_id=11464
		if (login_expired($_POST['login']))
		{
			logout();
			header('Location: _user.php?op=change_reset_pass&user='.$_POST['login'].'&login_expired=yes');
			exit;
		}

		if(check_password($_POST['login'], $_POST['pass']) != 1)
		{
			logout();
			header('Location: _user.php?op=change_reset_pass&user='.$_POST['login'].'&new_conditions=yes');
			exit;
		}

//var_dump($_SESSION);exit;
		$url = EE_HTTP.'index.php?admin_template=yes';
		//vdump($url, '$url');
		//exit;
	
		header('Location: '.$url);
	} else $error="Incorrect login or password";
}
if (!empty($_GET["not"]) && $_GET["not"]==1) $notify = "A new password has been sent to your email address";

echo parse('login_page_header');?>

	<tr bgcolor="#F0F0F0">
		<td colspan="3"><div id="error" class="error"></div></td>
	<tr>

        <tr bgcolor="#F0F0F0">
            <td class="table_data">Login:</td>
            <td><input value="" type="text" id="login" name="login" value="<?if(!empty($login)) echo $login;?>" size="18" autocomplete="off" /></td>
	    <td><div id="admin_login_errors" class="error" style="text-align: left;"></div></td>
        </tr>
        <tr bgcolor="#F0F0F0">
            <td class="table_data">Password:</td>
            <td><input value="" type="password" id="pass" name="pass" size="18" autocomplete="off" /></td>
	    <td><div id="admin_password_errors" class="error" style="text-align: left;"></div></td>
        </tr>
        <tr bgcolor="#F0F0F0">
            <td colspan="3" align="left">
                <input type="submit" name="submit" value="Login" class="button">
            </td>
        </tr>
        <tr bgcolor="#F0F0F0">
        	<td colspan="3" align="center">
        		<a href="_user.php?op=reset_password">Reset password</a>
        	</td>
        </tr>
<?  if(!empty($error)) {?>
        <tr bgcolor="#F0F0F0"><td class="error" colspan="3" align="center"><? echo $error ?></td></tr>
<?  }?>
<?  if(!empty($notify)) {?>
        <tr bgcolor="#F0F0F0"><td colspan="3" align="center"><?echo $notify?></td></tr>
<?  }?>

<?=parse('login_page_footer');?>
