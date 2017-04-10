<!-- <%cms_cons:Total%>: <%:rows_total%><br/> -->
<table class="survey_history">
<thead><tr>
  <th>
    <%e_cms_cons:Date%>
  </th>
  <th>
    <%e_cms_cons:Survey title%>
  </th>
  <th>
    <%e_cms_cons:Points count%>
  </th>
</tr></thead>
<tbody>

<%row%
<!-- <%cms_cons:Row num%>: <%:row_num%><br/> -->

<tr class="<%iif::points_convertion,0,,points_convertion_row%>">
  <td>
    <%:survey_date%>
  </td>
  <td>
      <%:survey_title%>
  </td>
  <td>
    <%:survey_points%>
  </td>
</tr>

%row%>
</tbody></table>

<%include:survey_history_totals%>


</div>
