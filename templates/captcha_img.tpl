<script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/captcha.js"></script> 

<img alt="" title="" id="img_<%iif::captcha_name,,captcha_code,:captcha_name%>" src="<%:EE_HTTP%>action.php?action=show_captcha&rndmz=<%:rndmz_for_captcha%>" />
