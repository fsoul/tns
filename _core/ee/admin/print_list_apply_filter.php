<?

		// ���������� �� ���� ����� �����
		for($i=0; $i<count($fields); $i++)
		{
			$filter_field = 'filter_'.$fields[$i];
			global $$filter_field;

			// ���� ����� ����� � ������� - ����� ������ ������ ����������
			$val_with_quotes = trim(urldecode($$filter_field));
			// bug_id = 10517
			$val_with_quotes = db_sql_escape_string($val_with_quotes);
			// bug_id = 9939
			$val_with_quotes = addcslashes($val_with_quotes, '_%');

			$val = trim_str($val_with_quotes, '\"');

			// ���� ������-� ����-� ���-� ������� �� �����
			if ($val_with_quotes != '')
			{
				// ����
				$ar_usl[] = $filter_field.'='.$val;

				$next_field_name = sprintf($filter_function[$fields[$i]], $fields[$i], sqlValue($val));

				// ���� ��� ���� "id" ��� ������������� �� "_id"
				// ��� ����� ����� � ����|����
				// - ���� ������ ����������
				if (	(strtolower($fields[$i]) == 'id')
				   	||
				   	((stristr(strtolower($fields[$i]), '_id')) == '_id')
				   	||
				   	($val_with_quotes == '\"'.$val.'\"')
				)
				{
					$ar_where[] = $next_field_name.' = '.sqlValue($val);
				}
				// ���� ��� ���� ������������� �� "_sql"
				// - �� ���������� �������� ��� ���������, ��� ��� � ���� ������
				// ����������� �.�. ��� ��������� ��� �����-� � �����-� ������ $filter_function[���_����]
				elseif ((stristr(strtolower($fields[$i]), '_sql')) == '_sql')
				{
					$ar_where[] = $next_field_name;
				}
				// ���� ���������
				else
				{
					$ar_where[] = 'UPPER('.$next_field_name.') like UPPER('.sqlValue('%'.$val_with_quotes.'%').')';
				}
			}
		}

		$where = implode(' and ', $ar_where);

msg($where, '$where');

		$usl = implode('&', $ar_usl);
		// ��������� � ����
		store_values($usl, $modul);

		// ��������� ������� where �� �������
		$sql.= $where.$order;
?>