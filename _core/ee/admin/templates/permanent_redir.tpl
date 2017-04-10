

	function check_source_url()
	{
		var obj = new ajax_son("_permanent_redirect.php");

		var source_url_error = document.getElementById('source_url_errors');
		
		obj.onComplete = function()
		{
			if(obj.response == -1)
			{
				source_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Source URL could not be empty';
				errors = 1;
			}
			else if(obj.response == -2 && i_edit == '')
			{
				source_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Warning: such URL already configered for another page. Please setup another URL.';
				errors = 1;
			}
			else if(obj.response == -3)
			{
				source_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Source URL could not be applied for existed page';
				errors = 1;
			}
			else if(obj.response == -4)	
			{
				source_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Incorrect Source URL. Please enter Source URL as example. Example: pagename_language.html';					error = 1;
			}
			else if(obj.response)
			{
				source_url_error.innerHTML = '';
				errors = 0;
			}
			//alert(obj.response + '-' + i_edit);
		}
		obj.run("op=check_source_url&source_url="+document.getElementById('source_url').value);
	}

	function change_target_url(target_url_mode)
	{
		var target_url = document.getElementById('target_url');
		var params = '';
		
		if(target_url_mode == 'url')
		{
			target_url.innerHTML = document.getElementById('url').value;

			var href = document.getElementById('url').value;
			if (href.indexOf("http://") == -1 || href.indexOf("<%:EE_HTTP%>")) {
				href = '<%:EE_HTTP%>' + href;
			}
			document.getElementById('target_url_link').href = href;
		}
		else if(target_url_mode == 'target_url')
		{
			var obj = new ajax_son("_permanent_redirect.php");
			obj.onComplete = function()
			{
				target_url.innerHTML = obj.response;
				if(obj.response.indexOf("http://") == 0 || obj.response.indexOf("https://") == 0)
				{
					document.getElementById('target_url_link').href = obj.response;
				}
				else
				{
					document.getElementById('target_url_link').href = "<%:EE_HTTP%>" + obj.response;
				}
			}
			obj.run("op=get_target_url&page=" + document.getElementById('satelit').value + "&language=" + document.getElementById('lang_code').value + "&view=" + document.getElementById('tpl_view').value);
		}
		else
		{
			return;
		}
	}
