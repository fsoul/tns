<?
/**
 *  
 * @abstract модуль с функциями для обработки данных в шаблонах
 * @package modules
 *
*/
/**
 * 
 * вызывает php функции из шаблонов
 * 
 * @param string $vtag_name название функции
 * @param string $vtag_value значения параметров в виде списка через запятую
 * @return string
 * 
 */
function tag_func($vtag_name, $vtag_value, $recursion_level = 0)
{
//msg (htm($vtag_value), $vtag_name);
//msg($recursion_level, '$recursion_level');
	// если имя функции пустое
	// (т.е. была конструкция типа <%:vtag_value% >)
	// - значит аргумент есть название глобальной переменной
	// поэтому сразу возвращаем ее значение
	if ($vtag_name=='')
	{
		// для использования одного общего кода просто устанваливаем соотв-е имя функции
		$vtag_name = 'getValueOf';
	}
//msg (htm($vtag_value), $vtag_name);

	// далее, если имя функции НЕ пустое
	// есть двоеточия перед аргументами функции
	// (т.е. была конструкция типа <%$vtag_name::vtag_value1,:vtag_value2% >) -
	// значит это не значения, а переменные

	// меняем экранированные запятые (например в тексте SQL-запроса),
	// чтобы не были восприняты как разделители аргументов функции
	// потом поменяем обратно
	$vtag_value = str_replace ('\,', '__coma__', $vtag_value);

	if (strpos($vtag_value, ':')!==false)
	{
//msg(11);
		// разбираем на запчасти строку
		$values = explode(',',$vtag_value);
		// для каждого аргумента
		for($i=0;$i<count($values);$i++)
		{
			// убираем пробелы
			$values[$i] = trim($values[$i]);
			// если аргумент начинается с двоеточия
			if (substr($values[$i],0,1)==':')
			{
				// то воспринимаем его как имя глоб. переменной
				// и заменяем соответствующим значением
				$values[$i] = getValueOf(trim(substr($values[$i],1)));
				// если в полученном значении появились запятые
				// - прячем, как выше прятали экранированные
				$values[$i] = str_replace (',', '__coma__', $values[$i]);
			}
		}
		// собираем строку аргументов обратно, а дальше - все, как было
		$vtag_value = implode(',',$values);
	}


	// экранируем возможно переданные извне кавычки и слеши
	// дополнительно рекомендуется, все-таки, приводить глобальные аргументы к int
	$values = explode(',',$vtag_value);
	foreach($values as $k=>$v)
	{
		// екранируем кавычки в аргументах функции
		$values[$k] = str_replace('\'', '\\\'', $values[$k]);
		// разекранируем уже экранированные кавычки в аргументах функции
		$values[$k] = str_replace('\\\\\'', '\\\'', $values[$k]);

		// сохраняем экранированную кавычку перед экранированием одиноких слешей
		$values[$k] = str_replace('\\\'', '__slash_quote__', $values[$k]);
		// экранируем одинокие слеши
		$values[$k] = str_replace('\\', '\\\\', $values[$k]);
		// возвращаем экранированную кавычку
		$values[$k] = str_replace('__slash_quote__', '\\\'', $values[$k]);
	}
	$vtag_value = implode(',',$values);


	// если есть такая функция
	if(function_exists($vtag_name))
	{
		// выполняем ее, результат помещаем в $s
		$f = '$s='.$vtag_name.'(\''.str_replace(',','\',\'',$vtag_value).'\');';
		// если были экранированные запятые - возвращаем их обратно 
//msg ($f, '$fffff 0');
		$f = str_replace('__coma__', ',', $f);
//msg ($f, '$fffff 1');
		eval($f);

		// если єто была попытка взять значение переменной во вложенном теге (рекурсия)
		// т.е. результат также будет обрабатываться парсером, а не выводиться сразу на страницу,
		// то нужно спрятать возможно появившиеся запятые
		if (strtolower($vtag_name)=='getvalueof' and $recursion_level>0)
		{
			$s = str_replace(',', '\,', $s);
		}
//msg ($s, $vtag_value);
	}
	else
	{
		echo "<br><b>".$vtag_name."</b>: !function_exists";
		// если такой функции нет -
		// помещаем в $s то, что когда-то было между <% и %>
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


