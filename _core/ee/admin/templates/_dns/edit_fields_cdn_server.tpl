<%iif:<%is_cdn_server:<%:id%>%>,1,<%get_dns_for_cdn:<%:id%>%>,
<input type="checkbox" id="enable_cdn" name="enable_cdn" style="float: left;" <%iif:<%:<%:field_name%>%>,,,<%iif::op,3,,checked%>%> value="1" onchange="if (this.checked) {document.getElementById('<%:field_name%>').value='<%:<%:field_name%>%>'; document.getElementById('<%:field_name%>').style.display='block'; } else {document.getElementById('<%:field_name%>').style.display='none'; document.getElementById('<%:field_name%>').value=''; }" />

<select id="<%:field_name%>" name="<%:field_name%>" style="display: <%iif::op,3,none,<%iif:<%:<%:field_name%>%>,,none,block%>%>;">
	<option value="">please select CDN...</option>
	<%dns_list:<%:<%:field_name%>%>%>
</select>
%>