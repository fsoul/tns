<?
	include('_core/ee/lib.php');

	$eol = "\r\n";
	$headers = 'From: '.$from.$eol;
	$headers.= 'X-Mailer: PHP/'.phpversion();
//	$headers.= 'MIME-Version: 1.0'.$eol;
//	$headers.= 'Content-Type: text/plain; charset='.getCharset().$eol;

/*
	var_dump(mail('2kgroup-test@rambler.ru', '1 Registration on TNS Opros', 'Шановний s p!

Для завершення реєстрацiї вiдкрийте сторiнку http://opros.tns-ua.com/UA/respondent-activate.html?sid=440

Пiсля цього Ви отримаєте наступний лист iз нагадуванням даних для авторизцаiї та вiдразу ж зможете взяти участь в опитуваннi.

З найкращими побажаннями,
Команда TNS Opros.', $headers));
*/

	var_dump(mail('2kgroup4@rambler.ru', 'Registration on TNS Opros', 'This is a test of the mailing'));
