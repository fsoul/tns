<?
	/*
		$user_filter = array('sessions'=>'Sessions', 'user_paths'=>'Users Paths', 'bypages'=>'By Pages'
								, 'users_entry'=>'Entry Points', 'user_exit' => 'Exit Pages', 'user_ref'=>'References');
		$engines_filter = array('eng_sessions'=>'Sessions', 'eng_bypages'=>'By Pages'
								, 'eng_entry'=>'Entry Points', 'eng_exit' => 'Exit Pages', 'eng_ref'=>'References');
	*/
	$sessions_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px" class="table_header">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Session path</td>
	<td  align="center" width="70px" class="solidBorder">User&nbsp;category</td>
	<td  align="center" width="50px" class="solidBorder">Start</td>
	<td  align="center" width="50px" class="solidBorder">Time</td>
</tr>';

	$user_paths_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">User category</td>
	<td  align="center" width="50px" class="solidBorder">Amount</td>
	<td  align="center" width="50px" class="solidBorder">%</td>
</tr>';

	$bypages_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>';

	$users_entry_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>';

	$user_exit_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>';

	$user_ref_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>';


	$eng_sessions_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px" >	
	<td rowspan="2" align="center" width="10px" class="solidBorder">#</td>
	<td  rowspan="2" align="center" width="*" class="solidBorder">Engine</td>
	<td  rowspan="2" align="center" width="80px" class="solidBorderText">Last indexed</td>
	<td  rowspan="2" align="center" width="50px" class="solidBorderText">Total indexed pages</td>
	<td  rowspan="2" align="center" width="50px" class="solidBorderText">Total for previous period</td>
	<td  align="center" width="50px" colspan="2" class="solidBorderText">Comparison</td>
</tr>
<tr>
	<td align="center" class="solidBorderText">%</td>
	<td align="center" class="solidBorderText">hits</td>
</tr>';
	
	$eng_bypages_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px" >	
	<td rowspan="2" align="center" width="10px" class="solidBorder">#</td>
	<td  rowspan="2" align="center" width="*" class="solidBorder">Pages</td>
	<td  rowspan="2" align="center" width="70px" class="solidBorderText">Last visited</td>
	<td  rowspan="2" align="center" width="50px" class="solidBorderText">Total</td>
	<td  rowspan="2" align="center" width="50px" class="solidBorderText">Total for previous period</td>
	<td  align="center" width="50px" colspan="2" class="solidBorderText">Comparison</td>
</tr>
<tr>
	<td align="center" class="solidBorderText">%</td>
	<td align="center" class="solidBorderText">hits</td>
</tr>';
	
	$eng_entry_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>';
	
	$eng_exit_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>';
	
	$eng_ref_header = '<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>';

?>