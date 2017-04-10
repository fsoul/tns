<?

function process_survey($poll_id, $survey_form_template, $survey_result_template)
{
	$res = '';

	$poll_id = cms($poll_id);
	$object_id = Get_object_id_by_name('survey');

	//Get active question id
	$sql = 'SELECT
			q.record_id,
			q.question,
			q.hide_results,
			q.text_instead_hidden_results

		FROM ('.create_sql_view_by_name_for_fields('question, hide_results, text_instead_hidden_results, active', 'question').') q
		WHERE
			q.record_id = '.sqlValue($poll_id).'
			AND
			q.active = \'1\'
		LIMIT 0,1
	';
	$sql_res = viewSQL($sql);

	$question_res	= db_sql_fetch_assoc($sql_res);
	$question_id	= isset($question_res['record_id']) ? $question_res['record_id'] : 0;

	global $question_text;
	$question_text	= isset($question_res['question']) ? $question_res['question'] : '';

	if ($question_id!=0)
	{
		// Check if answer correspond to question
                $is_corresponded =  getField('

                SELECT
                       answer.record_id
                  FROM
                       ('.create_sql_view_by_name_for_fields('question_id', 'answer').') answer
                 WHERE
                       answer.record_id='.sqlValue(intval(post('PollAnswer'))).'
                   AND answer.question_id='.sqlValue($question_id).'

                 LIMIT 0, 1

		') ? true : false;

	
		// Get IP. Check if it is in DB
		$user_ip = USER_IP;


		$sql = '

                SELECT
                       record_id
                  FROM
                       ('.create_sql_view_for_fields('ip, question_id', $object_id).') survey
                 WHERE
                       survey.ip = '.sqlValue($user_ip).'
                   AND survey.question_id = '.sqlValue($question_id).' 

                 LIMIT 0, 1

		';
		$sql_res = viewSQL($sql, 0);

		$survey = db_sql_fetch_assoc($sql_res);

		// - if current IP not exists and post from survey is empty 
		//		or answer does not correspond to question
		//		then it's necessary to generate form for answer possibility
		if ((!isset($survey['record_id']) && post('action')!='answer_for_survey')
			|| (post('action')=='answer_for_survey' && $is_corresponded==false)
		)
		{
			$sql = 'SELECT record_id, answer
				FROM ('.create_sql_view_by_name_for_fields('answer, question_id', 'answer').') answer
				WHERE answer.question_id = '.sqlValue($question_id);

			$res = parse_sql_to_html($sql, $survey_form_template);
		}

		// - if such IP is not exist but $_POST comes, then it's necessary to save this answer
		if(!isset($survey['record_id']) && post('action')=='answer_for_survey')
		{
			global $language;
			//Save answer just in that case if such ANSWER exist in current QUESTION
			if($is_corresponded==true)
			{
				$lang_list = SQLField2Array(viewsql('SELECT language_code FROM v_language WHERE status=1', 0));

				$saving_answer_record_id=0;
				foreach($lang_list as $next_lang)
				{
					$answer_array = array(
						'record_id'		=>	$saving_answer_record_id,
						'question_id'		=>	$question_id,
						'answer_id'		=>	intval(post('PollAnswer')),
						'date'			=>	date('Y-m-d H:i:s (T)'),
						'ip'			=>	$user_ip,
						'answer_language'	=>	$language,
						'user_id'		=>	(isset($_SESSION['UserId']) ? $_SESSION['UserId'] : ''),
						'language'		=>	$next_lang
						);
				

					if($saving_answer_record_id == 0)
					{				
						$saving_answer_record_id = f_add_object_modul($answer_array, $object_id);
					}
					else
					{				
						f_upd_object_modul($answer_array, $object_id);
					}

					$is_record_exist=true;
				}
			}
		}

		// - if $_POST is not empty OR if such IP exists
		//		AND answer corresponding to question
		//		then print survey results
		if(isset($survey['record_id'])
			|| (post('action')=='answer_for_survey' && $is_corresponded==true)
		)
		{
			if (!$question_res['hide_results'])
			{// output results of survey
				//get general amount of answers
				global $answers_amount;
				$answers_amount = count_survey_answers($question_id);
				$sql = create_survey_result_sql($question_id, $answers_amount);
				$res = parse_sql_to_html($sql, $survey_result_template);
			}
			else
			{// output text instead hidden results of survey
				$res = $question_res['text_instead_hidden_results'];
			}
		}
	}

	return $res;
}

function get_all_survey_results()
{
	$res = '';
	$sql = 'SELECT	*
		FROM	('.create_sql_view_by_name('question').') question
		WHERE question.active = "1"';

	$res = parse_sql_to_html($sql, 'survey_all_results_row');

	return $res;
}

function get_all_survey_results_answers($question_id)
{
	$res = '';
	$sql = create_survey_result_sql($question_id);
	$res = parse_sql_to_html($sql, 'survey_all_results_answers_row');
	return $res;
}


function count_survey_answers($question_id)
{
	//get general amount of answers
	$sql = 'SELECT count(*) AS answers_amount
		FROM ('.create_sql_view_by_name_for_fields('question_id', 'survey').') survey
		WHERE survey.question_id = '.sqlValue($question_id);
	$sql_res = viewSQL($sql);
	$answers_amount_res = db_sql_fetch_assoc($sql_res);
	$answers_amount = isset($answers_amount_res['answers_amount']) ? intval($answers_amount_res['answers_amount']) : 0 ;

	return $answers_amount;	
}

function create_survey_result_sql($question_id, $answers_amount='')
{
	if($answers_amount === '')
	{
		$answers_amount = count_survey_answers($question_id);
	}	

	$sql = 'SELECT
			answer.answer answer_text,
			answer.record_id,
			'.($answers_amount!=0 ? '(100*poll.voice_amount/'.$answers_amount.')' : '0').' AS answer_persent

		FROM
			('.create_sql_view_by_name_for_fields('answer, question_id', 'answer').') answer
			LEFT JOIN				
			(
				SELECT	survey.answer_id answer_id, count(survey.answer_id) voice_amount
				FROM	('.create_sql_view_by_name_for_fields('answer_id, question_id', 'survey').') survey
				WHERE	survey.question_id='.sqlValue($question_id).'
				GROUP BY survey.answer_id
			) poll
			ON answer.record_id=poll.answer_id 

		WHERE
			answer.question_id = '.sqlValue($question_id);

	return $sql;
}


