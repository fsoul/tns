  <tr>
    <td valign="top" align="right">
      <%include:captcha_img%>
      <div class="captcha_redraw">
<%text_edit_cms_cons:Redraw%>
        <a class="pointer" onclick="imgRefresh('img_<%iif::captcha_name,,captcha_code,:captcha_name%>');"><%cms_cons:Redraw%></a>
      </div>
    </td>
    <td>&nbsp;</td>
    <td valign="top">

      <input
        type="text"
        name="<%iif::captcha_name,,captcha_code,:captcha_name%>"
	autocomplete="off"
        class="inputTxt"
        style="
		width:85px;
	        <%iif:<%getError:<%iif::captcha_name,,captcha_code,:captcha_name%>%>,,,background: #ff0;%>
	"
        <%iif:<%getError:<%iif::captcha_name,,captcha_code,:captcha_name%>%>,,,onkeypress="this.style.background='#fff';"%>
      />


    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

