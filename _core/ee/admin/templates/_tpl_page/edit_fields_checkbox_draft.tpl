<input <%iif::readonly,,,readonly%> 
<%iif:<%config_var:use_draft_content%>,1,checked,checked disabled="disabled"%> type="checkbox" name="<%:field_name%>" value="1" onclick="publishPageHandler(this)" />
