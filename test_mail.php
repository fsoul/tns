<?
	include('_core/ee/lib.php');

	$eol = "\r\n";
	$headers = 'From: '.$from.$eol;
	$headers.= 'X-Mailer: PHP/'.phpversion();
//	$headers.= 'MIME-Version: 1.0'.$eol;
//	$headers.= 'Content-Type: text/plain; charset='.getCharset().$eol;

/*
	var_dump(mail('2kgroup-test@rambler.ru', '1 Registration on TNS Opros', '�������� s p!

��� ���������� �������i� �i������� ����i��� http://opros.tns-ua.com/UA/respondent-activate.html?sid=440

�i��� ����� �� �������� ��������� ���� i� ������������ ����� ��� ���������i� �� �i����� � ������� ����� ������ � ���������i.

� ���������� �����������,
������� TNS Opros.', $headers));
*/

	var_dump(mail('2kgroup4@rambler.ru', 'Registration on TNS Opros', 'This is a test of the mailing'));
