<form action="" method="get">
<%setValueOf:usr_role,<%getField:SELECT role FROM users WHERE id='<%:edit%>'%>%>
<%setValueOf:cont_access,<%getField:SELECT content_access FROM users WHERE id='<%:edit%>'%>%>
<input type="hidden" name="op" value="back_office_access" />
<input type="hidden" name="edit" value="<%:edit%>">

<table>
	<tr><td><b>Back office accsess for <span style="color:#f00"><%getField:SELECT login FROM users WHERE id=<%sqlValue:<%:edit%>%>,0%></span></b></td></tr>
	<tr><td style="padding:10px">
		<input type="radio" name="access_right" value="1" <%iif:<%:usr_role%>,1,checked,%> />None<br/>
		<input type="radio" name="access_right" value="3" <%iif:<%:usr_role%>,3,checked,%> />Administrator (Full Access)<br/>
		<input type="radio" name="access_right" value="2" <%iif:<%:usr_role%>,2,checked,%> />Backoffice user (Restricted Access)<br/>
		<div style="padding:10px">
			<fieldset>
				<legend style="font-size:11px; color:blue;">Backoffice user configuration</legend>
				<div>Available modules&#160;&#160;&#160;&#160;&#160;<input type="button" value=". . ." /></div>
	                        <div>Default content access:</div>
				<div>
					<input type="radio" name="content_access" value="1" <%iif:<%:cont_access%>,1,checked="checked",%> />Read only<br />
					<input type="radio" name="content_access" value="2" <%iif:<%:cont_access%>,2,checked="checked",%> />Edit<br />
					<input type="radio" name="content_access" value="3" <%iif:<%:cont_access%>,3,checked="checked",%> />Publish<br />
					<input type="radio" name="content_access" value="4" <%iif:<%:cont_access%>,4,checked="checked",%> />Full<br />
				</div>
			</fieldset>
		</div>
	</td></tr>
	<tr><td><%:UserRole%></td></tr>
</table>

<input type="submit" />

</form>