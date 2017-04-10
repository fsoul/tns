<%setValueOf:rows_on_page,<%cms:rows_on_page_<%:modul%>_<%:UserId%>%>%>
<%setValueOf:rows_on_page,<%iif::rows_on_page,,<%:MAX_ROWS_IN_ADMIN%>,:rows_on_page%>%>
<form name="form_rows_on_page" method="post" action="#">
<input type="hidden" name="op" value="rows_on_page">
<input type="hidden" name="modul" value="<%:modul%>">
<input type="hidden" name="user_id" value="<%:UserId%>">
<select name="rows_on_page" onchange="document.form_rows_on_page.submit();">
	<!-- option value= "-1" <%iif:<%:rows_on_page%>,-1,selected="1"%>><%cons:All%></option -->
	<option value=  "5" <%iif:<%:rows_on_page%>,5,selected="1"%>>5</option>
	<option value= "10" <%iif:<%:rows_on_page%>,10,selected="1"%>>10</option>
	<option value= "15" <%iif:<%:rows_on_page%>,15,selected="1"%>>15</option>
	<option value= "20" <%iif:<%:rows_on_page%>,20,selected="1"%>>20</option>
	<option value= "50" <%iif:<%:rows_on_page%>,50,selected="1"%>>50</option>
	<option value= "75" <%iif:<%:rows_on_page%>,75,selected="1"%>>75</option>
	<option value="100" <%iif:<%:rows_on_page%>,100,selected="1"%>>100</option>
</select>
</form>