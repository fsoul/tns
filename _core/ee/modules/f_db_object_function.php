<?
/**
 * This file contains functions that work with DB for objects of 3 types: add, edit, delete.
 * Functions are used in admin panel only.
 */

/**
 * Adds object template. 
 * It connects indicated template with indicated object for automatical page-generation
 * for each one object element on base this template. 
 * @param int $obj_id - object id
 * @param int $tpl_id - template id
 */
function f_add_object_template($obj_id, $tpl_id)
{
	$sql = 'SELECT
			id
		FROM
			object_template
		WHERE
			(
			object_id='.sqlValue($obj_id).'
			AND
			template_id='.sqlValue($tpl_id).'
			)
		';

	$ret = 0;
	if (db_sql_num_rows(ViewSQL($sql,0)) > 0)
		$ret = -1;

	if ($ret == 0)
	{
		$ret = RunSQL('INSERT INTO object_template SET object_id='.sqlValue($obj_id).', template_id='.sqlValue($tpl_id),0);
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Deletes object template
 * @param int $pId - object view id
 * @return int 1
 */
function f_del_object_template($pId)
{
	RunSQL('DELETE FROM object_template WHERE id='.sqlValue($pId));
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

/**
 * Deletes object templates
 * @param int $pId - array of object view id's
 * @return int 1
 */   
function f_del_object_templates($pId)
{
       	RunSQL('DELETE FROM object_template WHERE id in('.sqlValuesList($pId).')');    
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

/**
 * Updates  object template
 * @param int $pId object id
 * @param int $obj_id
 * @param int $tpl_id
 * @return int returns object view id if success or error id if false
 */
function f_upd_object_template($pId, $obj_id, $tpl_id)
{
	$sql = 'SELECT
			id
		FROM
			object_template
		WHERE
			object_id='.sqlValue($obj_id).'	AND template_id='.sqlValue($tpl_id);
	$ret = 0;
	if (db_sql_num_rows(ViewSQL($sql,0)) > 0)
		$ret = -1;

	if ($ret == 0)
	{
		RunSQL('UPDATE object_template SET object_id='.sqlValue($obj_id).', template_id='.sqlValue($tpl_id).' WHERE id = '.sqlValue($pId), 0);
		$ret = $pId;
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}


/**
 * Adds object field type
 * @param string $pType Type of field that must be added
 * @param int $pFlag indicates if fields of this type stores one common value for all languages
 * @return int returns Type id if success or error id if false
 */
function f_add_object_field_type($pType, $pFlag)
{
	$ret = 0;

	$pFlag = ( ((int)$pFlag) == 0 ? 0 : 1 );

	if (db_sql_num_rows(ViewSQL('SELECT id FROM object_field_type WHERE object_field_type = '.sqlValue($pType), 0)) > 0)
	{
		$ret = -1;
	}

	if ($ret == 0)
	{
		$ret = RunSQL('INSERT INTO object_field_type SET object_field_type = UPPER('.SQLValue($pType).'), one_for_all_languages = '.sqlValue($pFlag), 0);
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}
/**
 * Deletes object field type
 * @param int $pId - type id
 * @return int 1
 */
function f_del_object_field_type($pId)
{
	RunSQL('DELETE FROM object_field_type WHERE id = '.sqlValue($pId));
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

/**
 * Deletes object field types
 * @param int $pId - list of type ids like "'1','2','3'"
 * @return int 1
 */

function f_del_object_field_types($pId)
{                      
       	RunSQL('DELETE FROM object_field_type WHERE id in('.sqlValuesList($pId).')');    
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}
/**
 * Updates object field type
 * @param int $pId object field type id
 * @param string $pType value, that must be updated
 * @param int $pFlag indicates if fields of this type stores one common value for all languages
 * @return int returns object id if success or error id if false
 */
function f_upd_object_field_type($pId, $pType, $pFlag)
{
	$pFlag = ( ((int)$pFlag) == 0 ? 0 : 1 );

	RunSQL('UPDATE object_field_type SET object_field_type = UPPER('.SQLValue($pType).'), one_for_all_languages = '.sqlValue($pFlag).' WHERE id = '.sqlValue($pId), 0);
	$ret = $pId;
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Adds object
 * @param string $pObject_name Name of object, that must be added
 * @return int returns object id if success or error id if false
 */
function f_add_object($pObject_name)
{
	$ret = 0;
	if (db_sql_num_rows(ViewSQL('SELECT id FROM object WHERE name = "'.$pObject_name.'";',0)) > 0)
		$ret = -1;

	if ($ret == 0)
	{
		$ret = RunSQL('INSERT INTO object SET name = '.SQLValue($pObject_name).';',0);
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Deletes object
 * @param int $pId - object id
 * @return int 1
 */
function f_del_object($pId)
{
	RunSQL('DELETE FROM object WHERE id = "'.$pId.'";');
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}


/**
 * Deletes objects
 * @param int $pId - array of object id's
 * @return int 1
 */   
function f_del_objects($pId)
{
	RunSQL('DELETE FROM object WHERE id in('.sqlValuesList($pId).')');
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

/**
 * Updates object
 * @param int $pId object id
 * @param string $pObject_name value, that must be updated
 * @return int returns object id if success or error id if false
 */
function f_upd_object($pId, $pObject_name)
{
	$ret = 0;
	if (db_sql_num_rows(ViewSQL('SELECT id FROM object WHERE name = '.SQLValue($pObject_name).' AND id != '.SQLValue($pId).';',0)) > 0)
		$ret = -1;

	if ($ret == 0)
	{
		RunSQL('UPDATE object SET name = '.SQLValue($pObject_name).' WHERE id = "'.$pId.'";',0);
		$ret = $pId;
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}


/**
 * Adds object record
 * @param int $pObject_id id of object, for whitch record must be added
 * @return int returns record id if success or error id if false
 */
function f_add_object_record($pObject_id)
{
	$ret = 0;
	if (db_sql_num_rows(ViewSQL('SELECT id FROM object WHERE id = '.sqlValue($pObject_id), 0)) <= 0)
		$ret = -1;

	if ($ret == 0)
	{
		$ret = RunSQL('INSERT INTO object_record SET object_id = '.sqlValue($pObject_id).', last_update = CURRENT_TIMESTAMP(), user_name = '.SQLValue(session('UserName')), 0);
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Deletes object record
 * @param int $pRecordId - object record id
 * @return int 1
 */
function f_del_object_record($pRecordId)
{
	RunSQL('DELETE FROM url_mapping_object WHERE object_record_id = '.sqlValue($pRecordId), 1);
	RunSQL('DELETE FROM permanent_redirect_object WHERE object_record_id = '.sqlValue($pRecordId), 1);
	RunSQL('DELETE FROM object_record WHERE id = '.sqlValue($pRecordId), 1);
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}


/**
 * Deletes object records
 * @param int $pRecordId - array of object records id
 * @return int 1
 */
function f_del_object_records($pRecordId)
{
	RunSQL('DELETE FROM url_mapping_object WHERE object_record_id in('.sqlValuesList($pRecordId).')', 1);
	RunSQL('DELETE FROM permanent_redirect_object WHERE object_record_id in('.sqlValuesList($pRecordId).')', 1);
	RunSQL('DELETE FROM object_record WHERE id in('.sqlValuesList($pRecordId).')', 1);
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}



/**
 * Updates object record
 * @param int $pObject_id id of object, for whitch record must be updated
 * @param int $pRecordId id of record whitch must be updated
 * @return int returns record id if success or error id if false
 */
function f_upd_object_record($pRecordId, $pObject_id)
{
	$ret = 0;
	if (db_sql_num_rows(ViewSQL('SELECT id FROM object WHERE id = '.sqlValue($pObject_id), 0)) <= 0)
		$ret = -1;

	if ($ret == 0)
	{
		RunSQL('UPDATE object_record SET object_id = '.$pObject_id.', last_update = CURRENT_TIMESTAMP(), user_name = '.sqlValue(session('UserName')).' WHERE id = '.sqlValue($pRecordId), 0);
		$ret = $pRecordId;
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Adds object field
 * @param int $pObject_id id of object, for whitch field must be added
 * @param string $pField_name name of field that must be added
 * @param string $pField_type type of field that must be added
 * @param int $pField_one_for_all: iflag $pField_one_for_all = 1 then the current field one for all languages, if $pField_one_for_all=0 then for each language field is unique.
 * @return int returns field id if success or error id if false
 */
function f_add_object_field($pObject_id, $pField_name, $pField_type, $pField_one_for_all = 0)
{
	$pField_one_for_all = ( ((int)$pField_one_for_all) == 0 ? 0 : 1 );
	$ret = 0;
	if (db_sql_num_rows(ViewSQL('SELECT id FROM object_field WHERE object_id = '.sqlValue($pObject_id).' AND object_field_name='.SQLValue($pField_name).';',0)) > 0)
		$ret = -1;

	if ($ret == 0)
	{
		$ret = RunSQL('INSERT INTO object_field SET object_id = '.$pObject_id.', object_field_name = '.SQLValue($pField_name).', object_field_type = '.SQLValue(strtoupper($pField_type)).', one_for_all_languages = '.SQLValue(strtoupper($pField_one_for_all)).';',0);

		// Insert into object_content-table records for new field
		$sql = '
			SELECT '.$ret.',
				object_record.id,
				\'\',
				v_language.language_code
			  FROM
				object_record,
				v_language
			  WHERE
				object_id='.sqlValue($pObject_id).'
			order by 2
		';

		$sql = 'INSERT INTO object_content (
				object_field_id,
				object_record_id,
				value,
				language) '.$sql;
		RunSQL($sql, 0) ;
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Deletes object field
 * @param int $pId - object field id
 * @return int 1
 */
function f_del_object_field($pId)
{
	RunSQL('DELETE FROM object_field WHERE id = "'.$pId.'";');
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}



/**
 * Deletes object fields
 * @param int $pId - array of object fields id
 * @return int 1
 */
function f_del_object_fields($pId)
{
	RunSQL('DELETE FROM object_field WHERE id in('.sqlValuesList($pId).')');
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

/**
 * Updates object field
 * @param int $pId id of object field whitch must be updated
 * @param int $pObject_id id of object, for whitch field must be updated
 * @param string $pField_name name of field (value to update)
 * @param string $pField_type type of field (value to update)
 * @param int $pField_one_for_all: iflag $pField_one_for_all = 1 then the current field one for all languages, if $pField_one_for_all=0 then for each language field is unique.
 * @return int object field id
 */
function f_upd_object_field($pId, $pObject_id, $pField_name, $pField_type, $pField_one_for_all = 0)
{
	$pField_one_for_all = ( ((int)$pField_one_for_all) == 0 ? 0 : 1 );
	$ret = 0;
	if (db_sql_num_rows(ViewSQL('SELECT id FROM object_field WHERE id != '.sqlValue($pId).' AND object_id = '.sqlValue($pObject_id).' AND object_field_name='.SQLValue($pField_name).';',0)) > 0)
		$ret = -1;

	if ($ret == 0)
	{
		RunSQL('UPDATE object_field SET object_id = '.$pObject_id.', object_field_name = '.SQLValue($pField_name).', object_field_type = '.SQLValue(strtoupper($pField_type)).', one_for_all_languages = '.SQLValue(strtoupper($pField_one_for_all)).' WHERE id = "'.$pId.'";',0);
		$ret = $pId;
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Adds object content
 * @param int $pObject_field_id id of object field, for whitch content must be added
 * @param int $pRecord_id id of object record, for whitch content must be added
 * @param string $pValue data that must be added
 * @param string $pLanguage language for data
 * @return int returns object record id if success or error id if false
 */
function f_add_object_content($pObject_field_id, $pRecord_id, $pValue, $pLanguage)
{
	$ret = 0;

	if (!empty($pObject_field_id) && db_sql_num_rows(ViewSQL('SELECT id FROM object_field WHERE id = "'.$pObject_field_id.'";',0)) <= 0)
	{
		$ret = -1;
	}
	
	if (!empty($pRecord_id) && db_sql_num_rows(ViewSQL('SELECT id FROM object_record WHERE id = "'.$pRecord_id.'";',0)) <= 0)
	{
		$ret = -2;
	}

	if (!empty($pLanguage) && db_sql_num_rows(ViewSQL('SELECT language_code FROM v_language WHERE language_code = "'.$pLanguage.'";',0)) <= 0)
	{
		$ret = -3;
	}

	if (	!empty($pObject_field_id) &&
		!empty($pRecord_id) &&
		!empty($pLanguage) &&
		db_sql_num_rows(ViewSQL('SELECT object_record_id FROM object_content WHERE object_field_id = '.$pObject_field_id.' AND object_record_id = '.$pRecord_id.' AND language = "'.$pLanguage.'";',0)) > 0)
	{
		$ret = -4;
	}

	if ($ret == 0)
	{
		$ret = RunSQL('INSERT INTO object_content SET object_field_id = '.$pObject_field_id.', object_record_id = '.$pRecord_id.', value = '.sqlValue($pValue).', language = '.sqlValue($pLanguage), 1);
		$ret = array($pObject_field_id, $pRecord_id, $pLanguage);
	}
	// clean cache
	delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Deletes object content
 * @param int $pRecord_id - object record id
 * @param int $pObject_field_Id - object field id
 * @param string $language_code - language code
 * @return int 1
 */
function f_del_object_content($pObject_field_Id, $pRecord_id, $language_code)
{
	$sql = 'DELETE FROM
				object_content
			WHERE
				object_field_id='.sqlValue($pObject_field_Id).'
				AND
				object_record_id='.sqlValue($pRecord_id).'
				AND
				language='.sqlValue($language_code);

	runSQL($sql);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

function f_del_object_contents($pObject_field_Id, $pRecord_id, $pLanguages)
{           
	for ($i=0; $i<count($pObject_field_Id); $i++)
	{
		$ar_del_cond[] = '(object_field_id='.sqlValue($pObject_field_Id[$i]).
				' AND '.'object_record_id='.sqlValue($pRecord_id[$i]).
				' AND '.'language='.sqlValue($pLanguages[$i]).')';
	}
	$sql = 'DELETE 	FROM 
				object_content 
			WHERE 
				'.implode("\n OR \n\t",$ar_del_cond);
	RunSQL($sql);
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}
function f_del_object_content_by_record_id($pRecord_id)
{           
	RunSQL('DELETE FROM object_content WHERE object_record_id  in('.sqlValuesList($pRecord_id).');');
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return 1;
}

function f_del_object_contents_and_records($pRecord_id)
{
	f_del_object_records($pRecord_id);
	f_del_object_content_by_record_id($pRecord_id);
}
/**
 * Updates object field
 * @param int $pObject_field_id id of object field, for whitch content must be updated
 * @param int $pRecord_id id of object record, for whitch content must be updated
 * @param string $pValue value to update
 * @param string $pLanguage language for data
 * @return int object content id on success or error id on false
 */
function f_upd_object_content($pObject_field_id, $pRecord_id, $pValue, $pLanguage)
{
	$ret = 0;

	if (!empty($pLanguage) && db_sql_num_rows(ViewSQL('SELECT language_code FROM v_language WHERE language_code = "'.$pLanguage.'";',0)) <= 0)
	{
		$ret = -3;
	}

	if ($ret == 0)
	{
		$sql_where = ' WHERE object_field_id = '.$pObject_field_id.' AND language = "'.$pLanguage.'" AND object_record_id = '.$pRecord_id;

		// if there are still now appropriate content record - let add it
		if (	!empty($pObject_field_id) &&
			!empty($pRecord_id) &&
			db_sql_num_rows(viewsql('SELECT * FROM object_content '.$sql_where, 0))==0)
		{
			f_add_object_content($pObject_field_id, $pRecord_id, $pValue, $pLanguage);
		}
		// otherwise - let modify it
		else if (!empty($pObject_field_id) &&
			 !empty($pRecord_id))
		{
			$ret = RunSQL('UPDATE object_content SET value = '.sqlValue($pValue).' '.$sql_where, 0);
		}
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Adds data for object
 * @param array $field_values data to add
 * @param int $object_id id of object, for whitch data must be added
 * @return int id of record, for whitch data was added on success or error id on false
 */
function f_add_object_modul($field_values, $object_id, $field_val = false)
{
	global $error;

	$language = $field_values['language'];
	unset($field_values['language']);

	$record_id = (int)$field_values['record_id'];
	unset($field_values['record_id']);
              
	if(	isset($field_values['object_unique_name'])
		&&
		!empty($field_values['object_unique_name'])
		&&
		object_unique_name_exists($object_id, $field_values['object_unique_name'], $language, $record_id)
	)
	{
		$error['object_unique_name'] = $error[$language.'__object_unique_name'] = OBJECT_UNIQUE_NAME_EXISTS_ERROR;
		return -1;
	}
        if(object_record_exists($record_id, $field_values, $object_id, $field_val))
	{
		return -1;
	}
	if ($record_id == 0)
	{
		$ret = f_add_object_record($object_id);
	}
	else
	{
		$ret = $record_id;
	}
	if ($ret > 0)
	{                 
		foreach ($field_values as $k=>$val)
		{
			$res = f_add_object_content(Get_object_field_id_by_name($k, $object_id), $ret, $val, $language);
		}

		if ($res < 0)
		{
			$ret = f_del_object_record($ret);
			$ret = $res;
		}
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}


// функция для добавления пустых записей для объектов.
function f_add_object_empty_modul($object_id, $number = 1)
{

	$lang_list = SQLField2Array(viewsql('SELECT language_code FROM v_language WHERE status=1', 0));

	for($i = 0; $i< $number; $i++)
	{
		$ret = f_add_object_record($object_id);
                if ($ret > 0)
		{
			// получаем все поля объекта
			$fields = Get_fields_by_object_id($object_id);
			// забиваем значения полей пустыми записями
			for($j = 0; $j < count($fields); $j++)
			{
				$field_values[$fields[$j]]  = '';
			}

			foreach($lang_list as $language)
			{
				foreach ($field_values as $k=>$val)
				{
					$res = f_add_object_content(Get_object_field_id_by_name($k, $object_id), $ret, $val, $language);
				}
			
				if ($res < 0)
				{
					$ret = f_del_object_record($ret);
					$ret = $res;
				}
			}      	
		}
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}


/**
 * Deletes data for object
 * Call to f_del_object_record. With deleting record, all data will be deleted
 * @param int $pRecord_id id of record, for whitch data must be deleted
 * @return int 1
 */
function f_del_object_modul($pRecord_id)
{
	f_del_object_record($pRecord_id);
	return 1;
}


/**
 * Deletes data for objects
 * Call to f_del_object_record. With deleting record, all data will be deleted
 * @param int $pRecord_id array of ids of records, for whitch data must be deleted
 * @return int 1
 */
function f_del_object_moduls($pRecord_id)
{
	f_del_object_records($pRecord_id);
	return 1;
}


/**
 * Updates data for object
 * @param array $field_values data to update
 * @param int $object_id id of object, for whitch data must be updeted
 * @return int id of record, for whitch data was added on success or error id on false
 */
function f_upd_object_modul($field_values, $object_id, $field_val = false)
{
	global $error;

	$language = ( array_key_exists('language', $field_values) ? $field_values['language'] : 0 );
	unset($field_values['language']);

	$record_id = ( array_key_exists('record_id', $field_values) ? (int)$field_values['record_id'] : 0 );
	unset($field_values['record_id']);

	$id = ( array_key_exists('id', $field_values) ? (int)$field_values['id'] : 0 );
	unset($field_values['id']);

	$ret = $record_id;

	if (object_record_exists($record_id, $field_values, $object_id, $field_val))
	{
		return -1;
	}
	
	if(	isset($field_values['object_unique_name'])
		&&
		!empty($field_values['object_unique_name'])
		&& 
		object_unique_name_exists($object_id, $field_values['object_unique_name'], $language, $record_id))
	{
		$error['object_unique_name'] = $error[$language.'__object_unique_name'] = OBJECT_UNIQUE_NAME_EXISTS_ERROR;
		return -1;

	}

	foreach ($field_values as $k=>$val)
	{                                                                                              
		$res = f_upd_object_content(Get_object_field_id_by_name($k, $object_id), $ret, $val, $language);
	}

	if ($res < 0)
	{
		$ret = $res;
	}
	else
	{
		$ret = $id;
	}
	// delete sitemap.xml cache
	delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);

	return $ret;
}

/**
 * Checks if mentioned object_unique_name already exists
 * @param string $object_unique_name data to check
 * @param int $object_id id of object, for which data must be checked
 * @param int $record_id id of updated record (==0 if new one)
 * @param string $language language
 * @return bool TRUE if exists, FALSE if not exists
 */
function object_unique_name_exists($object_id, $object_unique_name, $language, $record_id = false)
{
	if($record_id != false)
	{
		$sql_where = ' AND object_record_id <> '.$record_id ;
	}

	$sql =
		"SELECT 
			count(*)
		   FROM 
			object_content 
		  WHERE 
			object_field_id = 
				(
					SELECT 
						id 
					  FROM 
						object_field 
					 WHERE 
						object_field_name = 'object_unique_name' 
					   AND 
						object_id =  '$object_id'
				) 
		    AND 
			value='$object_unique_name'
		    AND
			language = '$language'".$sql_where;			
		
 
		$is_object_unique_name_exists = (bool) getField($sql);

		return $is_object_unique_name_exists;
}

/**
 * Checks if mentioned $object_id record with $field_values data already exists
 * and checks if such object unique name exists
 * @param int $record_id id of updated record (==0 if new one)
 * @param array $field_values data to check
 * @param int $object_id id of object, for which data must be checked
 * @return bool TRUE if record exists, FALSE if not exists
 */
function object_record_exists($record_id, $ar_field_values, $object_id, $field_val_all_lang = false, $lang = null)
{
	global $langEncode;
	global $non_stat_fields;
	global $lang_depend_fields;
	
	if (is_null($lang))
	{
		$lang = $GLOBALS['language'];
	}

//
	if ($field_val_all_lang == false)
	{
		$ar_languages = array($lang);
	}
	else
	{
		$ar_languages = get_language_array();
	}

	$sql_fields = '	SELECT 
				id,
				object_field_name,
				one_for_all_languages
			FROM 
				object_field
			WHERE 
				object_id=' . sqlValue($object_id);

	$ar_fields_list = array_keys($ar_field_values);

	array_walk($ar_fields_list, create_function('&$a', '$a = explode(\' \', trim($a)); $a = trim($a[0]);'));
	$sql_fields .= 'AND
				object_field_name IN (\''.implode('\', \'', $ar_fields_list).'\') 
			ORDER BY id';

	$rs = viewsql($sql_fields, 0);

	while($r = db_sql_fetch_assoc($rs))
	{
		$ar_field_names[$r["id"]] = array($r["object_field_name"], $r['one_for_all_languages']);
	}

	$ar_sql = array();
	$ar_sql[] = "\r\n".' SELECT '."\r\n".'        r.id AS \'record_id\'';
	$ar_where[] = '        r.object_id='.sqlValue($object_id);

	//для каждого поля начиная выбираем из object_content то, что нам необходимо
	foreach($ar_field_names as $k=>$v)
	{
		foreach($ar_languages as $key_lang)
		{
			$field_name_for_sql = $v[0] . ($field_val_all_lang===true && $v[1]==0 ? '_'.$key_lang : '' );

			if (array_key_exists($v[0], $ar_field_values) && $ar_field_values[$v[0]] != '')
			{
				$ar_where[] = 'r.id IN (SELECT 
								object_record_id
							FROM
								object_content
							WHERE
								object_field_id = ' . sqlValue($k) . '
								AND
								language=' . sqlValue($key_lang) . '
								AND
								value = ' . sqlValue($ar_field_values[$v[0]]) . ')';

			}
			if ($v[1]==1)
			{
				break;
			}
		}
	}
	
	if ($all_languages==false)
	{
		$ar_sql[] = '        '.sqlValue($lang).' AS language';
	}
	$sql_from = (implode(','."\r\n", $ar_sql))."\r\n".
	'   FROM'."\r\n".
	'        object_record r'."\r\n".
	'   WHERE'."\r\n".
	(implode("\r\n".'   AND '."\r\n", $ar_where))." AND '%1\$s' != '%2\$s'";

//	$sql = 'SELECT record_id FROM ('.$sql_from.') AS v WHERE '.implode(' and ', $ar_where);
	$existed_record_id = getfield($sql_from.(!empty($record_id) ? ' AND r.id <> '.sqlValue($record_id) : ''));

	// ... don't add new one with the same values
	global $error;

	// if there is ANOTHER record with the same values (with ANOTHER record_id)
	if ($existed_record_id > 0)
	{
		$error['record_id'] = 'The record with such values already exists (id = '.$existed_record_id.')';
		$result =  true;
	}
	elseif (is_resource($res_object_unique_names) && db_sql_num_rows($res_object_unique_names))
	{
		foreach($arr_err_langs as $val)
		{
			$error[$val.'__object_unique_name'] = 'Such object unique name exists';
		}

		$result = true;
	}
	else
	{
		$result = false;
	}
	return $result;
}

function f_del_all_object_records($object_id)
{
	$r = viewSQL('SELECT id FROM object_record WHERE object_id='.sqlValue($object_id));
	while($row = db_sql_fetch_array($r))
	{
		
		$del_arr[] = $row['id'];	
	}
	//vdump($del_arr, '$del_arr');
	f_del_object_contents_and_records($del_arr);
}



