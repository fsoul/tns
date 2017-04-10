<select <%iif::readonly,,,disabled%> name="<%:field_name%>">
<option value=""></option>
<%parse_sql_to_html:


SELECT r.id AS option_value\,
	(
		SELECT value
		FROM object_content
		WHERE object_field_id =

		(	select id
			from object_field
			where object_field_name = 'name'
		)

		AND language=\'<%:language%>\'
		AND object_record_id=r.id
	) AS option_text\,
	"<%:<%:field_name%>%>" as option_value_test
FROM object_record r
WHERE
	r.object_id=(
			select object.id
			from object
			where object.name="news_export"
			)

,templates/<%:modul%>/option%>


</select>
<%include:hidden_input_instead_of_disabled_select%>
