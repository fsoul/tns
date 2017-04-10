<script type="text/javascript">

function display_hidden_fields(cur_id){
    return;
	var hidden_fields = document.getElementById('respondent_edit_form2');

	if (hidden_fields.style.display == 'none'){

		if (
			(document.getElementById('last_name_').value != '' || 'last_name_' == cur_id) &&
			(document.getElementById('first_name_').value != '' || 'first_name_' == cur_id) &&

			(document.getElementById('radioSexMale').checked
			 ||
			 document.getElementById('radioSexFemale').checked
			) &&

			document.getElementById('selector_district_id').value != '<%:OPTION_VALUE_DEFAULT%>' &&
			document.getElementById('selector_region').value != '<%:OPTION_VALUE_DEFAULT%>' &&
			document.getElementById('selector_city').value != '<%:OPTION_VALUE_DEFAULT%>' &&
			document.getElementById('selector_settlement').value != '<%:OPTION_VALUE_DEFAULT%>' &&
			document.getElementById('selector_street').value != '<%:OPTION_VALUE_DEFAULT%>' &&

			document.getElementById('birth_date_d').value != '' &&
			document.getElementById('birth_date_m').value != '' &&
			document.getElementById('birth_date_y').value != '' &&

			(document.getElementById('house_').value != '' || 'house_' == cur_id) &&
			(document.getElementById('flat_').value != '' || 'flat_' == cur_id)
		){
			hidden_fields.style.display = '';
			document.getElementById('register_form_submit_link').style.display = '';
		}
	}
}

</script>
