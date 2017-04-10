<select name="filter_<%:field_name%>">
<option value="">All</value>
<%parse_sql_to_html:
SELECT r.id AS option_value\,
	(
		SELECT value
		FROM object_content
		WHERE object_field_id = (
					      select id
					      from object_field
					      where object_id = r.object_id
					      and object_field.object_field_name=\'form_name\'
					      limit 0\,1
					)
		AND object_record_id=r.id
	) AS option_text\,
	"<%:filter_<%:field_name%>%>" as option_value_test
FROM object_record r
WHERE
	r.object_id=(
			select object.id
			from object
			where object.name=\'formbuilder\'
			)
,templates/<%:modul%>/option%>

</select>