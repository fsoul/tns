<?
		global $check_pattern;

 		for ($i=0; $i<count($fields); $i++)
		{
			$field_name = $fields[$i];
			global $$field_name;

			// если это сохранение/добавление
			if (post('refresh'))//тупо && array_key_exists($field_name, $_POST)
			{
				if(!isset($_POST[$field_name]))
					$_POST[$field_name] = null;
				// инициализируем новыми значениями гл.пер-е
				$field_values[$field_name] = $$field_name = $_POST[$field_name];
				
				// проверяем обязательные поля
				if (in_array($fields[$i], $mandatory) &&
					trim($_POST[$field_name])=='')
				{
					$error[$field_name]=EMPTY_ERROR;
				}
	
				if (!preg_match('/'.$check_pattern[$fields[$i]][0].'/', trim($_POST[$field_name])))
				{
					$error[$field_name]=($check_pattern[$fields[$i]][1]!=''?$check_pattern[$fields[$i]][1]:CHECK_PATTERN_ERROR);
				}
			}
			else
				// иначе - берем из базы (редактирование)
				// или будут пустые (новая запись)
				$$field_name = isset($info[$field_name])?$info[$field_name]:'';
		}
?>