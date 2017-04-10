function openEditor(f_name, t, type, language, use_languages_list) {

	var cms_name_values;

	if (typeof(f_name)=='string')
	{
		f_name = Array(f_name);
	}

	cms_name_values = '';

	for (i=0; i<f_name.length; i++)
	{
		cms_name_values = cms_name_values + "cms_name[]="+f_name[i]+"&";
	}

	language = (language) ? language : '<%:language%>';

	if (type=="text")
	{
		x=800;
		y=200;
	}
	else if (type=="textarea")
	{
		x=800;
		y=530;
	}
	else if (type=="select" || type=="select_gallery" || type=="select_survey")
	{
		x=800;
		y=200;
	}
	else if (type=="link")
	{
		x=800;
		y=300;
	}
	else if(type=="form")
	{
		x=800;
		y=200;
	}
	else
	{
		x=800;
		y=530;
	}

	if (f_name.length > 1)
	{
		var header_y;
		head_foot_y = 140;

		y = ((y-head_foot_y)*f_name.length)+head_foot_y;
	}

	URL="<%:EE_ADMIN_URL%>cms.php?"+cms_name_values+"t="+t+"&lang="+language+"&admin_template=<%get:admin_template%>&type="+type;

	if (use_languages_list == 'no')
	{
		URL = URL + "&use_languages_list=no";
	}
	openPopup(URL,x,y);
}

function openEditorObject(r_id, id) {
	x=800;
	y=670;
	URL="<%:EE_ADMIN_URL%>cms_object.php?record_id="+r_id+"&id="+id+"&lang=<%:language%>";
	window.parent.openPopup2(URL,x,y);
}
