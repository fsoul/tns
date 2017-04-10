<?
//	Сохраним строку с перечнем переменных в кукисах
function store_values($usl, $from)
{
	setcookie('usl_'.$from, '', time()-3600);
	setcookie('usl_'.$from, $usl);
}
//	считаем ранее сохранённую строку с перечнем переменных из кукисов, и в случае удачи распарсим её
function load_stored_values($from)
{
	global $load_cookie, $HTTP_COOKIE_VARS;
	if ($load_cookie and $HTTP_COOKIE_VARS['usl_'.$from] != '')
	{
		$c_vars=explode("&", $HTTP_COOKIE_VARS['usl_'.$from]);
		for($i=0;$i<count($c_vars);$i++)
		{
			list($k,$v)=split('=',$c_vars[$i]);
			if (!isset($_GET[$k]))
			{
				global $$k;
				$$k=$v;
			}
		}
	}
}
//	Функция для генерации стрелки при сортировке
function decode($img)
{
	global $srt;
	if($img==$srt) $s='<img src="'.EE_HTTP.'img/arrowTop.gif" border="0" alt="Ascending"/>&nbsp;';
	else if($img==-$srt) $s='<img src="'.EE_HTTP.'img/arrowBottom.gif" border="0" alt="Descending"/>&nbsp;';
		else $s='<img src="'.EE_HTTP.'img/arrowRight.gif" border="0" alt="Not sorted"/>&nbsp;';
	return $s;
}

//	На основании клика юзера генерим порядок сортировки
function getSortOrder()
{
	global $click, $sort, $srt, $sort_function, $enum_field;

	$order = '';

	if (	!is_array($sort) || 
		!is_array($sort_function)
	   )
	{
		return $order;
	}

	$field_format = '`%s`';
	
	if (	$click>0 and 
		$click<=count($sort) and 
		array_key_exists($click, $sort) and
		array_key_exists($sort[$click], $sort_function)
		)
	{
		$order = sprintf($sort_function[$sort[$click]], sprintf($field_format, $sort[$click]));

		if (abs($srt)==$click)
		{
			if ($srt<0)
			{
				$order = '';
				$srt = '';
			}
			else
			{
				$srt = '-'.$click;

				if ($order!='')
				{
					$order.= ' desc';
				}
			}
		}
		else
		{
			$srt = $click;
		}
	}
	else if($srt!='' and $click<0 and array_key_exists(abs($srt), $sort))
	{
//vdump($sort, 'sort');
//vdump($sort_function, '$sort_function');
//		$order=' order by '.$sort[abs($srt)];
		$order = sprintf($sort_function[$sort[abs($srt)]], sprintf($field_format, $sort[abs($srt)]));

		if ($srt<0 && $order!='')
		{
			$order.= ' desc';
		}
	}
//msg($order, '$order');
	// use 'order by' only if appropriate field was realy found, i.e. we have what to order by
	// otherwise - don't use order (for exmple somebody wants to order by not existing field)
	if ($order!='')
	{
		$order = ' order by '.$order;
	}

	/*
	** bug id = 7157
	** To sort enumeration fields in mysql use [...binary(field)...]
	*/
	if(is_array($sort) && is_array($enum_field))
	{
		if (	array_key_exists($click, $sort) and
			array_key_exists($sort[$click], $enum_field) and
			$sort[$click] == $enum_field[$sort[$click]]
		)
		{
			$order = preg_replace('/order by/i', 'order by binary', $order);
		}
	}

//msg($srt, '$srt');
//msg($click, '$click');
//msg($order, '$order');
//if (DEBUG_MODE) exit;
	return $order;
}

//	Будем возвращать значение ошибки
function getError($name)
{
	global $error;
	if (!empty($error[$name])) return $error[$name];
		else return '';
}
//	Функция для нормализации получаемого содержимого. Убирает все неразрешённые теги
function norm($str)
{
// prevent constants display
//	$tags[]='<%';

	$tags[]='<div';
	$tags[]='</div';
	$tags[]='<p';
	$tags[]='</p';
	$tags[]='<span';
	$tags[]='</span';
	$tags[]='<ol';
	$tags[]='</ol';
	$tags[]='<ul';
	$tags[]='</ul';
	$tags[]='<font';
	$tags[]='</font';
	$tags[]='<li';
	$tags[]='</li';
	$tags[]='<br>';
	$tags[]='<blockquote';
	$tags[]='</blockquote';
	$tags[]='<b>';
	$tags[]='</b>';
	$tags[]='<i';
	$tags[]='</i';
	$tags[]='<em';
	$tags[]='</em';
	$tags[]='<strong';
	$tags[]='</strong';
	$tags[]='<sup';
	$tags[]='</sup';
	$tags[]='<sub';
	$tags[]='</sub';
	$tags[]='<a';
	$tags[]='</a';
	$tags[]='<br';
	$tags[]='<u';
	$tags[]='</u';
	$tags[]='<img';
	$tags[]='<table';
	$tags[]='</table';
	$tags[]='<td';
	$tags[]='</td';
	$tags[]='<tr';
	$tags[]='</tr';
	$tags[]='<h1';
	$tags[]='</h1';
	$tags[]='<h2';
	$tags[]='</h2';
	$tags[]='<h3';
	$tags[]='</h3';
	$tags[]='<h4';
	$tags[]='</h4';
	$tags[]='<h5';
	$tags[]='</h5';
	$tags[]='<input';
	$tags[]='<button';
	$tags[]='<textarea';
	$tags[]='</textarea';
	$tags[]='<select';
	$tags[]='</select';
	$tags[]='<option';
	$tags[]='</option';
//	$tags[]='<script';
//	$tags[]='</script';

	$regular = '';

	for ($i=0; $i < count($tags); $i++)
	{
		$regular.= ($i > 0 ? '|' : '').'^'.$tags[$i];
	}

	$t_len = strlen($str);

	$s = '';

	for ($i=0; $i<$t_len; $i++)
	{
		$tagOpen = strpos($str, "<", $i);

		if($tagOpen === false)
		{
			$s .= substr($str,$i);
			break;
		}
		else
		{
			$tagClose = strpos($str, ">", $tagOpen);

			if ($tagClose === false)
			{
				$s .= substr($str,$i);
				break;
			}
			else
			{
				$i_tagOpen = strpos($str, "<", $tagOpen + 1);

				if ($i_tagOpen > $tagOpen && $i_tagOpen < $tagClose)
				{
					$tagOpen = $i_tagOpen;
				}

				$s .= substr($str, $i, $tagOpen-$i);

				$tag = substr($str, $tagOpen, $tagClose - $tagOpen + 1);

				if (preg_match('/'.$regular.'/i', $tag))
				{
					$s .= $tag;
				}

				$i = $tagClose;
			}
		}
	}

	return($s);
}

//**********************************************************
function dcd($str)
{
	$s=preg_replace('/<%/', '&lt;%', $str);
	$s=preg_replace('/%>/', '%&gt;', $s);
	return $s;
}

function encd($str)
{
	$s=preg_replace('/&lt;%/', '<%', $str);
	$s=preg_replace('/%&gt;/', '%>', $s);
	return $s;
}

//**********************************************************
function fNew()
{
	global $fNew;
	$s='<select name="fNew" class="table_data">';
	$s.='<option value="0"';if($fNew==0) $s.=' selected';$s.='>All';
	$s.='<option value="'.(DISABLED+1).'"';if($fNew==(DISABLED+1)) $s.=' selected';$s.='>No';
	$s.='<option value="'.(ENABLED+1).'"';if($fNew==(ENABLED+1)) $s.=' selected';$s.='>Yes';
	$s.='</select>';
	return $s;
}

function fStatus($yes='Enabled', $no='Disabled')
{
	global $fStatus;
	$s='<select name="fStatus" class="table_data">';
	$s.='<option value="0"';if($fStatus==0) $s.=' selected';$s.='>All';
	$s.='<option value="'.(DISABLED+1).'"';if($fStatus==(DISABLED+1)) $s.=' selected';$s.='>'.$no;
	$s.='<option value="'.(ENABLED+1).'"';if($fStatus==(ENABLED+1)) $s.=' selected';$s.='>'.$yes;
	$s.='</select>';
	return $s;
}

function aStatus($yes='Enabled', $no='Disabled')
{
	global $aStatus;
	$s='<table border="0">';
	$s.='<tr><td><input type="radio" name="aStatus" value="'.DISABLED.'"';if($aStatus==DISABLED) $s.=' checked';$s.='></td><td class="table_data">'.$no.'</td></tr>';
	$s.='<tr><td><input type="radio" name="aStatus" value="'.ENABLED.'"';if($aStatus==ENABLED) $s.=' checked';$s.='></td><td class="table_data">'.$yes.'</td></tr>';
	$s.='</table>';
	return $s;
}

function getStatus($id, $yes='Enabled', $no='Disabled')
{
	if($id==DISABLED) return $no;
	else return $yes;
}
//**********************************************************
function fUsers()
{
	global $fUsers;
	$s='<select name="fUsers">';
	$s.='<option value="0"';if($fUsers==0) $s.=' selected';$s.='>All';
	$rs=db_sql_query('select id,name,status from users order by name');
	while($r=db_sql_fetch_array($rs))
	{
		$s.='<option value="'.$r['id'].'"';
		if($r['id']==$fUsers) $s.=' selected';
		$s.='>'.$r['name'];
		if($r['status']!=1) $s.=' (disabled)';
	}
	$s.='</select>';
	return $s;
}

function getUser($id)
{
	if($id==0)
		return '';
	else
	{
		$rs=db_sql_query('select name, status from users where id='.$id);
		if(db_sql_num_rows($rs)<1) return 'error';
		else
		{
			$r=db_sql_fetch_array($rs);
			$s=$r['name'];
			if($r['status']!=ENABLED) $s.=' (disabled)';
			return $s;
		}
	}
}

//**********************************************************
function fRole()
{
	global $fRole;
	$s='<select name="fRole" class="table_data">';
	$s.='<option value="0"';if($fRole==0) $s.=' selected';$s.='>All';
	$s.='<option value="'.(USER+1).'"';if($fRole==(USER+1)) $s.=' selected';$s.='>User';
	$s.='<option value="'.(POWERUSER+1).'"';if($fRole==(POWERUSER+1)) $s.=' selected';$s.='>Power User';
	$s.='<option value="'.(ADMINISTRATOR+1).'"';if($fRole==(ADMINISTRATOR+1)) $s.=' selected';$s.='>Administrator';
	$s.='</select>';
	return $s;
}

function aRole()
{
	global $aRole;
	$s='<select name="aRole">';
	$s.='<option value="'.USER.'"';if($aRole==USER) $s.=' selected';$s.='>User';
	$s.='<option value="'.POWERUSER.'"';if($aRole==POWERUSER) $s.=' selected';$s.='>Power User';
	$s.='<option value="'.ADMINISTRATOR.'"';if($aRole==ADMINISTRATOR) $s.=' selected';$s.='>Administrator';
	$s.='</select>';
	return $s;
}

function getRole($id)
{
	switch($id)
	{
		case POWERUSER: $s='PowerUser';break;
		case USER: $s='User';break;
		case ADMINISTRATOR: $s='<span style="color:#ff0000">Administrator</span>';break;
		default : $s='ERROR';break;
	}
	return $s;
}

//**********************************************************
function show_admin_panel()
{
	global $UserRole;
	if($UserRole==ADMINISTRATOR) return true;
	else return false;
}

//**********************************************************
function killSlashes($str)
{
	$s=stripcslashes($str);
	while(strpos($s,"\'")) $s=stripcslashes($s);
	return $s;
}

function check_access()
{
	if(!checkAdmin()) {header('Location: index.php'); exit;}
}

function user_authorize()
{
	if(!checkAdmin()) return parse('login');
	else return parse('user_info');
}

//	Проверка корректности электронного адреса
function check_email($mail)
{
	return preg_match('/'.EMAIL_PATTERN.'/', $mail);
}

function print_is_admin_link()
{
	if (get('admin_template') == 'yes')
	{
		return '&admin_template=yes'; 
	}
	else
	{
		return '';
	}
}

