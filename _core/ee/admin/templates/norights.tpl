<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>No right</title>
<script type="text/javascript">
function goLogin() {
	setTimeout("window.top.location.href='<%:EE_ADMIN_URL%>index.php'",200);
}
</script>
</head>

<body bgcolor="#ffffff">

Sorry. You have no rights<br>
Click <a href="<%:EE_ADMIN_URL%>index.php" target="_top">here</a> to logon.
<%msg::UserRole,User Role%>
<%msg:<%checkAdmin%>,Check Admin%>

</body>
</html>
