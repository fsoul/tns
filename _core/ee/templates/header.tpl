<%include:head%>
<div id="common">
	<div id="header">
		<div id="language">
			<%parse_sql_to_html:
			 select language_code as lang_code\,
				language_name as lang_name
			   from v_language
			  where status=1
			,lang%>
		</div>
		header
	</div>
	<div id="main">
