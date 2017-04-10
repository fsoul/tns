<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Insert media</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<script type="text/javascript">

    function submit_cur(vr) {
        if (vr == 'delete') {
            this.document.fi.type.value = 'delete';
            this.document.fi.submit();
        } else {

            if (this.document.fi.url.checked &&
                this.document.fi.f_url_text.value.length < 4) {
                    alert('You must enter URL');
                    this.document.fi.f_url_text.focus();
                    return false;
            }

            this.document.fi.submit();

        }
    }
    function edit_current(vr) {
        if (vr == 'open_url') {
            this.document.fi.f_url_text.disabled  = '';
            //this.document.fi.satelit.disabled    = 'disabled';
			this.document.fi.select_button.disabled = 'disabled';
            this.document.fi.open_sat_page.checked = '';
            this.document.fi.open_url.checked = 'checked';
            this.document.fi.open_none.checked = '';
	    this.document.fi.media_title.disabled = '';
        } else if (vr == 'open_sat_page'){
            this.document.fi.f_url_text.disabled  = 'disabled';
            //this.document.fi.satelit.disabled    = '';
			this.document.fi.select_button.disabled    = '';
            this.document.fi.open_sat_page.checked = 'checked';
            this.document.fi.open_url.checked = '';
            this.document.fi.open_none.checked = '';
	    this.document.fi.media_title.disabled = '';
        } else {
            this.document.fi.open_none.checked = 'checked';
            this.document.fi.f_url_text.disabled  = 'disabled';
            //this.document.fi.satelit.disabled    = 'disabled';
			this.document.fi.select_button.disabled = 'disabled';
            this.document.fi.open_sat_page.checked = '';
            this.document.fi.open_url.checked = '';
	    this.document.fi.media_title.disabled = 'disabled';
        }
    }

    function edit_size(vr) {
        if (vr == 'default') {
            this.document.fi.f_size_x.disabled  = 'disabled';
            this.document.fi.f_size_y.disabled    = 'disabled';
            this.document.fi.image_size.checked = 'default';
            customsize.style.display = 'none';
            defaultsize.style.display = 'inline';
            this.document.getElementById('size_custom_ch').checked = "";
            this.document.getElementById('size_default_ch').checked = "checked";
        } else {
            this.document.fi.f_size_x.disabled  = '';
            this.document.fi.f_size_y.disabled    = '';
            customsize.style.display = 'inline';
            defaultsize.style.display = 'none';
            this.document.getElementById('size_custom_ch').checked = "checked";
            this.document.getElementById('size_default_ch').checked = "";
        }
    }

function LoadXML(uri,method,post_str)
{
	var request = null;

	// пытаемся создать объект для MSXML 2 и старше
	if (!request)
	{
		try
		{
			request = new ActiveXObject('Msxml2.XMLHTTP');
		}
		catch (e){}
	}

	// не вышло... попробуем для MSXML 1
	if (!request)
	{
		try
		{
			request = new ActiveXObject('Microsoft.XMLHTTP');
		}
		catch (e){}
	}

	// не	вышло... попробуем для Mozilla и Opera 7.60
	if (!request)
	{
		try
		{
			request = new XMLHttpRequest();
		}
		catch (e){}
	}

	if (!request)
	{
		// ничего не получилось...

		return null;
	}

	// делаем запрос
	request.open(method, uri, false);

	if (method=='GET') {
		request.send(null);
	} else {
		request.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		request.send(post_str);
	}

//	if (request.responseXML.childNodes.length==0)
//		return null;//alert('xml не загрузился');

	//возвращаем XML

	return request.responseText;
}
function update_preview(id)
{
	pr = document.getElementById('preview');
	if (id == 0 || id == 'undefined')
	{
		pr.innerHTML = '';
		return true;
	}
	else 
	{
		res = LoadXML('<%:EE_ADMIN_URL%>media_insert.php?op=get_preview&language=<%:language%>&pr_id='+id,'GET');
		pr.innerHTML = res;
		var img_res = pr.getElementsByTagName('img')[0];
		if(img_res != undefined){
			var img_x =  img_res.width;
			var img_y =  img_res.height;
			if(img_y > img_x)
			{       
				var k = img_res.height / img_res.width;
				img_res.height = img_res.height / k;
				img_res.width = img_res.width / k;
			}
		}
		return res;
	}
}

function clearMedia() {
	document.getElementById('nmediaid').value = '0';
	//document.getElementById('nmediaid2').innerHTML = '0';
	document.getElementById('nmedianame').innerHTML = '&lt; empty &gt;';
	update_preview(0);
}

function selectMedia() {
	URL="<%:EE_ADMIN_URL%>_assets.php?return_medias_for_insert=1&show_admin_menu=0&module_title_and_options=0&big_options=0&folder_menu=0&content_menu=0&group_by_options=0&hide_checkbox=1&hide_page_action=1&hide_checkbox=1&hide_page_edit=1&hide_page_autor=1&hide_view=1&hide_index=1&hide_cachable=1";
	// Set the browser window feature.
	var iWidth	= 800;
	var iHeight	= 600;
	window.parent.openPopup2(URL,iWidth,iHeight);
}

function returnMediaId(id, name) {
	document.getElementById('nmediaid').value = id;
	//document.getElementById('nmediaid2').innerHTML = id;
	document.getElementById('nmedianame').innerHTML = name;
	update_preview(id);
}
</script>
<%print_admin_js%>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0" onload="update_preview(<%:cur_id%>)">
<center>
<form name="fi" method="post" enctype="multipart/form-data">
<input type="hidden" name="i_name" value="<%getValueOf:i_name%>">
<input type="hidden" name="page_dependent" value="<%:page_dependent%>">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee" class="table_header">
		<td colspan="2" align="center" height="40">Select media object for position:&nbsp;&nbsp;<%getValueOf:i_name%></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="#092869"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr bgcolor="#EFEFDE" class="table_header">
		<td colspan="2">&nbsp;&nbsp;<b>Media preview:</b></td>
	</tr>
	<tr>
		<td colspan="2"><div id="preview" style="text-align:center; margin: 10px 0 0 0;"></div></td>
	</tr>
	<tr>
		<td>
		&nbsp;Media path:
		</td>
		<td>
		<%setValueOf:empty_media,&lt; empty &gt;%>
		<table border="0" cellpadding="0" cellspacing="0" width="334" style="margin: 10px 0;">
		<tr>
			<td width="100%">
			<div style="overflow: hidden;" id="nmedianame"><%iif:<%:current_media%>,,<%:empty_media%>,<%:current_media%>%></div>
			</td>
			<td align="right">
			<span style="white-space: nowrap;"><input type="hidden" name="nmediaid" id="nmediaid" value="<%:cur_id%>">&nbsp;<input type="button" value="Clear" onclick="clearMedia();">&nbsp;<input type="button" value="Select" onclick="selectMedia();">&nbsp;</span>
			</td>
		</tr>
		</table>
		</td>
	</tr>
		<%include:media_insert/image_link%>
	<tr>
		<td colspan="2" bgcolor="#EFEFDE"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="5"></td>
	</tr>
</table><br><input type="button" value="Cancel" class="button" onclick="window.parent.closePopup()">&nbsp;&nbsp;<input type="submit" value="Save" name="save" class="button">
</form>
</center>
</body>
</html>
