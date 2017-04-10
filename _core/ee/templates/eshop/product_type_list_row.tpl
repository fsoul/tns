<%row%
<%iif::cur_type,,<h3><%:type_name%></h3><ul>,<%iif::cur_type,<%:type_id%>,,</ul><h3><%:type_name%></h3><ul>%>%>
<%setValueOf:cur_type,<%:type_id%>%>
<li><a href="<%:EE_HTTP%>index.php?t=<%:t%>&language=<%:language%>&gid=<%getValueOf:sid,true%>" <%iif:<%:gid%>,<%getValueOf:sid,true%>,class="active"%>><%:s_group_name%></a></li>
%row%>
</ul>