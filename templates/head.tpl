<!DOCTYPE html>
<html>
  <head>
<%print_page_commentary%>
     <title><%get_page_title%></title>
<%print_page_meta_tags%>
     <meta http-equiv="Content-Language" content="<%getValueOf:language%>" />
     <meta http-equiv="Content-Type" content="text/html; charset=<%getCharset%>" />
      <meta name="viewport" content="width=device-width" />
<%iif::is_plugin_page,1,<link rel="chrome-webstore-item" href="https://chrome.google.com/webstore/detail/haikmmmjkcejaalkjbfobneapigfmldp">%>

<%iif::dns_draft_status,1,
     <meta name="content" content="draft">
%>

     <link rel="shortcut icon" href="<%:EE_HTTP%>favicon.ico" type="image/x-icon" />

     <link href="<%:EE_HTTP%>css/normalise.css" rel="stylesheet" type="text/css" />
     <link href="<%:EE_HTTP%>css/fonts.css" rel="stylesheet" type="text/css" />
     <link href="<%:EE_HTTP%>css/984_12_15_15.css" rel="stylesheet" type="text/css" />
     <link href="<%:EE_HTTP%>css/global.css" rel="stylesheet" type="text/css" />
     <link href="<%:EE_HTTP%>css/style.css" rel="stylesheet" type="text/css" />
     <!--[if IE]>  <link href="<%:EE_HTTP%>css/ie.css"  rel="stylesheet" type="text/css" /><![endif]-->
     <!--[if IE 6]><link href="<%:EE_HTTP%>css/ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
     <!--[if IE 7]><link href="<%:EE_HTTP%>css/ie7.css" rel="stylesheet" type="text/css" /><![endif]-->
     <!--[if IE 6]>
          <script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/DD_belatedPNG.js"></script>
          <script type="text/javascript" language="JavaScript">
              DD_belatedPNG.fix('.transparent');
          </script>
     <![endif]-->
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
      <script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/jquery.maskedinput.min.js"></script>
      <script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/chosen.jquery.min.js"></script>
      <script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/download.min.js"></script>
	 <script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/common.js"></script>
    <link href="<%:EE_HTTP%>css/chosen.css" rel="stylesheet" type="text/css" />

     <%iif::admin_template,yes,<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />%>

<%print_admin_js:1,0%>

<script type="text/javascript" language="JavaScript">
var cMeterScope = (function (){
    // TODO: setListeners

    var respondentID = '<%ap_get_respondent_id%>';
    window.postMessage({respondent_id: respondentID}, '*');

    window.addEventListener('message', function (event) {

		console.log('got a message');
        if (event.data && event.data.hasOwnProperty('command')) {
            if (event.data.command == "showLogin") {
				$(document).ready(function () {
					console.log('opros should show login form with custom text');
					console.log(newText);
					var newText = document.getElementById('new_plugin_auth_form');
					if (newText && document.getElementById('page_comment')) {
						document.getElementById('page_comment').innerHTML = newText.innerHTML;
					}
				});

            }
            if (event.data.command == "get_respondent_id") {
				event.target.postMessage({respondent_id: respondentID}, '*');
			}
        }
    });
    return {
        id: respondentID
    }

})();
var popup_ajax_in_work = 0;

function hide_popup(){
    document.body.style.overflowY='auto';
    document.body.removeChild(document.getElementById('popup_body'));
    document.body.removeChild(document.getElementById('popup_overlay'));
    return false;
}

function get_radio_val( ed ){
    for(var i = 0; i < ed.length; i++) {
        if( ed[i].checked ) {
            return ed[i].value;
        }
    }
    return false;
}

function validate_popup( f, btn ){
    if( /*get_radio_val( f["placement"] ) !== false &&*/
            get_radio_val( f["using_machine"] ) !== false /*&&
            get_radio_val( f["dev_count"] ) !== false*/
            ){
        if( btn ){
            btn.disabled = 0;
        }
        return true;
    } else {
        if( btn ){
            btn.disabled = 1;
        }
        return false;
    }
}

function submit_popup( form, cookie, mode ){
    if( popup_ajax_in_work == 0 ){
        try{
            var f_url = '<%:EE_HTTP%>action.php?action=save_popup&cookie=' + cookie;
            popup_ajax_in_work = 1;
            if( mode == 1 ){
                ajax_get_json( f_url + '&using_machine=0', function(resp){
                    hide_popup();
                    popup_ajax_in_work = 0;
                });
            } else {
                var um = get_radio_val( form["using_machine"] );
                if(um !== false ){
                    ajax_get_json( f_url + '&using_machine=' + um, function(resp){
                        hide_popup();
                        popup_ajax_in_work = 0;
                    });
                }
            }
        } catch(E) {
            popup_ajax_in_work = 0;
        }
    }
}
function submit_popup1( cookie){
    location.href = '<%:EE_HTTP%>action.php?action=save_popup1&cookie=' + cookie + '&type=1';
}

function submit_popup5( cookie){
    ajax_get_json('<%:EE_HTTP%>action.php?action=save_popup1&cookie=' + cookie + '&type=5', function(){ });
    hide_popup();
}

function try_show_popup(ap_id, cookie, plid){
    var platform = "<%ap_get_browser_for_plugin%>";
    if(platform == 'Mobile' || platform == 'Android' || platform == 'unknown_os'){
        console.log('popup blocked by OS type');
        return;
    }
    if(window["in_cppage"] != 1) return;
    if( navigator.userAgent.search('Windo') == -1 && navigator.userAgent.search('Linux') == -1
            && navigator.userAgent.search('Macintosh') == -1) return;

    ajax_get_json('<%:EE_HTTP%>action.php?action=show_popup&cookie='+cookie+'&plid='+plid,function(resp){
        if(resp.resp=="2"){
            var ov = document.createElement('div');
            var pup = document.createElement('div');
            ov.className = 'overlay';
            pup.className = 'popup';
            ov.id = 'popup_overlay';
            pup.id = 'popup_body';
            pup.style = "margin-top:-250px";

            var d_header = '<div class="pp_header"><a id="popup_close" title="<%e_cms_cons:POPUP_CANCEL%>" href="#"></a><div class="pp_container"><%e_cms_cons:POPUP_CAPTION%></div></div>';

            var d_q_3  = '<p><%e_cms_cons:POPUP_WHO_GO_ON_WEB%></p>'
                        + '<ul><%ap_inet_device_radio:<%:language%>%></ul>';

            var d_form   = '<form action="#" method="POST" name="popup_form">'
                         + '<div class="pp_body"><div class="pp_container">'
                         /*+ d_q_1
                         + d_q_2*/
                         + d_q_3
                         + '</div></div><div class="pp_footer"><div class="pp_container">'
                         + '<input type="submit" value="<%e_cms_cons:POPUP_SUBMIT%>" name="popup_submit" id="popup_submit" disabled="disabled"><input type="button" value="<%e_cms_cons:POPUP_CANCEL%>" id="popup_cancel">'
                         + '</div></div></form>';

            pup.innerHTML = d_header + d_form;

            document.body.style.overflowY='hidden';
            document.body.appendChild(ov);
            document.body.appendChild(pup);
            //ov.onclick = hide_popup;

            var form = document.forms['popup_form'];
            var subm = document.getElementById('popup_submit');

            /*var rad = form["placement"];
            for( var i = 0; i < rad.length; i++ ) {
                rad[i].onclick = function(){
                    validate_popup( form, subm );
                }
            }*/

            rad = form["using_machine"];
            if(rad)
            for( i = 0; i < rad.length; i++ ) {
                rad[i].onclick = function(){
                    validate_popup( form, subm );
                }
            }

            document.getElementById('popup_cancel').onclick = function(){
                submit_popup( form, cookie, 1 )
            };
            document.getElementById('popup_close').onclick = function(){
                submit_popup( form, cookie, 1 )
            };

            subm.onclick = form.onsubmit = function(){
                submit_popup( form, cookie, 0 );
                return false;
            };

        } else if(resp.resp == "3") {
            var ov = document.createElement('div');
            var pup = document.createElement('div');
            ov.className = 'overlay';
            pup.className = 'popup';
            ov.id = 'popup_overlay';
            pup.id = 'popup_body';

            var d_header = '<div class="pp_header"><div class="pp_container"><%e_cms_cons:PLUGIN_POPUP_CAPTION%></div></div>';

            var d_form   = '<form action="#" method="POST" name="popup_form">'
                    + '<div class="pp_body"><div class="pp_container">'
                    + '<p style="background:none"><br/><%longtext_edit_cms:POPUP_GO_TO_PLUGIN%><%cms_for_js:POPUP_GO_TO_PLUGIN%><br/></p>'
                    + '</div></div><div class="pp_footer"><div class="pp_container">'
                    + '<div style="float:left; margin:5px 20px; font-size:9px"><a id="popup_cancel" style="margin-right:10px" href="javascript:void(0)">x</a><%e_cms_cons:NO_THANKS%></div>'
                    + '<input type="button" value="<%e_cms_cons:POPUP_GO%>" id="popup_go">'
                    + '</div></div></form>';

            pup.innerHTML = d_header + d_form;

            document.body.style.overflowY='hidden';
            document.body.appendChild(ov);
            document.body.appendChild(pup);

            var form = document.forms['popup_form'];
            var subm = document.getElementById('popup_submit');

            document.getElementById('popup_cancel').onclick = function(){
                submit_popup5(cookie);
            };

            document.getElementById('popup_go').onclick = function(){
                submit_popup1(cookie);
            };

            form.onsubmit = function(){
                submit_popup1(cookie);
                return false;
            };
        }
    });
}

function set_background(field)
{
//alert(field);
	var id = 'header_login_form_'+field;
//alert(id);
	var el = document.getElementById(id);
//alert(el);
//alert(el.value);

	if (el.value!='')
	{
		var background = '#fff';
		el.style.background = background;
	}
	else
	{
		var background = '#fff url(\'<%:EE_HTTP_PREFIX%>css/images/bg_'+field+'_<%:language%>.png\') no-repeat left top';
		el.style.background = background;
	}
//alert(background);
}

</script>

<script type="text/javascript" src="<%:EE_HTTP%>js/ap_header_login_form.js"></script>

<%include:ap_registration_form_js%>
  </head>

  <body id="iRoot" class="page">

<%include:<%iif:1,1,cmeter%>%>

<%iif::dns_draft_status,1,
<div id ="draft_div">DRAFT MODE</div>
%>

<%iif:<%config_var:use_draft_content%>,1,<%iif:<%checkAdmin%>,1,<div id ="draft_div">DRAFT MODE</div>%>%>

<%print_admin_head%>
<%:admin_menu%>

<%edit_cms:html_comments_between_page_head_and_title%>

<!--p>head.tpl</p-->
