    </table>
    </form>
</td>
</tr>

<tr><td align="center" valign="middle">
   <table>
     <tr>
       <td><a href="http://www.2kgroup.com/Products/engineExpress.en.html" target="_blank"><img src="<%:EE_HTTP%>img/ee_logo.gif"  alt="Get more info about engineExpress" border="0"></a>
       </td>
       <td>
Powered by <a href="http://www.2kgroup.com/Products/engineExpress.en.html" target="_blank">engineExpress</a><br>
Developed by <a href="http://www.2kgroup.com" target="_blank">2K-Group</a><br>
Managed by <a href="<%:MANAGED_BY_URL%>" target="_blank"><%:MANAGED_BY_NAME%></a><br>
Help / Feedback: <a target="_blank" href="mailto:<%:SUPPORT_CONTACTS_EMAIL%>"><%:SUPPORT_CONTACTS_EMAIL%></a>
       </td>
     </tr>
   </table>
</td>
<tr>
</tr>
</table>
	<script language="JavaScript">if (document.form1.login) document.form1.login.focus()</script>
	<script type="text/JavaScript" src="<%:EE_HTTP%>js/ajax-son.js"></script>
	<script type="text/JavaScript">

		var AdminLoginError = "Incorrect login or password";

		var ajaxActionFile = '<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>action.php';

		var loadingStatus  = false;

		var reqNumber	= 1;

		String.prototype.trim = function()
		{
			var str = this;

			str = str.replace(/(^\s+)|(\s+$)/g, "");

			return str;
		}

		function admin_login()
		{
			var error 	= false;
			var login 	= document.getElementById('login').value;
			var password	= document.getElementById('pass').value;

			var err_el 	= document.getElementById('error');          
			var ajax	= new ajax_son(ajaxActionFile);

			err_el.innerHTML 		= '';

			if (	login.trim() == '' ||
				password.trim() == '')
			{
				err_el.innerHTML	= AdminLoginError;
				error = true;
			}
       		
			if (!error)
			{
				var reqString = 'action=admin_section_login' + 
						'&login=' + login + 
						'&password=' + password;

				ajax.onComplete = function()
				{
					var response = ajax.response;
       	
					switch(response)
					{
						case 'NOT_AUTH':
							document.getElementById('pass').value = '';
							err_el.innerHTML		= AdminLoginError;
							break;
       	
						case 'RESET_PASSWORD':
							location.replace('<%:EE_HTTP%><%:EE_ADMIN_SECTION_IN_HTACCESS%>_user.php?op=change_reset_pass&user=' + login);
							break;
       	
						case 'CHANGE_PASSWORD':
							location.replace('<%:EE_HTTP%><%:EE_ADMIN_SECTION_IN_HTACCESS%>_user.php?op=change_reset_pass&user=' + login + '&new_conditions=yes');
							break;
       					
						case 'OK':
							load_modules();
							break;
					}
				}
				ajax.onError = function()
				{
					alert(ajax.response);
				}
				ajax.onFail = function()
				{
					alert(ajax.response);
				}

				ajax.run(reqString);
			}
	       	
			return false;
		}       	
	       	
		function load_modules()
		{      	
			var ajaxModules	   	= new ajax_son(ajaxActionFile);
	       	
			var reqString = 'action=load_modules';
			var timer = false;
       	
			timer = setInterval(function(){check_modul_loading();}, 1000);
			document.getElementById('admin_login_shadow_box').style.display = 'block';
			document.getElementById('admin_login_popup').style.display = 'block';
       	
			ajaxModules.onComplete = function()
			{
				clearInterval(timer);
				document.getElementById('progressBar').style.width 	= parseInt(document.getElementById('statusBar').style.width);
				document.getElementById('progress').innerHTML 		= '100% (done)';
				location.replace('<%:EE_HTTP%>?admin_template=yes');
			}
			ajaxModules.run(reqString);
		}

		function check_modul_loading()
		{
			var ajaxCheckLoading	= new ajax_son(ajaxActionFile);
       	
			ajaxCheckLoading.asynchronous = false;
			
			var reqString = 'action=check_modul_loading';
	       	
			ajaxCheckLoading.onComplete = function()
			{
				eval('result = ' + ajaxCheckLoading.response);
	       	
				if (result.count_current_modules == 1)
				{
					var load_percent= (reqNumber <= 2 ? 1 : 100);
					var progress 	= (reqNumber <= 2 ? 1 : document.getElementById('statusBar').style.width);
				}
				else
				{
					var load_percent= parseInt((result.count_current_modules / result.count_all_modules) * 100);
					var progress 	= parseInt(document.getElementById('statusBar').style.width) * (result.count_current_modules / result.count_all_modules);
				}
       	
				document.getElementById('progressBar').style.width 	= parseInt(progress);
				document.getElementById('progress').innerHTML 		= load_percent + '%&nbsp;(&nbsp;'+result.current_modul_name+'&nbsp;)';
				document.title						= load_percent + '% loading...';
			}
       	
			ajaxCheckLoading.run(reqString);
			reqNumber++;
		}
       	
	</script>
</body>	
</html>