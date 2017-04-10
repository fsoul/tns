<!--

function imgRefresh(im_id)
{
	im = document.getElementById(im_id);

	tmp = new Date(); 
	tmp = tmp.getTime();

	if (im.src.indexOf('?'))
	{
		var separator = '&';
	}
	else
	{
		var separator = '?';
	}

	separator += 'tmp=';

	var p = im.src.lastIndexOf(separator);

	if (p > 0)
	{
		im.src = (im.src.substring(0, p+1)) + tmp;
	}
	else
	{
		im.src += (separator + tmp);
	}
}

// -->
