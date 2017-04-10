<html>
<style>
body {
	background-color: #FFFFFF;
	font-size: 11px;
	color:#000000;
	font-family:verdana, arial, helvetica, sans serif;
	text-decoration: none;
}
</style>
<body>

<%cms:news_letter_body_<%:edit%>%>
<%iif::show_email_link,1,<a href="<%:EE_HTTP%>index.php?t=<%:email_tpl%>&edit=<%:edit%>&language=<%:language%>"><%cms:text_for_nl__go_to_page%></a>%> <%show_go_to_page_control%>

</body>
</html>