<div class="content_large">

<style type="text/css">
<!--
.hide {
	display: none;
	visibility: hidden;
}
.form_config_table {
	font: 12px Tahoma, Arial, Verdana, Helvetica, sans-serif;
	margin: 0 auto;
	text-align: left;
}
.save_button {
	border: 1px solid #386CA1;
	font-size: 12px;
	color: #fff;
	background-color: #3F7B99;
	font-weight: normal;
}
.form_content TABLE {
	margin: 0pt auto;
	text-align: left;
}
/*.form_table TD {
	width: 200px;
}*/
.form_div{
	text-align: center;
	color: red;
}
-->
</style>
<script type="text/javascript">
//<!--
function show_field(id){
	if(navigator.appName=='Microsoft Internet Explorer'){document.getElementById(id).style.display='block';}
	else{document.getElementById(id).style.display='table-row';}
	document.getElementById(id).style.visibility='visible';
}
function hide_field(id){
	document.getElementById(id).style.display='none';
	document.getElementById(id).style.visibility='hidden';
}
function show_fields(cb_id,id_1,id_2,id_3){
	if(document.getElementById(cb_id).checked){
		show_field(id_1);
		show_field(id_2);
		show_field(id_3);
	}else{
		hide_field(id_1);
		hide_field(id_2);
		hide_field(id_3);
	}
}
var captchaCorrect = false;
function validForm(){
	var showEmail = '<%page_cms:form_builder_display_email_%>';
		if(showEmail == '1' && !/^[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]{2,6}$/i.test(document.getElementById('email').value)){
		show_field('form_error');
		return false;
	}
	if(<%page_cms:form_builder_form_disp_captcha_%>){
		var response = document.getElementById('recaptcha_response_field').value;
		var challenge = document.getElementById('recaptcha_challenge_field').value;
		ajax_check_url('<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>action.php?action=ajax_check_captcha&t=<%:t%>&admin_template=yes&response='+response+'&challenge='+challenge);
		if(captchaCorrect){
			return true;
		}
		return false;
	}
	return true;
}

var xmlHttp;

// creates an XMLHttpRequest instance
function createXmlHttpRequestObject() 
{
	// will store the reference to the XMLHttpRequest object
	var _xmlHttp;
	// this should work for all browsers except IE6 and older
	try
	{
		// try to create XMLHttpRequest object
		_xmlHttp = new XMLHttpRequest();
	}
	catch(e)
	{
		// assume IE6 or older
		var XmlHttpVersions = new Array("MSXML2.XMLHTTP.6.0",
						"MSXML2.XMLHTTP.5.0",
						"MSXML2.XMLHTTP.4.0",
						"MSXML2.XMLHTTP.3.0",
						"MSXML2.XMLHTTP",
						"Microsoft.XMLHTTP");
		// try every prog id until one works
		for (var i=0; i<XmlHttpVersions.length && !_xmlHttp; i++) 
		{
			try 
			{ 
				// try to create XMLHttpRequest object
				xmlHttp = new ActiveXObject(XmlHttpVersions[i]);
			} 
			catch (e) {}
		}
	}
	// return the created object or display an error message
	if (!_xmlHttp)
	{
	//	alert("Error creating the XMLHttpRequest object.");
	}
	else 
		return _xmlHttp;
}

// read a file from the server
function ajax_check_url(URL)
{
	// holds an instance of XMLHttpRequest
	xmlHttp = createXmlHttpRequestObject();
	// only continue if xmlHttp isn't void
	if (xmlHttp)
	{
		// try to connect to the server
		try
		{
			// initiate the asynchronous HTTP request
			//xmlHttp.onreadystatechange = ajax_show_result;
			xmlHttp.open("GET", URL, false);
			xmlHttp.send(null);
			ajax_show_result();
		}
		// display the error in case of failure
		catch (e)
		{
		//	alert("Can't connect to server:\n" + e.toString());
		}
	}
}

// function called when the state of the HTTP request changes
function ajax_show_result() 
{
	
	// when readyState is 4, we are ready to read the server response
	if (xmlHttp.readyState == 4) 
	{
		// continue only if HTTP status is "OK"
		if (xmlHttp.status == 200) 
		{
			try
			{
				// Print into DIV that we get
				if(xmlHttp.responseText == '1'){
					captchaCorrect = true;
				}else{
					document.getElementById('captcha_error').innerHTML = '<%cms:form_builder_captcha_error_%>';
					Recaptcha.reload();
				}
				
			}
			catch(e)
			{
				// display error message
			//	alert("Error reading the response: " + e.toString());
			}
		} 
		else
		{
			// display status message
		//	alert("There was a problem retrieving the data:\n" + 
		//				xmlHttp.statusText);
		}
	}
	
}
//-->
</script>
<%include:<%iif:<%:form_builder_hide_config%>,,<%iif:<%:admin_template%>,yes,form_builder/form_config%>%>%>
<%iif:<%session:form_builder_is_form_submitted%>,-1,<div class="form_div">Can't send email</div>%>
<%iif:<%session:form_builder_is_form_submitted%>,-2,<div class="form_div">Can't insert info to database</div>%>
<%include:<%iif:<%session:form_builder_is_form_submitted%>,<%:t%>,form_builder/form_thanks,form_builder/form_content%>%>
<%setGlobalValueOf:session,form_builder_is_form_submitted,0%>
</div>
