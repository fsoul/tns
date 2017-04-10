<nobr><input id="size_default_ch" onClick="javascrip:edit_size('default')" type="radio" name="image_size" value="default">Original size&nbsp;&nbsp;&nbsp;&nbsp;<input id="size_custom_ch" onClick="javascrip:edit_size('custom')" type="radio" name="image_size" value="custom">Custom size<div id="customsize" style="display:none">: <input type="text" style="width:30px; font-weight:bold;" name="f_size_x" value="<%:size_x%>">&nbsp;X&nbsp;<input type="text" style="width:30px; font-weight:bold;" name="f_size_y" value="<%:size_y%>">&nbsp;px</div></nobr>
<script language="JavaScript">
    function edit_size(vr) {
        if (vr == 'default') {
            this.document.fs.f_size_x.disabled  = 'disabled';
            this.document.fs.f_size_y.disabled    = 'disabled';
            this.document.fs.image_size.checked = 'default';
            customsize.style.display = 'none';
            this.document.getElementById('size_custom_ch').checked = "";
            this.document.getElementById('size_default_ch').checked = "checked";
        } else {
            this.document.fs.f_size_x.disabled  = '';
            this.document.fs.f_size_y.disabled    = '';
            customsize.style.display = 'inline';
            this.document.getElementById('size_custom_ch').checked = "checked";
            this.document.getElementById('size_default_ch').checked = "";
        }
    }

edit_size('default');
</script>
