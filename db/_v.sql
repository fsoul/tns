DROP VIEW IF EXISTS v_lang;
DROP VIEW IF EXISTS v_language;

CREATE VIEW v_language AS

	 SELECT *
	   FROM language
	 WHERE language_code <> ''
	;

DROP VIEW IF EXISTS v_tpl_non_folder;
CREATE VIEW v_tpl_non_folder AS
SELECT
  p.id,
  p.page_name,
  p.extension,
  p.page_description,
  p.default_page,
  p.create_date,
  p.edit_date,
  p.tpl_id,
  p.folder_id,
  p.for_search,
  p.owner_name,
  p.is_locked,
  IF (p.tpl_id=0, 0, tpl_files.type) AS type,
  IF (p.tpl_id=0, '', tpl_files.file_name) AS file_name,
  p.group_access,
  p.priority,
  p.cachable

  FROM
    tpl_pages p
  LEFT JOIN tpl_files ON p.tpl_id = tpl_files.id WHERE p.tpl_id IS NOT NULL;
DROP VIEW IF EXISTS v_ms_mail;
CREATE VIEW v_ms_mail
AS
	SELECT id, original_id, subject, date_reg, body, CONCAT(from_name,' (' , from_email , ')') AS from_,
		(SELECT status FROM ms_status	WHERE id = ms_status_id) AS status,
		CONCAT((SELECT rtrim(cast(COUNT(*) AS char)) FROM ms_recipient AS recip1 WHERE recip1.ms_mail_id = ms_mail.id), ' / ',
		(SELECT rtrim(cast(COUNT(*) AS char)) FROM ms_recipient AS recip2
			WHERE recip2.ms_mail_id = ms_mail.id AND recip2.ms_status_id = 3)) AS recipients_count
FROM  ms_mail;
DROP VIEW IF EXISTS v_tpl_folder;
CREATE VIEW v_tpl_folder AS
SELECT
  tpl_pages.id,
  tpl_pages.page_name,
  tpl_pages.page_description,
  tpl_pages.default_page,
  tpl_pages.create_date,
  tpl_pages.edit_date,
  tpl_pages.folder_id,
  tpl_pages.for_search,
  tpl_pages.owner_name,
  tpl_pages.is_locked
FROM
  tpl_pages
WHERE
  tpl_pages.tpl_id IS NULL;
DROP VIEW IF EXISTS v_tpl_path_content;

CREATE VIEW v_tpl_path_content
AS

     SELECT
            v_tpl_folder.id,

            IF(regular_content.val IS NULL,
			   IF(regular_content.val_draft IS NULL,
                  IF(default_content.val IS NULL,
				     IF(default_content.val_draft IS NULL,
					    v_tpl_folder.page_name,
                        default_content.val_draft
					 ),
                     default_content.val
                  ),
				  regular_content.val_draft
			   ),
               regular_content.val
            ) AS folder,
            language.language_code as language

       FROM
            (v_tpl_folder, v_language AS language)

  LEFT JOIN content regular_content
         ON v_tpl_folder.id = regular_content.var_id
        AND regular_content.var = 'folder_path_'
        AND regular_content.language = language.language_code

  LEFT JOIN content default_content
         ON v_tpl_folder.id = default_content.var_id
        AND default_content.var = 'folder_path_'
        AND default_content.language = (SELECT language_code FROM language WHERE default_language = 1)
;DROP VIEW IF EXISTS v_media_content;
CREATE VIEW v_media_content AS
SELECT
  v_tpl_non_folder.id,
  IF(regular_content.val IS NULL,
    IF(default_content.val IS NULL,
      v_tpl_non_folder.page_name,
      default_content.val
    ),
    regular_content.val
  ) AS page_name,
  v_tpl_non_folder.page_description,
  v_tpl_non_folder.default_page,
  v_tpl_non_folder.create_date,
  v_tpl_non_folder.edit_date,
  v_tpl_non_folder.tpl_id,
  v_tpl_non_folder.folder_id,
  v_tpl_non_folder.for_search,
  v_tpl_non_folder.owner_name,
  v_tpl_non_folder.is_locked,
  v_tpl_non_folder.type,
  v_tpl_non_folder.file_name,
  v_tpl_non_folder.cachable,
  language.language_code as language
FROM
   (v_tpl_non_folder, v_language AS language)
LEFT JOIN content regular_content ON
      v_tpl_non_folder.id = regular_content.var_id AND
      regular_content.var = 'page_name_' AND
      regular_content.language = language.language_code
LEFT JOIN content default_content ON
      v_tpl_non_folder.id = default_content.var_id AND
      default_content.var = 'page_name_' AND
      default_content.language = (SELECT language_code FROM language WHERE default_language = 1)
WHERE
  v_tpl_non_folder.type = 1
;
DROP VIEW IF EXISTS v_media_grid;
CREATE VIEW v_media_grid AS
SELECT
  v_media_content.id,

  CONCAT(
    v_media_content.page_name,
    CASE WHEN v_media_content.default_page>0 THEN ' ( default )' ELSE '' END
  ) AS media_name,

  v_media_content.page_description as media_description,

  CONCAT(v_media_content.file_name,'.tpl') AS template,

  CONCAT('/', IF(v_tpl_path_content.folder IS NULL,'',v_tpl_path_content.folder)) as folder,

  v_media_content.edit_date,
  CASE v_media_content.cachable
  WHEN '1' THEN 'Yes'
  ELSE 'No' END AS cachable,

  (CASE (SELECT COUNT(*)
     FROM content
    WHERE (val <> val_draft COLLATE utf8_bin OR val IS NULL)
      AND val_draft IS NOT NULL
      AND content.var = 'media_'
      AND content.var_id = v_media_content.id
        )
   WHEN 0 THEN 'No'
   ELSE 'Yes'
   END) AS in_draft_state,
   v_media_content.language

     FROM v_media_content
LEFT JOIN v_tpl_path_content

       ON
          v_media_content.folder_id = v_tpl_path_content.id
      AND v_media_content.language = v_tpl_path_content.language

       OR v_tpl_path_content.id is null

;DROP VIEW IF EXISTS v_tpl_non_folder_statistic;

CREATE VIEW v_tpl_non_folder_statistic AS
SELECT
  p.*,
  CASE (SELECT COUNT(page_id)
     FROM content
    WHERE (val <> val_draft COLLATE utf8_bin OR val IS NULL)
      AND val_draft IS NOT NULL
      AND content.page_id = p.id
  ) 
  WHEN 0 THEN 'No'
  ELSE 'Yes' 
  END AS in_draft_state,

  CASE (SELECT COUNT(page_id)
	FROM 
		content
	WHERE
		(val <> val_draft COLLATE utf8_bin OR val IS NULL)
	AND
		content.page_id = '0'
	AND
		content.var='page_name_'
	AND
		content.var_id=p.id
	AND
		val_draft IS NOT NULL
	)
   WHEN 0 THEN 'No'
   ELSE 'Yes'
   END AS is_draft_page,
  

  (SELECT MAX(content.edit_date)
     FROM content
    WHERE content.page_id = p.id)
  AS publish_date,
  
  (SELECT MAX(content.edit_date_draft)
     FROM content
    WHERE content.page_id = p.id)
  AS edit_date_draft,
  
  (SELECT val
     FROM content
    WHERE var = 'edit_user' AND page_id = p.id)
  AS edit_user

FROM v_tpl_non_folder p
;
DROP VIEW IF EXISTS v_tpl_page_content;

CREATE VIEW v_tpl_page_content

AS

SELECT

  v_tpl_non_folder.id,
  IF(regular_content.val IS NULL,
      IF(regular_content.val_draft IS NULL,
        IF(default_content.val IS NULL,
          v_tpl_non_folder.page_name,
          default_content.val
        ),
        regular_content.val_draft),
    regular_content.val
  ) AS page_name,
  v_tpl_non_folder.page_description,
  v_tpl_non_folder.default_page,
  v_tpl_non_folder.create_date,
  v_tpl_non_folder.edit_date,
  v_tpl_non_folder.tpl_id,
  v_tpl_non_folder.folder_id,
  v_tpl_non_folder.for_search,
  v_tpl_non_folder.owner_name,
  v_tpl_non_folder.is_locked,
  v_tpl_non_folder.type,
  v_tpl_non_folder.file_name,
  language.language_code as language,
  v_tpl_non_folder.group_access,
  v_tpl_non_folder.priority,
  v_tpl_non_folder.cachable

     FROM
          (v_tpl_non_folder, v_language AS language)

LEFT JOIN content AS regular_content
       ON v_tpl_non_folder.id = regular_content.var_id
      AND regular_content.var = 'page_name_'
      AND regular_content.language = language.language_code

LEFT JOIN content AS default_content
       ON v_tpl_non_folder.id = default_content.var_id
      AND default_content.var = 'page_name_'
      AND default_content.language = (SELECT language_code FROM language WHERE default_language = 1 LIMIT 0,1)

    WHERE
          v_tpl_non_folder.type = 0
;
DROP VIEW IF EXISTS v_tpl_page_grid;

CREATE VIEW v_tpl_page_grid
AS
	 SELECT
		v_tpl_page_content.id,
		v_tpl_page_content.page_name AS page_name,
		v_tpl_page_content.page_description AS page_description,

		CONCAT(v_tpl_page_content.file_name,_latin1'.tpl') AS template,

		IF(ISNULL(v_tpl_path_content.folder),'/',CONCAT('/',v_tpl_path_content.folder)) AS folder,

		v_tpl_page_content.default_page AS is_default,

		CASE v_tpl_page_content.default_page
		WHEN 1 THEN 'Yes'
		ELSE '' END AS default_page,

		CASE v_tpl_page_content.for_search
		WHEN 1 THEN 'Yes'
		ELSE '' END AS for_search,

		CASE v_tpl_page_content.is_locked
		WHEN 1 THEN 'Yes'
		ELSE 'No' END AS locked,

		CASE v_tpl_page_content.cachable
		WHEN '1' THEN 'Yes'
		ELSE 'No' END AS cachable,

		v_tpl_page_content.language AS language,
		v_st.in_draft_state,
    		v_st.publish_date AS edit_date,
	    	v_st.edit_date_draft,
    		v_st.edit_user

           FROM v_tpl_page_content
      LEFT JOIN v_tpl_path_content

             ON
                v_tpl_page_content.folder_id = v_tpl_path_content.id
            AND v_tpl_page_content.language = v_tpl_path_content.language

             OR v_tpl_path_content.id is null
      INNER JOIN v_tpl_non_folder_statistic v_st
            ON v_tpl_page_content.id = v_st.id
;DROP VIEW IF EXISTS vbrowser_grid;

CREATE VIEW vbrowser_grid AS

	 SELECT *
		
	   FROM v_tpl_page_grid
	;

DROP VIEW IF EXISTS vmbrowser_grid;

CREATE VIEW vmbrowser_grid AS

	 SELECT *
		
	   FROM v_media_grid
	;
DROP VIEW IF EXISTS v_channel_db;
CREATE VIEW v_channel_db AS 
			
	 	SELECT DISTINCT
			SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)) as id
		,
lan.language_code as language,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_channel_id')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as channel_id,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_status')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as status,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_author')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as author,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_channel_type')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as channel_type,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_title')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as title,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_description')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as description,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_rss')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as rss,

				(select val
				from content
	 	  		where var = CONCAT('channel_db_',SUBSTRING(var,12, (LOCATE('_channel_id',var)-12)),'_copyright')
		    	and language in (lan.language_code, 'EN') 
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as copyright
	 	FROM content as c1, v_language as lan
		WHERE LOCATE('_channel_id',var)>0 and LOCATE('channel_db_',var)>0 AND lan.status=1;

DROP VIEW IF EXISTS v_channel_edit;
CREATE VIEW v_channel_edit AS 
SELECT 
	channel_id,
 	title, 
 	description, 
	status,
 	author, 
 	channel_type, 
 	copyright,
 	rss
FROM v_channel_db;
DROP VIEW IF EXISTS v_channel_grid;
CREATE VIEW v_channel_grid AS
SELECT channel_id, title,

CASE status
      WHEN 0 THEN 'inactive'
      WHEN 1 THEN 'active'
END AS 'status',

author, channel_type,

CASE rss
      WHEN 0 THEN 'No'
      WHEN 1 THEN 'Yes'
END AS 'rss'
FROM v_channel_db

WHERE language = (SELECT language_code FROM v_language WHERE default_language=1);DROP VIEW IF EXISTS v_dns;

CREATE VIEW v_dns AS

	 SELECT *
	   FROM dns
	;

DROP VIEW IF EXISTS v_dns_edit;

CREATE VIEW v_dns_edit AS

	 SELECT *
	   FROM v_dns
	;

DROP VIEW IF EXISTS v_dns_grid;

CREATE VIEW v_dns_grid AS

	 SELECT id,
		dns,
		comment,

		CASE status
		WHEN 1
		THEN 'Enabled'
		ELSE 'Disabled'
		END AS status,
		language_forwarding,
		draft_mode		

	   FROM v_dns
	;

DROP VIEW IF EXISTS v_events_db;

CREATE VIEW v_events_db AS

	 	SELECT DISTINCT
			SUBSTRING(var,11, (LOCATE('_news_id',var)-11)) as id,

			lan.language_code as language,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_news_id')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as news_id,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_title')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as title,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_description')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as description,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_SystemDate')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as SystemDate,

			(select IF(val<>'',date_format(val,'%d.%m.%Y'),'')
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_SystemDate')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as SystemDate_d,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_ExpiryDate')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as ExpiryDate,

			(select IF(val<>'',date_format(val,'%d.%m.%Y'),'')
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_ExpiryDate')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as ExpiryDate_d,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_DisplayDate')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as DisplayDate,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_PublishedDate')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as PublishedDate,

			(select IF(val<>'',date_format(val,'%d.%m.%Y'),'')
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_PublishedDate')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as PublishedDate_d,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_status')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as status,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_channel_id')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as channel_id,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_show_on_home')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as show_on_home,

				(select val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_category')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end),language) LIMIT 1
				) as category,

				(select
				CASE TRIM(val)
				      WHEN '0' THEN 'draft'
				      WHEN '1' THEN 'published'
				      WHEN '2' THEN 'archive'
				END AS val
				from content
	 	  		where var = CONCAT('events_db_',SUBSTRING(var,11, (LOCATE('_news_id',var)-11)),'_status')
		    	and language in (lan.language_code, 'EN')
		  		order by CONCAT((case language when lan.language_code then '0' else '1' end) ,language) LIMIT 1
				) as status_text

	 	FROM content as c1, v_language as lan
		WHERE LOCATE('_news_id',var)>0 and LOCATE('events_db_',var)>0 AND lan.status=1;
DROP VIEW IF EXISTS v_lang_edit;

CREATE VIEW v_lang_edit AS

	 SELECT language_code id,
		language_url,
		language_name,
		'' AS language_link_title,
		l_encode,
		paypal_lang,
		status,
		default_language as is_default
	   FROM v_language
	;

DROP VIEW IF EXISTS v_lang_grid;

CREATE VIEW v_lang_grid AS

	 SELECT language_code,
		language_url,
		language_name,
		(SELECT val FROM content WHERE var = CONCAT('ee_lang_title_', language_code) AND language=(SELECT language_code FROM v_language WHERE default_language='1') LIMIT 0, 1) AS language_link_title,
		l_encode,
		paypal_lang,
		CASE status
			WHEN 1 THEN 'Enabled'
			ELSE 'Disabled'
		END AS status,

		CASE default_language
			WHEN 1 THEN 'Yes'
			ELSE ''
		END AS default_language
	   FROM v_language
	;

DROP VIEW IF EXISTS v_mail_inbox_edit;

CREATE VIEW v_mail_inbox_edit AS

	 SELECT id,
		name,
		email,
		DATE_FORMAT(send_date,'%d.%m.%Y %H:%i') send_date,
		add_info
	   FROM mail_inbox
	;DROP VIEW IF EXISTS v_mail_inbox_grid;

CREATE VIEW v_mail_inbox_grid AS

	 SELECT id,
		name,
		email,
		send_date,
		message,
		add_info,

		CASE viewed
		WHEN 1
		THEN 'Yes'
		ELSE 'No'
		END AS viewed

	   FROM mail_inbox
;
DROP VIEW IF EXISTS v_mailing_edit;

CREATE VIEW v_mailing_edit AS SELECT id, original_id, subject, date_reg, from_, status, recipients_count FROM v_ms_mail;
DROP VIEW IF EXISTS v_mailing_grid;

CREATE VIEW v_mailing_grid AS SELECT *  FROM v_mailing_edit;
DROP VIEW IF EXISTS v_media;
CREATE VIEW v_media AS
SELECT
  *
FROM
  v_tpl_non_folder
WHERE
  type = 1
;DROP VIEW IF EXISTS v_media_edit;
CREATE VIEW v_media_edit AS
SELECT id,
  page_name,
  page_description as media_description,
  tpl_id AS template,
  folder_id AS folder,
  '' as size,
  '' as alt_tag,
  '' as zip_file_name,
  cachable

FROM v_media;DROP VIEW IF EXISTS v_media_file;
CREATE VIEW v_media_file AS
SELECT *
  FROM tpl_files
	WHERE tpl_files.type = '1';
DROP VIEW IF EXISTS v_ms_recipient;
CREATE VIEW
		v_ms_recipient
AS
SELECT     id, ms_mail_id, recipient, date_update,
                          (SELECT     status
                            FROM      ms_status
                            WHERE     id = ms_status_id) AS status, recipient_id
FROM   ms_recipient;DROP VIEW IF EXISTS v_news_edit;
CREATE VIEW v_news_edit AS

SELECT news_id,
title,
description,
status,
category,
show_on_home,
channel_id,
SystemDate,
ExpiryDate,
PublishedDate

FROM v_events_db

WHERE language = (SELECT language_code FROM language WHERE default_language=1);
DROP VIEW IF EXISTS v_news_grid;
CREATE VIEW v_news_grid AS

SELECT news_id, title,

CASE status
      WHEN 0 THEN 'draft'
      WHEN 1 THEN 'published'
      WHEN 2 THEN 'archive'
END AS 'status',

category, channel_id, SystemDate, ExpiryDate, PublishedDate

FROM v_events_db

WHERE language = (SELECT language_code FROM language WHERE default_language=1);
DROP VIEW IF EXISTS v_news_letters_edit;

CREATE VIEW v_news_letters_edit AS


	SELECT
                id AS id,
                from_name AS email_from_name,
                from_email AS email_from_email,

                IFNULL(content.val,nl_email.subject) AS email_subject,

		tpl AS email_tpl,
		body AS email_body,
		header AS email_header,

                          (SELECT     COUNT(*)
                            FROM          nl_email_group
                            WHERE      nl_email_id = nl_email.id) AS group_count,
                          (SELECT     COUNT(*)
                            FROM          nl_subscriber
                            WHERE      nl_subscriber.nl_group_id IN
                                                       (SELECT     nl_group_id
                                                         FROM          nl_email_group
                                                         WHERE      nl_email_id = nl_email.id)) AS subscr_count, CASE WHEN
                          (SELECT     COUNT(*)
                            FROM          nl_email_group
                            WHERE      nl_email_id = nl_email.id) = 0 THEN 'draft' ELSE CASE WHEN
                          (SELECT     ms_status_id
                            FROM          ms_mail
                            WHERE      id = nl_email.transaction_id) = 3 THEN 'sent' ELSE CASE WHEN
                          (SELECT     ms_status_id
                            FROM          ms_mail
                            WHERE      id = nl_email.transaction_id) = 6 THEN 'archive' ELSE 'outbox' END END END AS email_status, transaction_id AS email_transaction_id,
			  (CASE WHEN 
				finish_date = null 
			   THEN 
				(select date_format(DATE_ADD(date_format(now(), '%Y-%m-%d'),INTERVAL (select val from config where var = 'default_active_period') DAY), '%d-%m-%Y'))
			   ELSE finish_date 
			   END) AS finish_date,
			   ip_address,
			   create_date
     FROM
          nl_email
LEFT JOIN

(
                 content
      INNER JOIN
                 language
              ON
                 content.language = language.language_code
             AND language.default_language = 1
)
       ON
          nl_email.id=content.var_id
      AND content.var = 'news_letter_subject_'


;



DROP VIEW IF EXISTS v_news_letters_grid;

CREATE VIEW v_news_letters_grid AS


	SELECT id, email_from_name AS from_name, email_from_email AS from_email, email_subject AS subject, email_status AS status, date_format(finish_date,'%d-%m-%Y') AS 'Finish Date', ip_address, create_date
	
	FROM         v_news_letters_edit;DROP VIEW IF EXISTS v_nl_email;
CREATE VIEW
		v_nl_email
AS
	SELECT     id AS email_id, from_name AS email_from_name, from_email AS email_from_email, subject AS email_subject, tpl AS email_tpl, body AS email_body,
                      header AS email_header,
                          (SELECT     COUNT(*)
                            FROM          nl_email_group
                            WHERE      nl_email_id = nl_email.id) AS group_count,
                          (SELECT     COUNT(*)
                            FROM          nl_subscriber
                            WHERE      nl_subscriber.nl_group_id IN
                                                       (SELECT     nl_group_id
                                                         FROM          nl_email_group
                                                         WHERE      nl_email_id = nl_email.id)) AS subscr_count, CASE WHEN
                          (SELECT     COUNT(*)
                            FROM          nl_email_group
                            WHERE      nl_email_id = nl_email.id) = 0 THEN 'draft' ELSE CASE WHEN
                          (SELECT     ms_status_id
                            FROM          ms_mail
                            WHERE      id = nl_email.transaction_id) = 3 THEN 'sent' ELSE 'outbox' END END AS email_status, transaction_id AS email_transaction_id,
			  (CASE WHEN 
				finish_date = null 
			   THEN 
				(select date_format(DATE_ADD(date_format(now(), '%Y-%m-%d'),INTERVAL (select val from config where var = 'default_active_period') DAY), '%d-%m-%Y'))
			   ELSE finish_date 
			   END) AS finish_date,
			   ip_address,
			   create_date

FROM         nl_email;
DROP VIEW IF EXISTS v_nl_email_edit;

CREATE VIEW v_nl_email_edit AS SELECT * FROM v_nl_email;



DROP VIEW IF EXISTS v_nl_email_grid;

CREATE VIEW v_nl_email_grid AS


	SELECT email_id, email_from_name, email_from_email, email_subject, email_header, email_status, finish_date, ip_address, create_date

	FROM v_nl_email;
DROP VIEW IF EXISTS v_nl_group;

CREATE VIEW
		v_nl_group
AS

SELECT     id, group_name, show_on_front,
                          (SELECT     COUNT(*)
                            FROM      nl_email_group
                            WHERE     nl_email_group.nl_group_id = nl_group.id) AS letters_count,
                          (SELECT     COUNT(*)
                            FROM      nl_subscriber
                            WHERE     nl_subscriber.nl_group_id = nl_group.id AND nl_subscriber.status IN (1,3) ) AS subscr_count
FROM         nl_group;
DROP VIEW IF EXISTS v_nl_groups_edit;

CREATE VIEW
		v_nl_groups_edit
AS

SELECT     id, group_name, show_on_front

FROM         nl_group;
DROP VIEW IF EXISTS v_nl_groups_grid;

CREATE VIEW v_nl_groups_grid AS

SELECT  * FROM v_nl_group;
DROP VIEW IF EXISTS v_nl_notification;

CREATE VIEW
	v_nl_notification
AS

SELECT p.*, 
	(SELECT val FROM content WHERE var='nl_notification_subject' AND page_id=p.id AND language = (SELECT language_code FROM language WHERE default_language=1) LIMIT 1) as subject,
	(SELECT val FROM content WHERE var='nl_notification_from_email' AND page_id=p.id LIMIT 1) as from_email
  FROM tpl_pages as p
  LEFT JOIN tpl_files as f on p.tpl_id = f.id
	WHERE f.type = '2';DROP VIEW IF EXISTS v_nl_notification_edit;

CREATE VIEW
	v_nl_notification_edit
AS

SELECT id, page_name as notification_type, from_email FROM v_nl_notification;DROP VIEW IF EXISTS v_nl_notification_grid;

CREATE VIEW
	v_nl_notification_grid
AS

SELECT id, page_name as notification_type, subject, from_email FROM v_nl_notification;DROP VIEW IF EXISTS v_nl_subscriber;

CREATE VIEW
	v_nl_subscriber
AS

SELECT nl_subscriber.id, 
	nl_subscriber.email, 
	nl_subscriber.nl_group_id, 
	nl_subscriber.reg_date, 
		(SELECT 	max(date_update) 
		   FROM 	v_ms_recipient v 
		  WHERE 	status = 'sent'  
		    AND 	recipient_id = nl_subscriber.id) as last_send,
	nl_subscriber.ip_address,
	nl_subscriber_status.status as subscriber_status, 
	nl_subscriber.confirm_code as confirm_code, 
	nl_subscriber.status as status,
	nl_subscriber.company as company,
nl_subscriber.first_name,nl_subscriber.sur_name,
	nl_subscriber.city as city,
                          (SELECT     group_name
                            FROM      nl_group
                            WHERE     id = nl_subscriber.nl_group_id) AS group_name,
	nl_subscriber.language,	
                          (SELECT     COUNT(*)
                            FROM      nl_email_group
                            WHERE     nl_email_group.nl_group_id = nl_subscriber.nl_group_id) AS letters_count


FROM nl_subscriber LEFT JOIN nl_subscriber_status ON nl_subscriber.status = nl_subscriber_status.id;
DROP VIEW IF EXISTS v_nl_subscribers_edit;

CREATE VIEW
	v_nl_subscribers_edit
AS

SELECT id, email, group_name, subscriber_status as status, company, first_name, sur_name, city, language, ip_address FROM v_nl_subscriber;
DROP VIEW IF EXISTS v_nl_subscribers_grid;

CREATE VIEW
	v_nl_subscribers_grid
AS

SELECT id, email, subscriber_status as status, company, first_name, sur_name, city, group_name, language, reg_date, last_send, ip_address FROM v_nl_subscriber;
DROP VIEW IF EXISTS v_object;

CREATE VIEW v_object AS SELECT * FROM object;

DROP VIEW IF EXISTS v_object_content;

CREATE VIEW v_object_content AS SELECT * FROM object_content;

DROP VIEW IF EXISTS v_object_content_edit;

CREATE VIEW v_object_content_edit AS SELECT * FROM object_content;

DROP VIEW IF EXISTS v_object_content_grid;

CREATE VIEW v_object_content_grid
AS
	 SELECT object_content.*,
		object.name as object_name,
		object_field.object_field_name
		
	   FROM object_content
     INNER JOIN object_field
	     ON object_content.object_field_id = object_field.id
     INNER JOIN object
	     ON object_field.object_id = object.id
 ORDER BY object_record_id;

DROP VIEW IF EXISTS v_object_edit;

CREATE VIEW v_object_edit AS SELECT * FROM object;

DROP VIEW IF EXISTS v_object_field;

CREATE VIEW v_object_field AS SELECT * FROM object_field;

DROP VIEW IF EXISTS v_object_field_edit;

CREATE VIEW v_object_field_edit AS SELECT * FROM object_field;

DROP VIEW IF EXISTS v_object_field_grid;

CREATE VIEW v_object_field_grid AS SELECT f.id,
     (SELECT name FROM object o WHERE o.id=f.object_id) AS 'object',
     f.object_field_name, 
     f.object_field_type,
     f.one_for_all_languages      
      FROM object_field f;
DROP VIEW IF EXISTS v_object_field_type;

CREATE VIEW v_object_field_type AS SELECT * FROM object_field_type;

DROP VIEW IF EXISTS v_object_field_type_edit;

CREATE VIEW v_object_field_type_edit AS SELECT * FROM v_object_field_type;

DROP VIEW IF EXISTS v_object_field_type_grid;

CREATE VIEW v_object_field_type_grid
AS

SELECT
	id,

	object_field_type,

	CASE one_for_all_languages
	WHEN 1 THEN 'YES'
	ELSE ''
	END AS one_for_all_languages
FROM
	v_object_field_type;
DROP VIEW IF EXISTS v_object_grid;

CREATE VIEW v_object_grid AS SELECT * FROM object;

DROP VIEW IF EXISTS v_object_record;

CREATE VIEW v_object_record AS SELECT * FROM object_record;

DROP VIEW IF EXISTS v_object_record_edit;

CREATE VIEW v_object_record_edit AS SELECT id, object_id FROM object_record;

DROP VIEW IF EXISTS v_object_record_grid;

CREATE VIEW v_object_record_grid
AS
	 SELECT object_record.id,
		object_record.object_id,
		object_record.user_name,
		object_record.last_update,
		object.name

	   FROM object_record
     INNER JOIN object
	     ON object_record.object_id = object.id

	  ORDER BY object_record.id;

DROP VIEW IF EXISTS `v_object_template`;
CREATE VIEW `v_object_template` AS
	 SELECT *
	   FROM `object_template`
	;
DROP VIEW IF EXISTS `v_object_template_edit`;
CREATE VIEW `v_object_template_edit` AS
	 SELECT *
	   FROM `v_object_template`
	;
DROP VIEW IF EXISTS `v_object_template_grid`;
CREATE VIEW `v_object_template_grid` AS
	SELECT
		v_object_template.id	AS id,
		v_object.name		AS object_name,
		tpl_files.file_name	AS template_name
	FROM
		v_object_template
			INNER JOIN v_object 
			ON v_object.id=v_object_template.object_id
				INNER JOIN tpl_files 
				ON tpl_files.id=v_object_template.template_id
	;


DROP VIEW IF EXISTS v_permanent_redirect_edit;

CREATE VIEW v_permanent_redirect_edit AS
	SELECT
	id,
	source_url,
	target_url,
	'' as url,
	page_id,
	lang_code,
	t_view
	FROM permanent_redirect;

DROP VIEW IF EXISTS v_permanent_redirect_grid;

CREATE VIEW v_permanent_redirect_grid AS
	SELECT * FROM permanent_redirect;



DROP VIEW IF EXISTS v_search_tpl_pages;


CREATE VIEW

           v_search_tpl_pages
AS

    SELECT
           tpl_pages.*,
           language.language_code
      FROM

           (

           tpl_pages
INNER JOIN tpl_files
        ON tpl_pages.tpl_id = tpl_files.id

           ),
           v_language AS language

     WHERE
           tpl_pages.for_search = '1'
       AND tpl_files.type = 0
;
DROP VIEW IF EXISTS v_styles_edit;

CREATE VIEW v_styles_edit AS

	 SELECT id,
		element,
		class,
		title,
		declaration
	   FROM styles
	;

DROP VIEW IF EXISTS v_styles_grid;

CREATE VIEW v_styles_grid AS

	 SELECT id,
		element,
		class,
		title,
		declaration as sample_text		
	   FROM styles
	;

DROP VIEW IF EXISTS v_tpl_file;

CREATE VIEW v_tpl_file AS

SELECT 	id,
	file_name,
	description,
	cachable
 FROM 
	tpl_files
WHERE 
	tpl_files.type = '0';
DROP VIEW IF EXISTS v_tpl_file_edit;

CREATE VIEW v_tpl_file_edit AS

SELECT * FROM v_tpl_file;
DROP VIEW IF EXISTS v_tpl_file_grid;

CREATE VIEW v_tpl_file_grid AS

SELECT 	id,
	file_name,
	description,

	CASE cachable
	WHEN '1'
	THEN 'Yes'
	ELSE 'No'
	END AS cachable

  FROM
	v_tpl_file;DROP VIEW IF EXISTS v_tpl_folder_content;
CREATE VIEW v_tpl_folder_content AS
SELECT
  v_tpl_folder.id,
  IF(regular_content.val IS NULL,
    IF(default_content.val IS NULL,
      v_tpl_folder.page_name,
      default_content.val
    ),
    regular_content.val
  ) AS page_name,
  v_tpl_folder.page_description,
  v_tpl_folder.default_page,
  v_tpl_folder.create_date,
  v_tpl_folder.edit_date,
  v_tpl_folder.folder_id,
  v_tpl_folder.for_search,
  v_tpl_folder.owner_name,
  v_tpl_folder.is_locked,
  language.language_code as language
FROM
   (v_tpl_folder, v_language AS language)
LEFT JOIN content regular_content ON
      v_tpl_folder.id = regular_content.var_id AND
      regular_content.var = 'page_name_' AND
      regular_content.language = language.language_code
LEFT JOIN content default_content ON
      v_tpl_folder.id = default_content.var_id AND
      default_content.var = 'page_name_' AND
      default_content.language = (SELECT language_code FROM language WHERE default_language = 1);
DROP VIEW IF EXISTS v_tpl_folder_edit;

CREATE VIEW v_tpl_folder_edit AS
   SELECT
     id,page_name, page_description, create_date, edit_date, folder_id, for_search, owner_name, is_locked,
	group_access,
	'' as folder_groups
     FROM tpl_pages
     WHERE tpl_id IS NULL
;
DROP VIEW IF EXISTS v_tpl_folder_grid;
CREATE VIEW v_tpl_folder_grid AS
SELECT
    v_tpl_folder.id,
    CONCAT('/', v_tpl_path_content.folder) AS folder,
    v_tpl_folder.page_description AS folder_description,
    v_tpl_folder.is_locked,
    v_tpl_folder.owner_name,
    (SELECT count(t.id)
       FROM tpl_pages t
      WHERE t.folder_id = v_tpl_folder.id
    ) AS items_count,
    v_tpl_path_content.language
FROM v_tpl_folder
LEFT JOIN v_tpl_path_content ON v_tpl_folder.id = v_tpl_path_content.id

;
DROP VIEW IF EXISTS v_tpl_non_folder_content;
CREATE VIEW v_tpl_non_folder_content AS
SELECT
  v_tpl_non_folder.id,
  IF(regular_content.val IS NULL,
    IF(default_content.val IS NULL,
      v_tpl_non_folder.page_name,
      default_content.val
    ),
    regular_content.val
  ) AS page_name,
  v_tpl_non_folder.page_description,
  v_tpl_non_folder.default_page,
  v_tpl_non_folder.create_date,
  v_tpl_non_folder.edit_date,
  v_tpl_non_folder.tpl_id,
  v_tpl_non_folder.folder_id,
  v_tpl_non_folder.for_search,
  v_tpl_non_folder.owner_name,
  v_tpl_non_folder.is_locked,
  v_tpl_non_folder.type,
  v_tpl_non_folder.file_name,
  language.language_code as language,
  v_tpl_non_folder.priority
FROM
   (v_tpl_non_folder, v_language AS language)
LEFT JOIN content regular_content ON
      v_tpl_non_folder.id = regular_content.var_id AND
      regular_content.var = 'page_name_' AND
      regular_content.language = language.language_code
LEFT JOIN content default_content ON
      v_tpl_non_folder.id = default_content.var_id AND
      default_content.var = 'page_name_' AND
      default_content.language = (SELECT language_code FROM language WHERE default_language = 1)
 ;
 DROP VIEW IF EXISTS v_tpl_non_folder_without_stat;

CREATE VIEW
              v_tpl_non_folder_without_stat
AS 
       SELECT
              tpl_pages.id,
              tpl_files.type,
              tpl_files.file_name,
              tpl_pages.page_description,
              tpl_pages.group_access,
              content.var,
              content.var_id,
              content.val,
              content.language,
              language.default_language
         FROM
              content
    LEFT JOIN tpl_pages
           ON var_id = tpl_pages.id

   INNER JOIN tpl_files
           ON tpl_pages.tpl_id = tpl_files.id

    LEFT JOIN v_language AS language
           ON content.language = language.language_code

        WHERE
              content.var = "folder_path_"
           OR content.var = "page_name_"
;


DROP VIEW IF EXISTS v_tpl_page;
CREATE VIEW v_tpl_page AS
SELECT
  *
FROM
  v_tpl_non_folder
WHERE
  type = 0
;DROP VIEW IF EXISTS v_tpl_page_detail;
CREATE VIEW v_tpl_page_detail AS
SELECT
		*
  FROM v_tpl_page
;

DROP VIEW IF EXISTS v_tpl_page_edit;

CREATE VIEW v_tpl_page_edit AS

	 SELECT id,
		page_name,
		extension,
		page_description,
		default_page AS is_default,
		tpl_id AS template,
		folder_id AS folder,
		for_search AS search,
		is_locked AS page_locked,
		cachable
		
	   FROM v_tpl_page
	;

DROP VIEW IF EXISTS v_tpl_page_folder;
CREATE VIEW v_tpl_page_folder AS
SELECT 
	p.id,
	(IF(p.folder_id IS NOT NULL AND p.folder_id<>0,CONCAT(f.page_name," / ",p.page_name),p.page_name)) as page_name,
	p.page_description,
	p.default_page,
	p.create_date,
	p.edit_date,
	p.tpl_id,
	p.folder_id,
	p.for_search
  FROM v_tpl_page p
  LEFT JOIN v_tpl_folder f on p.folder_id = f.id;
DROP VIEW IF EXISTS v_tpl_page_not_locked;

CREATE VIEW v_tpl_page_not_locked AS

SELECT * FROM v_tpl_page WHERE is_locked = 0;

DROP VIEW IF EXISTS v_tpl_views;
CREATE VIEW v_tpl_views AS SELECT * FROM tpl_views;

DROP VIEW IF EXISTS v_tpl_views_edit;
CREATE VIEW v_tpl_views_edit AS SELECT * FROM tpl_views;

DROP VIEW IF EXISTS v_tpl_views_grid;
CREATE VIEW v_tpl_views_grid
AS
SELECT 
    id,
    view_name,
    view_folder,
    description,
    icon,
    is_default,

    CASE is_default
    WHEN 1 THEN 'Yes'
    ELSE '' END AS default_view

 FROM tpl_views;

DROP VIEW IF EXISTS v_user;

CREATE VIEW v_user AS

	 SELECT *
	   FROM users
	;

DROP VIEW IF EXISTS v_user_edit;

CREATE VIEW v_user_edit AS

	 SELECT id, name, login,
		email, status, comment, icq, city, 
		'' as change_password,
		'' as old_password,
		'' as new_password,
		'' as confirm_new_password,
		'' as currently,
		ip,
		browser,
		DATE_FORMAT(login_datetime, '%d-%m-%Y %H:%i') as last_login,
		month_visits,
		'' as user_groups,
		role,
		content_access
	   FROM users
	;

DROP VIEW IF EXISTS v_user_grid;

CREATE VIEW v_user_grid AS

	 SELECT id, name, login, email,
		CASE status
			WHEN 0 THEN 'Disabled'
			WHEN 1 THEN 'Enabled'
		END AS status,
		role,
		(SELECT role_name FROM role WHERE id=users.role) AS role_name,
		(	SELECT 
				GROUP_CONCAT(user_groups.group_name SEPARATOR ', ')
			FROM 
				user_group
			LEFT JOIN 
				user_groups ON user_groups.id=user_group.group_id
			WHERE 
				user_group.user_id=users.id 
			GROUP BY 
				user_group.user_id
		) AS groups
	   FROM users
	;


DROP VIEW IF EXISTS v_user_groups;

CREATE VIEW v_user_groups AS SELECT * FROM user_groups;

DROP VIEW IF EXISTS v_user_groups_edit;

CREATE VIEW v_user_groups_edit AS

	 SELECT *
	   FROM user_groups
	;DROP VIEW IF EXISTS v_user_groups_grid;

CREATE VIEW v_user_groups_grid AS

	 SELECT *
	   FROM user_groups
	;DROP VIEW IF EXISTS v_user_profile;

CREATE VIEW v_user_profile AS

	 SELECT id, name, email,
		'' as change_password,
		'' as old_password,
		'' as new_password,
		'' as confirm_new_password
	   FROM users
	;

