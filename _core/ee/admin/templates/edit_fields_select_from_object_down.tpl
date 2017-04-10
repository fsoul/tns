<%parse_sql_to_html:

SELECT r.id AS option_value\,
	(
		SELECT value
		FROM object_content
		WHERE object_field_id = (
					      select id
					      from object_field
					      where object_id = r.object_id
					      and UPPER(object_field.object_field_type)=\'TEXT\'
					      and object_field.object_field_name=\'value\'
					      limit 0\,1
					    UNION
					      select id
					      from object_field
					      where object_id = r.object_id
					      and UPPER(object_field.object_field_type)=\'TEXT\'
					    LIMIT 0\,1
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
			where object.name=\'<%str_replace:_id,,:field_name%>\'
			)

,templates/<%:modul%>/option%>

</select>
