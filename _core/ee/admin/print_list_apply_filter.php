<?

		// проходимся по всем полям грида
		for($i=0; $i<count($fields); $i++)
		{
			$filter_field = 'filter_'.$fields[$i];
			global $$filter_field;

			// если ввели нечто в кавічках - будем искать точное совпадение
			$val_with_quotes = trim(urldecode($$filter_field));
			// bug_id = 10517
			$val_with_quotes = db_sql_escape_string($val_with_quotes);
			// bug_id = 9939
			$val_with_quotes = addcslashes($val_with_quotes, '_%');

			$val = trim_str($val_with_quotes, '\"');

			// если соотве-я глоб-я пер-я фильтра не пуста
			if ($val_with_quotes != '')
			{
				// куки
				$ar_usl[] = $filter_field.'='.$val;

				$next_field_name = sprintf($filter_function[$fields[$i]], $fields[$i], sqlValue($val));

				// если имя поля "id" или заканчивается на "_id"
				// или ввели нечто в кавь|чках
				// - ищем точное совпадение
				if (	(strtolower($fields[$i]) == 'id')
				   	||
				   	((stristr(strtolower($fields[$i]), '_id')) == '_id')
				   	||
				   	($val_with_quotes == '\"'.$val.'\"')
				)
				{
					$ar_where[] = $next_field_name.' = '.sqlValue($val);
				}
				// если имя поля заканчивается на "_sql"
				// - не используем значение для сравнения, так как в єтом случае
				// разработчик д.б. сам поместить все необх-е в соотв-й массив $filter_function[имя_поля]
				elseif ((stristr(strtolower($fields[$i]), '_sql')) == '_sql')
				{
					$ar_where[] = $next_field_name;
				}
				// ищем подстроку
				else
				{
					$ar_where[] = 'UPPER('.$next_field_name.') like UPPER('.sqlValue('%'.$val_with_quotes.'%').')';
				}
			}
		}

		$where = implode(' and ', $ar_where);

msg($where, '$where');

		$usl = implode('&', $ar_usl);
		// сохраняем в куки
		store_values($usl, $modul);

		// добавляем условие where до запроса
		$sql.= $where.$order;
?>