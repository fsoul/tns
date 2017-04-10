<script type="text/javascript" language="JavaScript">

option_value_other = '<%:OPTION_VALUE_OTHER%>';

function displayOther(this_)
{
	if (this_.style.background != '')
	{
		this_.style.background = '';
	}

	var input_other = document.getElementById('input_' + this_.name + 'other');
	console.log(input_other);
	if (input_other)
	{
		if (this_.value=='<%:OPTION_VALUE_OTHER%>')
		{
			input_other.style.display = "";
		}
		else
		{
			input_other.style.display = "none";
		}
	}

}

function getOptions(p_dictionary, this_)
{
	p_filter_id = this_.value;

	displayOther(this_);

	if (	p_filter_id != '<%:OPTION_VALUE_DEFAULT%>' && 
		p_filter_id != '<%:OPTION_VALUE_OTHER%>'
	) // some real object is selected, no dictionary title ("City", "Street") neither "Other"-option
	{
		document.body.style.cursor = "wait"; 
	}

	var xmlhttp = getXmlHttp();
	var url = '<%:EE_HTTP%>action.php?action=ap_select_options' + '&' + 'dictionary=' + p_dictionary + '&' + 'filter_id=' + p_filter_id + '&' + 'language=<%:language%>';
//prompt(url, '<%:EE_HTTP_SERVER%>'+url);
	xmlhttp.open('GET', url, true);

	xmlhttp.onreadystatechange = function()
	{
		if (xmlhttp.readyState == 4)
		{
			if (xmlhttp.status == 200)
			{
				var selector_ = document.getElementById('selector_' + p_dictionary);

				setOptions(selector_, xmlhttp.responseXML.documentElement);

				document.body.style.cursor = "default"; 
			}
		}
	};

	xmlhttp.send(null);
}

function setOptions(p_selector, p_xml)
{
	var options = p_xml.getElementsByTagName("option");
	var refresh_next = false;

	p_selector.options.length = 0; // Clear current options list

	for(i = 0; i < options.length; i++)
	{
		var option = document.createElement("option");
		var optionText = document.createTextNode(options[i].firstChild.data);

		option.appendChild(optionText);
		option.setAttribute("value", options[i].getAttribute("value"));

		if (options[i].getAttribute("selected"))
		{
			option.setAttribute("selected", "selected");
			refresh_next = true;
		}

		p_selector.appendChild(option);
	}

//	if (refresh_next)
	{
		p_selector.onchange();
	}
$(p_selector).trigger("chosen:updated");
	displayOther(p_selector);
}

$(function(){
	displayOther(document.getElementById('selector_street'));
});
/*
 $(function(){
 var opt = {
        no_results_text: "�����!",
        inherit_select_classes: true
    };
    $('#selector_district_id').chosen(opt);
    $('#selector_region').chosen(opt);
    $('#selector_city').chosen(opt);
})*/
</script>

