<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Statistics</title>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
	<link rel=stylesheet href="<%:EE_HTTP%>css/main.css" type="text/css">
	<script>
		function openWin(id) {
			ew=window.open("pages_mark.php?edit="+id,"Edit","width=400,height=300,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
			ew.focus();
		}
		function openBrowsers(id) {
			ew=window.open("browsers.php?edit="+id,"Edit","width=700,height=50,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
			ew.focus();
		}
		function openIPs(id) {
			ew=window.open("ips.php?edit="+id,"Edit","width=700,height=50,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
			ew.focus();
		}
	</script>
	<script src="calendar.js"></script>
</head>

<body onload="parent.menu.imgClick('statistic')">
<body>
<table border=0 >
	<tr>
		<td width="*" height="31"><a href="?act=stat_all">Общая статистика</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=month">Сравнение по месяцам</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=stat_pages">Статистика по страницам</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=browser">Browsers</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=ip">Ip-addresses</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=users">Сессии</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=pages">Оценка страниц</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=in">Точки входа</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=out">Точки выхода</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=build">Обновить отчет</a></td>
		<td width="*">|</td>
		<td width="*"><a href="?act=rebuild">Сгенерировать отчет</a></td>
	</tr>
</table>
	<%stat_content%>
	<tr bgcolor="092869"><td colspan="6"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td></tr>
	<tr>
		<td><img src="img/inv.gif" width="250" height="1"></td>
		<td><img src="img/inv.gif" width="150" height="1"></td>
		<td><img src="img/inv.gif" width="1" height="1"></td>
	</tr>
</table><br>
<script>
var format = "y-mm-dd";
var needReload = false;
initCalendar("date_from", format);
initCalendar("date_to", format);
initCalendar("date_from2", format);
initCalendar("date_to2", format);
</script>
</body>
</html>
