
function setBirthDate()
{
	var birth_date_ = document.getElementById('birth_date_');

	var birth_date_d = document.getElementById('birth_date_d');
	var birth_date_m = document.getElementById('birth_date_m');
	var birth_date_y = document.getElementById('birth_date_y');

	birth_date_.value = birth_date_d.value + '.' + birth_date_m.value + '.' + birth_date_y.value;
}


function setHidden()
{
    return;
	var ar_fields = new Array();

	ar_fields[0] = 'region';
	ar_fields[1] = 'city';
	//ar_fields[2] = 'settlement';
	//ar_fields[3] = 'street';

	var i;
//	var f_hidden;
	var f_other;

	for (i = 0; i < ar_fields.length; i++)
	{
//		f_hidden = document.getElementById(ar_fields[i] + '_'); 
		f_selector = document.getElementById('selector_' + ar_fields[i]);
		f_other = document.getElementById('input_' + ar_fields[i] + '_other');

		if (f_other.style.display == '')
		{
			f_selector.value = option_value_other;
//			f_hidden.value = f_other.value; 
		}
		else if (f_selector.value>0)
		{
//			f_hidden.value = f_selector.value;
		}
		else
		{
//			f_hidden.value = ''; 
		}
	}
}

$(function(){
	$('#registration_form').on('submit',function(){
		console.log('reg');
		if($('#tns_id').val() == '') $('#tns_id').val(window["IDCore"].getId());
	});
});
