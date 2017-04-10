<table class="p_results" cellspacing="0" cellpadding="0">

<tr>
  <th>
    <%e_cms_cons:Win Date%>
  </th>

  <th>
    <%e_cms_cons:Win Points%>
  </th>
</tr>


<%row%

<tr class="<%iif::is_success,0,grey%>">
  <td>
    <%:start_date%>
  </td>
  <td>
    <%:point%>
  </td>
</tr>

%row%>
</table>

