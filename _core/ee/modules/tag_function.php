<?
/**
 *  
 * @abstract ������ � ��������� ��� ��������� ������ � ��������
 * @package modules
 *
*/
/**
 * 
 * �������� php ������� �� ��������
 * 
 * @param string $vtag_name �������� �������
 * @param string $vtag_value �������� ���������� � ���� ������ ����� �������
 * @return string
 * 
 */
function tag_func($vtag_name, $vtag_value, $recursion_level = 0)
{
//msg (htm($vtag_value), $vtag_name);
//msg($recursion_level, '$recursion_level');
	// ���� ��� ������� ������
	// (�.�. ���� ����������� ���� <%:vtag_value% >)
	// - ������ �������� ���� �������� ���������� ����������
	// ������� ����� ���������� �� ��������
	if ($vtag_name=='')
	{
		// ��� ������������� ������ ������ ���� ������ ������������� �����-� ��� �������
		$vtag_name = 'getValueOf';
	}
//msg (htm($vtag_value), $vtag_name);

	// �����, ���� ��� ������� �� ������
	// ���� ��������� ����� ����������� �������
	// (�.�. ���� ����������� ���� <%$vtag_name::vtag_value1,:vtag_value2% >) -
	// ������ ��� �� ��������, � ����������

	// ������ �������������� ������� (�������� � ������ SQL-�������),
	// ����� �� ���� ���������� ��� ����������� ���������� �������
	// ����� �������� �������
	$vtag_value = str_replace ('\,', '__coma__', $vtag_value);

	if (strpos($vtag_value, ':')!==false)
	{
//msg(11);
		// ��������� �� �������� ������
		$values = explode(',',$vtag_value);
		// ��� ������� ���������
		for($i=0;$i<count($values);$i++)
		{
			// ������� �������
			$values[$i] = trim($values[$i]);
			// ���� �������� ���������� � ���������
			if (substr($values[$i],0,1)==':')
			{
				// �� ������������ ��� ��� ��� ����. ����������
				// � �������� ��������������� ���������
				$values[$i] = getValueOf(trim(substr($values[$i],1)));
				// ���� � ���������� �������� ��������� �������
				// - ������, ��� ���� ������� ��������������
				$values[$i] = str_replace (',', '__coma__', $values[$i]);
			}
		}
		// �������� ������ ���������� �������, � ������ - ���, ��� ����
		$vtag_value = implode(',',$values);
	}


	// ���������� �������� ���������� ����� ������� � �����
	// ������������� �������������, ���-����, ��������� ���������� ��������� � int
	$values = explode(',',$vtag_value);
	foreach($values as $k=>$v)
	{
		// ���������� ������� � ���������� �������
		$values[$k] = str_replace('\'', '\\\'', $values[$k]);
		// ������������� ��� �������������� ������� � ���������� �������
		$values[$k] = str_replace('\\\\\'', '\\\'', $values[$k]);

		// ��������� �������������� ������� ����� �������������� �������� ������
		$values[$k] = str_replace('\\\'', '__slash_quote__', $values[$k]);
		// ���������� �������� �����
		$values[$k] = str_replace('\\', '\\\\', $values[$k]);
		// ���������� �������������� �������
		$values[$k] = str_replace('__slash_quote__', '\\\'', $values[$k]);
	}
	$vtag_value = implode(',',$values);


	// ���� ���� ����� �������
	if(function_exists($vtag_name))
	{
		// ��������� ��, ��������� �������� � $s
		$f = '$s='.$vtag_name.'(\''.str_replace(',','\',\'',$vtag_value).'\');';
		// ���� ���� �������������� ������� - ���������� �� ������� 
//msg ($f, '$fffff 0');
		$f = str_replace('__coma__', ',', $f);
//msg ($f, '$fffff 1');
		eval($f);

		// ���� ��� ���� ������� ����� �������� ���������� �� ��������� ���� (��������)
		// �.�. ��������� ����� ����� �������������� ��������, � �� ���������� ����� �� ��������,
		// �� ����� �������� �������� ����������� �������
		if (strtolower($vtag_name)=='getvalueof' and $recursion_level>0)
		{
			$s = str_replace(',', '\,', $s);
		}
//msg ($s, $vtag_value);
	}
	else
	{
		echo "<br><b>".$vtag_name."</b>: !function_exists";
		// ���� ����� ������� ��� -
		// �������� � $s ��, ��� �����-�� ���� ����� <% � %>
		$s=$vtag_name.':'.$vtag_value;
	}
	return $s;
}

function strip_commas()
{
	$func_args = func_get_args();
	$text = implode(',', $func_args);
	return str_replace(',', '\,', $text);
}


