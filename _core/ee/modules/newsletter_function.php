<?php
/**
 * This function returns newsletter status
 *
 * @param int $newsletter_id id of newsletter in DB 
 * @return string status of newsletter [draft|sent|archive]
 */

function get_newsletter_status($newsletter_id)
{
	return getField('SELECT status FROM v_news_letters_grid WHERE id = '.sqlValue($newsletter_id));
}
?>