
<div class="survey_history_header">
  <div class="survey_date">
    <%e_cms_cons:State%>
  </div>
  <div class="survey_title">
    <%e_cms_cons:Survey title%>
  </div>
  <div class="survey_points">
    <%e_cms_cons:Points count%>
  </div>
</div>


<%row%

<div class="survey_history_border">

  <%iif::row_num,:rows_total,<div class="survey_history_row_footer_top">,<%iif:<%mod::row_num,:SURVEY_HISTORY_ROWS_ON_PAGE%>,1,<div class="survey_history_row_footer_top">%>%>


    <div
	class="survey_history_row <%iif::row_num,:rows_total,footer,<%iif:<%mod::row_num,:SURVEY_HISTORY_ROWS_ON_PAGE%>,1,footer%>%>"
	id="survey_history_row<%iif::row_num,:rows_total,__footer,<%iif:<%mod::row_num,:SURVEY_HISTORY_ROWS_ON_PAGE%>,1,__footer%>%>"
    >
      <div class="survey_date">
        <a href="<%:survey_url%>"><%cms_cons:Take part%></a>
      </div>
      <div class="survey_title">
        <%:project_name%>
      </div>
      <div class="survey_points">
        <%ap_project_points_label::project_max_point%>
      </div>
    </div>


  <%iif::row_num,:rows_total,</div>,<%iif:<%mod::row_num,:SURVEY_HISTORY_ROWS_ON_PAGE%>,1,</div>%>%>

</div>

%row%>


&nbsp;
<br/>

<%row_empty%

<div class="survey_history_border">
  <div class="survey_history_row_footer_top">
    <div class="survey_history_row footer" id="survey_history_row__footer">
      <div class="survey_date">&nbsp;</div>
      <div class="survey_title"><%e_page_cms:empty_row%></div>
      <div class="survey_points">&nbsp;</div>
    </div>
  </div>
</div>

%row_empty%>

