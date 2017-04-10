<script type="text/javascript" src="http://source.tns.bemobile.ua/id/tns_id.js"></script>

<script type="text/javascript">
        var tid = new tnsId();
alert(tid);
	tid.onReady = function(id) {
alert(1);
		try {
alert(2);
			if ("" != "<%ap_get_respondent_id%>") {
alert(3);

				tid.send("<%ap_get_respondent_id%>", -1, 2);
alert(4);

			} else {
alert(5);

				document.getElementById('tns_id').value = id;
alert(6);
			}
alert(7);

		} catch(e) {

		}
		alert("id - " + id);
	}

</script>
