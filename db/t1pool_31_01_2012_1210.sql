-- MySQL dump 10.11
--
-- Host: localhost    Database: t1pool
-- ------------------------------------------------------
-- Server version	5.0.88

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_mode`
--

DROP TABLE IF EXISTS `access_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_mode` (
  `id` int(11) NOT NULL,
  `access_mode_name` varchar(250) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_mode`
--

LOCK TABLES `access_mode` WRITE;
/*!40000 ALTER TABLE `access_mode` DISABLE KEYS */;
INSERT INTO `access_mode` VALUES (1,'Everyone has an access'),(2,'Only listed groups has an access');
/*!40000 ALTER TABLE `access_mode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `var` varchar(50) NOT NULL default '',
  `val` text,
  `description` varchar(150) default NULL,
  `sortOrder` int(11) default '0',
  `lang_code` char(2) NOT NULL default '',
  PRIMARY KEY  (`var`,`lang_code`),
  KEY `config_language_code_idx` (`lang_code`),
  CONSTRAINT `config_ibfk_1` FOREIGN KEY (`lang_code`) REFERENCES `language` (`language_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES ('abesent_browser_lang_aforward_target_url','a:2:{s:4:\"link\";s:21:\"test1.tns.2kgroup.com\";s:9:\"link_type\";s:3:\"url\";}','',0,''),('absent_browser_language_autoforwarding','1','',0,''),('alias_rule','<%:language%>/<%:page_folder%>/<%:page_name%>.<%:page_type%>','System alias creation rule',11,''),('alias_rule_example','<%:language%>/<%:page_folder%>/<%:page_name%>.<%:page_type%>','Example of system alias creation rule',11,''),('antispam_security','1','',0,''),('change_frequency','weekly','',0,''),('default_active_period','5','default_active_period',0,''),('ee_cache_html','','',0,''),('error_handle','a:3:{i:1;a:13:{i:8;s:1:\"1\";i:1024;s:1:\"1\";i:2048;s:1:\"1\";i:2;s:1:\"1\";i:32;s:1:\"1\";i:128;s:1:\"1\";i:512;s:1:\"1\";i:1;s:1:\"1\";i:4;s:1:\"1\";i:16;s:1:\"1\";i:64;s:1:\"1\";i:256;s:1:\"1\";i:4096;s:1:\"1\";}i:2;a:13:{i:8;s:1:\"0\";i:1024;s:1:\"0\";i:2048;s:1:\"0\";i:2;s:1:\"1\";i:32;s:1:\"1\";i:128;s:1:\"1\";i:512;s:1:\"1\";i:1;s:1:\"1\";i:4;s:1:\"1\";i:16;s:1:\"1\";i:64;s:1:\"1\";i:256;s:1:\"1\";i:4096;s:1:\"1\";}i:3;a:13:{i:8;s:1:\"0\";i:1024;s:1:\"0\";i:2048;s:1:\"0\";i:2;s:1:\"0\";i:32;s:1:\"0\";i:128;s:1:\"0\";i:512;s:1:\"0\";i:1;s:1:\"0\";i:4;s:1:\"0\";i:16;s:1:\"0\";i:64;s:1:\"0\";i:256;s:1:\"0\";i:4096;s:1:\"0\";}}','',0,''),('error_pages','a:25:{i:400;a:4:{s:2:\"id\";i:400;s:11:\"description\";s:11:\"Bad Request\";s:9:\"page_type\";i:2;s:5:\"value\";s:23:\"Error 400 - Bad Request\";}i:401;a:4:{s:2:\"id\";i:401;s:11:\"description\";s:12:\"Unauthorized\";s:9:\"page_type\";i:2;s:5:\"value\";s:24:\"Error 401 - Unauthorized\";}i:402;a:4:{s:2:\"id\";i:402;s:11:\"description\";s:16:\"Payment Required\";s:9:\"page_type\";i:2;s:5:\"value\";s:28:\"Error 402 - Payment Required\";}i:403;a:4:{s:2:\"id\";s:3:\"403\";s:11:\"description\";s:9:\"Forbidden\";s:9:\"page_type\";s:1:\"0\";s:5:\"value\";s:2:\"67\";}i:404;a:4:{s:2:\"id\";s:3:\"404\";s:11:\"description\";s:9:\"Not Found\";s:9:\"page_type\";s:1:\"0\";s:5:\"value\";s:2:\"63\";}i:405;a:4:{s:2:\"id\";i:405;s:11:\"description\";s:18:\"Method Not Allowed\";s:9:\"page_type\";i:2;s:5:\"value\";s:30:\"Error 405 - Method Not Allowed\";}i:406;a:4:{s:2:\"id\";i:406;s:11:\"description\";s:14:\"Not Acceptable\";s:9:\"page_type\";i:2;s:5:\"value\";s:26:\"Error 406 - Not Acceptable\";}i:407;a:4:{s:2:\"id\";i:407;s:11:\"description\";s:29:\"Proxy Authentication Required\";s:9:\"page_type\";i:2;s:5:\"value\";s:41:\"Error 407 - Proxy Authentication Required\";}i:408;a:4:{s:2:\"id\";i:408;s:11:\"description\";s:15:\"Request Timeout\";s:9:\"page_type\";i:2;s:5:\"value\";s:27:\"Error 408 - Request Timeout\";}i:409;a:4:{s:2:\"id\";i:409;s:11:\"description\";s:8:\"Conflict\";s:9:\"page_type\";i:2;s:5:\"value\";s:20:\"Error 409 - Conflict\";}i:410;a:4:{s:2:\"id\";i:410;s:11:\"description\";s:4:\"Gone\";s:9:\"page_type\";i:2;s:5:\"value\";s:16:\"Error 410 - Gone\";}i:411;a:4:{s:2:\"id\";i:411;s:11:\"description\";s:15:\"Length Required\";s:9:\"page_type\";i:2;s:5:\"value\";s:27:\"Error 411 - Length Required\";}i:412;a:4:{s:2:\"id\";i:412;s:11:\"description\";s:19:\"Precondition Failed\";s:9:\"page_type\";i:2;s:5:\"value\";s:31:\"Error 412 - Precondition Failed\";}i:413;a:4:{s:2:\"id\";i:413;s:11:\"description\";s:24:\"Request Entity Too Large\";s:9:\"page_type\";i:2;s:5:\"value\";s:36:\"Error 413 - Request Entity Too Large\";}i:414;a:4:{s:2:\"id\";i:414;s:11:\"description\";s:20:\"Request-URI Too Long\";s:9:\"page_type\";i:2;s:5:\"value\";s:32:\"Error 414 - Request-URI Too Long\";}i:415;a:4:{s:2:\"id\";i:415;s:11:\"description\";s:22:\"Unsupported Media Type\";s:9:\"page_type\";i:2;s:5:\"value\";s:34:\"Error 415 - Unsupported Media Type\";}i:416;a:4:{s:2:\"id\";i:416;s:11:\"description\";s:31:\"Requested Range Not Satisfiable\";s:9:\"page_type\";i:2;s:5:\"value\";s:43:\"Error 416 - Requested Range Not Satisfiable\";}i:417;a:4:{s:2:\"id\";i:417;s:11:\"description\";s:18:\"Expectation Failed\";s:9:\"page_type\";i:2;s:5:\"value\";s:30:\"Error 417 - Expectation Failed\";}i:500;a:4:{s:2:\"id\";i:500;s:11:\"description\";s:21:\"Internal Server Error\";s:9:\"page_type\";i:2;s:5:\"value\";s:33:\"Error 500 - Internal Server Error\";}i:501;a:4:{s:2:\"id\";i:501;s:11:\"description\";s:15:\"Not Implemented\";s:9:\"page_type\";i:2;s:5:\"value\";s:27:\"Error 501 - Not Implemented\";}i:502;a:4:{s:2:\"id\";i:502;s:11:\"description\";s:11:\"Bad Gateway\";s:9:\"page_type\";i:2;s:5:\"value\";s:23:\"Error 502 - Bad Gateway\";}i:503;a:4:{s:2:\"id\";i:503;s:11:\"description\";s:19:\"Service Unavailable\";s:9:\"page_type\";i:2;s:5:\"value\";s:31:\"Error 503 - Service Unavailable\";}i:504;a:4:{s:2:\"id\";i:504;s:11:\"description\";s:15:\"Gateway Timeout\";s:9:\"page_type\";i:2;s:5:\"value\";s:27:\"Error 504 - Gateway Timeout\";}i:505;a:4:{s:2:\"id\";i:505;s:11:\"description\";s:26:\"HTTP Version Not Supported\";s:9:\"page_type\";i:2;s:5:\"value\";s:38:\"Error 505 - HTTP Version Not Supported\";}i:600;a:4:{s:2:\"id\";i:600;s:11:\"description\";s:23:\"Check if DNS is enabled\";s:9:\"page_type\";i:2;s:5:\"value\";s:35:\"Error 600 - Check if DNS is enabled\";}}',NULL,0,''),('google_analytics','<script type=\"text/javascript\">\r\nvar gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");\r\ndocument.write(unescape(\"%3Cscript src=\'\" + gaJsHost + \"google-analytics.com/ga.js\' type=\'text/javascript\'%3E%3C/script%3E\"));\r\n</script>\r\n<script type=\"text/javascript\">\r\ntry {\r\nvar pageTracker = _gat._getTracker(\"UA-12923004-1\");\r\npageTracker._trackPageview();\r\n} catch(err) {}</script>','Google Analytics Code',30,''),('language_autoforwarding','','',0,''),('live','180002','Activity Timeout',1,''),('logfile_maxsize','2097152','Maximal size of log file in bytes',51,''),('logfile_stop_reset','0','What to do if log file size reache logfile_maxsize (Stop loging/Reset file)',52,''),('login_expiration_period','60','',0,''),('mail_character_set','iso-8859-1','mail_character_set',0,''),('MAX_CHARS','200','Max chars in short description',3,''),('MAX_ROWS_IN_ADMIN','20','Max rows in admin',4,''),('object_alias_rule','<%:language%>/<%:object_folder%>/<%:object_name%>/<%:object_view%>/<%:object_id%>.html','object alias rule',0,''),('object_alias_rule_example','<%:language%>/<%:object_folder%>/<%:object_name%>/<%:object_view%>/<%:object_id%>.html','object alias rule',0,''),('object_folder','object','object identificator',0,''),('pass_contain_letters','1','password must contain letters from a-zA-Z',0,''),('pass_contain_letters_with_diff_case','1','password must contains letters with different case',0,''),('pass_contain_numbers','','password must contain numbers from 0-9',0,''),('pass_min_8_symbol','1','password must be minimal 8 characters',0,''),('pass_not_have_login_inside','1','password must not have login inside password (even if typed in different case)',0,''),('search_enable_search_for_website','1','',0,''),('search_exclude_html_tags','1','',0,''),('search_max_chars_page_content','100','',0,''),('search_max_chars_page_keywords','100','',0,''),('search_max_chars_page_name','100','',0,''),('search_max_chars_page_url','100','',0,''),('search_media_library','1','',0,''),('search_minimal_characters_to_search','3','',0,''),('search_page_content','1','',0,''),('search_page_keywords','1','',0,''),('search_page_name','1','',0,''),('search_page_title','1','',0,''),('search_rate_media_library','1','',0,''),('search_rate_page_content','1','',0,''),('search_rate_page_keywords','5','',0,''),('search_rate_page_name','15','',0,''),('search_rate_page_title','10','',0,''),('search_rate_user_content','0','',0,''),('search_show_page_content','1','',0,''),('search_show_page_keywords','1','',0,''),('search_show_page_name','1','',0,''),('search_show_page_url','1','',0,''),('search_user_content','0','',0,''),('SMTP_host','localhost','SMTP_host',0,''),('s_copyright','... n.v.','Site Copyright',10,''),('use_draft_content','','Use draft/publish content mode',20,''),('warnings_notices_max_count','5','Limit number of warnings/notices to be sent',41,''),('warnings_notices_max_period','10','Number of time periods',42,''),('warnings_notices_max_period_type','minute','Type of time period (second/minute/quarter/hour/day)',43,'');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `page_id` int(11) NOT NULL default '0',
  `var` varchar(50) NOT NULL default '',
  `var_id` int(11) unsigned NOT NULL default '0',
  `val` text,
  `short_desc` varchar(100) default NULL,
  `full_desc` varchar(255) default NULL,
  `language` char(2) NOT NULL default '',
  `edit_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `val_draft` text,
  `edit_date_draft` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`page_id`,`var`,`var_id`,`language`),
  KEY `page_id_idx` (`page_id`),
  KEY `content_var_idx` (`var`),
  KEY `content_var_id_idx` (`var_id`),
  KEY `content_language_idx` (`language`),
  KEY `content_edit_date_idx` (`edit_date`),
  KEY `content_edit_date_draft_idx` (`edit_date_draft`),
  CONSTRAINT `content_ibfk_1` FOREIGN KEY (`language`) REFERENCES `language` (`language_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (0,'',0,NULL,'',NULL,'UA','2011-01-10 11:48:53',NULL,'2011-01-10 11:48:53'),(0,'ADDRESS',0,'Адрес проживания','ADDRESS','','RU','2010-04-12 14:40:24','Адрес проживания','2010-04-12 14:40:24'),(0,'ADDRESS',0,'Адреса проживання','ADDRESS',NULL,'UA','2010-04-02 08:25:12','Адреса проживання','2010-04-02 08:25:12'),(0,'at_least_one_group',0,'At least one group should be selected','at_least_one_group',NULL,'EN','2009-11-14 21:07:33','At least one group should be selected','2009-11-14 21:07:33'),(0,'AUTHORIZATION',0,NULL,'AUTHORIZATION','','EN','2010-06-21 07:00:46',NULL,'2010-06-21 07:00:46'),(0,'AUTHORIZATION',0,'Конвертировать','AUTHORIZATION','','RU','2010-06-21 07:01:04','Конвертировать','2010-06-21 07:01:04'),(0,'AUTHORIZATION',0,'Авторизація','AUTHORIZATION','','UA','2010-07-01 23:55:21','Авторизація','2010-07-01 23:55:21'),(0,'AUTHORIZATION_FORM',0,'Форма авторизації','AUTHORIZATION_FORM',NULL,'UA','2010-04-02 08:35:29','Форма авторизації','2010-04-02 08:35:29'),(0,'A_NEWS',0,'Новина','A_NEWS',NULL,'UA','2010-04-14 06:13:29','Новина','2010-04-14 06:13:29'),(0,'BIRTHDAY',0,'Дата рождения*','BIRTHDAY','','RU','2010-07-02 09:55:40','Дата рождения*','2010-07-02 09:55:40'),(0,'BIRTHDAY',0,'Дата народження*','BIRTHDAY','','UA','2010-08-26 11:35:07','Дата народження*','2010-08-26 11:35:07'),(0,'CELLULAR_PHONE',0,'Мобильный телефон** (ХХХххххххх)','CELLULAR_PHONE','','RU','2011-06-24 09:57:21','Мобильный телефон** (ХХХххххххх)','2011-06-24 09:57:21'),(0,'CELLULAR_PHONE',0,'Мобільний телефон** (ХХХххххххх)','CELLULAR_PHONE','','UA','2011-06-24 09:57:18','Мобільний телефон** (ХХХххххххх)','2011-06-24 09:57:18'),(0,'CITY',0,'Город*','CITY','','RU','2010-07-02 09:56:10','Город*','2010-07-02 09:56:10'),(0,'CITY',0,'Місто*','CITY','','UA','2010-07-02 09:56:08','Місто*','2010-07-02 09:56:08'),(0,'CITY_PHONE',0,'Домашний телефон**','CITY_PHONE','','RU','2010-07-02 10:06:37','Домашний телефон**','2010-07-02 10:06:37'),(0,'CITY_PHONE',0,'Міський телефон**','CITY_PHONE','','UA','2010-07-02 10:06:35','Міський телефон**','2010-07-02 10:06:35'),(0,'COMPLETE_TYPE',0,'Complete type','COMPLETE_TYPE',NULL,'UA','2010-04-02 08:23:55','Complete type','2010-04-02 08:23:55'),(0,'CONFIRM_PASSWORD',0,'Подтвердите пароль','CONFIRM_PASSWORD','','RU','2010-04-15 14:00:03','Подтвердите пароль','2010-04-15 14:00:03'),(0,'CONFIRM_PASSWORD',0,'Пiдтвердити пароль','CONFIRM_PASSWORD',NULL,'UA','2010-04-03 08:32:08','Пiдтвердити пароль','2010-04-03 08:32:08'),(0,'contact_block_content',0,NULL,'contact_block_content',NULL,'EN','2010-01-29 17:43:06',NULL,'2010-01-29 17:43:06'),(0,'contact_block_content',0,'<p><img width=\"50\" vspace=\"4\" height=\"50\" align=\"left\" alt=\"\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"pink_15_lm\">ПІБ</p>\r\n<p class=\"content_simple_text_lm\">адреса</p>\r\n<p class=\"content_simple_text_lm\">телефон</p>\r\n<p><a href=\"mailto:viktor.bozhko@tns-ua.com?subject=Question\" class=\"system_button2\">Надіслати повідомлення</a></p>','contact_block_content','','UA','2010-01-29 17:45:54','<p><img width=\"50\" vspace=\"4\" height=\"50\" align=\"left\" alt=\"\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"pink_15_lm\">ПІБ</p>\r\n<p class=\"content_simple_text_lm\">адреса</p>\r\n<p class=\"content_simple_text_lm\">телефон</p>\r\n<p><a href=\"mailto:viktor.bozhko@tns-ua.com?subject=Question\" class=\"system_button2\">Надіслати повідомлення</a></p>','2010-01-29 17:45:54'),(0,'content_no_template',0,'content_no_template',NULL,NULL,'EN','2010-03-20 06:30:00','content_no_template','2009-11-14 21:07:33'),(0,'CONVERTION',0,'Конвертувати','CONVERTION','','UA','2010-07-01 23:54:13','Конвертувати','2010-07-01 23:54:13'),(0,'current_projects_block_content',0,'<p><img height=\"50\" align=\"left\" width=\"50\" vspace=\"4\" alt=\"\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"content_simple_text_lm\">В разделе размещен список текущих исследований. Вы можете принять участие в любом из них.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=45&amp;language=UA\">Перейти к разделу</a></p>','current_projects_block_content','','RU','2010-04-15 14:11:12','<p><img height=\"50\" align=\"left\" width=\"50\" vspace=\"4\" alt=\"\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"content_simple_text_lm\">В разделе размещен список текущих исследований. Вы можете принять участие в любом из них.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=45&amp;language=UA\">Перейти к разделу</a></p>','2010-04-15 14:11:12'),(0,'current_projects_block_content',0,'<p><img height=\"50\" align=\"left\" width=\"50\" vspace=\"4\" alt=\"\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"content_simple_text_lm\">У розділі розміщено список поточних досліджень. Ви можете взяти участь у будь-якому з них.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=45&amp;language=UA\">Перейти до розділу</a></p>','current_projects_block_content','','UA','2010-04-15 14:02:41','<p><img height=\"50\" align=\"left\" width=\"50\" vspace=\"4\" alt=\"\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"content_simple_text_lm\">У розділі розміщено список поточних досліджень. Ви можете взяти участь у будь-якому з них.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=45&amp;language=UA\">Перейти до розділу</a></p>','2010-04-15 14:02:41'),(0,'DATE',0,NULL,'DATE',NULL,'RU','2010-04-15 11:57:21',NULL,'2010-04-15 11:57:21'),(0,'DATE',0,'Дата','DATE',NULL,'UA','2010-04-02 08:23:57','Дата','2010-04-02 08:23:57'),(0,'default_meta_commentary',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_commentary',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_commentary',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_description',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_description',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_description',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_keywords',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_keywords',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_keywords',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_title',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_title',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_meta_title',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'default_obj_meta_commentary',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_commentary',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_commentary',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_description',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_description',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_description',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_keywords',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_keywords',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_keywords',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_title',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_title',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'default_obj_meta_title',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'dest_email',0,'your_email@address.com','dest_email',NULL,'EN','2009-11-14 21:07:33','your_email@address.com','2009-11-14 21:07:33'),(0,'dest_email_subject',0,'News Letters system','dest_email_subject',NULL,'EN','2009-11-14 21:07:33','News Letters system','2009-11-14 21:07:33'),(0,'display_header_langs_list',0,NULL,'display_header_langs_list',NULL,'RU','2011-05-30 08:33:53',NULL,'2011-05-30 08:33:53'),(0,'display_header_langs_list',0,'','display_header_langs_list','','UA','2010-04-15 11:55:53','','2010-04-15 11:55:53'),(0,'DISTRICT',0,NULL,'DISTRICT','','RU','2010-07-02 09:55:53',NULL,'2010-07-02 09:55:53'),(0,'DISTRICT',0,'Область*','DISTRICT','','UA','2010-07-02 09:55:50','Область*','2010-07-02 09:55:50'),(0,'dns_disabled',0,'dns_disabled',NULL,NULL,'EN','2009-11-14 21:07:33','dns_disabled','2009-11-14 21:07:33'),(0,'E-MAIL',0,NULL,'E-MAIL','','RU','2011-06-24 09:58:16',NULL,'2011-06-24 09:58:16'),(0,'E-MAIL',0,'E-mail* (name@domain.ext)','E-MAIL','','UA','2011-06-24 09:58:12','E-mail* (name@domain.ext)','2011-06-24 09:58:12'),(0,'ENTER',0,'Вход','ENTER','','RU','2010-04-09 13:39:51','Вход','2010-04-09 13:39:51'),(0,'ENTER',0,'Вхід','ENTER',NULL,'UA','2010-04-02 08:23:33','Вхід','2010-04-02 08:23:33'),(0,'ENTER_AT_LEAST_ONE_PHONE',0,'Вкажiть хоча б один з телефонiв.','ENTER_AT_LEAST_ONE_PHONE',NULL,'RU','2011-07-05 03:28:16','Вкажiть хоча б один з телефонiв.','2011-07-05 03:28:16'),(0,'ENTER_AT_LEAST_ONE_PHONE',0,'Вкажiть хоча б один з телефонiв.','ENTER_AT_LEAST_ONE_PHONE',NULL,'UA','2011-07-05 07:03:29','Вкажiть хоча б один з телефонiв.','2011-07-05 07:03:29'),(0,'ENTER_E-MAIL_IN_STANDART_FORMAT',0,'Введiть e-mail у загальноприйнятому форматi (з \'@\'-собачкою та \'.\'-крапочкою).','ENTER_E-MAIL_IN_STANDART_FORMAT',NULL,'UA','2010-04-02 08:25:12','Введiть e-mail у загальноприйнятому форматi (з \'@\'-собачкою та \'.\'-крапочкою).','2010-04-02 08:25:12'),(0,'ENTER_PHONE_NUMBER_IN_FORMAT_(NNN)_NNNNNNN',0,'Введите номер в формате XXXxxxxxxx','ENTER_PHONE_NUMBER_IN_FORMAT_(NNN)_NNNNNNN','','RU','2011-06-30 08:59:29','Введите номер в формате XXXxxxxxxx','2011-06-30 08:59:29'),(0,'ENTER_PHONE_NUMBER_IN_FORMAT_(NNN)_NNNNNNN',0,'Введіть номер у форматі XXXxxxxxxx','ENTER_PHONE_NUMBER_IN_FORMAT_(NNN)_NNNNNNN','','UA','2011-06-29 08:24:08','Введіть номер у форматі XXXxxxxxxx','2011-06-29 08:24:08'),(0,'ENTER_PHONE_NUMBER_WITH_CODE_(10_DIGITS)',0,NULL,'ENTER_PHONE_NUMBER_WITH_CODE_(10_DIGITS)','','EN','2011-06-30 09:15:37',NULL,'2011-06-30 09:15:37'),(0,'ENTER_PHONE_NUMBER_WITH_CODE_(10_DIGITS)',0,'Введите номер телефона с кодом (10 цифр) без нецифровых символов (скобок, точек, тире, пробелов).','ENTER_PHONE_NUMBER_WITH_CODE_(10_DIGITS)','','RU','2011-06-30 09:15:41','Введите номер телефона с кодом (10 цифр) без нецифровых символов (скобок, точек, тире, пробелов).','2011-06-30 09:15:41'),(0,'ENTER_PHONE_NUMBER_WITH_CODE_(10_DIGITS)',0,'Введiть номер телефону з кодом (10 цифр) без нецифрових символів (дужок&#44; крапок&#44; тире&#44; пробілів).','ENTER_PHONE_NUMBER_WITH_CODE_(10_DIGITS)','','UA','2011-06-30 21:36:30','Введiть номер телефону з кодом (10 цифр) без нецифрових символів (дужок&#44; крапок&#44; тире&#44; пробілів).','2011-06-30 21:36:30'),(0,'ENTER_POINTS_NUMBER',0,'Введіть кількість балів','ENTER_POINTS_NUMBER','','UA','2010-07-27 07:55:24','Введіть кількість балів','2010-07-27 07:55:24'),(0,'ENTER_POINTS_NUMBER_YOU_WISH_TO_CONVERT',0,'Количество баллов для конвертации','ENTER_POINTS_NUMBER_YOU_WISH_TO_CONVERT','','RU','2010-06-21 07:02:38','Количество баллов для конвертации','2010-06-21 07:02:38'),(0,'ENTER_POINTS_NUMBER_YOU_WISH_TO_CONVERT',0,'Кількість балів для конвертації','ENTER_POINTS_NUMBER_YOU_WISH_TO_CONVERT','','UA','2010-06-21 07:02:43','Кількість балів для конвертації','2010-06-21 07:02:43'),(0,'ENTER_PURSE_NUMBER_IN_CORRECT_FORMAT',0,'Введите номер U-кошелька в правильном формате','ENTER_PURSE_NUMBER_IN_CORRECT_FORMAT','','RU','2011-07-04 23:02:25','Введите номер U-кошелька в правильном формате','2011-07-04 23:02:25'),(0,'ENTER_PURSE_NUMBER_IN_CORRECT_FORMAT',0,'Введіть номер U-гаманця в правильному форматі','ENTER_PURSE_NUMBER_IN_CORRECT_FORMAT','','UA','2011-07-04 23:01:50','Введіть номер U-гаманця в правильному форматі','2011-07-04 23:01:50'),(0,'ENTER_REFFER_EMAIL_IF_YOU_KNOW_IT',0,'Введіть e-mail того, хто запросив Вас до TNS Opros','ENTER_REFFER_EMAIL_IF_YOU_KNOW_IT','','UA','2010-07-13 13:14:30','Введіть e-mail того, хто запросив Вас до TNS Opros','2010-07-13 13:14:30'),(0,'ENTER_U-PURSE_NUMBER_U-NNNNNNNNNNNN',0,'Введите номер U-кошелька UNNNNNNNNNNNN','ENTER_U-PURSE_NUMBER_U-NNNNNNNNNNNN','','RU','2011-01-21 12:01:56','Введите номер U-кошелька UNNNNNNNNNNNN','2011-01-21 12:01:56'),(0,'ENTER_U-PURSE_NUMBER_U-NNNNNNNNNNNN',0,'Введіть номер U-гаманця UNNNNNNNNNNNN','ENTER_U-PURSE_NUMBER_U-NNNNNNNNNNNN','','UA','2011-01-21 12:03:06','Введіть номер U-гаманця UNNNNNNNNNNNN','2011-01-21 12:03:06'),(0,'ENTER_YOUR_E-MAIL',0,'Введіть e-maіl, який вводили при реєстрації','ENTER_YOUR_E-MAIL',NULL,'UA','2010-04-03 08:29:59','Введіть e-maіl, який вводили при реєстрації','2010-04-03 08:29:59'),(0,'ERROR_',404,'Помилка 404','ERROR_404',NULL,'UA','2010-04-02 08:27:05','Помилка 404','2010-04-02 08:27:05'),(0,'EXIT',0,'Выход','EXIT','','RU','2010-04-13 12:27:35','Выход','2010-04-13 12:27:35'),(0,'EXIT',0,'Вихід','EXIT',NULL,'UA','2010-04-02 08:23:55','Вихід','2010-04-02 08:23:55'),(0,'FAMILY',0,'Фамилия*','FAMILY','','RU','2010-07-02 09:54:49','Фамилия*','2010-07-02 09:54:49'),(0,'FAMILY',0,'Прізвище*','FAMILY','','UA','2010-07-02 09:54:45','Прізвище*','2010-07-02 09:54:45'),(0,'faq_block_content',0,'<p><img width=\"49\" vspace=\"4\" height=\"49\" align=\"left\" src=\"/usersimage/Image/faq.png\" alt=\"\" /></p>\r\n<p style=\"margin-left: 60px;\" class=\"content_simple_text\">Ответы на частозадаваемые вопросы в разделе Frequently Asked Questions.</p>\r\n<p style=\"margin-left: 60px;\" class=\"content_simple_text\">&nbsp;</p>\r\n<p><a href=\"/index.php?t=86&amp;language=UA\" class=\"system_button2\">Перейти к разделу</a></p>','faq_block_content','','RU','2010-04-12 08:51:59','<p><img width=\"49\" vspace=\"4\" height=\"49\" align=\"left\" src=\"/usersimage/Image/faq.png\" alt=\"\" /></p>\r\n<p style=\"margin-left: 60px;\" class=\"content_simple_text\">Ответы на частозадаваемые вопросы в разделе Frequently Asked Questions.</p>\r\n<p style=\"margin-left: 60px;\" class=\"content_simple_text\">&nbsp;</p>\r\n<p><a href=\"/index.php?t=86&amp;language=UA\" class=\"system_button2\">Перейти к разделу</a></p>','2010-04-12 08:51:59'),(0,'faq_block_content',0,'<p><img width=\"49\" vspace=\"4\" height=\"49\" align=\"left\" alt=\"\" src=\"/usersimage/Image/faq.png\" /></p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px;\">Відповіді на найпоширеніші питання у розділі Frequently Asked Questions.</p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px;\">&nbsp;</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=86&amp;language=UA\">Перейти до розділу</a></p>','faq_block_content','','UA','2010-04-12 08:51:16','<p><img width=\"49\" vspace=\"4\" height=\"49\" align=\"left\" alt=\"\" src=\"/usersimage/Image/faq.png\" /></p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px;\">Відповіді на найпоширеніші питання у розділі Frequently Asked Questions.</p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px;\">&nbsp;</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=86&amp;language=UA\">Перейти до розділу</a></p>','2010-04-12 08:51:16'),(0,'faq_block_title',0,'33333 33 33333','faq_block_title','','UA','2010-01-13 18:24:46','33333 33 33333','2010-01-13 18:24:46'),(0,'FEMALE',0,'Женский','FEMALE','','RU','2010-04-12 14:39:53','Женский','2010-04-12 14:39:53'),(0,'FEMALE',0,'Жіноча','FEMALE',NULL,'UA','2010-04-02 08:25:12','Жіноча','2010-04-02 08:25:12'),(0,'FIRST',0,'перша','FIRST',NULL,'UA','2010-04-11 14:13:54','перша','2010-04-11 14:13:54'),(0,'FIRST_PAGE',0,'First page','FIRST_PAGE',NULL,'UA','2010-04-11 14:13:54','First page','2010-04-11 14:13:54'),(0,'FLAT',0,'Квартира*','FLAT','','UA','2011-09-09 04:22:23','Квартира*','2011-09-09 04:22:23'),(0,'footer_copy',0,'<p>&copy;1998-2010 Тейлор Нельсон Софрез Украина. Все права защищены.</p>\r\n<p>Юридический адрес: ул. Игоревская 1/8 буква &quot;В&quot;, Киев, 04070, Украина</p>','footer_copy','','RU','2010-04-09 13:39:19','<p>&copy;1998-2010 Тейлор Нельсон Софрез Украина. Все права защищены.</p>\r\n<p>Юридический адрес: ул. Игоревская 1/8 буква &quot;В&quot;, Киев, 04070, Украина</p>','2010-04-09 13:39:19'),(0,'footer_copy',0,'<p>&copy;1998-2010 Тейлор Нельсон Софрез Україна. Усі права захищено.</p>\r\n<p>Юридична адреса: вул. Ігорівська 1/8 літера &quot;В&quot;, Київ, 04070, Україна</p>','footer_copy','','UA','2010-04-09 13:38:28','<p>&copy;1998-2010 Тейлор Нельсон Софрез Україна. Усі права захищено.</p>\r\n<p>Юридична адреса: вул. Ігорівська 1/8 літера &quot;В&quot;, Київ, 04070, Україна</p>','2010-04-09 13:38:28'),(0,'footer_siteby',0,'Developed by <a href=\"http://www.2kgroup.com\" target=\"_blank\" title=\"2K-Group: Web Development, IT outsourcing\">2K-Group</a>','footer_siteby','','UA','2010-02-09 14:27:18','Developed by <a href=\"http://www.2kgroup.com\" target=\"_blank\" title=\"2K-Group: Web Development, IT outsourcing\">2K-Group</a>','2010-02-09 14:27:18'),(0,'FORGOT_PASSWORD',0,'Забыли пароль','FORGOT_PASSWORD','','RU','2010-06-18 07:51:26','Забыли пароль','2010-06-18 07:51:26'),(0,'FORGOT_PASSWORD',0,'Забули пароль','FORGOT_PASSWORD','','UA','2010-06-18 07:51:23','Забули пароль','2010-06-18 07:51:23'),(0,'GO_TO_HOME_PAGE',0,'Перейти на главную страницу','GO_TO_HOME_PAGE','','RU','2010-04-09 13:40:06','Перейти на главную страницу','2010-04-09 13:40:06'),(0,'GO_TO_HOME_PAGE',0,'Перейти до головної сторiнки','GO_TO_HOME_PAGE',NULL,'UA','2010-04-02 08:23:33','Перейти до головної сторiнки','2010-04-02 08:23:33'),(0,'HOME',0,'Главная','HOME','','RU','2011-03-18 10:06:16','Главная','2011-03-18 10:06:16'),(0,'HOME',0,'Головна','HOME',NULL,'UA','2010-04-02 08:23:33','Головна','2010-04-02 08:23:33'),(0,'HOUSE',0,'Дом','HOUSE','','EN','2010-04-12 14:41:17','Дом','2010-04-12 14:41:17'),(0,'HOUSE',0,'Дом*','HOUSE','','RU','2010-07-02 09:56:36','Дом*','2010-07-02 09:56:36'),(0,'HOUSE',0,'Будинок*','HOUSE','','UA','2010-07-02 09:56:34','Будинок*','2010-07-02 09:56:34'),(0,'html_comments_between_page_head_and_title',0,NULL,'html_comments_between_page_head_and_title','','RU','2010-04-12 14:41:33',NULL,'2010-04-12 14:41:33'),(0,'html_comments_between_page_head_and_title',0,NULL,'html_comments_between_page_head_and_title',NULL,'UA','2010-01-19 10:17:54',NULL,'2010-01-19 10:17:54'),(0,'ID',0,'Id','ID',NULL,'UA','2010-04-02 08:25:12','Id','2010-04-02 08:25:12'),(0,'IF_EXISTS',0,'(e-mail) необязательное поле','IF_EXISTS','','RU','2010-07-14 06:47:06','(e-mail) необязательное поле','2010-07-14 06:47:06'),(0,'IF_EXISTS',0,'(e-mail) необов’язкове поле','IF_EXISTS','','UA','2010-07-14 06:59:34','(e-mail) необов’язкове поле','2010-07-14 06:59:34'),(0,'INCORRECT_CITY',0,'Incorrect city','INCORRECT_CITY',NULL,'UA','2011-01-23 20:11:42','Incorrect city','2011-01-23 20:11:42'),(0,'INCORRECT_FLAT_NUMBER',0,'Incorrect flat number','INCORRECT_FLAT_NUMBER',NULL,'RU','2011-07-05 14:02:09','Incorrect flat number','2011-07-05 14:02:09'),(0,'INCORRECT_FLAT_NUMBER',0,'Incorrect flat number','INCORRECT_FLAT_NUMBER',NULL,'UA','2011-07-06 10:01:13','Incorrect flat number','2011-07-06 10:01:13'),(0,'INCORRECT_REGION',0,'Incorrect region','INCORRECT_REGION',NULL,'UA','2011-01-24 10:40:05','Incorrect region','2011-01-24 10:40:05'),(0,'INCORRECT_SETTLEMENT',0,'Incorrect settlement','INCORRECT_SETTLEMENT',NULL,'UA','2011-01-23 20:11:42','Incorrect settlement','2011-01-23 20:11:42'),(0,'incorrect_sid',0,'<p><span style=\"color: #ff0000\">Не правильний код активації!</span></p>','incorrect_sid','','UA','2009-12-11 10:38:30','<p><span style=\"color: #ff0000\">Не правильний код активації!</span></p>','2009-12-11 10:38:30'),(0,'INCORRECT_STREET',0,'Incorrect street','INCORRECT_STREET',NULL,'UA','2011-01-24 10:42:31','Incorrect street','2011-01-24 10:42:31'),(0,'INDEX',0,'Индекс*','INDEX','','RU','2010-08-18 09:17:53','Индекс*','2010-08-18 09:17:53'),(0,'INDEX',0,'Індекс*','INDEX','','UA','2010-07-26 16:39:56','Індекс*','2010-07-26 16:39:56'),(0,'index_block_',4,NULL,'index_block_4',NULL,'EN','2010-01-19 10:36:57',NULL,'2010-01-19 10:36:57'),(0,'index_block_',4,'<p class=\"content_simple_text\">TNS &ndash; мировой лидер в отрасли проведения маркетинговых исследований &quot;на заказ&quot;.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Миссия TNS:&nbsp; <br />\r\n<em>&laquo;Быть наиболее успешной и уважаемой компанией в сфере маркетинговых исследований, которая бы имела прочную репутацию компании, предоставляющей неизменно качественные услуги; но, также, которая славилась бы тем, что она ставит перед клиентами все более высокие цели и предлагает им все более инновационные решения, удовлетворяя постоянно расширяющиеся потребности клиента&raquo;.</em></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p><a href=\"http://www.tns-ua.com\" class=\"system_button\">Перейти к сайту TNS</a></p>','index_block_4','','RU','2010-04-09 13:32:20','<p class=\"content_simple_text\">TNS &ndash; мировой лидер в отрасли проведения маркетинговых исследований &quot;на заказ&quot;.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Миссия TNS:&nbsp; <br />\r\n<em>&laquo;Быть наиболее успешной и уважаемой компанией в сфере маркетинговых исследований, которая бы имела прочную репутацию компании, предоставляющей неизменно качественные услуги; но, также, которая славилась бы тем, что она ставит перед клиентами все более высокие цели и предлагает им все более инновационные решения, удовлетворяя постоянно расширяющиеся потребности клиента&raquo;.</em></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p><a href=\"http://www.tns-ua.com\" class=\"system_button\">Перейти к сайту TNS</a></p>','2010-04-09 13:32:20'),(0,'index_block_',4,'<p class=\"content_simple_text\">TNS &ndash; світовий лідер у галузі проведення маркетингових досліджень &laquo;на замовлення&raquo;.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Місія TNS:&nbsp; <br />\r\n<em>&laquo;Бути найбільш успішною і шанованою компанією у сфері маркетингових досліджень, яка б мала міцну репутацію компанії, <br />\r\nщо надає незмінно якісні послуги; але, також, яка була би відомою тим, що надає можливість клієнтам ставити перед собою <br />\r\nвсе більш високі цілі, які вона допомагає реалізувати, і пропонує їм все більш інноваційні рішення, задовольняючи потреби <br />\r\nклієнта, що постійно розширюються&raquo;.</em></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p><a href=\"http://www.tns-ua.com\" class=\"system_button\">Перейти до сайту TNS</a></p>','index_block_4','','UA','2010-04-09 13:12:40','<p class=\"content_simple_text\">TNS &ndash; світовий лідер у галузі проведення маркетингових досліджень &laquo;на замовлення&raquo;.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Місія TNS:&nbsp; <br />\r\n<em>&laquo;Бути найбільш успішною і шанованою компанією у сфері маркетингових досліджень, яка б мала міцну репутацію компанії, <br />\r\nщо надає незмінно якісні послуги; але, також, яка була би відомою тим, що надає можливість клієнтам ставити перед собою <br />\r\nвсе більш високі цілі, які вона допомагає реалізувати, і пропонує їм все більш інноваційні рішення, задовольняючи потреби <br />\r\nклієнта, що постійно розширюються&raquo;.</em></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p><a href=\"http://www.tns-ua.com\" class=\"system_button\">Перейти до сайту TNS</a></p>','2010-04-09 13:12:40'),(0,'index_block_1_bottom',0,NULL,'index_block_1_bottom','','EN','2010-03-29 17:00:59',NULL,'2010-03-29 17:00:59'),(0,'index_block_1_bottom',0,'<p class=\"content_simple_text\"><a class=\"small_pink_down_arrow_at_left\">О TNS Opros</a></p>\r\n<p><a class=\"pink_microbox_at_left\" href=\"/index.php?t=35&amp;language=UA\">Мы TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=42&amp;language=UA\">Преимущества TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=55&amp;language=UA\">Миссия TNS Opros</a><br />\r\n&nbsp;</p>\r\n<p class=\"content_simple_text\">TNS разработала сообщество для того, чтобы дать Вам в руки реальный инструмент для благоустройства вашей жизни - лидеры рынка прислушаются к вашему мнению уже сегодня.</p>','index_block_1_bottom','','RU','2011-08-10 08:31:55','<p class=\"content_simple_text\"><a class=\"small_pink_down_arrow_at_left\">О TNS Opros</a></p>\r\n<p><a class=\"pink_microbox_at_left\" href=\"/index.php?t=35&amp;language=UA\">Мы TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=42&amp;language=UA\">Преимущества TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=55&amp;language=UA\">Миссия TNS Opros</a><br />\r\n&nbsp;</p>\r\n<p class=\"content_simple_text\">TNS разработала сообщество для того, чтобы дать Вам в руки реальный инструмент для благоустройства вашей жизни - лидеры рынка прислушаются к вашему мнению уже сегодня.</p>','2011-08-10 08:31:55'),(0,'index_block_1_bottom',0,'<p class=\"content_simple_text\"><a class=\"small_pink_down_arrow_at_left\">Про TNS Opros</a></p>\r\n<p><a class=\"pink_microbox_at_left\" href=\"/index.php?t=35&amp;language=UA\">Ми TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=42&amp;language=UA\">Переваги TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=55&amp;language=UA\">Місія TNS Opros</a><br />\r\n&nbsp;</p>\r\n<p class=\"content_simple_text\">TNS створила співтовариство для того, щоб дати Вам у руки реальний інструмент для благоустрою вашого життя - лідери ринку прислухаються до вашої думки вже сьогодні.</p>','index_block_1_bottom','','UA','2011-08-10 08:30:41','<p class=\"content_simple_text\"><a class=\"small_pink_down_arrow_at_left\">Про TNS Opros</a></p>\r\n<p><a class=\"pink_microbox_at_left\" href=\"/index.php?t=35&amp;language=UA\">Ми TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=42&amp;language=UA\">Переваги TNS Opros</a><br />\r\n<a class=\"pink_microbox_at_left\" href=\"/index.php?t=55&amp;language=UA\">Місія TNS Opros</a><br />\r\n&nbsp;</p>\r\n<p class=\"content_simple_text\">TNS створила співтовариство для того, щоб дати Вам у руки реальний інструмент для благоустрою вашого життя - лідери ринку прислухаються до вашої думки вже сьогодні.</p>','2011-08-10 08:30:41'),(0,'index_block_1_bottom_for_authorized',0,'<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Мы будем сохранять для Вас историю опросов,&nbsp;в которых Вы участвовали все время, пока Вы будете с нами.</p>\r\n<p><a href=\"/index.php?t=30&amp;language=UA\" class=\"system_button\">История опросов</a></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Накопили достаточное количество баллов? Воспользуйтесь одним из способов их конвертации для получения реальной выгоды.</p>\r\n<p><a href=\"/index.php?t=31&amp;language=UA\" class=\"system_button\">Конвертация баллов</a></p>','index_block_1_bottom_for_authorized','','RU','2010-04-09 13:46:33','<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Мы будем сохранять для Вас историю опросов,&nbsp;в которых Вы участвовали все время, пока Вы будете с нами.</p>\r\n<p><a href=\"/index.php?t=30&amp;language=UA\" class=\"system_button\">История опросов</a></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Накопили достаточное количество баллов? Воспользуйтесь одним из способов их конвертации для получения реальной выгоды.</p>\r\n<p><a href=\"/index.php?t=31&amp;language=UA\" class=\"system_button\">Конвертация баллов</a></p>','2010-04-09 13:46:33'),(0,'index_block_1_bottom_for_authorized',0,'<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Ми будемо зберігати для Вас історію опитувань,&nbsp;в яких Ви брали участь,&nbsp;весь час, поки Ви будете з нами.</p>\r\n<p><a href=\"/index.php?t=30&amp;language=UA\" class=\"system_button\">Історія опитувань</a></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Накопичили достатню кількість балів? Скористайтесь одним із способів їх конвертації для задоволення своїх потреб.</p>\r\n<p><a href=\"/index.php?t=31&amp;language=UA\" class=\"system_button\">Конвертація балів</a></p>','index_block_1_bottom_for_authorized','','UA','2010-04-09 13:43:29','<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Ми будемо зберігати для Вас історію опитувань,&nbsp;в яких Ви брали участь,&nbsp;весь час, поки Ви будете з нами.</p>\r\n<p><a href=\"/index.php?t=30&amp;language=UA\" class=\"system_button\">Історія опитувань</a></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Накопичили достатню кількість балів? Скористайтесь одним із способів їх конвертації для задоволення своїх потреб.</p>\r\n<p><a href=\"/index.php?t=31&amp;language=UA\" class=\"system_button\">Конвертація балів</a></p>','2010-04-09 13:43:29'),(0,'index_block_1_top',0,NULL,'index_block_1_top',NULL,'EN','2010-03-25 13:22:33',NULL,'2010-03-25 13:22:33'),(0,'index_block_1_top',0,'Узнайте больше об онлайн сообществе TNS Opros','index_block_1_top','','RU','2010-03-29 16:53:25','Узнайте больше об онлайн сообществе TNS Opros','2010-03-29 16:53:25'),(0,'index_block_1_top',0,'Дізнайтесь більше про онлайн співтовариство TNS Opros','index_block_1_top','','UA','2010-03-29 16:53:45','Дізнайтесь більше про онлайн співтовариство TNS Opros','2010-03-29 16:53:45'),(0,'index_block_1_top_for_authorized',0,NULL,'index_block_1_top_for_authorized','','EN','2010-04-09 13:41:42',NULL,'2010-04-09 13:41:42'),(0,'index_block_1_top_for_authorized',0,'Почувствуйте себя частью прогрессивной элиты общества!','index_block_1_top_for_authorized','','RU','2010-04-09 13:42:40','Почувствуйте себя частью прогрессивной элиты общества!','2010-04-09 13:42:40'),(0,'index_block_1_top_for_authorized',0,'Відчуйте себе частиною прогресивної еліти суспільства.','index_block_1_top_for_authorized','','UA','2010-01-11 08:24:46','Відчуйте себе частиною прогресивної еліти суспільства.','2010-01-11 08:24:46'),(0,'index_block_2_top',0,NULL,'index_block_2_top','','RU','2010-03-01 16:51:33',NULL,'2010-03-01 16:51:33'),(0,'index_block_2_top',0,'З нами Ви завжди в курсі останніх новин та розробок.','index_block_2_top','','UA','2010-03-01 16:53:12','З нами Ви завжди в курсі останніх новин та розробок.','2010-03-01 16:53:12'),(0,'index_block_3_bottom',0,'<p class=\"content_simple_text\">Узнайте больше о нашей системе<br />\r\nпоощрений и почуствуйте реальную<br />\r\nзаботу, которую TNS дарит каждому <br />\r\nреспонденту.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=52&amp;language=UA\">Система поощрений</a></p>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Для того, чтобы участвовать в наших<br />\r\nисследованиях, нужно заполнить<br />\r\nформу регистрации.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=47&amp;language=UA\">Форма регистрации</a></p>','index_block_3_bottom','','RU','2011-08-10 08:29:39','<p class=\"content_simple_text\">Узнайте больше о нашей системе<br />\r\nпоощрений и почуствуйте реальную<br />\r\nзаботу, которую TNS дарит каждому <br />\r\nреспонденту.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=52&amp;language=UA\">Система поощрений</a></p>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Для того, чтобы участвовать в наших<br />\r\nисследованиях, нужно заполнить<br />\r\nформу регистрации.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=47&amp;language=UA\">Форма регистрации</a></p>','2011-08-10 08:29:39'),(0,'index_block_3_bottom',0,'<p class=\"content_simple_text\">Дізнайтеся більше про нашу систему<br />\r\nзаохочення та відчуйте реальну<br />\r\nтурботу, яку TNS дарує кожному <br />\r\nреспонденту.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=52&amp;language=UA\">Система заохочення</a></p>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Для того, щоб брати участь у наших<br />\r\nдослідженнях, потрібно заповнити<br />\r\nформу реєстрації.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=47&amp;language=UA\">Форма реєстрації</a></p>','index_block_3_bottom','','UA','2011-08-10 08:29:31','<p class=\"content_simple_text\">Дізнайтеся більше про нашу систему<br />\r\nзаохочення та відчуйте реальну<br />\r\nтурботу, яку TNS дарує кожному <br />\r\nреспонденту.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=52&amp;language=UA\">Система заохочення</a></p>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Для того, щоб брати участь у наших<br />\r\nдослідженнях, потрібно заповнити<br />\r\nформу реєстрації.</p>\r\n<p><a class=\"system_button\" href=\"/index.php?t=47&amp;language=UA\">Форма реєстрації</a></p>','2011-08-10 08:29:31'),(0,'index_block_3_bottom_for_authorized',0,'<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Пожалуйста, выберите интересную Вам тематику исследования и перейдите по ссылке для того, чтобы начать опрос.<br />\r\nВы можете остановиться и продолжить опрос позже, если по каким-то ричинам Вы не завершите его с первого раза.</p>','index_block_3_bottom_for_authorized','','RU','2010-04-09 13:49:28','<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Пожалуйста, выберите интересную Вам тематику исследования и перейдите по ссылке для того, чтобы начать опрос.<br />\r\nВы можете остановиться и продолжить опрос позже, если по каким-то ричинам Вы не завершите его с первого раза.</p>','2010-04-09 13:49:28'),(0,'index_block_3_bottom_for_authorized',0,'<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Будь-ласка, оберіть цікаву для Вас тематику дослідження та перейдіть за посиланням для того, щоб почати опитування. <br />\r\nВи можете продовжити опитування, якщо за якихось причин Ви не завершили його з першого разу.</p>','index_block_3_bottom_for_authorized','','UA','2010-04-09 13:47:27','<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Будь-ласка, оберіть цікаву для Вас тематику дослідження та перейдіть за посиланням для того, щоб почати опитування. <br />\r\nВи можете продовжити опитування, якщо за якихось причин Ви не завершили його з першого разу.</p>','2010-04-09 13:47:27'),(0,'index_block_3_top',0,'Мы сделаем ваше участие в исследованиях развлечением!','index_block_3_top','','RU','2010-04-09 13:35:08','Мы сделаем ваше участие в исследованиях развлечением!','2010-04-09 13:35:08'),(0,'index_block_3_top',0,'Ми зробимо вашу участь у  дослідженнях розвагою','index_block_3_top','','UA','2010-04-09 13:34:43','Ми зробимо вашу участь у  дослідженнях розвагою','2010-04-09 13:34:43'),(0,'index_block_3_top_for_authorized',0,'Принимайте участие в исследованиях и зарабатывайте баллы!','index_block_3_top_for_authorized','','UA','2010-04-09 13:53:39','Принимайте участие в исследованиях и зарабатывайте баллы!','2010-04-09 13:53:39'),(0,'int_b_3_class',0,'CDE8F3','int_b_3_class','','UA','2010-01-12 21:53:25','CDE8F3','2010-01-12 21:53:25'),(0,'invalid_email_format',0,'Invalid email format','invalid_email_format',NULL,'EN','2009-11-14 21:07:33','Invalid email format','2009-11-14 21:07:33'),(0,'INVESTIGATIONS',0,'Исследования','INVESTIGATIONS','','RU','2010-04-27 12:28:27','Исследования','2010-04-27 12:28:27'),(0,'INVESTIGATIONS',0,'Дослiдження','INVESTIGATIONS',NULL,'UA','2010-04-11 14:13:54','Дослiдження','2010-04-11 14:13:54'),(0,'INVESTIGATION_POINTS',0,'Награждение за исследование','INVESTIGATION_POINTS','','RU','2010-04-15 12:12:57','Награждение за исследование','2010-04-15 12:12:57'),(0,'INVESTIGATION_POINTS',0,'Нагорода за дослідження','INVESTIGATION_POINTS',NULL,'UA','2010-04-02 08:35:35','Нагорода за дослідження','2010-04-02 08:35:35'),(0,'INVITATION_TO_EMAIL',0,'Запрошення на e-mail','INVITATION_TO_EMAIL','','UA','2010-07-14 06:49:10','Запрошення на e-mail','2010-07-14 06:49:10'),(0,'KYIV_',0,NULL,'KYIV_','','RU','2010-04-12 14:42:31',NULL,'2010-04-12 14:42:31'),(0,'KYIV_',0,NULL,'KYIV_',NULL,'UA','2010-04-12 14:42:31',NULL,'2010-04-12 14:42:31'),(0,'KYIV_&_SEVASTOPOL',0,'Мiста республiканського пiдпорядкування, Київ та Севастополь, вибирайте на рiвнi областi','KYIV_&_SEVASTOPOL',NULL,'UA','2010-04-02 08:25:12','Мiста республiканського пiдпорядкування, Київ та Севастополь, вибирайте на рiвнi областi','2010-04-02 08:25:12'),(0,'LAST',0,'остання','LAST',NULL,'UA','2010-04-11 14:13:54','остання','2010-04-11 14:13:54'),(0,'LAST_NEWS_36.',6,NULL,'LAST_NEWS_36.6','','EN','2010-04-21 09:40:11',NULL,'2010-04-21 09:40:11'),(0,'LAST_NEWS_36.',6,'Новости TNS Opros','LAST_NEWS_36.6','','RU','2010-04-21 09:40:07','Новости TNS Opros','2010-04-21 09:40:07'),(0,'LAST_NEWS_36.',6,'Новини TNS Opros','LAST_NEWS_36.6','','UA','2010-04-21 09:40:04','Новини TNS Opros','2010-04-21 09:40:04'),(0,'LAST_PAGE',0,'Last page','LAST_PAGE',NULL,'UA','2010-04-11 14:13:54','Last page','2010-04-11 14:13:54'),(0,'LIST',0,'list','LIST',NULL,'UA','2010-04-11 14:13:54','list','2010-04-11 14:13:54'),(0,'LOGIN',0,'E-mail','LOGIN',NULL,'UA','2010-04-02 08:35:29','E-mail','2010-04-02 08:35:29'),(0,'MALE',0,'Мужской','MALE','','RU','2010-04-12 14:39:42','Мужской','2010-04-12 14:39:42'),(0,'MALE',0,'Чоловіча','MALE',NULL,'UA','2010-04-02 08:25:12','Чоловіча','2010-04-02 08:25:12'),(0,'MANDATORY_FIELD',0,'Не всі обов\'язкові поля заповнені','MANDATORY_FIELD','','UA','2011-07-04 22:52:24','Не всі обов\'язкові поля заповнені','2011-07-04 22:52:24'),(0,'media_',69,'a:5:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:22:\"tns_new_year_69_UA.png\";}s:4:\"alts\";a:1:{s:2:\"UA\";s:1:\" \";}}','media_69','','','2010-03-04 16:25:51','a:5:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:22:\"tns_new_year_69_UA.png\";}s:4:\"alts\";a:1:{s:2:\"UA\";s:1:\" \";}}','2010-03-04 16:25:51'),(0,'media_',70,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";b:0;s:6:\"images\";a:1:{s:2:\"UA\";s:36:\"__replace_after_insert___1_70_UA.png\";}}','media_70',NULL,'','2010-01-08 13:54:20','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";b:0;s:6:\"images\";a:1:{s:2:\"UA\";s:36:\"__replace_after_insert___1_70_UA.png\";}}','2010-01-08 13:54:20'),(0,'media_',71,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:31:\"main_block_about_36_6_71_UA.png\";}}','media_71','','','2010-01-29 12:11:41','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:31:\"main_block_about_36_6_71_UA.png\";}}','2010-01-29 12:11:41'),(0,'media_',72,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:32:\"main_block_news_header_72_UA.png\";s:2:\"RU\";s:32:\"main_block_news_header_72_RU.png\";}}','media_72','','','2010-04-13 10:06:41','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:32:\"main_block_news_header_72_UA.png\";s:2:\"RU\";s:32:\"main_block_news_header_72_RU.png\";}}','2010-04-13 10:06:41'),(0,'media_',73,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:25:\"main_block_news_73_UA.png\";}}','media_73','','','2010-01-29 12:11:59','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:25:\"main_block_news_73_UA.png\";}}','2010-01-29 12:11:59'),(0,'media_',74,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:36:\"__replace_after_insert___5_74_UA.png\";s:2:\"RU\";s:32:\"main_block_join_header_74_RU.png\";}}','media_74','','','2010-04-13 10:04:25','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:36:\"__replace_after_insert___5_74_UA.png\";s:2:\"RU\";s:32:\"main_block_join_header_74_RU.png\";}}','2010-04-13 10:04:25'),(0,'media_',75,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:32:\"main_block_pryednajtes_75_UA.png\";}}','media_75','','','2010-01-29 12:12:24','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:32:\"main_block_pryednajtes_75_UA.png\";}}','2010-01-29 12:12:24'),(0,'media_',76,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:37:\"main_block_about_tns_header_76_UA.png\";s:2:\"RU\";s:37:\"main_block_about_tns_header_76_RU.png\";}}','media_76','','','2010-04-13 10:00:32','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:37:\"main_block_about_tns_header_76_UA.png\";s:2:\"RU\";s:37:\"main_block_about_tns_header_76_RU.png\";}}','2010-04-13 10:00:32'),(0,'media_',77,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:24:\"my_36_6_header_77_UA.png\";}}','media_77','','','2010-01-11 08:16:29','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:24:\"my_36_6_header_77_UA.png\";}}','2010-01-11 08:16:29'),(0,'media_',78,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:33:\"current_projects_header_78_UA.png\";}}','media_78','','','2010-01-11 08:18:07','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:33:\"current_projects_header_78_UA.png\";}}','2010-01-11 08:18:07'),(0,'media_',79,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:21:\"darts_arrow_79_UA.png\";}}','media_79','','','2010-01-29 12:02:42','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:21:\"darts_arrow_79_UA.png\";}}','2010-01-29 12:02:42'),(0,'media_',80,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:18:\"uah_sign_80_UA.png\";}}','media_80','','','2010-01-29 12:03:49','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:18:\"uah_sign_80_UA.png\";}}','2010-01-29 12:03:49'),(0,'media_',81,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:19:\"handshake_81_UA.png\";}}','media_81','','','2010-01-29 12:04:07','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:19:\"handshake_81_UA.png\";}}','2010-01-29 12:04:07'),(0,'media_',84,'a:7:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";b:0;s:6:\"images\";a:2:{s:2:\"UA\";s:16:\"quotes_84_UA.swf\";s:2:\"RU\";s:16:\"quotes_84_RU.swf\";}s:9:\"show_menu\";s:3:\"yes\";s:7:\"quality\";s:4:\"high\";s:7:\"bgcolor\";b:0;}','media_84','','','2010-04-22 13:40:08','a:7:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";b:0;s:6:\"images\";a:2:{s:2:\"UA\";s:16:\"quotes_84_UA.swf\";s:2:\"RU\";s:16:\"quotes_84_RU.swf\";}s:9:\"show_menu\";s:3:\"yes\";s:7:\"quality\";s:4:\"high\";s:7:\"bgcolor\";b:0;}','2010-04-22 13:40:08'),(0,'media_',85,'a:7:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:26:\"quotes_with_text_85_UA.png\";s:2:\"RU\";s:26:\"quotes_with_text_85_RU.png\";}s:9:\"show_menu\";s:3:\"yes\";s:7:\"quality\";s:4:\"high\";s:7:\"bgcolor\";b:0;}','media_85','','','2010-04-13 12:52:38','a:7:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:26:\"quotes_with_text_85_UA.png\";s:2:\"RU\";s:26:\"quotes_with_text_85_RU.png\";}s:9:\"show_menu\";s:3:\"yes\";s:7:\"quality\";s:4:\"high\";s:7:\"bgcolor\";b:0;}','2010-04-13 12:52:38'),(0,'media_',91,'a:7:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";b:0;s:6:\"images\";a:2:{s:2:\"EN\";s:12:\"91_91_EN.swf\";s:2:\"UA\";s:12:\"91_91_UA.swf\";}s:9:\"show_menu\";s:3:\"yes\";s:7:\"quality\";s:4:\"high\";s:7:\"bgcolor\";b:0;}','media_91','','','2010-01-30 13:31:34','a:7:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";b:0;s:6:\"images\";a:2:{s:2:\"EN\";s:12:\"91_91_EN.swf\";s:2:\"UA\";s:12:\"91_91_UA.swf\";}s:9:\"show_menu\";s:3:\"yes\";s:7:\"quality\";s:4:\"high\";s:7:\"bgcolor\";b:0;}','2010-01-30 13:31:34'),(0,'media_',92,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:21:\"tns_March_8_92_UA.png\";}}','media_92','','','2010-03-04 15:16:56','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:21:\"tns_March_8_92_UA.png\";}}','2010-03-04 15:16:56'),(0,'media_',94,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:27:\"shapka_UA_surveys_94_UA.png\";s:2:\"RU\";s:24:\"shapka_surveys_94_RU.png\";}}','media_94','','','2010-04-13 10:03:17','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:27:\"shapka_UA_surveys_94_UA.png\";s:2:\"RU\";s:24:\"shapka_surveys_94_RU.png\";}}','2010-04-13 10:03:17'),(0,'media_',95,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:26:\"shapka_pro_opros_95_UA.png\";s:2:\"RU\";s:26:\"shapka_pro_opros_95_RU.png\";}}','media_95','','','2010-04-13 10:02:58','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:26:\"shapka_pro_opros_95_UA.png\";s:2:\"RU\";s:26:\"shapka_pro_opros_95_RU.png\";}}','2010-04-13 10:02:58'),(0,'media_',96,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:26:\"shapka_miy_opros_96_UA.png\";s:2:\"RU\";s:26:\"shapka_miy_opros_96_RU.png\";}}','media_96','','','2010-04-13 10:00:53','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"UA\";s:26:\"shapka_miy_opros_96_UA.png\";s:2:\"RU\";s:26:\"shapka_miy_opros_96_RU.png\";}}','2010-04-13 10:00:53'),(0,'media_',97,'a:5:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:18:\"top_main_97_UA.PNG\";}s:4:\"alts\";a:1:{s:2:\"RU\";s:25:\"media/top_main_97_RU.PNG \";}}','media_97','','','2010-11-24 10:19:17','a:5:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:1:{s:2:\"UA\";s:18:\"top_main_97_UA.PNG\";}s:4:\"alts\";a:1:{s:2:\"RU\";s:25:\"media/top_main_97_RU.PNG \";}}','2010-11-24 10:19:17'),(0,'media_',98,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"RU\";s:15:\"gifts_98_RU.png\";s:2:\"UA\";s:15:\"gifts_98_UA.png\";}}','media_98','','','2010-04-19 10:28:39','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"RU\";s:15:\"gifts_98_RU.png\";s:2:\"UA\";s:15:\"gifts_98_UA.png\";}}','2010-04-19 10:28:39'),(0,'media_',100,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"RU\";s:14:\"100_100_RU.png\";s:2:\"UA\";s:14:\"100_100_UA.png\";}}','media_100','','','2010-04-20 12:37:02','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"RU\";s:14:\"100_100_RU.png\";s:2:\"UA\";s:14:\"100_100_UA.png\";}}','2010-04-20 12:37:02'),(0,'media_',102,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"RU\";s:23:\"top_discover_102_RU.png\";s:2:\"UA\";s:23:\"top_discover_102_UA.png\";}}','media_102','','','2011-08-10 08:38:41','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:2:{s:2:\"RU\";s:23:\"top_discover_102_RU.png\";s:2:\"UA\";s:23:\"top_discover_102_UA.png\";}}','2011-08-10 08:38:41'),(0,'media_',103,'a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:3:{s:2:\"EN\";s:25:\"help_eachother_103_EN.png\";s:2:\"RU\";s:25:\"help_eachother_103_RU.png\";s:2:\"UA\";s:25:\"help_eachother_103_UA.png\";}}','media_103','','','2011-02-18 14:55:55','a:4:{s:6:\"size_x\";i:0;s:6:\"size_y\";i:0;s:14:\"size_unit_type\";s:2:\"px\";s:6:\"images\";a:3:{s:2:\"EN\";s:25:\"help_eachother_103_EN.png\";s:2:\"RU\";s:25:\"help_eachother_103_RU.png\";s:2:\"UA\";s:25:\"help_eachother_103_UA.png\";}}','2011-02-18 14:55:55'),(0,'menu',0,'','menu','','UA','2010-03-30 12:28:07','','2010-03-30 12:28:07'),(0,'menu',22,'','menu22',NULL,'UA','2010-01-21 16:20:19','','2010-01-21 16:20:19'),(0,'menu',24,'','menu24',NULL,'UA','2010-01-22 14:02:49','','2010-01-22 14:02:49'),(0,'menu_100_',1,' ','menu_100_1',NULL,'EN','2009-11-14 21:10:09',' ','2009-11-14 21:10:09'),(0,'menu_100_',2,'О TNS Opros','menu_100_2','','RU','2010-04-13 10:08:13','О TNS Opros','2010-04-13 10:08:13'),(0,'menu_100_',2,'Про TNS Opros','menu_100_2','','UA','2010-04-13 12:23:51','Про TNS Opros','2010-04-13 12:23:51'),(0,'menu_100_',3,'Присоединяйтесь','menu_100_3','','RU','2010-04-13 10:08:34','Присоединяйтесь','2010-04-13 10:08:34'),(0,'menu_100_',3,'Приєднайтесь','menu_100_3','','UA','2010-04-13 08:22:43','Приєднайтесь','2010-04-13 08:22:43'),(0,'menu_100_',4,'Підсумки досліджень','menu_100_4','','UA','2010-01-13 12:02:58','Підсумки досліджень','2010-01-13 12:02:58'),(0,'menu_100_',5,'Новини','menu_100_5','','UA','2010-01-13 12:02:31','Новини','2010-01-13 12:02:31'),(0,'menu_100_',6,'Поточні проекти','menu_100_6',NULL,'UA','2009-12-11 13:22:58','Поточні проекти','2009-12-11 13:22:58'),(0,'menu_100_',7,'Текущие исследования','menu_100_7','','RU','2010-04-13 10:23:52','Текущие исследования','2010-04-13 10:23:52'),(0,'menu_100_',7,'Поточні дослідження','menu_100_7','','UA','2010-04-13 12:24:15','Поточні дослідження','2010-04-13 12:24:15'),(0,'menu_100_',8,'Мой Opros','menu_100_8','','RU','2010-04-13 10:25:00','Мой Opros','2010-04-13 10:25:00'),(0,'menu_100_',8,'Мій Opros','menu_100_8','','UA','2010-04-13 12:24:42','Мій Opros','2010-04-13 12:24:42'),(0,'menu_100_',9,'Back-office menu item','menu_100_9','','UA','2009-12-11 13:57:36','Back-office menu item','2009-12-11 13:57:36'),(0,'menu_100_',10,'Форма регистрации','menu_100_10',NULL,'RU','2010-03-29 17:33:23','Форма регистрации','2010-03-29 17:33:23'),(0,'menu_100_',10,'Форма реєстрації','menu_100_10','','UA','2010-03-29 17:33:13','Форма реєстрації','2010-03-29 17:33:13'),(0,'menu_100_',11,'Зачем регистрироваться','menu_100_11',NULL,'RU','2010-03-29 17:33:39','Зачем регистрироваться','2010-03-29 17:33:39'),(0,'menu_100_',11,'Навіщо реєструватись','menu_100_11','','UA','2010-03-29 17:33:29','Навіщо реєструватись','2010-03-29 17:33:29'),(0,'menu_100_',12,'Система поощрений','menu_100_12',NULL,'RU','2010-03-29 17:34:33','Система поощрений','2010-03-29 17:34:33'),(0,'menu_100_',12,'Система заохочення','menu_100_12','','UA','2010-03-29 17:34:29','Система заохочення','2010-03-29 17:34:29'),(0,'menu_100_',13,'Главная','menu_100_13','','RU','2010-04-13 12:22:58','Главная','2010-04-13 12:22:58'),(0,'menu_100_',13,'Головна','menu_100_13','','UA','2010-04-13 12:23:25','Головна','2010-04-13 12:23:25'),(0,'menu_100_',14,'Исследования','menu_100_14',NULL,'RU','2010-03-29 18:00:27','Исследования','2010-03-29 18:00:27'),(0,'menu_100_',14,'Дослідження','menu_100_14','','UA','2010-03-29 18:00:15','Дослідження','2010-03-29 18:00:15'),(0,'menu_100_',15,'История опросов','menu_100_15',NULL,'RU','2010-03-29 17:57:47','История опросов','2010-03-29 17:57:47'),(0,'menu_100_',15,'Історія опитувань','menu_100_15','','UA','2010-03-29 17:57:34','Історія опитувань','2010-03-29 17:57:34'),(0,'menu_100_',16,'Мои личные данные','menu_100_16',NULL,'RU','2010-03-29 17:58:05','Мои личные данные','2010-03-29 17:58:05'),(0,'menu_100_',16,'Мої особисті дані','menu_100_16','','UA','2010-03-29 17:57:54','Мої особисті дані','2010-03-29 17:57:54'),(0,'menu_100_',17,'Конвертация баллов','menu_100_17',NULL,'RU','2010-03-29 17:58:20','Конвертация баллов','2010-03-29 17:58:20'),(0,'menu_100_',17,'Конвертація балів','menu_100_17','','UA','2010-06-30 09:04:09','Конвертація балів','2010-06-30 09:04:09'),(0,'menu_100_',18,'Тестовий пункт меню з довгою назвою в декілька рядків','menu_100_18','','UA','2009-12-30 14:39:25','Тестовий пункт меню з довгою назвою в декілька рядків','2009-12-30 14:39:25'),(0,'menu_100_',19,'Мы TNS Opros','menu_100_19','','RU','2010-03-29 17:30:28','Мы TNS Opros','2010-03-29 17:30:28'),(0,'menu_100_',19,'Ми TNS Opros','menu_100_19','','UA','2010-03-29 17:30:25','Ми TNS Opros','2010-03-29 17:30:25'),(0,'menu_100_',20,'Преимущества TNS Opros','menu_100_20','','RU','2010-04-09 14:07:06','Преимущества TNS Opros','2010-04-09 14:07:06'),(0,'menu_100_',20,'Переваги TNS Opros','menu_100_20','','UA','2010-03-29 17:31:00','Переваги TNS Opros','2010-03-29 17:31:00'),(0,'menu_100_',21,'Миссия TNS Opros','menu_100_21',NULL,'RU','2010-03-29 17:31:25','Миссия TNS Opros','2010-03-29 17:31:25'),(0,'menu_100_',21,'Місія TNS Opros','menu_100_21','','UA','2010-03-29 17:31:14','Місія TNS Opros','2010-03-29 17:31:14'),(0,'menu_100_',22,'Останні новини','menu_100_22',NULL,'UA','2010-01-12 08:32:05','Останні новини','2010-01-12 08:32:05'),(0,'menu_100_',23,'Головна','menu_100_23',NULL,'UA','2010-01-12 08:32:55','Головна','2010-01-12 08:32:55'),(0,'menu_100_',24,'Результати досліджень','menu_100_24',NULL,'UA','2010-01-12 08:33:57','Результати досліджень','2010-01-12 08:33:57'),(0,'menu_100_',25,'Пожива для роздумів','menu_100_25',NULL,'UA','2010-01-12 08:34:46','Пожива для роздумів','2010-01-12 08:34:46'),(0,'menu_100_',26,'Статистика відвідувань','menu_100_26',NULL,'UA','2010-01-12 08:35:39','Статистика відвідувань','2010-01-12 08:35:39'),(0,'menu_100_',27,'Полезная информация','menu_100_27','','RU','2010-04-13 10:08:55','Полезная информация','2010-04-13 10:08:55'),(0,'menu_100_',27,'Корисна інформація','menu_100_27','','UA','2010-04-13 08:21:55','Корисна інформація','2010-04-13 08:21:55'),(0,'menu_100_',28,'Новости TNS Opros','menu_100_28',NULL,'RU','2010-03-29 17:35:15','Новости TNS Opros','2010-03-29 17:35:15'),(0,'menu_100_',28,'Новини TNS Opros','menu_100_28','','UA','2010-03-29 17:35:04','Новини TNS Opros','2010-03-29 17:35:04'),(0,'menu_100_',29,'Результаты исследований','menu_100_29',NULL,'RU','2010-03-29 17:35:42','Результаты исследований','2010-03-29 17:35:42'),(0,'menu_100_',29,'Результати досліджень','menu_100_29','','UA','2010-03-29 17:35:22','Результати досліджень','2010-03-29 17:35:22'),(0,'menu_100_',30,'FAQ','menu_100_30','','UA','2010-03-29 17:35:47','FAQ','2010-03-29 17:35:47'),(0,'menu_100_',31,'Система поощрений','menu_100_31',NULL,'RU','2010-03-29 17:58:37','Система поощрений','2010-03-29 17:58:37'),(0,'menu_100_',31,'Система заохочення','menu_100_31','','UA','2010-04-06 18:25:47','Система заохочення','2010-04-06 18:25:47'),(0,'menu_100_picture_active_',2,'/usersimage/menu_100_RU_active_2.png','menu_100_picture_active_2',NULL,'RU','2010-04-13 10:08:13','/usersimage/menu_100_RU_active_2.png','2010-04-13 10:08:13'),(0,'menu_100_picture_active_',2,'/usersimage/menu_100_UA_active_2.png','menu_100_picture_active_2',NULL,'UA','2010-04-13 12:23:52','/usersimage/menu_100_UA_active_2.png','2010-04-13 12:23:52'),(0,'menu_100_picture_active_',3,'/usersimage/menu_100_RU_active_3.png','menu_100_picture_active_3',NULL,'RU','2010-04-13 10:08:34','/usersimage/menu_100_RU_active_3.png','2010-04-13 10:08:34'),(0,'menu_100_picture_active_',3,'/usersimage/menu_100_UA_active_3.png','menu_100_picture_active_3',NULL,'UA','2010-04-13 08:22:43','/usersimage/menu_100_UA_active_3.png','2010-04-13 08:22:43'),(0,'menu_100_picture_active_',4,'/usersimage/menu_100_UA_active_4.png','menu_100_picture_active_4','','UA','2009-12-03 17:17:10','/usersimage/menu_100_UA_active_4.png','2009-12-03 17:17:10'),(0,'menu_100_picture_active_',5,'/usersimage/menu_100_UA_active_5.png','menu_100_picture_active_5','','UA','2009-12-03 17:16:18','/usersimage/menu_100_UA_active_5.png','2009-12-03 17:16:18'),(0,'menu_100_picture_active_',6,'/usersimage/menu_100_UA_active_6.png','menu_100_picture_active_6',NULL,'UA','2009-12-11 13:24:28','/usersimage/menu_100_UA_active_6.png','2009-12-11 13:24:28'),(0,'menu_100_picture_active_',7,'/usersimage/menu_100_RU_active_7.png','menu_100_picture_active_7',NULL,'RU','2010-04-13 10:23:52','/usersimage/menu_100_RU_active_7.png','2010-04-13 10:23:52'),(0,'menu_100_picture_active_',7,'/usersimage/menu_100_UA_active_7.png','menu_100_picture_active_7',NULL,'UA','2010-04-13 12:24:15','/usersimage/menu_100_UA_active_7.png','2010-04-13 12:24:15'),(0,'menu_100_picture_active_',8,'/usersimage/menu_100_RU_active_8.png','menu_100_picture_active_8',NULL,'RU','2010-04-13 10:25:00','/usersimage/menu_100_RU_active_8.png','2010-04-13 10:25:00'),(0,'menu_100_picture_active_',8,'/usersimage/menu_100_UA_active_8.png','menu_100_picture_active_8',NULL,'UA','2010-04-13 12:24:42','/usersimage/menu_100_UA_active_8.png','2010-04-13 12:24:42'),(0,'menu_100_picture_active_',13,'/usersimage/menu_100_RU_active_13.png','menu_100_picture_active_13',NULL,'RU','2010-04-13 10:07:41','/usersimage/menu_100_RU_active_13.png','2010-04-13 10:07:41'),(0,'menu_100_picture_active_',13,'/usersimage/menu_100_UA_active_13.png','menu_100_picture_active_13',NULL,'UA','2010-04-13 12:23:19','/usersimage/menu_100_UA_active_13.png','2010-04-13 12:23:19'),(0,'menu_100_picture_active_',27,'/usersimage/menu_100_RU_active_27.png','menu_100_picture_active_27',NULL,'RU','2010-04-13 10:08:55','/usersimage/menu_100_RU_active_27.png','2010-04-13 10:08:55'),(0,'menu_100_picture_active_',27,'/usersimage/menu_100_UA_active_27.png','menu_100_picture_active_27',NULL,'UA','2010-04-13 08:21:55','/usersimage/menu_100_UA_active_27.png','2010-04-13 08:21:55'),(0,'menu_100_picture_inactive_',2,'/usersimage/menu_100_RU_inactive_2.png','menu_100_picture_inactive_2',NULL,'RU','2010-04-13 10:08:13','/usersimage/menu_100_RU_inactive_2.png','2010-04-13 10:08:13'),(0,'menu_100_picture_inactive_',2,'/usersimage/menu_100_UA_inactive_2.png','menu_100_picture_inactive_2',NULL,'UA','2010-04-13 12:23:52','/usersimage/menu_100_UA_inactive_2.png','2010-04-13 12:23:52'),(0,'menu_100_picture_inactive_',3,'/usersimage/menu_100_RU_inactive_3.png','menu_100_picture_inactive_3',NULL,'RU','2010-04-13 10:08:34','/usersimage/menu_100_RU_inactive_3.png','2010-04-13 10:08:34'),(0,'menu_100_picture_inactive_',3,'/usersimage/menu_100_UA_inactive_3.png','menu_100_picture_inactive_3',NULL,'UA','2010-04-13 08:22:43','/usersimage/menu_100_UA_inactive_3.png','2010-04-13 08:22:43'),(0,'menu_100_picture_inactive_',4,'/usersimage/menu_100_UA_inactive_4.png','menu_100_picture_inactive_4',NULL,'UA','2009-12-02 16:14:32','/usersimage/menu_100_UA_inactive_4.png','2009-12-02 16:14:32'),(0,'menu_100_picture_inactive_',5,'/usersimage/menu_100_UA_inactive_5.png','menu_100_picture_inactive_5',NULL,'UA','2009-12-02 15:32:52','/usersimage/menu_100_UA_inactive_5.png','2009-12-02 15:32:52'),(0,'menu_100_picture_inactive_',6,'/usersimage/menu_100_UA_inactive_6.png','menu_100_picture_inactive_6',NULL,'UA','2009-12-11 13:25:58','/usersimage/menu_100_UA_inactive_6.png','2009-12-11 13:25:58'),(0,'menu_100_picture_inactive_',7,'/usersimage/menu_100_RU_inactive_7.png','menu_100_picture_inactive_7',NULL,'RU','2010-04-13 10:23:52','/usersimage/menu_100_RU_inactive_7.png','2010-04-13 10:23:52'),(0,'menu_100_picture_inactive_',7,'/usersimage/menu_100_UA_inactive_7.png','menu_100_picture_inactive_7',NULL,'UA','2010-04-13 12:24:15','/usersimage/menu_100_UA_inactive_7.png','2010-04-13 12:24:15'),(0,'menu_100_picture_inactive_',8,'/usersimage/menu_100_RU_inactive_8.png','menu_100_picture_inactive_8',NULL,'RU','2010-04-13 10:25:00','/usersimage/menu_100_RU_inactive_8.png','2010-04-13 10:25:00'),(0,'menu_100_picture_inactive_',8,'/usersimage/menu_100_UA_inactive_8.png','menu_100_picture_inactive_8',NULL,'UA','2010-04-13 12:24:42','/usersimage/menu_100_UA_inactive_8.png','2010-04-13 12:24:42'),(0,'menu_100_picture_inactive_',13,'/usersimage/menu_100_RU_inactive_13.png','menu_100_picture_inactive_13',NULL,'RU','2010-04-13 10:07:41','/usersimage/menu_100_RU_inactive_13.png','2010-04-13 10:07:41'),(0,'menu_100_picture_inactive_',13,'/usersimage/menu_100_UA_inactive_13.png','menu_100_picture_inactive_13',NULL,'UA','2010-04-13 12:23:19','/usersimage/menu_100_UA_inactive_13.png','2010-04-13 12:23:19'),(0,'menu_100_picture_inactive_',27,'/usersimage/menu_100_RU_inactive_27.png','menu_100_picture_inactive_27',NULL,'RU','2010-04-13 10:08:55','/usersimage/menu_100_RU_inactive_27.png','2010-04-13 10:08:55'),(0,'menu_100_picture_inactive_',27,'/usersimage/menu_100_UA_inactive_27.png','menu_100_picture_inactive_27',NULL,'UA','2010-04-13 08:21:55','/usersimage/menu_100_UA_inactive_27.png','2010-04-13 08:21:55'),(0,'menu_101_',1,' ','menu_101_1',NULL,'UA','2009-11-26 13:28:18',' ','2009-11-26 13:28:18'),(0,'menu_101_',2,'Про 36.6','menu_101_2',NULL,'UA','2009-11-26 13:37:04','Про 36.6','2009-11-26 13:37:04'),(0,'menu_101_',3,'Поточні проекти','menu_101_3',NULL,'UA','2009-11-26 14:02:47','Поточні проекти','2009-11-26 14:02:47'),(0,'menu_101_',4,'Моя 36.6','menu_101_4',NULL,'UA','2009-11-26 14:03:31','Моя 36.6','2009-11-26 14:03:31'),(0,'menu_101_',5,'Новини','menu_101_5',NULL,'UA','2009-11-26 14:04:15','Новини','2009-11-26 14:04:15'),(0,'menu_101_',6,'Підсумки досліджень','menu_101_6',NULL,'UA','2009-11-26 14:05:14','Підсумки досліджень','2009-11-26 14:05:14'),(0,'menu_10_',1,' ','menu_10_1',NULL,'UA','2009-11-26 13:28:18',' ','2009-11-26 13:28:18'),(0,'menu_10_',2,'TNS в Украине','menu_10_2',NULL,'RU','2010-03-01 13:16:38','TNS в Украине','2010-03-01 13:16:38'),(0,'menu_10_',2,'TNS в Україні','menu_10_2','','UA','2010-03-22 15:20:52','TNS в Україні','2010-03-22 15:20:52'),(0,'menu_10_',3,'Контакты','menu_10_3',NULL,'RU','2010-03-01 13:16:53','Контакты','2010-03-01 13:16:53'),(0,'menu_10_',3,'Контакти','menu_10_3','','UA','2011-03-18 10:02:53','Контакти','2011-03-18 10:02:53'),(0,'menu_10_',4,'Регистрация','menu_10_4',NULL,'RU','2010-03-01 13:17:14','Регистрация','2010-03-01 13:17:14'),(0,'menu_10_',4,'Реєстрація','menu_10_4','','UA','2010-03-22 15:20:58','Реєстрація','2010-03-22 15:20:58'),(0,'menu_10_',5,'Ви зашли как:','menu_10_5','','RU','2010-04-13 12:27:18','Ви зашли как:','2010-04-13 12:27:18'),(0,'menu_10_',5,'Ви зайшли як:','menu_10_5','','UA','2010-04-13 12:27:10','Ви зайшли як:','2010-04-13 12:27:10'),(0,'menu_10_',6,'Reset password','menu_10_6','','UA','2009-12-25 10:09:26','Reset password','2009-12-25 10:09:26'),(0,'menu_11_',1,' ','menu_11_1',NULL,'UA','2009-11-26 15:09:29',' ','2009-11-26 15:09:29'),(0,'menu_11_',2,'TNS в Україні','menu_11_2',NULL,'UA','2009-11-27 12:27:47','TNS в Україні','2009-11-27 12:27:47'),(0,'menu_11_',3,'Контакти','menu_11_3',NULL,'UA','2009-11-27 12:29:14','Контакти','2009-11-27 12:29:14'),(0,'menu_300_',1,' ','menu_300_1',NULL,'UA','2009-11-26 16:29:31',' ','2009-11-26 16:29:31'),(0,'menu_300_',2,'Карта сайта','menu_300_2',NULL,'RU','2010-04-09 13:32:49','Карта сайта','2010-04-09 13:32:49'),(0,'menu_300_',2,'Мапа сайту','menu_300_2','','UA','2010-04-09 13:32:42','Мапа сайту','2010-04-09 13:32:42'),(0,'menu_300_',3,'Конфиденциальность','menu_300_3',NULL,'RU','2010-04-09 13:33:28','Конфиденциальность','2010-04-09 13:33:28'),(0,'menu_300_',3,'Конфіденційність','menu_300_3','','UA','2010-04-09 13:33:19','Конфіденційність','2010-04-09 13:33:19'),(0,'menu_300_',4,'Ответственность','menu_300_4',NULL,'RU','2010-04-09 13:33:42','Ответственность','2010-04-09 13:33:42'),(0,'menu_300_',4,'Відповідальність','menu_300_4','','UA','2010-04-09 13:33:32','Відповідальність','2010-04-09 13:33:32'),(0,'menu_300_',5,'Правила участия','menu_300_5',NULL,'RU','2010-04-09 13:33:54','Правила участия','2010-04-09 13:33:54'),(0,'menu_300_',5,'Правила участі','menu_300_5','','UA','2010-04-09 13:33:48','Правила участі','2010-04-09 13:33:48'),(0,'menu_300_',6,'Условия акции','menu_300_6',NULL,'RU','2010-04-19 10:35:05','Условия акции','2010-04-19 10:35:05'),(0,'menu_300_',6,'Умови акції','menu_300_6','','UA','2011-01-11 15:34:14','Умови акції','2011-01-11 15:34:14'),(0,'menu_400101_',1,'  Запрошення надіслано','menu_400101_1','','UA','2010-07-13 12:52:15','  Запрошення надіслано','2010-07-13 12:52:15'),(0,'menu_40028_',1,' TNS в Україні','menu_40028_1','','UA','2010-01-13 14:36:00',' TNS в Україні','2010-01-13 14:36:00'),(0,'menu_40029_',1,'Ответственность','menu_40029_1',NULL,'RU','2010-04-13 13:24:32','Ответственность','2010-04-13 13:24:32'),(0,'menu_40029_',1,' Відповідальність','menu_40029_1','','UA','2010-01-13 14:26:45',' Відповідальність','2010-01-13 14:26:45'),(0,'menu_40030_',1,' Моя 36.6','menu_40030_1','','UA','2009-12-30 11:29:33',' Моя 36.6','2009-12-30 11:29:33'),(0,'menu_40031_',1,' ','menu_40031_1',NULL,'UA','2009-12-25 14:35:28',' ','2009-12-25 14:35:28'),(0,'menu_40032_',1,' Контакты','menu_40032_1',NULL,'RU','2011-03-18 10:06:43',' Контакты','2011-03-18 10:06:43'),(0,'menu_40032_',1,' Контакти','menu_40032_1','','UA','2010-01-13 14:37:08',' Контакти','2010-01-13 14:37:08'),(0,'menu_40033_',1,' Конфиденциальность','menu_40033_1',NULL,'RU','2010-04-13 13:23:06',' Конфиденциальность','2010-04-13 13:23:06'),(0,'menu_40033_',1,' Конфіденційність','menu_40033_1','','UA','2010-02-25 13:59:42',' Конфіденційність','2010-02-25 13:59:42'),(0,'menu_40034_',1,' Мапа сайту','menu_40034_1','','UA','2010-01-12 07:16:23',' Мапа сайту','2010-01-12 07:16:23'),(0,'menu_40035_',1,' ','menu_40035_1',NULL,'UA','2009-12-25 14:42:55',' ','2009-12-25 14:42:55'),(0,'menu_40036_',1,' ','menu_40036_1',NULL,'UA','2010-01-30 08:48:52',' ','2010-01-30 08:48:52'),(0,'menu_40037_',1,' ','menu_40037_1',NULL,'UA','2009-12-30 11:32:46',' ','2009-12-30 11:32:46'),(0,'menu_40038_',1,' ','menu_40038_1',NULL,'UA','2009-12-30 11:24:10',' ','2009-12-30 11:24:10'),(0,'menu_40039_',1,' ','menu_40039_1',NULL,'UA','2009-12-25 15:07:09',' ','2009-12-25 15:07:09'),(0,'menu_40045_',1,' Поточні проекти','menu_40045_1','','UA','2009-12-30 11:23:37',' Поточні проекти','2009-12-30 11:23:37'),(0,'menu_40046_',1,'Правила участия','menu_40046_1',NULL,'RU','2010-04-13 13:24:50','Правила участия','2010-04-13 13:24:50'),(0,'menu_40046_',1,'Правила участі','menu_40046_1','','UA','2010-01-13 14:25:47','Правила участі','2010-01-13 14:25:47'),(0,'menu_40047_',1,' ','menu_40047_1',NULL,'UA','2009-12-25 09:42:14',' ','2009-12-25 09:42:14'),(0,'menu_40048_',1,' ','menu_40048_1',NULL,'UA','2010-01-09 18:51:01',' ','2010-01-09 18:51:01'),(0,'menu_40049_',1,' ','menu_40049_1',NULL,'UA','2010-04-13 13:07:48',' ','2010-04-13 13:07:48'),(0,'menu_40052_',1,' ','menu_40052_1',NULL,'UA','2009-12-25 15:07:13',' ','2009-12-25 15:07:13'),(0,'menu_40054_',1,' ','menu_40054_1',NULL,'UA','2009-12-25 14:57:21',' ','2009-12-25 14:57:21'),(0,'menu_40057_',1,' Відновлення паролю','menu_40057_1','','UA','2009-12-13 19:49:20',' Відновлення паролю','2009-12-13 19:49:20'),(0,'menu_40059_',1,' Підтвердження реєстрації','menu_40059_1','','UA','2009-12-13 12:08:37',' Підтвердження реєстрації','2009-12-13 12:08:37'),(0,'menu_40060_',1,' Оновлення паролю','menu_40060_1','','UA','2010-01-28 16:55:08',' Оновлення паролю','2010-01-28 16:55:08'),(0,'menu_40061_',1,'Реєстрацію завершено','menu_40061_1','','UA','2010-01-14 18:36:54','Реєстрацію завершено','2010-01-14 18:36:54'),(0,'menu_40062_',1,'Підтвердження реєстрації','menu_40062_1','','UA','2010-01-27 04:52:25','Підтвердження реєстрації','2010-01-27 04:52:25'),(0,'menu_40063_',1,' Сторінка не знайдена','menu_40063_1','','UA','2009-12-13 12:04:32',' Сторінка не знайдена','2009-12-13 12:04:32'),(0,'menu_40064_',1,' Нагадування паролю','menu_40064_1','','UA','2010-02-01 16:39:39',' Нагадування паролю','2010-02-01 16:39:39'),(0,'menu_40066_',1,' Дані оновлено','menu_40066_1','','UA','2010-01-18 15:33:47',' Дані оновлено','2010-01-18 15:33:47'),(0,'menu_40067_',1,' Немає доступу','menu_40067_1','','UA','2009-12-29 21:57:37',' Немає доступу','2009-12-29 21:57:37'),(0,'menu_40068_',1,' Авторизація','menu_40068_1','','UA','2010-01-05 23:47:25',' Авторизація','2010-01-05 23:47:25'),(0,'menu_40088_',1,' Завершення проекту','menu_40088_1','','UA','2010-01-31 15:24:00',' Завершення проекту','2010-01-31 15:24:00'),(0,'menu_40089_',1,' ','menu_40089_1',NULL,'UA','2010-01-19 08:28:55',' ','2010-01-19 08:28:55'),(0,'menu_40090_',1,' Новий пароль збережено','menu_40090_1','','UA','2010-01-19 11:59:30',' Новий пароль збережено','2010-01-19 11:59:30'),(0,'menu_40093_',1,' Активація','menu_40093_1','','UA','2010-04-09 14:03:23',' Активація','2010-04-09 14:03:23'),(0,'menu_40099_',1,' Умови акції','menu_40099_1','','UA','2010-04-19 10:34:12',' Умови акції','2010-04-19 10:34:12'),(0,'menu_400_',1,' Підтвердження реєстрації','menu_400_1','','UA','2009-12-11 15:32:13',' Підтвердження реєстрації','2009-12-11 15:32:13'),(0,'menu_400_',2,'Підтвердження реєстрації','menu_400_2',NULL,'UA','2009-12-11 15:29:34','Підтвердження реєстрації','2009-12-11 15:29:34'),(0,'menu_900101_',1,' FAQ','menu_900101_1','','UA','2010-07-13 12:53:50',' FAQ','2010-07-13 12:53:50'),(0,'menu_90028_',1,' ','menu_90028_1',NULL,'UA','2010-04-14 12:02:55',' ','2010-04-14 12:02:55'),(0,'menu_90029_',1,'FAQ','menu_90029_1','','UA','2010-01-14 16:07:17','FAQ','2010-01-14 16:07:17'),(0,'menu_90029_',2,'Форма реєстрації','menu_90029_2',NULL,'UA','2010-01-14 16:08:57','Форма реєстрації','2010-01-14 16:08:57'),(0,'menu_90030_',1,'FAQ','menu_90030_1','','UA','2010-01-14 08:23:01','FAQ','2010-01-14 08:23:01'),(0,'menu_90030_',2,'Новости TNS Opros','menu_90030_2','','RU','2010-04-15 12:04:24','Новости TNS Opros','2010-04-15 12:04:24'),(0,'menu_90030_',2,'Новини TNS Opros','menu_90030_2','','UA','2010-04-15 12:04:33','Новини TNS Opros','2010-04-15 12:04:33'),(0,'menu_90031_',1,'FAQ','menu_90031_1','','UA','2010-01-14 08:55:23','FAQ','2010-01-14 08:55:23'),(0,'menu_90031_',2,'Система заохочення','menu_90031_2',NULL,'UA','2010-01-14 08:56:05','Система заохочення','2010-01-14 08:56:05'),(0,'menu_90032_',1,' ','menu_90032_1',NULL,'UA','2010-01-19 10:32:16',' ','2010-01-19 10:32:16'),(0,'menu_90033_',1,'FAQ','menu_90033_1','','UA','2010-01-14 16:07:48','FAQ','2010-01-14 16:07:48'),(0,'menu_90033_',2,'Форма регистрации','menu_90033_2',NULL,'RU','2010-04-13 13:24:04','Форма регистрации','2010-04-13 13:24:04'),(0,'menu_90033_',2,'Форма реєстрації','menu_90033_2',NULL,'UA','2010-01-14 16:10:06','Форма реєстрації','2010-01-14 16:10:06'),(0,'menu_90034_',1,'FAQ','menu_90034_1','','UA','2010-01-22 14:03:35','FAQ','2010-01-22 14:03:35'),(0,'menu_90035_',1,'FAQ','menu_90035_1',NULL,'RU','2010-04-12 08:50:47','FAQ','2010-04-12 08:50:47'),(0,'menu_90035_',1,'FAQ','menu_90035_1','','UA','2010-01-13 21:51:20','FAQ','2010-01-13 21:51:20'),(0,'menu_90035_',2,'Мої бали','menu_90035_2',NULL,'UA','2010-01-14 06:40:35','Мої бали','2010-01-14 06:40:35'),(0,'menu_90035_',3,'Результаты исследований','menu_90035_3',NULL,'RU','2010-04-12 08:52:16','Результаты исследований','2010-04-12 08:52:16'),(0,'menu_90035_',3,'Результати досліджень','menu_90035_3',NULL,'UA','2010-01-14 06:52:43','Результати досліджень','2010-01-14 06:52:43'),(0,'menu_90036_',1,' ','menu_90036_1',NULL,'UA','2010-01-30 08:48:52',' ','2010-01-30 08:48:52'),(0,'menu_90037_',1,'FAQ','menu_90037_1','','UA','2010-01-14 08:29:14','FAQ','2010-01-14 08:29:14'),(0,'menu_90037_',2,'Корисний контакт','menu_90037_2',NULL,'UA','2010-01-14 08:28:53','Корисний контакт','2010-01-14 08:28:53'),(0,'menu_90037_',3,'Новости TNS Opros','menu_90037_3',NULL,'RU','2010-04-15 14:00:59','Новости TNS Opros','2010-04-15 14:00:59'),(0,'menu_90037_',3,'Новини TNS Opros','menu_90037_3','','UA','2010-04-15 14:01:13','Новини TNS Opros','2010-04-15 14:01:13'),(0,'menu_90038_',1,' ','menu_90038_1',NULL,'UA','2010-03-29 17:53:44',' ','2010-03-29 17:53:44'),(0,'menu_90039_',1,'Полезный контакт','menu_90039_1',NULL,'RU','2010-04-13 12:34:02','Полезный контакт','2010-04-13 12:34:02'),(0,'menu_90039_',1,'Корисний контакт','menu_90039_1','','UA','2010-01-14 10:16:17','Корисний контакт','2010-01-14 10:16:17'),(0,'menu_90039_',2,'Результаты исследований','menu_90039_2',NULL,'RU','2010-04-13 12:34:56','Результаты исследований','2010-04-13 12:34:56'),(0,'menu_90039_',2,'Результати досліджень','menu_90039_2',NULL,'UA','2010-01-14 10:17:25','Результати досліджень','2010-01-14 10:17:25'),(0,'menu_90039_',3,'Поточні проекти','menu_90039_3',NULL,'UA','2010-01-14 10:18:25','Поточні проекти','2010-01-14 10:18:25'),(0,'menu_90040_',1,'FAQ','menu_90040_1','','UA','2010-01-14 09:59:18','FAQ','2010-01-14 09:59:18'),(0,'menu_90040_',2,'Форма регистрации','menu_90040_2',NULL,'RU','2010-04-12 15:26:40','Форма регистрации','2010-04-12 15:26:40'),(0,'menu_90040_',2,'Форма реєстрації','menu_90040_2',NULL,'UA','2010-01-14 10:00:16','Форма реєстрації','2010-01-14 10:00:16'),(0,'menu_90040_',3,'Результаты исследований','menu_90040_3',NULL,'RU','2010-04-12 15:27:01','Результаты исследований','2010-04-12 15:27:01'),(0,'menu_90040_',3,'Результати досліджень','menu_90040_3',NULL,'UA','2010-01-14 10:04:05','Результати досліджень','2010-01-14 10:04:05'),(0,'menu_90042_',1,'FAQ','menu_90042_1','','UA','2010-01-14 07:34:20','FAQ','2010-01-14 07:34:20'),(0,'menu_90042_',2,'Мої бали','menu_90042_2',NULL,'UA','2010-01-14 07:35:11','Мої бали','2010-01-14 07:35:11'),(0,'menu_90042_',3,'Результати досліджень','menu_90042_3',NULL,'UA','2010-01-14 07:36:13','Результати досліджень','2010-01-14 07:36:13'),(0,'menu_90043_',1,' ','menu_90043_1',NULL,'UA','2010-01-19 11:23:21',' ','2010-01-19 11:23:21'),(0,'menu_90045_',1,'FAQ','menu_90045_1','','UA','2010-01-14 07:56:50','FAQ','2010-01-14 07:56:50'),(0,'menu_90045_',2,'Мої бали','menu_90045_2',NULL,'UA','2010-01-14 07:57:43','Мої бали','2010-01-14 07:57:43'),(0,'menu_90045_',3,'TNS 36.6 Новини','menu_90045_3',NULL,'UA','2010-01-14 08:07:49','TNS 36.6 Новини','2010-01-14 08:07:49'),(0,'menu_90046_',1,'FAQ','menu_90046_1','','UA','2010-01-14 16:05:50','FAQ','2010-01-14 16:05:50'),(0,'menu_90046_',2,'Форма реєстрації','menu_90046_2',NULL,'UA','2010-01-14 16:11:01','Форма реєстрації','2010-01-14 16:11:01'),(0,'menu_90047_',1,'Полезный контакт','menu_90047_1',NULL,'RU','2010-04-13 12:32:09','Полезный контакт','2010-04-13 12:32:09'),(0,'menu_90047_',1,'Корисний контакт','menu_90047_1','','UA','2010-01-14 10:12:37','Корисний контакт','2010-01-14 10:12:37'),(0,'menu_90047_',2,'Новости TNS Opros','menu_90047_2',NULL,'RU','2010-04-13 12:31:39','Новости TNS Opros','2010-04-13 12:31:39'),(0,'menu_90047_',2,'TNS Opros Новини','menu_90047_2','','UA','2010-03-30 12:36:53','TNS Opros Новини','2010-03-30 12:36:53'),(0,'menu_90049_',1,' ','menu_90049_1',NULL,'UA','2010-04-13 13:07:48',' ','2010-04-13 13:07:48'),(0,'menu_90051_',1,'FAQ','menu_90051_1','','UA','2010-01-14 10:05:11','FAQ','2010-01-14 10:05:11'),(0,'menu_90051_',2,'Форма реєстрації','menu_90051_2',NULL,'UA','2010-01-14 10:06:16','Форма реєстрації','2010-01-14 10:06:16'),(0,'menu_90051_',3,'Результати досліджень','menu_90051_3',NULL,'UA','2010-01-14 10:07:38','Результати досліджень','2010-01-14 10:07:38'),(0,'menu_90052_',1,'Мої бали','menu_90052_1','','UA','2010-01-14 10:24:29','Мої бали','2010-01-14 10:24:29'),(0,'menu_90052_',2,'Корисний контакт','menu_90052_2','','UA','2010-01-29 17:47:31','Корисний контакт','2010-01-29 17:47:31'),(0,'menu_90052_',3,'Конвертація балів','menu_90052_3',NULL,'UA','2010-01-14 10:27:13','Конвертація балів','2010-01-14 10:27:13'),(0,'menu_90053_',1,' ','menu_90053_1',NULL,'UA','2010-01-19 11:23:35',' ','2010-01-19 11:23:35'),(0,'menu_90055_',1,'FAQ','menu_90055_1','','UA','2010-01-14 07:39:21','FAQ','2010-01-14 07:39:21'),(0,'menu_90055_',2,'Текущие исследования','menu_90055_2',NULL,'RU','2010-04-15 14:02:17','Текущие исследования','2010-04-15 14:02:17'),(0,'menu_90055_',2,'Поточні дослідження','menu_90055_2','','UA','2010-04-15 14:02:25','Поточні дослідження','2010-04-15 14:02:25'),(0,'menu_90055_',3,'Результаты исследований','menu_90055_3',NULL,'RU','2010-04-15 14:11:25','Результаты исследований','2010-04-15 14:11:25'),(0,'menu_90055_',3,'Результати досліджень','menu_90055_3',NULL,'UA','2010-01-14 07:51:18','Результати досліджень','2010-01-14 07:51:18'),(0,'menu_90057_',1,'FAQ','menu_90057_1','','UA','2010-01-14 10:45:36','FAQ','2010-01-14 10:45:36'),(0,'menu_90057_',2,'Корисний контакт','menu_90057_2','','UA','2010-01-14 11:50:32','Корисний контакт','2010-01-14 11:50:32'),(0,'menu_90059_',1,'Корисний контакт','menu_90059_1','','UA','2010-01-14 10:49:42','Корисний контакт','2010-01-14 10:49:42'),(0,'menu_90059_',2,'TNS 36.6 Новини','menu_90059_2',NULL,'UA','2010-01-14 10:50:44','TNS 36.6 Новини','2010-01-14 10:50:44'),(0,'menu_90060_',1,'FAQ','menu_90060_1','','UA','2010-01-28 16:55:34','FAQ','2010-01-28 16:55:34'),(0,'menu_90061_',1,'FAQ','menu_90061_1','','UA','2010-01-14 18:05:22','FAQ','2010-01-14 18:05:22'),(0,'menu_90062_',1,'FAQ','menu_90062_1','','UA','2010-01-27 04:52:53','FAQ','2010-01-27 04:52:53'),(0,'menu_90063_',1,'FAQ','menu_90063_1','','UA','2010-01-14 11:00:18','FAQ','2010-01-14 11:00:18'),(0,'menu_90064_',1,'FAQ','menu_90064_1','','UA','2010-02-01 16:40:19','FAQ','2010-02-01 16:40:19'),(0,'menu_90066_',1,'FAQ','menu_90066_1','','UA','2010-01-18 15:38:54','FAQ','2010-01-18 15:38:54'),(0,'menu_90067_',1,' ','menu_90067_1',NULL,'UA','2010-01-19 11:19:32',' ','2010-01-19 11:19:32'),(0,'menu_90068_',1,' FAQ','menu_90068_1','','UA','2010-01-14 06:37:42',' FAQ','2010-01-14 06:37:42'),(0,'menu_90068_',2,'Форма реєстрації','menu_90068_2',NULL,'UA','2010-01-14 06:35:16','Форма реєстрації','2010-01-14 06:35:16'),(0,'menu_90086_',1,'Форма регистрации','menu_90086_1',NULL,'RU','2010-04-13 13:35:35','Форма регистрации','2010-04-13 13:35:35'),(0,'menu_90086_',1,'Форма реєстрації','menu_90086_1','','UA','2010-01-14 10:09:31','Форма реєстрації','2010-01-14 10:09:31'),(0,'menu_90086_',2,'Результаты исследований','menu_90086_2',NULL,'RU','2010-04-13 13:35:53','Результаты исследований','2010-04-13 13:35:53'),(0,'menu_90086_',2,'Результати досліджень','menu_90086_2',NULL,'UA','2010-01-14 10:10:27','Результати досліджень','2010-01-14 10:10:27'),(0,'menu_90086_',3,'Полезный контакт','menu_90086_3',NULL,'RU','2010-04-13 13:34:22','Полезный контакт','2010-04-13 13:34:22'),(0,'menu_90086_',3,'Корисний контакт','menu_90086_3','','UA','2010-01-29 17:48:15','Корисний контакт','2010-01-29 17:48:15'),(0,'menu_90088_',1,'FAQ','menu_90088_1','','UA','2010-01-31 15:25:03','FAQ','2010-01-31 15:25:03'),(0,'menu_90089_',1,' ','menu_90089_1',NULL,'UA','2010-01-19 08:28:55',' ','2010-01-19 08:28:55'),(0,'menu_90090_',1,'FAQ','menu_90090_1','','UA','2010-01-19 11:59:55','FAQ','2010-01-19 11:59:55'),(0,'menu_90093_',1,' ','menu_90093_1',NULL,'UA','2010-04-09 13:30:08',' ','2010-04-09 13:30:08'),(0,'menu_90099_',1,' ','menu_90099_1',NULL,'UA','2010-04-19 10:33:16',' ','2010-04-19 10:33:16'),(0,'menu_lang_dependent_url_100_',1,'','menu_lang_dependent_url_100_1',NULL,'EN','2009-11-14 21:10:09','','2009-11-14 21:10:09'),(0,'menu_lang_dependent_url_100_',6,'','menu_lang_dependent_url_100_6',NULL,'UA','2009-12-11 13:22:58','','2009-12-11 13:22:58'),(0,'menu_lang_dependent_url_100_',9,'http://2kgroup.com/','menu_lang_dependent_url_100_9','','UA','2009-12-11 13:57:36','http://2kgroup.com/','2009-12-11 13:57:36'),(0,'menu_lang_dependent_url_100_',22,'','menu_lang_dependent_url_100_22',NULL,'UA','2010-01-12 08:32:05','','2010-01-12 08:32:05'),(0,'menu_lang_dependent_url_100_',23,'','menu_lang_dependent_url_100_23',NULL,'UA','2010-01-12 08:32:55','','2010-01-12 08:32:55'),(0,'menu_lang_dependent_url_100_',24,'','menu_lang_dependent_url_100_24',NULL,'UA','2010-01-12 08:33:57','','2010-01-12 08:33:57'),(0,'menu_lang_dependent_url_100_',25,'','menu_lang_dependent_url_100_25',NULL,'UA','2010-01-12 08:34:46','','2010-01-12 08:34:46'),(0,'menu_lang_dependent_url_100_',26,'','menu_lang_dependent_url_100_26',NULL,'UA','2010-01-12 08:35:39','','2010-01-12 08:35:39'),(0,'menu_lang_dependent_url_101_',1,'','menu_lang_dependent_url_101_1',NULL,'UA','2009-11-26 13:28:18','','2009-11-26 13:28:18'),(0,'menu_lang_dependent_url_101_',2,'','menu_lang_dependent_url_101_2',NULL,'UA','2009-11-26 13:37:04','','2009-11-26 13:37:04'),(0,'menu_lang_dependent_url_101_',3,'','menu_lang_dependent_url_101_3',NULL,'UA','2009-11-26 14:02:47','','2009-11-26 14:02:47'),(0,'menu_lang_dependent_url_101_',4,'','menu_lang_dependent_url_101_4',NULL,'UA','2009-11-26 14:03:31','','2009-11-26 14:03:31'),(0,'menu_lang_dependent_url_101_',5,'','menu_lang_dependent_url_101_5',NULL,'UA','2009-11-26 14:04:15','','2009-11-26 14:04:15'),(0,'menu_lang_dependent_url_101_',6,'','menu_lang_dependent_url_101_6',NULL,'UA','2009-11-26 14:05:14','','2009-11-26 14:05:14'),(0,'menu_lang_dependent_url_10_',1,'','menu_lang_dependent_url_10_1',NULL,'UA','2009-11-26 13:28:18','','2009-11-26 13:28:18'),(0,'menu_lang_dependent_url_10_',2,'http://www.tns-ua.com','menu_lang_dependent_url_10_2',NULL,'RU','2010-03-01 13:16:38','http://www.tns-ua.com','2010-03-01 13:16:38'),(0,'menu_lang_dependent_url_10_',2,'http://www.tns-ua.com','menu_lang_dependent_url_10_2','','UA','2010-03-22 15:20:52','http://www.tns-ua.com','2010-03-22 15:20:52'),(0,'menu_lang_dependent_url_10_',5,'#','menu_lang_dependent_url_10_5','','RU','2010-04-13 12:27:18','#','2010-04-13 12:27:18'),(0,'menu_lang_dependent_url_10_',5,'#','menu_lang_dependent_url_10_5','','UA','2010-04-13 12:27:10','#','2010-04-13 12:27:10'),(0,'menu_lang_dependent_url_11_',1,'','menu_lang_dependent_url_11_1',NULL,'UA','2009-11-26 15:09:29','','2009-11-26 15:09:29'),(0,'menu_lang_dependent_url_11_',2,'','menu_lang_dependent_url_11_2',NULL,'UA','2009-11-27 12:27:48','','2009-11-27 12:27:48'),(0,'menu_lang_dependent_url_11_',3,'','menu_lang_dependent_url_11_3',NULL,'UA','2009-11-27 12:29:14','','2009-11-27 12:29:14'),(0,'menu_lang_dependent_url_300_',1,'','menu_lang_dependent_url_300_1',NULL,'UA','2009-11-26 16:29:31','','2009-11-26 16:29:31'),(0,'menu_lang_dependent_url_40031_',1,'','menu_lang_dependent_url_40031_1',NULL,'UA','2009-12-25 14:35:28','','2009-12-25 14:35:28'),(0,'menu_lang_dependent_url_40035_',1,'','menu_lang_dependent_url_40035_1',NULL,'UA','2009-12-25 14:42:55','','2009-12-25 14:42:55'),(0,'menu_lang_dependent_url_40036_',1,'','menu_lang_dependent_url_40036_1',NULL,'UA','2010-01-30 08:48:52','','2010-01-30 08:48:52'),(0,'menu_lang_dependent_url_40037_',1,'','menu_lang_dependent_url_40037_1',NULL,'UA','2009-12-30 11:32:46','','2009-12-30 11:32:46'),(0,'menu_lang_dependent_url_40038_',1,'','menu_lang_dependent_url_40038_1',NULL,'UA','2009-12-30 11:24:10','','2009-12-30 11:24:10'),(0,'menu_lang_dependent_url_40039_',1,'','menu_lang_dependent_url_40039_1',NULL,'UA','2009-12-25 15:07:09','','2009-12-25 15:07:09'),(0,'menu_lang_dependent_url_40047_',1,'','menu_lang_dependent_url_40047_1',NULL,'UA','2009-12-25 09:42:14','','2009-12-25 09:42:14'),(0,'menu_lang_dependent_url_40048_',1,'','menu_lang_dependent_url_40048_1',NULL,'UA','2010-01-09 18:51:01','','2010-01-09 18:51:01'),(0,'menu_lang_dependent_url_40049_',1,'','menu_lang_dependent_url_40049_1',NULL,'UA','2010-04-13 13:07:48','','2010-04-13 13:07:48'),(0,'menu_lang_dependent_url_40052_',1,'','menu_lang_dependent_url_40052_1',NULL,'UA','2009-12-25 15:07:13','','2009-12-25 15:07:13'),(0,'menu_lang_dependent_url_40054_',1,'','menu_lang_dependent_url_40054_1',NULL,'UA','2009-12-25 14:57:21','','2009-12-25 14:57:21'),(0,'menu_lang_dependent_url_40089_',1,'','menu_lang_dependent_url_40089_1',NULL,'UA','2010-01-19 08:28:55','','2010-01-19 08:28:55'),(0,'menu_lang_dependent_url_400_',2,'','menu_lang_dependent_url_400_2',NULL,'UA','2009-12-11 15:29:34','','2009-12-11 15:29:34'),(0,'menu_lang_dependent_url_900101_',1,'#','menu_lang_dependent_url_900101_1','','UA','2010-07-13 12:53:50','#','2010-07-13 12:53:50'),(0,'menu_lang_dependent_url_90028_',1,'','menu_lang_dependent_url_90028_1',NULL,'UA','2010-04-14 12:02:55','','2010-04-14 12:02:55'),(0,'menu_lang_dependent_url_90029_',1,'#','menu_lang_dependent_url_90029_1','','UA','2010-01-14 16:07:17','#','2010-01-14 16:07:17'),(0,'menu_lang_dependent_url_90029_',2,'#','menu_lang_dependent_url_90029_2',NULL,'UA','2010-01-14 16:08:57','#','2010-01-14 16:08:57'),(0,'menu_lang_dependent_url_90030_',1,'#','menu_lang_dependent_url_90030_1','','UA','2010-01-14 08:23:01','#','2010-01-14 08:23:01'),(0,'menu_lang_dependent_url_90030_',2,'#','menu_lang_dependent_url_90030_2','','RU','2010-04-15 12:04:24','#','2010-04-15 12:04:24'),(0,'menu_lang_dependent_url_90030_',2,'#','menu_lang_dependent_url_90030_2','','UA','2010-04-15 12:04:33','#','2010-04-15 12:04:33'),(0,'menu_lang_dependent_url_90031_',1,'#','menu_lang_dependent_url_90031_1','','UA','2010-01-14 08:55:23','#','2010-01-14 08:55:23'),(0,'menu_lang_dependent_url_90031_',2,'#','menu_lang_dependent_url_90031_2',NULL,'UA','2010-01-14 08:56:05','#','2010-01-14 08:56:05'),(0,'menu_lang_dependent_url_90032_',1,'','menu_lang_dependent_url_90032_1',NULL,'UA','2010-01-19 10:32:16','','2010-01-19 10:32:16'),(0,'menu_lang_dependent_url_90033_',1,'#','menu_lang_dependent_url_90033_1','','UA','2010-01-14 16:07:48','#','2010-01-14 16:07:48'),(0,'menu_lang_dependent_url_90033_',2,'#','menu_lang_dependent_url_90033_2',NULL,'RU','2010-04-13 13:24:04','#','2010-04-13 13:24:04'),(0,'menu_lang_dependent_url_90033_',2,'#','menu_lang_dependent_url_90033_2',NULL,'UA','2010-01-14 16:10:06','#','2010-01-14 16:10:06'),(0,'menu_lang_dependent_url_90034_',1,'#','menu_lang_dependent_url_90034_1','','UA','2010-01-22 14:03:35','#','2010-01-22 14:03:35'),(0,'menu_lang_dependent_url_90035_',1,'#','menu_lang_dependent_url_90035_1',NULL,'RU','2010-04-12 08:50:47','#','2010-04-12 08:50:47'),(0,'menu_lang_dependent_url_90035_',1,'#','menu_lang_dependent_url_90035_1','','UA','2010-01-13 21:51:20','#','2010-01-13 21:51:20'),(0,'menu_lang_dependent_url_90035_',2,'№','menu_lang_dependent_url_90035_2',NULL,'UA','2010-01-14 06:40:35','№','2010-01-14 06:40:35'),(0,'menu_lang_dependent_url_90035_',3,'#','menu_lang_dependent_url_90035_3',NULL,'RU','2010-04-12 08:52:16','#','2010-04-12 08:52:16'),(0,'menu_lang_dependent_url_90035_',3,'#','menu_lang_dependent_url_90035_3',NULL,'UA','2010-01-14 06:52:43','#','2010-01-14 06:52:43'),(0,'menu_lang_dependent_url_90036_',1,'','menu_lang_dependent_url_90036_1',NULL,'UA','2010-01-30 08:48:52','','2010-01-30 08:48:52'),(0,'menu_lang_dependent_url_90037_',1,'#','menu_lang_dependent_url_90037_1','','UA','2010-01-14 08:29:14','#','2010-01-14 08:29:14'),(0,'menu_lang_dependent_url_90037_',2,'#','menu_lang_dependent_url_90037_2',NULL,'UA','2010-01-14 08:28:53','#','2010-01-14 08:28:53'),(0,'menu_lang_dependent_url_90037_',3,'#','menu_lang_dependent_url_90037_3',NULL,'RU','2010-04-15 14:00:59','#','2010-04-15 14:00:59'),(0,'menu_lang_dependent_url_90037_',3,'#','menu_lang_dependent_url_90037_3','','UA','2010-04-15 14:01:13','#','2010-04-15 14:01:13'),(0,'menu_lang_dependent_url_90038_',1,'','menu_lang_dependent_url_90038_1',NULL,'UA','2010-03-29 17:53:44','','2010-03-29 17:53:44'),(0,'menu_lang_dependent_url_90039_',1,'#','menu_lang_dependent_url_90039_1',NULL,'RU','2010-04-13 12:34:02','#','2010-04-13 12:34:02'),(0,'menu_lang_dependent_url_90039_',1,'#','menu_lang_dependent_url_90039_1','','UA','2010-01-14 10:16:17','#','2010-01-14 10:16:17'),(0,'menu_lang_dependent_url_90039_',2,'#','menu_lang_dependent_url_90039_2',NULL,'RU','2010-04-13 12:34:56','#','2010-04-13 12:34:56'),(0,'menu_lang_dependent_url_90039_',2,'#','menu_lang_dependent_url_90039_2',NULL,'UA','2010-01-14 10:17:25','#','2010-01-14 10:17:25'),(0,'menu_lang_dependent_url_90039_',3,'#','menu_lang_dependent_url_90039_3',NULL,'UA','2010-01-14 10:18:25','#','2010-01-14 10:18:25'),(0,'menu_lang_dependent_url_90040_',1,'#','menu_lang_dependent_url_90040_1','','UA','2010-01-14 09:59:18','#','2010-01-14 09:59:18'),(0,'menu_lang_dependent_url_90040_',2,'#','menu_lang_dependent_url_90040_2',NULL,'RU','2010-04-12 15:26:40','#','2010-04-12 15:26:40'),(0,'menu_lang_dependent_url_90040_',2,'#','menu_lang_dependent_url_90040_2',NULL,'UA','2010-01-14 10:00:16','#','2010-01-14 10:00:16'),(0,'menu_lang_dependent_url_90040_',3,'#','menu_lang_dependent_url_90040_3',NULL,'RU','2010-04-12 15:27:01','#','2010-04-12 15:27:01'),(0,'menu_lang_dependent_url_90040_',3,'#','menu_lang_dependent_url_90040_3',NULL,'UA','2010-01-14 10:04:05','#','2010-01-14 10:04:05'),(0,'menu_lang_dependent_url_90042_',1,'#','menu_lang_dependent_url_90042_1','','UA','2010-01-14 07:34:20','#','2010-01-14 07:34:20'),(0,'menu_lang_dependent_url_90042_',2,'#','menu_lang_dependent_url_90042_2',NULL,'UA','2010-01-14 07:35:11','#','2010-01-14 07:35:11'),(0,'menu_lang_dependent_url_90042_',3,'#','menu_lang_dependent_url_90042_3',NULL,'UA','2010-01-14 07:36:13','#','2010-01-14 07:36:13'),(0,'menu_lang_dependent_url_90043_',1,'','menu_lang_dependent_url_90043_1',NULL,'UA','2010-01-19 11:23:21','','2010-01-19 11:23:21'),(0,'menu_lang_dependent_url_90045_',1,'#','menu_lang_dependent_url_90045_1','','UA','2010-01-14 07:56:50','#','2010-01-14 07:56:50'),(0,'menu_lang_dependent_url_90045_',2,'#','menu_lang_dependent_url_90045_2',NULL,'UA','2010-01-14 07:57:43','#','2010-01-14 07:57:43'),(0,'menu_lang_dependent_url_90045_',3,'#','menu_lang_dependent_url_90045_3',NULL,'UA','2010-01-14 08:07:49','#','2010-01-14 08:07:49'),(0,'menu_lang_dependent_url_90046_',1,'#','menu_lang_dependent_url_90046_1','','UA','2010-01-14 16:05:50','#','2010-01-14 16:05:50'),(0,'menu_lang_dependent_url_90046_',2,'#','menu_lang_dependent_url_90046_2',NULL,'UA','2010-01-14 16:11:01','#','2010-01-14 16:11:01'),(0,'menu_lang_dependent_url_90047_',1,'#','menu_lang_dependent_url_90047_1',NULL,'RU','2010-04-13 12:32:09','#','2010-04-13 12:32:09'),(0,'menu_lang_dependent_url_90047_',1,'#','menu_lang_dependent_url_90047_1','','UA','2010-01-14 10:12:37','#','2010-01-14 10:12:37'),(0,'menu_lang_dependent_url_90047_',2,'#','menu_lang_dependent_url_90047_2',NULL,'RU','2010-04-13 12:31:39','#','2010-04-13 12:31:39'),(0,'menu_lang_dependent_url_90047_',2,'#','menu_lang_dependent_url_90047_2','','UA','2010-03-30 12:36:53','#','2010-03-30 12:36:53'),(0,'menu_lang_dependent_url_90049_',1,'','menu_lang_dependent_url_90049_1',NULL,'UA','2010-04-13 13:07:48','','2010-04-13 13:07:48'),(0,'menu_lang_dependent_url_90051_',1,'#','menu_lang_dependent_url_90051_1','','UA','2010-01-14 10:05:11','#','2010-01-14 10:05:11'),(0,'menu_lang_dependent_url_90051_',2,'#','menu_lang_dependent_url_90051_2',NULL,'UA','2010-01-14 10:06:16','#','2010-01-14 10:06:16'),(0,'menu_lang_dependent_url_90051_',3,'#','menu_lang_dependent_url_90051_3',NULL,'UA','2010-01-14 10:07:39','#','2010-01-14 10:07:39'),(0,'menu_lang_dependent_url_90052_',1,'#','menu_lang_dependent_url_90052_1','','UA','2010-01-14 10:24:29','#','2010-01-14 10:24:29'),(0,'menu_lang_dependent_url_90052_',2,'#','menu_lang_dependent_url_90052_2','','UA','2010-01-29 17:47:31','#','2010-01-29 17:47:31'),(0,'menu_lang_dependent_url_90052_',3,'#','menu_lang_dependent_url_90052_3',NULL,'UA','2010-01-14 10:27:13','#','2010-01-14 10:27:13'),(0,'menu_lang_dependent_url_90053_',1,'','menu_lang_dependent_url_90053_1',NULL,'UA','2010-01-19 11:23:35','','2010-01-19 11:23:35'),(0,'menu_lang_dependent_url_90055_',1,'#','menu_lang_dependent_url_90055_1','','UA','2010-01-14 07:39:21','#','2010-01-14 07:39:21'),(0,'menu_lang_dependent_url_90055_',2,'#','menu_lang_dependent_url_90055_2',NULL,'RU','2010-04-15 14:02:17','#','2010-04-15 14:02:17'),(0,'menu_lang_dependent_url_90055_',2,'#','menu_lang_dependent_url_90055_2','','UA','2010-04-15 14:02:25','#','2010-04-15 14:02:25'),(0,'menu_lang_dependent_url_90055_',3,'#','menu_lang_dependent_url_90055_3',NULL,'RU','2010-04-15 14:11:25','#','2010-04-15 14:11:25'),(0,'menu_lang_dependent_url_90055_',3,'#','menu_lang_dependent_url_90055_3',NULL,'UA','2010-01-14 07:51:18','#','2010-01-14 07:51:18'),(0,'menu_lang_dependent_url_90057_',1,'#','menu_lang_dependent_url_90057_1','','UA','2010-01-14 10:45:36','#','2010-01-14 10:45:36'),(0,'menu_lang_dependent_url_90057_',2,'#','menu_lang_dependent_url_90057_2','','UA','2010-01-14 11:50:32','#','2010-01-14 11:50:32'),(0,'menu_lang_dependent_url_90059_',1,'#','menu_lang_dependent_url_90059_1','','UA','2010-01-14 10:49:42','#','2010-01-14 10:49:42'),(0,'menu_lang_dependent_url_90059_',2,'#','menu_lang_dependent_url_90059_2',NULL,'UA','2010-01-14 10:50:44','#','2010-01-14 10:50:44'),(0,'menu_lang_dependent_url_90060_',1,'#','menu_lang_dependent_url_90060_1','','UA','2010-01-28 16:55:34','#','2010-01-28 16:55:34'),(0,'menu_lang_dependent_url_90061_',1,'#','menu_lang_dependent_url_90061_1','','UA','2010-01-14 18:05:22','#','2010-01-14 18:05:22'),(0,'menu_lang_dependent_url_90062_',1,'#','menu_lang_dependent_url_90062_1','','UA','2010-01-27 04:52:53','#','2010-01-27 04:52:53'),(0,'menu_lang_dependent_url_90063_',1,'#','menu_lang_dependent_url_90063_1','','UA','2010-01-14 11:00:18','#','2010-01-14 11:00:18'),(0,'menu_lang_dependent_url_90064_',1,'#','menu_lang_dependent_url_90064_1','','UA','2010-02-01 16:40:19','#','2010-02-01 16:40:19'),(0,'menu_lang_dependent_url_90066_',1,'#','menu_lang_dependent_url_90066_1','','UA','2010-01-18 15:38:54','#','2010-01-18 15:38:54'),(0,'menu_lang_dependent_url_90067_',1,'','menu_lang_dependent_url_90067_1',NULL,'UA','2010-01-19 11:19:32','','2010-01-19 11:19:32'),(0,'menu_lang_dependent_url_90068_',1,'#','menu_lang_dependent_url_90068_1','','UA','2010-01-14 06:37:42','#','2010-01-14 06:37:42'),(0,'menu_lang_dependent_url_90068_',2,'#','menu_lang_dependent_url_90068_2',NULL,'UA','2010-01-14 06:35:16','#','2010-01-14 06:35:16'),(0,'menu_lang_dependent_url_90086_',1,'#','menu_lang_dependent_url_90086_1',NULL,'RU','2010-04-13 13:35:35','#','2010-04-13 13:35:35'),(0,'menu_lang_dependent_url_90086_',1,'#','menu_lang_dependent_url_90086_1','','UA','2010-01-14 10:09:31','#','2010-01-14 10:09:31'),(0,'menu_lang_dependent_url_90086_',2,'#','menu_lang_dependent_url_90086_2',NULL,'RU','2010-04-13 13:35:53','#','2010-04-13 13:35:53'),(0,'menu_lang_dependent_url_90086_',2,'#','menu_lang_dependent_url_90086_2',NULL,'UA','2010-01-14 10:10:27','#','2010-01-14 10:10:27'),(0,'menu_lang_dependent_url_90086_',3,'#','menu_lang_dependent_url_90086_3',NULL,'RU','2010-04-13 13:34:22','#','2010-04-13 13:34:22'),(0,'menu_lang_dependent_url_90086_',3,'#','menu_lang_dependent_url_90086_3','','UA','2010-01-29 17:48:15','#','2010-01-29 17:48:15'),(0,'menu_lang_dependent_url_90088_',1,'#','menu_lang_dependent_url_90088_1','','UA','2010-01-31 15:25:03','#','2010-01-31 15:25:03'),(0,'menu_lang_dependent_url_90089_',1,'','menu_lang_dependent_url_90089_1',NULL,'UA','2010-01-19 08:28:55','','2010-01-19 08:28:55'),(0,'menu_lang_dependent_url_90090_',1,'#','menu_lang_dependent_url_90090_1','','UA','2010-01-19 11:59:55','#','2010-01-19 11:59:55'),(0,'menu_lang_dependent_url_90093_',1,'','menu_lang_dependent_url_90093_1',NULL,'UA','2010-04-09 13:30:08','','2010-04-09 13:30:08'),(0,'menu_lang_dependent_url_90099_',1,'','menu_lang_dependent_url_90099_1',NULL,'UA','2010-04-19 10:33:16','','2010-04-19 10:33:16'),(0,'menu_structure_',10,'a:4:{i:2;a:9:{s:3:\"url\";s:21:\"http://www.tns-ua.com\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"32\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:4;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"47\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:5;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"you_are_logged_as\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_10','','','2011-03-18 10:02:53','a:4:{i:2;a:9:{s:3:\"url\";s:21:\"http://www.tns-ua.com\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"32\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:4;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"47\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:5;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"you_are_logged_as\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2011-03-18 10:02:53'),(0,'menu_structure_',11,'a:2:{i:2;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"28\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:3;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"32\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}}','menu_structure_11','','','2009-12-11 14:08:20','a:2:{i:2;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"28\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:3;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"32\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}}','2009-12-11 14:08:20'),(0,'menu_structure_',100,'a:23:{i:2;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"999999\";s:3:\"sat\";s:2:\"35\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"FF0093\";s:3:\"sat\";s:2:\"47\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:7;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"FF0093\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:8;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"47B3B8\";s:3:\"sat\";s:2:\"30\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:10;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"47\";s:6:\"parent\";s:1:\"3\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:11;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"39\";s:6:\"parent\";s:1:\"3\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:12;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"52\";s:6:\"parent\";s:1:\"3\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:13;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"0086D4\";s:3:\"sat\";s:1:\"1\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:14;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";s:1:\"7\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:15;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"30\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:16;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"37\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:17;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"31\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:19;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"35\";s:6:\"parent\";s:1:\"2\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:20;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"42\";s:6:\"parent\";s:1:\"2\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:21;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"55\";s:6:\"parent\";s:1:\"2\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:23;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:1:\"1\";s:6:\"parent\";s:2:\"13\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:25;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"44\";s:6:\"parent\";s:1:\"4\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:26;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"53\";s:6:\"parent\";s:1:\"4\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:27;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"8A81BA\";s:3:\"sat\";s:2:\"40\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:31;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:28;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"40\";s:6:\"parent\";s:2:\"27\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:29;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"51\";s:6:\"parent\";s:2:\"27\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:30;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"86\";s:6:\"parent\";s:2:\"27\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:31;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"52\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_100','','','2010-06-30 09:04:10','a:23:{i:2;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"999999\";s:3:\"sat\";s:2:\"35\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"FF0093\";s:3:\"sat\";s:2:\"47\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:7;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"FF0093\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:8;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"47B3B8\";s:3:\"sat\";s:2:\"30\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:10;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"47\";s:6:\"parent\";s:1:\"3\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:11;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"39\";s:6:\"parent\";s:1:\"3\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:12;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"52\";s:6:\"parent\";s:1:\"3\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:13;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"0086D4\";s:3:\"sat\";s:1:\"1\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:14;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";s:1:\"7\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:15;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"30\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:16;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"37\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:17;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"31\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:19;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"35\";s:6:\"parent\";s:1:\"2\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:20;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"42\";s:6:\"parent\";s:1:\"2\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:21;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"55\";s:6:\"parent\";s:1:\"2\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:23;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:1:\"1\";s:6:\"parent\";s:2:\"13\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:25;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"44\";s:6:\"parent\";s:1:\"4\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:26;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"53\";s:6:\"parent\";s:1:\"4\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:27;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:6:\"8A81BA\";s:3:\"sat\";s:2:\"40\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:31;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:28;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"40\";s:6:\"parent\";s:2:\"27\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:29;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"51\";s:6:\"parent\";s:2:\"27\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:30;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"86\";s:6:\"parent\";s:2:\"27\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:31;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"52\";s:6:\"parent\";s:1:\"8\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-06-30 09:04:10'),(0,'menu_structure_',101,'a:6:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}i:2;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"48\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:3;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:4;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"38\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:5;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"40\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:6;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"43\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:5;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}}','menu_structure_101','','','2009-11-26 14:05:14','a:6:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}i:2;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"48\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:3;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:4;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"38\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:5;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"40\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}i:6;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"43\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:5;s:6:\"shadow\";b:0;s:4:\"type\";s:0:\"\";}}','2009-11-26 14:05:14'),(0,'menu_structure_',300,'a:5:{i:2;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"34\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"33\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:4;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"29\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:5;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"46\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:6;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"99\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:5;s:6:\"shadow\";s:5:\"admin\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_300','','','2011-01-11 15:34:14','a:5:{i:2;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"34\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"33\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:4;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"29\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:3;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:5;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"46\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:4;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:6;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"99\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:5;s:6:\"shadow\";s:5:\"admin\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2011-01-11 15:34:14'),(0,'menu_structure_',400,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"59\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','menu_structure_400','','','2009-12-11 15:32:13','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"59\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','2009-12-11 15:32:13'),(0,'menu_structure_',40028,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"28\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40028','','','2010-01-13 14:36:00','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"28\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-13 14:36:00'),(0,'menu_structure_',40029,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"29\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40029','','','2010-04-13 13:24:32','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"29\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-13 13:24:32'),(0,'menu_structure_',40030,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"38\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','menu_structure_40030','','','2009-12-30 11:29:33','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"38\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','2009-12-30 11:29:33'),(0,'menu_structure_',40031,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40031','','','2009-12-25 14:35:28','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-25 14:35:28'),(0,'menu_structure_',40032,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"32\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40032','','','2011-03-18 10:06:43','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"32\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2011-03-18 10:06:43'),(0,'menu_structure_',40033,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"33\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40033','','','2010-04-13 13:23:06','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"33\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-13 13:23:06'),(0,'menu_structure_',40034,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"34\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40034','','','2010-01-12 07:16:23','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"34\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-12 07:16:23'),(0,'menu_structure_',40035,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40035','','','2009-12-25 14:42:55','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-25 14:42:55'),(0,'menu_structure_',40036,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_40036','','','2010-01-30 08:48:52','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-30 08:48:52'),(0,'menu_structure_',40037,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40037','','','2009-12-30 11:32:46','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-30 11:32:46'),(0,'menu_structure_',40038,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40038','','','2009-12-30 11:24:10','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-30 11:24:10'),(0,'menu_structure_',40039,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40039','','','2009-12-25 15:07:09','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-25 15:07:09'),(0,'menu_structure_',40040,'a:0:{}','',NULL,'','2009-12-17 14:59:07','a:0:{}','2009-12-17 14:59:07'),(0,'menu_structure_',40041,'a:0:{}','',NULL,'','2010-01-19 13:56:20','a:0:{}','2010-01-19 13:56:20'),(0,'menu_structure_',40042,'a:0:{}','',NULL,'','2010-01-09 18:59:55','a:0:{}','2010-01-09 18:59:55'),(0,'menu_structure_',40043,'a:0:{}','',NULL,'','2009-12-25 14:25:34','a:0:{}','2009-12-25 14:25:34'),(0,'menu_structure_',40044,'a:0:{}','',NULL,'','2010-02-17 22:07:41','a:0:{}','2010-02-17 22:07:41'),(0,'menu_structure_',40045,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','menu_structure_40045','','','2009-12-30 11:23:37','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"45\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','2009-12-30 11:23:37'),(0,'menu_structure_',40046,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"46\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40046','','','2010-04-13 13:24:50','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"46\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-13 13:24:50'),(0,'menu_structure_',40047,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40047','','','2009-12-25 09:42:14','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-25 09:42:14'),(0,'menu_structure_',40048,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_40048','','','2010-01-09 18:51:01','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-09 18:51:01'),(0,'menu_structure_',40049,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_40049','','','2010-04-13 13:07:48','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-04-13 13:07:48'),(0,'menu_structure_',40050,'a:0:{}','',NULL,'','2010-02-17 22:07:59','a:0:{}','2010-02-17 22:07:59'),(0,'menu_structure_',40051,'a:0:{}','',NULL,'','2010-01-14 10:04:30','a:0:{}','2010-01-14 10:04:30'),(0,'menu_structure_',40052,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40052','','','2009-12-25 15:07:13','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-25 15:07:13'),(0,'menu_structure_',40053,'a:0:{}','',NULL,'','2010-01-19 11:23:35','a:0:{}','2010-01-19 11:23:35'),(0,'menu_structure_',40054,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','menu_structure_40054','','','2009-12-25 14:57:21','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;}}','2009-12-25 14:57:21'),(0,'menu_structure_',40055,'a:0:{}','',NULL,'','2010-01-09 19:00:10','a:0:{}','2010-01-09 19:00:10'),(0,'menu_structure_',40057,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"57\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";}}','menu_structure_40057','','','2009-12-13 19:49:21','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"57\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";}}','2009-12-13 19:49:21'),(0,'menu_structure_',40059,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"59\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','menu_structure_40059','','','2009-12-13 12:08:37','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"59\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','2009-12-13 12:08:37'),(0,'menu_structure_',40060,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"60\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40060','','','2010-01-28 16:55:08','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"60\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-28 16:55:08'),(0,'menu_structure_',40061,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"61\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40061','','','2010-01-14 18:36:54','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"61\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 18:36:54'),(0,'menu_structure_',40062,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"62\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40062','','','2010-01-27 04:52:25','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"62\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-27 04:52:25'),(0,'menu_structure_',40063,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"63\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','menu_structure_40063','','','2009-12-13 12:04:32','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"63\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','2009-12-13 12:04:32'),(0,'menu_structure_',40064,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"64\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40064','','','2010-02-01 16:39:39','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"64\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-02-01 16:39:39'),(0,'menu_structure_',40065,'a:0:{}','',NULL,'','2009-12-25 12:06:59','a:0:{}','2009-12-25 12:06:59'),(0,'menu_structure_',40066,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"66\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40066','','','2010-01-18 15:33:47','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"66\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-18 15:33:47'),(0,'menu_structure_',40067,'a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"67\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','menu_structure_40067','','','2009-12-29 21:57:38','a:1:{i:1;a:8:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"67\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";}}','2009-12-29 21:57:38'),(0,'menu_structure_',40068,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"68\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40068','','','2010-01-05 23:47:25','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"68\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-05 23:47:25'),(0,'menu_structure_',40086,'a:0:{}','',NULL,'','2010-01-13 11:54:49','a:0:{}','2010-01-13 11:54:49'),(0,'menu_structure_',40088,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"88\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40088','','','2010-01-31 15:24:00','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"88\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-31 15:24:00'),(0,'menu_structure_',40089,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_40089','','','2010-01-19 08:28:55','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-19 08:28:55'),(0,'menu_structure_',40090,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"90\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40090','','','2010-01-19 11:59:30','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"90\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-19 11:59:30'),(0,'menu_structure_',40093,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"93\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40093','','','2010-04-09 14:03:23','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"93\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-09 14:03:23'),(0,'menu_structure_',40099,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"99\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_40099','','','2010-04-19 10:34:12','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:2:\"99\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:2:\"-1\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-19 10:34:12'),(0,'menu_structure_',90028,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90028','','','2010-04-14 12:02:55','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-04-14 12:02:55'),(0,'menu_structure_',90029,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90029','','','2010-01-14 16:08:57','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 16:08:57'),(0,'menu_structure_',90030,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90030','','','2010-04-15 12:04:33','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-15 12:04:33'),(0,'menu_structure_',90031,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:6:\"system\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90031','','','2010-01-14 08:56:05','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:6:\"system\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 08:56:05'),(0,'menu_structure_',90032,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90032','','','2010-01-19 10:32:16','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-19 10:32:16'),(0,'menu_structure_',90033,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90033','','','2010-04-13 13:24:04','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-13 13:24:04'),(0,'menu_structure_',90034,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90034','','','2010-01-22 14:03:35','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-22 14:03:35'),(0,'menu_structure_',90035,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:3:\"№\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90035','','','2010-04-12 08:52:16','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:3:\"№\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-12 08:52:16'),(0,'menu_structure_',90036,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90036','','','2010-01-30 08:48:52','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-30 08:48:52'),(0,'menu_structure_',90037,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:-1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:5;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90037','','','2010-04-15 14:01:13','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:-1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:5;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-15 14:01:13'),(0,'menu_structure_',90038,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90038','','','2010-03-29 17:53:44','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-03-29 17:53:44'),(0,'menu_structure_',90039,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:16:\"current_projects\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:30;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90039','','','2010-04-13 12:34:56','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:16:\"current_projects\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:30;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-13 12:34:56'),(0,'menu_structure_',90040,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90040','','','2010-04-12 15:27:01','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-12 15:27:01'),(0,'menu_structure_',90041,'a:0:{}','',NULL,'','2010-01-19 13:56:20','a:0:{}','2010-01-19 13:56:20'),(0,'menu_structure_',90042,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90042','','','2010-01-14 07:36:13','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 07:36:13'),(0,'menu_structure_',90043,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90043','','','2010-01-19 11:23:21','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-19 11:23:21'),(0,'menu_structure_',90044,'a:0:{}','',NULL,'','2010-02-17 22:07:41','a:0:{}','2010-02-17 22:07:41'),(0,'menu_structure_',90045,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90045','','','2010-01-14 08:07:49','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 08:07:49'),(0,'menu_structure_',90046,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90046','','','2010-01-14 16:11:01','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 16:11:01'),(0,'menu_structure_',90047,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90047','','','2010-04-13 12:32:09','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-13 12:32:09'),(0,'menu_structure_',90048,'a:0:{}','',NULL,'','2010-01-19 13:55:51','a:0:{}','2010-01-19 13:55:51'),(0,'menu_structure_',90049,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90049','','','2010-04-13 13:07:48','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-04-13 13:07:48'),(0,'menu_structure_',90050,'a:0:{}','',NULL,'','2010-02-17 22:07:59','a:0:{}','2010-02-17 22:07:59'),(0,'menu_structure_',90051,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90051','','','2010-01-29 15:54:25','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-29 15:54:25'),(0,'menu_structure_',90052,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"points_convertion\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:30;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90052','','','2010-01-29 17:47:31','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:9:\"my_points\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"points_convertion\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:30;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-29 17:47:31'),(0,'menu_structure_',90053,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90053','','','2010-01-19 11:23:35','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-19 11:23:35'),(0,'menu_structure_',90055,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:16:\"current_projects\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90055','','','2010-04-15 14:11:25','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:16:\"current_projects\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:4:\"auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:2;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-15 14:11:25'),(0,'menu_structure_',90057,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90057','','','2010-01-14 11:50:32','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 11:50:32'),(0,'menu_structure_',90059,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90059','','','2010-01-14 10:50:44','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:4:\"news\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 10:50:44'),(0,'menu_structure_',90060,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90060','','','2010-01-28 16:55:34','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-28 16:55:34'),(0,'menu_structure_',90061,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90061','','','2010-01-14 18:05:22','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 18:05:22'),(0,'menu_structure_',90062,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90062','','','2010-01-27 04:52:53','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-27 04:52:53'),(0,'menu_structure_',90063,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90063','','','2010-01-14 11:00:18','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 11:00:18'),(0,'menu_structure_',90064,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90064','','','2010-02-01 16:40:19','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-02-01 16:40:19'),(0,'menu_structure_',90065,'a:0:{}','',NULL,'','2010-01-18 19:00:18','a:0:{}','2010-01-18 19:00:18'),(0,'menu_structure_',90066,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90066','','','2010-01-18 15:38:54','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-18 15:38:54'),(0,'menu_structure_',90067,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90067','','','2010-01-19 11:19:32','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-19 11:19:32'),(0,'menu_structure_',90068,'a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90068','','','2010-01-14 06:37:42','a:2:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:6:\"_blank\";s:5:\"order\";i:10;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:1;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-14 06:37:42'),(0,'menu_structure_',90086,'a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:-1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90086','','','2010-04-13 13:35:53','a:3:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:17:\"registration_form\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:10;s:6:\"shadow\";s:8:\"not_auth\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:2;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"results\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:20;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}i:3;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:7:\"contact\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:-1;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-04-13 13:35:53'),(0,'menu_structure_',90088,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90088','','','2010-01-31 15:25:03','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-31 15:25:03'),(0,'menu_structure_',90089,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90089','','','2010-01-19 08:28:55','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-01-19 08:28:55'),(0,'menu_structure_',90090,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_90090','','','2010-01-19 11:59:55','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-01-19 11:59:55'),(0,'menu_structure_',90093,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90093','','','2010-04-09 13:30:08','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-04-09 13:30:08'),(0,'menu_structure_',90099,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','menu_structure_90099','','','2010-04-19 10:33:16','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";N;s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:0:\"\";s:5:\"order\";i:0;s:6:\"shadow\";i:0;s:4:\"type\";N;s:8:\"selected\";N;}}','2010-04-19 10:33:16'),(0,'menu_structure_',400101,'a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:3:\"101\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_400101','','','2010-07-13 12:52:15','a:1:{i:1;a:9:{s:3:\"url\";s:0:\"\";s:4:\"code\";s:0:\"\";s:3:\"sat\";s:3:\"101\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-07-13 12:52:15'),(0,'menu_structure_',900101,'a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','menu_structure_900101','','','2010-07-13 12:53:50','a:1:{i:1;a:9:{s:3:\"url\";s:1:\"#\";s:4:\"code\";s:3:\"faq\";s:3:\"sat\";s:0:\"\";s:6:\"parent\";i:0;s:9:\"open_type\";s:4:\"self\";s:5:\"order\";i:0;s:6:\"shadow\";s:0:\"\";s:4:\"type\";s:0:\"\";s:8:\"selected\";N;}}','2010-07-13 12:53:50'),(0,'menu_title_100_',1,NULL,'menu_title_100_1',NULL,'EN','2009-11-14 21:10:09',NULL,'2009-11-14 21:10:09'),(0,'menu_title_100_',2,'','menu_title_100_2','','RU','2010-04-13 10:08:13','','2010-04-13 10:08:13'),(0,'menu_title_100_',2,'','menu_title_100_2','','UA','2010-04-13 12:23:52','','2010-04-13 12:23:52'),(0,'menu_title_100_',3,'','menu_title_100_3','','RU','2010-04-13 10:08:34','','2010-04-13 10:08:34'),(0,'menu_title_100_',3,'','menu_title_100_3','','UA','2010-04-13 08:22:43','','2010-04-13 08:22:43'),(0,'menu_title_100_',4,'','menu_title_100_4','','UA','2010-01-13 12:02:58','','2010-01-13 12:02:58'),(0,'menu_title_100_',5,'','menu_title_100_5','','UA','2010-01-13 12:02:31','','2010-01-13 12:02:31'),(0,'menu_title_100_',6,'','menu_title_100_6',NULL,'UA','2009-12-11 13:22:58','','2009-12-11 13:22:58'),(0,'menu_title_100_',7,'','menu_title_100_7','','RU','2010-04-13 10:23:52','','2010-04-13 10:23:52'),(0,'menu_title_100_',7,'','menu_title_100_7','','UA','2010-04-13 12:24:15','','2010-04-13 12:24:15'),(0,'menu_title_100_',8,'','menu_title_100_8','','RU','2010-04-13 10:25:00','','2010-04-13 10:25:00'),(0,'menu_title_100_',8,'','menu_title_100_8','','UA','2010-04-13 12:24:42','','2010-04-13 12:24:42'),(0,'menu_title_100_',9,'','menu_title_100_9','','UA','2009-12-11 13:57:36','','2009-12-11 13:57:36'),(0,'menu_title_100_',10,'','menu_title_100_10',NULL,'RU','2010-03-29 17:33:23','','2010-03-29 17:33:23'),(0,'menu_title_100_',10,'','menu_title_100_10','','UA','2010-03-29 17:33:13','','2010-03-29 17:33:13'),(0,'menu_title_100_',11,'','menu_title_100_11',NULL,'RU','2010-03-29 17:33:40','','2010-03-29 17:33:40'),(0,'menu_title_100_',11,'','menu_title_100_11','','UA','2010-03-29 17:33:29','','2010-03-29 17:33:29'),(0,'menu_title_100_',12,'','menu_title_100_12',NULL,'RU','2010-03-29 17:34:33','','2010-03-29 17:34:33'),(0,'menu_title_100_',12,'','menu_title_100_12','','UA','2010-03-29 17:34:29','','2010-03-29 17:34:29'),(0,'menu_title_100_',13,'','menu_title_100_13','','RU','2010-04-13 12:22:58','','2010-04-13 12:22:58'),(0,'menu_title_100_',13,'','menu_title_100_13','','UA','2010-04-13 12:23:25','','2010-04-13 12:23:25'),(0,'menu_title_100_',14,'','menu_title_100_14',NULL,'RU','2010-03-29 18:00:27','','2010-03-29 18:00:27'),(0,'menu_title_100_',14,'','menu_title_100_14','','UA','2010-03-29 18:00:15','','2010-03-29 18:00:15'),(0,'menu_title_100_',15,'','menu_title_100_15',NULL,'RU','2010-03-29 17:57:47','','2010-03-29 17:57:47'),(0,'menu_title_100_',15,'','menu_title_100_15','','UA','2010-03-29 17:57:34','','2010-03-29 17:57:34'),(0,'menu_title_100_',16,'','menu_title_100_16',NULL,'RU','2010-03-29 17:58:05','','2010-03-29 17:58:05'),(0,'menu_title_100_',16,'','menu_title_100_16','','UA','2010-03-29 17:57:54','','2010-03-29 17:57:54'),(0,'menu_title_100_',17,'','menu_title_100_17',NULL,'RU','2010-03-29 17:58:20','','2010-03-29 17:58:20'),(0,'menu_title_100_',17,'','menu_title_100_17','','UA','2010-06-30 09:04:09','','2010-06-30 09:04:09'),(0,'menu_title_100_',18,'','menu_title_100_18','','UA','2009-12-30 14:39:25','','2009-12-30 14:39:25'),(0,'menu_title_100_',19,'','menu_title_100_19','','RU','2010-03-29 17:30:28','','2010-03-29 17:30:28'),(0,'menu_title_100_',19,'','menu_title_100_19','','UA','2010-03-29 17:30:25','','2010-03-29 17:30:25'),(0,'menu_title_100_',20,'','menu_title_100_20','','RU','2010-04-09 14:07:06','','2010-04-09 14:07:06'),(0,'menu_title_100_',20,'','menu_title_100_20','','UA','2010-03-29 17:31:00','','2010-03-29 17:31:00'),(0,'menu_title_100_',21,'','menu_title_100_21',NULL,'RU','2010-03-29 17:31:25','','2010-03-29 17:31:25'),(0,'menu_title_100_',21,'','menu_title_100_21','','UA','2010-03-29 17:31:14','','2010-03-29 17:31:14'),(0,'menu_title_100_',22,'','menu_title_100_22',NULL,'UA','2010-01-12 08:32:05','','2010-01-12 08:32:05'),(0,'menu_title_100_',23,'','menu_title_100_23',NULL,'UA','2010-01-12 08:32:55','','2010-01-12 08:32:55'),(0,'menu_title_100_',24,'','menu_title_100_24',NULL,'UA','2010-01-12 08:33:57','','2010-01-12 08:33:57'),(0,'menu_title_100_',25,'','menu_title_100_25',NULL,'UA','2010-01-12 08:34:46','','2010-01-12 08:34:46'),(0,'menu_title_100_',26,'','menu_title_100_26',NULL,'UA','2010-01-12 08:35:39','','2010-01-12 08:35:39'),(0,'menu_title_100_',27,'','menu_title_100_27','','RU','2010-04-13 10:08:55','','2010-04-13 10:08:55'),(0,'menu_title_100_',27,'','menu_title_100_27','','UA','2010-04-13 08:21:55','','2010-04-13 08:21:55'),(0,'menu_title_100_',28,'','menu_title_100_28',NULL,'RU','2010-03-29 17:35:15','','2010-03-29 17:35:15'),(0,'menu_title_100_',28,'','menu_title_100_28','','UA','2010-03-29 17:35:04','','2010-03-29 17:35:04'),(0,'menu_title_100_',29,'','menu_title_100_29',NULL,'RU','2010-03-29 17:35:42','','2010-03-29 17:35:42'),(0,'menu_title_100_',29,'','menu_title_100_29','','UA','2010-03-29 17:35:22','','2010-03-29 17:35:22'),(0,'menu_title_100_',30,'','menu_title_100_30','','UA','2010-03-29 17:35:47','','2010-03-29 17:35:47'),(0,'menu_title_100_',31,'','menu_title_100_31',NULL,'RU','2010-03-29 17:58:37','','2010-03-29 17:58:37'),(0,'menu_title_100_',31,'','menu_title_100_31','','UA','2010-04-06 18:25:47','','2010-04-06 18:25:47'),(0,'menu_title_101_',1,NULL,'menu_title_101_1',NULL,'UA','2009-11-26 13:28:18',NULL,'2009-11-26 13:28:18'),(0,'menu_title_101_',2,'','menu_title_101_2',NULL,'UA','2009-11-26 13:37:04','','2009-11-26 13:37:04'),(0,'menu_title_101_',3,'','menu_title_101_3',NULL,'UA','2009-11-26 14:02:47','','2009-11-26 14:02:47'),(0,'menu_title_101_',4,'','menu_title_101_4',NULL,'UA','2009-11-26 14:03:31','','2009-11-26 14:03:31'),(0,'menu_title_101_',5,'','menu_title_101_5',NULL,'UA','2009-11-26 14:04:15','','2009-11-26 14:04:15'),(0,'menu_title_101_',6,'','menu_title_101_6',NULL,'UA','2009-11-26 14:05:14','','2009-11-26 14:05:14'),(0,'menu_title_10_',1,NULL,'menu_title_10_1',NULL,'UA','2009-11-26 13:28:18',NULL,'2009-11-26 13:28:18'),(0,'menu_title_10_',2,'','menu_title_10_2',NULL,'RU','2010-03-01 13:16:38','','2010-03-01 13:16:38'),(0,'menu_title_10_',2,'','menu_title_10_2','','UA','2010-03-22 15:20:52','','2010-03-22 15:20:52'),(0,'menu_title_10_',3,'','menu_title_10_3',NULL,'RU','2010-03-01 13:16:53','','2010-03-01 13:16:53'),(0,'menu_title_10_',3,'','menu_title_10_3','','UA','2011-03-18 10:02:53','','2011-03-18 10:02:53'),(0,'menu_title_10_',4,'','menu_title_10_4',NULL,'RU','2010-03-01 13:17:14','','2010-03-01 13:17:14'),(0,'menu_title_10_',4,'','menu_title_10_4','','UA','2010-03-22 15:20:58','','2010-03-22 15:20:58'),(0,'menu_title_10_',5,'','menu_title_10_5','','RU','2010-04-13 12:27:18','','2010-04-13 12:27:18'),(0,'menu_title_10_',5,'','menu_title_10_5','','UA','2010-04-13 12:27:10','','2010-04-13 12:27:10'),(0,'menu_title_10_',6,'','menu_title_10_6','','UA','2009-12-25 10:09:26','','2009-12-25 10:09:26'),(0,'menu_title_11_',1,NULL,'menu_title_11_1',NULL,'UA','2009-11-26 15:09:29',NULL,'2009-11-26 15:09:29'),(0,'menu_title_11_',2,'','menu_title_11_2',NULL,'UA','2009-11-27 12:27:47','','2009-11-27 12:27:47'),(0,'menu_title_11_',3,'','menu_title_11_3',NULL,'UA','2009-11-27 12:29:14','','2009-11-27 12:29:14'),(0,'menu_title_300_',1,NULL,'menu_title_300_1',NULL,'UA','2009-11-26 16:29:31',NULL,'2009-11-26 16:29:31'),(0,'menu_title_300_',2,'','menu_title_300_2',NULL,'RU','2010-04-09 13:32:49','','2010-04-09 13:32:49'),(0,'menu_title_300_',2,'','menu_title_300_2','','UA','2010-04-09 13:32:42','','2010-04-09 13:32:42'),(0,'menu_title_300_',3,'','menu_title_300_3',NULL,'RU','2010-04-09 13:33:28','','2010-04-09 13:33:28'),(0,'menu_title_300_',3,'','menu_title_300_3','','UA','2010-04-09 13:33:19','','2010-04-09 13:33:19'),(0,'menu_title_300_',4,'','menu_title_300_4',NULL,'RU','2010-04-09 13:33:42','','2010-04-09 13:33:42'),(0,'menu_title_300_',4,'','menu_title_300_4','','UA','2010-04-09 13:33:32','','2010-04-09 13:33:32'),(0,'menu_title_300_',5,'','menu_title_300_5',NULL,'RU','2010-04-09 13:33:54','','2010-04-09 13:33:54'),(0,'menu_title_300_',5,'','menu_title_300_5','','UA','2010-04-09 13:33:48','','2010-04-09 13:33:48'),(0,'menu_title_300_',6,'','menu_title_300_6',NULL,'RU','2010-04-19 10:35:05','','2010-04-19 10:35:05'),(0,'menu_title_300_',6,'','menu_title_300_6','','UA','2011-01-11 15:34:14','','2011-01-11 15:34:14'),(0,'menu_title_400101_',1,'','menu_title_400101_1','','UA','2010-07-13 12:52:15','','2010-07-13 12:52:15'),(0,'menu_title_40028_',1,'','menu_title_40028_1','','UA','2010-01-13 14:36:00','','2010-01-13 14:36:00'),(0,'menu_title_40029_',1,'','menu_title_40029_1',NULL,'RU','2010-04-13 13:24:32','','2010-04-13 13:24:32'),(0,'menu_title_40029_',1,'','menu_title_40029_1','','UA','2010-01-13 14:26:45','','2010-01-13 14:26:45'),(0,'menu_title_40030_',1,'','menu_title_40030_1','','UA','2009-12-30 11:29:33','','2009-12-30 11:29:33'),(0,'menu_title_40031_',1,NULL,'menu_title_40031_1',NULL,'UA','2009-12-25 14:35:28',NULL,'2009-12-25 14:35:28'),(0,'menu_title_40032_',1,'','menu_title_40032_1',NULL,'RU','2011-03-18 10:06:43','','2011-03-18 10:06:43'),(0,'menu_title_40032_',1,'','menu_title_40032_1','','UA','2010-01-13 14:37:08','','2010-01-13 14:37:08'),(0,'menu_title_40033_',1,'','menu_title_40033_1',NULL,'RU','2010-04-13 13:23:06','','2010-04-13 13:23:06'),(0,'menu_title_40033_',1,'','menu_title_40033_1','','UA','2010-02-25 13:59:42','','2010-02-25 13:59:42'),(0,'menu_title_40034_',1,'','menu_title_40034_1','','UA','2010-01-12 07:16:23','','2010-01-12 07:16:23'),(0,'menu_title_40035_',1,NULL,'menu_title_40035_1',NULL,'UA','2009-12-25 14:42:55',NULL,'2009-12-25 14:42:55'),(0,'menu_title_40036_',1,NULL,'menu_title_40036_1',NULL,'UA','2010-01-30 08:48:52',NULL,'2010-01-30 08:48:52'),(0,'menu_title_40037_',1,NULL,'menu_title_40037_1',NULL,'UA','2009-12-30 11:32:46',NULL,'2009-12-30 11:32:46'),(0,'menu_title_40038_',1,NULL,'menu_title_40038_1',NULL,'UA','2009-12-30 11:24:10',NULL,'2009-12-30 11:24:10'),(0,'menu_title_40039_',1,NULL,'menu_title_40039_1',NULL,'UA','2009-12-25 15:07:09',NULL,'2009-12-25 15:07:09'),(0,'menu_title_40045_',1,'','menu_title_40045_1','','UA','2009-12-30 11:23:37','','2009-12-30 11:23:37'),(0,'menu_title_40046_',1,'','menu_title_40046_1',NULL,'RU','2010-04-13 13:24:50','','2010-04-13 13:24:50'),(0,'menu_title_40046_',1,'','menu_title_40046_1','','UA','2010-01-13 14:25:47','','2010-01-13 14:25:47'),(0,'menu_title_40047_',1,NULL,'menu_title_40047_1',NULL,'UA','2009-12-25 09:42:14',NULL,'2009-12-25 09:42:14'),(0,'menu_title_40048_',1,NULL,'menu_title_40048_1',NULL,'UA','2010-01-09 18:51:01',NULL,'2010-01-09 18:51:01'),(0,'menu_title_40049_',1,NULL,'menu_title_40049_1',NULL,'UA','2010-04-13 13:07:48',NULL,'2010-04-13 13:07:48'),(0,'menu_title_40052_',1,NULL,'menu_title_40052_1',NULL,'UA','2009-12-25 15:07:13',NULL,'2009-12-25 15:07:13'),(0,'menu_title_40054_',1,NULL,'menu_title_40054_1',NULL,'UA','2009-12-25 14:57:21',NULL,'2009-12-25 14:57:21'),(0,'menu_title_40057_',1,'','menu_title_40057_1','','UA','2009-12-13 19:49:21','','2009-12-13 19:49:21'),(0,'menu_title_40059_',1,'','menu_title_40059_1','','UA','2009-12-13 12:08:37','','2009-12-13 12:08:37'),(0,'menu_title_40060_',1,'','menu_title_40060_1','','UA','2010-01-28 16:55:08','','2010-01-28 16:55:08'),(0,'menu_title_40061_',1,'','menu_title_40061_1','','UA','2010-01-14 18:36:54','','2010-01-14 18:36:54'),(0,'menu_title_40062_',1,'','menu_title_40062_1','','UA','2010-01-27 04:52:25','','2010-01-27 04:52:25'),(0,'menu_title_40063_',1,'','menu_title_40063_1','','UA','2009-12-13 12:04:32','','2009-12-13 12:04:32'),(0,'menu_title_40064_',1,'','menu_title_40064_1','','UA','2010-02-01 16:39:39','','2010-02-01 16:39:39'),(0,'menu_title_40066_',1,'','menu_title_40066_1','','UA','2010-01-18 15:33:47','','2010-01-18 15:33:47'),(0,'menu_title_40067_',1,'','menu_title_40067_1','','UA','2009-12-29 21:57:37','','2009-12-29 21:57:37'),(0,'menu_title_40068_',1,'','menu_title_40068_1','','UA','2010-01-05 23:47:25','','2010-01-05 23:47:25'),(0,'menu_title_40088_',1,'','menu_title_40088_1','','UA','2010-01-31 15:24:00','','2010-01-31 15:24:00'),(0,'menu_title_40089_',1,NULL,'menu_title_40089_1',NULL,'UA','2010-01-19 08:28:55',NULL,'2010-01-19 08:28:55'),(0,'menu_title_40090_',1,'','menu_title_40090_1','','UA','2010-01-19 11:59:30','','2010-01-19 11:59:30'),(0,'menu_title_40093_',1,'','menu_title_40093_1','','UA','2010-04-09 14:03:23','','2010-04-09 14:03:23'),(0,'menu_title_40099_',1,'','menu_title_40099_1','','UA','2010-04-19 10:34:12','','2010-04-19 10:34:12'),(0,'menu_title_400_',1,'','menu_title_400_1','','UA','2009-12-11 15:32:13','','2009-12-11 15:32:13'),(0,'menu_title_400_',2,'','menu_title_400_2',NULL,'UA','2009-12-11 15:29:34','','2009-12-11 15:29:34'),(0,'menu_title_900101_',1,'','menu_title_900101_1','','UA','2010-07-13 12:53:50','','2010-07-13 12:53:50'),(0,'menu_title_90028_',1,NULL,'menu_title_90028_1',NULL,'UA','2010-04-14 12:02:55',NULL,'2010-04-14 12:02:55'),(0,'menu_title_90029_',1,'','menu_title_90029_1','','UA','2010-01-14 16:07:17','','2010-01-14 16:07:17'),(0,'menu_title_90029_',2,'','menu_title_90029_2',NULL,'UA','2010-01-14 16:08:57','','2010-01-14 16:08:57'),(0,'menu_title_90030_',1,'','menu_title_90030_1','','UA','2010-01-14 08:23:01','','2010-01-14 08:23:01'),(0,'menu_title_90030_',2,'','menu_title_90030_2','','RU','2010-04-15 12:04:24','','2010-04-15 12:04:24'),(0,'menu_title_90030_',2,'','menu_title_90030_2','','UA','2010-04-15 12:04:33','','2010-04-15 12:04:33'),(0,'menu_title_90031_',1,'','menu_title_90031_1','','UA','2010-01-14 08:55:23','','2010-01-14 08:55:23'),(0,'menu_title_90031_',2,'','menu_title_90031_2',NULL,'UA','2010-01-14 08:56:05','','2010-01-14 08:56:05'),(0,'menu_title_90032_',1,NULL,'menu_title_90032_1',NULL,'UA','2010-01-19 10:32:16',NULL,'2010-01-19 10:32:16'),(0,'menu_title_90033_',1,'','menu_title_90033_1','','UA','2010-01-14 16:07:48','','2010-01-14 16:07:48'),(0,'menu_title_90033_',2,'','menu_title_90033_2',NULL,'RU','2010-04-13 13:24:04','','2010-04-13 13:24:04'),(0,'menu_title_90033_',2,'','menu_title_90033_2',NULL,'UA','2010-01-14 16:10:06','','2010-01-14 16:10:06'),(0,'menu_title_90034_',1,'','menu_title_90034_1','','UA','2010-01-22 14:03:35','','2010-01-22 14:03:35'),(0,'menu_title_90035_',1,'','menu_title_90035_1',NULL,'RU','2010-04-12 08:50:47','','2010-04-12 08:50:47'),(0,'menu_title_90035_',1,'','menu_title_90035_1','','UA','2010-01-13 21:51:20','','2010-01-13 21:51:20'),(0,'menu_title_90035_',2,'','menu_title_90035_2',NULL,'UA','2010-01-14 06:40:35','','2010-01-14 06:40:35'),(0,'menu_title_90035_',3,'','menu_title_90035_3',NULL,'RU','2010-04-12 08:52:16','','2010-04-12 08:52:16'),(0,'menu_title_90035_',3,'','menu_title_90035_3',NULL,'UA','2010-01-14 06:52:43','','2010-01-14 06:52:43'),(0,'menu_title_90036_',1,NULL,'menu_title_90036_1',NULL,'UA','2010-01-30 08:48:52',NULL,'2010-01-30 08:48:52'),(0,'menu_title_90037_',1,'','menu_title_90037_1','','UA','2010-01-14 08:29:14','','2010-01-14 08:29:14'),(0,'menu_title_90037_',2,'N.B. Is page dependent !!!','menu_title_90037_2',NULL,'UA','2010-01-14 08:28:53','N.B. Is page dependent !!!','2010-01-14 08:28:53'),(0,'menu_title_90037_',3,'','menu_title_90037_3',NULL,'RU','2010-04-15 14:00:59','','2010-04-15 14:00:59'),(0,'menu_title_90037_',3,'','menu_title_90037_3','','UA','2010-04-15 14:01:13','','2010-04-15 14:01:13'),(0,'menu_title_90038_',1,NULL,'menu_title_90038_1',NULL,'UA','2010-03-29 17:53:44',NULL,'2010-03-29 17:53:44'),(0,'menu_title_90039_',1,'---','menu_title_90039_1',NULL,'RU','2010-04-13 12:34:02','---','2010-04-13 12:34:02'),(0,'menu_title_90039_',1,'---','menu_title_90039_1','','UA','2010-01-14 10:16:17','---','2010-01-14 10:16:17'),(0,'menu_title_90039_',2,'','menu_title_90039_2',NULL,'RU','2010-04-13 12:34:56','','2010-04-13 12:34:56'),(0,'menu_title_90039_',2,'','menu_title_90039_2',NULL,'UA','2010-01-14 10:17:25','','2010-01-14 10:17:25'),(0,'menu_title_90039_',3,'','menu_title_90039_3',NULL,'UA','2010-01-14 10:18:25','','2010-01-14 10:18:25'),(0,'menu_title_90040_',1,'','menu_title_90040_1','','UA','2010-01-14 09:59:18','','2010-01-14 09:59:18'),(0,'menu_title_90040_',2,'','menu_title_90040_2',NULL,'RU','2010-04-12 15:26:40','','2010-04-12 15:26:40'),(0,'menu_title_90040_',2,'','menu_title_90040_2',NULL,'UA','2010-01-14 10:00:16','','2010-01-14 10:00:16'),(0,'menu_title_90040_',3,'','menu_title_90040_3',NULL,'RU','2010-04-12 15:27:01','','2010-04-12 15:27:01'),(0,'menu_title_90040_',3,'','menu_title_90040_3',NULL,'UA','2010-01-14 10:04:05','','2010-01-14 10:04:05'),(0,'menu_title_90042_',1,'','menu_title_90042_1','','UA','2010-01-14 07:34:20','','2010-01-14 07:34:20'),(0,'menu_title_90042_',2,'','menu_title_90042_2',NULL,'UA','2010-01-14 07:35:11','','2010-01-14 07:35:11'),(0,'menu_title_90042_',3,'','menu_title_90042_3',NULL,'UA','2010-01-14 07:36:13','','2010-01-14 07:36:13'),(0,'menu_title_90043_',1,NULL,'menu_title_90043_1',NULL,'UA','2010-01-19 11:23:21',NULL,'2010-01-19 11:23:21'),(0,'menu_title_90045_',1,'','menu_title_90045_1','','UA','2010-01-14 07:56:50','','2010-01-14 07:56:50'),(0,'menu_title_90045_',2,'','menu_title_90045_2',NULL,'UA','2010-01-14 07:57:43','','2010-01-14 07:57:43'),(0,'menu_title_90045_',3,'','menu_title_90045_3',NULL,'UA','2010-01-14 08:07:49','','2010-01-14 08:07:49'),(0,'menu_title_90046_',1,'','menu_title_90046_1','','UA','2010-01-14 16:05:50','','2010-01-14 16:05:50'),(0,'menu_title_90046_',2,'','menu_title_90046_2',NULL,'UA','2010-01-14 16:11:01','','2010-01-14 16:11:01'),(0,'menu_title_90047_',1,'...','menu_title_90047_1',NULL,'RU','2010-04-13 12:32:09','...','2010-04-13 12:32:09'),(0,'menu_title_90047_',1,'...','menu_title_90047_1','','UA','2010-01-14 10:12:37','...','2010-01-14 10:12:37'),(0,'menu_title_90047_',2,'','menu_title_90047_2',NULL,'RU','2010-04-13 12:31:39','','2010-04-13 12:31:39'),(0,'menu_title_90047_',2,'','menu_title_90047_2','','UA','2010-03-30 12:36:53','','2010-03-30 12:36:53'),(0,'menu_title_90049_',1,NULL,'menu_title_90049_1',NULL,'UA','2010-04-13 13:07:48',NULL,'2010-04-13 13:07:48'),(0,'menu_title_90051_',1,'','menu_title_90051_1','','UA','2010-01-14 10:05:11','','2010-01-14 10:05:11'),(0,'menu_title_90051_',2,'','menu_title_90051_2',NULL,'UA','2010-01-14 10:06:16','','2010-01-14 10:06:16'),(0,'menu_title_90051_',3,'','menu_title_90051_3',NULL,'UA','2010-01-14 10:07:38','','2010-01-14 10:07:38'),(0,'menu_title_90052_',1,'','menu_title_90052_1','','UA','2010-01-14 10:24:29','','2010-01-14 10:24:29'),(0,'menu_title_90052_',2,'---','menu_title_90052_2','','UA','2010-01-29 17:47:31','---','2010-01-29 17:47:31'),(0,'menu_title_90052_',3,'','menu_title_90052_3',NULL,'UA','2010-01-14 10:27:13','','2010-01-14 10:27:13'),(0,'menu_title_90053_',1,NULL,'menu_title_90053_1',NULL,'UA','2010-01-19 11:23:35',NULL,'2010-01-19 11:23:35'),(0,'menu_title_90055_',1,'','menu_title_90055_1','','UA','2010-01-14 07:39:21','','2010-01-14 07:39:21'),(0,'menu_title_90055_',2,'','menu_title_90055_2',NULL,'RU','2010-04-15 14:02:17','','2010-04-15 14:02:17'),(0,'menu_title_90055_',2,'','menu_title_90055_2','','UA','2010-04-15 14:02:25','','2010-04-15 14:02:25'),(0,'menu_title_90055_',3,'','menu_title_90055_3',NULL,'RU','2010-04-15 14:11:25','','2010-04-15 14:11:25'),(0,'menu_title_90055_',3,'','menu_title_90055_3',NULL,'UA','2010-01-14 07:51:18','','2010-01-14 07:51:18'),(0,'menu_title_90057_',1,'','menu_title_90057_1','','UA','2010-01-14 10:45:36','','2010-01-14 10:45:36'),(0,'menu_title_90057_',2,'N.B. Is page dependent !!!','menu_title_90057_2','','UA','2010-01-14 11:50:32','N.B. Is page dependent !!!','2010-01-14 11:50:32'),(0,'menu_title_90059_',1,'---','menu_title_90059_1','','UA','2010-01-14 10:49:42','---','2010-01-14 10:49:42'),(0,'menu_title_90059_',2,'','menu_title_90059_2',NULL,'UA','2010-01-14 10:50:44','','2010-01-14 10:50:44'),(0,'menu_title_90060_',1,'','menu_title_90060_1','','UA','2010-01-28 16:55:34','','2010-01-28 16:55:34'),(0,'menu_title_90061_',1,'','menu_title_90061_1','','UA','2010-01-14 18:05:22','','2010-01-14 18:05:22'),(0,'menu_title_90062_',1,'','menu_title_90062_1','','UA','2010-01-27 04:52:53','','2010-01-27 04:52:53'),(0,'menu_title_90063_',1,'','menu_title_90063_1','','UA','2010-01-14 11:00:18','','2010-01-14 11:00:18'),(0,'menu_title_90064_',1,'','menu_title_90064_1','','UA','2010-02-01 16:40:19','','2010-02-01 16:40:19'),(0,'menu_title_90066_',1,'','menu_title_90066_1','','UA','2010-01-18 15:38:54','','2010-01-18 15:38:54'),(0,'menu_title_90067_',1,NULL,'menu_title_90067_1',NULL,'UA','2010-01-19 11:19:32',NULL,'2010-01-19 11:19:32'),(0,'menu_title_90068_',1,'','menu_title_90068_1','','UA','2010-01-14 06:37:42','','2010-01-14 06:37:42'),(0,'menu_title_90068_',2,'','menu_title_90068_2',NULL,'UA','2010-01-14 06:35:16','','2010-01-14 06:35:16'),(0,'menu_title_90086_',1,'','menu_title_90086_1',NULL,'RU','2010-04-13 13:35:35','','2010-04-13 13:35:35'),(0,'menu_title_90086_',1,'','menu_title_90086_1','','UA','2010-01-14 10:09:31','','2010-01-14 10:09:31'),(0,'menu_title_90086_',2,'','menu_title_90086_2',NULL,'RU','2010-04-13 13:35:53','','2010-04-13 13:35:53'),(0,'menu_title_90086_',2,'','menu_title_90086_2',NULL,'UA','2010-01-14 10:10:27','','2010-01-14 10:10:27'),(0,'menu_title_90086_',3,'---','menu_title_90086_3',NULL,'RU','2010-04-13 13:34:22','---','2010-04-13 13:34:22'),(0,'menu_title_90086_',3,'---','menu_title_90086_3','','UA','2010-01-29 17:48:15','---','2010-01-29 17:48:15'),(0,'menu_title_90088_',1,'','menu_title_90088_1','','UA','2010-01-31 15:25:03','','2010-01-31 15:25:03'),(0,'menu_title_90089_',1,NULL,'menu_title_90089_1',NULL,'UA','2010-01-19 08:28:55',NULL,'2010-01-19 08:28:55'),(0,'menu_title_90090_',1,'','menu_title_90090_1','','UA','2010-01-19 11:59:55','','2010-01-19 11:59:55'),(0,'menu_title_90093_',1,NULL,'menu_title_90093_1',NULL,'UA','2010-04-09 13:30:08',NULL,'2010-04-09 13:30:08'),(0,'menu_title_90099_',1,NULL,'menu_title_90099_1',NULL,'UA','2010-04-19 10:33:16',NULL,'2010-04-19 10:33:16'),(0,'meta_commentary',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_commentary',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_commentary',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_description',0,'meta_description',NULL,NULL,'EN','2010-03-20 06:30:00','meta_description','2009-11-14 21:07:33'),(0,'meta_description',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_description',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_keywords',0,'meta_keywords',NULL,NULL,'EN','2010-03-20 06:30:00','meta_keywords','2009-11-14 21:07:33'),(0,'meta_keywords',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_keywords',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_title',0,'meta_title',NULL,NULL,'EN','2010-03-20 06:30:00','meta_title','2009-11-14 21:07:33'),(0,'meta_title',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'meta_title',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:38:10'),(0,'MIN_%S',0,NULL,'MIN_%S',NULL,'UA','2010-08-19 15:46:54',NULL,'2010-08-19 15:46:54'),(0,'MIN_%S,_MAX_%S,_DIVISIBLE_BY_%S',0,'Мінімум %s, максимум %s, кратно %s','MIN_%S,_MAX_%S,_DIVISIBLE_BY_%S','','UA','2010-08-19 15:48:03','Мінімум %s, максимум %s, кратно %s','2010-08-19 15:48:03'),(0,'MIN_%S._MAX_%S._DIVISIBLE_BY_%S.',0,'Мінімум %s максимум %s кратно %s','MIN_%S._MAX_%S._DIVISIBLE_BY_%S.','','UA','2010-08-19 15:40:32','Мінімум %s максимум %s кратно %s','2010-08-19 15:40:32'),(0,'MIN_%S._MAX_%S\\._DIVISIBLE_BY_%S.',0,'Min %s. Max %s\\. Divisible by %s.','MIN_%S._MAX_%S\\._DIVISIBLE_BY_%S.',NULL,'UA','2010-08-19 15:38:36','Min %s. Max %s\\. Divisible by %s.','2010-08-19 15:38:36'),(0,'MIN_1000,_DIVISIBLE_BY_',100,'Мінімум %s, максимум %s, кратно %s','MIN_1000,_DIVISIBLE_BY_100','','UA','2010-08-19 15:24:48','Мінімум %s, максимум %s, кратно %s','2010-08-19 15:24:48'),(0,'my_points_block_content',0,'<p><img height=\"50\" alt=\"\" width=\"50\" align=\"left\" vspace=\"4\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px\">З&rsquo;ясуйте кількість зароблених балів та перегляньте історію досліджень.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=30&amp;language=UA\">Перейти до розділу</a></p>','my_points_block_content','','UA','2010-01-14 06:59:33','<p><img height=\"50\" alt=\"\" width=\"50\" align=\"left\" vspace=\"4\" src=\"/usersimage/Image/face.png\" /></p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px\">З&rsquo;ясуйте кількість зароблених балів та перегляньте історію досліджень.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=30&amp;language=UA\">Перейти до розділу</a></p>','2010-01-14 06:59:33'),(0,'NAME',0,'Имя*','NAME','','RU','2010-07-02 09:55:20','Имя*','2010-07-02 09:55:20'),(0,'NAME',0,'Iм&#039;я*','NAME','','UA','2010-07-02 09:55:04','Iм&#039;я*','2010-07-02 09:55:04'),(0,'NEW_PASSWORD',0,'Новый пароль','NEW_PASSWORD','','RU','2010-04-15 13:59:43','Новый пароль','2010-04-15 13:59:43'),(0,'NEW_PASSWORD',0,'Новий пароль','NEW_PASSWORD',NULL,'UA','2010-04-03 08:32:08','Новий пароль','2010-04-03 08:32:08'),(0,'NEXT',0,'наступна','NEXT',NULL,'UA','2010-04-11 14:13:54','наступна','2010-04-11 14:13:54'),(0,'NEXT_PAGE',0,'Next page','NEXT_PAGE',NULL,'UA','2010-04-11 14:13:54','Next page','2010-04-11 14:13:54'),(0,'NEXT_PAGES_BLOCK',0,'Next_pages_block','NEXT_PAGES_BLOCK',NULL,'UA','2010-04-11 14:13:54','Next_pages_block','2010-04-11 14:13:54'),(0,'no_default_page',0,'no_default_page',NULL,NULL,'EN','2009-11-14 21:07:33','no_default_page','2009-11-14 21:07:33'),(0,'NO_INFO',0,'Iнформацiя вiдсутня','NO_INFO',NULL,'UA','2010-04-02 08:35:30','Iнформацiя вiдсутня','2010-04-02 08:35:30'),(0,'obj_meta_commentary',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_commentary',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_commentary',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_description',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_description',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_description',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_keywords',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_keywords',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_keywords',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_title',0,'',NULL,NULL,'EN','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_title',0,'',NULL,NULL,'RU','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'obj_meta_title',0,'',NULL,NULL,'UA','0000-00-00 00:00:00',NULL,'2010-03-19 15:45:01'),(0,'OCI_ERROR_',20001,NULL,'OCI_ERROR_20001',NULL,'UA','2011-01-10 12:03:20',NULL,'2011-01-10 12:03:20'),(0,'OLD_PASSWORD',0,'Старый пароль','OLD_PASSWORD','','RU','2010-04-15 13:59:31','Старый пароль','2010-04-15 13:59:31'),(0,'OLD_PASSWORD',0,'Старий пароль','OLD_PASSWORD',NULL,'UA','2010-04-03 08:32:08','Старий пароль','2010-04-03 08:32:08'),(0,'OTHER_NEWS_36.',6,'Iншi новини 36.6','OTHER_NEWS_36.6',NULL,'UA','2010-06-16 13:12:54','Iншi новини 36.6','2010-06-16 13:12:54'),(0,'page_name_',1,'index','page_name_1',NULL,'EN','2010-04-20 14:33:47','index','2010-04-20 14:33:47'),(0,'page_name_',1,'index','page_name_1',NULL,'RU','2010-04-20 14:33:47','index','2010-04-20 14:33:47'),(0,'page_name_',1,'index','page_name_1',NULL,'UA','2010-04-20 14:33:47','index','2010-04-20 14:33:47'),(0,'page_name_',11,'news-rss','page_name_11',NULL,'UA','2010-01-21 16:11:06','news-rss','2010-01-21 16:11:06'),(0,'page_name_',28,'TNS-in-Ukraine','page_name_28',NULL,'EN','2010-04-14 12:02:43','TNS-in-Ukraine','2010-04-14 12:02:43'),(0,'page_name_',28,'TNS-v-Ukraine','page_name_28',NULL,'RU','2010-04-14 12:02:43','TNS-v-Ukraine','2010-04-14 12:02:43'),(0,'page_name_',28,'TNS-v-Ukrajini','page_name_28',NULL,'UA','2010-04-14 12:02:43','TNS-v-Ukrajini','2010-04-14 12:02:43'),(0,'page_name_',29,'Responsibility','page_name_29',NULL,'EN','2010-04-14 12:06:49','Responsibility','2010-04-14 12:06:49'),(0,'page_name_',29,'Otvetstvennost','page_name_29',NULL,'RU','2010-04-14 12:06:49','Otvetstvennost','2010-04-14 12:06:49'),(0,'page_name_',29,'Vidpovidalnist','page_name_29',NULL,'UA','2010-04-14 12:06:49','Vidpovidalnist','2010-04-14 12:06:49'),(0,'page_name_',30,'survey-history','page_name_30',NULL,'EN','2010-01-18 19:05:40','survey-history','2010-01-18 19:05:40'),(0,'page_name_',30,'survey-history','page_name_30',NULL,'UA','2010-01-18 19:05:40','survey-history','2010-01-18 19:05:40'),(0,'page_name_',31,'Points-convertion','page_name_31',NULL,'EN','2010-04-14 17:58:55','Points-convertion','2010-04-14 17:58:55'),(0,'page_name_',31,'Konvertacija-balov','page_name_31',NULL,'RU','2010-04-14 17:58:55','Konvertacija-balov','2010-04-14 17:58:55'),(0,'page_name_',31,'Konvertacija-baliv','page_name_31',NULL,'UA','2010-04-14 17:58:55','Konvertacija-baliv','2010-04-14 17:58:55'),(0,'page_name_',32,'Contacts','page_name_32',NULL,'EN','2010-04-14 17:59:50','Contacts','2010-04-14 17:59:50'),(0,'page_name_',32,'Kontakty','page_name_32',NULL,'RU','2010-04-14 17:59:50','Kontakty','2010-04-14 17:59:50'),(0,'page_name_',32,'Kontakty','page_name_32',NULL,'UA','2010-04-14 17:59:50','Kontakty','2010-04-14 17:59:50'),(0,'page_name_',33,'Confidentiality','page_name_33',NULL,'EN','2010-04-14 18:39:21','Confidentiality','2010-04-14 18:39:21'),(0,'page_name_',33,'Konfidencialnost','page_name_33',NULL,'RU','2010-04-14 18:39:21','Konfidencialnost','2010-04-14 18:39:21'),(0,'page_name_',33,'Konfidencijnist','page_name_33',NULL,'UA','2010-04-14 18:39:21','Konfidencijnist','2010-04-14 18:39:21'),(0,'page_name_',34,'Site-map','page_name_34',NULL,'EN','2010-04-14 18:41:08','Site-map','2010-04-14 18:41:08'),(0,'page_name_',34,'Karta-sajta','page_name_34',NULL,'RU','2010-04-14 18:41:08','Karta-sajta','2010-04-14 18:41:08'),(0,'page_name_',34,'Mapa-sajtu','page_name_34',NULL,'UA','2010-04-14 18:41:08','Mapa-sajtu','2010-04-14 18:41:08'),(0,'page_name_',35,'We-Opros','page_name_35',NULL,'EN','2010-04-14 18:42:15','We-Opros','2010-04-14 18:42:15'),(0,'page_name_',35,'My-Opros','page_name_35',NULL,'RU','2010-04-14 18:42:15','My-Opros','2010-04-14 18:42:15'),(0,'page_name_',35,'My-Opros','page_name_35',NULL,'UA','2010-04-14 18:42:15','My-Opros','2010-04-14 18:42:15'),(0,'page_name_',36,'My-points','page_name_36',NULL,'EN','2010-04-14 18:43:10','My-points','2010-04-14 18:43:10'),(0,'page_name_',36,'Moi-baly','page_name_36',NULL,'RU','2010-04-14 18:43:10','Moi-baly','2010-04-14 18:43:10'),(0,'page_name_',36,'Moji-baly','page_name_36',NULL,'UA','2010-04-14 18:43:10','Moji-baly','2010-04-14 18:43:10'),(0,'page_name_',37,'user-profile','page_name_37',NULL,'EN','2010-01-18 19:07:30','user-profile','2010-01-18 19:07:30'),(0,'page_name_',37,'user-profile','page_name_37',NULL,'UA','2010-01-18 19:07:30','user-profile','2010-01-18 19:07:30'),(0,'page_name_',38,'My-Opros','page_name_38',NULL,'EN','2010-04-14 18:44:48','My-Opros','2010-04-14 18:44:48'),(0,'page_name_',38,'Moj-Opros','page_name_38',NULL,'RU','2010-04-14 18:44:48','Moj-Opros','2010-04-14 18:44:48'),(0,'page_name_',38,'Mij-Opros','page_name_38',NULL,'UA','2010-04-14 18:44:48','Mij-Opros','2010-04-14 18:44:48'),(0,'page_name_',39,'Why-register','page_name_39',NULL,'EN','2010-04-14 18:47:26','Why-register','2010-04-14 18:47:26'),(0,'page_name_',39,'Zachem-registrirovatsya','page_name_39',NULL,'RU','2010-04-14 18:47:26','Zachem-registrirovatsya','2010-04-14 18:47:26'),(0,'page_name_',39,'Navishcho-rejestruvatys','page_name_39',NULL,'UA','2010-04-14 18:47:26','Navishcho-rejestruvatys','2010-04-14 18:47:26'),(0,'page_name_',40,'News','page_name_40',NULL,'EN','2010-04-14 18:49:04','News','2010-04-14 18:49:04'),(0,'page_name_',40,'Novosti','page_name_40',NULL,'RU','2010-04-14 18:49:04','Novosti','2010-04-14 18:49:04'),(0,'page_name_',40,'Novyny','page_name_40',NULL,'UA','2010-04-14 18:49:04','Novyny','2010-04-14 18:49:04'),(0,'page_name_',41,'Last-news','page_name_41',NULL,'EN','2010-04-14 18:50:17','Last-news','2010-04-14 18:50:17'),(0,'page_name_',41,'Poslednie-novosti','page_name_41',NULL,'RU','2010-04-14 18:50:17','Poslednie-novosti','2010-04-14 18:50:17'),(0,'page_name_',41,'Ostanni-novyny','page_name_41',NULL,'UA','2010-04-14 18:50:17','Ostanni-novyny','2010-04-14 18:50:17'),(0,'page_name_',42,'Advantages-Opros','page_name_42',NULL,'EN','2010-04-14 18:52:37','Advantages-Opros','2010-04-14 18:52:37'),(0,'page_name_',42,'Preimushchestva-Opros','page_name_42',NULL,'RU','2010-04-14 18:52:37','Preimushchestva-Opros','2010-04-14 18:52:37'),(0,'page_name_',42,'Perevagy-Opros','page_name_42',NULL,'UA','2010-04-14 18:52:37','Perevagy-Opros','2010-04-14 18:52:37'),(0,'page_name_',43,'Investigations-totals','page_name_43',NULL,'EN','2010-04-14 19:12:13','Investigations-totals','2010-04-14 19:12:13'),(0,'page_name_',43,'Itogi-issledovanij','page_name_43',NULL,'RU','2010-04-14 19:12:13','Itogi-issledovanij','2010-04-14 19:12:13'),(0,'page_name_',43,'Pidsumky-doslidzhen','page_name_43',NULL,'UA','2010-04-14 19:12:13','Pidsumky-doslidzhen','2010-04-14 19:12:13'),(0,'page_name_',44,'Food-for-thought','page_name_44',NULL,'EN','2010-04-14 18:58:08','Food-for-thought','2010-04-14 18:58:08'),(0,'page_name_',44,'Pishcha-dlya-razmyshlenij','page_name_44',NULL,'RU','2010-04-14 18:58:08','Pishcha-dlya-razmyshlenij','2010-04-14 18:58:08'),(0,'page_name_',44,'Pozhyva-dlya-rozdumiv','page_name_44',NULL,'UA','2010-04-14 18:58:08','Pozhyva-dlya-rozdumiv','2010-04-14 18:58:08'),(0,'page_name_',45,'Current-projects','page_name_45',NULL,'EN','2010-04-14 18:59:18','Current-projects','2010-04-14 18:59:18'),(0,'page_name_',45,'Tekushchie-proekty','page_name_45',NULL,'RU','2010-04-14 18:59:18','Tekushchie-proekty','2010-04-14 18:59:18'),(0,'page_name_',45,'Potochni-proekty','page_name_45',NULL,'UA','2010-04-14 18:59:18','Potochni-proekty','2010-04-14 18:59:18'),(0,'page_name_',46,'Participation-rules','page_name_46',NULL,'EN','2010-04-14 19:01:44','Participation-rules','2010-04-14 19:01:44'),(0,'page_name_',46,'Pravila-uchastija','page_name_46',NULL,'RU','2010-04-14 19:01:44','Pravila-uchastija','2010-04-14 19:01:44'),(0,'page_name_',46,'Pravyla-uchasti','page_name_46',NULL,'UA','2010-04-14 19:01:44','Pravyla-uchasti','2010-04-14 19:01:44'),(0,'page_name_',47,'Форма-реєстрації','page_name_47',NULL,'EN','2010-04-14 19:02:41','Форма-реєстрації','2010-04-14 19:02:41'),(0,'page_name_',47,'Forma-registracii','page_name_47',NULL,'RU','2010-04-14 19:02:41','Forma-registracii','2010-04-14 19:02:41'),(0,'page_name_',47,'Forma-rejestraciji','page_name_47',NULL,'UA','2010-04-14 19:02:41','Forma-rejestraciji','2010-04-14 19:02:41'),(0,'page_name_',48,'About-Opros','page_name_48',NULL,'EN','2010-04-14 19:03:44','About-Opros','2010-04-14 19:03:44'),(0,'page_name_',48,'Pro-Opros','page_name_48',NULL,'RU','2010-04-14 19:03:44','Pro-Opros','2010-04-14 19:03:44'),(0,'page_name_',48,'Pro-Opros','page_name_48',NULL,'UA','2010-04-14 19:03:44','Pro-Opros','2010-04-14 19:03:44'),(0,'page_name_',49,'About-TNS-and-Opros','page_name_49',NULL,'EN','2010-04-14 19:05:08','About-TNS-and-Opros','2010-04-14 19:05:08'),(0,'page_name_',49,'Pro-TNS-ta-Opros','page_name_49',NULL,'RU','2010-04-14 19:05:08','Pro-TNS-ta-Opros','2010-04-14 19:05:08'),(0,'page_name_',49,'Pro-TNS-ta-Opros','page_name_49',NULL,'UA','2010-04-14 19:05:08','Pro-TNS-ta-Opros','2010-04-14 19:05:08'),(0,'page_name_',50,'Projects','page_name_50',NULL,'EN','2010-04-14 19:06:32','Projects','2010-04-14 19:06:32'),(0,'page_name_',50,'Proekty','page_name_50',NULL,'RU','2010-04-14 19:06:32','Proekty','2010-04-14 19:06:32'),(0,'page_name_',50,'Proekty','page_name_50',NULL,'UA','2010-04-14 19:06:32','Proekty','2010-04-14 19:06:32'),(0,'page_name_',51,'Investigation-results','page_name_51',NULL,'EN','2010-04-14 19:11:24','Investigation-results','2010-04-14 19:11:24'),(0,'page_name_',51,'Rezultaty-issledovanij','page_name_51',NULL,'RU','2010-04-14 19:11:24','Rezultaty-issledovanij','2010-04-14 19:11:24'),(0,'page_name_',51,'Rezultaty-doslidzhen','page_name_51',NULL,'UA','2010-04-14 19:11:24','Rezultaty-doslidzhen','2010-04-14 19:11:24'),(0,'page_name_',52,'Bonus-system','page_name_52',NULL,'EN','2010-04-14 19:16:52','Bonus-system','2010-04-14 19:16:52'),(0,'page_name_',52,'Sistema-pooshchrenij','page_name_52',NULL,'RU','2010-04-14 19:16:52','Sistema-pooshchrenij','2010-04-14 19:16:52'),(0,'page_name_',52,'Systema-zaohochennya','page_name_52',NULL,'UA','2010-04-14 19:16:52','Systema-zaohochennya','2010-04-14 19:16:52'),(0,'page_name_',53,'Visits-statistics','page_name_53',NULL,'EN','2010-04-14 19:19:07','Visits-statistics','2010-04-14 19:19:07'),(0,'page_name_',53,'Statistika-poseshchenij','page_name_53',NULL,'RU','2010-04-14 19:19:07','Statistika-poseshchenij','2010-04-14 19:19:07'),(0,'page_name_',53,'Statystyka-vidviduvan','page_name_53',NULL,'UA','2010-04-14 19:19:07','Statystyka-vidviduvan','2010-04-14 19:19:07'),(0,'page_name_',55,'Mission-Opros','page_name_55',NULL,'EN','2010-04-14 19:21:10','Mission-Opros','2010-04-14 19:21:10'),(0,'page_name_',55,'Missija-Opros','page_name_55',NULL,'RU','2010-04-14 19:21:10','Missija-Opros','2010-04-14 19:21:10'),(0,'page_name_',55,'Misija-Opros','page_name_55',NULL,'UA','2010-04-14 19:21:10','Misija-Opros','2010-04-14 19:21:10'),(0,'page_name_',57,'Password-reminder','page_name_57',NULL,'EN','2010-03-20 05:29:46','Password-reminder','2010-03-20 05:29:46'),(0,'page_name_',57,'Password-reminder','page_name_57',NULL,'RU','2010-03-20 05:29:46','Password-reminder','2010-03-20 05:29:46'),(0,'page_name_',57,'Password-reminder','page_name_57',NULL,'UA','2010-03-20 05:29:46','Password-reminder','2010-03-20 05:29:46'),(0,'page_name_',59,'respondent-registration-approve','page_name_59',NULL,'EN','2010-03-20 06:16:50','respondent-registration-approve','2010-03-20 06:16:50'),(0,'page_name_',59,'respondent-registration-approve','page_name_59',NULL,'RU','2010-03-20 06:16:50','respondent-registration-approve','2010-03-20 06:16:50'),(0,'page_name_',59,'respondent-registration-approve','page_name_59',NULL,'UA','2010-03-20 06:16:50','respondent-registration-approve','2010-03-20 06:16:50'),(0,'page_name_',60,'respondent-password-update','page_name_60',NULL,'EN','2010-03-20 06:10:03','respondent-password-update','2010-03-20 06:10:03'),(0,'page_name_',60,'respondent-password-update','page_name_60',NULL,'RU','2010-03-20 06:10:03','respondent-password-update','2010-03-20 06:10:03'),(0,'page_name_',60,'respondent-password-update','page_name_60',NULL,'UA','2010-03-20 06:10:03','respondent-password-update','2010-03-20 06:10:03'),(0,'page_name_',61,'respondent-registered-success','page_name_61',NULL,'EN','2010-01-18 18:54:51','respondent-registered-success','2010-01-18 18:54:51'),(0,'page_name_',61,'respondent-registered-success','page_name_61',NULL,'UA','2010-01-18 18:54:51','respondent-registered-success','2010-01-18 18:54:51'),(0,'page_name_',62,'registration-approved','page_name_62',NULL,'EN','2010-01-18 18:55:52','registration-approved','2010-01-18 18:55:52'),(0,'page_name_',62,'registration-approved','page_name_62',NULL,'UA','2010-01-18 18:55:52','registration-approved','2010-01-18 18:55:52'),(0,'page_name_',63,'Page-not-found','page_name_63',NULL,'EN','2010-04-14 19:22:38','Page-not-found','2010-04-14 19:22:38'),(0,'page_name_',63,'Stranitsa-ne-najdena','page_name_63',NULL,'RU','2010-04-14 19:22:38','Stranitsa-ne-najdena','2010-04-14 19:22:38'),(0,'page_name_',63,'Storinka-ne-znajdena','page_name_63',NULL,'UA','2010-04-14 19:22:38','Storinka-ne-znajdena','2010-04-14 19:22:38'),(0,'page_name_',64,'password-reminde-sended','page_name_64',NULL,'UA','2009-12-25 10:16:13','password-reminde-sended','2009-12-25 10:16:13'),(0,'page_name_',65,'password-update-success','page_name_65',NULL,'UA','2009-12-25 12:06:37','password-update-success','2009-12-25 12:06:37'),(0,'page_name_',66,'respondent-updated','page_name_66',NULL,'UA','2009-12-25 13:38:56','respondent-updated','2009-12-25 13:38:56'),(0,'page_name_',67,'Forbidden','page_name_67',NULL,'UA','2009-12-29 21:55:04','Forbidden','2009-12-29 21:55:04'),(0,'page_name_',68,'Authorization','page_name_68',NULL,'EN','2010-04-12 14:30:54','Authorization','2010-04-12 14:30:54'),(0,'page_name_',68,'Authorization','page_name_68',NULL,'RU','2010-04-12 14:30:54','Authorization','2010-04-12 14:30:54'),(0,'page_name_',68,'Authorization','page_name_68',NULL,'UA','2010-04-12 14:30:54','Authorization','2010-04-12 14:30:54'),(0,'page_name_',69,'tns_z_novym_rokom','page_name_69',NULL,'EN','2010-03-04 15:26:47','tns_z_novym_rokom','2010-03-04 15:26:47'),(0,'page_name_',69,'tns_z_novym_rokom','page_name_69',NULL,'RU','2010-03-04 15:26:47','tns_z_novym_rokom','2010-03-04 15:26:47'),(0,'page_name_',69,'tns_z_novym_rokom','page_name_69',NULL,'UA','2010-03-04 15:26:47','tns_z_novym_rokom','2010-03-04 15:26:47'),(0,'page_name_',70,'shapka_pro_36_6','page_name_70',NULL,'UA','2010-01-08 13:57:10','shapka_pro_36_6','2010-01-08 13:57:10'),(0,'page_name_',71,'pro_36_6','page_name_71',NULL,'UA','2010-01-08 13:58:25','pro_36_6','2010-01-08 13:58:25'),(0,'page_name_',72,'shapka_novyny','page_name_72',NULL,'UA','2010-01-08 13:59:29','shapka_novyny','2010-01-08 13:59:29'),(0,'page_name_',73,'novyny','page_name_73',NULL,'UA','2010-01-08 14:00:03','novyny','2010-01-08 14:00:03'),(0,'page_name_',74,'shapka_pryednajtes','page_name_74',NULL,'UA','2010-01-08 14:00:49','shapka_pryednajtes','2010-01-08 14:00:49'),(0,'page_name_',75,'pryednajtes','page_name_75',NULL,'UA','2010-01-08 14:02:42','pryednajtes','2010-01-08 14:02:42'),(0,'page_name_',76,'shapka_pro_tns','page_name_76',NULL,'UA','2010-01-08 14:03:46','shapka_pro_tns','2010-01-08 14:03:46'),(0,'page_name_',77,'shapka_moja_36_6','page_name_77',NULL,'UA','2010-01-11 08:15:54','shapka_moja_36_6','2010-01-11 08:15:54'),(0,'page_name_',78,'shapka_poto4ni_proekty','page_name_78',NULL,'UA','2010-01-11 08:17:33','shapka_poto4ni_proekty','2010-01-11 08:17:33'),(0,'page_name_',79,'Darts-arrow','page_name_79',NULL,'EN','2010-01-18 17:02:58','Darts-arrow','2010-01-18 17:02:58'),(0,'page_name_',79,'Darts-arrow','page_name_79',NULL,'UA','2010-01-18 17:02:58','Darts-arrow','2010-01-18 17:02:58'),(0,'page_name_',80,'uah-sign','page_name_80',NULL,'UA','2010-01-12 16:46:34','uah-sign','2010-01-12 16:46:34'),(0,'page_name_',81,'handshake','page_name_81',NULL,'UA','2010-01-12 18:24:59','handshake','2010-01-12 18:24:59'),(0,'page_name_',84,'quotes','page_name_84',NULL,'UA','2010-01-12 18:41:00','quotes','2010-01-12 18:41:00'),(0,'page_name_',85,'quotes_with_text','page_name_85',NULL,'EN','2010-04-09 11:28:18','quotes_with_text','2010-04-09 11:28:18'),(0,'page_name_',85,'quotes_with_text','page_name_85',NULL,'RU','2010-04-09 11:28:18','quotes_with_text','2010-04-09 11:28:18'),(0,'page_name_',85,'quotes_with_text','page_name_85',NULL,'UA','2010-04-09 11:28:18','quotes_with_text','2010-04-09 11:28:18'),(0,'page_name_',86,'FAQ','page_name_86',NULL,'EN','2010-04-14 19:24:00','FAQ','2010-04-14 19:24:00'),(0,'page_name_',86,'FAQ','page_name_86',NULL,'RU','2010-04-14 19:24:00','FAQ','2010-04-14 19:24:00'),(0,'page_name_',86,'FAQ','page_name_86',NULL,'UA','2010-04-14 19:24:00','FAQ','2010-04-14 19:24:00'),(0,'page_name_',87,'media','page_name_87',NULL,'EN','2010-01-18 16:59:50','media','2010-01-18 16:59:50'),(0,'page_name_',87,'media','page_name_87',NULL,'UA','2010-01-18 16:59:50','media','2010-01-18 16:59:50'),(0,'page_name_',88,'project-complete','page_name_88',NULL,'EN','2010-01-18 18:16:37','project-complete','2010-01-18 18:16:37'),(0,'page_name_',88,'project-complete','page_name_88',NULL,'UA','2010-01-18 18:16:37','project-complete','2010-01-18 18:16:37'),(0,'page_name_',89,'new','page_name_89',NULL,'EN','2010-01-19 08:28:41','new','2010-01-19 08:28:41'),(0,'page_name_',89,'new','page_name_89',NULL,'UA','2010-01-19 08:28:41','new','2010-01-19 08:28:41'),(0,'page_name_',90,'password-updated-success','page_name_90',NULL,'UA','2010-01-19 11:56:40','password-updated-success','2010-01-19 11:56:40'),(0,'page_name_',91,'flash_el_advantages','page_name_91',NULL,'EN','2010-01-30 13:30:09','flash_el_advantages','2010-01-30 13:30:09'),(0,'page_name_',91,'flash_el_advantages','page_name_91',NULL,'UA','2010-01-30 13:30:09','flash_el_advantages','2010-01-30 13:30:09'),(0,'page_name_',92,'March-8','page_name_92',NULL,'EN','2010-03-04 15:25:24','March-8','2010-03-04 15:25:24'),(0,'page_name_',92,'March-8','page_name_92',NULL,'RU','2010-03-04 15:25:24','March-8','2010-03-04 15:25:24'),(0,'page_name_',92,'March-8','page_name_92',NULL,'UA','2010-03-04 15:25:24','March-8','2010-03-04 15:25:24'),(0,'page_name_',93,'respondent-activate','page_name_93',NULL,'EN','2010-04-09 14:07:12','respondent-activate','2010-04-09 14:07:12'),(0,'page_name_',93,'respondent-activate','page_name_93',NULL,'RU','2010-04-09 14:07:12','respondent-activate','2010-04-09 14:07:12'),(0,'page_name_',93,'respondent-activate','page_name_93',NULL,'UA','2010-04-09 14:07:12','respondent-activate','2010-04-09 14:07:12'),(0,'page_name_',94,'shapka_surveys','page_name_94',NULL,'EN','2010-04-13 09:36:10','shapka_surveys','2010-04-13 09:36:10'),(0,'page_name_',94,'shapka_surveys','page_name_94',NULL,'RU','2010-04-13 09:36:10','shapka_surveys','2010-04-13 09:36:10'),(0,'page_name_',94,'shapka_surveys','page_name_94',NULL,'UA','2010-04-13 09:36:10','shapka_surveys','2010-04-13 09:36:10'),(0,'page_name_',95,'shapka_pro_opros','page_name_95',NULL,'EN','2010-04-13 09:36:24','shapka_pro_opros','2010-04-13 09:36:24'),(0,'page_name_',95,'shapka_pro_opros','page_name_95',NULL,'RU','2010-04-13 09:36:24','shapka_pro_opros','2010-04-13 09:36:24'),(0,'page_name_',95,'shapka_pro_opros','page_name_95',NULL,'UA','2010-04-13 09:36:24','shapka_pro_opros','2010-04-13 09:36:24'),(0,'page_name_',96,'shapka_miy_opros','page_name_96',NULL,'EN','2010-04-13 09:36:49','shapka_miy_opros','2010-04-13 09:36:49'),(0,'page_name_',96,'shapka_miy_opros','page_name_96',NULL,'RU','2010-04-13 09:36:49','shapka_miy_opros','2010-04-13 09:36:49'),(0,'page_name_',96,'shapka_miy_opros','page_name_96',NULL,'UA','2010-04-13 09:36:49','shapka_miy_opros','2010-04-13 09:36:49'),(0,'page_name_',97,'top_main','page_name_97',NULL,'EN','2010-04-19 07:57:21','top_main','2010-04-19 07:57:21'),(0,'page_name_',97,'top_main','page_name_97',NULL,'RU','2010-04-19 07:57:21','top_main','2010-04-19 07:57:21'),(0,'page_name_',97,'top_main','page_name_97',NULL,'UA','2010-04-19 07:57:21','top_main','2010-04-19 07:57:21'),(0,'page_name_',98,'gifts','page_name_98',NULL,'EN','2010-04-19 10:28:29','gifts','2010-04-19 10:28:29'),(0,'page_name_',98,'gifts','page_name_98',NULL,'RU','2010-04-19 10:28:29','gifts','2010-04-19 10:28:29'),(0,'page_name_',98,'gifts','page_name_98',NULL,'UA','2010-04-19 10:28:29','gifts','2010-04-19 10:28:29'),(0,'page_name_',99,'akciya','page_name_99',NULL,'EN','2010-04-19 10:33:39','akciya','2010-04-19 10:33:39'),(0,'page_name_',99,'akciya','page_name_99',NULL,'RU','2010-04-19 10:33:39','akciya','2010-04-19 10:33:39'),(0,'page_name_',99,'akciya','page_name_99',NULL,'UA','2010-04-19 10:33:39','akciya','2010-04-19 10:33:39'),(0,'page_name_',100,'main_top','page_name_100',NULL,'UA','2010-04-20 11:02:23','main_top','2010-04-20 11:02:23'),(0,'page_name_',101,'invitation-sent-success','page_name_101',NULL,'EN','2010-07-13 12:49:20','invitation-sent-success','2010-07-13 12:49:20'),(0,'page_name_',101,'priglashenie-otpravleno-uspeshno','page_name_101',NULL,'RU','2010-07-13 12:49:20','priglashenie-otpravleno-uspeshno','2010-07-13 12:49:20'),(0,'page_name_',101,'zaproshennya-nadislano-uspishno','page_name_101',NULL,'UA','2010-07-13 12:49:20','zaproshennya-nadislano-uspishno','2010-07-13 12:49:20'),(0,'page_name_',102,'top_discover','page_name_102',NULL,'EN','2011-01-11 16:15:19','top_discover','2011-01-11 16:15:19'),(0,'page_name_',102,'top_discover','page_name_102',NULL,'RU','2011-01-11 16:15:19','top_discover','2011-01-11 16:15:19'),(0,'page_name_',102,'top_discover','page_name_102',NULL,'UA','2011-01-11 16:15:19','top_discover','2011-01-11 16:15:19'),(0,'page_name_',103,'help_eachother','page_name_103',NULL,'EN','2011-02-18 14:55:12','help_eachother','2011-02-18 14:55:12'),(0,'page_name_',103,'help_eachother','page_name_103',NULL,'RU','2011-02-18 14:55:12','help_eachother','2011-02-18 14:55:12'),(0,'page_name_',103,'help_eachother','page_name_103',NULL,'UA','2011-02-18 14:55:12','help_eachother','2011-02-18 14:55:12'),(0,'PASSWORD',0,'Пароль*','PASSWORD','','UA','2010-07-02 09:57:55','Пароль*','2010-07-02 09:57:55'),(0,'PASSWORD_CONFIRM',0,'Подтвердить пароль*','PASSWORD_CONFIRM','','RU','2010-07-02 09:58:03','Подтвердить пароль*','2010-07-02 09:58:03'),(0,'PASSWORD_CONFIRM',0,'Підтвердити пароль*','PASSWORD_CONFIRM','','UA','2010-07-02 09:58:01','Підтвердити пароль*','2010-07-02 09:58:01'),(0,'PASSWORD_FOR_CONFIRMATION',0,'Введите пароль для подтверждения действия','PASSWORD_FOR_CONFIRMATION','','RU','2010-08-18 09:15:52','Введите пароль для подтверждения действия','2010-08-18 09:15:52'),(0,'PASSWORD_FOR_CONFIRMATION',0,'Введіть пароль для підтвердження дії','PASSWORD_FOR_CONFIRMATION','','UA','2010-08-18 09:15:35','Введіть пароль для підтвердження дії','2010-08-18 09:15:35'),(0,'PASSWORD_FOR_UPDATE_CONFIRMATION',0,'Пароль для підтвердження змін','PASSWORD_FOR_UPDATE_CONFIRMATION',NULL,'UA','2010-04-03 08:32:08','Пароль для підтвердження змін','2010-04-03 08:32:08'),(0,'PASSWORD_REMINDER_FORM',0,'Форма відновлення паролю','PASSWORD_REMINDER_FORM',NULL,'UA','2010-04-03 08:29:59','Форма відновлення паролю','2010-04-03 08:29:59'),(0,'password_rules_error',0,'Пароль має бути завдовжки не менше, ніж 6 символів.','password_rules_error','','UA','2010-04-12 13:28:47','Пароль має бути завдовжки не менше, ніж 6 символів.','2010-04-12 13:28:47'),(0,'password_rules_error_header',0,'Будь ласка, перевірте введені дані ще раз.<br/>','password_rules_error_header','','UA','2010-02-25 12:38:47','Будь ласка, перевірте введені дані ще раз.<br/>','2010-02-25 12:38:47'),(0,'PASSWORD_UPDATE_FORM',0,'Поменять пароль','PASSWORD_UPDATE_FORM','','RU','2010-04-15 13:59:16','Поменять пароль','2010-04-15 13:59:16'),(0,'PASSWORD_UPDATE_FORM',0,'Форма для змiни паролю','PASSWORD_UPDATE_FORM',NULL,'UA','2010-04-03 08:32:08','Форма для змiни паролю','2010-04-03 08:32:08'),(0,'PATRONYMIC_NAME',0,'Отчество*','PATRONYMIC_NAME','','RU','2010-08-18 09:17:08','Отчество*','2010-08-18 09:17:08'),(0,'PATRONYMIC_NAME',0,'По-батькові*','PATRONYMIC_NAME','','UA','2010-07-26 16:40:17','По-батькові*','2010-07-26 16:40:17'),(0,'POINTS_CONVERTION',0,'Использование баллов','POINTS_CONVERTION','','RU','2010-04-15 11:58:41','Использование баллов','2010-04-15 11:58:41'),(0,'POINTS_CONVERTION',0,'Використання балів','POINTS_CONVERTION',NULL,'UA','2010-04-02 08:23:57','Використання балів','2010-04-02 08:23:57'),(0,'points_convertion_block_content',0,'<p class=\"content_simple_text\">Використати свої бали можна двома способами:<br />\r\n&nbsp;- поповнити мобільний;<br />\r\n&nbsp;- поштовий переказ.<br />\r\nВідчуйте реальну користь від участі в дослідженнях.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=31&amp;language=UA\">Перейти до розділу</a></p>','points_convertion_block_content','','UA','2010-01-14 10:43:15','<p class=\"content_simple_text\">Використати свої бали можна двома способами:<br />\r\n&nbsp;- поповнити мобільний;<br />\r\n&nbsp;- поштовий переказ.<br />\r\nВідчуйте реальну користь від участі в дослідженнях.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=31&amp;language=UA\">Перейти до розділу</a></p>','2010-01-14 10:43:15'),(0,'POINTS_COUNT',0,'Количество баллов','POINTS_COUNT','','RU','2010-04-15 11:57:43','Количество баллов','2010-04-15 11:57:43'),(0,'POINTS_COUNT',0,'Кількість балів','POINTS_COUNT',NULL,'UA','2010-04-02 08:23:57','Кількість балів','2010-04-02 08:23:57'),(0,'POINTS_NUMBER_SHOULD_BE_AT_LEAST_%S',0,'Мінімальна кількість балів - %s','POINTS_NUMBER_SHOULD_BE_AT_LEAST_%S','','UA','2010-08-19 15:19:11','Мінімальна кількість балів - %s','2010-08-19 15:19:11'),(0,'POINTS_NUMBER_SHOULD_BE_DIVISIBLE_BY_%S',0,'Кількість балів має бути кратною %s','POINTS_NUMBER_SHOULD_BE_DIVISIBLE_BY_%S','','UA','2010-08-19 15:21:00','Кількість балів має бути кратною %s','2010-08-19 15:21:00'),(0,'POINTS_USING',0,'Использование баллов','POINTS_USING','','RU','2010-06-21 06:59:22','Использование баллов','2010-06-21 06:59:22'),(0,'POINTS_USING',0,'Використання балів','POINTS_USING','','UA','2010-06-21 06:59:09','Використання балів','2010-06-21 06:59:09'),(0,'points_using_comment',0,'<p>О начислении того или иного количества баллов сообщается в   конце каждого опроса. Чтобы избежать недоразумений, пожалуйста,   ознакамливайтесь с информацией о причинах начисления Вам баллов сразу,  не  &quot;просчелкивайте&quot; информационную страницу.</p>\r\n<p>В случае, если Вы не подошли по критериям отбора, Вам начисляется 50 баллов.</p>\r\n<p>&nbsp;</p>\r\n<p>Напоминаем, что Вы можете использовать свои баллы тремя способами:</p>\r\n<ol>\r\n    <li>Конвертировать в деньги (почтовый перевод).</li>\r\n    <li>Перевести на счет мобильного телефона.</li>\r\n    <li>Перевести на&nbsp;счет&nbsp;webmoney</li>\r\n</ol>\r\n<p>&nbsp;</p>\r\n<p>Принимайте участие в исследованиях и накапливайте больше баллов!</p>','points_using_comment','','RU','2011-06-15 12:34:52','<p>О начислении того или иного количества баллов сообщается в   конце каждого опроса. Чтобы избежать недоразумений, пожалуйста,   ознакамливайтесь с информацией о причинах начисления Вам баллов сразу,  не  &quot;просчелкивайте&quot; информационную страницу.</p>\r\n<p>В случае, если Вы не подошли по критериям отбора, Вам начисляется 50 баллов.</p>\r\n<p>&nbsp;</p>\r\n<p>Напоминаем, что Вы можете использовать свои баллы тремя способами:</p>\r\n<ol>\r\n    <li>Конвертировать в деньги (почтовый перевод).</li>\r\n    <li>Перевести на счет мобильного телефона.</li>\r\n    <li>Перевести на&nbsp;счет&nbsp;webmoney</li>\r\n</ol>\r\n<p>&nbsp;</p>\r\n<p>Принимайте участие в исследованиях и накапливайте больше баллов!</p>','2011-06-15 12:34:52'),(0,'points_using_comment',0,'<p>Про нарахування тої чи іншої кількості балів наголошується в  кінці кожного опитування з детальним описом причин цього нарахування. Щоб уникнути непорозумінь, будь-ласка,  ознайомлюйтесь з інформацією про причини нарахування Вам балів зразу, не  &quot;проклацуйте&quot; інформаційну сторінку.</p>\r\n<p>У випадку, якщо Ви не підійшли за критеріями відбору, Вам нараховується 50 балів.</p>\r\n<p>&nbsp;</p>\r\n<p>Нагадуємо, що ви можете використати свої бали трьома способами:</p>\r\n<ol>\r\n    <li>Сконвертувати у гроші (поштовий переказ).</li>\r\n    <li>Перевести на рахунок мобільного телефону.</li>\r\n    <li>Перевести на рахунок webmoney</li>\r\n</ol>\r\n<p>&nbsp;</p>\r\n<p>Беріть участь у опитуваннях та накопичуйте більше балів!</p>','points_using_comment','','UA','2011-06-15 12:32:12','<p>Про нарахування тої чи іншої кількості балів наголошується в  кінці кожного опитування з детальним описом причин цього нарахування. Щоб уникнути непорозумінь, будь-ласка,  ознайомлюйтесь з інформацією про причини нарахування Вам балів зразу, не  &quot;проклацуйте&quot; інформаційну сторінку.</p>\r\n<p>У випадку, якщо Ви не підійшли за критеріями відбору, Вам нараховується 50 балів.</p>\r\n<p>&nbsp;</p>\r\n<p>Нагадуємо, що ви можете використати свої бали трьома способами:</p>\r\n<ol>\r\n    <li>Сконвертувати у гроші (поштовий переказ).</li>\r\n    <li>Перевести на рахунок мобільного телефону.</li>\r\n    <li>Перевести на рахунок webmoney</li>\r\n</ol>\r\n<p>&nbsp;</p>\r\n<p>Беріть участь у опитуваннях та накопичуйте більше балів!</p>','2011-06-15 12:32:12'),(0,'POSTAL_ORDER',0,'Почтовый перевод','POSTAL_ORDER','','RU','2010-06-21 07:03:34','Почтовый перевод','2010-06-21 07:03:34'),(0,'POSTAL_ORDER',0,'Поштовий переказ','POSTAL_ORDER','','UA','2010-06-21 07:03:49','Поштовий переказ','2010-06-21 07:03:49'),(0,'POST_ORDER',0,'Поштовий переказ','POST_ORDER','','UA','2010-07-26 16:18:42','Поштовий переказ','2010-07-26 16:18:42'),(0,'PREVIOUS',0,'попередня','PREVIOUS',NULL,'UA','2010-04-11 14:13:54','попередня','2010-04-11 14:13:54'),(0,'PREVIOUS_PAGE',0,'Previous page','PREVIOUS_PAGE',NULL,'UA','2010-04-11 14:13:54','Previous page','2010-04-11 14:13:54'),(0,'PREVIOUS_PAGES_BLOCK',0,'Previous_pages_block','PREVIOUS_PAGES_BLOCK',NULL,'UA','2010-04-11 14:13:54','Previous_pages_block','2010-04-11 14:13:54'),(0,'PROJECT_CODE',0,'Код проекту','PROJECT_CODE',NULL,'UA','2010-04-02 08:23:55','Код проекту','2010-04-02 08:23:55'),(0,'READ_ALL_LAST_NEWS',0,'Все последние новости','READ_ALL_LAST_NEWS','','RU','2010-04-02 08:27:23','Все последние новости','2010-04-02 08:27:23'),(0,'READ_ALL_LAST_NEWS',0,'Переглянути всі останні новини','READ_ALL_LAST_NEWS','','UA','2010-04-09 13:46:46','Переглянути всі останні новини','2010-04-09 13:46:46'),(0,'RECIPIENT',0,'Отримувач','RECIPIENT','','UA','2010-07-26 16:34:53','Отримувач','2010-07-26 16:34:53'),(0,'RECIPIENT_ADDRESS',0,'Адреса отримання','RECIPIENT_ADDRESS','','UA','2010-07-26 16:35:13','Адреса отримання','2010-07-26 16:35:13'),(0,'REDRAW',0,'Обновить рисунок','REDRAW','','RU','2010-04-12 14:43:21','Обновить рисунок','2010-04-12 14:43:21'),(0,'REDRAW',0,'Оновити малюнок','REDRAW',NULL,'UA','2010-04-02 08:25:12','Оновити малюнок','2010-04-02 08:25:12'),(0,'REFFER',0,'Хто запросив?','REFFER','','UA','2010-07-13 13:13:01','Хто запросив?','2010-07-13 13:13:01'),(0,'reffer_email_body',0,'<p>Добрый день!</p>\r\n<p> </p>\r\n<p>Ваш знакомый {first_name} {last_name} приглашает Вас принять участие в сообществе TNS Opros.</p>\r\n<p> </p>\r\n<p>Участники сообщества могут получать вознаграждение за участие в маркетинговых исследованиях. Для регистрации в TNS Opros откройте страницу <%get_reffer_link%> и заполните форму регистрации.</p>\r\n<p> </p>\r\n<p>С наилучшими пожеланиями,</p>\r\n<p>Администрация TNS Opros.</p>','reffer_email_body','','RU','2010-07-14 07:29:02','<p>Добрый день!</p>\r\n<p> </p>\r\n<p>Ваш знакомый {first_name} {last_name} приглашает Вас принять участие в сообществе TNS Opros.</p>\r\n<p> </p>\r\n<p>Участники сообщества могут получать вознаграждение за участие в маркетинговых исследованиях. Для регистрации в TNS Opros откройте страницу <%get_reffer_link%> и заполните форму регистрации.</p>\r\n<p> </p>\r\n<p>С наилучшими пожеланиями,</p>\r\n<p>Администрация TNS Opros.</p>','2010-07-14 07:29:02'),(0,'reffer_email_body',0,'<p>Доброго дня!<br />\r\n<br />\r\nВаш знайомий {first_name} {last_name} надіслав Вам запрошення до участі в співтоваристві TNS Opros.<br />\r\n<br />\r\nУчасники співтовариства можуть отримувати винагороду за участь у маркетингових дослідженнях. Для реєстрації у TNS Opros відкрийте сторінку <%get_reffer_link%> та заповніть форму реєстрації.<br />\r\n<br />\r\nЗ найкращими побажаннями,<br />\r\n<br />\r\nАдміністрація TNS Opros.</p>','reffer_email_body','','UA','2010-07-14 15:40:34','<p>Доброго дня!<br />\r\n<br />\r\nВаш знайомий {first_name} {last_name} надіслав Вам запрошення до участі в співтоваристві TNS Opros.<br />\r\n<br />\r\nУчасники співтовариства можуть отримувати винагороду за участь у маркетингових дослідженнях. Для реєстрації у TNS Opros відкрийте сторінку <%get_reffer_link%> та заповніть форму реєстрації.<br />\r\n<br />\r\nЗ найкращими побажаннями,<br />\r\n<br />\r\nАдміністрація TNS Opros.</p>','2010-07-14 15:40:34'),(0,'reffer_email_subject',0,'Ваш знакомый пригласил Вас в TNS Opros','reffer_email_subject','','RU','2010-07-14 07:30:54','Ваш знакомый пригласил Вас в TNS Opros','2010-07-14 07:30:54'),(0,'reffer_email_subject',0,'Ваш знайомий запросив Вас до участі у TNS Opros','reffer_email_subject','','UA','2010-07-14 07:30:45','Ваш знайомий запросив Вас до участі у TNS Opros','2010-07-14 07:30:45'),(0,'REFFER_FORM',0,'Надіслати запрошення','REFFER_FORM','','UA','2010-07-14 06:49:56','Надіслати запрошення','2010-07-14 06:49:56'),(0,'REFFER_LINK',0,'Посилання','REFFER_LINK','','UA','2010-07-14 06:48:24','Посилання','2010-07-14 06:48:24'),(0,'REGION',0,NULL,'REGION','','RU','2010-07-02 09:56:01',NULL,'2010-07-02 09:56:01'),(0,'REGION',0,'Район*','REGION','','UA','2010-07-02 09:56:00','Район*','2010-07-02 09:56:00'),(0,'REGISTRATION_FORM',0,'Регистрационный бланк','REGISTRATION_FORM','','RU','2010-04-12 14:38:57','Регистрационный бланк','2010-04-12 14:38:57'),(0,'REGISTRATION_FORM',0,'Реєстраційний бланк','REGISTRATION_FORM',NULL,'UA','2010-04-02 08:25:12','Реєстраційний бланк','2010-04-02 08:25:12'),(0,'registration_form_block_content',0,'<p class=\"content_simple_text\">Еще не успели зарегистрироваться? Переходите по ссылке и заполняйте форму регистрации.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=47&amp;language=UA\">Зарегистрироваться</a></p>','registration_form_block_content','','RU','2010-04-12 15:26:22','<p class=\"content_simple_text\">Еще не успели зарегистрироваться? Переходите по ссылке и заполняйте форму регистрации.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=47&amp;language=UA\">Зарегистрироваться</a></p>','2010-04-12 15:26:22'),(0,'registration_form_block_content',0,'<p class=\"content_simple_text\">Ще не встигли зареєструватись? Перейдіть за посиланням та заповніть форму реєстрації.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=47&amp;language=UA\">Зареєструватись</a></p>','registration_form_block_content','','UA','2010-01-14 12:14:46','<p class=\"content_simple_text\">Ще не встигли зареєструватись? Перейдіть за посиланням та заповніть форму реєстрації.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=47&amp;language=UA\">Зареєструватись</a></p>','2010-01-14 12:14:46'),(0,'REPLENISHMENT_MOBILE',0,'Пополнение мобильного','REPLENISHMENT_MOBILE','','RU','2010-06-21 07:04:03','Пополнение мобильного','2010-06-21 07:04:03'),(0,'REPLENISHMENT_MOBILE',0,'Поповнення мобільного','REPLENISHMENT_MOBILE','','UA','2010-08-18 09:14:21','Поповнення мобільного','2010-08-18 09:14:21'),(0,'REPLENISHMENT_WEBMONEY',0,'Поповнення WebMoney','REPLENISHMENT_WEBMONEY','','UA','2010-07-26 16:18:24','Поповнення WebMoney','2010-07-26 16:18:24'),(0,'RESPONDENT_CODE',0,'Код респондента','RESPONDENT_CODE',NULL,'UA','2010-04-02 08:23:55','Код респондента','2010-04-02 08:23:55'),(0,'respondent_registered_email_body',0,'<p>Шановний {first_name} {last_name}!</p>\r\n<p>Щоб завершити реєстрацію на сайті {HTTP} - натисніть&nbsp;{approving_form_link}.</p>','respondent_registered_email_body','','UA','2009-12-10 18:13:06','<p>Шановний {first_name} {last_name}!</p>\r\n<p>Щоб завершити реєстрацію на сайті {HTTP} - натисніть&nbsp;{approving_form_link}.</p>','2009-12-10 18:13:06'),(0,'respondent_registered_email_subject',0,'Реєстрація на сайті {HTTP}','respondent_registered_email_subject','{HTTP} - адреса сайту','UA','2009-12-10 17:48:17','Реєстрація на сайті {HTTP}','2009-12-10 17:48:17'),(0,'results_block_content',0,'<p class=\"content_simple_text\">Раздел посвящен результатам проведенных компанией TNS исследований. Вы можетет ознакомиться с ними на сайте или загрузить их к себе на компютер.</p>\r\n<p><a href=\"/index.php?t=51&amp;language=UA\" class=\"system_button2\">Перейти к разделу</a></p>','results_block_content','','RU','2010-04-12 15:27:15','<p class=\"content_simple_text\">Раздел посвящен результатам проведенных компанией TNS исследований. Вы можетет ознакомиться с ними на сайте или загрузить их к себе на компютер.</p>\r\n<p><a href=\"/index.php?t=51&amp;language=UA\" class=\"system_button2\">Перейти к разделу</a></p>','2010-04-12 15:27:15'),(0,'results_block_content',0,'<p class=\"content_simple_text\">Розділ присвячений результатам проведених компанією TNS досліджень. Ви можете ознайомитись з ними на сайті або завантажити їх на свій компютер.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=51&amp;language=UA\">Перейти до розділу</a></p>','results_block_content','','UA','2010-04-12 08:52:32','<p class=\"content_simple_text\">Розділ присвячений результатам проведених компанією TNS досліджень. Ви можете ознайомитись з ними на сайті або завантажити їх на свій компютер.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=51&amp;language=UA\">Перейти до розділу</a></p>','2010-04-12 08:52:32'),(0,'right_block_b_class_current_projects',0,'CCE4D7','right_block_b_class_current_projects','','UA','2010-01-14 07:49:04','CCE4D7','2010-01-14 07:49:04'),(0,'right_block_b_class_faq',0,'','Цвет footer блока. Может быть одно из значений: CCE8F3 (голубой), CCE4D7 (зеленый), E1DFED (фиолетов','','UA','2010-01-18 16:58:10','','2010-01-18 16:58:10'),(0,'right_block_b_class_my_points',0,'CCE4D7','right_block_b_class_my_points','','UA','2010-01-14 07:30:56','CCE4D7','2010-01-14 07:30:56'),(0,'right_block_b_class_news',0,NULL,'right_block_b_class_news',NULL,'RU','2010-04-13 12:31:46',NULL,'2010-04-13 12:31:46'),(0,'right_block_b_class_news',0,'E1DFED','right_block_b_class_news','','UA','2010-01-14 08:09:02','E1DFED','2010-01-14 08:09:02'),(0,'right_block_b_class_points_convertion',0,'E1DFED','right_block_b_class_points_convertion','','UA','2010-01-14 10:34:44','E1DFED','2010-01-14 10:34:44'),(0,'right_block_b_class_registration_form',0,'','Цвет footer блока. Может быть одно из значений: CCE4D7, CCE8F3, E1DFED или пустое значение','','UA','2010-01-18 16:30:49','','2010-01-18 16:30:49'),(0,'right_block_b_class_results',0,'E1DFED','Цвет footer блока. Может быть одно из значений: CCE8F3 (голубой), CCE4D7 (зеленый), E1DFED (фиолетов','','UA','2010-01-18 16:57:40','E1DFED','2010-01-18 16:57:40'),(0,'right_block_b_class_system',0,'E1DFED','right_block_b_class_system','','UA','2010-01-14 08:59:02','E1DFED','2010-01-14 08:59:02'),(0,'right_block_b_class_usefull_contact',0,'E1DFED','right_block_b_class_usefull_contact','','UA','2010-01-13 18:34:33','E1DFED','2010-01-13 18:34:33'),(0,'right_block_faq',0,'<p><img height=\"49\" width=\"49\" align=\"left\" vspace=\"4\" alt=\"\" src=\"/usersimage/Image/faq.png\" /></p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px\">Відповіді на найпоширеніші питання у розділі Frequently Asked Questions.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=86&amp;language=UA\">Перейти до розділу</a></p>','right_block_faq','','UA','2010-01-13 11:49:37','<p><img height=\"49\" width=\"49\" align=\"left\" vspace=\"4\" alt=\"\" src=\"/usersimage/Image/faq.png\" /></p>\r\n<p class=\"content_simple_text\" style=\"margin-left: 60px\">Відповіді на найпоширеніші питання у розділі Frequently Asked Questions.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=86&amp;language=UA\">Перейти до розділу</a></p>','2010-01-13 11:49:37'),(0,'right_block_h_class_contact',0,NULL,'right_block_h_class_contact',NULL,'UA','2010-01-14 11:45:33',NULL,'2010-01-14 11:45:33'),(0,'right_block_h_class_current_projects',0,'47B3B8','right_block_h_class_current_projects','','UA','2010-01-14 07:48:38','47B3B8','2010-01-14 07:48:38'),(0,'right_block_h_class_faq',0,NULL,'right_block_h_class_faq',NULL,'RU','2010-04-12 08:50:38',NULL,'2010-04-12 08:50:38'),(0,'right_block_h_class_faq',0,'','Цвет шапки блока. Может быть 3A5D0 (голубой), 47B3B8 (зеленый), 8A81BA (фиолетовый) или пустым (буде','','UA','2010-01-18 16:55:42','','2010-01-18 16:55:42'),(0,'right_block_h_class_my_points',0,'47B3B8','right_block_h_class_my_points','','UA','2010-01-14 07:17:04','47B3B8','2010-01-14 07:17:04'),(0,'right_block_h_class_news',0,NULL,'right_block_h_class_news',NULL,'RU','2010-04-13 12:31:06',NULL,'2010-04-13 12:31:06'),(0,'right_block_h_class_news',0,'8A81BA','right_block_h_class_news','','UA','2010-01-14 08:08:36','8A81BA','2010-01-14 08:08:36'),(0,'right_block_h_class_points_convertion',0,'8A81BA','right_block_h_class_points_convertion','','UA','2010-01-14 10:33:50','8A81BA','2010-01-14 10:33:50'),(0,'right_block_h_class_registration_form',0,'','Цвет шапки блока. Может быть 3A5D0, 47B3B8, 8A81BA или пустым','','UA','2010-01-18 16:27:53','','2010-01-18 16:27:53'),(0,'right_block_h_class_results',0,'8A81BA','Цвет шапки блока. Может быть 3A5D0 (голубой), 47B3B8 (зеленый), 8A81BA (фиолетовый) или пустым (буде','','UA','2010-01-18 16:55:51','8A81BA','2010-01-18 16:55:51'),(0,'right_block_h_class_system',0,'8A81BA','right_block_h_class_system','','UA','2010-01-14 08:58:39','8A81BA','2010-01-14 08:58:39'),(0,'right_block_h_class_usefull_contact',0,'8A81BA','right_block_h_class_usefull_contact','','UA','2010-01-13 18:33:53','8A81BA','2010-01-13 18:33:53'),(0,'rows_on_page__tpl_page_',1,'75','rows_on_page__tpl_page_1','','UA','2009-11-20 11:15:55','75','2009-11-20 11:15:55'),(0,'ROW_NUM',0,'Row num','ROW_NUM',NULL,'UA','2010-04-02 08:23:57','Row num','2010-04-02 08:23:57'),(0,'rules_read_confirm',0,'<p>Я подтверждаю прочтение <a href=\"/index.php?t=46&amp;language=UA\" target=\"_blank\">Правил участия</a><br />\r\nи не имею возражений касательно их содержания.</p>','rules_read_confirm','','RU','2011-03-16 08:25:51','<p>Я подтверждаю прочтение <a href=\"/index.php?t=46&amp;language=UA\" target=\"_blank\">Правил участия</a><br />\r\nи не имею возражений касательно их содержания.</p>','2011-03-16 08:25:51'),(0,'rules_read_confirm',0,'<p>Я підтверджую прочитання <a href=\"/index.php?t=46&amp;language=UA\" target=\"_blank\">Правил участі</a><br />\r\nта не маю заперечень щодо їх змісту.</p>','rules_read_confirm','','UA','2011-03-16 08:25:46','<p>Я підтверджую прочитання <a href=\"/index.php?t=46&amp;language=UA\" target=\"_blank\">Правил участі</a><br />\r\nта не маю заперечень щодо їх змісту.</p>','2011-03-16 08:25:46'),(0,'SAVE',0,'Сохранить','SAVE','','RU','2010-04-15 14:00:18','Сохранить','2010-04-15 14:00:18'),(0,'SAVE',0,'Зберегти','SAVE',NULL,'UA','2010-04-03 08:32:08','Зберегти','2010-04-03 08:32:08'),(0,'SELECT_CONVERTION_TYPE',0,'Select convertion type','SELECT_CONVERTION_TYPE',NULL,'UA','2010-11-30 16:15:50','Select convertion type','2010-11-30 16:15:50'),(0,'SELECT_POINTS_CONVERTION_TYPE',0,'Способ конвертации','SELECT_POINTS_CONVERTION_TYPE','','RU','2010-06-21 07:02:14','Способ конвертации','2010-06-21 07:02:14'),(0,'SELECT_POINTS_CONVERTION_TYPE',0,'Спосіб конвертації','SELECT_POINTS_CONVERTION_TYPE','','UA','2010-06-21 07:02:24','Спосіб конвертації','2010-06-21 07:02:24'),(0,'SEND',0,'Отправить','SEND','','RU','2010-04-12 14:45:07','Отправить','2010-04-12 14:45:07'),(0,'SEND',0,'Надіслати','SEND',NULL,'UA','2010-04-02 08:25:12','Надіслати','2010-04-02 08:25:12'),(0,'SEND_REQUEST',0,'Подать заявку','SEND_REQUEST','','RU','2010-08-18 09:17:33','Подать заявку','2010-08-18 09:17:33'),(0,'SEND_REQUEST',0,'Подати заявку','SEND_REQUEST','','UA','2010-07-26 16:26:05','Подати заявку','2010-07-26 16:26:05'),(0,'SETTLEMENT',0,'Район города*','SETTLEMENT','','RU','2010-07-02 09:56:19','Район города*','2010-07-02 09:56:19'),(0,'SETTLEMENT',0,'Район міста*','SETTLEMENT','','UA','2010-07-02 09:56:17','Район міста*','2010-07-02 09:56:17'),(0,'SEX',0,'Пол*','SEX','','RU','2010-07-02 09:55:29','Пол*','2010-07-02 09:55:29'),(0,'SEX',0,'Стать*','SEX','','UA','2010-07-02 09:55:27','Стать*','2010-07-02 09:55:27'),(0,'START_CONVERTION',0,NULL,'START_CONVERTION',NULL,'EN','2010-07-26 16:39:44',NULL,'2010-07-26 16:39:44'),(0,'START_CONVERTION',0,'Начать конвертацию','START_CONVERTION','','RU','2010-08-18 09:13:49','Начать конвертацию','2010-08-18 09:13:49'),(0,'START_CONVERTION',0,'Почати конвертацію','START_CONVERTION','','UA','2010-08-18 09:13:37','Почати конвертацію','2010-08-18 09:13:37'),(0,'STREET',0,'Улица*','STREET','','RU','2010-07-02 09:56:28','Улица*','2010-07-02 09:56:28'),(0,'STREET',0,'Вулиця*','STREET','','UA','2010-07-02 09:56:26','Вулиця*','2010-07-02 09:56:26'),(0,'submit_text',0,'Confirm','submit_text',NULL,'EN','2009-11-14 21:07:33','Confirm','2009-11-14 21:07:33'),(0,'subscribe_confirm_thanks_content',0,'Your subscription is confirmed. Thank you.','subscribe_confirm_thanks_content',NULL,'EN','2009-11-14 21:07:33','Your subscription is confirmed. Thank you.','2009-11-14 21:07:33'),(0,'subscribe_error',0,'There are happened some error. Maybe you already confirmed the subscription/unsubscription.','subscribe_error',NULL,'EN','2009-11-14 21:07:33','There are happened some error. Maybe you already confirmed the subscription/unsubscription.','2009-11-14 21:07:33'),(0,'subscribe_error',0,NULL,'subscribe_error',NULL,'UA','2010-03-25 14:16:55',NULL,'2010-03-25 14:16:55'),(0,'subscription_thanks_content',0,'Thank you for subscription!','subscription_thanks_content',NULL,'EN','2009-11-14 21:07:33','Thank you for subscription!','2009-11-14 21:07:33'),(0,'survey_history_no_info',0,'<p class=\"content_simple_text\">Якщо ви ще не брали участь у дослідженнях, то, будь-ласка, перейдіть до розділу &ldquo;<a href=\"/index.php?t=45&amp;language=UA\">Поточні дослідження</a>&rdquo;, де ви зможете ознайомитися з переліком досліджень, що проводятся в даний час та взяти участь у тих, що вас зацікавлять.</p>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Якщо ви брали участь у дослідженнях, але система не зареєструвала цього, то, будь-ласка, повідомте про це в службу підтримки:</p>\r\n<p><a class=\"system_button2\" href=\"mailto:info@2kgroup.com\">Повідомити службу підтримки</a></p>','survey_history_no_info','','UA','2010-01-27 05:18:46','<p class=\"content_simple_text\">Якщо ви ще не брали участь у дослідженнях, то, будь-ласка, перейдіть до розділу &ldquo;<a href=\"/index.php?t=45&amp;language=UA\">Поточні дослідження</a>&rdquo;, де ви зможете ознайомитися з переліком досліджень, що проводятся в даний час та взяти участь у тих, що вас зацікавлять.</p>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Якщо ви брали участь у дослідженнях, але система не зареєструвала цього, то, будь-ласка, повідомте про це в службу підтримки:</p>\r\n<p><a class=\"system_button2\" href=\"mailto:info@2kgroup.com\">Повідомити службу підтримки</a></p>','2010-01-27 05:18:46'),(0,'SURVEY_TITLE',0,'Тема опроса','SURVEY_TITLE','','RU','2010-04-15 11:57:33','Тема опроса','2010-04-15 11:57:33'),(0,'SURVEY_TITLE',0,'Тема опитування','SURVEY_TITLE',NULL,'UA','2010-04-02 08:23:57','Тема опитування','2010-04-02 08:23:57'),(0,'system_block_content',0,'<p class=\"content_simple_text\">Дізнайтеся більше про те, як можна використати свої бали, а також багато іншої цікавої інформації.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=52&amp;language=UA\">Перейти до розділу</a></p>','system_block_content','','UA','2010-01-28 22:04:00','<p class=\"content_simple_text\">Дізнайтеся більше про те, як можна використати свої бали, а також багато іншої цікавої інформації.</p>\r\n<p><a class=\"system_button2\" href=\"/index.php?t=52&amp;language=UA\">Перейти до розділу</a></p>','2010-01-28 22:04:00'),(0,'TAKE_PART',0,'Принять участие:','TAKE_PART','','RU','2010-04-09 13:47:16','Принять участие:','2010-04-09 13:47:16'),(0,'TAKE_PART',0,'Взяти участь','TAKE_PART','','UA','2010-04-09 13:46:57','Взяти участь','2010-04-09 13:46:57'),(0,'TAKE_PART_IN_INVESTIGATION',0,'Принять участие в исследовании','TAKE_PART_IN_INVESTIGATION','','RU','2010-04-15 12:13:25','Принять участие в исследовании','2010-04-15 12:13:25'),(0,'TAKE_PART_IN_INVESTIGATION',0,'Взяти участь у дослідженні','TAKE_PART_IN_INVESTIGATION',NULL,'UA','2010-04-02 08:35:35','Взяти участь у дослідженні','2010-04-02 08:35:35'),(0,'text_bottom',0,'text_bottom','text_bottom',NULL,'EN','2010-03-20 06:30:00','text_bottom','2009-11-14 21:07:33'),(0,'THERE_IS_NO_REFFER_WITH_SUCH_E-MAIL',0,'Такий e-mail в системі не зареєстровано','THERE_IS_NO_REFFER_WITH_SUCH_E-MAIL','','UA','2010-07-14 07:32:56','Такий e-mail в системі не зареєстровано','2010-07-14 07:32:56'),(0,'title_no_template',0,'title_no_template',NULL,NULL,'EN','2010-03-20 06:30:00','title_no_template','2009-11-14 21:07:33'),(0,'TOTAL',0,'Total','TOTAL',NULL,'UA','2010-04-02 08:23:57','Total','2010-04-02 08:23:57'),(0,'TOTAL_POINTS_AVAILABLE',0,'Всего доступных баллов','TOTAL_POINTS_AVAILABLE','','RU','2010-04-15 11:58:28','Всего доступных баллов','2010-04-15 11:58:28'),(0,'TOTAL_POINTS_AVAILABLE',0,'Всього доступних балів','TOTAL_POINTS_AVAILABLE',NULL,'UA','2010-04-02 08:23:57','Всього доступних балів','2010-04-02 08:23:57'),(0,'TOTAL_POINTS_USED',0,'Всего использовано баллов','TOTAL_POINTS_USED','','RU','2010-04-15 11:58:11','Всего использовано баллов','2010-04-15 11:58:11'),(0,'TOTAL_POINTS_USED',0,'Всього використано балів','TOTAL_POINTS_USED',NULL,'UA','2010-04-02 08:23:57','Всього використано балів','2010-04-02 08:23:57'),(0,'UNKNOWN_CONVERTION_TYPE_ID',0,'unknown_convertion_type_id','UNKNOWN_CONVERTION_TYPE_ID',NULL,'UA','2010-12-24 14:39:15','unknown_convertion_type_id','2010-12-24 14:39:15'),(0,'UNKNOWN_PROVIDER_CODE',0,'Системе не удалось распознать код сети оператора мобильной связи.','UNKNOWN_PROVIDER_CODE','','RU','2011-06-22 23:27:12','Системе не удалось распознать код сети оператора мобильной связи.','2011-06-22 23:27:12'),(0,'UNKNOWN_PROVIDER_CODE',0,'Системі не вдалось розпізнати код мережі оператора мобільного звязку.','UNKNOWN_PROVIDER_CODE','','UA','2011-06-22 23:27:05','Системі не вдалось розпізнати код мережі оператора мобільного звязку.','2011-06-22 23:27:05'),(0,'UNKNOWN_PROVIDER_CODE',1,'Unknown provider code1','UNKNOWN_PROVIDER_CODE1',NULL,'UA','2011-06-22 23:25:26','Unknown provider code1','2011-06-22 23:25:26'),(0,'unsubscribe_confirm_thanks_content',0,'Your unsubscription is confirmed.','unsubscribe_confirm_thanks_content',NULL,'EN','2009-11-14 21:07:33','Your unsubscription is confirmed.','2009-11-14 21:07:33'),(0,'unsubscription_thanks_content',0,'Thank you for unsubscription!','unsubscription_thanks_content',NULL,'EN','2009-11-14 21:07:33','Thank you for unsubscription!','2009-11-14 21:07:33'),(0,'usefull_contact_block_content',0,'<p>1111 111 111111111 1 111111 11 1 111111</p>','usefull_contact_block_content','','UA','2010-01-13 18:22:18','<p>1111 111 111111111 1 111111 11 1 111111</p>','2010-01-13 18:22:18'),(0,'usefull_contact_block_title',0,'11111','usefull_contact_block_title','','UA','2010-01-13 18:21:15','11111','2010-01-13 18:21:15'),(0,'USER_WITH_SUCH_CELL_PHONE_ALREADY_BLOCKED',0,'Користувач з таким номером мобільного телефону заблокований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','USER_WITH_SUCH_CELL_PHONE_ALREADY_BLOCKED','','UA','2010-11-16 13:49:01','Користувач з таким номером мобільного телефону заблокований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','2010-11-16 13:49:01'),(0,'USER_WITH_SUCH_CELL_PHONE_ALREADY_EXISTS',0,'Користувач з таким номером мобільного телефону вже зареєстрований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','USER_WITH_SUCH_CELL_PHONE_ALREADY_EXISTS','','UA','2010-11-16 13:53:32','Користувач з таким номером мобільного телефону вже зареєстрований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','2010-11-16 13:53:32'),(0,'USER_WITH_SUCH_CITY_PHONE_ALREADY_BLOCKED',0,'Користувач з таким номером домашнього телефону заблокований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','USER_WITH_SUCH_CITY_PHONE_ALREADY_BLOCKED','','UA','2010-11-16 13:47:36','Користувач з таким номером домашнього телефону заблокований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','2010-11-16 13:47:36'),(0,'USER_WITH_SUCH_CITY_PHONE_ALREADY_EXISTS',0,'Користувач з таким номером домашнього телефону вже зареєстрований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','USER_WITH_SUCH_CITY_PHONE_ALREADY_EXISTS','','UA','2010-11-16 13:51:59','Користувач з таким номером домашнього телефону вже зареєстрований. Будь ласка, оберiть для реєстрацiї iнший номер телефону.','2010-11-16 13:51:59'),(0,'USE_OTHER-OPTION_TO_ENTER_OWN_VALUE',0,'Скористайтесь пунктом \'Iнший варiант\' щоб ввести назву самостiйно','USE_OTHER-OPTION_TO_ENTER_OWN_VALUE',NULL,'UA','2010-04-02 08:25:12','Скористайтесь пунктом \'Iнший варiант\' щоб ввести назву самостiйно','2010-04-02 08:25:12'),(0,'why_register_block_1_description',0,'<p class=\"content_simple_text\"><span class=\"arial12px\">Інформація &ndash; найцінніший ресурс сучасного цивілізованого світу.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Ви завжди будете в курсі останніх тенденцій і розробок на споживчих ринках. Ви приймете участь у розробці нових товарів та послуг. Вам буде відомо про зміни&nbsp;в асортименті, якості та складі товарів заздалегідь.</span></p>','why_register_block_1_description','','UA','2010-01-12 16:30:26','<p class=\"content_simple_text\"><span class=\"arial12px\">Інформація &ndash; найцінніший ресурс сучасного цивілізованого світу.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Ви завжди будете в курсі останніх тенденцій і розробок на споживчих ринках. Ви приймете участь у розробці нових товарів та послуг. Вам буде відомо про зміни&nbsp;в асортименті, якості та складі товарів заздалегідь.</span></p>','2010-01-12 16:30:26'),(0,'why_register_block_1_title',0,'Інформованість','why_register_block_1_title','','UA','2010-01-12 16:36:02','Інформованість','2010-01-12 16:36:02'),(0,'why_register_block_2_description',0,'<p class=\"content_simple_text\"><span class=\"arial12px\">Інформація &ndash; найцінніший ресурс сучасного цивілізованого світу.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Ви завжди будете в курсі останніх тенденцій і розробок на споживчих ринках. Ви приймете участь у розробці нових товарів та послуг. Вам буде відомо про зміни&nbsp;в асортименті, якості та складі товарів заздалегідь.</span></p>','why_register_block_2_description','','UA','2010-01-12 18:30:31','<p class=\"content_simple_text\"><span class=\"arial12px\">Інформація &ndash; найцінніший ресурс сучасного цивілізованого світу.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Ви завжди будете в курсі останніх тенденцій і розробок на споживчих ринках. Ви приймете участь у розробці нових товарів та послуг. Вам буде відомо про зміни&nbsp;в асортименті, якості та складі товарів заздалегідь.</span></p>','2010-01-12 18:30:31'),(0,'why_register_block_2_title',0,'Винагорода','why_register_block_2_title','','UA','2010-01-12 16:44:58','Винагорода','2010-01-12 16:44:58'),(0,'why_register_block_3_description',0,'<p>Визнання &ndash; найкраща подяка.</p>\r\n<p>&nbsp;</p>\r\n<p>Ваша думка визнана дуже важливою. Кожен учасник проекту вносить свою корективу у формування остаточних рішень щодо випуску товарів та послуг, вказує на стратегію виробника для задоволення власних потреб.</p>','why_register_block_3_description','','UA','2010-01-12 18:29:39','<p>Визнання &ndash; найкраща подяка.</p>\r\n<p>&nbsp;</p>\r\n<p>Ваша думка визнана дуже важливою. Кожен учасник проекту вносить свою корективу у формування остаточних рішень щодо випуску товарів та послуг, вказує на стратегію виробника для задоволення власних потреб.</p>','2010-01-12 18:29:39'),(0,'why_register_block_3_title',0,'Важливість вашої думки','why_register_block_3_title','','UA','2010-01-12 16:45:27','Важливість вашої думки','2010-01-12 16:45:27'),(0,'YOUR_ACCOUNT_%%S_POINTS',0,'На Вашому рахунку %%s балів','YOUR_ACCOUNT_%%S_POINTS','','UA','2010-04-12 15:19:56','На Вашому рахунку %%s балів','2010-04-12 15:19:56'),(0,'YOUR_ACCOUNT_%S_POINTS',0,NULL,'YOUR_ACCOUNT_%S_POINTS','','EN','2010-04-09 13:52:19',NULL,'2010-04-09 13:52:19'),(0,'YOUR_ACCOUNT_%S_POINTS',0,'На Вашому рахунку %s балів','YOUR_ACCOUNT_%S_POINTS','','RU','2010-04-09 13:58:36','На Вашому рахунку %s балів','2010-04-09 13:58:36'),(0,'YOUR_ACCOUNT_%S_POINTS',0,'На Вашому рахунку %s балів','YOUR_ACCOUNT_%S_POINTS','','UA','2010-04-12 13:16:49','На Вашому рахунку %s балів','2010-04-12 13:16:49'),(0,'YOUR_ACCOUNT_IS_BLOCKED',0,'Ваш акаунт был заблокирован. За дополнительной информацией обращайтесь к Администрации.','YOUR_ACCOUNT_IS_BLOCKED','','RU','2010-07-27 10:08:42','Ваш акаунт был заблокирован. За дополнительной информацией обращайтесь к Администрации.','2010-07-27 10:08:42'),(0,'YOUR_ACCOUNT_IS_BLOCKED',0,'Ваш акаунт було заблоковано. За додатковою інформацією звертайтеся до Адміністрації.','YOUR_ACCOUNT_IS_BLOCKED','','UA','2010-07-27 10:08:24','Ваш акаунт було заблоковано. За додатковою інформацією звертайтеся до Адміністрації.','2010-07-27 10:08:24'),(0,'your_email_text',0,'E-mail:','your_email_text',NULL,'EN','2009-11-14 21:07:33','E-mail:','2009-11-14 21:07:33'),(0,'your_lname_text',0,'Surname:','your_lname_text',NULL,'EN','2009-11-14 21:07:33','Surname:','2009-11-14 21:07:33'),(0,'your_name_text',0,'Name:','your_name_text',NULL,'EN','2009-11-14 21:07:33','Name:','2009-11-14 21:07:33'),(0,'YOUR_REFFER_LINK',0,'Ваше посилання для запрошення нових учасників','YOUR_REFFER_LINK','','UA','2010-07-14 06:47:37','Ваше посилання для запрошення нових учасників','2010-07-14 06:47:37'),(0,'YOU_ARE_HERE',0,'Вы находитесь тут','YOU_ARE_HERE','','RU','2011-03-18 10:06:03','Вы находитесь тут','2011-03-18 10:06:03'),(0,'YOU_ARE_HERE',0,'Ви знаходитесь тут','YOU_ARE_HERE','','UA','2010-04-09 13:57:12','Ви знаходитесь тут','2010-04-09 13:57:12'),(0,'YOU_CAN_NOT_USE_MORE_THEN_%S_POINTS_NUMBER',0,'Ви не можете використати більше ніж %s балів','YOU_CAN_NOT_USE_MORE_THEN_%S_POINTS_NUMBER','','UA','2010-08-19 15:20:20','Ви не можете використати більше ніж %s балів','2010-08-19 15:20:20'),(0,'Район_города_с_кодом__82200__не_найден_в_репозитар',0,NULL,'Район_города_с_кодом__82200__не_найден_в_репозитарии',NULL,'EN','2011-01-10 11:50:02',NULL,'2011-01-10 11:50:02'),(0,'Район_города_с_кодом__82200__не_найден_в_репозитар',0,'','','','UA','2011-01-10 11:50:02','','2011-01-10 11:50:02'),(1,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-08 13:51:35'),(1,'media_inserted_index_block_',4,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"76\";}','Media id for object index_block_4 on page 1',NULL,'','2010-01-08 14:36:45','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"76\";}','2010-01-08 14:36:45'),(1,'media_inserted_index_block_1_header',0,'a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"35\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"95\";}','Media id for object index_block_1_header on page 1','','','2010-04-13 09:37:07','a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"35\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"95\";}','2010-04-13 09:37:07'),(1,'media_inserted_index_block_1_header_for_authorized',0,'a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"30\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"96\";}','Media id for object index_block_1_header_for_authorized on page 1','','','2010-04-13 12:25:28','a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"30\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"96\";}','2010-04-13 12:25:28'),(1,'media_inserted_index_block_1_top',0,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"71\";}','Media id for object index_block_1_top on page 1',NULL,'','2010-01-08 14:31:33','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"71\";}','2010-01-08 14:31:33'),(1,'media_inserted_index_block_2_header',0,'a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"40\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"72\";}','Media id for object index_block_2_header on page 1','','','2010-01-28 18:22:41','a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"40\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"72\";}','2010-01-28 18:22:41'),(1,'media_inserted_index_block_2_top',0,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"73\";}','Media id for object index_block_2_top on page 1',NULL,'','2010-01-08 14:31:47','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"73\";}','2010-01-08 14:31:47'),(1,'media_inserted_index_block_3_header',0,'a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"47\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"74\";}','Media id for object index_block_3_header on page 1',NULL,'','2010-01-08 14:08:57','a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"47\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"74\";}','2010-01-08 14:08:57'),(1,'media_inserted_index_block_3_header_for_authorized',0,'a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"45\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"94\";}','Media id for object index_block_3_header_for_authorized on page 1','','','2010-04-13 12:25:51','a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"45\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"94\";}','2010-04-13 12:25:51'),(1,'media_inserted_index_block_3_top',0,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"75\";}','Media id for object index_block_3_top on page 1',NULL,'','2010-01-08 14:32:01','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"75\";}','2010-01-08 14:32:01'),(1,'media_inserted_index_splash',0,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:3:\"102\";}','Media id for object index_splash on page 1','','','2011-08-10 08:38:01','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:3:\"102\";}','2011-08-10 08:38:01'),(1,'media_title_index_block_',4,'','Media id for object index_block_4 on page 1',NULL,'UA','2010-01-08 14:36:45','','2010-01-08 14:36:45'),(1,'media_title_index_block_1_header',0,'','Media id for object index_block_1_header on page 1','','UA','2010-04-13 09:37:07','','2010-04-13 09:37:07'),(1,'media_title_index_block_1_header_for_authorized',0,'','Media id for object index_block_1_header_for_authorized on page 1','','UA','2010-04-13 12:25:28','','2010-04-13 12:25:28'),(1,'media_title_index_block_1_top',0,'','Media id for object index_block_1_top on page 1',NULL,'UA','2010-01-08 14:31:33','','2010-01-08 14:31:33'),(1,'media_title_index_block_2_header',0,'','Media id for object index_block_2_header on page 1','','UA','2010-01-28 18:22:41','','2010-01-28 18:22:41'),(1,'media_title_index_block_2_top',0,'','Media id for object index_block_2_top on page 1',NULL,'UA','2010-01-08 14:31:47','','2010-01-08 14:31:47'),(1,'media_title_index_block_3_header',0,'','Media id for object index_block_3_header on page 1',NULL,'UA','2010-01-08 14:08:57','','2010-01-08 14:08:57'),(1,'media_title_index_block_3_header_for_authorized',0,'','Media id for object index_block_3_header_for_authorized on page 1','','UA','2010-04-13 12:25:51','','2010-04-13 12:25:51'),(1,'media_title_index_block_3_top',0,'','Media id for object index_block_3_top on page 1',NULL,'UA','2010-01-08 14:32:01','','2010-01-08 14:32:01'),(1,'media_title_index_splash',0,'','Media id for object index_splash on page 1','','RU','2010-04-20 11:30:46','','2010-04-20 11:30:46'),(1,'media_title_index_splash',0,'','Media id for object index_splash on page 1','','UA','2011-08-10 08:38:01','','2011-08-10 08:38:01'),(19,'nl_notification_from_email',0,'root@2kgroup.com','nl_notification_from_email',NULL,'EN','2009-11-14 21:07:33','root@2kgroup.com','2009-11-14 21:07:33'),(19,'nl_notification_subject',0,'Test Subject','nl_notification_subject',NULL,'EN','2009-11-14 21:07:33','Test Subject','2009-11-14 21:07:33'),(19,'page_content',0,'Hello!\r\n\r\nYou have just subscribed to the Newsletters\r\n\r\nPlease click on the following link to confirm your subscription:\r\n{{CONFIRM_LINK}}\r\nBest Regards\r\nm','page_content',NULL,'EN','2010-03-20 06:30:00','Hello!\r\n\r\nYou have just subscribed to the Newsletters\r\n\r\nPlease click on the following link to confirm your subscription:\r\n{{CONFIRM_LINK}}\r\nBest Regards\r\nm','2009-11-14 21:07:33'),(29,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-14 16:01:17'),(29,'internal_page_content',0,NULL,'internal_page_content','','RU','2011-06-14 09:22:13',NULL,'2011-06-14 09:22:13'),(29,'internal_page_content',0,'<h1>Використання інформації на веб-сайті</h1>\r\n<p class=\"content_simple_text\">Будь-яка особа може отримати доступ до даного веб-сайту та використовувати його виключно при виконанні умов, викладених нижче, а також чинного законодавства України. <br />\r\nКористувач має право переглядати інформацію на даному веб-сайті виключно в цілях отримання інформації для особистих потреб. Категорично забороняється розповсюдження інформації, отриманої на даному веб-сайті, зміна та виправлення її будь-яким чином або передача третім особам у комерційних цілях без письмового дозволу ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;.<br />\r\nТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; не несе відповідальності за прямі або опосередковані збитки, що можуть виникнути у Користувача в результаті отримання доступу або використання будь-якої інформації, що міститься на даному веб-сайті або на будь-якому з веб-сайтів, що мають інтерактивний зв&rsquo;язок з ним.</p>\r\n<p>&nbsp;</p>\r\n<h1>Авторські права</h1>\r\n<p class=\"content_simple_text\">Будь-які найменування, логотипи та торгові знаки, що зустрічаються на даному сайті, за виключенням окремо вказаних випадків, є торговими знаками котрі належать та використовуються ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; або афільованими компаніями або особами у тих місцях, де ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; реалізує продукти, що мають ці торгові знаки. Категорично забороняється використання або неналежне застосування цих торгових знаків або будь-якої іншої інформації, що міститься на даному сайті, крім випадків, передбачених даними умовами або вмістом веб-сайту ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;.<br />\r\nБудь-яке відтворення матеріалів даного веб-сайту можливе тільки з письмового дозволу ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;. При публікації будь-якої інформації з сайту ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; у ЗМІ обов&rsquo;язково потрібно робити посилання на джерело даних.<br />\r\nПри публікації даних в Інтернет посилання на джерело повинне бути активним гіперпосиланням на відповідну сторінку веб-сайту www.tns-ua.com. або opros.tns-ua.com</p>','internal_page_content','','UA','2011-06-14 09:22:26','<h1>Використання інформації на веб-сайті</h1>\r\n<p class=\"content_simple_text\">Будь-яка особа може отримати доступ до даного веб-сайту та використовувати його виключно при виконанні умов, викладених нижче, а також чинного законодавства України. <br />\r\nКористувач має право переглядати інформацію на даному веб-сайті виключно в цілях отримання інформації для особистих потреб. Категорично забороняється розповсюдження інформації, отриманої на даному веб-сайті, зміна та виправлення її будь-яким чином або передача третім особам у комерційних цілях без письмового дозволу ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;.<br />\r\nТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; не несе відповідальності за прямі або опосередковані збитки, що можуть виникнути у Користувача в результаті отримання доступу або використання будь-якої інформації, що міститься на даному веб-сайті або на будь-якому з веб-сайтів, що мають інтерактивний зв&rsquo;язок з ним.</p>\r\n<p>&nbsp;</p>\r\n<h1>Авторські права</h1>\r\n<p class=\"content_simple_text\">Будь-які найменування, логотипи та торгові знаки, що зустрічаються на даному сайті, за виключенням окремо вказаних випадків, є торговими знаками котрі належать та використовуються ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; або афільованими компаніями або особами у тих місцях, де ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; реалізує продукти, що мають ці торгові знаки. Категорично забороняється використання або неналежне застосування цих торгових знаків або будь-якої іншої інформації, що міститься на даному сайті, крім випадків, передбачених даними умовами або вмістом веб-сайту ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;.<br />\r\nБудь-яке відтворення матеріалів даного веб-сайту можливе тільки з письмового дозволу ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;. При публікації будь-якої інформації з сайту ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; у ЗМІ обов&rsquo;язково потрібно робити посилання на джерело даних.<br />\r\nПри публікації даних в Інтернет посилання на джерело повинне бути активним гіперпосиланням на відповідну сторінку веб-сайту www.tns-ua.com. або opros.tns-ua.com</p>','2011-06-14 09:22:26'),(29,'page_comment',0,NULL,'page_comment','','RU','2011-06-14 09:21:42',NULL,'2011-06-14 09:21:42'),(29,'page_comment',0,NULL,'page_comment',NULL,'UA','2011-06-14 09:21:42',NULL,'2011-06-14 09:21:42'),(29,'page_header',0,'Ответственность','page_header','','RU','2010-04-13 13:25:24','Ответственность','2010-04-13 13:25:24'),(29,'page_header',0,NULL,'page_header',NULL,'UA','2010-02-25 13:59:57',NULL,'2010-02-25 13:59:57'),(30,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-04 11:36:57'),(30,'int_b_class',0,NULL,'int_b_class','','RU','2010-06-24 11:17:03',NULL,'2010-06-24 11:17:03'),(30,'int_b_class',0,'D4EEED','int_b_class','','UA','2010-01-22 16:42:57','D4EEED','2010-01-22 16:42:57'),(30,'int_h_class',0,NULL,'int_h_class','','RU','2010-06-24 11:16:32',NULL,'2010-06-24 11:16:32'),(30,'int_h_class',0,'47B3B8','int_h_class','','UA','2010-01-22 16:42:34','47B3B8','2010-01-22 16:42:34'),(30,'page_comment',0,'Собирайте баллы принимая участие в опросах. Каждый опрос принесет Вам баллы.','page_comment','','RU','2010-04-15 11:57:18','Собирайте баллы принимая участие в опросах. Каждый опрос принесет Вам баллы.','2010-04-15 11:57:18'),(30,'page_comment',0,'Накопичуйте бали, беручи участь в опитуваннях. Кожне \r\nопитування принесе Вам бали.','page_comment','','UA','2010-01-04 11:37:15','Накопичуйте бали, беручи участь в опитуваннях. Кожне \r\nопитування принесе Вам бали.','2010-01-04 11:37:15'),(30,'page_error',0,'Нажаль в системі поки що немає даних про вашу участь у дослідженнях.','page_error','','UA','2010-01-22 18:42:07','Нажаль в системі поки що немає даних про вашу участь у дослідженнях.','2010-01-22 18:42:07'),(30,'page_header',0,'История опросов','page_header','','RU','2010-04-15 11:56:25','История опросов','2010-04-15 11:56:25'),(31,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-02-22 11:19:16'),(31,'internal_page_content',0,'<p>Нажаль, ви ще не набрали достатню кількість балів для конвертації.</p>','internal_page_content','','UA','2010-02-22 11:20:18','<p>Нажаль, ви ще не набрали достатню кількість балів для конвертації.</p>','2010-02-22 11:20:18'),(31,'int_b_class',0,NULL,'int_b_class','','RU','2010-06-24 11:18:16',NULL,'2010-06-24 11:18:16'),(31,'int_b_class',0,'D4EEED','int_b_class','','UA','2010-06-24 11:17:36','D4EEED','2010-06-24 11:17:36'),(31,'int_h_class',0,NULL,'int_h_class','','RU','2010-06-24 11:17:55',NULL,'2010-06-24 11:17:55'),(31,'int_h_class',0,'47B3B8','int_h_class','','UA','2010-06-24 11:17:58','47B3B8','2010-06-24 11:17:58'),(31,'page_comment',0,NULL,'page_comment','','EN','2010-06-21 07:04:38',NULL,'2010-06-21 07:04:38'),(31,'page_comment',0,'Минимальная сумма для конвертации webmoney или на мобильный - 3000 баллов.\r\nМинимальная сумма для конвертации почтовым переводом - 10000 баллов.\r\nКурс: 100 баллов - 1 грн.','page_comment','','RU','2011-09-01 13:30:50','Минимальная сумма для конвертации webmoney или на мобильный - 3000 баллов.\r\nМинимальная сумма для конвертации почтовым переводом - 10000 баллов.\r\nКурс: 100 баллов - 1 грн.','2011-09-01 13:30:50'),(31,'page_comment',0,'Мінімальна сума для конвертації webmoney або на мобільний - 3000 балів.\r\nМінімальна сума для конвертації поштовим переказом - 10000 балів.\r\nКурс: 100 балів - 1 грн.','page_comment','','UA','2011-09-01 13:30:18','Мінімальна сума для конвертації webmoney або на мобільний - 3000 балів.\r\nМінімальна сума для конвертації поштовим переказом - 10000 балів.\r\nКурс: 100 балів - 1 грн.','2011-09-01 13:30:18'),(31,'page_error',0,'При заповненні форми виникли помилки. Будь ласка, перевірте, чи всі поля заповнені правильно.','page_error','','UA','2010-07-27 07:56:42','При заповненні форми виникли помилки. Будь ласка, перевірте, чи всі поля заповнені правильно.','2010-07-27 07:56:42'),(32,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00',NULL,'2011-03-18 10:00:31'),(32,'internal_page_content',0,'<p><img align=\"left\" width=\"45\" vspace=\"4\" height=\"44\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Служба поддержки</p>\r\n<p class=\"content_simple_text_lm\">accesspanel.helpdesk@tns-ua.com</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=Contacts\" class=\"system_button2\">Послать сообщение</a></p>','internal_page_content','','RU','2011-06-05 13:57:04','<p><img align=\"left\" width=\"45\" vspace=\"4\" height=\"44\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Служба поддержки</p>\r\n<p class=\"content_simple_text_lm\">accesspanel.helpdesk@tns-ua.com</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=Contacts\" class=\"system_button2\">Послать сообщение</a></p>','2011-06-05 13:57:04'),(32,'internal_page_content',0,'<p><img align=\"left\" width=\"45\" vspace=\"4\" height=\"44\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Служба підтримки</p>\r\n<p class=\"content_simple_text_lm\">accesspanel.helpdesk@tns-ua.com</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=Contacts\" class=\"system_button2\">Надіслати повідомлення</a></p>','internal_page_content','','UA','2011-06-05 13:56:58','<p><img align=\"left\" width=\"45\" vspace=\"4\" height=\"44\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Служба підтримки</p>\r\n<p class=\"content_simple_text_lm\">accesspanel.helpdesk@tns-ua.com</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=Contacts\" class=\"system_button2\">Надіслати повідомлення</a></p>','2011-06-05 13:56:58'),(32,'page_comment',0,NULL,'page_comment','','RU','2011-03-18 10:03:06',NULL,'2011-03-18 10:03:06'),(32,'page_comment',0,NULL,'page_comment',NULL,'UA','2011-03-18 10:03:06',NULL,'2011-03-18 10:03:06'),(32,'page_header',0,'Контакты','page_header','','RU','2011-03-18 10:07:24','Контакты','2011-03-18 10:07:24'),(32,'page_header',0,NULL,'page_header',NULL,'UA','2011-03-18 10:02:35',NULL,'2011-03-18 10:02:35'),(33,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-14 15:59:51'),(33,'internal_page_content',0,NULL,'internal_page_content','','RU','2011-08-08 08:11:35',NULL,'2011-08-08 08:11:35'),(33,'internal_page_content',0,'<h1>Про захист даних переданих в Інтернет</h1>\r\n<p class=\"content_simple_text\">ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; проводить дуже кропітку роботу щодо захисту будь-яких переданих в Інтернет даних. Ця політика конфіденційності розповсюджується на респондентів, що завершили або проходять опитування з будь-якої тематики вивчення ринку.</p>\r\n<p class=\"content_simple_text\">Дані, що ми отримуємо в процесі проведення досліджень, можуть бути використані лише&nbsp;в наукових або дослідницьких цілях.</p>\r\n<p>&nbsp;</p>\r\n<h1>Коли та яку саме інформацію ми збираємо?</h1>\r\n<p class=\"content_simple_text\">Ваша персональна інформація збирається коли Ви заповнюєте форми зворотного зв&rsquo;язку та відсилаєте ці дані до ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; або зв&rsquo;язуєтесь з нами по телефону. Зокрема, ми записуємо Ваше ім&rsquo;я, прізвище, адресу, адресу електронної пошти, номер телефону(включаючи номер мобільного телефону), будь-яку іншу інформацію, яку Ви передаєте нам про сфери Вашого інтересу, інформацію, що Ви передаєте беручи участь в опитуваннях, що проводить ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;. Ми впевнені, що збір усієї цієї інформації є дуже важливим та може допомогти нам при подальшій співпраці з Вами. Уся інформація, яку Ви передаєте нам, буде оброблятись та зберігатись з найвищою відповідальністю.</p>\r\n<p class=\"content_simple_text\">Під час проведення досліджень, ми збираємо Ваші відповіді у кодованому чисельному вигляді. Ми гарантуємо повну конфіденційність Ваших відповідей.</p>\r\n<p>&nbsp;</p>\r\n<h1>Що ми робимо з Вашими персональними даними?</h1>\r\n<p class=\"content_simple_text\">Ваші персональні дані потрібні лише для Вашого профайлу у співтоваристві, а також можуть бути використані працівниками&nbsp;ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; для зв&rsquo;язку з Вами. Прикладом такого зв&rsquo;язку можуть бути запрошення до участі у дослідженні, прес-релізи, запрошення на семінари та виставки, що проводить ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;, газети, електронні газети, звіти по дослідженню ринків, галузеві аналізи, корпоративні або фінансові оповіщення або будь-які інші загальні відгуки на Ваші можливі запити.</p>\r\n<p>&nbsp;</p>\r\n<h1>Кому доступна Ваша інформація?</h1>\r\n<p class=\"content_simple_text\">Інформація, яку Ви надаєте про себе під час реєстрації потрібна лише для Вашої авторизації на сайті.</p>\r\n<p class=\"content_simple_text\">Ми не передаємо реєстраційні дані третім особам.</p>\r\n<p>&nbsp;</p>\r\n<h1>Передача інформації</h1>\r\n<p class=\"content_simple_text\">Передача Вашої особистої інформації можлива лише у випадках, передбачених чинним законодавском України.</p>\r\n<p>&nbsp;</p>\r\n<h1>Додатково</h1>\r\n<p class=\"content_simple_text\">Будь-ласка, завершуйте сеанс роботи з сайтом натисканням кнопки &quot;Вихід&quot;. Це дасть можливість бути упевненим, що жодна третя особа не має доступу до Ваших особистих даних.</p>\r\n<p class=\"content_simple_text\">Ця політика конфіденційності розроблена у відповідності до чинного законодавства України. У випадку зміни будь-якого пункту цієї політики конфіденційності ми зобов&rsquo;язуємось у 30-денний строк розмістити їх на веб-сайті. Ми ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;, учасник Taylor Nelson Sofres group, учасник Kantar Group, зареєстровані за адресою м.Київ, вул. Ігорівська 1/8, літера &laquo;В&raquo;.</p>\r\n<p>&nbsp;</p>','internal_page_content','','UA','2011-08-15 12:55:52','<h1>Про захист даних переданих в Інтернет</h1>\r\n<p class=\"content_simple_text\">ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; проводить дуже кропітку роботу щодо захисту будь-яких переданих в Інтернет даних. Ця політика конфіденційності розповсюджується на респондентів, що завершили або проходять опитування з будь-якої тематики вивчення ринку.</p>\r\n<p class=\"content_simple_text\">Дані, що ми отримуємо в процесі проведення досліджень, можуть бути використані лише&nbsp;в наукових або дослідницьких цілях.</p>\r\n<p>&nbsp;</p>\r\n<h1>Коли та яку саме інформацію ми збираємо?</h1>\r\n<p class=\"content_simple_text\">Ваша персональна інформація збирається коли Ви заповнюєте форми зворотного зв&rsquo;язку та відсилаєте ці дані до ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; або зв&rsquo;язуєтесь з нами по телефону. Зокрема, ми записуємо Ваше ім&rsquo;я, прізвище, адресу, адресу електронної пошти, номер телефону(включаючи номер мобільного телефону), будь-яку іншу інформацію, яку Ви передаєте нам про сфери Вашого інтересу, інформацію, що Ви передаєте беручи участь в опитуваннях, що проводить ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;. Ми впевнені, що збір усієї цієї інформації є дуже важливим та може допомогти нам при подальшій співпраці з Вами. Уся інформація, яку Ви передаєте нам, буде оброблятись та зберігатись з найвищою відповідальністю.</p>\r\n<p class=\"content_simple_text\">Під час проведення досліджень, ми збираємо Ваші відповіді у кодованому чисельному вигляді. Ми гарантуємо повну конфіденційність Ваших відповідей.</p>\r\n<p>&nbsp;</p>\r\n<h1>Що ми робимо з Вашими персональними даними?</h1>\r\n<p class=\"content_simple_text\">Ваші персональні дані потрібні лише для Вашого профайлу у співтоваристві, а також можуть бути використані працівниками&nbsp;ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo; для зв&rsquo;язку з Вами. Прикладом такого зв&rsquo;язку можуть бути запрошення до участі у дослідженні, прес-релізи, запрошення на семінари та виставки, що проводить ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;, газети, електронні газети, звіти по дослідженню ринків, галузеві аналізи, корпоративні або фінансові оповіщення або будь-які інші загальні відгуки на Ваші можливі запити.</p>\r\n<p>&nbsp;</p>\r\n<h1>Кому доступна Ваша інформація?</h1>\r\n<p class=\"content_simple_text\">Інформація, яку Ви надаєте про себе під час реєстрації потрібна лише для Вашої авторизації на сайті.</p>\r\n<p class=\"content_simple_text\">Ми не передаємо реєстраційні дані третім особам.</p>\r\n<p>&nbsp;</p>\r\n<h1>Передача інформації</h1>\r\n<p class=\"content_simple_text\">Передача Вашої особистої інформації можлива лише у випадках, передбачених чинним законодавском України.</p>\r\n<p>&nbsp;</p>\r\n<h1>Додатково</h1>\r\n<p class=\"content_simple_text\">Будь-ласка, завершуйте сеанс роботи з сайтом натисканням кнопки &quot;Вихід&quot;. Це дасть можливість бути упевненим, що жодна третя особа не має доступу до Ваших особистих даних.</p>\r\n<p class=\"content_simple_text\">Ця політика конфіденційності розроблена у відповідності до чинного законодавства України. У випадку зміни будь-якого пункту цієї політики конфіденційності ми зобов&rsquo;язуємось у 30-денний строк розмістити їх на веб-сайті. Ми ТОВ &laquo;Тейлор Нельсон Софрез Україна&raquo;, учасник Taylor Nelson Sofres group, учасник Kantar Group, зареєстровані за адресою м.Київ, вул. Ігорівська 1/8, літера &laquo;В&raquo;.</p>\r\n<p>&nbsp;</p>','2011-08-15 12:55:52'),(33,'page_comment',0,NULL,'page_comment',NULL,'UA','2010-02-25 13:57:47',NULL,'2010-02-25 13:57:47'),(33,'page_header',0,'Конфиденциальность','page_header','','RU','2010-04-13 13:25:37','Конфиденциальность','2010-04-13 13:25:37'),(33,'page_header',0,'Конфіденційність','page_header','','UA','2010-02-25 13:59:27','Конфіденційність','2010-02-25 13:59:27'),(35,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-09 18:51:29'),(35,'faq_block_content',0,'<p>444444 4 4444444 444 444444444444 444444 4444444 444 4444 44444444 4444 4 444</p>','faq_block_content','','UA','2010-01-13 18:27:57','<p>444444 4 4444444 444 444444444444 444444 4444444 444 4444 44444444 4444 4 444</p>','2010-01-13 18:27:57'),(35,'faq_block_title',0,'44444444 44','faq_block_title','','UA','2010-01-13 18:27:21','44444444 44','2010-01-13 18:27:21'),(35,'internal_page_content',0,'<p>TNS Opros &ndash; это новая ступенька в Вашем разговоре с производителем.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; это новый проект TNS, который был разработан для того  чтобы объединить совсем разных людей с единой целью - сделать окружающий  мир более уютным и удобным для Вас.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; это новое сообщество людей, которые могут в реальной  жизни быть знакомыми или нет, жить в одном населенном пункте или нет,  любить что-то одно или нет - это парни и девушки, мужчины и женщины,  дедушки и бабушки, которые желают быть услышаными.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; это сообщество людей, которые дают согласие принимать  участие в опросах компании&nbsp; TNS за вознаграждение.</p>','internal_page_content','','RU','2011-08-08 08:10:32','<p>TNS Opros &ndash; это новая ступенька в Вашем разговоре с производителем.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; это новый проект TNS, который был разработан для того  чтобы объединить совсем разных людей с единой целью - сделать окружающий  мир более уютным и удобным для Вас.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; это новое сообщество людей, которые могут в реальной  жизни быть знакомыми или нет, жить в одном населенном пункте или нет,  любить что-то одно или нет - это парни и девушки, мужчины и женщины,  дедушки и бабушки, которые желают быть услышаными.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; это сообщество людей, которые дают согласие принимать  участие в опросах компании&nbsp; TNS за вознаграждение.</p>','2011-08-08 08:10:32'),(35,'internal_page_content',0,'<p>TNS Opros &ndash; це нова сходинка у Вашій розмові з виробником.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; це новий проект TNS, який має за мету об\'єднати зовсім різних <br />\r\nлюдей для однієї цілі &ndash; зробити навколишній світ більш затишним та <br />\r\nзручним саме для Вас.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; це нове співтовариство людей, які можуть у реальному житті <br />\r\nбути знайомими, або незнайомими, жити в одному місці або у різних, <br />\r\nлюбити морозиво або ні &ndash; це хлопчики та дівчата, чоловіки та жінки, <br />\r\nдідусі та бабусі, які бажають бути почутими.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; це співтовариство людей, що дають згоду на участь в <br />\r\nопитуваннях компанії TNS за винагороду.</p>','internal_page_content','','UA','2010-03-29 17:32:43','<p>TNS Opros &ndash; це нова сходинка у Вашій розмові з виробником.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; це новий проект TNS, який має за мету об\'єднати зовсім різних <br />\r\nлюдей для однієї цілі &ndash; зробити навколишній світ більш затишним та <br />\r\nзручним саме для Вас.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; це нове співтовариство людей, які можуть у реальному житті <br />\r\nбути знайомими, або незнайомими, жити в одному місці або у різних, <br />\r\nлюбити морозиво або ні &ndash; це хлопчики та дівчата, чоловіки та жінки, <br />\r\nдідусі та бабусі, які бажають бути почутими.</p>\r\n<p>&nbsp;</p>\r\n<p>TNS Opros &ndash; це співтовариство людей, що дають згоду на участь в <br />\r\nопитуваннях компанії TNS за винагороду.</p>','2010-03-29 17:32:43'),(35,'internal_page_header',0,'Коротко о главном','internal_page_header','','RU','2010-04-02 08:30:20','Коротко о главном','2010-04-02 08:30:20'),(35,'internal_page_header',0,'Коротко про головне','internal_page_header','','UA','2010-01-09 18:57:53','Коротко про головне','2010-01-09 18:57:53'),(35,'int_b_class',0,'CDE8F3','int_b_class','','UA','2010-01-09 18:56:58','CDE8F3','2010-01-09 18:56:58'),(35,'int_h_class',0,'0086D3','int_h_class','','UA','2010-01-09 18:51:44','0086D3','2010-01-09 18:51:44'),(35,'page_comment',0,'TNS в Украине вышла на рынок онлайн исследований. Быть с нами значит получать наилучшее. Проект TNS Opros качественно изменит вашу жизнь и отношение к продуктам и услугам.','page_comment','','RU','2010-04-12 08:50:23','TNS в Украине вышла на рынок онлайн исследований. Быть с нами значит получать наилучшее. Проект TNS Opros качественно изменит вашу жизнь и отношение к продуктам и услугам.','2010-04-12 08:50:23'),(35,'page_comment',0,'TNS в Україні вийшла на ринок онлайн досліджень. Бути з нами означає отримувати найкраще. Проект “Opros” якісно змінить ваше життя та ставлення до продуктів та послуг.','page_comment','','UA','2010-03-29 18:03:54','TNS в Україні вийшла на ринок онлайн досліджень. Бути з нами означає отримувати найкраще. Проект “Opros” якісно змінить ваше життя та ставлення до продуктів та послуг.','2010-03-29 18:03:54'),(35,'page_header',0,'Мы TNS Opros','page_header','','RU','2010-04-12 08:50:05','Мы TNS Opros','2010-04-12 08:50:05'),(35,'page_header',0,NULL,'page_header',NULL,'UA','2010-03-29 17:31:34',NULL,'2010-03-29 17:31:34'),(35,'page_script',0,NULL,'page_script','','RU','2010-04-09 14:06:30',NULL,'2010-04-09 14:06:30'),(35,'page_script',0,NULL,'page_script',NULL,'UA','2010-04-09 14:06:30',NULL,'2010-04-09 14:06:30'),(35,'usefull_contact_block_content',0,'<p>222222 2 2222 22222 222 22222</p>','usefull_contact_block_content','','UA','2010-01-13 18:23:35','<p>222222 2 2222 22222 222 22222</p>','2010-01-13 18:23:35'),(35,'usefull_contact_block_title',0,'2222222222','usefull_contact_block_title','','UA','2010-01-13 18:23:00','2222222222','2010-01-13 18:23:00'),(37,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Послать сообщение</a></p>','contact_block_content','','RU','2011-03-30 08:36:53','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Послать сообщение</a></p>','2011-03-30 08:36:53'),(37,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','contact_block_content','','UA','2011-03-30 08:36:42','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','2011-03-30 08:36:42'),(37,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-19 07:12:58'),(37,'int_b_class',0,NULL,'int_b_class','','RU','2010-06-24 11:17:16',NULL,'2010-06-24 11:17:16'),(37,'int_b_class',0,'D4EEED','int_b_class','','UA','2010-06-24 11:17:18','D4EEED','2010-06-24 11:17:18'),(37,'int_h_class',0,NULL,'int_h_class','','RU','2010-06-24 11:17:43',NULL,'2010-06-24 11:17:43'),(37,'int_h_class',0,'47B3B8','int_h_class','','UA','2010-06-24 11:16:50','47B3B8','2010-06-24 11:16:50'),(37,'page_comment',0,NULL,'page_comment',NULL,'UA','2010-07-14 06:56:31',NULL,'2010-07-14 06:56:31'),(37,'page_error',0,NULL,'page_error',NULL,'RU','2010-04-15 13:57:52',NULL,'2010-04-15 13:57:52'),(37,'page_error',0,'При заповненні форми були допущені помилки. \r\nБудь-ласка, перевірте введені дані ще раз.','page_error','','UA','2010-01-19 07:13:04','При заповненні форми були допущені помилки. \r\nБудь-ласка, перевірте введені дані ще раз.','2010-01-19 07:13:04'),(39,'block_0_description',0,NULL,'block_0_description','','EN','2010-04-20 14:39:58',NULL,'2010-04-20 14:39:58'),(39,'block_0_description',0,'<p>Признание &ndash; самая лучшая благодарность.</p>\r\n<p>&nbsp;</p>\r\n<p>Ваше мнение признано очень важным. Каждый участник проекта вносит свою коррективу в формирование финальных решений касательно выпуска партии товаров или услуг, указывает на стратегию производителю для удовлетворения собственных нужд.</p>','block_0_description','','RU','2011-02-18 14:58:46','<p>Признание &ndash; самая лучшая благодарность.</p>\r\n<p>&nbsp;</p>\r\n<p>Ваше мнение признано очень важным. Каждый участник проекта вносит свою коррективу в формирование финальных решений касательно выпуска партии товаров или услуг, указывает на стратегию производителю для удовлетворения собственных нужд.</p>','2011-02-18 14:58:46'),(39,'block_0_description',0,'<p>Визнання &ndash; найкраща подяка.</p>\r\n<p>&nbsp;</p>\r\n<p>Ваша думка визнана дуже важливою. Кожен учасник проекту вносить свою корективу у формування остаточних рішень щодо випуску товарів та послуг, вказує на стратегію виробника для задоволення власних потреб.</p>','block_0_description','','UA','2011-02-18 14:57:53','<p>Визнання &ndash; найкраща подяка.</p>\r\n<p>&nbsp;</p>\r\n<p>Ваша думка визнана дуже важливою. Кожен учасник проекту вносить свою корективу у формування остаточних рішень щодо випуску товарів та послуг, вказує на стратегію виробника для задоволення власних потреб.</p>','2011-02-18 14:57:53'),(39,'block_0_title',0,'Важность вашего мнения','block_0_title','','RU','2011-02-18 14:56:58','Важность вашего мнения','2011-02-18 14:56:58'),(39,'block_0_title',0,'Важливість вашої думки','block_0_title','','UA','2011-02-18 14:56:56','Важливість вашої думки','2011-02-18 14:56:56'),(39,'block_1_description',0,'<p class=\"content_simple_text\"><span class=\"arial12px\">Информация &ndash; самый ценный ресурс современного цивилизованного мира.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Вы всегда будете в курсе последних тенденций и разработок на потребительских рынках. Вы приймите участие в разработке новых товаров и услуг. Вам будет известно об изменениях в ассортименте, качестве и остальных потребительских характеристиках товаров заблаговременно. И более того </span><span class=\"arial12px\">&ndash; Вы примите непосредственное участие в этих изменениях. <br />\r\n</span></p>','block_1_description','','RU','2010-04-12 14:55:26','<p class=\"content_simple_text\"><span class=\"arial12px\">Информация &ndash; самый ценный ресурс современного цивилизованного мира.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Вы всегда будете в курсе последних тенденций и разработок на потребительских рынках. Вы приймите участие в разработке новых товаров и услуг. Вам будет известно об изменениях в ассортименте, качестве и остальных потребительских характеристиках товаров заблаговременно. И более того </span><span class=\"arial12px\">&ndash; Вы примите непосредственное участие в этих изменениях. <br />\r\n</span></p>','2010-04-12 14:55:26'),(39,'block_1_description',0,'<p class=\"content_simple_text\"><span class=\"arial12px\">Інформація &ndash; найцінніший ресурс сучасного цивілізованого світу.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Ви завжди будете в курсі останніх тенденцій і розробок на споживчих ринках. Ви приймете участь у розробці нових товарів та послуг. Вам буде відомо про зміни&nbsp;в асортименті, якості та складі товарів заздалегідь.</span></p>','block_1_description','','UA','2010-01-12 20:18:25','<p class=\"content_simple_text\"><span class=\"arial12px\">Інформація &ndash; найцінніший ресурс сучасного цивілізованого світу.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Ви завжди будете в курсі останніх тенденцій і розробок на споживчих ринках. Ви приймете участь у розробці нових товарів та послуг. Вам буде відомо про зміни&nbsp;в асортименті, якості та складі товарів заздалегідь.</span></p>','2010-01-12 20:18:25'),(39,'block_1_title',0,'Информированность','block_1_title','','RU','2010-04-12 15:05:38','Информированность','2010-04-12 15:05:38'),(39,'block_1_title',0,'Інформованість','block_1_title','','UA','2010-01-12 19:02:25','Інформованість','2010-01-12 19:02:25'),(39,'block_2_description',0,'<p class=\"content_simple_text\"><span class=\"arial12px\">Копейка рубль бережет. Эта пословица знакома нам с детства.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Каждый раз при участии в исследовании Вы будете получать накопительные баллы, которые можно конвертировать в деньги. Таким образом, это еще один способ подзаработать в сети Интернет, но, в отличие от остальных, совершенно прозрачный.</span></p>','block_2_description','','RU','2010-04-12 15:09:33','<p class=\"content_simple_text\"><span class=\"arial12px\">Копейка рубль бережет. Эта пословица знакома нам с детства.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">Каждый раз при участии в исследовании Вы будете получать накопительные баллы, которые можно конвертировать в деньги. Таким образом, это еще один способ подзаработать в сети Интернет, но, в отличие от остальных, совершенно прозрачный.</span></p>','2010-04-12 15:09:33'),(39,'block_2_description',0,'<p class=\"content_simple_text\"><span class=\"arial12px\">Вчасна копійка дорожча за буденну гривню.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">За кожне пройдене опитування ви будете отримувати накопичувальні бали, які можна конвертувати у реальні гроші. Таким чином це ще один спосіб підзаробити в Інтернет, але на відміну від інших багатьох &ndash; прозорий.</span></p>','block_2_description','','UA','2010-02-24 11:17:12','<p class=\"content_simple_text\"><span class=\"arial12px\">Вчасна копійка дорожча за буденну гривню.</span></p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\"><span class=\"arial12px\">За кожне пройдене опитування ви будете отримувати накопичувальні бали, які можна конвертувати у реальні гроші. Таким чином це ще один спосіб підзаробити в Інтернет, але на відміну від інших багатьох &ndash; прозорий.</span></p>','2010-02-24 11:17:12'),(39,'block_2_title',0,'Вознаграждение','block_2_title','','RU','2010-04-12 15:05:53','Вознаграждение','2010-04-12 15:05:53'),(39,'block_2_title',0,'Винагорода','block_2_title','','UA','2010-01-12 20:22:33','Винагорода','2010-01-12 20:22:33'),(39,'block_3_description',0,'<p>Покоряйте вершины!</p>','block_3_description','','RU','2011-02-18 15:06:56','<p>Покоряйте вершины!</p>','2011-02-18 15:06:56'),(39,'block_3_description',0,'<p>Підкорюйте вершини!</p>','block_3_description','','UA','2011-02-18 15:07:10','<p>Підкорюйте вершини!</p>','2011-02-18 15:07:10'),(39,'block_3_title',0,'На шаг впереди!','block_3_title','','RU','2011-02-18 14:59:10','На шаг впереди!','2011-02-18 14:59:10'),(39,'block_3_title',0,'На крок попереду!','block_3_title','','UA','2011-02-18 14:59:14','На крок попереду!','2011-02-18 14:59:14'),(39,'contact_block_content',0,NULL,'contact_block_content','','EN','2011-03-30 08:31:00',NULL,'2011-03-30 08:31:00'),(39,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" alt=\"\" src=\"/usersimage/Image/person.PNG\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a class=\"system_button2\" href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\">Послать сообщение</a></p>','contact_block_content','','RU','2011-03-30 08:31:30','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" alt=\"\" src=\"/usersimage/Image/person.PNG\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a class=\"system_button2\" href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\">Послать сообщение</a></p>','2011-03-30 08:31:30'),(39,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','contact_block_content','','UA','2011-03-30 08:31:42','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','2011-03-30 08:31:42'),(39,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-12 16:28:43'),(39,'int_b_0_class',0,NULL,'int_b_0_class',NULL,'UA','2011-02-18 14:32:20',NULL,'2011-02-18 14:32:20'),(39,'int_h_0_class',0,NULL,'int_h_0_class',NULL,'UA','2010-07-02 10:05:08',NULL,'2010-07-02 10:05:08'),(39,'int_h_1_class',0,'','int_h_1_class','','UA','2010-01-12 16:43:07','','2010-01-12 16:43:07'),(39,'media_inserted_why_register',0,'a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"47\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"85\";}','Media id for object why_register on page 39','','','2010-04-07 15:16:23','a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"47\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"85\";}','2010-04-07 15:16:23'),(39,'media_inserted_why_register_block_',0,'a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"47\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"81\";}','Media id for object why_register_block_0 on page 39','','','2011-02-18 14:57:16','a:2:{s:4:\"link\";a:3:{s:4:\"type\";s:13:\"open_sat_page\";s:3:\"sat\";s:2:\"47\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"81\";}','2011-02-18 14:57:16'),(39,'media_inserted_why_register_block_',1,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"79\";}','Media id for object why_register_block_1 on page 39',NULL,'','2010-01-12 16:28:43','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"79\";}','2010-01-12 16:28:43'),(39,'media_inserted_why_register_block_',2,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"80\";}','Media id for object why_register_block_2 on page 39',NULL,'','2010-01-12 18:22:36','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"80\";}','2010-01-12 18:22:36'),(39,'media_inserted_why_register_block_',3,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:3:\"103\";}','Media id for object why_register_block_3 on page 39','','','2011-02-18 14:59:44','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:3:\"103\";}','2011-02-18 14:59:44'),(39,'media_title_why_register',0,'','Media id for object why_register on page 39','','UA','2010-04-07 15:16:23','','2010-04-07 15:16:23'),(39,'media_title_why_register_block_',0,'','Media id for object why_register_block_0 on page 39','','UA','2011-02-18 14:57:16','','2011-02-18 14:57:16'),(39,'media_title_why_register_block_',1,'','Media id for object why_register_block_1 on page 39',NULL,'UA','2010-01-12 16:28:43','','2010-01-12 16:28:43'),(39,'media_title_why_register_block_',2,'','Media id for object why_register_block_2 on page 39',NULL,'UA','2010-01-12 18:22:36','','2010-01-12 18:22:36'),(39,'media_title_why_register_block_',3,'','Media id for object why_register_block_3 on page 39',NULL,'RU','2011-02-18 14:59:44','','2011-02-18 14:59:44'),(39,'media_title_why_register_block_',3,'','Media id for object why_register_block_3 on page 39',NULL,'UA','2010-01-12 18:27:48','','2010-01-12 18:27:48'),(39,'page_comment',0,NULL,'page_comment',NULL,'UA','2011-02-18 14:31:58',NULL,'2011-02-18 14:31:58'),(39,'right_block_h_class_contact',0,NULL,'right_block_h_class_contact',NULL,'UA','2010-01-27 12:40:21',NULL,'2010-01-27 12:40:21'),(40,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-21 16:12:04'),(40,'int_b_class',0,'E3E2EE','int_b_class','','UA','2010-01-21 16:15:21','E3E2EE','2010-01-21 16:15:21'),(40,'int_h_class',0,NULL,'int_h_class',NULL,'RU','2010-03-29 17:36:16',NULL,'2010-03-29 17:36:16'),(40,'int_h_class',0,'8A81BA','int_h_class','','UA','2010-01-21 16:12:37','8A81BA','2010-01-21 16:12:37'),(40,'page_comment',0,'Чтобы держать Вас в курсе, мы публикуем новости на сайте, а также распространяем их в СМИ.','page_comment','','RU','2011-08-11 14:36:12','Чтобы держать Вас в курсе, мы публикуем новости на сайте, а также распространяем их в СМИ.','2011-08-11 14:36:12'),(40,'page_comment',0,'Дбаючи про Вашу інформованість, ми публікуємо новини та прес-релізи на сайті, а також розповсюджуємо їх у ЗМІ.','page_comment','','UA','2011-08-11 14:36:05','Дбаючи про Вашу інформованість, ми публікуємо новини та прес-релізи на сайті, а також розповсюджуємо їх у ЗМІ.','2011-08-11 14:36:05'),(40,'page_header',0,'Новости','page_header','','RU','2010-04-12 15:24:43','Новости','2010-04-12 15:24:43'),(42,'block_1_description',0,'<p class=\"content_simple_text\">Вы могли себе представить, что производитель заинтересован в ваших ответах на свои вопросы: каким сделать новый продукт, как изменить старый, чтобы он Вам понравился?</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Участие в данном сообществе не требует от Вас каким-то образом изменять свою жизнь или совершать дополнительные ежедневные действия. Наоборот - Вы интересны нам именно такими, какими Вы есть в обычной своей жизни.</p>','block_1_description','','RU','2010-04-12 09:03:32','<p class=\"content_simple_text\">Вы могли себе представить, что производитель заинтересован в ваших ответах на свои вопросы: каким сделать новый продукт, как изменить старый, чтобы он Вам понравился?</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Участие в данном сообществе не требует от Вас каким-то образом изменять свою жизнь или совершать дополнительные ежедневные действия. Наоборот - Вы интересны нам именно такими, какими Вы есть в обычной своей жизни.</p>','2010-04-12 09:03:32'),(42,'block_1_description',0,'<p class=\"content_simple_text\">Ви могли собі уявити, що виробник бажає отримати саме ваші <br />\r\nвідповіді на питання яким зробити новий продукт, або як змінити <br />\r\nстарий так, щоб він Вам сподобався?</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Участь у даному співтоваристві не вимагає від вас якимось чином <br />\r\nзмінювати свій спосіб життя. Навпаки &ndash; нам ви цікаві саме такими, як <br />\r\nви звикли.</p>','block_1_description','','UA','2010-01-12 21:50:12','<p class=\"content_simple_text\">Ви могли собі уявити, що виробник бажає отримати саме ваші <br />\r\nвідповіді на питання яким зробити новий продукт, або як змінити <br />\r\nстарий так, щоб він Вам сподобався?</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Участь у даному співтоваристві не вимагає від вас якимось чином <br />\r\nзмінювати свій спосіб життя. Навпаки &ndash; нам ви цікаві саме такими, як <br />\r\nви звикли.</p>','2010-01-12 21:50:12'),(42,'block_1_title',0,'Предпосылки создания TNS Opros','block_1_title','','RU','2010-04-12 08:56:49','Предпосылки создания TNS Opros','2010-04-12 08:56:49'),(42,'block_1_title',0,'Передумови створення TNS Opros','block_1_title','','UA','2010-03-30 11:26:21','Передумови створення TNS Opros','2010-03-30 11:26:21'),(42,'block_2_description_',1,'<p>Первым и наиболее важным преимуществом TNS&nbsp;Opros является то, что все ваши ответы, которые Вы сделаете в рамках проекта будут учтены производителями в своих будущих товарных стратегиях. Таким образом, через некоторое время после исследования, Вы увидите на полке новый или обновленный продукт и главное, что он будет именно таким каким Вы хотели его видеть!</p>','block_2_description_1','','RU','2010-04-12 09:13:33','<p>Первым и наиболее важным преимуществом TNS&nbsp;Opros является то, что все ваши ответы, которые Вы сделаете в рамках проекта будут учтены производителями в своих будущих товарных стратегиях. Таким образом, через некоторое время после исследования, Вы увидите на полке новый или обновленный продукт и главное, что он будет именно таким каким Вы хотели его видеть!</p>','2010-04-12 09:13:33'),(42,'block_2_description_',1,'<p>Першою, і найбільш важливою перевагою 36.6 є те, що усі ваші відповіді, які ви зробите у рамках проекту будуть враховані виробниками у своїх стратегіях щодо випуску товарів та послуг у майбутньому. Таким чином, через деякий час після дослідження, ви можете побачити на полиці новий <br />\r\nпродукт, який допомогли створити виробнику.</p>','block_2_description_1','','UA','2010-01-12 21:35:35','<p>Першою, і найбільш важливою перевагою 36.6 є те, що усі ваші відповіді, які ви зробите у рамках проекту будуть враховані виробниками у своїх стратегіях щодо випуску товарів та послуг у майбутньому. Таким чином, через деякий час після дослідження, ви можете побачити на полиці новий <br />\r\nпродукт, який допомогли створити виробнику.</p>','2010-01-12 21:35:35'),(42,'block_2_description_',2,'<p>Вторым преимуществом является то, что мы готовы выплачивать Вам материальные поощрения за Ваши ответы. Пожалуйста, ознакомьтесь с нашей <a href=\"/index.php?t=52&amp;language=RU\">Системой поощрений</a>.<br />\r\nИтак, легко заметить, что высказывание своего мнения приносит пользу не только впрок, но и на сегодняшний день.</p>','block_2_description_2','','RU','2010-04-12 14:35:54','<p>Вторым преимуществом является то, что мы готовы выплачивать Вам материальные поощрения за Ваши ответы. Пожалуйста, ознакомьтесь с нашей <a href=\"/index.php?t=52&amp;language=RU\">Системой поощрений</a>.<br />\r\nИтак, легко заметить, что высказывание своего мнения приносит пользу не только впрок, но и на сегодняшний день.</p>','2010-04-12 14:35:54'),(42,'block_2_description_',2,'<p>Другою перевагою є те, що ми готові виплачувати Вам винагороду за ваші відповіді. <br />\r\nОтже, ви відчуєте, що висловлення своєї думки корисне не тільки &laquo;впрок&raquo;, але і на сьогоднішній день.</p>','block_2_description_2','','UA','2010-01-12 21:36:54','<p>Другою перевагою є те, що ми готові виплачувати Вам винагороду за ваші відповіді. <br />\r\nОтже, ви відчуєте, що висловлення своєї думки корисне не тільки &laquo;впрок&raquo;, але і на сьогоднішній день.</p>','2010-01-12 21:36:54'),(42,'block_2_title',0,'Почему именно TNS Opros','block_2_title','','RU','2010-04-12 09:03:57','Почему именно TNS Opros','2010-04-12 09:03:57'),(42,'block_2_title',0,'Чому саме TNS Opros','block_2_title','','UA','2010-03-30 11:26:31','Чому саме TNS Opros','2010-03-30 11:26:31'),(42,'block_3_description',0,'<p class=\"content_simple_text\">Вам понадобиться минимум времени для ответов на вопросы. Нужно только прочитать формулировку вопроса и выбрать соответствующий вариант ответа.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Мы уважаем ваши интересы, потому Вам не понадобиться участвовать в исследованиях, тематика которых Вам неприятна. Вы сами выбираете в каких исследованиях Вам брать участие.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">И, наконец, последнее: отсутствие какой-либо рекламы. Мы не проводим рекламных кампаний на нашем сайте, и потому Вам никаким образом не будут навязывать какие-либо продукты и/или услуги. Наоборот, нам интересно какие именно продукты и/или услуги Вы выбираете по своему желанию и почему.</p>','block_3_description','','RU','2011-08-08 08:13:29','<p class=\"content_simple_text\">Вам понадобиться минимум времени для ответов на вопросы. Нужно только прочитать формулировку вопроса и выбрать соответствующий вариант ответа.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Мы уважаем ваши интересы, потому Вам не понадобиться участвовать в исследованиях, тематика которых Вам неприятна. Вы сами выбираете в каких исследованиях Вам брать участие.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">И, наконец, последнее: отсутствие какой-либо рекламы. Мы не проводим рекламных кампаний на нашем сайте, и потому Вам никаким образом не будут навязывать какие-либо продукты и/или услуги. Наоборот, нам интересно какие именно продукты и/или услуги Вы выбираете по своему желанию и почему.</p>','2011-08-08 08:13:29'),(42,'block_3_description',0,'<p class=\"content_simple_text\">Участь потребує мінімум часу, для відповіді на запитання. Потрібно <br />\r\nлише прочитати формулювання питання та вибрати відповідний <br />\r\nваріант відповіді.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Ми поважаємо Ваші інтереси, тому вам не знадобиться давати <br />\r\nвідповіді на тематику, що вас не цікавить. Ви самі вибираєте у яких <br />\r\nдослідженнях брати участь.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">І нарешті останнє: відсутність будь-якої реклами. Ми не проводимо <br />\r\nрекламних кампаній на нашому сайті, а отже, Вам ніяким чином не <br />\r\nбудуть нав&rsquo;язувати ніякі продукти. Навпаки &ndash; нам цікаво які продукти ви обираєте за своїм бажанням і чому.</p>','block_3_description','','UA','2010-04-23 08:16:12','<p class=\"content_simple_text\">Участь потребує мінімум часу, для відповіді на запитання. Потрібно <br />\r\nлише прочитати формулювання питання та вибрати відповідний <br />\r\nваріант відповіді.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Ми поважаємо Ваші інтереси, тому вам не знадобиться давати <br />\r\nвідповіді на тематику, що вас не цікавить. Ви самі вибираєте у яких <br />\r\nдослідженнях брати участь.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">І нарешті останнє: відсутність будь-якої реклами. Ми не проводимо <br />\r\nрекламних кампаній на нашому сайті, а отже, Вам ніяким чином не <br />\r\nбудуть нав&rsquo;язувати ніякі продукти. Навпаки &ndash; нам цікаво які продукти ви обираєте за своїм бажанням і чому.</p>','2010-04-23 08:16:12'),(42,'block_3_title',0,'Еще несколько фактов о TNS Opros','block_3_title','','RU','2010-04-12 09:05:23','Еще несколько фактов о TNS Opros','2010-04-12 09:05:23'),(42,'block_3_title',0,'Ще декілька цікавих фактів про TNS Opros','block_3_title','','UA','2010-03-30 11:27:22','Ще декілька цікавих фактів про TNS Opros','2010-03-30 11:27:22'),(42,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-12 21:26:08'),(42,'int_b_1_class',0,'CDE8F3','int_b_1_class','','UA','2010-01-12 21:27:40','CDE8F3','2010-01-12 21:27:40'),(42,'int_b_2_class',0,'CDE8F3_2','int_b_2_class','','UA','2010-01-12 21:31:24','CDE8F3_2','2010-01-12 21:31:24'),(42,'int_b_3_class',0,'CDE8F3','int_b_3_class','','UA','2010-01-12 21:55:28','CDE8F3','2010-01-12 21:55:28'),(42,'int_h_1_class',0,'0086D3','int_h_1_class','','UA','2010-01-12 21:26:47','0086D3','2010-01-12 21:26:47'),(42,'int_h_2_class',0,'0086D3','int_h_2_class','','UA','2010-01-12 21:30:05','0086D3','2010-01-12 21:30:05'),(42,'int_h_3_class',0,'0086D3','int_h_3_class','','UA','2010-01-12 21:30:38','0086D3','2010-01-12 21:30:38'),(42,'media_inserted_advantages',0,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"84\";}','Media id for object advantages on page 42','','','2010-04-21 09:17:55','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"84\";}','2010-04-21 09:17:55'),(42,'media_title_advantages',0,'','Media id for object advantages on page 42','','RU','2010-04-21 09:17:55','','2010-04-21 09:17:55'),(42,'media_title_advantages',0,'','Media id for object advantages on page 42',NULL,'UA','2010-01-12 21:29:15','','2010-01-12 21:29:15'),(42,'page_comment',0,'TNS в Украине вышла на рынок онлайн-исследований. Быть с нами означает получать самое лучшее. Проект TNS Opros качественно изменит вашу жизнь и отношение к продуктам и услугам.','page_comment','','RU','2010-04-12 14:28:49','TNS в Украине вышла на рынок онлайн-исследований. Быть с нами означает получать самое лучшее. Проект TNS Opros качественно изменит вашу жизнь и отношение к продуктам и услугам.','2010-04-12 14:28:49'),(42,'page_comment',0,'TNS в Україні вийшла на ринок онлайн досліджень. Бути з нами означає отримувати найкраще. Проект “36.6” якісно змінить ваше життя та ставлення до продуктів та послуг.','page_comment','','UA','2010-04-09 14:15:25','TNS в Україні вийшла на ринок онлайн досліджень. Бути з нами означає отримувати найкраще. Проект “36.6” якісно змінить ваше життя та ставлення до продуктів та послуг.','2010-04-09 14:15:25'),(42,'page_header',0,'Преимущества TNS Opros','page_header','','RU','2010-04-09 14:14:41','Преимущества TNS Opros','2010-04-09 14:14:41'),(42,'page_header',0,NULL,'page_header',NULL,'UA','2010-04-09 14:06:55',NULL,'2010-04-09 14:06:55'),(45,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-19 06:41:02'),(45,'empty_row',0,'<p>На данный момент нет текущих исследований.</p>','empty_row','','RU','2010-04-22 07:49:29','<p>На данный момент нет текущих исследований.</p>','2010-04-22 07:49:29'),(45,'empty_row',0,'<p>Наразі немає доступних досліджень.</p>','empty_row','','UA','2010-03-29 18:00:52','<p>Наразі немає доступних досліджень.</p>','2010-03-29 18:00:52'),(45,'int_b_class',0,NULL,'int_b_class',NULL,'EN','2010-01-19 11:33:47',NULL,'2010-01-19 11:33:47'),(45,'int_b_class',0,'','int_b_class','','UA','2010-01-19 11:34:39','','2010-01-19 11:34:39'),(45,'page_comment',0,'Ниже приведен список исследований, в которых Вы можете принять участие.','page_comment','','RU','2010-04-15 12:12:29','Ниже приведен список исследований, в которых Вы можете принять участие.','2010-04-15 12:12:29'),(45,'page_comment',0,'Нижче наведено перелік досліджень, у яких ви можете взяти \r\nучасть.','page_comment','','UA','2010-03-29 18:00:41','Нижче наведено перелік досліджень, у яких ви можете взяти \r\nучасть.','2010-03-29 18:00:41'),(45,'page_header',0,'Текущие исследования','page_header','','RU','2010-04-13 11:09:32','Текущие исследования','2010-04-13 11:09:32'),(45,'page_header',0,NULL,'page_header',NULL,'UA','2010-04-13 11:09:45',NULL,'2010-04-13 11:09:45'),(46,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-14 16:02:00'),(46,'internal_page_content',0,'<h1>Загальні положення</h1>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Ці правила є обов&rsquo;язковими для усіх учасників співтовариства &laquo;36.6&raquo;. До порушників будуть застосовуватись адекватні заходи покарань, включаючи припинення участі у співтоваристві.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Адміністрація залишає за собою право заблокувати Вам доступ до ресурсу без попереднього пояснення причин. Якщо Ви будете вважати ці дії неправомірними стосовно себе, то Ви маєте право вимагати пояснення цих причин. <br />\r\nНезнання правил не звільняє від відповідальності за їх порушення. Незрозумілі моменти Ви завжди можете уточнити у адміністрації.</p>\r\n<p class=\"content_simple_text\"><br />\r\nЗареєструвавшись, Ви підтверджуєте, що згодні з цими Правилами, берете на себе обов&rsquo;язки їх виконувати та несете повну персональну відповідальність за їх порушення.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h1>Правила</h1>\r\n<ol class=\"content_simple_text\">\r\n    <li>Кожен громадянин або особа, що постійно мешкає на території України має право участі у даному співтоваристві. Особи, що проживають на треиторії України непостійно, включаючи міжнародну трудову міграцію, не мають права брати участь у співтоваристві.</li>\r\n    <li>Особа, що реєструється, зобов&rsquo;язується вказувати про себе лише правдиві дані, а також у подальшому сповіщати адміністрацію товариства при зміні будь-яких особистих даних, що були вказані при реєстрації.</li>\r\n    <li>Учасник співтовариства зобов&rsquo;язується не передавати свої логін та пароль іншим особам.</li>\r\n    <li>Учасник співтовариства зобов&rsquo;язується дотримуватись інструкцій до питань та чесно відповідати на питання у дослідженнях.</li>\r\n    <li>Учасник співтовариства має право накопичувати та використовувати бали відповідно до системи заохочення співтовариства.</li>\r\n    <li>У разі виявлення фальсифікації дослідження або будь-яких інших неправомірних дій, адміністрація має право заблокувати доступ учасника до ресурсу, а також повністю або частково анулювати накопичені учасником бали.</li>\r\n</ol>','internal_page_content','','UA','2011-08-15 13:06:13','<h1>Загальні положення</h1>\r\n<p>&nbsp;</p>\r\n<p class=\"content_simple_text\">Ці правила є обов&rsquo;язковими для усіх учасників співтовариства &laquo;36.6&raquo;. До порушників будуть застосовуватись адекватні заходи покарань, включаючи припинення участі у співтоваристві.</p>\r\n<p class=\"content_simple_text\">&nbsp;</p>\r\n<p class=\"content_simple_text\">Адміністрація залишає за собою право заблокувати Вам доступ до ресурсу без попереднього пояснення причин. Якщо Ви будете вважати ці дії неправомірними стосовно себе, то Ви маєте право вимагати пояснення цих причин. <br />\r\nНезнання правил не звільняє від відповідальності за їх порушення. Незрозумілі моменти Ви завжди можете уточнити у адміністрації.</p>\r\n<p class=\"content_simple_text\"><br />\r\nЗареєструвавшись, Ви підтверджуєте, що згодні з цими Правилами, берете на себе обов&rsquo;язки їх виконувати та несете повну персональну відповідальність за їх порушення.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h1>Правила</h1>\r\n<ol class=\"content_simple_text\">\r\n    <li>Кожен громадянин або особа, що постійно мешкає на території України має право участі у даному співтоваристві. Особи, що проживають на треиторії України непостійно, включаючи міжнародну трудову міграцію, не мають права брати участь у співтоваристві.</li>\r\n    <li>Особа, що реєструється, зобов&rsquo;язується вказувати про себе лише правдиві дані, а також у подальшому сповіщати адміністрацію товариства при зміні будь-яких особистих даних, що були вказані при реєстрації.</li>\r\n    <li>Учасник співтовариства зобов&rsquo;язується не передавати свої логін та пароль іншим особам.</li>\r\n    <li>Учасник співтовариства зобов&rsquo;язується дотримуватись інструкцій до питань та чесно відповідати на питання у дослідженнях.</li>\r\n    <li>Учасник співтовариства має право накопичувати та використовувати бали відповідно до системи заохочення співтовариства.</li>\r\n    <li>У разі виявлення фальсифікації дослідження або будь-яких інших неправомірних дій, адміністрація має право заблокувати доступ учасника до ресурсу, а також повністю або частково анулювати накопичені учасником бали.</li>\r\n</ol>','2011-08-15 13:06:13'),(46,'page_header',0,'Правила участия','page_header','','RU','2010-04-13 13:25:08','Правила участия','2010-04-13 13:25:08'),(47,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" alt=\"\" src=\"/usersimage/Image/person.PNG\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a class=\"system_button2\" href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\">Послать сообщение</a></p>','contact_block_content','','RU','2011-03-22 09:49:19','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" alt=\"\" src=\"/usersimage/Image/person.PNG\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a class=\"system_button2\" href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\">Послать сообщение</a></p>','2011-03-22 09:49:19'),(47,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','contact_block_content','','UA','2011-03-30 08:30:50','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','2011-03-30 08:30:50'),(47,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-04 16:40:13'),(47,'email_body',0,'Уважаемый {first_name} {last_name}!\r\n\r\nДля завершения регистрации откройте страницу {link}\r\nПосле этого Вы получите следующее письмо с напоминанием ваших регистрационных данных и сразу же сможете участвовать в опросах.\r\n\r\nС наилучшими пожеланиями,\r\nКоманда TNS Opros.','email_body','','RU','2010-04-12 14:48:20','Уважаемый {first_name} {last_name}!\r\n\r\nДля завершения регистрации откройте страницу {link}\r\nПосле этого Вы получите следующее письмо с напоминанием ваших регистрационных данных и сразу же сможете участвовать в опросах.\r\n\r\nС наилучшими пожеланиями,\r\nКоманда TNS Opros.','2010-04-12 14:48:20'),(47,'email_body',0,'Шановний {first_name} {last_name}!\r\n\r\nДля завершення реєстрації відкрийте сторінку {link}\r\nПісля цього Ви отримаєте наступний лист із нагадуванням даних для авторизцаії та відразу ж зможете взяти участь в опитуванні.\r\n\r\nЗ найкращими побажаннями,\r\nКоманда TNS Opros.','email_body','','UA','2010-07-08 14:17:13','Шановний {first_name} {last_name}!\r\n\r\nДля завершення реєстрації відкрийте сторінку {link}\r\nПісля цього Ви отримаєте наступний лист із нагадуванням даних для авторизцаії та відразу ж зможете взяти участь в опитуванні.\r\n\r\nЗ найкращими побажаннями,\r\nКоманда TNS Opros.','2010-07-08 14:17:13'),(47,'email_subject',0,NULL,'email_subject',NULL,'RU','2010-04-12 14:45:16',NULL,'2010-04-12 14:45:16'),(47,'email_subject',0,'Registration on TNS Opros','email_subject','','UA','2010-02-19 19:25:30','Registration on TNS Opros','2010-02-19 19:25:30'),(47,'int_b_class',0,NULL,'int_b_class',NULL,'UA','2010-02-24 12:00:50',NULL,'2010-02-24 12:00:50'),(47,'int_h_class',0,NULL,'int_h_class',NULL,'RU','2010-04-12 14:38:41',NULL,'2010-04-12 14:38:41'),(47,'int_h_class',0,'','int_h_class','','UA','2010-03-30 11:22:23','','2010-03-30 11:22:23'),(47,'media_inserted_registration_form',0,'a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"84\";}','Media id for object registration_form on page 47','','','2010-04-21 09:16:43','a:2:{s:4:\"link\";a:2:{s:4:\"type\";s:9:\"open_none\";s:8:\"opentype\";s:4:\"self\";}s:8:\"media_id\";s:2:\"84\";}','2010-04-21 09:16:43'),(47,'media_title_registration_form',0,'','Media id for object registration_form on page 47','','UA','2010-04-21 09:16:43','','2010-04-21 09:16:43'),(47,'page_comment',0,'* - обязательное поле\r\n** - можно заполнить одно из полей\r\nВаш <b>e-mail</b> будет использован как логин для авторизации.\r\n\r\nПожалуйста, указывайте свои реальные данные. Иначе Вы не сможете получить вознаграждение.\r\n\r\nЕсли Вы проживаете в частном доме, в поле \"Квартира\" поставьте, пожалуйста, код \"1\".\r\n\r\nФормат номера мобильного телефона: ХХХххххххх (где ХХХ – код оператора, ххххххх – номер мобильного)\r\n\r\nПожалуйста, внесите адреса <i>noreply@tns-ua.com</i> и <i>opros@tns-ua.com</i> в свою адресную книгу. Это обеспечит бесперебойное получение сообщений от TNS Opros. Иначе сообщения могут быть помещены в СПАМ.','page_comment','','RU','2011-09-19 10:48:46','* - обязательное поле\r\n** - можно заполнить одно из полей\r\nВаш <b>e-mail</b> будет использован как логин для авторизации.\r\n\r\nПожалуйста, указывайте свои реальные данные. Иначе Вы не сможете получить вознаграждение.\r\n\r\nЕсли Вы проживаете в частном доме, в поле \"Квартира\" поставьте, пожалуйста, код \"1\".\r\n\r\nФормат номера мобильного телефона: ХХХххххххх (где ХХХ – код оператора, ххххххх – номер мобильного)\r\n\r\nПожалуйста, внесите адреса <i>noreply@tns-ua.com</i> и <i>opros@tns-ua.com</i> в свою адресную книгу. Это обеспечит бесперебойное получение сообщений от TNS Opros. Иначе сообщения могут быть помещены в СПАМ.','2011-09-19 10:48:46'),(47,'page_comment',0,'* - обов’язкове поле.\r\n** - можливе заповнення лише одного з полів \r\nВаш <b>e-mail</b> буде використано як логін для авторизації.\r\n\r\nБудь-ласка, вказуйте ваші реальні дані. Інакше Ви не зможете отримати винагороду.\r\n\r\nЯкщо Ви проживаєте в приватному будинку, в рядку \"Квартира\" поставте, будь ласка, код \"1\".\r\n\r\nФормат номеру мобільного телефону: ХХХххххххх (де ХХХ – код оператора, ххххххх – номер мобільного)\r\n\r\nБудь-ласка, внесіть адреси <i>noreply@tns-ua.com</i> та <i>opros@tns-ua.com</i> до своєї адресної книжки. Це забезпечить Вам безперебійне отримання повідомлень від TNS Opros. Інакше повідомлення можуть бути переміщені в СПАМ.','page_comment','','UA','2011-09-19 10:46:51','* - обов’язкове поле.\r\n** - можливе заповнення лише одного з полів \r\nВаш <b>e-mail</b> буде використано як логін для авторизації.\r\n\r\nБудь-ласка, вказуйте ваші реальні дані. Інакше Ви не зможете отримати винагороду.\r\n\r\nЯкщо Ви проживаєте в приватному будинку, в рядку \"Квартира\" поставте, будь ласка, код \"1\".\r\n\r\nФормат номеру мобільного телефону: ХХХххххххх (де ХХХ – код оператора, ххххххх – номер мобільного)\r\n\r\nБудь-ласка, внесіть адреси <i>noreply@tns-ua.com</i> та <i>opros@tns-ua.com</i> до своєї адресної книжки. Це забезпечить Вам безперебійне отримання повідомлень від TNS Opros. Інакше повідомлення можуть бути переміщені в СПАМ.','2011-09-19 10:46:51'),(47,'page_error',0,'При заполнении формы были допущены ошибки. Пожалуйста, проверьте введенные данные.','page_error','','RU','2011-07-01 13:22:05','При заполнении формы были допущены ошибки. Пожалуйста, проверьте введенные данные.','2011-07-01 13:22:05'),(47,'page_error',0,'При заповненні форми були допущені помилки. Будь-ласка, перевірте введені дані.','page_error','','UA','2011-07-01 13:22:22','При заповненні форми були допущені помилки. Будь-ласка, перевірте введені дані.','2011-07-01 13:22:22'),(47,'page_header',0,'Форма регистрации','page_header','','RU','2010-04-12 14:38:36','Форма регистрации','2010-04-12 14:38:36'),(47,'page_header',0,'Форма реєстрації','page_header','','UA','2009-12-08 08:29:35','Форма реєстрації','2009-12-08 08:29:35'),(47,'right_block_b_class_contact',0,NULL,'right_block_b_class_contact',NULL,'UA','2010-01-18 17:05:57',NULL,'2010-01-18 17:05:57'),(47,'right_block_h_class_contact',0,'','right_block_h_class_contact','','UA','2010-01-19 08:26:32','','2010-01-19 08:26:32'),(48,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-09 18:45:43'),(48,'int_h_class',0,NULL,'int_h_class',NULL,'UA','2010-01-09 18:45:43',NULL,'2010-01-09 18:45:43'),(51,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-18 16:15:37'),(51,'internal_page_content',0,'<p>На питання</p>\r\n<strong><em>&laquo;Що Ви хочете отримати в подарунок до Нового року?&raquo;</em></strong>\r\n<p>українці відповіли таким чином:</p>\r\n<table>\r\n    \r\n        <tr>\r\n            <td>\r\n            <p>Щось корисне&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n            </td>\r\n            <td valign=\"bottom\">\r\n            <p align=\"center\">40%</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td>\r\n            <p>Щось корисне</p>\r\n            </td>\r\n            <td valign=\"bottom\">\r\n            <p align=\"center\">40%</p>\r\n            </td>\r\n        </tr>\r\n    \r\n</table>\r\n<p>При цьому трохи менше половини українців (47,6%</p>','internal_page_content','','UA','2010-01-26 17:09:25','<p>На питання</p>\r\n<strong><em>&laquo;Що Ви хочете отримати в подарунок до Нового року?&raquo;</em></strong>\r\n<p>українці відповіли таким чином:</p>\r\n<table>\r\n    \r\n        <tr>\r\n            <td>\r\n            <p>Щось корисне&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n            </td>\r\n            <td valign=\"bottom\">\r\n            <p align=\"center\">40%</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td>\r\n            <p>Щось корисне</p>\r\n            </td>\r\n            <td valign=\"bottom\">\r\n            <p align=\"center\">40%</p>\r\n            </td>\r\n        </tr>\r\n    \r\n</table>\r\n<p>При цьому трохи менше половини українців (47,6%</p>','2010-01-26 17:09:25'),(51,'internal_page_header',0,'Результати останніх досліджень','internal_page_header','','UA','2010-01-18 16:20:07','Результати останніх досліджень','2010-01-18 16:20:07'),(51,'int_b_class',0,'E3E2EE','int_b_class','','UA','2010-01-29 15:53:49','E3E2EE','2010-01-29 15:53:49'),(51,'int_h_class',0,'8A81BA','int_h_class','','UA','2010-01-29 15:53:01','8A81BA','2010-01-29 15:53:01'),(51,'page_comment',0,'Деякі найцікавіші результати наших досліджень ми для зручності користування розміщуємо прямо на сайті.','page_comment','','UA','2010-01-29 15:51:47','Деякі найцікавіші результати наших досліджень ми для зручності користування розміщуємо прямо на сайті.','2010-01-29 15:51:47'),(51,'page_header',0,NULL,'page_header',NULL,'EN','2010-01-18 16:16:08',NULL,'2010-01-18 16:16:08'),(51,'page_header',0,'Результати досліджень','page_header','','UA','2010-01-18 16:16:29','Результати досліджень','2010-01-18 16:16:29'),(52,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Послать сообщение</a></p>','contact_block_content','','RU','2011-03-30 08:31:59','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Администрация TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">г. Киев ул. Игоревская 1/8 буква &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Послать сообщение</a></p>','2011-03-30 08:31:59'),(52,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','contact_block_content','','UA','2011-03-30 08:32:07','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Адміністрація TNS Opros</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=RegistrationFormQuestion\" class=\"system_button2\">Надіслати повідомлення</a></p>','2011-03-30 08:32:07'),(52,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-25 15:13:48'),(52,'internal_page_content',0,'<p>Фундамент данной системы &ndash; курс: 100 баллов = 1грн.</p>\r\n<p>&nbsp;</p>\r\n<p>В среднем, если Вы подошли по критериям отбора исследования, мы  будем начислять Вам от 500 до 1500 баллов за каждый опрос. В случае же, если Вы не подошли по критериям отбора, Вам будет начислено 50 баллов.</p>\r\n<p>&nbsp;</p>\r\n<p>О начислении того или иного количества баллов Вам будет сообщено в  конце каждого опроса. Чтобы избежать недоразумений, пожалуйста,  ознакамливайтесь с информацией о причинах начисления Вам баллов сразу, не  &quot;проклацивайте&quot; информационную страницу.</p>','internal_page_content','','RU','2011-05-30 14:13:16','<p>Фундамент данной системы &ndash; курс: 100 баллов = 1грн.</p>\r\n<p>&nbsp;</p>\r\n<p>В среднем, если Вы подошли по критериям отбора исследования, мы  будем начислять Вам от 500 до 1500 баллов за каждый опрос. В случае же, если Вы не подошли по критериям отбора, Вам будет начислено 50 баллов.</p>\r\n<p>&nbsp;</p>\r\n<p>О начислении того или иного количества баллов Вам будет сообщено в  конце каждого опроса. Чтобы избежать недоразумений, пожалуйста,  ознакамливайтесь с информацией о причинах начисления Вам баллов сразу, не  &quot;проклацивайте&quot; информационную страницу.</p>','2011-05-30 14:13:16'),(52,'internal_page_content',0,'<p>Основа даної системи &ndash; курс: 100 балів = 1грн.</p>\r\n<p>&nbsp;</p>\r\n<p>В середньому, якщо Ви підійшли за критеріями відбору опитування, ми будемо нараховувати Вам від 500 до 1500 балів за кожне опитування. У випадку ж, якщо Ви не підійшли за критеріями відбору, Вам буде нараховано 50 балів.</p>\r\n<p>&nbsp;</p>\r\n<p>Про нарахування тої чи іншої кількості балів Вам буде наголошено в кінці кожного опитування. Щоб уникнути непорозумінь, будь-ласка, ознайомлюйтесь з інформацією про причини нарахування Вам балів зразу, не &quot;проклацуйте&quot; інформаційну сторінку.</p>','internal_page_content','','UA','2011-05-30 14:13:19','<p>Основа даної системи &ndash; курс: 100 балів = 1грн.</p>\r\n<p>&nbsp;</p>\r\n<p>В середньому, якщо Ви підійшли за критеріями відбору опитування, ми будемо нараховувати Вам від 500 до 1500 балів за кожне опитування. У випадку ж, якщо Ви не підійшли за критеріями відбору, Вам буде нараховано 50 балів.</p>\r\n<p>&nbsp;</p>\r\n<p>Про нарахування тої чи іншої кількості балів Вам буде наголошено в кінці кожного опитування. Щоб уникнути непорозумінь, будь-ласка, ознайомлюйтесь з інформацією про причини нарахування Вам балів зразу, не &quot;проклацуйте&quot; інформаційну сторінку.</p>','2011-05-30 14:13:19'),(52,'internal_page_header',0,'Система поощрений TNS Opros','internal_page_header','','RU','2011-05-30 08:34:11','Система поощрений TNS Opros','2011-05-30 08:34:11'),(52,'internal_page_header',0,'Система заохочення TNS Opros','internal_page_header','','UA','2011-05-30 08:33:30','Система заохочення TNS Opros','2011-05-30 08:33:30'),(52,'int_b_class',0,NULL,'int_b_class','','RU','2010-06-24 11:18:24',NULL,'2010-06-24 11:18:24'),(52,'int_b_class',0,'','int_b_class','','UA','2010-07-02 10:05:29','','2010-07-02 10:05:29'),(52,'int_h_class',0,NULL,'int_h_class','','RU','2010-07-02 10:05:21',NULL,'2010-07-02 10:05:21'),(52,'int_h_class',0,'','int_h_class','','UA','2010-07-02 10:05:19','','2010-07-02 10:05:19'),(52,'page_comment',0,'Принимая участие в исследованиях, Вы накапливаете баллы, которые позже сможете конвертировать в деньги.','page_comment','','RU','2010-10-14 08:44:19','Принимая участие в исследованиях, Вы накапливаете баллы, которые позже сможете конвертировать в деньги.','2010-10-14 08:44:19'),(52,'page_comment',0,'Беручи участь у наших дослідженнях, Ви накопичуєте бали, що пізніше зможете конвертувати у гроші.','page_comment','','UA','2010-04-12 15:16:27','Беручи участь у наших дослідженнях, Ви накопичуєте бали, що пізніше зможете конвертувати у гроші.','2010-04-12 15:16:27'),(52,'page_header',0,'Система поощрений','page_header','','RU','2010-04-12 15:17:41','Система поощрений','2010-04-12 15:17:41'),(52,'page_header',0,'','page_header','','UA','2009-12-25 15:14:05','','2009-12-25 15:14:05'),(52,'page_script',0,NULL,'page_script',NULL,'RU','2010-04-12 15:20:35',NULL,'2010-04-12 15:20:35'),(52,'page_script',0,NULL,'page_script',NULL,'UA','2010-04-12 15:20:43',NULL,'2010-04-12 15:20:43'),(55,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-09 19:00:56'),(55,'internal_page_content',0,NULL,'internal_page_content','','EN','2010-04-23 08:16:43',NULL,'2010-04-23 08:16:43'),(55,'internal_page_content',0,'<p>Главная цель и миссия TNS&nbsp;Opros &ndash; дать потребителям в руки рычаг воздействия на производителя или поставщика продуктов и услуг. Донести мысль потребителя до производителя.</p>\r\n<p>&nbsp;</p>\r\n<p>Высказывая свое мнение посредством TNS&nbsp;Opros, Вы получаете возможность влиять на окружающий мир, делаете его приятней и удобней для себя. Ваше мнение может повлиять на глобальные принципы мировых лидеров&nbsp; &ndash; производителей товаров и услуг .</p>\r\n<p>&nbsp;</p>\r\n<p>Мы стремимся к совершенству. И Вы &ndash; с нами!</p>','internal_page_content','','RU','2010-04-23 08:16:47','<p>Главная цель и миссия TNS&nbsp;Opros &ndash; дать потребителям в руки рычаг воздействия на производителя или поставщика продуктов и услуг. Донести мысль потребителя до производителя.</p>\r\n<p>&nbsp;</p>\r\n<p>Высказывая свое мнение посредством TNS&nbsp;Opros, Вы получаете возможность влиять на окружающий мир, делаете его приятней и удобней для себя. Ваше мнение может повлиять на глобальные принципы мировых лидеров&nbsp; &ndash; производителей товаров и услуг .</p>\r\n<p>&nbsp;</p>\r\n<p>Мы стремимся к совершенству. И Вы &ndash; с нами!</p>','2010-04-23 08:16:47'),(55,'internal_page_content',0,'<p>Головна мета і місія TNS Opros &ndash; надати споживачам важіль впливу на виробників продуктів по послуг. Донести думку споживача до виробника.</p>\r\n<p>&nbsp;</p>\r\n<p>Висловлюючи свою думку засобами TNS Opros, Ви отримаєте можливість <br />\r\nвпливати на навколишній світ, зробите його більш приємним, зручним <br />\r\nта затишним для себе. Ваша думка може вплинути на глобальні <br />\r\nпринципи світових лідерів &ndash; виробників товарів та послуг.</p>\r\n<p>&nbsp;</p>\r\n<p>Ми прагнемо до досконалості. І Ви &ndash; з нами!</p>','internal_page_content','','UA','2010-04-23 08:16:52','<p>Головна мета і місія TNS Opros &ndash; надати споживачам важіль впливу на виробників продуктів по послуг. Донести думку споживача до виробника.</p>\r\n<p>&nbsp;</p>\r\n<p>Висловлюючи свою думку засобами TNS Opros, Ви отримаєте можливість <br />\r\nвпливати на навколишній світ, зробите його більш приємним, зручним <br />\r\nта затишним для себе. Ваша думка може вплинути на глобальні <br />\r\nпринципи світових лідерів &ndash; виробників товарів та послуг.</p>\r\n<p>&nbsp;</p>\r\n<p>Ми прагнемо до досконалості. І Ви &ndash; з нами!</p>','2010-04-23 08:16:52'),(55,'internal_page_header',0,'Чем мы заняты','internal_page_header','','RU','2010-04-13 13:16:11','Чем мы заняты','2010-04-13 13:16:11'),(55,'internal_page_header',0,'Що ми робимо','internal_page_header','','UA','2010-01-09 19:02:00','Що ми робимо','2010-01-09 19:02:00'),(55,'int_b_class',0,'CDE8F3','int_b_class','','UA','2010-01-09 19:01:29','CDE8F3','2010-01-09 19:01:29'),(55,'int_h_class',0,NULL,'int_h_class',NULL,'RU','2010-04-13 13:15:49',NULL,'2010-04-13 13:15:49'),(55,'int_h_class',0,'0086D3','int_h_class','','UA','2010-01-09 19:01:02','0086D3','2010-01-09 19:01:02'),(55,'page_comment',0,'TNS в Украине вышла на рынок онлайн исследований. Быть с нами значит получать самое лучшее. Проект TNS Opros качественно изменит вашу жизнь и отношение к продуктам и услугам.','page_comment','','RU','2010-04-13 13:14:51','TNS в Украине вышла на рынок онлайн исследований. Быть с нами значит получать самое лучшее. Проект TNS Opros качественно изменит вашу жизнь и отношение к продуктам и услугам.','2010-04-13 13:14:51'),(55,'page_comment',0,'TNS в Україні вийшла на ринок онлайн досліджень. Бути з нами означає отримувати найкраще. Проект TNS Opros якісно змінить ваше життя та ставлення до продуктів та послуг.','page_comment','','UA','2010-04-13 13:15:07','TNS в Україні вийшла на ринок онлайн досліджень. Бути з нами означає отримувати найкраще. Проект TNS Opros якісно змінить ваше життя та ставлення до продуктів та послуг.','2010-04-13 13:15:07'),(55,'page_header',0,'Миссия TNS Opros','page_header','','RU','2010-04-13 13:05:22','Миссия TNS Opros','2010-04-13 13:05:22'),(57,'contact_block_content',0,'<p><img height=\"50\" width=\"50\" vspace=\"4\" align=\"left\" src=\"/usersimage/Image/face.png\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Віктор Божко</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p class=\"content_simple_text_lm\">044 201 10 15</p>\r\n<p><a class=\"system_button2\" href=\"mailto:viktor.bozhko@tns-ua.com?subject=Question\">Надіслати повідомлення</a></p>','contact_block_content','','UA','2010-01-29 15:33:22','<p><img height=\"50\" width=\"50\" vspace=\"4\" align=\"left\" src=\"/usersimage/Image/face.png\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Віктор Божко</p>\r\n<p class=\"content_simple_text_lm\">м. Київ вул. Ігорівська 1/8 літера &ldquo;В&rdquo;</p>\r\n<p class=\"content_simple_text_lm\">044 201 10 15</p>\r\n<p><a class=\"system_button2\" href=\"mailto:viktor.bozhko@tns-ua.com?subject=Question\">Надіслати повідомлення</a></p>','2010-01-29 15:33:22'),(57,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-13 19:51:26'),(57,'email_body',0,'Шановний {first_name} {last_name}!\r\nЩоб ввести новий пароль замість втраченого - скористайтесь формою на сторінці {link}.','email_body','','UA','2010-02-19 19:28:46','Шановний {first_name} {last_name}!\r\nЩоб ввести новий пароль замість втраченого - скористайтесь формою на сторінці {link}.','2010-02-19 19:28:46'),(57,'email_subject',0,'Password reset on TNS Opros','email_subject','','UA','2010-02-19 19:30:14','Password reset on TNS Opros','2010-02-19 19:30:14'),(57,'page_comment',0,'Будь-ласка, введіть e-mail, який ви використовували при \r\nреєстрації. На вашу поштову скриньку буде відправлено\r\nлиста з новим паролем.','page_comment','','UA','2009-12-13 19:52:17','Будь-ласка, введіть e-mail, який ви використовували при \r\nреєстрації. На вашу поштову скриньку буде відправлено\r\nлиста з новим паролем.','2009-12-13 19:52:17'),(57,'page_error',0,'Користувача з таким e-mail не існує або при заповненні форми \r\nбули допущені помилки.\r\nБудь-ласка, перевірте введені дані ще раз.','page_error','','UA','2009-12-13 19:56:09','Користувача з таким e-mail не існує або при заповненні форми \r\nбули допущені помилки.\r\nБудь-ласка, перевірте введені дані ще раз.','2009-12-13 19:56:09'),(57,'page_header',0,'Забули пароль?','page_header','','UA','2009-12-13 19:53:40','Забули пароль?','2009-12-13 19:53:40'),(59,'contact_block_content',0,'<p class=\"pink_15_lm\">Lorem ipsum.</p>\r\n<p class=\"content_simple_text_lm\">Dolor sit amet.</p>','contact_block_content','','UA','2010-01-14 11:57:49','<p class=\"pink_15_lm\">Lorem ipsum.</p>\r\n<p class=\"content_simple_text_lm\">Dolor sit amet.</p>','2010-01-14 11:57:49'),(59,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-11 10:39:18'),(59,'email_body',0,'Шановний {first_name} {last_name}!\r\nВи завершили реєстрацію на сайті {HTTP}.\r\n\r\nВаш логін: {login}\r\n\r\nДля запобігання втрати паролю, він не висилається Вам у відкритому вигляді. Якщо Ви забули пароль, то, будь ласка, скористайтесь формою відновлення паролю: {link}\r\n\r\nКількість балів на вашому рахунку Ви можете перевірити за адресою: {HTTP}UA/survey-history.html\r\n\r\nБажаємо успішних опитувань!\r\n\r\nЗ найкращими побажаннями,\r\nАдміністрація TNS Opros.','email_body','','UA','2010-03-10 11:41:08','Шановний {first_name} {last_name}!\r\nВи завершили реєстрацію на сайті {HTTP}.\r\n\r\nВаш логін: {login}\r\n\r\nДля запобігання втрати паролю, він не висилається Вам у відкритому вигляді. Якщо Ви забули пароль, то, будь ласка, скористайтесь формою відновлення паролю: {link}\r\n\r\nКількість балів на вашому рахунку Ви можете перевірити за адресою: {HTTP}UA/survey-history.html\r\n\r\nБажаємо успішних опитувань!\r\n\r\nЗ найкращими побажаннями,\r\nАдміністрація TNS Opros.','2010-03-10 11:41:08'),(59,'email_subject',0,'Account on TNS Opros','email_subject','','UA','2010-02-25 19:19:14','Account on TNS Opros','2010-02-25 19:19:14'),(59,'page_comment',0,'Будь-ласка, введіть пароль до вашого профайлу на сайті. \r\nЗверніть увагу, що пароль треба ввести двічі. Використовуйте латинські літери.\r\nПароль має містити хоча б одну велику літеру, хоча б одну маленьку літеру, хоча б одну цифру та бути завдовжки не менше, ніж 8 символів.','page_comment','','UA','2010-02-26 08:43:59','Будь-ласка, введіть пароль до вашого профайлу на сайті. \r\nЗверніть увагу, що пароль треба ввести двічі. Використовуйте латинські літери.\r\nПароль має містити хоча б одну велику літеру, хоча б одну маленьку літеру, хоча б одну цифру та бути завдовжки не менше, ніж 8 символів.','2010-02-26 08:43:59'),(59,'page_error',0,'Під час заповнення форми були допущені помилки.<br/>\r\nБудь ласка, перевірте введені дані ще раз.<br/>','page_error','','UA','2010-01-28 08:46:16','Під час заповнення форми були допущені помилки.<br/>\r\nБудь ласка, перевірте введені дані ще раз.<br/>','2010-01-28 08:46:16'),(59,'page_header',0,'Форма підтвердження реєстрації','page_header','','UA','2009-12-11 11:22:28','Форма підтвердження реєстрації','2009-12-11 11:22:28'),(60,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-28 17:00:36'),(60,'email_body',0,'Ваш пароль було успішно змінено.\r\nДякуємо за користування сервісом!\r\n\r\nЗ повагою, \r\nкоманда TNS Opros!','email_body','','UA','2010-04-01 14:51:10','Ваш пароль було успішно змінено.\r\nДякуємо за користування сервісом!\r\n\r\nЗ повагою, \r\nкоманда TNS Opros!','2010-04-01 14:51:10'),(60,'email_subject',0,'New password on TNS Opros','email_subject','','UA','2010-04-01 14:49:01','New password on TNS Opros','2010-04-01 14:49:01'),(60,'page_comment',0,NULL,'page_comment',NULL,'UA','2010-02-24 16:22:17',NULL,'2010-02-24 16:22:17'),(60,'page_error',0,'При заповненні форми були допущені помилки.<br />\r\nБудь ласка, спробуйте заповнити форму ще раз.','page_error','','UA','2010-01-28 17:01:24','При заповненні форми були допущені помилки.<br />\r\nБудь ласка, спробуйте заповнити форму ще раз.','2010-01-28 17:01:24'),(60,'page_header',0,'Відновлення паролю','page_header','','UA','2010-02-24 16:23:04','Відновлення паролю','2010-02-24 16:23:04'),(61,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-10 16:06:24'),(61,'internal_page_content',0,NULL,'internal_page_content','','EN','2011-03-28 08:48:39',NULL,'2011-03-28 08:48:39'),(61,'internal_page_content',0,'<p>Поздравляем!</p>\r\n<p>Вы зарегистрированы.</p>\r\n<p>Проверьте свою <strong>электронную почту</strong> для получения дальнейших инструкций и <strong>подтверждения регистрации</strong>. Без подтверждения регистрации Вы не сможете принимать участие в опросах.</p>','internal_page_content','','RU','2011-03-28 08:50:37','<p>Поздравляем!</p>\r\n<p>Вы зарегистрированы.</p>\r\n<p>Проверьте свою <strong>электронную почту</strong> для получения дальнейших инструкций и <strong>подтверждения регистрации</strong>. Без подтверждения регистрации Вы не сможете принимать участие в опросах.</p>','2011-03-28 08:50:37'),(61,'internal_page_content',0,'<p>Вітаємо!</p>\r\n<p>Ви зареєстровані.</p>\r\n<p>Перевірте свою <strong>електронну пошту</strong> щоб отримати подальші інструкції та <strong>підтвердити реєстрацію</strong>. Без підтверждення реєстрації Ви не зможете приймати участь у опитуваннях.</p>','internal_page_content','','UA','2011-03-28 08:48:22','<p>Вітаємо!</p>\r\n<p>Ви зареєстровані.</p>\r\n<p>Перевірте свою <strong>електронну пошту</strong> щоб отримати подальші інструкції та <strong>підтвердити реєстрацію</strong>. Без підтверждення реєстрації Ви не зможете приймати участь у опитуваннях.</p>','2011-03-28 08:48:22'),(61,'page_comment',0,'','page_comment','','UA','2010-04-08 19:00:45','','2010-04-08 19:00:45'),(61,'page_script',0,NULL,'page_script','','RU','2010-04-26 14:53:40',NULL,'2010-04-26 14:53:40'),(61,'page_script',0,'<script language=\"JavaScript\"> //<!-- var c8_pid = Math.round(Math.random() * 1000000000); document.write(\'<scr\' + \'ipt language=\"JavaScript\" charset=\"utf-8\" src=\"http://b.c8.net.ua/goal?49&\' + c8_pid + \'&54\"></scr\' + \'ipt>\'); //--> </script>','page_script','','UA','2010-04-09 06:44:10','<script language=\"JavaScript\"> //<!-- var c8_pid = Math.round(Math.random() * 1000000000); document.write(\'<scr\' + \'ipt language=\"JavaScript\" charset=\"utf-8\" src=\"http://b.c8.net.ua/goal?49&\' + c8_pid + \'&54\"></scr\' + \'ipt>\'); //--> </script>','2010-04-09 06:44:10'),(62,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-11 10:41:33'),(62,'internal_page_content',0,'<p><span id=\"bread_crumb_page_name\">Вітаємо!</span></p>\r\n<p><span id=\"bread_crumb_page_name\">Реєстрацію завершено остаточно, пароль збережено.</span></p>','internal_page_content','','UA','2009-12-11 10:41:54','<p><span id=\"bread_crumb_page_name\">Вітаємо!</span></p>\r\n<p><span id=\"bread_crumb_page_name\">Реєстрацію завершено остаточно, пароль збережено.</span></p>','2009-12-11 10:41:54'),(62,'page_comment',0,'','page_comment','','UA','2009-12-11 11:19:40','','2009-12-11 11:19:40'),(62,'page_header',0,'Форма підтвердження реєстрації','page_header','','UA','2009-12-11 10:55:34','Форма підтвердження реєстрації','2009-12-11 10:55:34'),(63,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-11 14:52:29'),(63,'internal_page_content',0,'<p>Нажаль, такої сторінки не існує. Якщо ви скористалися збереженим <br />\r\nраніше посиланням або меню Favourites, то, скоріше за все, сторінка <br />\r\nзмінила адресу і Вам неохідно оновити посилання.</p>\r\n<p>Також перевірте, будь-ласка, написання посилання на наявність <br />\r\nпомилок, описок та зайвих пробілів.</p>\r\n<p>Ви завжди можете скористатись <a href=\"/index.php?t=34&amp;language=UA\">мапою сайту</a>.</p>','internal_page_content','','UA','2009-12-11 14:53:36','<p>Нажаль, такої сторінки не існує. Якщо ви скористалися збереженим <br />\r\nраніше посиланням або меню Favourites, то, скоріше за все, сторінка <br />\r\nзмінила адресу і Вам неохідно оновити посилання.</p>\r\n<p>Також перевірте, будь-ласка, написання посилання на наявність <br />\r\nпомилок, описок та зайвих пробілів.</p>\r\n<p>Ви завжди можете скористатись <a href=\"/index.php?t=34&amp;language=UA\">мапою сайту</a>.</p>','2009-12-11 14:53:36'),(63,'page_header',0,'Такої сторінки не існує','page_header','','UA','2009-12-11 14:54:28','Такої сторінки не існує','2009-12-11 14:54:28'),(67,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2009-12-29 21:57:46'),(67,'internal_page_content',0,'<p>Сторінка, яку ви намагались відкрити, доступна лише для авторизованих користувачив.</p>\r\n<p>Скористайтесь <a href=\"/index.php?t=68&amp;language=UA\">формою авторизації</a> або <a href=\"/index.php?t=47&amp;language=UA\">зареєструйтесь</a>, якщо не зробили цього раніше.</p>','internal_page_content','','UA','2010-01-30 08:50:37','<p>Сторінка, яку ви намагались відкрити, доступна лише для авторизованих користувачив.</p>\r\n<p>Скористайтесь <a href=\"/index.php?t=68&amp;language=UA\">формою авторизації</a> або <a href=\"/index.php?t=47&amp;language=UA\">зареєструйтесь</a>, якщо не зробили цього раніше.</p>','2010-01-30 08:50:37'),(67,'page_comment',0,'','page_comment','','UA','2010-01-30 08:49:35','','2010-01-30 08:49:35'),(68,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-05 23:48:41'),(68,'page_comment',0,'Будь-ласка, введіть свій логін(e-mail) та пароль у форму нижче.','page_comment','','UA','2010-01-29 15:34:14','Будь-ласка, введіть свій логін(e-mail) та пароль у форму нижче.','2010-01-29 15:34:14'),(68,'page_error',0,'Користувача з таким логіном та паролем не існує або при заповненні \r\nформи були допущені помилки.\r\n\r\nБудь-ласка, перевірте введені дані ще раз.','page_error','','UA','2010-01-05 23:50:18','Користувача з таким логіном та паролем не існує або при заповненні \r\nформи були допущені помилки.\r\n\r\nБудь-ласка, перевірте введені дані ще раз.','2010-01-05 23:50:18'),(86,'contact_block_content',0,NULL,'contact_block_content',NULL,'EN','2010-01-29 17:48:18',NULL,'2010-01-29 17:48:18'),(86,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Служба поддержки</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=FAQQuestion\" class=\"system_button2\">Послать сообщение</a></p>','contact_block_content','','RU','2010-06-21 07:14:43','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" src=\"/usersimage/Image/person.PNG\" alt=\"\" /></p>\r\n<p class=\"pink_15_lm\">Служба поддержки</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=FAQQuestion\" class=\"system_button2\">Послать сообщение</a></p>','2010-06-21 07:14:43'),(86,'contact_block_content',0,'<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" alt=\"\" src=\"/usersimage/Image/person.PNG\" /></p>\r\n<p class=\"pink_15_lm\">Служба підтримки</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a class=\"system_button2\" href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=FAQQuestion\">Надіслати повідомлення</a></p>','contact_block_content','','UA','2011-03-18 10:00:16','<p><img width=\"45\" vspace=\"4\" height=\"44\" align=\"left\" alt=\"\" src=\"/usersimage/Image/person.PNG\" /></p>\r\n<p class=\"pink_15_lm\">Служба підтримки</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p class=\"content_simple_text_lm\">&nbsp;</p>\r\n<p><a class=\"system_button2\" href=\"mailto:accesspanel.helpdesk@tns-ua.com?subject=FAQQuestion\">Надіслати повідомлення</a></p>','2011-03-18 10:00:16'),(86,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-18 16:25:10'),(86,'internal_page_content',0,NULL,'internal_page_content','','EN','2011-08-15 12:50:37',NULL,'2011-08-15 12:50:37'),(86,'internal_page_content',0,'<p><a href=\"#part1\" class=\"faq_question\">Как принять участие в исследовании?</a><br />\r\n<a href=\"#part2\" class=\"faq_question\">Для чего нужен мой e-mail?</a><br />\r\n<a href=\"#part3\" class=\"faq_question\">Вопрос конфиденциальности личных данных.</a><br />\r\n<a href=\"#part4\" class=\"faq_question\">Что такое маркетинговые исследования?</a><br />\r\n<a href=\"#part5\" class=\"faq_question\">Что такое аксес-панель?</a><br />\r\n<a href=\"#part6\" class=\"faq_question\">Почему я не могу конвертировать свои баллы?</a><br />\r\n<a href=\"#part7\" class=\"faq_question\">Почему список текущих исследований пуст?</a><br />\r\n<a href=\"#part8\" class=\"faq_question\">Как я могу проверить какие операции проводились с моими баллами?</a><br />\r\n<a href=\"#part9\" class=\"faq_question\">Я сконвертировал свои баллы, но не получил деньги. Сколько времени должно пройти, пока перевод дойдет до меня?</a></p>\r\n<p>&nbsp;</p>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part1\">Как принять участие в исследовании</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, чтобы принять участие в исследовании Вам необходимо сначала зарегистрироваться в сообществе TNS Opros. После этого перейдите на страницу <a href=\"/index.php?t=45&amp;language=UA\">Текущие исследования</a> и выберите тематику исследования по своим предпочтениям. В завершение, после того, как Вы пройдете опрос, Вы будете перенаправлены на страницу <a href=\"/index.php?t=30&amp;language=UA\">История опросов</a>, где будет указано сколько баллов Вы заработали за пройденное исследование.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part2\">Для чего нужен мой e-mail?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Ваш e-mail(адрес электронной почты) служит логином для авторизации на сайте, а также может быть использован для связи с Вами по каким-либо причинам, которые могут возникнуть пока Вы участвуете в сообществе. Например, подтверждение регистрации, возобновление пароля, приглашение к участию в исследовании и др..</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part3\">Вопрос конфиденциальности личных данных.</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Усі ваші особисті дані збираються, передаються та зберігаються з у відповідності до найвищих вимог конфіденційності. Жодна третя особа(у тому числі інші учасники) не може заволодіти будь-якими даними, що Ви передаєте співтовариству. Сервери з даними охороняються у режимі 24*7 протягом усього року. Будь-ласка, не передавайте свої логін та пароль іншим особам, а також користуйтеся кнопкою &quot;Вихід&quot; для завершення роботи на сайті. Це забезпечить додатковий рівень безпеки Ваших особистих даних.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part4\">Что такое маркетинговые исследования?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Маркетингові дослідження &mdash; систематичне збирання, опрацьовування й аналіз інформації та можливостей, розроблення рекомендацій на підставі цих даних. Відомо, що добробут компаній виробників та постачальників послуг напряму залежить від задоволеності споживачем продукцією. Завдання маркетингового дослідження - визначити сторони невдоволеності споживача та шляхи подолання цієї невдоволенності. Як правило, вони також передбачають аналіз продажу та маркетингових можливостей, прогнозування продажу, ринкових кривих пропозиції та попиту. Результати маркетингових досліджень фірми використовують при плануванні та контролі діяльності.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part5\">Що таке аксес-панель?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Аксес-панель(англ. access panel) - співтовариство людей, що згодились на постійній основі брати участь у маркетингових дослідженнях певної компанії, що їх проводить. Реалізуються загалом у онлайн-секторі. Компанія TNS має великий світовий досвід побудови аксес-панелей по всьому світу.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part6\">Почему я не могу конвертировать свои баллы?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, щоб отримати можливість конвертувати свої бали потрібно накопичити їх не менше, ніж 3000. Якщо Ви накопичили достатню кількість балів, але все одно не можете їх сконвертувати, будь-ласка, напишіть у нашу Службу Підтримки. Ми якнашвидше дамо відповідь.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part7\">Почему список текущих исследований пуст?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Список проектів може бути пустий у декількох випадках:</div>\r\n<ol>\r\n    <li>Ви вже взяли участь у всіх поточних проектах;</li>\r\n    <li>На даний момент немає поточних проектів.</li>\r\n</ol>\r\n<br />\r\n<p>В будь-якому випадку список проектів ніколи не пустує протягом тривалого періоду. Заходьте частіше та переконаєтесь!</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part8\">Как я могу проверить какие операции проводились с моими баллами?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Існує спеціальна сторінка&nbsp; <a href=\"/index.php?t=30&amp;language=UA\">Історія опитувань</a>, де у хронологічному порядку відображаються усі дії, що ви робили у співтоваристві. Операція використання балів для конвертації позначається особливим фоном, тому зразу буде помітною серед інших.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part9\">Я сконвертировал свои баллы, но не получил деньги. Сколько времени должно пройти, пока перевод дойдет до меня?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Независимо от того, какой вид конвертации Вы выбрали, переводы осуществляются каждый понедельник за предыдущую неделю. При этом деньги могут поступить на счет в течении двух-трех дней(за исключением праздничных дней, когда возможна несколько большая задержка).</div>\r\n</div>\r\n</div>\r\n</div>','internal_page_content','','RU','2011-08-15 12:51:06','<p><a href=\"#part1\" class=\"faq_question\">Как принять участие в исследовании?</a><br />\r\n<a href=\"#part2\" class=\"faq_question\">Для чего нужен мой e-mail?</a><br />\r\n<a href=\"#part3\" class=\"faq_question\">Вопрос конфиденциальности личных данных.</a><br />\r\n<a href=\"#part4\" class=\"faq_question\">Что такое маркетинговые исследования?</a><br />\r\n<a href=\"#part5\" class=\"faq_question\">Что такое аксес-панель?</a><br />\r\n<a href=\"#part6\" class=\"faq_question\">Почему я не могу конвертировать свои баллы?</a><br />\r\n<a href=\"#part7\" class=\"faq_question\">Почему список текущих исследований пуст?</a><br />\r\n<a href=\"#part8\" class=\"faq_question\">Как я могу проверить какие операции проводились с моими баллами?</a><br />\r\n<a href=\"#part9\" class=\"faq_question\">Я сконвертировал свои баллы, но не получил деньги. Сколько времени должно пройти, пока перевод дойдет до меня?</a></p>\r\n<p>&nbsp;</p>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part1\">Как принять участие в исследовании</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, чтобы принять участие в исследовании Вам необходимо сначала зарегистрироваться в сообществе TNS Opros. После этого перейдите на страницу <a href=\"/index.php?t=45&amp;language=UA\">Текущие исследования</a> и выберите тематику исследования по своим предпочтениям. В завершение, после того, как Вы пройдете опрос, Вы будете перенаправлены на страницу <a href=\"/index.php?t=30&amp;language=UA\">История опросов</a>, где будет указано сколько баллов Вы заработали за пройденное исследование.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part2\">Для чего нужен мой e-mail?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Ваш e-mail(адрес электронной почты) служит логином для авторизации на сайте, а также может быть использован для связи с Вами по каким-либо причинам, которые могут возникнуть пока Вы участвуете в сообществе. Например, подтверждение регистрации, возобновление пароля, приглашение к участию в исследовании и др..</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part3\">Вопрос конфиденциальности личных данных.</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Усі ваші особисті дані збираються, передаються та зберігаються з у відповідності до найвищих вимог конфіденційності. Жодна третя особа(у тому числі інші учасники) не може заволодіти будь-якими даними, що Ви передаєте співтовариству. Сервери з даними охороняються у режимі 24*7 протягом усього року. Будь-ласка, не передавайте свої логін та пароль іншим особам, а також користуйтеся кнопкою &quot;Вихід&quot; для завершення роботи на сайті. Це забезпечить додатковий рівень безпеки Ваших особистих даних.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part4\">Что такое маркетинговые исследования?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Маркетингові дослідження &mdash; систематичне збирання, опрацьовування й аналіз інформації та можливостей, розроблення рекомендацій на підставі цих даних. Відомо, що добробут компаній виробників та постачальників послуг напряму залежить від задоволеності споживачем продукцією. Завдання маркетингового дослідження - визначити сторони невдоволеності споживача та шляхи подолання цієї невдоволенності. Як правило, вони також передбачають аналіз продажу та маркетингових можливостей, прогнозування продажу, ринкових кривих пропозиції та попиту. Результати маркетингових досліджень фірми використовують при плануванні та контролі діяльності.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part5\">Що таке аксес-панель?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Аксес-панель(англ. access panel) - співтовариство людей, що згодились на постійній основі брати участь у маркетингових дослідженнях певної компанії, що їх проводить. Реалізуються загалом у онлайн-секторі. Компанія TNS має великий світовий досвід побудови аксес-панелей по всьому світу.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part6\">Почему я не могу конвертировать свои баллы?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, щоб отримати можливість конвертувати свої бали потрібно накопичити їх не менше, ніж 3000. Якщо Ви накопичили достатню кількість балів, але все одно не можете їх сконвертувати, будь-ласка, напишіть у нашу Службу Підтримки. Ми якнашвидше дамо відповідь.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part7\">Почему список текущих исследований пуст?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Список проектів може бути пустий у декількох випадках:</div>\r\n<ol>\r\n    <li>Ви вже взяли участь у всіх поточних проектах;</li>\r\n    <li>На даний момент немає поточних проектів.</li>\r\n</ol>\r\n<br />\r\n<p>В будь-якому випадку список проектів ніколи не пустує протягом тривалого періоду. Заходьте частіше та переконаєтесь!</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part8\">Как я могу проверить какие операции проводились с моими баллами?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Існує спеціальна сторінка&nbsp; <a href=\"/index.php?t=30&amp;language=UA\">Історія опитувань</a>, де у хронологічному порядку відображаються усі дії, що ви робили у співтоваристві. Операція використання балів для конвертації позначається особливим фоном, тому зразу буде помітною серед інших.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part9\">Я сконвертировал свои баллы, но не получил деньги. Сколько времени должно пройти, пока перевод дойдет до меня?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Независимо от того, какой вид конвертации Вы выбрали, переводы осуществляются каждый понедельник за предыдущую неделю. При этом деньги могут поступить на счет в течении двух-трех дней(за исключением праздничных дней, когда возможна несколько большая задержка).</div>\r\n</div>\r\n</div>\r\n</div>','2011-08-15 12:51:06'),(86,'internal_page_content',0,'<p><a href=\"#part1\" class=\"faq_question\">Як взяти участь у дослідженні?</a><br />\r\n<a href=\"#part2\" class=\"faq_question\">Для чого потрібен мій e-mail?</a><br />\r\n<a href=\"#part3\" class=\"faq_question\">Питання конфіденційності особистих даних.</a><br />\r\n<a href=\"#part4\" class=\"faq_question\">Що таке маркетингові дослідження?</a><br />\r\n<a href=\"#part5\" class=\"faq_question\">Що таке аксес-панель?</a><br />\r\n<a href=\"#part6\" class=\"faq_question\">Чому я не можу сконвертувати свої бали?</a><br />\r\n<a href=\"#part7\" class=\"faq_question\">Чому список поточних проектів пустий?</a><br />\r\n<a href=\"#part8\" class=\"faq_question\">Як я можу дізнатися про операції, що проводилися з моїми балами?</a><br />\r\n<a href=\"#part9\" class=\"faq_question\">Я сконвертував свої бали, але не отримав гроші. Скільки часу потрібно для того, щоб гроші дійшли до мене?</a></p>\r\n<p>&nbsp;</p>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part1\">Як взяти участь у дослідженні?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, щоб взяти участь у дослідженні Вам необхідно спочатку зареєструватися у співтоваристві(при цьому необхідно буде вказати деяку інформацію про Вас та Вашу e-mail адресу). Після цього потрібно перейти на сторінку <a href=\"/index.php?t=45&amp;language=UA\">Поточні дослідження</a> та оберіть тематику дослідження за своїм смаком. Після завершення анкетування Ви будете перенаправлені на сторінку <a href=\"/index.php?t=30&amp;language=UA\">Історія опитувань</a>, де буде вказано скільки балів Ви заробили за пройдене дослідження.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part2\">Для чого потрібен мій e-mail?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Ваш e-mail(електронна пошта) слугує логіном для авторизації на сайті, а також буде використаний для зв<span lang=\"EN-US\">&rsquo;</span>язку з Вами з будь-яких причин, що можуть виникнути впродовж вашої участі у співтоваристві. Наприклад, підтвердження реєстрації, відновлення паролю, запрошення до участі у дослідженні і т.і..</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part3\">Питання конфіденційності особистих даних.</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Усі ваші особисті дані збираються, передаються та зберігаються у відповідності до найвищих вимог конфіденційності. Жодна третя особа(у тому числі інші учасники) не може заволодіти будь-якими даними, що Ви передаєте співтовариству. Сервери з даними охороняються у режимі 24*7 протягом усього року. Будь-ласка, не передавайте свої логін та пароль іншим особам, а також користуйтеся кнопкою &quot;Вихід&quot; для завершення роботи на сайті. Це забезпечить додатковий рівень безпеки Ваших особистих даних.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part4\">Що таке маркетингові дослідження?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Маркетингові дослідження &mdash; систематичне збирання, опрацьовування й аналіз інформації та можливостей, розроблення рекомендацій на підставі цих даних. Відомо, що добробут компаній виробників та постачальників послуг напряму залежить від задоволеності споживачем продукцією. Завдання маркетингового дослідження - визначити сторони невдоволеності споживача та шляхи подолання цієї невдоволенності. Як правило, вони також передбачають аналіз продажу та маркетингових можливостей, прогнозування продажу, ринкових кривих пропозиції та попиту. Результати маркетингових досліджень фірми використовують при плануванні та контролі діяльності.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part5\">Що таке аксес-панель?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Аксес-панель(англ. access panel) - співтовариство людей, що згодились на постійній основі брати участь у маркетингових дослідженнях певної компанії, що їх проводить. Реалізуються загалом у онлайн-секторі. Компанія TNS має великий світовий досвід побудови аксес-панелей по всьому світу.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part6\">Чому я не можу сконвертувати свої бали?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, щоб отримати можливість конвертувати свої бали потрібно накопичити їх не менше, ніж 3000. Якщо Ви накопичили достатню кількість балів, але все одно не можете їх сконвертувати, будь-ласка, напишіть у нашу Службу Підтримки. Ми якнашвидше дамо відповідь.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part7\">Чому список поточних проектів пустий?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Список проектів може бути пустий у декількох випадках:</div>\r\n<ol>\r\n    <li>Ви вже взяли участь у всіх поточних проектах;</li>\r\n    <li>На даний момент немає поточних проектів.</li>\r\n</ol>\r\n<br />\r\n<p>В будь-якому випадку список проектів ніколи не пустує протягом тривалого періоду. Заходьте частіше та переконаєтесь!</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part8\">Як я можу дізнатися про операції, що проводилися з моїми балами?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Існує спеціальна сторінка&nbsp; <a href=\"/index.php?t=30&amp;language=UA\">Історія опитувань</a>, де у хронологічному порядку відображаються усі дії, що ви робили у співтоваристві. Операція використання балів для конвертації позначається особливим фоном, тому відразу буде помітною серед інших.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part9\">Я сконвертував свої бали, але не отримав гроші. Скільки часу потрібно для того, щоб гроші дійшли до мене?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Незалежно від того, який вид конвертації ви вибрали, перекази здійснюються щопонеділка за попередній тиждень. При цьому гроші потрапляють на рахунок протягом двох-трьох днів(за виключенням святкових днів, коли можлива дещо більша затримка).</div>\r\n</div>\r\n</div>\r\n</div>','internal_page_content','<DIV class=int>\r\n<br/><DIV class=int_h>\r\n<br/><DIV class=int_h_text>Питання №1</DIV>\r\n<br/></DIV>\r\n<br/><DIV class=int_b>\r\n<br/><DIV class=int_b_content>\r\n<br/><DIV>Відповідь на питання №1</DIV>\r\n<br/></DIV>\r\n<br/></DIV>\r\n<br/></DIV>\r\n<br/>','UA','2011-08-15 13:07:19','<p><a href=\"#part1\" class=\"faq_question\">Як взяти участь у дослідженні?</a><br />\r\n<a href=\"#part2\" class=\"faq_question\">Для чого потрібен мій e-mail?</a><br />\r\n<a href=\"#part3\" class=\"faq_question\">Питання конфіденційності особистих даних.</a><br />\r\n<a href=\"#part4\" class=\"faq_question\">Що таке маркетингові дослідження?</a><br />\r\n<a href=\"#part5\" class=\"faq_question\">Що таке аксес-панель?</a><br />\r\n<a href=\"#part6\" class=\"faq_question\">Чому я не можу сконвертувати свої бали?</a><br />\r\n<a href=\"#part7\" class=\"faq_question\">Чому список поточних проектів пустий?</a><br />\r\n<a href=\"#part8\" class=\"faq_question\">Як я можу дізнатися про операції, що проводилися з моїми балами?</a><br />\r\n<a href=\"#part9\" class=\"faq_question\">Я сконвертував свої бали, але не отримав гроші. Скільки часу потрібно для того, щоб гроші дійшли до мене?</a></p>\r\n<p>&nbsp;</p>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part1\">Як взяти участь у дослідженні?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, щоб взяти участь у дослідженні Вам необхідно спочатку зареєструватися у співтоваристві(при цьому необхідно буде вказати деяку інформацію про Вас та Вашу e-mail адресу). Після цього потрібно перейти на сторінку <a href=\"/index.php?t=45&amp;language=UA\">Поточні дослідження</a> та оберіть тематику дослідження за своїм смаком. Після завершення анкетування Ви будете перенаправлені на сторінку <a href=\"/index.php?t=30&amp;language=UA\">Історія опитувань</a>, де буде вказано скільки балів Ви заробили за пройдене дослідження.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part2\">Для чого потрібен мій e-mail?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Ваш e-mail(електронна пошта) слугує логіном для авторизації на сайті, а також буде використаний для зв<span lang=\"EN-US\">&rsquo;</span>язку з Вами з будь-яких причин, що можуть виникнути впродовж вашої участі у співтоваристві. Наприклад, підтвердження реєстрації, відновлення паролю, запрошення до участі у дослідженні і т.і..</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part3\">Питання конфіденційності особистих даних.</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Усі ваші особисті дані збираються, передаються та зберігаються у відповідності до найвищих вимог конфіденційності. Жодна третя особа(у тому числі інші учасники) не може заволодіти будь-якими даними, що Ви передаєте співтовариству. Сервери з даними охороняються у режимі 24*7 протягом усього року. Будь-ласка, не передавайте свої логін та пароль іншим особам, а також користуйтеся кнопкою &quot;Вихід&quot; для завершення роботи на сайті. Це забезпечить додатковий рівень безпеки Ваших особистих даних.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part4\">Що таке маркетингові дослідження?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Маркетингові дослідження &mdash; систематичне збирання, опрацьовування й аналіз інформації та можливостей, розроблення рекомендацій на підставі цих даних. Відомо, що добробут компаній виробників та постачальників послуг напряму залежить від задоволеності споживачем продукцією. Завдання маркетингового дослідження - визначити сторони невдоволеності споживача та шляхи подолання цієї невдоволенності. Як правило, вони також передбачають аналіз продажу та маркетингових можливостей, прогнозування продажу, ринкових кривих пропозиції та попиту. Результати маркетингових досліджень фірми використовують при плануванні та контролі діяльності.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part5\">Що таке аксес-панель?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Аксес-панель(англ. access panel) - співтовариство людей, що згодились на постійній основі брати участь у маркетингових дослідженнях певної компанії, що їх проводить. Реалізуються загалом у онлайн-секторі. Компанія TNS має великий світовий досвід побудови аксес-панелей по всьому світу.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part6\">Чому я не можу сконвертувати свої бали?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Для того, щоб отримати можливість конвертувати свої бали потрібно накопичити їх не менше, ніж 3000. Якщо Ви накопичили достатню кількість балів, але все одно не можете їх сконвертувати, будь-ласка, напишіть у нашу Службу Підтримки. Ми якнашвидше дамо відповідь.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part7\">Чому список поточних проектів пустий?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Список проектів може бути пустий у декількох випадках:</div>\r\n<ol>\r\n    <li>Ви вже взяли участь у всіх поточних проектах;</li>\r\n    <li>На даний момент немає поточних проектів.</li>\r\n</ol>\r\n<br />\r\n<p>В будь-якому випадку список проектів ніколи не пустує протягом тривалого періоду. Заходьте частіше та переконаєтесь!</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part8\">Як я можу дізнатися про операції, що проводилися з моїми балами?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Існує спеціальна сторінка&nbsp; <a href=\"/index.php?t=30&amp;language=UA\">Історія опитувань</a>, де у хронологічному порядку відображаються усі дії, що ви робили у співтоваристві. Операція використання балів для конвертації позначається особливим фоном, тому відразу буде помітною серед інших.</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"int\">\r\n<div class=\"int_h\">\r\n<div class=\"int_h_text\"><a name=\"part9\">Я сконвертував свої бали, але не отримав гроші. Скільки часу потрібно для того, щоб гроші дійшли до мене?</a></div>\r\n</div>\r\n<div class=\"int_b\">\r\n<div class=\"int_b_content\">\r\n<div>Незалежно від того, який вид конвертації ви вибрали, перекази здійснюються щопонеділка за попередній тиждень. При цьому гроші потрапляють на рахунок протягом двох-трьох днів(за виключенням святкових днів, коли можлива дещо більша затримка).</div>\r\n</div>\r\n</div>\r\n</div>','2011-08-15 13:07:19'),(86,'internal_page_header',0,'','Заглавие блока','','UA','2010-01-18 16:29:37','','2010-01-18 16:29:37'),(86,'int_b_class',0,'','Цвет footer блока. Может быть одно из значений: CDE8F3, D0D0D0, D0EAF4 или пустое значение','','UA','2010-01-18 16:29:11','','2010-01-18 16:29:11'),(86,'int_h_class',0,'','Цвет шапки блока. Возможные значения: 0086D3, 8495AE или пустое','','UA','2010-01-18 16:28:48','','2010-01-18 16:28:48'),(86,'page_comment',0,'Ответы на самые распространенные вопросы мы размещаем в этом разделе. Это сэкономит Ваше время и добавит удобства в пользовании сайтом.','page_comment','','RU','2010-04-13 13:38:38','Ответы на самые распространенные вопросы мы размещаем в этом разделе. Это сэкономит Ваше время и добавит удобства в пользовании сайтом.','2010-04-13 13:38:38'),(86,'page_comment',0,'Відповіді на найпоширеніші запитання ми розміщуємо у даному розділі. Це заощадить Ваш час додасть зручності у користуванні.','page_comment','','UA','2010-04-13 13:36:59','Відповіді на найпоширеніші запитання ми розміщуємо у даному розділі. Це заощадить Ваш час додасть зручності у користуванні.','2010-04-13 13:36:59'),(86,'page_header',0,'Частозадаваемые вопросы','page_header','','RU','2010-04-13 13:36:33','Частозадаваемые вопросы','2010-04-13 13:36:33'),(86,'right_block_h_class_contact',0,NULL,'right_block_h_class_contact',NULL,'UA','2010-01-30 09:40:55',NULL,'2010-01-30 09:40:55'),(89,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00','root','2010-01-19 08:29:23'),(89,'internal_page_content',0,'<p>От: Access Panel Test2 site Server</p>\r\n<p>1</p>\r\n<p>2</p>\r\n<p>3</p>\r\n<p>4</p>\r\n<p>&nbsp;</p>','internal_page_content','','UA','2010-01-19 08:33:01','<p>От: Access Panel Test2 site Server</p>\r\n<p>1</p>\r\n<p>2</p>\r\n<p>3</p>\r\n<p>4</p>\r\n<p>&nbsp;</p>','2010-01-19 08:33:01'),(89,'internal_page_header',0,'заголовок','internal_page_header','','UA','2010-01-19 08:32:10','заголовок','2010-01-19 08:32:10'),(89,'int_b_class',0,NULL,'int_b_class',NULL,'UA','2010-01-19 08:32:47',NULL,'2010-01-19 08:32:47'),(89,'int_h_class',0,NULL,'int_h_class',NULL,'UA','2010-01-19 08:31:58',NULL,'2010-01-19 08:31:58'),(89,'page_comment',0,NULL,'page_comment',NULL,'EN','2010-01-19 08:31:47',NULL,'2010-01-19 08:31:47'),(89,'page_comment',0,'пояснения','page_comment','','UA','2010-01-19 08:31:55','пояснения','2010-01-19 08:31:55'),(89,'page_header',0,'Новые статьи','page_header','','UA','2010-01-19 08:31:34','Новые статьи','2010-01-19 08:31:34'),(93,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00',NULL,'2010-04-12 11:33:12'),(93,'email_body',0,'Шановний {first_name} {last_name}!\r\nВи завершили реєстрацію на сайті {HTTP}.\r\n\r\nВаш логін: {login}\r\n\r\nДля запобігання втрати паролю, він не висилається Вам у відкритому вигляді. Якщо Ви забули пароль, то, будь ласка, скористайтесь формою відновлення паролю: {link}\r\n\r\nКількість балів на вашому рахунку Ви можете перевірити за адресою: {HTTP}UA/survey-history.html\r\n\r\nБажаємо успішних опитувань!\r\n\r\nЗ найкращими побажаннями,\r\nАдміністрація TNS Opros.','email_body','','UA','2010-04-12 11:33:53','Шановний {first_name} {last_name}!\r\nВи завершили реєстрацію на сайті {HTTP}.\r\n\r\nВаш логін: {login}\r\n\r\nДля запобігання втрати паролю, він не висилається Вам у відкритому вигляді. Якщо Ви забули пароль, то, будь ласка, скористайтесь формою відновлення паролю: {link}\r\n\r\nКількість балів на вашому рахунку Ви можете перевірити за адресою: {HTTP}UA/survey-history.html\r\n\r\nБажаємо успішних опитувань!\r\n\r\nЗ найкращими побажаннями,\r\nАдміністрація TNS Opros.','2010-04-12 11:33:53'),(93,'email_subject',0,'Account on TNS Opros','email_subject','','UA','2010-04-12 11:33:16','Account on TNS Opros','2010-04-12 11:33:16'),(99,'edit_user',0,'root',NULL,NULL,'','0000-00-00 00:00:00',NULL,'2010-04-21 14:39:11'),(99,'internal_page_content',0,NULL,'internal_page_content','','EN','2010-10-14 09:18:44',NULL,'2010-10-14 09:18:44'),(99,'internal_page_content',0,NULL,'internal_page_content',NULL,'RU','2010-06-01 09:33:28',NULL,'2010-06-01 09:33:28'),(99,'internal_page_content',0,'<p>\r\n<link rel=\"File-List\" href=\"file:///C:\\DOCUME~1\\Admin\\LOCALS~1\\Temp\\msohtml1\\01\\clip_filelist.xml\" /> <span lang=\"UK\" style=\"\">1.&nbsp;&nbsp; Загальні положення.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Акція з залучення користувачів(далі Учасників) до реєстрації на сайті <a href=\"../../\">http://opros.tns-ua.com</a><span style=\"\">&nbsp; </span>(далі Акція) має на меті популяризацію послуг, що надає компанія TNS в Україні, а саме онлайн-сервісу для проведення маркетингових досліджень.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Термін проведення Акції: 22.04.2010 &ndash; 24.11.2010.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.3.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Територія проведення Акції: Акція проводиться в мережі Інтернет, на сайті <a href=\"../../\">http://opros.tns-ua.com</a> по всій території України.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.4.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Організатор: TNS в Україні.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.5.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Організатор залишає за собою право змінювати умови Акції. В такому чині зміни набувають чинності з моменту опублікування їх на сайті <a href=\"../../\">http://opros.tns-ua.com</a>.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 18pt; text-indent: -18pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Участь у Конкурсі.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Для участі в Акції необхідно зареєструватися на сайті, при цьому вказавши свою </span><span lang=\"EN-US\" style=\"\">e</span><span lang=\"UK\" style=\"\">-</span><span lang=\"EN-US\" style=\"\">mail</span><span lang=\"UK\" style=\"\"> адресу та підтвердити свою реєстрацію шляхом посилання, що прийде у вигляді листа на вказану </span><span lang=\"EN-US\" style=\"\">e</span><span lang=\"UK\" style=\"\">-</span><span lang=\"EN-US\" style=\"\">mail</span><span lang=\"UK\" style=\"\"> адресу.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">До участі в Акції допускаються громадяни України, які досягли 12-річного віку.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.3.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Участь у Акції &ndash; безкоштовна.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.4.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Не можуть брати участь у Акції: працівники та представники Організатора, члени їх сімей, а також представники будь-яких інших осіб, що мають безпосереднє відношення до організації чи проведенню даної Акції, а також громадяни України, що зайняті у сфері маркетингу та досліджень ринку.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.5.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Будь-які користувачі, що підходять під опис п.2.4. можуть бути учасниками співтовариства </span><span lang=\"EN-US\" style=\"\">TNS</span><span lang=\"EN-US\" style=\"\"> </span><span lang=\"EN-US\" style=\"\">Opros</span><span lang=\"UK\" style=\"\"> згідно правил участі у співтоваристві </span><span lang=\"EN-US\" style=\"\">TNS</span><span lang=\"EN-US\" style=\"\"> </span><span lang=\"EN-US\" style=\"\">Opros</span><span lang=\"EN-US\" style=\"\"> </span><span lang=\"UK\" style=\"\">(далі Правила Участі), що описані на сторінці <a href=\"../../UA/Pravyla-uchasti.html\">http://opros.tns-ua.com/UA/Pravyla-uchasti.html</a>, але не являються Учасниками Акції.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.6.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Учасник Акції зобов&rsquo;язується слідувати Правилам Участі.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.7.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Участь у фотоконкурсі передбачає прийняття всіх пунктів даних правил без винятку й застережень у повному обсязі.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.8.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Організатор Акції залишає за собою право відмовити в участі без пояснення причин.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 18pt; text-indent: -18pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">3.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Призи та обрання переможців Акції</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">3.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Кожен Учасник Акції в обов&rsquo;язковому порядку отримує 500 балів на рахунок.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">3.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Переможці Акції будуть обрані методом лототрону у офісі Організатора за адресою </span>вул. Ігорівська 1/8 літера &quot;В&quot;, Київ, 04070, Україна<span style=\"\"> <span lang=\"UK\">06.12.2010.</span></span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 18pt; text-indent: -18pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">4.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Призовий фонд та порядок отримання подарунків.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">4.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Призовий фонд фотоконкурсу: плеєр Transcend T-Sonic 860 8GB White, навушники Koss Porta Pro, гнучка клавіатура Your Device! Black (PUK1001B).</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">4.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Переможці Акції будуть запрошені до офісу Організатора за адресою </span>вул. Ігорівська 1/8 літера &quot;В&quot;, Київ, 04070, Україна<span lang=\"UK\" style=\"\"> 07.12.2010 та отримають призи.</span></p>\r\n<p>&nbsp;</p>','internal_page_content','','UA','2010-11-24 10:05:37','<p>\r\n<link rel=\"File-List\" href=\"file:///C:\\DOCUME~1\\Admin\\LOCALS~1\\Temp\\msohtml1\\01\\clip_filelist.xml\" /> <span lang=\"UK\" style=\"\">1.&nbsp;&nbsp; Загальні положення.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Акція з залучення користувачів(далі Учасників) до реєстрації на сайті <a href=\"../../\">http://opros.tns-ua.com</a><span style=\"\">&nbsp; </span>(далі Акція) має на меті популяризацію послуг, що надає компанія TNS в Україні, а саме онлайн-сервісу для проведення маркетингових досліджень.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Термін проведення Акції: 22.04.2010 &ndash; 24.11.2010.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.3.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Територія проведення Акції: Акція проводиться в мережі Інтернет, на сайті <a href=\"../../\">http://opros.tns-ua.com</a> по всій території України.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.4.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Організатор: TNS в Україні.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">1.5.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Організатор залишає за собою право змінювати умови Акції. В такому чині зміни набувають чинності з моменту опублікування їх на сайті <a href=\"../../\">http://opros.tns-ua.com</a>.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 18pt; text-indent: -18pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Участь у Конкурсі.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Для участі в Акції необхідно зареєструватися на сайті, при цьому вказавши свою </span><span lang=\"EN-US\" style=\"\">e</span><span lang=\"UK\" style=\"\">-</span><span lang=\"EN-US\" style=\"\">mail</span><span lang=\"UK\" style=\"\"> адресу та підтвердити свою реєстрацію шляхом посилання, що прийде у вигляді листа на вказану </span><span lang=\"EN-US\" style=\"\">e</span><span lang=\"UK\" style=\"\">-</span><span lang=\"EN-US\" style=\"\">mail</span><span lang=\"UK\" style=\"\"> адресу.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">До участі в Акції допускаються громадяни України, які досягли 12-річного віку.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.3.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Участь у Акції &ndash; безкоштовна.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.4.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Не можуть брати участь у Акції: працівники та представники Організатора, члени їх сімей, а також представники будь-яких інших осіб, що мають безпосереднє відношення до організації чи проведенню даної Акції, а також громадяни України, що зайняті у сфері маркетингу та досліджень ринку.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.5.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Будь-які користувачі, що підходять під опис п.2.4. можуть бути учасниками співтовариства </span><span lang=\"EN-US\" style=\"\">TNS</span><span lang=\"EN-US\" style=\"\"> </span><span lang=\"EN-US\" style=\"\">Opros</span><span lang=\"UK\" style=\"\"> згідно правил участі у співтоваристві </span><span lang=\"EN-US\" style=\"\">TNS</span><span lang=\"EN-US\" style=\"\"> </span><span lang=\"EN-US\" style=\"\">Opros</span><span lang=\"EN-US\" style=\"\"> </span><span lang=\"UK\" style=\"\">(далі Правила Участі), що описані на сторінці <a href=\"../../UA/Pravyla-uchasti.html\">http://opros.tns-ua.com/UA/Pravyla-uchasti.html</a>, але не являються Учасниками Акції.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.6.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Учасник Акції зобов&rsquo;язується слідувати Правилам Участі.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.7.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Участь у фотоконкурсі передбачає прийняття всіх пунктів даних правил без винятку й застережень у повному обсязі.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">2.8.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Організатор Акції залишає за собою право відмовити в участі без пояснення причин.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 18pt; text-indent: -18pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">3.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Призи та обрання переможців Акції</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">3.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Кожен Учасник Акції в обов&rsquo;язковому порядку отримує 500 балів на рахунок.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">3.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Переможці Акції будуть обрані методом лототрону у офісі Організатора за адресою </span>вул. Ігорівська 1/8 літера &quot;В&quot;, Київ, 04070, Україна<span style=\"\"> <span lang=\"UK\">06.12.2010.</span></span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 18pt; text-indent: -18pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">4.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Призовий фонд та порядок отримання подарунків.</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">4.1.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Призовий фонд фотоконкурсу: плеєр Transcend T-Sonic 860 8GB White, навушники Koss Porta Pro, гнучка клавіатура Your Device! Black (PUK1001B).</span></p>\r\n<p class=\"MsoNormal\" style=\"margin-left: 39.6pt; text-indent: -21.6pt;\"><span lang=\"UK\" style=\"\"><span style=\"\">4.2.<span style=\"font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;\">&nbsp;&nbsp; </span></span></span><span lang=\"UK\" style=\"\">Переможці Акції будуть запрошені до офісу Організатора за адресою </span>вул. Ігорівська 1/8 літера &quot;В&quot;, Київ, 04070, Україна<span lang=\"UK\" style=\"\"> 07.12.2010 та отримають призи.</span></p>\r\n<p>&nbsp;</p>','2010-11-24 10:05:37'),(99,'page_comment',0,NULL,'page_comment',NULL,'UA','2010-10-14 09:18:35',NULL,'2010-10-14 09:18:35');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_access`
--

DROP TABLE IF EXISTS `content_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_access` (
  `id` int(11) NOT NULL,
  `content_access_name` varchar(250) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_access`
--

LOCK TABLES `content_access` WRITE;
/*!40000 ALTER TABLE `content_access` DISABLE KEYS */;
INSERT INTO `content_access` VALUES (1,'Read only'),(2,'Edit'),(3,'Publish'),(4,'Full');
/*!40000 ALTER TABLE `content_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dns`
--

DROP TABLE IF EXISTS `dns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns` (
  `id` int(11) NOT NULL auto_increment,
  `dns` varchar(255) NOT NULL default '',
  `comment` text,
  `status` int(11) NOT NULL default '0',
  `language_forwarding` char(2) default NULL,
  `draft_mode` tinyint(1) NOT NULL default '0',
  `cdn_server` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `dns` (`dns`),
  KEY `status_idx` (`status`),
  KEY `dns_language_idx` (`language_forwarding`),
  KEY `dns_cdn_server_idx` (`cdn_server`),
  CONSTRAINT `dns_cdn_server_idx` FOREIGN KEY (`cdn_server`) REFERENCES `dns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dns_language_idx` FOREIGN KEY (`language_forwarding`) REFERENCES `language` (`language_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dns`
--

LOCK TABLES `dns` WRITE;
/*!40000 ALTER TABLE `dns` DISABLE KEYS */;
INSERT INTO `dns` VALUES (1,'test1.tns.2kgroup.com','',1,'UA',0,NULL),(2,'2kgroup-bmw','',1,'UA',0,NULL),(3,'109.68.45.2',NULL,1,'UA',0,NULL),(4,'opros.tns-global.com.ua','',1,'UA',0,NULL),(5,'opros.tns-ua.com','',1,'UA',0,NULL);
/*!40000 ALTER TABLE `dns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folder_group`
--

DROP TABLE IF EXISTS `folder_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folder_group` (
  `folder_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  KEY `folder_id` (`folder_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder_group`
--

LOCK TABLES `folder_group` WRITE;
/*!40000 ALTER TABLE `folder_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `folder_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `language_code` char(2) NOT NULL default '',
  `language_url` char(10) NOT NULL,
  `language_name` varchar(30) default NULL,
  `l_encode` varchar(50) default NULL,
  `paypal_lang` char(2) NOT NULL default 'US',
  `language_of_browser` char(50) NOT NULL,
  `status` int(11) NOT NULL default '0',
  `default_language` int(11) NOT NULL default '0',
  PRIMARY KEY  (`language_code`),
  UNIQUE KEY `language_of_browser` (`language_of_browser`),
  UNIQUE KEY `language_url` (`language_url`),
  UNIQUE KEY `language_name` (`language_name`),
  KEY `status_idx` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES ('','','','','','',1,0),('EN','EN','EN','UTF-8','US','%[EN]%',1,0),('RU','RU','Russian','windows-1251','RU','%[RU]%',1,0),('UA','UA','Ukrainian','windows-1251','EN','%[UA]%',1,1);
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_inbox`
--

DROP TABLE IF EXISTS `mail_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_inbox` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(50) NOT NULL default '',
  `name` varchar(100) NOT NULL default '',
  `add_info` text NOT NULL,
  `send_date` datetime NOT NULL,
  `viewed` int(10) unsigned NOT NULL default '0',
  `message` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `viewed_idx` (`viewed`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_inbox`
--

LOCK TABLES `mail_inbox` WRITE;
/*!40000 ALTER TABLE `mail_inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_mail`
--

DROP TABLE IF EXISTS `ms_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ms_mail` (
  `id` int(11) NOT NULL auto_increment,
  `original_name` varchar(255) NOT NULL default 'news_letters',
  `original_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` longtext,
  `from_name` varchar(255) NOT NULL,
  `from_email` varchar(255) NOT NULL,
  `header` longtext,
  `ms_status_id` int(11) NOT NULL default '2',
  `date_reg` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `original_id_idx` (`original_id`),
  KEY `ms_status_id_idx` (`ms_status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_mail`
--

LOCK TABLES `ms_mail` WRITE;
/*!40000 ALTER TABLE `ms_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ms_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_recipient`
--

DROP TABLE IF EXISTS `ms_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ms_recipient` (
  `id` int(11) NOT NULL auto_increment,
  `recipient` varchar(255) NOT NULL,
  `ms_mail_id` int(11) NOT NULL,
  `ms_status_id` int(11) NOT NULL default '2',
  `date_update` datetime default NULL,
  `language` char(2) NOT NULL,
  `recipient_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `ms_mail_id_idx` (`ms_mail_id`),
  KEY `ms_status_id_idx` (`ms_status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_recipient`
--

LOCK TABLES `ms_recipient` WRITE;
/*!40000 ALTER TABLE `ms_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `ms_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_status`
--

DROP TABLE IF EXISTS `ms_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ms_status` (
  `id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `ms_status_key` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_status`
--

LOCK TABLES `ms_status` WRITE;
/*!40000 ALTER TABLE `ms_status` DISABLE KEYS */;
INSERT INTO `ms_status` VALUES (1,'draft'),(2,'outbox'),(3,'sent'),(4,'deleted'),(5,'error'),(6,'archive');
/*!40000 ALTER TABLE `ms_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nl_attachments`
--

DROP TABLE IF EXISTS `nl_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nl_attachments` (
  `id` int(11) NOT NULL auto_increment,
  `nl_id` int(11) NOT NULL,
  `file_name` varchar(50) NOT NULL,
  `file_content` longblob NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `nl_id_idx` (`nl_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nl_attachments`
--

LOCK TABLES `nl_attachments` WRITE;
/*!40000 ALTER TABLE `nl_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `nl_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nl_email`
--

DROP TABLE IF EXISTS `nl_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nl_email` (
  `id` int(11) NOT NULL auto_increment,
  `from_name` varchar(255) NOT NULL,
  `from_email` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `tpl` varchar(255) default NULL,
  `body` longtext,
  `header` longtext,
  `transaction_id` int(11) default NULL,
  `finish_date` date default NULL,
  `ip_address` varchar(50) default NULL,
  `create_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `transaction_id_idx` (`transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nl_email`
--

LOCK TABLES `nl_email` WRITE;
/*!40000 ALTER TABLE `nl_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `nl_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nl_email_group`
--

DROP TABLE IF EXISTS `nl_email_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nl_email_group` (
  `nl_email_id` int(11) NOT NULL,
  `nl_group_id` int(11) NOT NULL,
  UNIQUE KEY `UQ__nl_email_group__22FF2F51` (`nl_email_id`,`nl_group_id`),
  KEY `nl_email_id_idx` (`nl_email_id`),
  KEY `nl_group_id_idx` (`nl_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nl_email_group`
--

LOCK TABLES `nl_email_group` WRITE;
/*!40000 ALTER TABLE `nl_email_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `nl_email_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nl_group`
--

DROP TABLE IF EXISTS `nl_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nl_group` (
  `id` int(11) NOT NULL auto_increment,
  `group_name` varchar(255) NOT NULL,
  `show_on_front` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `UQ__nl_group__40058253` (`group_name`),
  KEY `show_on_front_idx` (`show_on_front`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nl_group`
--

LOCK TABLES `nl_group` WRITE;
/*!40000 ALTER TABLE `nl_group` DISABLE KEYS */;
INSERT INTO `nl_group` VALUES (1,'newsletter group',1);
/*!40000 ALTER TABLE `nl_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nl_subscriber`
--

DROP TABLE IF EXISTS `nl_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nl_subscriber` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) NOT NULL,
  `nl_group_id` int(11) NOT NULL,
  `status` int(2) default NULL,
  `reg_date` datetime default NULL,
  `last_send` datetime default NULL,
  `confirm_code` bigint(20) default NULL,
  `language` char(2) default NULL,
  `company` char(255) default NULL,
  `first_name` varchar(50) default NULL,
  `sur_name` varchar(50) default NULL,
  `city` char(255) default NULL,
  `ip_address` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `nl_group_id_idx` (`nl_group_id`),
  KEY `status_idx` (`status`),
  KEY `nl_subscriber_language_idx` (`language`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nl_subscriber`
--

LOCK TABLES `nl_subscriber` WRITE;
/*!40000 ALTER TABLE `nl_subscriber` DISABLE KEYS */;
/*!40000 ALTER TABLE `nl_subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nl_subscriber_status`
--

DROP TABLE IF EXISTS `nl_subscriber_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nl_subscriber_status` (
  `id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  UNIQUE KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nl_subscriber_status`
--

LOCK TABLES `nl_subscriber_status` WRITE;
/*!40000 ALTER TABLE `nl_subscriber_status` DISABLE KEYS */;
INSERT INTO `nl_subscriber_status` VALUES (0,'subscribe requested'),(1,'subscribed'),(3,'unsubscribe requested'),(4,'unsubscribed');
/*!40000 ALTER TABLE `nl_subscriber_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object`
--

DROP TABLE IF EXISTS `object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object`
--

LOCK TABLES `object` WRITE;
/*!40000 ALTER TABLE `object` DISABLE KEYS */;
INSERT INTO `object` VALUES (10,'answer'),(14,'ap_investigation'),(13,'ap_news'),(1,'captcha'),(3,'formbuilder'),(2,'form_mails'),(5,'gallery'),(4,'gallery_image'),(6,'news_channels'),(7,'news_export'),(8,'news_items'),(9,'news_mapping'),(11,'question'),(12,'survey');
/*!40000 ALTER TABLE `object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_content`
--

DROP TABLE IF EXISTS `object_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_content` (
  `object_field_id` int(11) NOT NULL,
  `object_record_id` int(11) NOT NULL,
  `value` text NOT NULL,
  `language` char(2) NOT NULL default 'UA',
  PRIMARY KEY  (`object_field_id`,`object_record_id`,`language`),
  KEY `object_content_object_record_id` (`object_record_id`),
  KEY `language` (`language`),
  CONSTRAINT `object_content_ibfk_1` FOREIGN KEY (`object_field_id`) REFERENCES `object_field` (`id`) ON DELETE CASCADE,
  CONSTRAINT `object_content_ibfk_2` FOREIGN KEY (`language`) REFERENCES `language` (`language_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `object_content_object_record_id` FOREIGN KEY (`object_record_id`) REFERENCES `object_record` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_content`
--

LOCK TABLES `object_content` WRITE;
/*!40000 ALTER TABLE `object_content` DISABLE KEYS */;
INSERT INTO `object_content` VALUES (76,18,'001265234400','EN'),(76,18,'001265234400','RU'),(76,18,'001265234400','UA'),(76,27,'001265580000','UA'),(76,28,'001265580000','UA'),(76,30,'001265580000','UA'),(76,31,'001266184800','UA'),(76,32,'001266184800','UA'),(76,33,'001266184800','UA'),(76,34,'001266184800','UA'),(77,18,'','EN'),(77,18,'','RU'),(77,18,'Використання мобільного телефону','UA'),(77,27,'Кількість автомобілів у сім’ї','UA'),(77,28,'Інтерактивне спілкування і спілкування у реальному житті','UA'),(77,30,'На що витрачаються кишенькові гроші','UA'),(77,31,'Покупка презервативів','UA'),(77,32,'Вживання засобів від похмілля','UA'),(77,33,'Без чого ми не можемо уявити своє життя? ','UA'),(77,34,'Користування Інтернет','UA'),(78,18,'','EN'),(78,18,'\r\nЕще 12 лет назад никто не знал о мобильной связи, а сегодня 88% городского населения использует ее, и количество пользователей растет.','RU'),(78,18,'Ще 12 років назад ніхто нічого не знав про мобільний звязок, а на сьогоднішній день 88 % міського населення використовують мобільний звязок, і кількість користувачів збільшується. ','UA'),(78,27,'Не дивлячись на фінансову кризу, кількість автомобілів і Україні зберігається. В кожній 5ій сімї, що проживає в містах Українм, є один автомобіль (20, 4%), а 2% українців мають два та більше автомобілів.','UA'),(78,28,'Трохи більше половини міського населення України у віці 16-65 років, а саме 58 %, поділяють побоювання, що компютер замінить просте спілкування між людьми, хоча всього 22% населення України у віці 16-65 років використовують комп’ютер вдома кожен день і 11% на роботі/під час навчання. ','UA'),(78,30,'56.7% дітей у віці від 12 до 15 років (які проживають у містах України з населенням більше, ніж 50 тис. жителів), у яких є кишенькові гроші, витрачають їх на покупку солодощів, чіпсів, сухариків і 50,2% витрачають свої кишенькові гроші на напої. ','UA'),(78,31,'Кожен 5-й міський житель України у віці 16-65 років купує презервативи (21,9%). ','UA'),(78,32,'5% серед міського населення України в віці 16-65 років хоча б раз у півроку вживали покупні засоби від похмілля. ','UA'),(78,33,'Люди не можуть прожити без повітря, без їжі та води, але ще, крім того, 62,3% міського населення України у віці 16-65 років не можуть уявити свого життя без перегляду ТВ. ','UA'),(78,34,'Виявляється, рівень користування Інтернет вдома зростає, а рівень використання на роботі – падає. ','UA'),(79,18,'','RU'),(79,18,'<p>Кожен другий українець відправляє SMS кожен або майже кожен день (21,9%). 34.6% міського населення України у віці 12-65 років не можуть уявити свого життя без розмов по мобільному телефону. 69,4% міського населення України у віці 12-65 років згодні з твердженням, що мобільний телефон допомагає людям жити повноцінним життям.</p>\r\n<p><img width=\"420\" height=\"256\" alt=\"\" src=\"/usersimage/Image/article_UA_telephone.PNG\" /></p>\r\n<p>&nbsp;</p>\r\n<p>Джерело: MMI Ukraine</p>','UA'),(79,27,'<p><img width=\"420\" height=\"198\" alt=\"\" src=\"/usersimage/Image/article_UA_cars.PNG\" /></p>\r\n<p>&nbsp;</p>\r\n<p>Джерело: MMI Ukraine</p>','UA'),(79,28,'<p><img width=\"420\" height=\"251\" src=\"/usersimage/Image/article_UA_communication.PNG\" alt=\"\" /></p>\r\n<p>&nbsp;</p>\r\n<p>Джерело: MMI Ukraine</p>','UA'),(79,30,'<p><img width=\"390\" height=\"814\" align=\"middle\" src=\"/usersimage/Image/123.png\" alt=\"\" /></p>\r\n<p>&nbsp;</p>\r\n<p>Джерело: MMI Ukraine</p>','UA'),(79,31,'<p>Серед тих, хто є холостими або не заміжніми, 26,3% купують презервативи, це більше, ніж серед усього міського населення України у віці 16-65 років. Серед тих, хто згодні з твердженнями, що перед тим як заводити дітей, потрібно як можна довше пожити у своє задоволення, і заводити дітей можна тільки після того, як досягнеш чогось у житті - 24,7% и 24,4% відповідно купують презервативи, це більше ніж серед усього міського населення України у віці 16-65 років.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span lang=\"UK\" style=\"font-size: 10pt; font-family: Arial;\"><img width=\"420\" height=\"256\" src=\"/usersimage/Image/article_UA_condoms.PNG\" alt=\"\" /></span></p>\r\n<p>&nbsp;</p>\r\nДжерело: MMI Ukraine','UA'),(79,32,'Серед тих, хто вживав вермут декілька разів в місяць чи раз в місяць, засоби від похмілля вживали 18%. А серед тих, хто вживає горілку частіше одного разу в місяць або раз в місяць, 12% вживали засоби від похмілля. Це більше, ніж серед усього міського населення України у віці 16-65 років.\r\n<p><img width=\"420\" height=\"258\" src=\"/usersimage/Image/article_UA_drunk.PNG\" alt=\"\" /></p>\r\n<p>Джерело: MMI Ukraine</p>','UA'),(79,33,'<p><img width=\"420\" height=\"319\" alt=\"\" src=\"/usersimage/Image/article_UA_lifewithout.PNG\" /></p>\r\n<p>&nbsp;</p>\r\n<p>Джерело: MMI Ukraine</p>','UA'),(79,34,'<p><img width=\"420\" height=\"254\" src=\"/usersimage/Image/article_UA_internetusing.PNG\" alt=\"\" /></p>\r\n<p>&nbsp;</p>\r\nДжерело: MMI Ukraine','UA');
/*!40000 ALTER TABLE `object_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_field`
--

DROP TABLE IF EXISTS `object_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_field` (
  `id` int(11) NOT NULL auto_increment,
  `object_id` int(11) NOT NULL,
  `object_field_name` varchar(50) NOT NULL,
  `object_field_type` varchar(20) NOT NULL,
  `one_for_all_languages` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `object_id` (`object_id`,`object_field_name`),
  KEY `object_field_type` (`object_field_type`),
  KEY `one_for_all_languages_idx` (`one_for_all_languages`),
  CONSTRAINT `object_field_object_id` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `object_field_type` FOREIGN KEY (`object_field_type`) REFERENCES `object_field_type` (`object_field_type`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_field`
--

LOCK TABLES `object_field` WRITE;
/*!40000 ALTER TABLE `object_field` DISABLE KEYS */;
INSERT INTO `object_field` VALUES (1,1,'captcha_word','TEXT',0),(2,2,'form_name','TEXT',1),(3,2,'user_name','TEXT',1),(4,2,'date','TEXT',1),(5,2,'ip','TEXT',1),(6,2,'serialized','LONGTEXT',1),(7,3,'form_name','TEXT',1),(8,3,'form_config','LONGTEXT',1),(9,3,'content','LONGTEXT',1),(10,5,'gallery_date','DATE',1),(11,5,'gallery_title','TEXT',0),(12,5,'gallery_description','TEXT',0),(13,5,'gallery_status','INTEGER',1),(14,5,'gallery_image_w','INTEGER',1),(15,5,'gallery_image_h','INTEGER',1),(16,5,'gallery_images','INTEGER',1),(17,5,'load_gallery','TEXT',1),(18,5,'gallery_id','ID',1),(19,4,'gallery_id','FOREIGN_KEY',1),(20,4,'image_filename','TEXT',1),(21,4,'image_title','TEXT',0),(22,4,'image_description','TEXT',0),(23,4,'is_gallery_image','INTEGER',1),(24,4,'item_order','INTEGER',1),(25,4,'load_image','TEXT',1),(26,4,'text_above_image','TEXT',0),(27,4,'text_below_image','TEXT',0),(28,4,'publish_date','DATE',1),(29,4,'KEYWORDS','TEXT',0),(30,4,'DESCRIPTION','TEXT',0),(31,4,'TITLE','TEXT',0),(32,6,'channel_title','TEXT',0),(33,6,'channel_link','TEXT',0),(34,6,'channel_description','TEXT',0),(35,6,'channel_language','TEXT',0),(36,6,'channel_pubDate','DATE',1),(37,6,'channel_lastBuildDate','DATE',0),(38,6,'channel_docs','TEXT',0),(39,6,'channel_generator','TEXT',0),(40,6,'channel_managingEditor','TEXT',0),(41,6,'channel_webMaster','TEXT',0),(42,6,'status_id','TEXT',1),(43,8,'summary_title','TEXT',0),(44,8,'item_title','TEXT',0),(45,8,'item_link','TEXT',0),(46,8,'item_description','TEXT',0),(47,8,'item_pubDate','DATE',1),(48,8,'item_guid','TEXT',0),(49,8,'item_channel_id','ID',1),(50,8,'status_of_news','TEXT',0),(51,8,'html_content','HTML',1),(52,8,'gallery_id','FOREIGN_KEY',1),(53,7,'name','TEXT',0),(54,7,'template','TEXT',0),(55,9,'title','TEXT',0),(56,9,'channel','ID',0),(57,9,'type_of_export','ID',0),(58,10,'answer','TEXT',0),(59,10,'question_id','FOREIGN_KEY',1),(60,11,'question','TEXT',0),(61,11,'active','INTEGER',1),(62,11,'date','TEXT',1),(63,11,'hide_results','INTEGER ',1),(64,11,'text_instead_hidden_results','HTML',0),(65,12,'question_id','FOREIGN_KEY',1),(66,12,'answer_id','FOREIGN_KEY',1),(67,12,'date','TEXT',1),(68,12,'ip','TEXT',1),(69,12,'answer_language','TEXT',1),(70,12,'user_id','TEXT',1),(71,13,'ap_news_date','DATE',1),(72,13,'ap_news_title','TEXT',0),(73,13,'ap_news_preview','LONGTEXT',0),(74,13,'ap_news_content','HTML',0),(75,13,'ap_news_img','IMAGE',1),(76,14,'ap_investigation_date','DATE',1),(77,14,'ap_investigation_title','TEXT',0),(78,14,'ap_investigation_preview','LONGTEXT',0),(79,14,'ap_investigation_content','HTML',0);
/*!40000 ALTER TABLE `object_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_field_type`
--

DROP TABLE IF EXISTS `object_field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_field_type` (
  `id` int(11) NOT NULL auto_increment,
  `object_field_type` varchar(20) NOT NULL,
  `one_for_all_languages` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `object_field_type` (`object_field_type`),
  KEY `one_for_all_languages_idx` (`one_for_all_languages`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_field_type`
--

LOCK TABLES `object_field_type` WRITE;
/*!40000 ALTER TABLE `object_field_type` DISABLE KEYS */;
INSERT INTO `object_field_type` VALUES (1,'DATE',0),(2,'TEXT',0),(3,'INTEGER',0),(4,'IMAGE',0),(5,'HTML',0),(6,'ID',0),(7,'FOREIGN_KEY',0),(8,'LONGTEXT',0);
/*!40000 ALTER TABLE `object_field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_record`
--

DROP TABLE IF EXISTS `object_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_record` (
  `id` int(11) NOT NULL auto_increment,
  `object_id` int(11) NOT NULL,
  `last_update` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `user_name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `object_id` (`object_id`),
  CONSTRAINT `object_record_object_id` FOREIGN KEY (`object_id`) REFERENCES `object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_record`
--

LOCK TABLES `object_record` WRITE;
/*!40000 ALTER TABLE `object_record` DISABLE KEYS */;
INSERT INTO `object_record` VALUES (18,14,'2010-02-04 13:56:45','Admin'),(27,14,'2010-02-08 09:48:34','Admin'),(28,14,'2010-02-08 10:41:03','Admin'),(30,14,'2010-02-08 12:54:07','Admin'),(31,14,'2010-02-15 13:08:24','Admin'),(32,14,'2010-02-15 13:15:11','Admin'),(33,14,'2010-02-15 13:17:44','Admin'),(34,14,'2010-02-15 13:21:18','Admin');
/*!40000 ALTER TABLE `object_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_template`
--

DROP TABLE IF EXISTS `object_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_template` (
  `id` int(11) NOT NULL auto_increment,
  `object_id` int(11) default NULL,
  `template_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `object_id` (`object_id`,`template_id`),
  KEY `object_template_template_id` (`template_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_template`
--

LOCK TABLES `object_template` WRITE;
/*!40000 ALTER TABLE `object_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `object_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permanent_redirect`
--

DROP TABLE IF EXISTS `permanent_redirect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permanent_redirect` (
  `id` int(11) NOT NULL auto_increment,
  `source_url` varchar(255) default NULL,
  `target_url` varchar(255) default NULL,
  `page_id` int(11) default NULL,
  `lang_code` char(2) default NULL,
  `t_view` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `source_url` (`source_url`),
  KEY `page_id` (`page_id`),
  KEY `pr_language_code_idx` (`lang_code`),
  KEY `t_view` (`t_view`),
  CONSTRAINT `permanent_redirect_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `tpl_pages` (`id`),
  CONSTRAINT `permanent_redirect_ibfk_2` FOREIGN KEY (`lang_code`) REFERENCES `language` (`language_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permanent_redirect_ibfk_3` FOREIGN KEY (`t_view`) REFERENCES `tpl_views` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permanent_redirect`
--

LOCK TABLES `permanent_redirect` WRITE;
/*!40000 ALTER TABLE `permanent_redirect` DISABLE KEYS */;
/*!40000 ALTER TABLE `permanent_redirect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permanent_redirect_object`
--

DROP TABLE IF EXISTS `permanent_redirect_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permanent_redirect_object` (
  `id` int(11) NOT NULL auto_increment,
  `source_url` varchar(255) NOT NULL,
  `target_url` varchar(255) default NULL,
  `language` char(2) default NULL,
  `tpl_view` int(11) default NULL,
  `object_record_id` int(11) default NULL,
  `object_view` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `pr_object_source_url` (`source_url`),
  KEY `pr_object_language_idx` (`language`),
  KEY `pr_object_tpl_view_idx` (`tpl_view`),
  KEY `pr_object_record_id` (`object_record_id`),
  KEY `pr_object_object_view` (`object_view`),
  CONSTRAINT `permanent_redirect_object_ibfk_1` FOREIGN KEY (`language`) REFERENCES `language` (`language_code`),
  CONSTRAINT `permanent_redirect_object_ibfk_2` FOREIGN KEY (`tpl_view`) REFERENCES `tpl_views` (`id`),
  CONSTRAINT `permanent_redirect_object_ibfk_3` FOREIGN KEY (`object_record_id`) REFERENCES `object_record` (`id`),
  CONSTRAINT `permanent_redirect_object_ibfk_4` FOREIGN KEY (`object_view`) REFERENCES `tpl_files` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permanent_redirect_object`
--

LOCK TABLES `permanent_redirect_object` WRITE;
/*!40000 ALTER TABLE `permanent_redirect_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `permanent_redirect_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_acl_groups`
--

DROP TABLE IF EXISTS `phpbb_acl_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_acl_groups` (
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_option_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_role_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_setting` tinyint(2) NOT NULL default '0',
  KEY `group_id` (`group_id`),
  KEY `auth_opt_id` (`auth_option_id`),
  KEY `auth_role_id` (`auth_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_acl_groups`
--

LOCK TABLES `phpbb_acl_groups` WRITE;
/*!40000 ALTER TABLE `phpbb_acl_groups` DISABLE KEYS */;
INSERT INTO `phpbb_acl_groups` VALUES (1,0,85,0,1),(1,0,93,0,1),(1,0,111,0,1),(5,0,0,5,0),(5,0,0,1,0),(2,0,0,6,0),(3,0,0,6,0),(4,0,0,5,0),(4,0,0,10,0),(1,1,0,17,0),(2,1,0,17,0),(3,1,0,17,0),(6,1,0,17,0),(1,2,0,17,0),(2,2,0,15,0),(3,2,0,15,0),(4,2,0,21,0),(5,2,0,14,0),(5,2,0,10,0),(6,2,0,19,0),(7,0,0,23,0),(7,2,0,24,0);
/*!40000 ALTER TABLE `phpbb_acl_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_acl_options`
--

DROP TABLE IF EXISTS `phpbb_acl_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_acl_options` (
  `auth_option_id` mediumint(8) unsigned NOT NULL auto_increment,
  `auth_option` varchar(50) collate utf8_bin NOT NULL default '',
  `is_global` tinyint(1) unsigned NOT NULL default '0',
  `is_local` tinyint(1) unsigned NOT NULL default '0',
  `founder_only` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`auth_option_id`),
  UNIQUE KEY `auth_option` (`auth_option`)
) ENGINE=MyISAM AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_acl_options`
--

LOCK TABLES `phpbb_acl_options` WRITE;
/*!40000 ALTER TABLE `phpbb_acl_options` DISABLE KEYS */;
INSERT INTO `phpbb_acl_options` VALUES (1,'f_',0,1,0),(2,'f_announce',0,1,0),(3,'f_attach',0,1,0),(4,'f_bbcode',0,1,0),(5,'f_bump',0,1,0),(6,'f_delete',0,1,0),(7,'f_download',0,1,0),(8,'f_edit',0,1,0),(9,'f_email',0,1,0),(10,'f_flash',0,1,0),(11,'f_icons',0,1,0),(12,'f_ignoreflood',0,1,0),(13,'f_img',0,1,0),(14,'f_list',0,1,0),(15,'f_noapprove',0,1,0),(16,'f_poll',0,1,0),(17,'f_post',0,1,0),(18,'f_postcount',0,1,0),(19,'f_print',0,1,0),(20,'f_read',0,1,0),(21,'f_reply',0,1,0),(22,'f_report',0,1,0),(23,'f_search',0,1,0),(24,'f_sigs',0,1,0),(25,'f_smilies',0,1,0),(26,'f_sticky',0,1,0),(27,'f_subscribe',0,1,0),(28,'f_user_lock',0,1,0),(29,'f_vote',0,1,0),(30,'f_votechg',0,1,0),(31,'m_',1,1,0),(32,'m_approve',1,1,0),(33,'m_chgposter',1,1,0),(34,'m_delete',1,1,0),(35,'m_edit',1,1,0),(36,'m_info',1,1,0),(37,'m_lock',1,1,0),(38,'m_merge',1,1,0),(39,'m_move',1,1,0),(40,'m_report',1,1,0),(41,'m_split',1,1,0),(42,'m_ban',1,0,0),(43,'m_warn',1,0,0),(44,'a_',1,0,0),(45,'a_aauth',1,0,0),(46,'a_attach',1,0,0),(47,'a_authgroups',1,0,0),(48,'a_authusers',1,0,0),(49,'a_backup',1,0,0),(50,'a_ban',1,0,0),(51,'a_bbcode',1,0,0),(52,'a_board',1,0,0),(53,'a_bots',1,0,0),(54,'a_clearlogs',1,0,0),(55,'a_email',1,0,0),(56,'a_fauth',1,0,0),(57,'a_forum',1,0,0),(58,'a_forumadd',1,0,0),(59,'a_forumdel',1,0,0),(60,'a_group',1,0,0),(61,'a_groupadd',1,0,0),(62,'a_groupdel',1,0,0),(63,'a_icons',1,0,0),(64,'a_jabber',1,0,0),(65,'a_language',1,0,0),(66,'a_mauth',1,0,0),(67,'a_modules',1,0,0),(68,'a_names',1,0,0),(69,'a_phpinfo',1,0,0),(70,'a_profile',1,0,0),(71,'a_prune',1,0,0),(72,'a_ranks',1,0,0),(73,'a_reasons',1,0,0),(74,'a_roles',1,0,0),(75,'a_search',1,0,0),(76,'a_server',1,0,0),(77,'a_styles',1,0,0),(78,'a_switchperm',1,0,0),(79,'a_uauth',1,0,0),(80,'a_user',1,0,0),(81,'a_userdel',1,0,0),(82,'a_viewauth',1,0,0),(83,'a_viewlogs',1,0,0),(84,'a_words',1,0,0),(85,'u_',1,0,0),(86,'u_attach',1,0,0),(87,'u_chgavatar',1,0,0),(88,'u_chgcensors',1,0,0),(89,'u_chgemail',1,0,0),(90,'u_chggrp',1,0,0),(91,'u_chgname',1,0,0),(92,'u_chgpasswd',1,0,0),(93,'u_download',1,0,0),(94,'u_hideonline',1,0,0),(95,'u_ignoreflood',1,0,0),(96,'u_masspm',1,0,0),(97,'u_masspm_group',1,0,0),(98,'u_pm_attach',1,0,0),(99,'u_pm_bbcode',1,0,0),(100,'u_pm_delete',1,0,0),(101,'u_pm_download',1,0,0),(102,'u_pm_edit',1,0,0),(103,'u_pm_emailpm',1,0,0),(104,'u_pm_flash',1,0,0),(105,'u_pm_forward',1,0,0),(106,'u_pm_img',1,0,0),(107,'u_pm_printpm',1,0,0),(108,'u_pm_smilies',1,0,0),(109,'u_readpm',1,0,0),(110,'u_savedrafts',1,0,0),(111,'u_search',1,0,0),(112,'u_sendemail',1,0,0),(113,'u_sendim',1,0,0),(114,'u_sendpm',1,0,0),(115,'u_sig',1,0,0),(116,'u_viewonline',1,0,0),(117,'u_viewprofile',1,0,0);
/*!40000 ALTER TABLE `phpbb_acl_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_acl_roles`
--

DROP TABLE IF EXISTS `phpbb_acl_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_acl_roles` (
  `role_id` mediumint(8) unsigned NOT NULL auto_increment,
  `role_name` varchar(255) collate utf8_bin NOT NULL default '',
  `role_description` text collate utf8_bin NOT NULL,
  `role_type` varchar(10) collate utf8_bin NOT NULL default '',
  `role_order` smallint(4) unsigned NOT NULL default '0',
  PRIMARY KEY  (`role_id`),
  KEY `role_type` (`role_type`),
  KEY `role_order` (`role_order`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_acl_roles`
--

LOCK TABLES `phpbb_acl_roles` WRITE;
/*!40000 ALTER TABLE `phpbb_acl_roles` DISABLE KEYS */;
INSERT INTO `phpbb_acl_roles` VALUES (1,'ROLE_ADMIN_STANDARD','ROLE_DESCRIPTION_ADMIN_STANDARD','a_',1),(2,'ROLE_ADMIN_FORUM','ROLE_DESCRIPTION_ADMIN_FORUM','a_',3),(3,'ROLE_ADMIN_USERGROUP','ROLE_DESCRIPTION_ADMIN_USERGROUP','a_',4),(4,'ROLE_ADMIN_FULL','ROLE_DESCRIPTION_ADMIN_FULL','a_',2),(5,'ROLE_USER_FULL','ROLE_DESCRIPTION_USER_FULL','u_',3),(6,'ROLE_USER_STANDARD','ROLE_DESCRIPTION_USER_STANDARD','u_',1),(7,'ROLE_USER_LIMITED','ROLE_DESCRIPTION_USER_LIMITED','u_',2),(8,'ROLE_USER_NOPM','ROLE_DESCRIPTION_USER_NOPM','u_',4),(9,'ROLE_USER_NOAVATAR','ROLE_DESCRIPTION_USER_NOAVATAR','u_',5),(10,'ROLE_MOD_FULL','ROLE_DESCRIPTION_MOD_FULL','m_',3),(11,'ROLE_MOD_STANDARD','ROLE_DESCRIPTION_MOD_STANDARD','m_',1),(12,'ROLE_MOD_SIMPLE','ROLE_DESCRIPTION_MOD_SIMPLE','m_',2),(13,'ROLE_MOD_QUEUE','ROLE_DESCRIPTION_MOD_QUEUE','m_',4),(14,'ROLE_FORUM_FULL','ROLE_DESCRIPTION_FORUM_FULL','f_',7),(15,'ROLE_FORUM_STANDARD','ROLE_DESCRIPTION_FORUM_STANDARD','f_',5),(16,'ROLE_FORUM_NOACCESS','ROLE_DESCRIPTION_FORUM_NOACCESS','f_',1),(17,'ROLE_FORUM_READONLY','ROLE_DESCRIPTION_FORUM_READONLY','f_',2),(18,'ROLE_FORUM_LIMITED','ROLE_DESCRIPTION_FORUM_LIMITED','f_',3),(19,'ROLE_FORUM_BOT','ROLE_DESCRIPTION_FORUM_BOT','f_',9),(20,'ROLE_FORUM_ONQUEUE','ROLE_DESCRIPTION_FORUM_ONQUEUE','f_',8),(21,'ROLE_FORUM_POLLS','ROLE_DESCRIPTION_FORUM_POLLS','f_',6),(22,'ROLE_FORUM_LIMITED_POLLS','ROLE_DESCRIPTION_FORUM_LIMITED_POLLS','f_',4),(23,'ROLE_USER_NEW_MEMBER','ROLE_DESCRIPTION_USER_NEW_MEMBER','u_',6),(24,'ROLE_FORUM_NEW_MEMBER','ROLE_DESCRIPTION_FORUM_NEW_MEMBER','f_',10);
/*!40000 ALTER TABLE `phpbb_acl_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_acl_roles_data`
--

DROP TABLE IF EXISTS `phpbb_acl_roles_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_acl_roles_data` (
  `role_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_option_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_setting` tinyint(2) NOT NULL default '0',
  PRIMARY KEY  (`role_id`,`auth_option_id`),
  KEY `ath_op_id` (`auth_option_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_acl_roles_data`
--

LOCK TABLES `phpbb_acl_roles_data` WRITE;
/*!40000 ALTER TABLE `phpbb_acl_roles_data` DISABLE KEYS */;
INSERT INTO `phpbb_acl_roles_data` VALUES (1,44,1),(1,46,1),(1,47,1),(1,48,1),(1,50,1),(1,51,1),(1,52,1),(1,56,1),(1,57,1),(1,58,1),(1,59,1),(1,60,1),(1,61,1),(1,62,1),(1,63,1),(1,66,1),(1,68,1),(1,70,1),(1,71,1),(1,72,1),(1,73,1),(1,79,1),(1,80,1),(1,81,1),(1,82,1),(1,83,1),(1,84,1),(2,44,1),(2,47,1),(2,48,1),(2,56,1),(2,57,1),(2,58,1),(2,59,1),(2,66,1),(2,71,1),(2,79,1),(2,82,1),(2,83,1),(3,44,1),(3,47,1),(3,48,1),(3,50,1),(3,60,1),(3,61,1),(3,62,1),(3,72,1),(3,79,1),(3,80,1),(3,82,1),(3,83,1),(4,44,1),(4,45,1),(4,46,1),(4,47,1),(4,48,1),(4,49,1),(4,50,1),(4,51,1),(4,52,1),(4,53,1),(4,54,1),(4,55,1),(4,56,1),(4,57,1),(4,58,1),(4,59,1),(4,60,1),(4,61,1),(4,62,1),(4,63,1),(4,64,1),(4,65,1),(4,66,1),(4,67,1),(4,68,1),(4,69,1),(4,70,1),(4,71,1),(4,72,1),(4,73,1),(4,74,1),(4,75,1),(4,76,1),(4,77,1),(4,78,1),(4,79,1),(4,80,1),(4,81,1),(4,82,1),(4,83,1),(4,84,1),(5,85,1),(5,86,1),(5,87,1),(5,88,1),(5,89,1),(5,90,1),(5,91,1),(5,92,1),(5,93,1),(5,94,1),(5,95,1),(5,96,1),(5,97,1),(5,98,1),(5,99,1),(5,100,1),(5,101,1),(5,102,1),(5,103,1),(5,104,1),(5,105,1),(5,106,1),(5,107,1),(5,108,1),(5,109,1),(5,110,1),(5,111,1),(5,112,1),(5,113,1),(5,114,1),(5,115,1),(5,116,1),(5,117,1),(6,85,1),(6,86,1),(6,87,1),(6,88,1),(6,89,1),(6,92,1),(6,93,1),(6,94,1),(6,96,1),(6,97,1),(6,98,1),(6,99,1),(6,100,1),(6,101,1),(6,102,1),(6,103,1),(6,106,1),(6,107,1),(6,108,1),(6,109,1),(6,110,1),(6,111,1),(6,112,1),(6,113,1),(6,114,1),(6,115,1),(6,117,1),(7,85,1),(7,87,1),(7,88,1),(7,89,1),(7,92,1),(7,93,1),(7,94,1),(7,99,1),(7,100,1),(7,101,1),(7,102,1),(7,105,1),(7,106,1),(7,107,1),(7,108,1),(7,109,1),(7,114,1),(7,115,1),(7,117,1),(8,85,1),(8,87,1),(8,88,1),(8,89,1),(8,92,1),(8,93,1),(8,94,1),(8,115,1),(8,117,1),(8,96,0),(8,97,0),(8,109,0),(8,114,0),(9,85,1),(9,88,1),(9,89,1),(9,92,1),(9,93,1),(9,94,1),(9,99,1),(9,100,1),(9,101,1),(9,102,1),(9,105,1),(9,106,1),(9,107,1),(9,108,1),(9,109,1),(9,114,1),(9,115,1),(9,117,1),(9,87,0),(10,31,1),(10,32,1),(10,42,1),(10,33,1),(10,34,1),(10,35,1),(10,36,1),(10,37,1),(10,38,1),(10,39,1),(10,40,1),(10,41,1),(10,43,1),(11,31,1),(11,32,1),(11,34,1),(11,35,1),(11,36,1),(11,37,1),(11,38,1),(11,39,1),(11,40,1),(11,41,1),(11,43,1),(12,31,1),(12,34,1),(12,35,1),(12,36,1),(12,40,1),(13,31,1),(13,32,1),(13,35,1),(14,1,1),(14,2,1),(14,3,1),(14,4,1),(14,5,1),(14,6,1),(14,7,1),(14,8,1),(14,9,1),(14,10,1),(14,11,1),(14,12,1),(14,13,1),(14,14,1),(14,15,1),(14,16,1),(14,17,1),(14,18,1),(14,19,1),(14,20,1),(14,21,1),(14,22,1),(14,23,1),(14,24,1),(14,25,1),(14,26,1),(14,27,1),(14,28,1),(14,29,1),(14,30,1),(15,1,1),(15,3,1),(15,4,1),(15,5,1),(15,6,1),(15,7,1),(15,8,1),(15,9,1),(15,11,1),(15,13,1),(15,14,1),(15,15,1),(15,17,1),(15,18,1),(15,19,1),(15,20,1),(15,21,1),(15,22,1),(15,23,1),(15,24,1),(15,25,1),(15,27,1),(15,29,1),(15,30,1),(16,1,0),(17,1,1),(17,7,1),(17,14,1),(17,19,1),(17,20,1),(17,23,1),(17,27,1),(18,1,1),(18,4,1),(18,7,1),(18,8,1),(18,9,1),(18,13,1),(18,14,1),(18,15,1),(18,17,1),(18,18,1),(18,19,1),(18,20,1),(18,21,1),(18,22,1),(18,23,1),(18,24,1),(18,25,1),(18,27,1),(18,29,1),(19,1,1),(19,7,1),(19,14,1),(19,19,1),(19,20,1),(20,1,1),(20,3,1),(20,4,1),(20,7,1),(20,8,1),(20,9,1),(20,13,1),(20,14,1),(20,17,1),(20,18,1),(20,19,1),(20,20,1),(20,21,1),(20,22,1),(20,23,1),(20,24,1),(20,25,1),(20,27,1),(20,29,1),(20,15,0),(21,1,1),(21,3,1),(21,4,1),(21,5,1),(21,6,1),(21,7,1),(21,8,1),(21,9,1),(21,11,1),(21,13,1),(21,14,1),(21,15,1),(21,16,1),(21,17,1),(21,18,1),(21,19,1),(21,20,1),(21,21,1),(21,22,1),(21,23,1),(21,24,1),(21,25,1),(21,27,1),(21,29,1),(21,30,1),(22,1,1),(22,4,1),(22,7,1),(22,8,1),(22,9,1),(22,13,1),(22,14,1),(22,15,1),(22,16,1),(22,17,1),(22,18,1),(22,19,1),(22,20,1),(22,21,1),(22,22,1),(22,23,1),(22,24,1),(22,25,1),(22,27,1),(22,29,1),(23,96,0),(23,97,0),(23,114,0),(24,15,0);
/*!40000 ALTER TABLE `phpbb_acl_roles_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_acl_users`
--

DROP TABLE IF EXISTS `phpbb_acl_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_acl_users` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_option_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_role_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_setting` tinyint(2) NOT NULL default '0',
  KEY `user_id` (`user_id`),
  KEY `auth_option_id` (`auth_option_id`),
  KEY `auth_role_id` (`auth_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_acl_users`
--

LOCK TABLES `phpbb_acl_users` WRITE;
/*!40000 ALTER TABLE `phpbb_acl_users` DISABLE KEYS */;
INSERT INTO `phpbb_acl_users` VALUES (2,0,0,5,0);
/*!40000 ALTER TABLE `phpbb_acl_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_attachments`
--

DROP TABLE IF EXISTS `phpbb_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_attachments` (
  `attach_id` mediumint(8) unsigned NOT NULL auto_increment,
  `post_msg_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `in_message` tinyint(1) unsigned NOT NULL default '0',
  `poster_id` mediumint(8) unsigned NOT NULL default '0',
  `is_orphan` tinyint(1) unsigned NOT NULL default '1',
  `physical_filename` varchar(255) collate utf8_bin NOT NULL default '',
  `real_filename` varchar(255) collate utf8_bin NOT NULL default '',
  `download_count` mediumint(8) unsigned NOT NULL default '0',
  `attach_comment` text collate utf8_bin NOT NULL,
  `extension` varchar(100) collate utf8_bin NOT NULL default '',
  `mimetype` varchar(100) collate utf8_bin NOT NULL default '',
  `filesize` int(20) unsigned NOT NULL default '0',
  `filetime` int(11) unsigned NOT NULL default '0',
  `thumbnail` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`attach_id`),
  KEY `filetime` (`filetime`),
  KEY `post_msg_id` (`post_msg_id`),
  KEY `topic_id` (`topic_id`),
  KEY `poster_id` (`poster_id`),
  KEY `is_orphan` (`is_orphan`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_attachments`
--

LOCK TABLES `phpbb_attachments` WRITE;
/*!40000 ALTER TABLE `phpbb_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_banlist`
--

DROP TABLE IF EXISTS `phpbb_banlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_banlist` (
  `ban_id` mediumint(8) unsigned NOT NULL auto_increment,
  `ban_userid` mediumint(8) unsigned NOT NULL default '0',
  `ban_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `ban_email` varchar(100) collate utf8_bin NOT NULL default '',
  `ban_start` int(11) unsigned NOT NULL default '0',
  `ban_end` int(11) unsigned NOT NULL default '0',
  `ban_exclude` tinyint(1) unsigned NOT NULL default '0',
  `ban_reason` varchar(255) collate utf8_bin NOT NULL default '',
  `ban_give_reason` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`ban_id`),
  KEY `ban_end` (`ban_end`),
  KEY `ban_user` (`ban_userid`,`ban_exclude`),
  KEY `ban_email` (`ban_email`,`ban_exclude`),
  KEY `ban_ip` (`ban_ip`,`ban_exclude`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_banlist`
--

LOCK TABLES `phpbb_banlist` WRITE;
/*!40000 ALTER TABLE `phpbb_banlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_banlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_bbcodes`
--

DROP TABLE IF EXISTS `phpbb_bbcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_bbcodes` (
  `bbcode_id` smallint(4) unsigned NOT NULL default '0',
  `bbcode_tag` varchar(16) collate utf8_bin NOT NULL default '',
  `bbcode_helpline` varchar(255) collate utf8_bin NOT NULL default '',
  `display_on_posting` tinyint(1) unsigned NOT NULL default '0',
  `bbcode_match` text collate utf8_bin NOT NULL,
  `bbcode_tpl` mediumtext collate utf8_bin NOT NULL,
  `first_pass_match` mediumtext collate utf8_bin NOT NULL,
  `first_pass_replace` mediumtext collate utf8_bin NOT NULL,
  `second_pass_match` mediumtext collate utf8_bin NOT NULL,
  `second_pass_replace` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`bbcode_id`),
  KEY `display_on_post` (`display_on_posting`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_bbcodes`
--

LOCK TABLES `phpbb_bbcodes` WRITE;
/*!40000 ALTER TABLE `phpbb_bbcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_bbcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_bookmarks`
--

DROP TABLE IF EXISTS `phpbb_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_bookmarks` (
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`topic_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_bookmarks`
--

LOCK TABLES `phpbb_bookmarks` WRITE;
/*!40000 ALTER TABLE `phpbb_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_bots`
--

DROP TABLE IF EXISTS `phpbb_bots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_bots` (
  `bot_id` mediumint(8) unsigned NOT NULL auto_increment,
  `bot_active` tinyint(1) unsigned NOT NULL default '1',
  `bot_name` varchar(255) collate utf8_bin NOT NULL default '',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `bot_agent` varchar(255) collate utf8_bin NOT NULL default '',
  `bot_ip` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`bot_id`),
  KEY `bot_active` (`bot_active`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_bots`
--

LOCK TABLES `phpbb_bots` WRITE;
/*!40000 ALTER TABLE `phpbb_bots` DISABLE KEYS */;
INSERT INTO `phpbb_bots` VALUES (1,1,'AdsBot [Google]',3,'AdsBot-Google',''),(2,1,'Alexa [Bot]',4,'ia_archiver',''),(3,1,'Alta Vista [Bot]',5,'Scooter/',''),(4,1,'Ask Jeeves [Bot]',6,'Ask Jeeves',''),(5,1,'Baidu [Spider]',7,'Baiduspider+(',''),(6,1,'Bing [Bot]',8,'bingbot/',''),(7,1,'Exabot [Bot]',9,'Exabot/',''),(8,1,'FAST Enterprise [Crawler]',10,'FAST Enterprise Crawler',''),(9,1,'FAST WebCrawler [Crawler]',11,'FAST-WebCrawler/',''),(10,1,'Francis [Bot]',12,'http://www.neomo.de/',''),(11,1,'Gigabot [Bot]',13,'Gigabot/',''),(12,1,'Google Adsense [Bot]',14,'Mediapartners-Google',''),(13,1,'Google Desktop',15,'Google Desktop',''),(14,1,'Google Feedfetcher',16,'Feedfetcher-Google',''),(15,1,'Google [Bot]',17,'Googlebot',''),(16,1,'Heise IT-Markt [Crawler]',18,'heise-IT-Markt-Crawler',''),(17,1,'Heritrix [Crawler]',19,'heritrix/1.',''),(18,1,'IBM Research [Bot]',20,'ibm.com/cs/crawler',''),(19,1,'ICCrawler - ICjobs',21,'ICCrawler - ICjobs',''),(20,1,'ichiro [Crawler]',22,'ichiro/',''),(21,1,'Majestic-12 [Bot]',23,'MJ12bot/',''),(22,1,'Metager [Bot]',24,'MetagerBot/',''),(23,1,'MSN NewsBlogs',25,'msnbot-NewsBlogs/',''),(24,1,'MSN [Bot]',26,'msnbot/',''),(25,1,'MSNbot Media',27,'msnbot-media/',''),(26,1,'NG-Search [Bot]',28,'NG-Search/',''),(27,1,'Nutch [Bot]',29,'http://lucene.apache.org/nutch/',''),(28,1,'Nutch/CVS [Bot]',30,'NutchCVS/',''),(29,1,'OmniExplorer [Bot]',31,'OmniExplorer_Bot/',''),(30,1,'Online link [Validator]',32,'online link validator',''),(31,1,'psbot [Picsearch]',33,'psbot/0',''),(32,1,'Seekport [Bot]',34,'Seekbot/',''),(33,1,'Sensis [Crawler]',35,'Sensis Web Crawler',''),(34,1,'SEO Crawler',36,'SEO search Crawler/',''),(35,1,'Seoma [Crawler]',37,'Seoma [SEO Crawler]',''),(36,1,'SEOSearch [Crawler]',38,'SEOsearch/',''),(37,1,'Snappy [Bot]',39,'Snappy/1.1 ( http://www.urltrends.com/ )',''),(38,1,'Steeler [Crawler]',40,'http://www.tkl.iis.u-tokyo.ac.jp/~crawler/',''),(39,1,'Synoo [Bot]',41,'SynooBot/',''),(40,1,'Telekom [Bot]',42,'crawleradmin.t-info@telekom.de',''),(41,1,'TurnitinBot [Bot]',43,'TurnitinBot/',''),(42,1,'Voyager [Bot]',44,'voyager/1.0',''),(43,1,'W3 [Sitesearch]',45,'W3 SiteSearch Crawler',''),(44,1,'W3C [Linkcheck]',46,'W3C-checklink/',''),(45,1,'W3C [Validator]',47,'W3C_*Validator',''),(46,1,'WiseNut [Bot]',48,'http://www.WISEnutbot.com',''),(47,1,'YaCy [Bot]',49,'yacybot',''),(48,1,'Yahoo MMCrawler [Bot]',50,'Yahoo-MMCrawler/',''),(49,1,'Yahoo Slurp [Bot]',51,'Yahoo! DE Slurp',''),(50,1,'Yahoo [Bot]',52,'Yahoo! Slurp',''),(51,1,'YahooSeeker [Bot]',53,'YahooSeeker/','');
/*!40000 ALTER TABLE `phpbb_bots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_config`
--

DROP TABLE IF EXISTS `phpbb_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_config` (
  `config_name` varchar(255) collate utf8_bin NOT NULL default '',
  `config_value` varchar(255) collate utf8_bin NOT NULL default '',
  `is_dynamic` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`config_name`),
  KEY `is_dynamic` (`is_dynamic`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_config`
--

LOCK TABLES `phpbb_config` WRITE;
/*!40000 ALTER TABLE `phpbb_config` DISABLE KEYS */;
INSERT INTO `phpbb_config` VALUES ('active_sessions','0',0),('allow_attachments','1',0),('allow_autologin','1',0),('allow_avatar','0',0),('allow_avatar_local','0',0),('allow_avatar_remote','0',0),('allow_avatar_upload','0',0),('allow_avatar_remote_upload','0',0),('allow_bbcode','1',0),('allow_birthdays','1',0),('allow_bookmarks','1',0),('allow_emailreuse','0',0),('allow_forum_notify','1',0),('allow_mass_pm','1',0),('allow_name_chars','USERNAME_CHARS_ANY',0),('allow_namechange','0',0),('allow_nocensors','0',0),('allow_pm_attach','0',0),('allow_pm_report','1',0),('allow_post_flash','1',0),('allow_post_links','1',0),('allow_privmsg','1',0),('allow_quick_reply','1',0),('allow_sig','1',0),('allow_sig_bbcode','1',0),('allow_sig_flash','0',0),('allow_sig_img','1',0),('allow_sig_links','1',0),('allow_sig_pm','1',0),('allow_sig_smilies','1',0),('allow_smilies','1',0),('allow_topic_notify','1',0),('attachment_quota','52428800',0),('auth_bbcode_pm','1',0),('auth_flash_pm','0',0),('auth_img_pm','1',0),('auth_method','db',0),('auth_smilies_pm','1',0),('avatar_filesize','6144',0),('avatar_gallery_path','images/avatars/gallery',0),('avatar_max_height','90',0),('avatar_max_width','90',0),('avatar_min_height','20',0),('avatar_min_width','20',0),('avatar_path','images/avatars/upload',0),('avatar_salt','fb856d87dcfd2b0dae0c6a47c4fbec7d',0),('board_contact','sergep@2kgroup.com',0),('board_disable','0',0),('board_disable_msg','',0),('board_dst','0',0),('board_email','sergep@2kgroup.com',0),('board_email_form','0',0),('board_email_sig','Thanks, The Management',0),('board_hide_emails','1',0),('board_timezone','0',0),('browser_check','1',0),('bump_interval','10',0),('bump_type','d',0),('cache_gc','7200',0),('captcha_plugin','phpbb_captcha_gd',0),('captcha_gd','1',0),('captcha_gd_foreground_noise','0',0),('captcha_gd_x_grid','25',0),('captcha_gd_y_grid','25',0),('captcha_gd_wave','0',0),('captcha_gd_3d_noise','1',0),('captcha_gd_fonts','1',0),('confirm_refresh','1',0),('check_attachment_content','1',0),('check_dnsbl','0',0),('chg_passforce','0',0),('cookie_domain','opros.tns-ua.com',0),('cookie_name','phpbb3_s2ngk',0),('cookie_path','/',0),('cookie_secure','0',0),('coppa_enable','0',0),('coppa_fax','',0),('coppa_mail','',0),('database_gc','604800',0),('dbms_version','5.0.88',0),('default_dateformat','D M d, Y g:i a',0),('default_style','1',0),('display_last_edited','1',0),('display_order','0',0),('edit_time','0',0),('delete_time','0',0),('email_check_mx','1',0),('email_enable','1',0),('email_function_name','mail',0),('email_max_chunk_size','50',0),('email_package_size','20',0),('enable_confirm','1',0),('enable_pm_icons','1',0),('enable_post_confirm','1',0),('feed_enable','0',0),('feed_http_auth','0',0),('feed_limit_post','15',0),('feed_limit_topic','10',0),('feed_overall_forums','0',0),('feed_overall','1',0),('feed_forum','1',0),('feed_topic','1',0),('feed_topics_new','1',0),('feed_topics_active','0',0),('feed_item_statistics','1',0),('flood_interval','15',0),('force_server_vars','0',0),('form_token_lifetime','7200',0),('form_token_mintime','0',0),('form_token_sid_guests','1',0),('forward_pm','1',0),('forwarded_for_check','0',0),('full_folder_action','2',0),('fulltext_mysql_max_word_len','254',0),('fulltext_mysql_min_word_len','4',0),('fulltext_native_common_thres','5',0),('fulltext_native_load_upd','1',0),('fulltext_native_max_chars','14',0),('fulltext_native_min_chars','3',0),('gzip_compress','0',0),('hot_threshold','25',0),('icons_path','images/icons',0),('img_create_thumbnail','0',0),('img_display_inlined','1',0),('img_imagick','',0),('img_link_height','0',0),('img_link_width','0',0),('img_max_height','0',0),('img_max_thumb_width','400',0),('img_max_width','0',0),('img_min_thumb_filesize','12000',0),('ip_check','3',0),('ip_login_limit_max','50',0),('ip_login_limit_time','21600',0),('ip_login_limit_use_forwarded','0',0),('jab_enable','0',0),('jab_host','',0),('jab_password','',0),('jab_package_size','20',0),('jab_port','5222',0),('jab_use_ssl','0',0),('jab_username','',0),('ldap_base_dn','',0),('ldap_email','',0),('ldap_password','',0),('ldap_port','',0),('ldap_server','',0),('ldap_uid','',0),('ldap_user','',0),('ldap_user_filter','',0),('limit_load','0',0),('limit_search_load','0',0),('load_anon_lastread','0',0),('load_birthdays','1',0),('load_cpf_memberlist','0',0),('load_cpf_viewprofile','1',0),('load_cpf_viewtopic','0',0),('load_db_lastread','1',0),('load_db_track','1',0),('load_jumpbox','1',0),('load_moderators','1',0),('load_online','1',0),('load_online_guests','1',0),('load_online_time','5',0),('load_onlinetrack','1',0),('load_search','1',0),('load_tplcompile','0',0),('load_unreads_search','1',0),('load_user_activity','1',0),('max_attachments','3',0),('max_attachments_pm','1',0),('max_autologin_time','0',0),('max_filesize','262144',0),('max_filesize_pm','262144',0),('max_login_attempts','3',0),('max_name_chars','20',0),('max_num_search_keywords','10',0),('max_pass_chars','100',0),('max_poll_options','10',0),('max_post_chars','60000',0),('max_post_font_size','200',0),('max_post_img_height','0',0),('max_post_img_width','0',0),('max_post_smilies','0',0),('max_post_urls','0',0),('max_quote_depth','3',0),('max_reg_attempts','5',0),('max_sig_chars','255',0),('max_sig_font_size','200',0),('max_sig_img_height','0',0),('max_sig_img_width','0',0),('max_sig_smilies','0',0),('max_sig_urls','5',0),('min_name_chars','3',0),('min_pass_chars','6',0),('min_post_chars','1',0),('min_search_author_chars','3',0),('mime_triggers','body|head|html|img|plaintext|a href|pre|script|table|title',0),('new_member_post_limit','3',0),('new_member_group_default','0',0),('override_user_style','0',0),('pass_complex','PASS_TYPE_ANY',0),('pm_edit_time','0',0),('pm_max_boxes','4',0),('pm_max_msgs','50',0),('pm_max_recipients','0',0),('posts_per_page','10',0),('print_pm','1',0),('queue_interval','60',0),('ranks_path','images/ranks',0),('require_activation','0',0),('referer_validation','1',0),('script_path','/forum',0),('search_block_size','250',0),('search_gc','7200',0),('search_interval','0',0),('search_anonymous_interval','0',0),('search_type','fulltext_native',0),('search_store_results','1800',0),('secure_allow_deny','1',0),('secure_allow_empty_referer','1',0),('secure_downloads','0',0),('server_name','opros.tns-ua.com',0),('server_port','80',0),('server_protocol','http://',0),('session_gc','3600',0),('session_length','3600',0),('site_desc','A short text to describe your forum',0),('sitename','yourdomain.com',0),('smilies_path','images/smilies',0),('smilies_per_page','50',0),('smtp_auth_method','PLAIN',0),('smtp_delivery','0',0),('smtp_host','',0),('smtp_password','',0),('smtp_port','25',0),('smtp_username','',0),('topics_per_page','25',0),('tpl_allow_php','0',0),('upload_icons_path','images/upload_icons',0),('upload_path','files',0),('version','3.0.10',0),('warnings_expire_days','90',0),('warnings_gc','14400',0),('cache_last_gc','1327494745',1),('cron_lock','0',1),('database_last_gc','1326745772',1),('last_queue_run','0',1),('newest_user_colour','AA0000',1),('newest_user_id','2',1),('newest_username','sergep',1),('num_files','0',1),('num_posts','1',1),('num_topics','1',1),('num_users','1',1),('rand_seed','f7dd42ba3adff074504fec9a6fd53982',1),('rand_seed_last_update','1327494745',1),('record_online_date','1326326331',1),('record_online_users','1',1),('search_indexing_state','',1),('search_last_gc','1326745783',1),('session_last_gc','1326745809',1),('upload_dir_size','0',1),('warnings_last_gc','1326744732',1),('board_startdate','1326326102',0),('default_lang','en',0),('questionnaire_unique_id','924c8ce7af053b43',0);
/*!40000 ALTER TABLE `phpbb_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_confirm`
--

DROP TABLE IF EXISTS `phpbb_confirm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_confirm` (
  `confirm_id` char(32) collate utf8_bin NOT NULL default '',
  `session_id` char(32) collate utf8_bin NOT NULL default '',
  `confirm_type` tinyint(3) NOT NULL default '0',
  `code` varchar(8) collate utf8_bin NOT NULL default '',
  `seed` int(10) unsigned NOT NULL default '0',
  `attempts` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`session_id`,`confirm_id`),
  KEY `confirm_type` (`confirm_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_confirm`
--

LOCK TABLES `phpbb_confirm` WRITE;
/*!40000 ALTER TABLE `phpbb_confirm` DISABLE KEYS */;
INSERT INTO `phpbb_confirm` VALUES ('50029f3adb1cc7ed23be9f4e267e5a39','211c8ea0da379807e66c66f9415c795f',2,'5WZYGLY',664607345,1),('4ac885f97d9d6ac70566e7344d2a8580','211c8ea0da379807e66c66f9415c795f',2,'R2JV6A',1446626008,1),('ffe573d258528000f13f7338f76ab9e4','211c8ea0da379807e66c66f9415c795f',2,'5XT3P3S',1678405882,1),('cdf9b422518bc7c181f78b94cc7272fd','211c8ea0da379807e66c66f9415c795f',2,'5JAD9ZY',1987099387,1),('549833b4dbd35c42362c595dbaa3cddf','211c8ea0da379807e66c66f9415c795f',2,'27K2U',599964789,0);
/*!40000 ALTER TABLE `phpbb_confirm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_disallow`
--

DROP TABLE IF EXISTS `phpbb_disallow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_disallow` (
  `disallow_id` mediumint(8) unsigned NOT NULL auto_increment,
  `disallow_username` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`disallow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_disallow`
--

LOCK TABLES `phpbb_disallow` WRITE;
/*!40000 ALTER TABLE `phpbb_disallow` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_disallow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_drafts`
--

DROP TABLE IF EXISTS `phpbb_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_drafts` (
  `draft_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `save_time` int(11) unsigned NOT NULL default '0',
  `draft_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `draft_message` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`draft_id`),
  KEY `save_time` (`save_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_drafts`
--

LOCK TABLES `phpbb_drafts` WRITE;
/*!40000 ALTER TABLE `phpbb_drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_extension_groups`
--

DROP TABLE IF EXISTS `phpbb_extension_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_extension_groups` (
  `group_id` mediumint(8) unsigned NOT NULL auto_increment,
  `group_name` varchar(255) collate utf8_bin NOT NULL default '',
  `cat_id` tinyint(2) NOT NULL default '0',
  `allow_group` tinyint(1) unsigned NOT NULL default '0',
  `download_mode` tinyint(1) unsigned NOT NULL default '1',
  `upload_icon` varchar(255) collate utf8_bin NOT NULL default '',
  `max_filesize` int(20) unsigned NOT NULL default '0',
  `allowed_forums` text collate utf8_bin NOT NULL,
  `allow_in_pm` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_extension_groups`
--

LOCK TABLES `phpbb_extension_groups` WRITE;
/*!40000 ALTER TABLE `phpbb_extension_groups` DISABLE KEYS */;
INSERT INTO `phpbb_extension_groups` VALUES (1,'IMAGES',1,1,1,'',0,'',0),(2,'ARCHIVES',0,1,1,'',0,'',0),(3,'PLAIN_TEXT',0,0,1,'',0,'',0),(4,'DOCUMENTS',0,0,1,'',0,'',0),(5,'REAL_MEDIA',3,0,1,'',0,'',0),(6,'WINDOWS_MEDIA',2,0,1,'',0,'',0),(7,'FLASH_FILES',5,0,1,'',0,'',0),(8,'QUICKTIME_MEDIA',6,0,1,'',0,'',0),(9,'DOWNLOADABLE_FILES',0,0,1,'',0,'',0);
/*!40000 ALTER TABLE `phpbb_extension_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_extensions`
--

DROP TABLE IF EXISTS `phpbb_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_extensions` (
  `extension_id` mediumint(8) unsigned NOT NULL auto_increment,
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `extension` varchar(100) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`extension_id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_extensions`
--

LOCK TABLES `phpbb_extensions` WRITE;
/*!40000 ALTER TABLE `phpbb_extensions` DISABLE KEYS */;
INSERT INTO `phpbb_extensions` VALUES (1,1,'gif'),(2,1,'png'),(3,1,'jpeg'),(4,1,'jpg'),(5,1,'tif'),(6,1,'tiff'),(7,1,'tga'),(8,2,'gtar'),(9,2,'gz'),(10,2,'tar'),(11,2,'zip'),(12,2,'rar'),(13,2,'ace'),(14,2,'torrent'),(15,2,'tgz'),(16,2,'bz2'),(17,2,'7z'),(18,3,'txt'),(19,3,'c'),(20,3,'h'),(21,3,'cpp'),(22,3,'hpp'),(23,3,'diz'),(24,3,'csv'),(25,3,'ini'),(26,3,'log'),(27,3,'js'),(28,3,'xml'),(29,4,'xls'),(30,4,'xlsx'),(31,4,'xlsm'),(32,4,'xlsb'),(33,4,'doc'),(34,4,'docx'),(35,4,'docm'),(36,4,'dot'),(37,4,'dotx'),(38,4,'dotm'),(39,4,'pdf'),(40,4,'ai'),(41,4,'ps'),(42,4,'ppt'),(43,4,'pptx'),(44,4,'pptm'),(45,4,'odg'),(46,4,'odp'),(47,4,'ods'),(48,4,'odt'),(49,4,'rtf'),(50,5,'rm'),(51,5,'ram'),(52,6,'wma'),(53,6,'wmv'),(54,7,'swf'),(55,8,'mov'),(56,8,'m4v'),(57,8,'m4a'),(58,8,'mp4'),(59,8,'3gp'),(60,8,'3g2'),(61,8,'qt'),(62,9,'mpeg'),(63,9,'mpg'),(64,9,'mp3'),(65,9,'ogg'),(66,9,'ogm');
/*!40000 ALTER TABLE `phpbb_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_forums`
--

DROP TABLE IF EXISTS `phpbb_forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_forums` (
  `forum_id` mediumint(8) unsigned NOT NULL auto_increment,
  `parent_id` mediumint(8) unsigned NOT NULL default '0',
  `left_id` mediumint(8) unsigned NOT NULL default '0',
  `right_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_parents` mediumtext collate utf8_bin NOT NULL,
  `forum_name` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_desc` text collate utf8_bin NOT NULL,
  `forum_desc_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_desc_options` int(11) unsigned NOT NULL default '7',
  `forum_desc_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `forum_link` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_password` varchar(40) collate utf8_bin NOT NULL default '',
  `forum_style` mediumint(8) unsigned NOT NULL default '0',
  `forum_image` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_rules` text collate utf8_bin NOT NULL,
  `forum_rules_link` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_rules_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_rules_options` int(11) unsigned NOT NULL default '7',
  `forum_rules_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `forum_topics_per_page` tinyint(4) NOT NULL default '0',
  `forum_type` tinyint(4) NOT NULL default '0',
  `forum_status` tinyint(4) NOT NULL default '0',
  `forum_posts` mediumint(8) unsigned NOT NULL default '0',
  `forum_topics` mediumint(8) unsigned NOT NULL default '0',
  `forum_topics_real` mediumint(8) unsigned NOT NULL default '0',
  `forum_last_post_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_last_poster_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_last_post_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_last_post_time` int(11) unsigned NOT NULL default '0',
  `forum_last_poster_name` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_last_poster_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `forum_flags` tinyint(4) NOT NULL default '32',
  `forum_options` int(20) unsigned NOT NULL default '0',
  `display_subforum_list` tinyint(1) unsigned NOT NULL default '1',
  `display_on_index` tinyint(1) unsigned NOT NULL default '1',
  `enable_indexing` tinyint(1) unsigned NOT NULL default '1',
  `enable_icons` tinyint(1) unsigned NOT NULL default '1',
  `enable_prune` tinyint(1) unsigned NOT NULL default '0',
  `prune_next` int(11) unsigned NOT NULL default '0',
  `prune_days` mediumint(8) unsigned NOT NULL default '0',
  `prune_viewed` mediumint(8) unsigned NOT NULL default '0',
  `prune_freq` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`forum_id`),
  KEY `left_right_id` (`left_id`,`right_id`),
  KEY `forum_lastpost_id` (`forum_last_post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_forums`
--

LOCK TABLES `phpbb_forums` WRITE;
/*!40000 ALTER TABLE `phpbb_forums` DISABLE KEYS */;
INSERT INTO `phpbb_forums` VALUES (1,0,1,4,'','Your first category','','',7,'','','',0,'','','','',7,'',0,0,0,1,1,1,1,2,'',1326326102,'sergep','AA0000',32,0,1,1,1,1,0,0,0,0,0),(2,1,2,3,'','Your first forum','Description of your first forum.','',7,'','','',0,'','','','',7,'',0,1,0,1,1,1,1,2,'Welcome to phpBB3',1326326102,'sergep','AA0000',48,0,1,1,1,1,0,0,0,0,0);
/*!40000 ALTER TABLE `phpbb_forums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_forums_access`
--

DROP TABLE IF EXISTS `phpbb_forums_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_forums_access` (
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `session_id` char(32) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`forum_id`,`user_id`,`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_forums_access`
--

LOCK TABLES `phpbb_forums_access` WRITE;
/*!40000 ALTER TABLE `phpbb_forums_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_forums_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_forums_track`
--

DROP TABLE IF EXISTS `phpbb_forums_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_forums_track` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `mark_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_forums_track`
--

LOCK TABLES `phpbb_forums_track` WRITE;
/*!40000 ALTER TABLE `phpbb_forums_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_forums_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_forums_watch`
--

DROP TABLE IF EXISTS `phpbb_forums_watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_forums_watch` (
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `notify_status` tinyint(1) unsigned NOT NULL default '0',
  KEY `forum_id` (`forum_id`),
  KEY `user_id` (`user_id`),
  KEY `notify_stat` (`notify_status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_forums_watch`
--

LOCK TABLES `phpbb_forums_watch` WRITE;
/*!40000 ALTER TABLE `phpbb_forums_watch` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_forums_watch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_groups`
--

DROP TABLE IF EXISTS `phpbb_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_groups` (
  `group_id` mediumint(8) unsigned NOT NULL auto_increment,
  `group_type` tinyint(4) NOT NULL default '1',
  `group_founder_manage` tinyint(1) unsigned NOT NULL default '0',
  `group_skip_auth` tinyint(1) unsigned NOT NULL default '0',
  `group_name` varchar(255) collate utf8_bin NOT NULL default '',
  `group_desc` text collate utf8_bin NOT NULL,
  `group_desc_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `group_desc_options` int(11) unsigned NOT NULL default '7',
  `group_desc_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `group_display` tinyint(1) unsigned NOT NULL default '0',
  `group_avatar` varchar(255) collate utf8_bin NOT NULL default '',
  `group_avatar_type` tinyint(2) NOT NULL default '0',
  `group_avatar_width` smallint(4) unsigned NOT NULL default '0',
  `group_avatar_height` smallint(4) unsigned NOT NULL default '0',
  `group_rank` mediumint(8) unsigned NOT NULL default '0',
  `group_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `group_sig_chars` mediumint(8) unsigned NOT NULL default '0',
  `group_receive_pm` tinyint(1) unsigned NOT NULL default '0',
  `group_message_limit` mediumint(8) unsigned NOT NULL default '0',
  `group_max_recipients` mediumint(8) unsigned NOT NULL default '0',
  `group_legend` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`group_id`),
  KEY `group_legend_name` (`group_legend`,`group_name`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_groups`
--

LOCK TABLES `phpbb_groups` WRITE;
/*!40000 ALTER TABLE `phpbb_groups` DISABLE KEYS */;
INSERT INTO `phpbb_groups` VALUES (1,3,0,0,'GUESTS','','',7,'',0,'',0,0,0,0,'',0,0,0,5,0),(2,3,0,0,'REGISTERED','','',7,'',0,'',0,0,0,0,'',0,0,0,5,0),(3,3,0,0,'REGISTERED_COPPA','','',7,'',0,'',0,0,0,0,'',0,0,0,5,0),(4,3,0,0,'GLOBAL_MODERATORS','','',7,'',0,'',0,0,0,0,'00AA00',0,0,0,0,1),(5,3,1,0,'ADMINISTRATORS','','',7,'',0,'',0,0,0,0,'AA0000',0,0,0,0,1),(6,3,0,0,'BOTS','','',7,'',0,'',0,0,0,0,'9E8DA7',0,0,0,5,0),(7,3,0,0,'NEWLY_REGISTERED','','',7,'',0,'',0,0,0,0,'',0,0,0,5,0);
/*!40000 ALTER TABLE `phpbb_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_icons`
--

DROP TABLE IF EXISTS `phpbb_icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_icons` (
  `icons_id` mediumint(8) unsigned NOT NULL auto_increment,
  `icons_url` varchar(255) collate utf8_bin NOT NULL default '',
  `icons_width` tinyint(4) NOT NULL default '0',
  `icons_height` tinyint(4) NOT NULL default '0',
  `icons_order` mediumint(8) unsigned NOT NULL default '0',
  `display_on_posting` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`icons_id`),
  KEY `display_on_posting` (`display_on_posting`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_icons`
--

LOCK TABLES `phpbb_icons` WRITE;
/*!40000 ALTER TABLE `phpbb_icons` DISABLE KEYS */;
INSERT INTO `phpbb_icons` VALUES (1,'misc/fire.gif',16,16,1,1),(2,'smile/redface.gif',16,16,9,1),(3,'smile/mrgreen.gif',16,16,10,1),(4,'misc/heart.gif',16,16,4,1),(5,'misc/star.gif',16,16,2,1),(6,'misc/radioactive.gif',16,16,3,1),(7,'misc/thinking.gif',16,16,5,1),(8,'smile/info.gif',16,16,8,1),(9,'smile/question.gif',16,16,6,1),(10,'smile/alert.gif',16,16,7,1);
/*!40000 ALTER TABLE `phpbb_icons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_lang`
--

DROP TABLE IF EXISTS `phpbb_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_lang` (
  `lang_id` tinyint(4) NOT NULL auto_increment,
  `lang_iso` varchar(30) collate utf8_bin NOT NULL default '',
  `lang_dir` varchar(30) collate utf8_bin NOT NULL default '',
  `lang_english_name` varchar(100) collate utf8_bin NOT NULL default '',
  `lang_local_name` varchar(255) collate utf8_bin NOT NULL default '',
  `lang_author` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`lang_id`),
  KEY `lang_iso` (`lang_iso`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_lang`
--

LOCK TABLES `phpbb_lang` WRITE;
/*!40000 ALTER TABLE `phpbb_lang` DISABLE KEYS */;
INSERT INTO `phpbb_lang` VALUES (1,'en','en','British English','British English','phpBB Group');
/*!40000 ALTER TABLE `phpbb_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_log`
--

DROP TABLE IF EXISTS `phpbb_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_log` (
  `log_id` mediumint(8) unsigned NOT NULL auto_increment,
  `log_type` tinyint(4) NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `reportee_id` mediumint(8) unsigned NOT NULL default '0',
  `log_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `log_time` int(11) unsigned NOT NULL default '0',
  `log_operation` text collate utf8_bin NOT NULL,
  `log_data` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`log_id`),
  KEY `log_type` (`log_type`),
  KEY `forum_id` (`forum_id`),
  KEY `topic_id` (`topic_id`),
  KEY `reportee_id` (`reportee_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_log`
--

LOCK TABLES `phpbb_log` WRITE;
/*!40000 ALTER TABLE `phpbb_log` DISABLE KEYS */;
INSERT INTO `phpbb_log` VALUES (1,0,2,0,0,0,'89.252.56.204',1326326112,'LOG_INSTALL_INSTALLED','a:1:{i:0;s:6:\"3.0.10\";}'),(2,3,1,0,0,2,'89.252.56.204',1326746089,'LOG_USER_NEW_PASSWORD','a:1:{i:0;s:6:\"sergep\";}'),(3,3,2,0,0,2,'89.252.56.204',1326746771,'LOG_USER_NEW_PASSWORD','a:1:{i:0;s:6:\"sergep\";}');
/*!40000 ALTER TABLE `phpbb_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_login_attempts`
--

DROP TABLE IF EXISTS `phpbb_login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_login_attempts` (
  `attempt_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `attempt_browser` varchar(150) collate utf8_bin NOT NULL default '',
  `attempt_forwarded_for` varchar(255) collate utf8_bin NOT NULL default '',
  `attempt_time` int(11) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `username` varchar(255) collate utf8_bin NOT NULL default '0',
  `username_clean` varchar(255) collate utf8_bin NOT NULL default '0',
  KEY `att_ip` (`attempt_ip`,`attempt_time`),
  KEY `att_for` (`attempt_forwarded_for`,`attempt_time`),
  KEY `att_time` (`attempt_time`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_login_attempts`
--

LOCK TABLES `phpbb_login_attempts` WRITE;
/*!40000 ALTER TABLE `phpbb_login_attempts` DISABLE KEYS */;
INSERT INTO `phpbb_login_attempts` VALUES ('89.252.56.204','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','',1326744744,0,'wewe','wewe'),('89.252.56.204','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','',1326744750,0,'wewe','wewe'),('89.252.56.204','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','',1326744753,0,'wewe','wewe'),('89.252.56.204','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','',1326744875,0,'wewe','wewe');
/*!40000 ALTER TABLE `phpbb_login_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_moderator_cache`
--

DROP TABLE IF EXISTS `phpbb_moderator_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_moderator_cache` (
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `username` varchar(255) collate utf8_bin NOT NULL default '',
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `group_name` varchar(255) collate utf8_bin NOT NULL default '',
  `display_on_index` tinyint(1) unsigned NOT NULL default '1',
  KEY `disp_idx` (`display_on_index`),
  KEY `forum_id` (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_moderator_cache`
--

LOCK TABLES `phpbb_moderator_cache` WRITE;
/*!40000 ALTER TABLE `phpbb_moderator_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_moderator_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_modules`
--

DROP TABLE IF EXISTS `phpbb_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_modules` (
  `module_id` mediumint(8) unsigned NOT NULL auto_increment,
  `module_enabled` tinyint(1) unsigned NOT NULL default '1',
  `module_display` tinyint(1) unsigned NOT NULL default '1',
  `module_basename` varchar(255) collate utf8_bin NOT NULL default '',
  `module_class` varchar(10) collate utf8_bin NOT NULL default '',
  `parent_id` mediumint(8) unsigned NOT NULL default '0',
  `left_id` mediumint(8) unsigned NOT NULL default '0',
  `right_id` mediumint(8) unsigned NOT NULL default '0',
  `module_langname` varchar(255) collate utf8_bin NOT NULL default '',
  `module_mode` varchar(255) collate utf8_bin NOT NULL default '',
  `module_auth` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`module_id`),
  KEY `left_right_id` (`left_id`,`right_id`),
  KEY `module_enabled` (`module_enabled`),
  KEY `class_left_id` (`module_class`,`left_id`)
) ENGINE=MyISAM AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_modules`
--

LOCK TABLES `phpbb_modules` WRITE;
/*!40000 ALTER TABLE `phpbb_modules` DISABLE KEYS */;
INSERT INTO `phpbb_modules` VALUES (1,1,1,'','acp',0,1,64,'ACP_CAT_GENERAL','',''),(2,1,1,'','acp',1,4,17,'ACP_QUICK_ACCESS','',''),(3,1,1,'','acp',1,18,41,'ACP_BOARD_CONFIGURATION','',''),(4,1,1,'','acp',1,42,49,'ACP_CLIENT_COMMUNICATION','',''),(5,1,1,'','acp',1,50,63,'ACP_SERVER_CONFIGURATION','',''),(6,1,1,'','acp',0,65,84,'ACP_CAT_FORUMS','',''),(7,1,1,'','acp',6,66,71,'ACP_MANAGE_FORUMS','',''),(8,1,1,'','acp',6,72,83,'ACP_FORUM_BASED_PERMISSIONS','',''),(9,1,1,'','acp',0,85,110,'ACP_CAT_POSTING','',''),(10,1,1,'','acp',9,86,99,'ACP_MESSAGES','',''),(11,1,1,'','acp',9,100,109,'ACP_ATTACHMENTS','',''),(12,1,1,'','acp',0,111,166,'ACP_CAT_USERGROUP','',''),(13,1,1,'','acp',12,112,145,'ACP_CAT_USERS','',''),(14,1,1,'','acp',12,146,153,'ACP_GROUPS','',''),(15,1,1,'','acp',12,154,165,'ACP_USER_SECURITY','',''),(16,1,1,'','acp',0,167,216,'ACP_CAT_PERMISSIONS','',''),(17,1,1,'','acp',16,170,179,'ACP_GLOBAL_PERMISSIONS','',''),(18,1,1,'','acp',16,180,191,'ACP_FORUM_BASED_PERMISSIONS','',''),(19,1,1,'','acp',16,192,201,'ACP_PERMISSION_ROLES','',''),(20,1,1,'','acp',16,202,215,'ACP_PERMISSION_MASKS','',''),(21,1,1,'','acp',0,217,230,'ACP_CAT_STYLES','',''),(22,1,1,'','acp',21,218,221,'ACP_STYLE_MANAGEMENT','',''),(23,1,1,'','acp',21,222,229,'ACP_STYLE_COMPONENTS','',''),(24,1,1,'','acp',0,231,250,'ACP_CAT_MAINTENANCE','',''),(25,1,1,'','acp',24,232,241,'ACP_FORUM_LOGS','',''),(26,1,1,'','acp',24,242,249,'ACP_CAT_DATABASE','',''),(27,1,1,'','acp',0,251,276,'ACP_CAT_SYSTEM','',''),(28,1,1,'','acp',27,252,255,'ACP_AUTOMATION','',''),(29,1,1,'','acp',27,256,267,'ACP_GENERAL_TASKS','',''),(30,1,1,'','acp',27,268,275,'ACP_MODULE_MANAGEMENT','',''),(31,1,1,'','acp',0,277,278,'ACP_CAT_DOT_MODS','',''),(32,1,1,'attachments','acp',3,19,20,'ACP_ATTACHMENT_SETTINGS','attach','acl_a_attach'),(33,1,1,'attachments','acp',11,101,102,'ACP_ATTACHMENT_SETTINGS','attach','acl_a_attach'),(34,1,1,'attachments','acp',11,103,104,'ACP_MANAGE_EXTENSIONS','extensions','acl_a_attach'),(35,1,1,'attachments','acp',11,105,106,'ACP_EXTENSION_GROUPS','ext_groups','acl_a_attach'),(36,1,1,'attachments','acp',11,107,108,'ACP_ORPHAN_ATTACHMENTS','orphan','acl_a_attach'),(37,1,1,'ban','acp',15,155,156,'ACP_BAN_EMAILS','email','acl_a_ban'),(38,1,1,'ban','acp',15,157,158,'ACP_BAN_IPS','ip','acl_a_ban'),(39,1,1,'ban','acp',15,159,160,'ACP_BAN_USERNAMES','user','acl_a_ban'),(40,1,1,'bbcodes','acp',10,87,88,'ACP_BBCODES','bbcodes','acl_a_bbcode'),(41,1,1,'board','acp',3,21,22,'ACP_BOARD_SETTINGS','settings','acl_a_board'),(42,1,1,'board','acp',3,23,24,'ACP_BOARD_FEATURES','features','acl_a_board'),(43,1,1,'board','acp',3,25,26,'ACP_AVATAR_SETTINGS','avatar','acl_a_board'),(44,1,1,'board','acp',3,27,28,'ACP_MESSAGE_SETTINGS','message','acl_a_board'),(45,1,1,'board','acp',10,89,90,'ACP_MESSAGE_SETTINGS','message','acl_a_board'),(46,1,1,'board','acp',3,29,30,'ACP_POST_SETTINGS','post','acl_a_board'),(47,1,1,'board','acp',10,91,92,'ACP_POST_SETTINGS','post','acl_a_board'),(48,1,1,'board','acp',3,31,32,'ACP_SIGNATURE_SETTINGS','signature','acl_a_board'),(49,1,1,'board','acp',3,33,34,'ACP_FEED_SETTINGS','feed','acl_a_board'),(50,1,1,'board','acp',3,35,36,'ACP_REGISTER_SETTINGS','registration','acl_a_board'),(51,1,1,'board','acp',4,43,44,'ACP_AUTH_SETTINGS','auth','acl_a_server'),(52,1,1,'board','acp',4,45,46,'ACP_EMAIL_SETTINGS','email','acl_a_server'),(53,1,1,'board','acp',5,51,52,'ACP_COOKIE_SETTINGS','cookie','acl_a_server'),(54,1,1,'board','acp',5,53,54,'ACP_SERVER_SETTINGS','server','acl_a_server'),(55,1,1,'board','acp',5,55,56,'ACP_SECURITY_SETTINGS','security','acl_a_server'),(56,1,1,'board','acp',5,57,58,'ACP_LOAD_SETTINGS','load','acl_a_server'),(57,1,1,'bots','acp',29,257,258,'ACP_BOTS','bots','acl_a_bots'),(58,1,1,'captcha','acp',3,37,38,'ACP_VC_SETTINGS','visual','acl_a_board'),(59,1,0,'captcha','acp',3,39,40,'ACP_VC_CAPTCHA_DISPLAY','img','acl_a_board'),(60,1,1,'database','acp',26,243,244,'ACP_BACKUP','backup','acl_a_backup'),(61,1,1,'database','acp',26,245,246,'ACP_RESTORE','restore','acl_a_backup'),(62,1,1,'disallow','acp',15,161,162,'ACP_DISALLOW_USERNAMES','usernames','acl_a_names'),(63,1,1,'email','acp',29,259,260,'ACP_MASS_EMAIL','email','acl_a_email && cfg_email_enable'),(64,1,1,'forums','acp',7,67,68,'ACP_MANAGE_FORUMS','manage','acl_a_forum'),(65,1,1,'groups','acp',14,147,148,'ACP_GROUPS_MANAGE','manage','acl_a_group'),(66,1,1,'icons','acp',10,93,94,'ACP_ICONS','icons','acl_a_icons'),(67,1,1,'icons','acp',10,95,96,'ACP_SMILIES','smilies','acl_a_icons'),(68,1,1,'inactive','acp',13,115,116,'ACP_INACTIVE_USERS','list','acl_a_user'),(69,1,1,'jabber','acp',4,47,48,'ACP_JABBER_SETTINGS','settings','acl_a_jabber'),(70,1,1,'language','acp',29,261,262,'ACP_LANGUAGE_PACKS','lang_packs','acl_a_language'),(71,1,1,'logs','acp',25,233,234,'ACP_ADMIN_LOGS','admin','acl_a_viewlogs'),(72,1,1,'logs','acp',25,235,236,'ACP_MOD_LOGS','mod','acl_a_viewlogs'),(73,1,1,'logs','acp',25,237,238,'ACP_USERS_LOGS','users','acl_a_viewlogs'),(74,1,1,'logs','acp',25,239,240,'ACP_CRITICAL_LOGS','critical','acl_a_viewlogs'),(75,1,1,'main','acp',1,2,3,'ACP_INDEX','main',''),(76,1,1,'modules','acp',30,269,270,'ACP','acp','acl_a_modules'),(77,1,1,'modules','acp',30,271,272,'UCP','ucp','acl_a_modules'),(78,1,1,'modules','acp',30,273,274,'MCP','mcp','acl_a_modules'),(79,1,1,'permission_roles','acp',19,193,194,'ACP_ADMIN_ROLES','admin_roles','acl_a_roles && acl_a_aauth'),(80,1,1,'permission_roles','acp',19,195,196,'ACP_USER_ROLES','user_roles','acl_a_roles && acl_a_uauth'),(81,1,1,'permission_roles','acp',19,197,198,'ACP_MOD_ROLES','mod_roles','acl_a_roles && acl_a_mauth'),(82,1,1,'permission_roles','acp',19,199,200,'ACP_FORUM_ROLES','forum_roles','acl_a_roles && acl_a_fauth'),(83,1,1,'permissions','acp',16,168,169,'ACP_PERMISSIONS','intro','acl_a_authusers || acl_a_authgroups || acl_a_viewauth'),(84,1,0,'permissions','acp',20,203,204,'ACP_PERMISSION_TRACE','trace','acl_a_viewauth'),(85,1,1,'permissions','acp',18,181,182,'ACP_FORUM_PERMISSIONS','setting_forum_local','acl_a_fauth && (acl_a_authusers || acl_a_authgroups)'),(86,1,1,'permissions','acp',18,183,184,'ACP_FORUM_PERMISSIONS_COPY','setting_forum_copy','acl_a_fauth && acl_a_authusers && acl_a_authgroups && acl_a_mauth'),(87,1,1,'permissions','acp',18,185,186,'ACP_FORUM_MODERATORS','setting_mod_local','acl_a_mauth && (acl_a_authusers || acl_a_authgroups)'),(88,1,1,'permissions','acp',17,171,172,'ACP_USERS_PERMISSIONS','setting_user_global','acl_a_authusers && (acl_a_aauth || acl_a_mauth || acl_a_uauth)'),(89,1,1,'permissions','acp',13,117,118,'ACP_USERS_PERMISSIONS','setting_user_global','acl_a_authusers && (acl_a_aauth || acl_a_mauth || acl_a_uauth)'),(90,1,1,'permissions','acp',18,187,188,'ACP_USERS_FORUM_PERMISSIONS','setting_user_local','acl_a_authusers && (acl_a_mauth || acl_a_fauth)'),(91,1,1,'permissions','acp',13,119,120,'ACP_USERS_FORUM_PERMISSIONS','setting_user_local','acl_a_authusers && (acl_a_mauth || acl_a_fauth)'),(92,1,1,'permissions','acp',17,173,174,'ACP_GROUPS_PERMISSIONS','setting_group_global','acl_a_authgroups && (acl_a_aauth || acl_a_mauth || acl_a_uauth)'),(93,1,1,'permissions','acp',14,149,150,'ACP_GROUPS_PERMISSIONS','setting_group_global','acl_a_authgroups && (acl_a_aauth || acl_a_mauth || acl_a_uauth)'),(94,1,1,'permissions','acp',18,189,190,'ACP_GROUPS_FORUM_PERMISSIONS','setting_group_local','acl_a_authgroups && (acl_a_mauth || acl_a_fauth)'),(95,1,1,'permissions','acp',14,151,152,'ACP_GROUPS_FORUM_PERMISSIONS','setting_group_local','acl_a_authgroups && (acl_a_mauth || acl_a_fauth)'),(96,1,1,'permissions','acp',17,175,176,'ACP_ADMINISTRATORS','setting_admin_global','acl_a_aauth && (acl_a_authusers || acl_a_authgroups)'),(97,1,1,'permissions','acp',17,177,178,'ACP_GLOBAL_MODERATORS','setting_mod_global','acl_a_mauth && (acl_a_authusers || acl_a_authgroups)'),(98,1,1,'permissions','acp',20,205,206,'ACP_VIEW_ADMIN_PERMISSIONS','view_admin_global','acl_a_viewauth'),(99,1,1,'permissions','acp',20,207,208,'ACP_VIEW_USER_PERMISSIONS','view_user_global','acl_a_viewauth'),(100,1,1,'permissions','acp',20,209,210,'ACP_VIEW_GLOBAL_MOD_PERMISSIONS','view_mod_global','acl_a_viewauth'),(101,1,1,'permissions','acp',20,211,212,'ACP_VIEW_FORUM_MOD_PERMISSIONS','view_mod_local','acl_a_viewauth'),(102,1,1,'permissions','acp',20,213,214,'ACP_VIEW_FORUM_PERMISSIONS','view_forum_local','acl_a_viewauth'),(103,1,1,'php_info','acp',29,263,264,'ACP_PHP_INFO','info','acl_a_phpinfo'),(104,1,1,'profile','acp',13,121,122,'ACP_CUSTOM_PROFILE_FIELDS','profile','acl_a_profile'),(105,1,1,'prune','acp',7,69,70,'ACP_PRUNE_FORUMS','forums','acl_a_prune'),(106,1,1,'prune','acp',15,163,164,'ACP_PRUNE_USERS','users','acl_a_userdel'),(107,1,1,'ranks','acp',13,123,124,'ACP_MANAGE_RANKS','ranks','acl_a_ranks'),(108,1,1,'reasons','acp',29,265,266,'ACP_MANAGE_REASONS','main','acl_a_reasons'),(109,1,1,'search','acp',5,59,60,'ACP_SEARCH_SETTINGS','settings','acl_a_search'),(110,1,1,'search','acp',26,247,248,'ACP_SEARCH_INDEX','index','acl_a_search'),(111,1,1,'send_statistics','acp',5,61,62,'ACP_SEND_STATISTICS','send_statistics','acl_a_server'),(112,1,1,'styles','acp',22,219,220,'ACP_STYLES','style','acl_a_styles'),(113,1,1,'styles','acp',23,223,224,'ACP_TEMPLATES','template','acl_a_styles'),(114,1,1,'styles','acp',23,225,226,'ACP_THEMES','theme','acl_a_styles'),(115,1,1,'styles','acp',23,227,228,'ACP_IMAGESETS','imageset','acl_a_styles'),(116,1,1,'update','acp',28,253,254,'ACP_VERSION_CHECK','version_check','acl_a_board'),(117,1,1,'users','acp',13,113,114,'ACP_MANAGE_USERS','overview','acl_a_user'),(118,1,0,'users','acp',13,125,126,'ACP_USER_FEEDBACK','feedback','acl_a_user'),(119,1,0,'users','acp',13,127,128,'ACP_USER_WARNINGS','warnings','acl_a_user'),(120,1,0,'users','acp',13,129,130,'ACP_USER_PROFILE','profile','acl_a_user'),(121,1,0,'users','acp',13,131,132,'ACP_USER_PREFS','prefs','acl_a_user'),(122,1,0,'users','acp',13,133,134,'ACP_USER_AVATAR','avatar','acl_a_user'),(123,1,0,'users','acp',13,135,136,'ACP_USER_RANK','rank','acl_a_user'),(124,1,0,'users','acp',13,137,138,'ACP_USER_SIG','sig','acl_a_user'),(125,1,0,'users','acp',13,139,140,'ACP_USER_GROUPS','groups','acl_a_user && acl_a_group'),(126,1,0,'users','acp',13,141,142,'ACP_USER_PERM','perm','acl_a_user && acl_a_viewauth'),(127,1,0,'users','acp',13,143,144,'ACP_USER_ATTACH','attach','acl_a_user'),(128,1,1,'words','acp',10,97,98,'ACP_WORDS','words','acl_a_words'),(129,1,1,'users','acp',2,5,6,'ACP_MANAGE_USERS','overview','acl_a_user'),(130,1,1,'groups','acp',2,7,8,'ACP_GROUPS_MANAGE','manage','acl_a_group'),(131,1,1,'forums','acp',2,9,10,'ACP_MANAGE_FORUMS','manage','acl_a_forum'),(132,1,1,'logs','acp',2,11,12,'ACP_MOD_LOGS','mod','acl_a_viewlogs'),(133,1,1,'bots','acp',2,13,14,'ACP_BOTS','bots','acl_a_bots'),(134,1,1,'php_info','acp',2,15,16,'ACP_PHP_INFO','info','acl_a_phpinfo'),(135,1,1,'permissions','acp',8,73,74,'ACP_FORUM_PERMISSIONS','setting_forum_local','acl_a_fauth && (acl_a_authusers || acl_a_authgroups)'),(136,1,1,'permissions','acp',8,75,76,'ACP_FORUM_PERMISSIONS_COPY','setting_forum_copy','acl_a_fauth && acl_a_authusers && acl_a_authgroups && acl_a_mauth'),(137,1,1,'permissions','acp',8,77,78,'ACP_FORUM_MODERATORS','setting_mod_local','acl_a_mauth && (acl_a_authusers || acl_a_authgroups)'),(138,1,1,'permissions','acp',8,79,80,'ACP_USERS_FORUM_PERMISSIONS','setting_user_local','acl_a_authusers && (acl_a_mauth || acl_a_fauth)'),(139,1,1,'permissions','acp',8,81,82,'ACP_GROUPS_FORUM_PERMISSIONS','setting_group_local','acl_a_authgroups && (acl_a_mauth || acl_a_fauth)'),(140,1,1,'','mcp',0,1,10,'MCP_MAIN','',''),(141,1,1,'','mcp',0,11,18,'MCP_QUEUE','',''),(142,1,1,'','mcp',0,19,32,'MCP_REPORTS','',''),(143,1,1,'','mcp',0,33,38,'MCP_NOTES','',''),(144,1,1,'','mcp',0,39,48,'MCP_WARN','',''),(145,1,1,'','mcp',0,49,56,'MCP_LOGS','',''),(146,1,1,'','mcp',0,57,64,'MCP_BAN','',''),(147,1,1,'ban','mcp',146,58,59,'MCP_BAN_USERNAMES','user','acl_m_ban'),(148,1,1,'ban','mcp',146,60,61,'MCP_BAN_IPS','ip','acl_m_ban'),(149,1,1,'ban','mcp',146,62,63,'MCP_BAN_EMAILS','email','acl_m_ban'),(150,1,1,'logs','mcp',145,50,51,'MCP_LOGS_FRONT','front','acl_m_ || aclf_m_'),(151,1,1,'logs','mcp',145,52,53,'MCP_LOGS_FORUM_VIEW','forum_logs','acl_m_,$id'),(152,1,1,'logs','mcp',145,54,55,'MCP_LOGS_TOPIC_VIEW','topic_logs','acl_m_,$id'),(153,1,1,'main','mcp',140,2,3,'MCP_MAIN_FRONT','front',''),(154,1,1,'main','mcp',140,4,5,'MCP_MAIN_FORUM_VIEW','forum_view','acl_m_,$id'),(155,1,1,'main','mcp',140,6,7,'MCP_MAIN_TOPIC_VIEW','topic_view','acl_m_,$id'),(156,1,1,'main','mcp',140,8,9,'MCP_MAIN_POST_DETAILS','post_details','acl_m_,$id || (!$id && aclf_m_)'),(157,1,1,'notes','mcp',143,34,35,'MCP_NOTES_FRONT','front',''),(158,1,1,'notes','mcp',143,36,37,'MCP_NOTES_USER','user_notes',''),(159,1,1,'pm_reports','mcp',142,20,21,'MCP_PM_REPORTS_OPEN','pm_reports','aclf_m_report'),(160,1,1,'pm_reports','mcp',142,22,23,'MCP_PM_REPORTS_CLOSED','pm_reports_closed','aclf_m_report'),(161,1,1,'pm_reports','mcp',142,24,25,'MCP_PM_REPORT_DETAILS','pm_report_details','aclf_m_report'),(162,1,1,'queue','mcp',141,12,13,'MCP_QUEUE_UNAPPROVED_TOPICS','unapproved_topics','aclf_m_approve'),(163,1,1,'queue','mcp',141,14,15,'MCP_QUEUE_UNAPPROVED_POSTS','unapproved_posts','aclf_m_approve'),(164,1,1,'queue','mcp',141,16,17,'MCP_QUEUE_APPROVE_DETAILS','approve_details','acl_m_approve,$id || (!$id && aclf_m_approve)'),(165,1,1,'reports','mcp',142,26,27,'MCP_REPORTS_OPEN','reports','aclf_m_report'),(166,1,1,'reports','mcp',142,28,29,'MCP_REPORTS_CLOSED','reports_closed','aclf_m_report'),(167,1,1,'reports','mcp',142,30,31,'MCP_REPORT_DETAILS','report_details','acl_m_report,$id || (!$id && aclf_m_report)'),(168,1,1,'warn','mcp',144,40,41,'MCP_WARN_FRONT','front','aclf_m_warn'),(169,1,1,'warn','mcp',144,42,43,'MCP_WARN_LIST','list','aclf_m_warn'),(170,1,1,'warn','mcp',144,44,45,'MCP_WARN_USER','warn_user','aclf_m_warn'),(171,1,1,'warn','mcp',144,46,47,'MCP_WARN_POST','warn_post','acl_m_warn && acl_f_read,$id'),(172,1,1,'','ucp',0,1,12,'UCP_MAIN','',''),(173,1,1,'','ucp',0,13,22,'UCP_PROFILE','',''),(174,1,1,'','ucp',0,23,30,'UCP_PREFS','',''),(175,1,1,'','ucp',0,31,42,'UCP_PM','',''),(176,1,1,'','ucp',0,43,48,'UCP_USERGROUPS','',''),(177,1,1,'','ucp',0,49,54,'UCP_ZEBRA','',''),(178,1,1,'attachments','ucp',172,10,11,'UCP_MAIN_ATTACHMENTS','attachments','acl_u_attach'),(179,1,1,'groups','ucp',176,44,45,'UCP_USERGROUPS_MEMBER','membership',''),(180,1,1,'groups','ucp',176,46,47,'UCP_USERGROUPS_MANAGE','manage',''),(181,1,1,'main','ucp',172,2,3,'UCP_MAIN_FRONT','front',''),(182,1,1,'main','ucp',172,4,5,'UCP_MAIN_SUBSCRIBED','subscribed',''),(183,1,1,'main','ucp',172,6,7,'UCP_MAIN_BOOKMARKS','bookmarks','cfg_allow_bookmarks'),(184,1,1,'main','ucp',172,8,9,'UCP_MAIN_DRAFTS','drafts',''),(185,1,0,'pm','ucp',175,32,33,'UCP_PM_VIEW','view','cfg_allow_privmsg'),(186,1,1,'pm','ucp',175,34,35,'UCP_PM_COMPOSE','compose','cfg_allow_privmsg'),(187,1,1,'pm','ucp',175,36,37,'UCP_PM_DRAFTS','drafts','cfg_allow_privmsg'),(188,1,1,'pm','ucp',175,38,39,'UCP_PM_OPTIONS','options','cfg_allow_privmsg'),(189,1,0,'pm','ucp',175,40,41,'UCP_PM_POPUP_TITLE','popup','cfg_allow_privmsg'),(190,1,1,'prefs','ucp',174,24,25,'UCP_PREFS_PERSONAL','personal',''),(191,1,1,'prefs','ucp',174,26,27,'UCP_PREFS_POST','post',''),(192,1,1,'prefs','ucp',174,28,29,'UCP_PREFS_VIEW','view',''),(193,1,1,'profile','ucp',173,14,15,'UCP_PROFILE_PROFILE_INFO','profile_info',''),(194,1,1,'profile','ucp',173,16,17,'UCP_PROFILE_SIGNATURE','signature',''),(195,1,1,'profile','ucp',173,18,19,'UCP_PROFILE_AVATAR','avatar','cfg_allow_avatar && (cfg_allow_avatar_local || cfg_allow_avatar_remote || cfg_allow_avatar_upload || cfg_allow_avatar_remote_upload)'),(196,1,1,'profile','ucp',173,20,21,'UCP_PROFILE_REG_DETAILS','reg_details',''),(197,1,1,'zebra','ucp',177,50,51,'UCP_ZEBRA_FRIENDS','friends',''),(198,1,1,'zebra','ucp',177,52,53,'UCP_ZEBRA_FOES','foes','');
/*!40000 ALTER TABLE `phpbb_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_poll_options`
--

DROP TABLE IF EXISTS `phpbb_poll_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_poll_options` (
  `poll_option_id` tinyint(4) NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `poll_option_text` text collate utf8_bin NOT NULL,
  `poll_option_total` mediumint(8) unsigned NOT NULL default '0',
  KEY `poll_opt_id` (`poll_option_id`),
  KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_poll_options`
--

LOCK TABLES `phpbb_poll_options` WRITE;
/*!40000 ALTER TABLE `phpbb_poll_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_poll_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_poll_votes`
--

DROP TABLE IF EXISTS `phpbb_poll_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_poll_votes` (
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `poll_option_id` tinyint(4) NOT NULL default '0',
  `vote_user_id` mediumint(8) unsigned NOT NULL default '0',
  `vote_user_ip` varchar(40) collate utf8_bin NOT NULL default '',
  KEY `topic_id` (`topic_id`),
  KEY `vote_user_id` (`vote_user_id`),
  KEY `vote_user_ip` (`vote_user_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_poll_votes`
--

LOCK TABLES `phpbb_poll_votes` WRITE;
/*!40000 ALTER TABLE `phpbb_poll_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_poll_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_posts`
--

DROP TABLE IF EXISTS `phpbb_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_posts` (
  `post_id` mediumint(8) unsigned NOT NULL auto_increment,
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `poster_id` mediumint(8) unsigned NOT NULL default '0',
  `icon_id` mediumint(8) unsigned NOT NULL default '0',
  `poster_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `post_time` int(11) unsigned NOT NULL default '0',
  `post_approved` tinyint(1) unsigned NOT NULL default '1',
  `post_reported` tinyint(1) unsigned NOT NULL default '0',
  `enable_bbcode` tinyint(1) unsigned NOT NULL default '1',
  `enable_smilies` tinyint(1) unsigned NOT NULL default '1',
  `enable_magic_url` tinyint(1) unsigned NOT NULL default '1',
  `enable_sig` tinyint(1) unsigned NOT NULL default '1',
  `post_username` varchar(255) collate utf8_bin NOT NULL default '',
  `post_subject` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL default '',
  `post_text` mediumtext collate utf8_bin NOT NULL,
  `post_checksum` varchar(32) collate utf8_bin NOT NULL default '',
  `post_attachment` tinyint(1) unsigned NOT NULL default '0',
  `bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `bbcode_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `post_postcount` tinyint(1) unsigned NOT NULL default '1',
  `post_edit_time` int(11) unsigned NOT NULL default '0',
  `post_edit_reason` varchar(255) collate utf8_bin NOT NULL default '',
  `post_edit_user` mediumint(8) unsigned NOT NULL default '0',
  `post_edit_count` smallint(4) unsigned NOT NULL default '0',
  `post_edit_locked` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`post_id`),
  KEY `forum_id` (`forum_id`),
  KEY `topic_id` (`topic_id`),
  KEY `poster_ip` (`poster_ip`),
  KEY `poster_id` (`poster_id`),
  KEY `post_approved` (`post_approved`),
  KEY `post_username` (`post_username`),
  KEY `tid_post_time` (`topic_id`,`post_time`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_posts`
--

LOCK TABLES `phpbb_posts` WRITE;
/*!40000 ALTER TABLE `phpbb_posts` DISABLE KEYS */;
INSERT INTO `phpbb_posts` VALUES (1,1,2,2,0,'89.252.56.204',1326326102,1,0,1,1,1,1,'','Welcome to phpBB3','This is an example post in your phpBB3 installation. Everything seems to be working. You may delete this post if you like and continue to set up your board. During the installation process your first category and your first forum are assigned an appropriate set of permissions for the predefined usergroups administrators, bots, global moderators, guests, registered users and registered COPPA users. If you also choose to delete your first category and your first forum, do not forget to assign permissions for all these usergroups for all new categories and forums you create. It is recommended to rename your first category and your first forum and copy permissions from these while creating new categories and forums. Have fun!','5dd683b17f641daf84c040bfefc58ce9',0,'','',1,0,'',0,0,0);
/*!40000 ALTER TABLE `phpbb_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_privmsgs`
--

DROP TABLE IF EXISTS `phpbb_privmsgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_privmsgs` (
  `msg_id` mediumint(8) unsigned NOT NULL auto_increment,
  `root_level` mediumint(8) unsigned NOT NULL default '0',
  `author_id` mediumint(8) unsigned NOT NULL default '0',
  `icon_id` mediumint(8) unsigned NOT NULL default '0',
  `author_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `message_time` int(11) unsigned NOT NULL default '0',
  `enable_bbcode` tinyint(1) unsigned NOT NULL default '1',
  `enable_smilies` tinyint(1) unsigned NOT NULL default '1',
  `enable_magic_url` tinyint(1) unsigned NOT NULL default '1',
  `enable_sig` tinyint(1) unsigned NOT NULL default '1',
  `message_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `message_text` mediumtext collate utf8_bin NOT NULL,
  `message_edit_reason` varchar(255) collate utf8_bin NOT NULL default '',
  `message_edit_user` mediumint(8) unsigned NOT NULL default '0',
  `message_attachment` tinyint(1) unsigned NOT NULL default '0',
  `bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `bbcode_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `message_edit_time` int(11) unsigned NOT NULL default '0',
  `message_edit_count` smallint(4) unsigned NOT NULL default '0',
  `to_address` text collate utf8_bin NOT NULL,
  `bcc_address` text collate utf8_bin NOT NULL,
  `message_reported` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`msg_id`),
  KEY `author_ip` (`author_ip`),
  KEY `message_time` (`message_time`),
  KEY `author_id` (`author_id`),
  KEY `root_level` (`root_level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_privmsgs`
--

LOCK TABLES `phpbb_privmsgs` WRITE;
/*!40000 ALTER TABLE `phpbb_privmsgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_privmsgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_privmsgs_folder`
--

DROP TABLE IF EXISTS `phpbb_privmsgs_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_privmsgs_folder` (
  `folder_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `folder_name` varchar(255) collate utf8_bin NOT NULL default '',
  `pm_count` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`folder_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_privmsgs_folder`
--

LOCK TABLES `phpbb_privmsgs_folder` WRITE;
/*!40000 ALTER TABLE `phpbb_privmsgs_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_privmsgs_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_privmsgs_rules`
--

DROP TABLE IF EXISTS `phpbb_privmsgs_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_privmsgs_rules` (
  `rule_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `rule_check` mediumint(8) unsigned NOT NULL default '0',
  `rule_connection` mediumint(8) unsigned NOT NULL default '0',
  `rule_string` varchar(255) collate utf8_bin NOT NULL default '',
  `rule_user_id` mediumint(8) unsigned NOT NULL default '0',
  `rule_group_id` mediumint(8) unsigned NOT NULL default '0',
  `rule_action` mediumint(8) unsigned NOT NULL default '0',
  `rule_folder_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`rule_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_privmsgs_rules`
--

LOCK TABLES `phpbb_privmsgs_rules` WRITE;
/*!40000 ALTER TABLE `phpbb_privmsgs_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_privmsgs_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_privmsgs_to`
--

DROP TABLE IF EXISTS `phpbb_privmsgs_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_privmsgs_to` (
  `msg_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `author_id` mediumint(8) unsigned NOT NULL default '0',
  `pm_deleted` tinyint(1) unsigned NOT NULL default '0',
  `pm_new` tinyint(1) unsigned NOT NULL default '1',
  `pm_unread` tinyint(1) unsigned NOT NULL default '1',
  `pm_replied` tinyint(1) unsigned NOT NULL default '0',
  `pm_marked` tinyint(1) unsigned NOT NULL default '0',
  `pm_forwarded` tinyint(1) unsigned NOT NULL default '0',
  `folder_id` int(11) NOT NULL default '0',
  KEY `msg_id` (`msg_id`),
  KEY `author_id` (`author_id`),
  KEY `usr_flder_id` (`user_id`,`folder_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_privmsgs_to`
--

LOCK TABLES `phpbb_privmsgs_to` WRITE;
/*!40000 ALTER TABLE `phpbb_privmsgs_to` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_privmsgs_to` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_profile_fields`
--

DROP TABLE IF EXISTS `phpbb_profile_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_profile_fields` (
  `field_id` mediumint(8) unsigned NOT NULL auto_increment,
  `field_name` varchar(255) collate utf8_bin NOT NULL default '',
  `field_type` tinyint(4) NOT NULL default '0',
  `field_ident` varchar(20) collate utf8_bin NOT NULL default '',
  `field_length` varchar(20) collate utf8_bin NOT NULL default '',
  `field_minlen` varchar(255) collate utf8_bin NOT NULL default '',
  `field_maxlen` varchar(255) collate utf8_bin NOT NULL default '',
  `field_novalue` varchar(255) collate utf8_bin NOT NULL default '',
  `field_default_value` varchar(255) collate utf8_bin NOT NULL default '',
  `field_validation` varchar(20) collate utf8_bin NOT NULL default '',
  `field_required` tinyint(1) unsigned NOT NULL default '0',
  `field_show_on_reg` tinyint(1) unsigned NOT NULL default '0',
  `field_show_on_vt` tinyint(1) unsigned NOT NULL default '0',
  `field_show_profile` tinyint(1) unsigned NOT NULL default '0',
  `field_hide` tinyint(1) unsigned NOT NULL default '0',
  `field_no_view` tinyint(1) unsigned NOT NULL default '0',
  `field_active` tinyint(1) unsigned NOT NULL default '0',
  `field_order` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`field_id`),
  KEY `fld_type` (`field_type`),
  KEY `fld_ordr` (`field_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_profile_fields`
--

LOCK TABLES `phpbb_profile_fields` WRITE;
/*!40000 ALTER TABLE `phpbb_profile_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_profile_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_profile_fields_data`
--

DROP TABLE IF EXISTS `phpbb_profile_fields_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_profile_fields_data` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_profile_fields_data`
--

LOCK TABLES `phpbb_profile_fields_data` WRITE;
/*!40000 ALTER TABLE `phpbb_profile_fields_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_profile_fields_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_profile_fields_lang`
--

DROP TABLE IF EXISTS `phpbb_profile_fields_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_profile_fields_lang` (
  `field_id` mediumint(8) unsigned NOT NULL default '0',
  `lang_id` mediumint(8) unsigned NOT NULL default '0',
  `option_id` mediumint(8) unsigned NOT NULL default '0',
  `field_type` tinyint(4) NOT NULL default '0',
  `lang_value` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`field_id`,`lang_id`,`option_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_profile_fields_lang`
--

LOCK TABLES `phpbb_profile_fields_lang` WRITE;
/*!40000 ALTER TABLE `phpbb_profile_fields_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_profile_fields_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_profile_lang`
--

DROP TABLE IF EXISTS `phpbb_profile_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_profile_lang` (
  `field_id` mediumint(8) unsigned NOT NULL default '0',
  `lang_id` mediumint(8) unsigned NOT NULL default '0',
  `lang_name` varchar(255) collate utf8_bin NOT NULL default '',
  `lang_explain` text collate utf8_bin NOT NULL,
  `lang_default_value` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`field_id`,`lang_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_profile_lang`
--

LOCK TABLES `phpbb_profile_lang` WRITE;
/*!40000 ALTER TABLE `phpbb_profile_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_profile_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_ranks`
--

DROP TABLE IF EXISTS `phpbb_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_ranks` (
  `rank_id` mediumint(8) unsigned NOT NULL auto_increment,
  `rank_title` varchar(255) collate utf8_bin NOT NULL default '',
  `rank_min` mediumint(8) unsigned NOT NULL default '0',
  `rank_special` tinyint(1) unsigned NOT NULL default '0',
  `rank_image` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`rank_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_ranks`
--

LOCK TABLES `phpbb_ranks` WRITE;
/*!40000 ALTER TABLE `phpbb_ranks` DISABLE KEYS */;
INSERT INTO `phpbb_ranks` VALUES (1,'Site Admin',0,1,'');
/*!40000 ALTER TABLE `phpbb_ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_reports`
--

DROP TABLE IF EXISTS `phpbb_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_reports` (
  `report_id` mediumint(8) unsigned NOT NULL auto_increment,
  `reason_id` smallint(4) unsigned NOT NULL default '0',
  `post_id` mediumint(8) unsigned NOT NULL default '0',
  `pm_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `user_notify` tinyint(1) unsigned NOT NULL default '0',
  `report_closed` tinyint(1) unsigned NOT NULL default '0',
  `report_time` int(11) unsigned NOT NULL default '0',
  `report_text` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`report_id`),
  KEY `post_id` (`post_id`),
  KEY `pm_id` (`pm_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_reports`
--

LOCK TABLES `phpbb_reports` WRITE;
/*!40000 ALTER TABLE `phpbb_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_reports_reasons`
--

DROP TABLE IF EXISTS `phpbb_reports_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_reports_reasons` (
  `reason_id` smallint(4) unsigned NOT NULL auto_increment,
  `reason_title` varchar(255) collate utf8_bin NOT NULL default '',
  `reason_description` mediumtext collate utf8_bin NOT NULL,
  `reason_order` smallint(4) unsigned NOT NULL default '0',
  PRIMARY KEY  (`reason_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_reports_reasons`
--

LOCK TABLES `phpbb_reports_reasons` WRITE;
/*!40000 ALTER TABLE `phpbb_reports_reasons` DISABLE KEYS */;
INSERT INTO `phpbb_reports_reasons` VALUES (1,'warez','The post contains links to illegal or pirated software.',1),(2,'spam','The reported post has the only purpose to advertise for a website or another product.',2),(3,'off_topic','The reported post is off topic.',3),(4,'other','The reported post does not fit into any other category, please use the further information field.',4);
/*!40000 ALTER TABLE `phpbb_reports_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_search_results`
--

DROP TABLE IF EXISTS `phpbb_search_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_search_results` (
  `search_key` varchar(32) collate utf8_bin NOT NULL default '',
  `search_time` int(11) unsigned NOT NULL default '0',
  `search_keywords` mediumtext collate utf8_bin NOT NULL,
  `search_authors` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`search_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_search_results`
--

LOCK TABLES `phpbb_search_results` WRITE;
/*!40000 ALTER TABLE `phpbb_search_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_search_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_search_wordlist`
--

DROP TABLE IF EXISTS `phpbb_search_wordlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_search_wordlist` (
  `word_id` mediumint(8) unsigned NOT NULL auto_increment,
  `word_text` varchar(255) collate utf8_bin NOT NULL default '',
  `word_common` tinyint(1) unsigned NOT NULL default '0',
  `word_count` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`word_id`),
  UNIQUE KEY `wrd_txt` (`word_text`),
  KEY `wrd_cnt` (`word_count`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_search_wordlist`
--

LOCK TABLES `phpbb_search_wordlist` WRITE;
/*!40000 ALTER TABLE `phpbb_search_wordlist` DISABLE KEYS */;
INSERT INTO `phpbb_search_wordlist` VALUES (1,'this',0,1),(2,'example',0,1),(3,'post',0,1),(4,'your',0,1),(5,'phpbb3',0,2),(6,'installation',0,1),(7,'everything',0,1),(8,'seems',0,1),(9,'working',0,1),(10,'you',0,1),(11,'may',0,1),(12,'delete',0,1),(13,'like',0,1),(14,'and',0,1),(15,'continue',0,1),(16,'set',0,1),(17,'board',0,1),(18,'during',0,1),(19,'the',0,1),(20,'process',0,1),(21,'first',0,1),(22,'category',0,1),(23,'forum',0,1),(24,'are',0,1),(25,'assigned',0,1),(26,'appropriate',0,1),(27,'permissions',0,1),(28,'for',0,1),(29,'predefined',0,1),(30,'usergroups',0,1),(31,'administrators',0,1),(32,'bots',0,1),(33,'global',0,1),(34,'moderators',0,1),(35,'guests',0,1),(36,'registered',0,1),(37,'users',0,1),(38,'coppa',0,1),(39,'also',0,1),(40,'choose',0,1),(41,'not',0,1),(42,'forget',0,1),(43,'assign',0,1),(44,'all',0,1),(45,'these',0,1),(46,'new',0,1),(47,'categories',0,1),(48,'forums',0,1),(49,'create',0,1),(50,'recommended',0,1),(51,'rename',0,1),(52,'copy',0,1),(53,'from',0,1),(54,'while',0,1),(55,'creating',0,1),(56,'have',0,1),(57,'fun',0,1),(58,'welcome',0,1);
/*!40000 ALTER TABLE `phpbb_search_wordlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_search_wordmatch`
--

DROP TABLE IF EXISTS `phpbb_search_wordmatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_search_wordmatch` (
  `post_id` mediumint(8) unsigned NOT NULL default '0',
  `word_id` mediumint(8) unsigned NOT NULL default '0',
  `title_match` tinyint(1) unsigned NOT NULL default '0',
  UNIQUE KEY `unq_mtch` (`word_id`,`post_id`,`title_match`),
  KEY `word_id` (`word_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_search_wordmatch`
--

LOCK TABLES `phpbb_search_wordmatch` WRITE;
/*!40000 ALTER TABLE `phpbb_search_wordmatch` DISABLE KEYS */;
INSERT INTO `phpbb_search_wordmatch` VALUES (1,1,0),(1,2,0),(1,3,0),(1,4,0),(1,5,0),(1,5,1),(1,6,0),(1,7,0),(1,8,0),(1,9,0),(1,10,0),(1,11,0),(1,12,0),(1,13,0),(1,14,0),(1,15,0),(1,16,0),(1,17,0),(1,18,0),(1,19,0),(1,20,0),(1,21,0),(1,22,0),(1,23,0),(1,24,0),(1,25,0),(1,26,0),(1,27,0),(1,28,0),(1,29,0),(1,30,0),(1,31,0),(1,32,0),(1,33,0),(1,34,0),(1,35,0),(1,36,0),(1,37,0),(1,38,0),(1,39,0),(1,40,0),(1,41,0),(1,42,0),(1,43,0),(1,44,0),(1,45,0),(1,46,0),(1,47,0),(1,48,0),(1,49,0),(1,50,0),(1,51,0),(1,52,0),(1,53,0),(1,54,0),(1,55,0),(1,56,0),(1,57,0),(1,58,1);
/*!40000 ALTER TABLE `phpbb_search_wordmatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_sessions`
--

DROP TABLE IF EXISTS `phpbb_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_sessions` (
  `session_id` char(32) collate utf8_bin NOT NULL default '',
  `session_user_id` mediumint(8) unsigned NOT NULL default '0',
  `session_forum_id` mediumint(8) unsigned NOT NULL default '0',
  `session_last_visit` int(11) unsigned NOT NULL default '0',
  `session_start` int(11) unsigned NOT NULL default '0',
  `session_time` int(11) unsigned NOT NULL default '0',
  `session_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `session_browser` varchar(150) collate utf8_bin NOT NULL default '',
  `session_forwarded_for` varchar(255) collate utf8_bin NOT NULL default '',
  `session_page` varchar(255) collate utf8_bin NOT NULL default '',
  `session_viewonline` tinyint(1) unsigned NOT NULL default '1',
  `session_autologin` tinyint(1) unsigned NOT NULL default '0',
  `session_admin` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`session_id`),
  KEY `session_time` (`session_time`),
  KEY `session_user_id` (`session_user_id`),
  KEY `session_fid` (`session_forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_sessions`
--

LOCK TABLES `phpbb_sessions` WRITE;
/*!40000 ALTER TABLE `phpbb_sessions` DISABLE KEYS */;
INSERT INTO `phpbb_sessions` VALUES ('947af9439e475afad641c58bab1da649',1,0,1326746842,1326746842,1326746846,'89.252.56.204','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','','index.php',1,0,0),('6e7fd7f650086cd2ed1b19d39f587b57',1,0,1327494745,1327494745,1327494745,'92.244.100.226','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','','index.php',1,0,0),('58282e6e910577292951aa348ccf66a6',1,0,1326746820,1326746820,1326746820,'89.252.56.204','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','','ucp.php?mode=logout',1,0,0),('b312f6b51d20dc759563cad7f97119ec',1,0,1326746842,1326746842,1326746842,'89.252.56.204','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','','ucp.php?mode=logout',1,0,0);
/*!40000 ALTER TABLE `phpbb_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_sessions_keys`
--

DROP TABLE IF EXISTS `phpbb_sessions_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_sessions_keys` (
  `key_id` char(32) collate utf8_bin NOT NULL default '',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `last_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `last_login` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`key_id`,`user_id`),
  KEY `last_login` (`last_login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_sessions_keys`
--

LOCK TABLES `phpbb_sessions_keys` WRITE;
/*!40000 ALTER TABLE `phpbb_sessions_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_sessions_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_sitelist`
--

DROP TABLE IF EXISTS `phpbb_sitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_sitelist` (
  `site_id` mediumint(8) unsigned NOT NULL auto_increment,
  `site_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `site_hostname` varchar(255) collate utf8_bin NOT NULL default '',
  `ip_exclude` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_sitelist`
--

LOCK TABLES `phpbb_sitelist` WRITE;
/*!40000 ALTER TABLE `phpbb_sitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_sitelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_smilies`
--

DROP TABLE IF EXISTS `phpbb_smilies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_smilies` (
  `smiley_id` mediumint(8) unsigned NOT NULL auto_increment,
  `code` varchar(50) collate utf8_bin NOT NULL default '',
  `emotion` varchar(50) collate utf8_bin NOT NULL default '',
  `smiley_url` varchar(50) collate utf8_bin NOT NULL default '',
  `smiley_width` smallint(4) unsigned NOT NULL default '0',
  `smiley_height` smallint(4) unsigned NOT NULL default '0',
  `smiley_order` mediumint(8) unsigned NOT NULL default '0',
  `display_on_posting` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`smiley_id`),
  KEY `display_on_post` (`display_on_posting`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_smilies`
--

LOCK TABLES `phpbb_smilies` WRITE;
/*!40000 ALTER TABLE `phpbb_smilies` DISABLE KEYS */;
INSERT INTO `phpbb_smilies` VALUES (1,':D','Very Happy','icon_e_biggrin.gif',15,17,1,1),(2,':-D','Very Happy','icon_e_biggrin.gif',15,17,2,1),(3,':grin:','Very Happy','icon_e_biggrin.gif',15,17,3,1),(4,':)','Smile','icon_e_smile.gif',15,17,4,1),(5,':-)','Smile','icon_e_smile.gif',15,17,5,1),(6,':smile:','Smile','icon_e_smile.gif',15,17,6,1),(7,';)','Wink','icon_e_wink.gif',15,17,7,1),(8,';-)','Wink','icon_e_wink.gif',15,17,8,1),(9,':wink:','Wink','icon_e_wink.gif',15,17,9,1),(10,':(','Sad','icon_e_sad.gif',15,17,10,1),(11,':-(','Sad','icon_e_sad.gif',15,17,11,1),(12,':sad:','Sad','icon_e_sad.gif',15,17,12,1),(13,':o','Surprised','icon_e_surprised.gif',15,17,13,1),(14,':-o','Surprised','icon_e_surprised.gif',15,17,14,1),(15,':eek:','Surprised','icon_e_surprised.gif',15,17,15,1),(16,':shock:','Shocked','icon_eek.gif',15,17,16,1),(17,':?','Confused','icon_e_confused.gif',15,17,17,1),(18,':-?','Confused','icon_e_confused.gif',15,17,18,1),(19,':???:','Confused','icon_e_confused.gif',15,17,19,1),(20,'8-)','Cool','icon_cool.gif',15,17,20,1),(21,':cool:','Cool','icon_cool.gif',15,17,21,1),(22,':lol:','Laughing','icon_lol.gif',15,17,22,1),(23,':x','Mad','icon_mad.gif',15,17,23,1),(24,':-x','Mad','icon_mad.gif',15,17,24,1),(25,':mad:','Mad','icon_mad.gif',15,17,25,1),(26,':P','Razz','icon_razz.gif',15,17,26,1),(27,':-P','Razz','icon_razz.gif',15,17,27,1),(28,':razz:','Razz','icon_razz.gif',15,17,28,1),(29,':oops:','Embarrassed','icon_redface.gif',15,17,29,1),(30,':cry:','Crying or Very Sad','icon_cry.gif',15,17,30,1),(31,':evil:','Evil or Very Mad','icon_evil.gif',15,17,31,1),(32,':twisted:','Twisted Evil','icon_twisted.gif',15,17,32,1),(33,':roll:','Rolling Eyes','icon_rolleyes.gif',15,17,33,1),(34,':!:','Exclamation','icon_exclaim.gif',15,17,34,1),(35,':?:','Question','icon_question.gif',15,17,35,1),(36,':idea:','Idea','icon_idea.gif',15,17,36,1),(37,':arrow:','Arrow','icon_arrow.gif',15,17,37,1),(38,':|','Neutral','icon_neutral.gif',15,17,38,1),(39,':-|','Neutral','icon_neutral.gif',15,17,39,1),(40,':mrgreen:','Mr. Green','icon_mrgreen.gif',15,17,40,1),(41,':geek:','Geek','icon_e_geek.gif',17,17,41,1),(42,':ugeek:','Uber Geek','icon_e_ugeek.gif',17,18,42,1);
/*!40000 ALTER TABLE `phpbb_smilies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_styles`
--

DROP TABLE IF EXISTS `phpbb_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_styles` (
  `style_id` mediumint(8) unsigned NOT NULL auto_increment,
  `style_name` varchar(255) collate utf8_bin NOT NULL default '',
  `style_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `style_active` tinyint(1) unsigned NOT NULL default '1',
  `template_id` mediumint(8) unsigned NOT NULL default '0',
  `theme_id` mediumint(8) unsigned NOT NULL default '0',
  `imageset_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`style_id`),
  UNIQUE KEY `style_name` (`style_name`),
  KEY `template_id` (`template_id`),
  KEY `theme_id` (`theme_id`),
  KEY `imageset_id` (`imageset_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_styles`
--

LOCK TABLES `phpbb_styles` WRITE;
/*!40000 ALTER TABLE `phpbb_styles` DISABLE KEYS */;
INSERT INTO `phpbb_styles` VALUES (1,'prosilver','&copy; phpBB Group',1,1,1,1);
/*!40000 ALTER TABLE `phpbb_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_styles_imageset`
--

DROP TABLE IF EXISTS `phpbb_styles_imageset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_styles_imageset` (
  `imageset_id` mediumint(8) unsigned NOT NULL auto_increment,
  `imageset_name` varchar(255) collate utf8_bin NOT NULL default '',
  `imageset_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `imageset_path` varchar(100) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`imageset_id`),
  UNIQUE KEY `imgset_nm` (`imageset_name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_styles_imageset`
--

LOCK TABLES `phpbb_styles_imageset` WRITE;
/*!40000 ALTER TABLE `phpbb_styles_imageset` DISABLE KEYS */;
INSERT INTO `phpbb_styles_imageset` VALUES (1,'prosilver','&copy; phpBB Group','prosilver');
/*!40000 ALTER TABLE `phpbb_styles_imageset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_styles_imageset_data`
--

DROP TABLE IF EXISTS `phpbb_styles_imageset_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_styles_imageset_data` (
  `image_id` mediumint(8) unsigned NOT NULL auto_increment,
  `image_name` varchar(200) collate utf8_bin NOT NULL default '',
  `image_filename` varchar(200) collate utf8_bin NOT NULL default '',
  `image_lang` varchar(30) collate utf8_bin NOT NULL default '',
  `image_height` smallint(4) unsigned NOT NULL default '0',
  `image_width` smallint(4) unsigned NOT NULL default '0',
  `imageset_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`image_id`),
  KEY `i_d` (`imageset_id`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_styles_imageset_data`
--

LOCK TABLES `phpbb_styles_imageset_data` WRITE;
/*!40000 ALTER TABLE `phpbb_styles_imageset_data` DISABLE KEYS */;
INSERT INTO `phpbb_styles_imageset_data` VALUES (1,'site_logo','site_logo.gif','',52,139,1),(2,'forum_link','forum_link.gif','',27,27,1),(3,'forum_read','forum_read.gif','',27,27,1),(4,'forum_read_locked','forum_read_locked.gif','',27,27,1),(5,'forum_read_subforum','forum_read_subforum.gif','',27,27,1),(6,'forum_unread','forum_unread.gif','',27,27,1),(7,'forum_unread_locked','forum_unread_locked.gif','',27,27,1),(8,'forum_unread_subforum','forum_unread_subforum.gif','',27,27,1),(9,'topic_moved','topic_moved.gif','',27,27,1),(10,'topic_read','topic_read.gif','',27,27,1),(11,'topic_read_mine','topic_read_mine.gif','',27,27,1),(12,'topic_read_hot','topic_read_hot.gif','',27,27,1),(13,'topic_read_hot_mine','topic_read_hot_mine.gif','',27,27,1),(14,'topic_read_locked','topic_read_locked.gif','',27,27,1),(15,'topic_read_locked_mine','topic_read_locked_mine.gif','',27,27,1),(16,'topic_unread','topic_unread.gif','',27,27,1),(17,'topic_unread_mine','topic_unread_mine.gif','',27,27,1),(18,'topic_unread_hot','topic_unread_hot.gif','',27,27,1),(19,'topic_unread_hot_mine','topic_unread_hot_mine.gif','',27,27,1),(20,'topic_unread_locked','topic_unread_locked.gif','',27,27,1),(21,'topic_unread_locked_mine','topic_unread_locked_mine.gif','',27,27,1),(22,'sticky_read','sticky_read.gif','',27,27,1),(23,'sticky_read_mine','sticky_read_mine.gif','',27,27,1),(24,'sticky_read_locked','sticky_read_locked.gif','',27,27,1),(25,'sticky_read_locked_mine','sticky_read_locked_mine.gif','',27,27,1),(26,'sticky_unread','sticky_unread.gif','',27,27,1),(27,'sticky_unread_mine','sticky_unread_mine.gif','',27,27,1),(28,'sticky_unread_locked','sticky_unread_locked.gif','',27,27,1),(29,'sticky_unread_locked_mine','sticky_unread_locked_mine.gif','',27,27,1),(30,'announce_read','announce_read.gif','',27,27,1),(31,'announce_read_mine','announce_read_mine.gif','',27,27,1),(32,'announce_read_locked','announce_read_locked.gif','',27,27,1),(33,'announce_read_locked_mine','announce_read_locked_mine.gif','',27,27,1),(34,'announce_unread','announce_unread.gif','',27,27,1),(35,'announce_unread_mine','announce_unread_mine.gif','',27,27,1),(36,'announce_unread_locked','announce_unread_locked.gif','',27,27,1),(37,'announce_unread_locked_mine','announce_unread_locked_mine.gif','',27,27,1),(38,'global_read','announce_read.gif','',27,27,1),(39,'global_read_mine','announce_read_mine.gif','',27,27,1),(40,'global_read_locked','announce_read_locked.gif','',27,27,1),(41,'global_read_locked_mine','announce_read_locked_mine.gif','',27,27,1),(42,'global_unread','announce_unread.gif','',27,27,1),(43,'global_unread_mine','announce_unread_mine.gif','',27,27,1),(44,'global_unread_locked','announce_unread_locked.gif','',27,27,1),(45,'global_unread_locked_mine','announce_unread_locked_mine.gif','',27,27,1),(46,'pm_read','topic_read.gif','',27,27,1),(47,'pm_unread','topic_unread.gif','',27,27,1),(48,'icon_back_top','icon_back_top.gif','',11,11,1),(49,'icon_contact_aim','icon_contact_aim.gif','',20,20,1),(50,'icon_contact_email','icon_contact_email.gif','',20,20,1),(51,'icon_contact_icq','icon_contact_icq.gif','',20,20,1),(52,'icon_contact_jabber','icon_contact_jabber.gif','',20,20,1),(53,'icon_contact_msnm','icon_contact_msnm.gif','',20,20,1),(54,'icon_contact_www','icon_contact_www.gif','',20,20,1),(55,'icon_contact_yahoo','icon_contact_yahoo.gif','',20,20,1),(56,'icon_post_delete','icon_post_delete.gif','',20,20,1),(57,'icon_post_info','icon_post_info.gif','',20,20,1),(58,'icon_post_report','icon_post_report.gif','',20,20,1),(59,'icon_post_target','icon_post_target.gif','',9,11,1),(60,'icon_post_target_unread','icon_post_target_unread.gif','',9,11,1),(61,'icon_topic_attach','icon_topic_attach.gif','',10,7,1),(62,'icon_topic_latest','icon_topic_latest.gif','',9,11,1),(63,'icon_topic_newest','icon_topic_newest.gif','',9,11,1),(64,'icon_topic_reported','icon_topic_reported.gif','',14,16,1),(65,'icon_topic_unapproved','icon_topic_unapproved.gif','',14,16,1),(66,'icon_user_warn','icon_user_warn.gif','',20,20,1),(67,'subforum_read','subforum_read.gif','',9,11,1),(68,'subforum_unread','subforum_unread.gif','',9,11,1),(69,'icon_contact_pm','icon_contact_pm.gif','en',20,28,1),(70,'icon_post_edit','icon_post_edit.gif','en',20,42,1),(71,'icon_post_quote','icon_post_quote.gif','en',20,54,1),(72,'icon_user_online','icon_user_online.gif','en',58,58,1),(73,'button_pm_forward','button_pm_forward.gif','en',25,96,1),(74,'button_pm_new','button_pm_new.gif','en',25,84,1),(75,'button_pm_reply','button_pm_reply.gif','en',25,96,1),(76,'button_topic_locked','button_topic_locked.gif','en',25,88,1),(77,'button_topic_new','button_topic_new.gif','en',25,96,1),(78,'button_topic_reply','button_topic_reply.gif','en',25,96,1);
/*!40000 ALTER TABLE `phpbb_styles_imageset_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_styles_template`
--

DROP TABLE IF EXISTS `phpbb_styles_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_styles_template` (
  `template_id` mediumint(8) unsigned NOT NULL auto_increment,
  `template_name` varchar(255) collate utf8_bin NOT NULL default '',
  `template_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `template_path` varchar(100) collate utf8_bin NOT NULL default '',
  `bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default 'kNg=',
  `template_storedb` tinyint(1) unsigned NOT NULL default '0',
  `template_inherits_id` int(4) unsigned NOT NULL default '0',
  `template_inherit_path` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`template_id`),
  UNIQUE KEY `tmplte_nm` (`template_name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_styles_template`
--

LOCK TABLES `phpbb_styles_template` WRITE;
/*!40000 ALTER TABLE `phpbb_styles_template` DISABLE KEYS */;
INSERT INTO `phpbb_styles_template` VALUES (1,'prosilver','&copy; phpBB Group','prosilver','lNg=',0,0,'');
/*!40000 ALTER TABLE `phpbb_styles_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_styles_template_data`
--

DROP TABLE IF EXISTS `phpbb_styles_template_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_styles_template_data` (
  `template_id` mediumint(8) unsigned NOT NULL default '0',
  `template_filename` varchar(100) collate utf8_bin NOT NULL default '',
  `template_included` text collate utf8_bin NOT NULL,
  `template_mtime` int(11) unsigned NOT NULL default '0',
  `template_data` mediumtext collate utf8_bin NOT NULL,
  KEY `tid` (`template_id`),
  KEY `tfn` (`template_filename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_styles_template_data`
--

LOCK TABLES `phpbb_styles_template_data` WRITE;
/*!40000 ALTER TABLE `phpbb_styles_template_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_styles_template_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_styles_theme`
--

DROP TABLE IF EXISTS `phpbb_styles_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_styles_theme` (
  `theme_id` mediumint(8) unsigned NOT NULL auto_increment,
  `theme_name` varchar(255) collate utf8_bin NOT NULL default '',
  `theme_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `theme_path` varchar(100) collate utf8_bin NOT NULL default '',
  `theme_storedb` tinyint(1) unsigned NOT NULL default '0',
  `theme_mtime` int(11) unsigned NOT NULL default '0',
  `theme_data` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`theme_id`),
  UNIQUE KEY `theme_name` (`theme_name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_styles_theme`
--

LOCK TABLES `phpbb_styles_theme` WRITE;
/*!40000 ALTER TABLE `phpbb_styles_theme` DISABLE KEYS */;
INSERT INTO `phpbb_styles_theme` VALUES (1,'prosilver','&copy; phpBB Group','prosilver',1,1326326272,'/*  phpBB3 Style Sheet\n    --------------------------------------------------------------\n	Style name:			prosilver (the default phpBB 3.0.x style)\n	Based on style:		\n	Original author:	Tom Beddard ( http://www.subblue.com/ )\n	Modified by:		phpBB Group ( http://www.phpbb.com/ )\n    --------------------------------------------------------------\n*/\n\n/* General Markup Styles\n---------------------------------------- */\n\n* {\n	/* Reset browsers default margin, padding and font sizes */\n	margin: 0;\n	padding: 0;\n}\n\nhtml {\n	font-size: 100%;\n	/* Always show a scrollbar for short pages - stops the jump when the scrollbar appears. non-IE browsers */\n	height: 101%;\n}\n\nbody {\n	/* Text-Sizing with ems: http://www.clagnut.com/blog/348/ */\n	font-family: Verdana, Helvetica, Arial, sans-serif;\n	color: #828282;\n	background-color: #FFFFFF;\n	/*font-size: 62.5%;			 This sets the default font size to be equivalent to 10px */\n	font-size: 10px;\n	margin: 0;\n	padding: 12px 0;\n}\n\nh1 {\n	/* Forum name */\n	font-family: \"Trebuchet MS\", Arial, Helvetica, sans-serif;\n	margin-right: 200px;\n	color: #FFFFFF;\n	margin-top: 15px;\n	font-weight: bold;\n	font-size: 2em;\n}\n\nh2 {\n	/* Forum header titles */\n	font-family: \"Trebuchet MS\", Arial, Helvetica, sans-serif;\n	font-weight: normal;\n	color: #3f3f3f;\n	font-size: 2em;\n	margin: 0.8em 0 0.2em 0;\n}\n\nh2.solo {\n	margin-bottom: 1em;\n}\n\nh3 {\n	/* Sub-headers (also used as post headers, but defined later) */\n	font-family: Arial, Helvetica, sans-serif;\n	font-weight: bold;\n	text-transform: uppercase;\n	border-bottom: 1px solid #CCCCCC;\n	margin-bottom: 3px;\n	padding-bottom: 2px;\n	font-size: 1.05em;\n	color: #989898;\n	margin-top: 20px;\n}\n\nh4 {\n	/* Forum and topic list titles */\n	font-family: \"Trebuchet MS\", Verdana, Helvetica, Arial, Sans-serif;\n	font-size: 1.3em;\n}\n\np {\n	line-height: 1.3em;\n	font-size: 1.1em;\n	margin-bottom: 1.5em;\n}\n\nimg {\n	border-width: 0;\n}\n\nhr {\n	/* Also see tweaks.css */\n	border: 0 none #FFFFFF;\n	border-top: 1px solid #CCCCCC;\n	height: 1px;\n	margin: 5px 0;\n	display: block;\n	clear: both;\n}\n\nhr.dashed {\n	border-top: 1px dashed #CCCCCC;\n	margin: 10px 0;\n}\n\nhr.divider {\n	display: none;\n}\n\np.right {\n	text-align: right;\n}\n\n/* Main blocks\n---------------------------------------- */\n#wrap {\n	padding: 0 20px;\n	min-width: 650px;\n}\n\n#simple-wrap {\n	padding: 6px 10px;\n}\n\n#page-body {\n	margin: 4px 0;\n	clear: both;\n}\n\n#page-footer {\n	clear: both;\n}\n\n#page-footer h3 {\n	margin-top: 20px;\n}\n\n#logo {\n	float: left;\n	width: auto;\n	padding: 10px 13px 0 10px;\n}\n\na#logo:hover {\n	text-decoration: none;\n}\n\n/* Search box\n--------------------------------------------- */\n#search-box {\n	color: #FFFFFF;\n	position: relative;\n	margin-top: 30px;\n	margin-right: 5px;\n	display: block;\n	float: right;\n	text-align: right;\n	white-space: nowrap; /* For Opera */\n}\n\n#search-box #keywords {\n	width: 95px;\n	background-color: #FFF;\n}\n\n#search-box input {\n	border: 1px solid #b0b0b0;\n}\n\n/* .button1 style defined later, just a few tweaks for the search button version */\n#search-box input.button1 {\n	padding: 1px 5px;\n}\n\n#search-box li {\n	text-align: right;\n	margin-top: 4px;\n}\n\n#search-box img {\n	vertical-align: middle;\n	margin-right: 3px;\n}\n\n/* Site description and logo */\n#site-description {\n	float: left;\n	width: 70%;\n}\n\n#site-description h1 {\n	margin-right: 0;\n}\n\n/* Round cornered boxes and backgrounds\n---------------------------------------- */\n.headerbar {\n	background: #ebebeb none repeat-x 0 0;\n	color: #FFFFFF;\n	margin-bottom: 4px;\n	padding: 0 5px;\n}\n\n.navbar {\n	background-color: #ebebeb;\n	padding: 0 10px;\n}\n\n.forabg {\n	background: #b1b1b1 none repeat-x 0 0;\n	margin-bottom: 4px;\n	padding: 0 5px;\n	clear: both;\n}\n\n.forumbg {\n	background: #ebebeb none repeat-x 0 0;\n	margin-bottom: 4px;\n	padding: 0 5px;\n	clear: both;\n}\n\n.panel {\n	margin-bottom: 4px;\n	padding: 0 10px;\n	background-color: #f3f3f3;\n	color: #3f3f3f;\n}\n\n.post {\n	padding: 0 10px;\n	margin-bottom: 4px;\n	background-repeat: no-repeat;\n	background-position: 100% 0;\n}\n\n.post:target .content {\n	color: #000000;\n}\n\n.post:target h3 a {\n	color: #000000;\n}\n\n.bg1	{ background-color: #f7f7f7;}\n.bg2	{ background-color: #f2f2f2; }\n.bg3	{ background-color: #ebebeb; }\n\n.rowbg {\n	margin: 5px 5px 2px 5px;\n}\n\n.ucprowbg {\n	background-color: #e2e2e2;\n}\n\n.fieldsbg {\n	/*border: 1px #DBDEE2 solid;*/\n	background-color: #eaeaea;\n}\n\nspan.corners-top, span.corners-bottom, span.corners-top span, span.corners-bottom span {\n	font-size: 1px;\n	line-height: 1px;\n	display: block;\n	height: 5px;\n	background-repeat: no-repeat;\n}\n\nspan.corners-top {\n	background-image: none;\n	background-position: 0 0;\n	margin: 0 -5px;\n}\n\nspan.corners-top span {\n	background-image: none;\n	background-position: 100% 0;\n}\n\nspan.corners-bottom {\n	background-image: none;\n	background-position: 0 100%;\n	margin: 0 -5px;\n	clear: both;\n}\n\nspan.corners-bottom span {\n	background-image: none;\n	background-position: 100% 100%;\n}\n\n.headbg span.corners-bottom {\n	margin-bottom: -1px;\n}\n\n.post span.corners-top, .post span.corners-bottom, .panel span.corners-top, .panel span.corners-bottom, .navbar span.corners-top, .navbar span.corners-bottom {\n	margin: 0 -10px;\n}\n\n.rules span.corners-top {\n	margin: 0 -10px 5px -10px;\n}\n\n.rules span.corners-bottom {\n	margin: 5px -10px 0 -10px;\n}\n\n/* Horizontal lists\n----------------------------------------*/\nul.linklist {\n	display: block;\n	margin: 0;\n}\n\nul.linklist li {\n	display: block;\n	list-style-type: none;\n	float: left;\n	width: auto;\n	margin-right: 5px;\n	font-size: 1.1em;\n	line-height: 2.2em;\n}\n\nul.linklist li.rightside, p.rightside {\n	float: right;\n	margin-right: 0;\n	margin-left: 5px;\n	text-align: right;\n}\n\nul.navlinks {\n	padding-bottom: 1px;\n	margin-bottom: 1px;\n	border-bottom: 1px solid #FFFFFF;\n	font-weight: bold;\n}\n\nul.leftside {\n	float: left;\n	margin-left: 0;\n	margin-right: 5px;\n	text-align: left;\n}\n\nul.rightside {\n	float: right;\n	margin-left: 5px;\n	margin-right: -5px;\n	text-align: right;\n}\n\n/* Table styles\n----------------------------------------*/\ntable.table1 {\n	/* See tweaks.css */\n}\n\n#ucp-main table.table1 {\n	padding: 2px;\n}\n\ntable.table1 thead th {\n	font-weight: normal;\n	text-transform: uppercase;\n	color: #FFFFFF;\n	line-height: 1.3em;\n	font-size: 1em;\n	padding: 0 0 4px 3px;\n}\n\ntable.table1 thead th span {\n	padding-left: 7px;\n}\n\ntable.table1 tbody tr {\n	border: 1px solid #cfcfcf;\n}\n\ntable.table1 tbody tr:hover, table.table1 tbody tr.hover {\n	background-color: #f6f6f6;\n	color: #000;\n}\n\ntable.table1 td {\n	color: #6a6a6a;\n	font-size: 1.1em;\n}\n\ntable.table1 tbody td {\n	padding: 5px;\n	border-top: 1px solid #FAFAFA;\n}\n\ntable.table1 tbody th {\n	padding: 5px;\n	border-bottom: 1px solid #000000;\n	text-align: left;\n	color: #333333;\n	background-color: #FFFFFF;\n}\n\n/* Specific column styles */\ntable.table1 .name		{ text-align: left; }\ntable.table1 .posts		{ text-align: center !important; width: 7%; }\ntable.table1 .joined	{ text-align: left; width: 15%; }\ntable.table1 .active	{ text-align: left; width: 15%; }\ntable.table1 .mark		{ text-align: center; width: 7%; }\ntable.table1 .info		{ text-align: left; width: 30%; }\ntable.table1 .info div	{ width: 100%; white-space: normal; overflow: hidden; }\ntable.table1 .autocol	{ line-height: 2em; white-space: nowrap; }\ntable.table1 thead .autocol { padding-left: 1em; }\n\ntable.table1 span.rank-img {\n	float: right;\n	width: auto;\n}\n\ntable.info td {\n	padding: 3px;\n}\n\ntable.info tbody th {\n	padding: 3px;\n	text-align: right;\n	vertical-align: top;\n	color: #000000;\n	font-weight: normal;\n}\n\n.forumbg table.table1 {\n	margin: 0 -2px -1px -1px;\n}\n\n/* Misc layout styles\n---------------------------------------- */\n/* column[1-2] styles are containers for two column layouts \n   Also see tweaks.css */\n.column1 {\n	float: left;\n	clear: left;\n	width: 49%;\n}\n\n.column2 {\n	float: right;\n	clear: right;\n	width: 49%;\n}\n\n/* General classes for placing floating blocks */\n.left-box {\n	float: left;\n	width: auto;\n	text-align: left;\n}\n\n.right-box {\n	float: right;\n	width: auto;\n	text-align: right;\n}\n\ndl.details {\n	/*font-family: \"Lucida Grande\", Verdana, Helvetica, Arial, sans-serif;*/\n	font-size: 1.1em;\n}\n\ndl.details dt {\n	float: left;\n	clear: left;\n	width: 30%;\n	text-align: right;\n	color: #000000;\n	display: block;\n}\n\ndl.details dd {\n	margin-left: 0;\n	padding-left: 5px;\n	margin-bottom: 5px;\n	color: #828282;\n	float: left;\n	width: 65%;\n}\n\n/* Pagination\n---------------------------------------- */\n.pagination {\n	height: 1%; /* IE tweak (holly hack) */\n	width: auto;\n	text-align: right;\n	margin-top: 5px;\n	float: right;\n}\n\n.pagination span.page-sep {\n	display: none;\n}\n\nli.pagination {\n	margin-top: 0;\n}\n\n.pagination strong, .pagination b {\n	font-weight: normal;\n}\n\n.pagination span strong {\n	padding: 0 2px;\n	margin: 0 2px;\n	font-weight: normal;\n	color: #FFFFFF;\n	background-color: #bfbfbf;\n	border: 1px solid #bfbfbf;\n	font-size: 0.9em;\n}\n\n.pagination span a, .pagination span a:link, .pagination span a:visited, .pagination span a:active {\n	font-weight: normal;\n	text-decoration: none;\n	color: #747474;\n	margin: 0 2px;\n	padding: 0 2px;\n	background-color: #eeeeee;\n	border: 1px solid #bababa;\n	font-size: 0.9em;\n	line-height: 1.5em;\n}\n\n.pagination span a:hover {\n	border-color: #d2d2d2;\n	background-color: #d2d2d2;\n	color: #FFF;\n	text-decoration: none;\n}\n\n.pagination img {\n	vertical-align: middle;\n}\n\n/* Pagination in viewforum for multipage topics */\n.row .pagination {\n	display: block;\n	float: right;\n	width: auto;\n	margin-top: 0;\n	padding: 1px 0 1px 15px;\n	font-size: 0.9em;\n	background: none 0 50% no-repeat;\n}\n\n.row .pagination span a, li.pagination span a {\n	background-color: #FFFFFF;\n}\n\n.row .pagination span a:hover, li.pagination span a:hover {\n	background-color: #d2d2d2;\n}\n\n/* Miscellaneous styles\n---------------------------------------- */\n#forum-permissions {\n	float: right;\n	width: auto;\n	padding-left: 5px;\n	margin-left: 5px;\n	margin-top: 10px;\n	text-align: right;\n}\n\n.copyright {\n	padding: 5px;\n	text-align: center;\n	color: #555555;\n}\n\n.small {\n	font-size: 0.9em !important;\n}\n\n.titlespace {\n	margin-bottom: 15px;\n}\n\n.headerspace {\n	margin-top: 20px;\n}\n\n.error {\n	color: #bcbcbc;\n	font-weight: bold;\n	font-size: 1em;\n}\n\n.reported {\n	background-color: #f7f7f7;\n}\n\nli.reported:hover {\n	background-color: #ececec;\n}\n\ndiv.rules {\n	background-color: #ececec;\n	color: #bcbcbc;\n	padding: 0 10px;\n	margin: 10px 0;\n	font-size: 1.1em;\n}\n\ndiv.rules ul, div.rules ol {\n	margin-left: 20px;\n}\n\np.rules {\n	background-color: #ececec;\n	background-image: none;\n	padding: 5px;\n}\n\np.rules img {\n	vertical-align: middle;\n	padding-top: 5px;\n}\n\np.rules a {\n	vertical-align: middle;\n	clear: both;\n}\n\n#top {\n	position: absolute;\n	top: -20px;\n}\n\n.clear {\n	display: block;\n	clear: both;\n	font-size: 1px;\n	line-height: 1px;\n	background: transparent;\n}\n/* Link Styles\n---------------------------------------- */\n\n/* Links adjustment to correctly display an order of rtl/ltr mixed content */\na {\n	direction: ltr;\n	unicode-bidi: embed;\n}\n\na:link	{ color: #898989; text-decoration: none; }\na:visited	{ color: #898989; text-decoration: none; }\na:hover	{ color: #d3d3d3; text-decoration: underline; }\na:active	{ color: #d2d2d2; text-decoration: none; }\n\n/* Coloured usernames */\n.username-coloured {\n	font-weight: bold;\n	display: inline !important;\n	padding: 0 !important;\n}\n\n/* Links on gradient backgrounds */\n#search-box a:link, .navbg a:link, .forumbg .header a:link, .forabg .header a:link, th a:link {\n	color: #FFFFFF;\n	text-decoration: none;\n}\n\n#search-box a:visited, .navbg a:visited, .forumbg .header a:visited, .forabg .header a:visited, th a:visited {\n	color: #FFFFFF;\n	text-decoration: none;\n}\n\n#search-box a:hover, .navbg a:hover, .forumbg .header a:hover, .forabg .header a:hover, th a:hover {\n	color: #ffffff;\n	text-decoration: underline;\n}\n\n#search-box a:active, .navbg a:active, .forumbg .header a:active, .forabg .header a:active, th a:active {\n	color: #ffffff;\n	text-decoration: none;\n}\n\n/* Links for forum/topic lists */\na.forumtitle {\n	font-family: \"Trebuchet MS\", Helvetica, Arial, Sans-serif;\n	font-size: 1.2em;\n	font-weight: bold;\n	color: #898989;\n	text-decoration: none;\n}\n\n/* a.forumtitle:visited { color: #898989; } */\n\na.forumtitle:hover {\n	color: #bcbcbc;\n	text-decoration: underline;\n}\n\na.forumtitle:active {\n	color: #898989;\n}\n\na.topictitle {\n	font-family: \"Trebuchet MS\", Helvetica, Arial, Sans-serif;\n	font-size: 1.2em;\n	font-weight: bold;\n	color: #898989;\n	text-decoration: none;\n}\n\n/* a.topictitle:visited { color: #d2d2d2; } */\n\na.topictitle:hover {\n	color: #bcbcbc;\n	text-decoration: underline;\n}\n\na.topictitle:active {\n	color: #898989;\n}\n\n/* Post body links */\n.postlink {\n	text-decoration: none;\n	color: #d2d2d2;\n	border-bottom: 1px solid #d2d2d2;\n	padding-bottom: 0;\n}\n\n/* .postlink:visited { color: #bdbdbd; } */\n\n.postlink:active {\n	color: #d2d2d2;\n}\n\n.postlink:hover {\n	background-color: #f6f6f6;\n	text-decoration: none;\n	color: #404040;\n}\n\n.signature a, .signature a:visited, .signature a:hover, .signature a:active {\n	border: none;\n	text-decoration: underline;\n	background-color: transparent;\n}\n\n/* Profile links */\n.postprofile a:link, .postprofile a:visited, .postprofile dt.author a {\n	font-weight: bold;\n	color: #898989;\n	text-decoration: none;\n}\n\n.postprofile a:hover, .postprofile dt.author a:hover {\n	text-decoration: underline;\n	color: #d3d3d3;\n}\n\n/* CSS spec requires a:link, a:visited, a:hover and a:active rules to be specified in this order. */\n/* See http://www.phpbb.com/bugs/phpbb3/59685 */\n.postprofile a:active {\n	font-weight: bold;\n	color: #898989;\n	text-decoration: none;\n}\n\n\n/* Profile searchresults */	\n.search .postprofile a {\n	color: #898989;\n	text-decoration: none; \n	font-weight: normal;\n}\n\n.search .postprofile a:hover {\n	color: #d3d3d3;\n	text-decoration: underline; \n}\n\n/* Back to top of page */\n.back2top {\n	clear: both;\n	height: 11px;\n	text-align: right;\n}\n\na.top {\n	background: none no-repeat top left;\n	text-decoration: none;\n	width: {IMG_ICON_BACK_TOP_WIDTH}px;\n	height: {IMG_ICON_BACK_TOP_HEIGHT}px;\n	display: block;\n	float: right;\n	overflow: hidden;\n	letter-spacing: 1000px;\n	text-indent: 11px;\n}\n\na.top2 {\n	background: none no-repeat 0 50%;\n	text-decoration: none;\n	padding-left: 15px;\n}\n\n/* Arrow links  */\na.up		{ background: none no-repeat left center; }\na.down		{ background: none no-repeat right center; }\na.left		{ background: none no-repeat 3px 60%; }\na.right		{ background: none no-repeat 95% 60%; }\n\na.up, a.up:link, a.up:active, a.up:visited {\n	padding-left: 10px;\n	text-decoration: none;\n	border-bottom-width: 0;\n}\n\na.up:hover {\n	background-position: left top;\n	background-color: transparent;\n}\n\na.down, a.down:link, a.down:active, a.down:visited {\n	padding-right: 10px;\n}\n\na.down:hover {\n	background-position: right bottom;\n	text-decoration: none;\n}\n\na.left, a.left:active, a.left:visited {\n	padding-left: 12px;\n}\n\na.left:hover {\n	color: #d2d2d2;\n	text-decoration: none;\n	background-position: 0 60%;\n}\n\na.right, a.right:active, a.right:visited {\n	padding-right: 12px;\n}\n\na.right:hover {\n	color: #d2d2d2;\n	text-decoration: none;\n	background-position: 100% 60%;\n}\n\n/* invisible skip link, used for accessibility  */\n.skiplink {\n	position: absolute;\n	left: -999px;\n	width: 990px;\n}\n\n/* Feed icon in forumlist_body.html */\na.feed-icon-forum {\n	float: right;\n	margin: 3px;\n}\n/* Content Styles\n---------------------------------------- */\n\nul.topiclist {\n	display: block;\n	list-style-type: none;\n	margin: 0;\n}\n\nul.forums {\n	background: #f9f9f9 none repeat-x 0 0;\n}\n\nul.topiclist li {\n	display: block;\n	list-style-type: none;\n	color: #777777;\n	margin: 0;\n}\n\nul.topiclist dl {\n	position: relative;\n}\n\nul.topiclist li.row dl {\n	padding: 2px 0;\n}\n\nul.topiclist dt {\n	display: block;\n	float: left;\n	width: 50%;\n	font-size: 1.1em;\n	padding-left: 5px;\n	padding-right: 5px;\n}\n\nul.topiclist dd {\n	display: block;\n	float: left;\n	border-left: 1px solid #FFFFFF;\n	padding: 4px 0;\n}\n\nul.topiclist dfn {\n	/* Labels for post/view counts */\n	position: absolute;\n	left: -999px;\n	width: 990px;\n}\n\nul.topiclist li.row dt a.subforum {\n	background-image: none;\n	background-position: 0 50%;\n	background-repeat: no-repeat;\n	position: relative;\n	white-space: nowrap;\n	padding: 0 0 0 12px;\n}\n\n.forum-image {\n	float: left;\n	padding-top: 5px;\n	margin-right: 5px;\n}\n\nli.row {\n	border-top: 1px solid #FFFFFF;\n	border-bottom: 1px solid #8f8f8f;\n}\n\nli.row strong {\n	font-weight: normal;\n	color: #000000;\n}\n\nli.row:hover {\n	background-color: #f6f6f6;\n}\n\nli.row:hover dd {\n	border-left-color: #CCCCCC;\n}\n\nli.header dt, li.header dd {\n	line-height: 1em;\n	border-left-width: 0;\n	margin: 2px 0 4px 0;\n	color: #FFFFFF;\n	padding-top: 2px;\n	padding-bottom: 2px;\n	font-size: 1em;\n	font-family: Arial, Helvetica, sans-serif;\n	text-transform: uppercase;\n}\n\nli.header dt {\n	font-weight: bold;\n}\n\nli.header dd {\n	margin-left: 1px;\n}\n\nli.header dl.icon {\n	min-height: 0;\n}\n\nli.header dl.icon dt {\n	/* Tweak for headers alignment when folder icon used */\n	padding-left: 0;\n	padding-right: 50px;\n}\n\n/* Forum list column styles */\ndl.icon {\n	min-height: 35px;\n	background-position: 10px 50%;		/* Position of folder icon */\n	background-repeat: no-repeat;\n}\n\ndl.icon dt {\n	padding-left: 45px;					/* Space for folder icon */\n	background-repeat: no-repeat;\n	background-position: 5px 95%;		/* Position of topic icon */\n}\n\ndd.posts, dd.topics, dd.views {\n	width: 8%;\n	text-align: center;\n	line-height: 2.2em;\n	font-size: 1.2em;\n}\n\n/* List in forum description */\ndl.icon dt ol,\ndl.icon dt ul {\n	list-style-position: inside;\n	margin-left: 1em;\n}\n\ndl.icon dt li {\n	display: list-item;\n	list-style-type: inherit;\n}\n\ndd.lastpost {\n	width: 25%;\n	font-size: 1.1em;\n}\n\ndd.redirect {\n	font-size: 1.1em;\n	line-height: 2.5em;\n}\n\ndd.moderation {\n	font-size: 1.1em;\n}\n\ndd.lastpost span, ul.topiclist dd.searchby span, ul.topiclist dd.info span, ul.topiclist dd.time span, dd.redirect span, dd.moderation span {\n	display: block;\n	padding-left: 5px;\n}\n\ndd.time {\n	width: auto;\n	line-height: 200%;\n	font-size: 1.1em;\n}\n\ndd.extra {\n	width: 12%;\n	line-height: 200%;\n	text-align: center;\n	font-size: 1.1em;\n}\n\ndd.mark {\n	float: right !important;\n	width: 9%;\n	text-align: center;\n	line-height: 200%;\n	font-size: 1.2em;\n}\n\ndd.info {\n	width: 30%;\n}\n\ndd.option {\n	width: 15%;\n	line-height: 200%;\n	text-align: center;\n	font-size: 1.1em;\n}\n\ndd.searchby {\n	width: 47%;\n	font-size: 1.1em;\n	line-height: 1em;\n}\n\nul.topiclist dd.searchextra {\n	margin-left: 5px;\n	padding: 0.2em 0;\n	font-size: 1.1em;\n	color: #333333;\n	border-left: none;\n	clear: both;\n	width: 98%;\n	overflow: hidden;\n}\n\n/* Container for post/reply buttons and pagination */\n.topic-actions {\n	margin-bottom: 3px;\n	font-size: 1.1em;\n	height: 28px;\n	min-height: 28px;\n}\ndiv[class].topic-actions {\n	height: auto;\n}\n\n/* Post body styles\n----------------------------------------*/\n.postbody {\n	padding: 0;\n	line-height: 1.48em;\n	color: #333333;\n	width: 76%;\n	float: left;\n	clear: both;\n}\n\n.postbody .ignore {\n	font-size: 1.1em;\n}\n\n.postbody h3.first {\n	/* The first post on the page uses this */\n	font-size: 1.7em;\n}\n\n.postbody h3 {\n	/* Postbody requires a different h3 format - so change it here */\n	font-size: 1.5em;\n	padding: 2px 0 0 0;\n	margin: 0 0 0.3em 0 !important;\n	text-transform: none;\n	border: none;\n	font-family: \"Trebuchet MS\", Verdana, Helvetica, Arial, sans-serif;\n	line-height: 125%;\n}\n\n.postbody h3 img {\n	/* Also see tweaks.css */\n	vertical-align: bottom;\n}\n\n.postbody .content {\n	font-size: 1.3em;\n}\n\n.search .postbody {\n	width: 68%\n}\n\n/* Topic review panel\n----------------------------------------*/\n#review {\n	margin-top: 2em;\n}\n\n#topicreview {\n	padding-right: 5px;\n	overflow: auto;\n	height: 300px;\n}\n\n#topicreview .postbody {\n	width: auto;\n	float: none;\n	margin: 0;\n	height: auto;\n}\n\n#topicreview .post {\n	height: auto;\n}\n\n#topicreview h2 {\n	border-bottom-width: 0;\n}\n\n.post-ignore .postbody {\n	display: none;\n}\n\n/* MCP Post details\n----------------------------------------*/\n#post_details\n{\n	/* This will only work in IE7+, plus the others */\n	overflow: auto;\n	max-height: 300px;\n}\n\n#expand\n{\n	clear: both;\n}\n\n/* Content container styles\n----------------------------------------*/\n.content {\n	min-height: 3em;\n	overflow: hidden;\n	line-height: 1.4em;\n	font-family: \"Lucida Grande\", \"Trebuchet MS\", Verdana, Helvetica, Arial, sans-serif;\n	font-size: 1em;\n	color: #333333;\n	padding-bottom: 1px;\n}\n\n.content h2, .panel h2 {\n	font-weight: normal;\n	color: #989898;\n	border-bottom: 1px solid #CCCCCC;\n	font-size: 1.6em;\n	margin-top: 0.5em;\n	margin-bottom: 0.5em;\n	padding-bottom: 0.5em;\n}\n\n.panel h3 {\n	margin: 0.5em 0;\n}\n\n.panel p {\n	font-size: 1.2em;\n	margin-bottom: 1em;\n	line-height: 1.4em;\n}\n\n.content p {\n	font-family: \"Lucida Grande\", \"Trebuchet MS\", Verdana, Helvetica, Arial, sans-serif;\n	font-size: 1.2em;\n	margin-bottom: 1em;\n	line-height: 1.4em;\n}\n\ndl.faq {\n	font-family: \"Lucida Grande\", Verdana, Helvetica, Arial, sans-serif;\n	font-size: 1.1em;\n	margin-top: 1em;\n	margin-bottom: 2em;\n	line-height: 1.4em;\n}\n\ndl.faq dt {\n	font-weight: bold;\n	color: #333333;\n}\n\n.content dl.faq {\n	font-size: 1.2em;\n	margin-bottom: 0.5em;\n}\n\n.content li {\n	list-style-type: inherit;\n}\n\n.content ul, .content ol {\n	margin-bottom: 1em;\n	margin-left: 3em;\n}\n\n.posthilit {\n	background-color: #f3f3f3;\n	color: #BCBCBC;\n	padding: 0 2px 1px 2px;\n}\n\n.announce, .unreadpost {\n	/* Highlight the announcements & unread posts box */\n	border-left-color: #BCBCBC;\n	border-right-color: #BCBCBC;\n}\n\n/* Post author */\np.author {\n	margin: 0 15em 0.6em 0;\n	padding: 0 0 5px 0;\n	font-family: Verdana, Helvetica, Arial, sans-serif;\n	font-size: 1em;\n	line-height: 1.2em;\n}\n\n/* Post signature */\n.signature {\n	margin-top: 1.5em;\n	padding-top: 0.2em;\n	font-size: 1.1em;\n	border-top: 1px solid #CCCCCC;\n	clear: left;\n	line-height: 140%;\n	overflow: hidden;\n	width: 100%;\n}\n\ndd .signature {\n	margin: 0;\n	padding: 0;\n	clear: none;\n	border: none;\n}\n\n.signature li {\n	list-style-type: inherit;\n}\n\n.signature ul, .signature ol {\n	margin-bottom: 1em;\n	margin-left: 3em;\n}\n\n/* Post noticies */\n.notice {\n	font-family: \"Lucida Grande\", Verdana, Helvetica, Arial, sans-serif;\n	width: auto;\n	margin-top: 1.5em;\n	padding-top: 0.2em;\n	font-size: 1em;\n	border-top: 1px dashed #CCCCCC;\n	clear: left;\n	line-height: 130%;\n}\n\n/* Jump to post link for now */\nul.searchresults {\n	list-style: none;\n	text-align: right;\n	clear: both;\n}\n\n/* BB Code styles\n----------------------------------------*/\n/* Quote block */\nblockquote {\n	background: #ebebeb none 6px 8px no-repeat;\n	border: 1px solid #dbdbdb;\n	font-size: 0.95em;\n	margin: 0.5em 1px 0 25px;\n	overflow: hidden;\n	padding: 5px;\n}\n\nblockquote blockquote {\n	/* Nested quotes */\n	background-color: #bababa;\n	font-size: 1em;\n	margin: 0.5em 1px 0 15px;	\n}\n\nblockquote blockquote blockquote {\n	/* Nested quotes */\n	background-color: #e4e4e4;\n}\n\nblockquote cite {\n	/* Username/source of quoter */\n	font-style: normal;\n	font-weight: bold;\n	margin-left: 20px;\n	display: block;\n	font-size: 0.9em;\n}\n\nblockquote cite cite {\n	font-size: 1em;\n}\n\nblockquote.uncited {\n	padding-top: 25px;\n}\n\n/* Code block */\ndl.codebox {\n	padding: 3px;\n	background-color: #FFFFFF;\n	border: 1px solid #d8d8d8;\n	font-size: 1em;\n}\n\ndl.codebox dt {\n	text-transform: uppercase;\n	border-bottom: 1px solid #CCCCCC;\n	margin-bottom: 3px;\n	font-size: 0.8em;\n	font-weight: bold;\n	display: block;\n}\n\nblockquote dl.codebox {\n	margin-left: 0;\n}\n\ndl.codebox code {\n	/* Also see tweaks.css */\n	overflow: auto;\n	display: block;\n	height: auto;\n	max-height: 200px;\n	white-space: normal;\n	padding-top: 5px;\n	font: 0.9em Monaco, \"Andale Mono\",\"Courier New\", Courier, mono;\n	line-height: 1.3em;\n	color: #8b8b8b;\n	margin: 2px 0;\n}\n\n.syntaxbg		{ color: #FFFFFF; }\n.syntaxcomment	{ color: #000000; }\n.syntaxdefault	{ color: #bcbcbc; }\n.syntaxhtml		{ color: #000000; }\n.syntaxkeyword	{ color: #585858; }\n.syntaxstring	{ color: #a7a7a7; }\n\n/* Attachments\n----------------------------------------*/\n.attachbox {\n	float: left;\n	width: auto; \n	margin: 5px 5px 5px 0;\n	padding: 6px;\n	background-color: #FFFFFF;\n	border: 1px dashed #d8d8d8;\n	clear: left;\n}\n\n.pm-message .attachbox {\n	background-color: #f3f3f3;\n}\n\n.attachbox dt {\n	font-family: Arial, Helvetica, sans-serif;\n	text-transform: uppercase;\n}\n\n.attachbox dd {\n	margin-top: 4px;\n	padding-top: 4px;\n	clear: left;\n	border-top: 1px solid #d8d8d8;\n}\n\n.attachbox dd dd {\n	border: none;\n}\n\n.attachbox p {\n	line-height: 110%;\n	color: #666666;\n	font-weight: normal;\n	clear: left;\n}\n\n.attachbox p.stats\n{\n	line-height: 110%;\n	color: #666666;\n	font-weight: normal;\n	clear: left;\n}\n\n.attach-image {\n	margin: 3px 0;\n	width: 100%;\n	max-height: 350px;\n	overflow: auto;\n}\n\n.attach-image img {\n	border: 1px solid #999999;\n/*	cursor: move; */\n	cursor: default;\n}\n\n/* Inline image thumbnails */\ndiv.inline-attachment dl.thumbnail, div.inline-attachment dl.file {\n	display: block;\n	margin-bottom: 4px;\n}\n\ndiv.inline-attachment p {\n	font-size: 100%;\n}\n\ndl.file {\n	font-family: Verdana, Arial, Helvetica, sans-serif;\n	display: block;\n}\n\ndl.file dt {\n	text-transform: none;\n	margin: 0;\n	padding: 0;\n	font-weight: bold;\n	font-family: Verdana, Arial, Helvetica, sans-serif;\n}\n\ndl.file dd {\n	color: #666666;\n	margin: 0;\n	padding: 0;	\n}\n\ndl.thumbnail img {\n	padding: 3px;\n	border: 1px solid #666666;\n	background-color: #FFF;\n}\n\ndl.thumbnail dd {\n	color: #666666;\n	font-style: italic;\n	font-family: Verdana, Arial, Helvetica, sans-serif;\n}\n\n.attachbox dl.thumbnail dd {\n	font-size: 100%;\n}\n\ndl.thumbnail dt a:hover {\n	background-color: #EEEEEE;\n}\n\ndl.thumbnail dt a:hover img {\n	border: 1px solid #d2d2d2;\n}\n\n/* Post poll styles\n----------------------------------------*/\nfieldset.polls {\n	font-family: \"Trebuchet MS\", Verdana, Helvetica, Arial, sans-serif;\n}\n\nfieldset.polls dl {\n	margin-top: 5px;\n	border-top: 1px solid #e2e2e2;\n	padding: 5px 0 0 0;\n	line-height: 120%;\n	color: #666666;\n}\n\nfieldset.polls dl.voted {\n	font-weight: bold;\n	color: #000000;\n}\n\nfieldset.polls dt {\n	text-align: left;\n	float: left;\n	display: block;\n	width: 30%;\n	border-right: none;\n	padding: 0;\n	margin: 0;\n	font-size: 1.1em;\n}\n\nfieldset.polls dd {\n	float: left;\n	width: 10%;\n	border-left: none;\n	padding: 0 5px;\n	margin-left: 0;\n	font-size: 1.1em;\n}\n\nfieldset.polls dd.resultbar {\n	width: 50%;\n}\n\nfieldset.polls dd input {\n	margin: 2px 0;\n}\n\nfieldset.polls dd div {\n	text-align: right;\n	font-family: Arial, Helvetica, sans-serif;\n	color: #FFFFFF;\n	font-weight: bold;\n	padding: 0 2px;\n	overflow: visible;\n	min-width: 2%;\n}\n\n.pollbar1 {\n	background-color: #aaaaaa;\n	border-bottom: 1px solid #747474;\n	border-right: 1px solid #747474;\n}\n\n.pollbar2 {\n	background-color: #bebebe;\n	border-bottom: 1px solid #8c8c8c;\n	border-right: 1px solid #8c8c8c;\n}\n\n.pollbar3 {\n	background-color: #D1D1D1;\n	border-bottom: 1px solid #aaaaaa;\n	border-right: 1px solid #aaaaaa;\n}\n\n.pollbar4 {\n	background-color: #e4e4e4;\n	border-bottom: 1px solid #bebebe;\n	border-right: 1px solid #bebebe;\n}\n\n.pollbar5 {\n	background-color: #f8f8f8;\n	border-bottom: 1px solid #D1D1D1;\n	border-right: 1px solid #D1D1D1;\n}\n\n/* Poster profile block\n----------------------------------------*/\n.postprofile {\n	/* Also see tweaks.css */\n	margin: 5px 0 10px 0;\n	min-height: 80px;\n	color: #666666;\n	border-left: 1px solid #FFFFFF;\n	width: 22%;\n	float: right;\n	display: inline;\n}\n.pm .postprofile {\n	border-left: 1px solid #DDDDDD;\n}\n\n.postprofile dd, .postprofile dt {\n	line-height: 1.2em;\n	margin-left: 8px;\n}\n\n.postprofile strong {\n	font-weight: normal;\n	color: #000000;\n}\n\n.avatar {\n	border: none;\n	margin-bottom: 3px;\n}\n\n.online {\n	background-image: none;\n	background-position: 100% 0;\n	background-repeat: no-repeat;\n}\n\n/* Poster profile used by search*/\n.search .postprofile {\n	width: 30%;\n}\n\n/* pm list in compose message if mass pm is enabled */\ndl.pmlist dt {\n	width: 60% !important;\n}\n\ndl.pmlist dt textarea {\n	width: 95%;\n}\n\ndl.pmlist dd {\n	margin-left: 61% !important;\n	margin-bottom: 2px;\n}\n/* Button Styles\n---------------------------------------- */\n\n/* Rollover buttons\n   Based on: http://wellstyled.com/css-nopreload-rollovers.html\n----------------------------------------*/\n.buttons {\n	float: left;\n	width: auto;\n	height: auto;\n}\n\n/* Rollover state */\n.buttons div {\n	float: left;\n	margin: 0 5px 0 0;\n	background-position: 0 100%;\n}\n\n/* Rolloff state */\n.buttons div a {\n	display: block;\n	width: 100%;\n	height: 100%;\n	background-position: 0 0;\n	position: relative;\n	overflow: hidden;\n}\n\n/* Hide <a> text and hide off-state image when rolling over (prevents flicker in IE) */\n/*.buttons div span		{ display: none; }*/\n/*.buttons div a:hover	{ background-image: none; }*/\n.buttons div span			{ position: absolute; width: 100%; height: 100%; cursor: pointer;}\n.buttons div a:hover span	{ background-position: 0 100%; }\n\n/* Big button images */\n.reply-icon span	{ background: transparent none 0 0 no-repeat; }\n.post-icon span		{ background: transparent none 0 0 no-repeat; }\n.locked-icon span	{ background: transparent none 0 0 no-repeat; }\n.pmreply-icon span	{ background: none 0 0 no-repeat; }\n.newpm-icon span 	{ background: none 0 0 no-repeat; }\n.forwardpm-icon span 	{ background: none 0 0 no-repeat; }\n\n/* Set big button dimensions */\n.buttons div.reply-icon		{ width: {IMG_BUTTON_TOPIC_REPLY_WIDTH}px; height: {IMG_BUTTON_TOPIC_REPLY_HEIGHT}px; }\n.buttons div.post-icon		{ width: {IMG_BUTTON_TOPIC_NEW_WIDTH}px; height: {IMG_BUTTON_TOPIC_NEW_HEIGHT}px; }\n.buttons div.locked-icon	{ width: {IMG_BUTTON_TOPIC_LOCKED_WIDTH}px; height: {IMG_BUTTON_TOPIC_LOCKED_HEIGHT}px; }\n.buttons div.pmreply-icon	{ width: {IMG_BUTTON_PM_REPLY_WIDTH}px; height: {IMG_BUTTON_PM_REPLY_HEIGHT}px; }\n.buttons div.newpm-icon		{ width: {IMG_BUTTON_PM_NEW_WIDTH}px; height: {IMG_BUTTON_PM_NEW_HEIGHT}px; }\n.buttons div.forwardpm-icon	{ width: {IMG_BUTTON_PM_FORWARD_WIDTH}px; height: {IMG_BUTTON_PM_FORWARD_HEIGHT}px; }\n\n/* Sub-header (navigation bar)\n--------------------------------------------- */\na.print, a.sendemail, a.fontsize {\n	display: block;\n	overflow: hidden;\n	height: 18px;\n	text-indent: -5000px;\n	text-align: left;\n	background-repeat: no-repeat;\n}\n\na.print {\n	background-image: none;\n	width: 22px;\n}\n\na.sendemail {\n	background-image: none;\n	width: 22px;\n}\n\na.fontsize {\n	background-image: none;\n	background-position: 0 -1px;\n	width: 29px;\n}\n\na.fontsize:hover {\n	background-position: 0 -20px;\n	text-decoration: none;\n}\n\n/* Icon images\n---------------------------------------- */\n.sitehome, .icon-faq, .icon-members, .icon-home, .icon-ucp, .icon-register, .icon-logout,\n.icon-bookmark, .icon-bump, .icon-subscribe, .icon-unsubscribe, .icon-pages, .icon-search {\n	background-position: 0 50%;\n	background-repeat: no-repeat;\n	background-image: none;\n	padding: 1px 0 0 17px;\n}\n\n/* Poster profile icons\n----------------------------------------*/\nul.profile-icons {\n	padding-top: 10px;\n	list-style: none;\n}\n\n/* Rollover state */\nul.profile-icons li {\n	float: left;\n	margin: 0 6px 3px 0;\n	background-position: 0 100%;\n}\n\n/* Rolloff state */\nul.profile-icons li a {\n	display: block;\n	width: 100%;\n	height: 100%;\n	background-position: 0 0;\n}\n\n/* Hide <a> text and hide off-state image when rolling over (prevents flicker in IE) */\nul.profile-icons li span { display:none; }\nul.profile-icons li a:hover { background: none; }\n\n/* Positioning of moderator icons */\n.postbody ul.profile-icons {\n	float: right;\n	width: auto;\n	padding: 0;\n}\n\n.postbody ul.profile-icons li {\n	margin: 0 3px;\n}\n\n/* Profile & navigation icons */\n.email-icon, .email-icon a		{ background: none top left no-repeat; }\n.aim-icon, .aim-icon a			{ background: none top left no-repeat; }\n.yahoo-icon, .yahoo-icon a		{ background: none top left no-repeat; }\n.web-icon, .web-icon a			{ background: none top left no-repeat; }\n.msnm-icon, .msnm-icon a			{ background: none top left no-repeat; }\n.icq-icon, .icq-icon a			{ background: none top left no-repeat; }\n.jabber-icon, .jabber-icon a		{ background: none top left no-repeat; }\n.pm-icon, .pm-icon a				{ background: none top left no-repeat; }\n.quote-icon, .quote-icon a		{ background: none top left no-repeat; }\n\n/* Moderator icons */\n.report-icon, .report-icon a		{ background: none top left no-repeat; }\n.warn-icon, .warn-icon a			{ background: none top left no-repeat; }\n.edit-icon, .edit-icon a			{ background: none top left no-repeat; }\n.delete-icon, .delete-icon a		{ background: none top left no-repeat; }\n.info-icon, .info-icon a			{ background: none top left no-repeat; }\n\n/* Set profile icon dimensions */\nul.profile-icons li.email-icon		{ width: {IMG_ICON_CONTACT_EMAIL_WIDTH}px; height: {IMG_ICON_CONTACT_EMAIL_HEIGHT}px; }\nul.profile-icons li.aim-icon	{ width: {IMG_ICON_CONTACT_AIM_WIDTH}px; height: {IMG_ICON_CONTACT_AIM_HEIGHT}px; }\nul.profile-icons li.yahoo-icon	{ width: {IMG_ICON_CONTACT_YAHOO_WIDTH}px; height: {IMG_ICON_CONTACT_YAHOO_HEIGHT}px; }\nul.profile-icons li.web-icon	{ width: {IMG_ICON_CONTACT_WWW_WIDTH}px; height: {IMG_ICON_CONTACT_WWW_HEIGHT}px; }\nul.profile-icons li.msnm-icon	{ width: {IMG_ICON_CONTACT_MSNM_WIDTH}px; height: {IMG_ICON_CONTACT_MSNM_HEIGHT}px; }\nul.profile-icons li.icq-icon	{ width: {IMG_ICON_CONTACT_ICQ_WIDTH}px; height: {IMG_ICON_CONTACT_ICQ_HEIGHT}px; }\nul.profile-icons li.jabber-icon	{ width: {IMG_ICON_CONTACT_JABBER_WIDTH}px; height: {IMG_ICON_CONTACT_JABBER_HEIGHT}px; }\nul.profile-icons li.pm-icon		{ width: {IMG_ICON_CONTACT_PM_WIDTH}px; height: {IMG_ICON_CONTACT_PM_HEIGHT}px; }\nul.profile-icons li.quote-icon	{ width: {IMG_ICON_POST_QUOTE_WIDTH}px; height: {IMG_ICON_POST_QUOTE_HEIGHT}px; }\nul.profile-icons li.report-icon	{ width: {IMG_ICON_POST_REPORT_WIDTH}px; height: {IMG_ICON_POST_REPORT_HEIGHT}px; }\nul.profile-icons li.edit-icon	{ width: {IMG_ICON_POST_EDIT_WIDTH}px; height: {IMG_ICON_POST_EDIT_HEIGHT}px; }\nul.profile-icons li.delete-icon	{ width: {IMG_ICON_POST_DELETE_WIDTH}px; height: {IMG_ICON_POST_DELETE_HEIGHT}px; }\nul.profile-icons li.info-icon	{ width: {IMG_ICON_POST_INFO_WIDTH}px; height: {IMG_ICON_POST_INFO_HEIGHT}px; }\nul.profile-icons li.warn-icon	{ width: {IMG_ICON_USER_WARN_WIDTH}px; height: {IMG_ICON_USER_WARN_HEIGHT}px; }\n\n/* Fix profile icon default margins */\nul.profile-icons li.edit-icon	{ margin: 0 0 0 3px; }\nul.profile-icons li.quote-icon	{ margin: 0 0 0 10px; }\nul.profile-icons li.info-icon, ul.profile-icons li.report-icon	{ margin: 0 3px 0 0; }\n/* Control Panel Styles\n---------------------------------------- */\n\n\n/* Main CP box\n----------------------------------------*/\n#cp-menu {\n	float:left;\n	width: 19%;\n	margin-top: 1em;\n	margin-bottom: 5px;\n}\n\n#cp-main {\n	float: left;\n	width: 81%;\n}\n\n#cp-main .content {\n	padding: 0;\n}\n\n#cp-main h3, #cp-main hr, #cp-menu hr {\n	border-color: #bfbfbf;\n}\n\n#cp-main .panel p {\n	font-size: 1.1em;\n}\n\n#cp-main .panel ol {\n	margin-left: 2em;\n	font-size: 1.1em;\n}\n\n#cp-main .panel li.row {\n	border-bottom: 1px solid #cbcbcb;\n	border-top: 1px solid #F9F9F9;\n}\n\nul.cplist {\n	margin-bottom: 5px;\n	border-top: 1px solid #cbcbcb;\n}\n\n#cp-main .panel li.header dd, #cp-main .panel li.header dt {\n	color: #000000;\n	margin-bottom: 2px;\n}\n\n#cp-main table.table1 {\n	margin-bottom: 1em;\n}\n\n#cp-main table.table1 thead th {\n	color: #333333;\n	font-weight: bold;\n	border-bottom: 1px solid #333333;\n	padding: 5px;\n}\n\n#cp-main table.table1 tbody th {\n	font-style: italic;\n	background-color: transparent !important;\n	border-bottom: none;\n}\n\n#cp-main .pagination {\n	float: right;\n	width: auto;\n	padding-top: 1px;\n}\n\n#cp-main .postbody p {\n	font-size: 1.1em;\n}\n\n#cp-main .pm-message {\n	border: 1px solid #e2e2e2;\n	margin: 10px 0;\n	background-color: #FFFFFF;\n	width: auto;\n	float: none;\n}\n\n.pm-message h2 {\n	padding-bottom: 5px;\n}\n\n#cp-main .postbody h3, #cp-main .box2 h3 {\n	margin-top: 0;\n}\n\n#cp-main .buttons {\n	margin-left: 0;\n}\n\n#cp-main ul.linklist {\n	margin: 0;\n}\n\n/* MCP Specific tweaks */\n.mcp-main .postbody {\n	width: 100%;\n}\n\n/* CP tabbed menu\n----------------------------------------*/\n#tabs {\n	line-height: normal;\n	margin: 20px 0 -1px 7px;\n	min-width: 570px;\n}\n\n#tabs ul {\n	margin:0;\n	padding: 0;\n	list-style: none;\n}\n\n#tabs li {\n	display: inline;\n	margin: 0;\n	padding: 0;\n	font-size: 1em;\n	font-weight: bold;\n}\n\n#tabs a {\n	float: left;\n	background: none no-repeat 0% -35px;\n	margin: 0 1px 0 0;\n	padding: 0 0 0 5px;\n	text-decoration: none;\n	position: relative;\n	cursor: pointer;\n}\n\n#tabs a span {\n	float: left;\n	display: block;\n	background: none no-repeat 100% -35px;\n	padding: 6px 10px 6px 5px;\n	color: #828282;\n	white-space: nowrap;\n}\n\n#tabs a:hover span {\n	color: #bcbcbc;\n}\n\n#tabs .activetab a {\n	background-position: 0 0;\n	border-bottom: 1px solid #ebebeb;\n}\n\n#tabs .activetab a span {\n	background-position: 100% 0;\n	padding-bottom: 7px;\n	color: #333333;\n}\n\n#tabs a:hover {\n	background-position: 0 -70px;\n}\n\n#tabs a:hover span {\n	background-position:100% -70px;\n}\n\n#tabs .activetab a:hover {\n	background-position: 0 0;\n}\n\n#tabs .activetab a:hover span {\n	color: #000000;\n	background-position: 100% 0;\n}\n\n/* Mini tabbed menu used in MCP\n----------------------------------------*/\n#minitabs {\n	line-height: normal;\n	margin: -20px 7px 0 0;\n}\n\n#minitabs ul {\n	margin:0;\n	padding: 0;\n	list-style: none;\n}\n\n#minitabs li {\n	display: block;\n	float: right;\n	padding: 0 10px 4px 10px;\n	font-size: 1em;\n	font-weight: bold;\n	background-color: #f2f2f2;\n	margin-left: 2px;\n}\n\n#minitabs a {\n}\n\n#minitabs a:hover {\n	text-decoration: none;\n}\n\n#minitabs li.activetab {\n	background-color: #F9F9F9;\n}\n\n#minitabs li.activetab a, #minitabs li.activetab a:hover {\n	color: #333333;\n}\n\n/* UCP navigation menu\n----------------------------------------*/\n/* Container for sub-navigation list */\n#navigation {\n	width: 100%;\n	padding-top: 36px;\n}\n\n#navigation ul {\n	list-style:none;\n}\n\n/* Default list state */\n#navigation li {\n	margin: 1px 0;\n	padding: 0;\n	font-weight: bold;\n	display: inline;\n}\n\n/* Link styles for the sub-section links */\n#navigation a {\n	display: block;\n	padding: 5px;\n	margin: 1px 0;\n	text-decoration: none;\n	font-weight: bold;\n	color: #333;\n	background: #cfcfcf none repeat-y 100% 0;\n}\n\n#navigation a:hover {\n	text-decoration: none;\n	background-color: #c6c6c6;\n	color: #bcbcbc;\n	background-image: none;\n}\n\n#navigation #active-subsection a {\n	display: block;\n	color: #d3d3d3;\n	background-color: #F9F9F9;\n	background-image: none;\n}\n\n#navigation #active-subsection a:hover {\n	color: #d3d3d3;\n}\n\n/* Preferences pane layout\n----------------------------------------*/\n#cp-main h2 {\n	border-bottom: none;\n	padding: 0;\n	margin-left: 10px;\n	color: #333333;\n}\n\n#cp-main .panel {\n	background-color: #F9F9F9;\n}\n\n#cp-main .pm {\n	background-color: #FFFFFF;\n}\n\n#cp-main span.corners-top, #cp-menu span.corners-top {\n	background-image: none;\n}\n\n#cp-main span.corners-top span, #cp-menu span.corners-top span {\n	background-image: none;\n}\n\n#cp-main span.corners-bottom, #cp-menu span.corners-bottom {\n	background-image: none;\n}\n\n#cp-main span.corners-bottom span, #cp-menu span.corners-bottom span {\n	background-image: none;\n}\n\n/* Topicreview */\n#cp-main .panel #topicreview span.corners-top, #cp-menu .panel #topicreview span.corners-top {\n	background-image: none;\n}\n\n#cp-main .panel #topicreview span.corners-top span, #cp-menu .panel #topicreview span.corners-top span {\n	background-image: none;\n}\n\n#cp-main .panel #topicreview span.corners-bottom, #cp-menu .panel #topicreview span.corners-bottom {\n	background-image: none;\n}\n\n#cp-main .panel #topicreview span.corners-bottom span, #cp-menu .panel #topicreview span.corners-bottom span {\n	background-image: none;\n}\n\n/* Friends list */\n.cp-mini {\n	background-color: #f9f9f9;\n	padding: 0 5px;\n	margin: 10px 15px 10px 5px;\n}\n\n.cp-mini span.corners-top, .cp-mini span.corners-bottom {\n	margin: 0 -5px;\n}\n\ndl.mini dt {\n	font-weight: bold;\n	color: #676767;\n}\n\ndl.mini dd {\n	padding-top: 4px;\n}\n\n.friend-online {\n	font-weight: bold;\n}\n\n.friend-offline {\n	font-style: italic;\n}\n\n/* PM Styles\n----------------------------------------*/\n#pm-menu {\n	line-height: 2.5em;\n}\n\n/* PM panel adjustments */\n.pm-panel-header {\n	margin: 0; \n	padding-bottom: 10px; \n	border-bottom: 1px dashed #A4B3BF;\n}\n\n.reply-all {\n	display: block; \n	padding-top: 4px; \n	clear: both;\n	float: left;\n}\n\n.pm-panel-message {\n	padding-top: 10px;\n}\n\n.pm-return-to {\n	padding-top: 23px;\n}\n\n#cp-main .pm-message-nav {\n	margin: 0; \n	padding: 2px 10px 5px 10px; \n	border-bottom: 1px dashed #A4B3BF;\n}\n\n/* PM Message history */\n.current {\n	color: #999999;\n}\n\n/* Defined rules list for PM options */\nol.def-rules {\n	padding-left: 0;\n}\n\nol.def-rules li {\n	line-height: 180%;\n	padding: 1px;\n}\n\n/* PM marking colours */\n.pmlist li.bg1 {\n	padding: 0 3px;\n}\n\n.pmlist li.bg2 {\n	padding: 0 3px;\n}\n\n.pmlist li.pm_message_reported_colour, .pm_message_reported_colour {\n	border-left-color: #bcbcbc;\n	border-right-color: #bcbcbc;\n}\n\n.pmlist li.pm_marked_colour, .pm_marked_colour {\n	padding: 0;\n	border: solid 3px #ffffff;\n	border-width: 0 3px;\n}\n\n.pmlist li.pm_replied_colour, .pm_replied_colour {\n	padding: 0;\n	border: solid 3px #c2c2c2;\n	border-width: 0 3px;\n}\n\n.pmlist li.pm_friend_colour, .pm_friend_colour {\n	padding: 0;\n	border: solid 3px #bdbdbd;\n	border-width: 0 3px;\n}\n\n.pmlist li.pm_foe_colour, .pm_foe_colour {\n	padding: 0;\n	border: solid 3px #000000;\n	border-width: 0 3px;\n}\n\n.pm-legend {\n	border-left-width: 10px;\n	border-left-style: solid;\n	border-right-width: 0;\n	margin-bottom: 3px;\n	padding-left: 3px;\n}\n\n/* Avatar gallery */\n#gallery label {\n	position: relative;\n	float: left;\n	margin: 10px;\n	padding: 5px;\n	width: auto;\n	background: #FFFFFF;\n	border: 1px solid #CCC;\n	text-align: center;\n}\n\n#gallery label:hover {\n	background-color: #EEE;\n}\n/* Form Styles\n---------------------------------------- */\n\n/* General form styles\n----------------------------------------*/\nfieldset {\n	border-width: 0;\n	font-family: Verdana, Helvetica, Arial, sans-serif;\n	font-size: 1.1em;\n}\n\ninput {\n	font-weight: normal;\n	cursor: pointer;\n	vertical-align: middle;\n	padding: 0 3px;\n	font-size: 1em;\n	font-family: Verdana, Helvetica, Arial, sans-serif;\n}\n\nselect {\n	font-family: Verdana, Helvetica, Arial, sans-serif;\n	font-weight: normal;\n	cursor: pointer;\n	vertical-align: middle;\n	border: 1px solid #666666;\n	padding: 1px;\n	background-color: #FAFAFA;\n	font-size: 1em;\n}\n\noption {\n	padding-right: 1em;\n}\n\noption.disabled-option {\n	color: graytext;\n}\n\ntextarea {\n	font-family: \"Lucida Grande\", Verdana, Helvetica, Arial, sans-serif;\n	width: 60%;\n	padding: 2px;\n	font-size: 1em;\n	line-height: 1.4em;\n}\n\nlabel {\n	cursor: default;\n	padding-right: 5px;\n	color: #676767;\n}\n\nlabel input {\n	vertical-align: middle;\n}\n\nlabel img {\n	vertical-align: middle;\n}\n\n/* Definition list layout for forms\n---------------------------------------- */\nfieldset dl {\n	padding: 4px 0;\n}\n\nfieldset dt {\n	float: left;	\n	width: 40%;\n	text-align: left;\n	display: block;\n}\n\nfieldset dd {\n	margin-left: 41%;\n	vertical-align: top;\n	margin-bottom: 3px;\n}\n\n/* Specific layout 1 */\nfieldset.fields1 dt {\n	width: 15em;\n	border-right-width: 0;\n}\n\nfieldset.fields1 dd {\n	margin-left: 15em;\n	border-left-width: 0;\n}\n\nfieldset.fields1 {\n	background-color: transparent;\n}\n\nfieldset.fields1 div {\n	margin-bottom: 3px;\n}\n\n/* Set it back to 0px for the reCaptcha divs: PHPBB3-9587 */\nfieldset.fields1 #recaptcha_widget_div div {\n	margin-bottom: 0;\n}\n\n/* Specific layout 2 */\nfieldset.fields2 dt {\n	width: 15em;\n	border-right-width: 0;\n}\n\nfieldset.fields2 dd {\n	margin-left: 16em;\n	border-left-width: 0;\n}\n\n/* Form elements */\ndt label {\n	font-weight: bold;\n	text-align: left;\n}\n\ndd label {\n	white-space: nowrap;\n	color: #333;\n}\n\ndd input, dd textarea {\n	margin-right: 3px;\n}\n\ndd select {\n	width: auto;\n}\n\ndd textarea {\n	width: 85%;\n}\n\n/* Hover effects */\nfieldset dl:hover dt label {\n	color: #000000;\n}\n\nfieldset.fields2 dl:hover dt label {\n	color: inherit;\n}\n\n#timezone {\n	width: 95%;\n}\n\n* html #timezone {\n	width: 50%;\n}\n\n/* Quick-login on index page */\nfieldset.quick-login {\n	margin-top: 5px;\n}\n\nfieldset.quick-login input {\n	width: auto;\n}\n\nfieldset.quick-login input.inputbox {\n	width: 15%;\n	vertical-align: middle;\n	margin-right: 5px;\n	background-color: #f3f3f3;\n}\n\nfieldset.quick-login label {\n	white-space: nowrap;\n	padding-right: 2px;\n}\n\n/* Display options on viewtopic/viewforum pages  */\nfieldset.display-options {\n	text-align: center;\n	margin: 3px 0 5px 0;\n}\n\nfieldset.display-options label {\n	white-space: nowrap;\n	padding-right: 2px;\n}\n\nfieldset.display-options a {\n	margin-top: 3px;\n}\n\n/* Display actions for ucp and mcp pages */\nfieldset.display-actions {\n	text-align: right;\n	line-height: 2em;\n	white-space: nowrap;\n	padding-right: 1em;\n}\n\nfieldset.display-actions label {\n	white-space: nowrap;\n	padding-right: 2px;\n}\n\nfieldset.sort-options {\n	line-height: 2em;\n}\n\n/* MCP forum selection*/\nfieldset.forum-selection {\n	margin: 5px 0 3px 0;\n	float: right;\n}\n\nfieldset.forum-selection2 {\n	margin: 13px 0 3px 0;\n	float: right;\n}\n\n/* Jumpbox */\nfieldset.jumpbox {\n	text-align: right;\n	margin-top: 15px;\n	height: 2.5em;\n}\n\nfieldset.quickmod {\n	width: 50%;\n	float: right;\n	text-align: right;\n	height: 2.5em;\n}\n\n/* Submit button fieldset */\nfieldset.submit-buttons {\n	text-align: center;\n	vertical-align: middle;\n	margin: 5px 0;\n}\n\nfieldset.submit-buttons input {\n	vertical-align: middle;\n	padding-top: 3px;\n	padding-bottom: 3px;\n}\n\n/* Posting page styles\n----------------------------------------*/\n\n/* Buttons used in the editor */\n#format-buttons {\n	margin: 15px 0 2px 0;\n}\n\n#format-buttons input, #format-buttons select {\n	vertical-align: middle;\n}\n\n/* Main message box */\n#message-box {\n	width: 80%;\n}\n\n#message-box textarea {\n	font-family: \"Trebuchet MS\", Verdana, Helvetica, Arial, sans-serif;\n	width: 450px;\n	height: 270px;\n	min-width: 100%;\n	max-width: 100%;\n	font-size: 1.2em;\n	color: #333333;\n}\n\n/* Emoticons panel */\n#smiley-box {\n	width: 18%;\n	float: right;\n}\n\n#smiley-box img {\n	margin: 3px;\n}\n\n/* Input field styles\n---------------------------------------- */\n.inputbox {\n	background-color: #FFFFFF;\n	border: 1px solid #c0c0c0;\n	color: #333333;\n	padding: 2px;\n	cursor: text;\n}\n\n.inputbox:hover {\n	border: 1px solid #eaeaea;\n}\n\n.inputbox:focus {\n	border: 1px solid #eaeaea;\n	color: #4b4b4b;\n}\n\ninput.inputbox	{ width: 85%; }\ninput.medium	{ width: 50%; }\ninput.narrow	{ width: 25%; }\ninput.tiny		{ width: 125px; }\n\ntextarea.inputbox {\n	width: 85%;\n}\n\n.autowidth {\n	width: auto !important;\n}\n\n/* Form button styles\n---------------------------------------- */\ninput.button1, input.button2 {\n	font-size: 1em;\n}\n\na.button1, input.button1, input.button3, a.button2, input.button2 {\n	width: auto !important;\n	padding-top: 1px;\n	padding-bottom: 1px;\n	font-family: \"Lucida Grande\", Verdana, Helvetica, Arial, sans-serif;\n	color: #000;\n	background: #FAFAFA none repeat-x top left;\n}\n\na.button1, input.button1 {\n	font-weight: bold;\n	border: 1px solid #666666;\n}\n\ninput.button3 {\n	padding: 0;\n	margin: 0;\n	line-height: 5px;\n	height: 12px;\n	background-image: none;\n	font-variant: small-caps;\n}\n\n/* Alternative button */\na.button2, input.button2, input.button3 {\n	border: 1px solid #666666;\n}\n\n/* <a> button in the style of the form buttons */\na.button1, a.button1:link, a.button1:visited, a.button1:active, a.button2, a.button2:link, a.button2:visited, a.button2:active {\n	text-decoration: none;\n	color: #000000;\n	padding: 2px 8px;\n	line-height: 250%;\n	vertical-align: text-bottom;\n	background-position: 0 1px;\n}\n\n/* Hover states */\na.button1:hover, input.button1:hover, a.button2:hover, input.button2:hover, input.button3:hover {\n	border: 1px solid #BCBCBC;\n	background-position: 0 100%;\n	color: #BCBCBC;\n}\n\ninput.disabled {\n	font-weight: normal;\n	color: #666666;\n}\n\n/* Topic and forum Search */\n.search-box {\n	margin-top: 3px;\n	margin-left: 5px;\n	float: left;\n}\n\n.search-box input {\n}\n\ninput.search {\n	background-image: none;\n	background-repeat: no-repeat;\n	background-position: left 1px;\n	padding-left: 17px;\n}\n\n.full { width: 95%; }\n.medium { width: 50%;}\n.narrow { width: 25%;}\n.tiny { width: 10%;}\n/* Style Sheet Tweaks\n\nThese style definitions are mainly IE specific \ntweaks required due to its poor CSS support.\n-------------------------------------------------*/\n\n* html table, * html select, * html input { font-size: 100%; }\n* html hr { margin: 0; }\n* html span.corners-top, * html span.corners-bottom { background-image: url(\"{T_THEME_PATH}/images/corners_left.gif\"); }\n* html span.corners-top span, * html span.corners-bottom span { background-image: url(\"{T_THEME_PATH}/images/corners_right.gif\"); }\n\ntable.table1 {\n	width: 99%;		/* IE < 6 browsers */\n	/* Tantek hack */\n	voice-family: \"\\\"}\\\"\";\n	voice-family: inherit;\n	width: 100%;\n}\nhtml>body table.table1 { width: 100%; }	/* Reset 100% for opera */\n\n* html ul.topiclist li { position: relative; }\n* html .postbody h3 img { vertical-align: middle; }\n\n/* Form styles */\nhtml>body dd label input { vertical-align: text-bottom; }	/* Align checkboxes/radio buttons nicely */\n\n* html input.button1, * html input.button2 {\n	padding-bottom: 0;\n	margin-bottom: 1px;\n}\n\n/* Misc layout styles */\n* html .column1, * html .column2 { width: 45%; }\n\n/* Nice method for clearing floated blocks without having to insert any extra markup (like spacer above)\n   From http://www.positioniseverything.net/easyclearing.html \n#tabs:after, #minitabs:after, .post:after, .navbar:after, fieldset dl:after, ul.topiclist dl:after, ul.linklist:after, dl.polls:after {\n	content: \".\"; \n	display: block; \n	height: 0; \n	clear: both; \n	visibility: hidden;\n}*/\n\n.clearfix, #tabs, #minitabs, fieldset dl, ul.topiclist dl, dl.polls {\n	height: 1%;\n	overflow: hidden;\n}\n\n/* viewtopic fix */\n* html .post {\n	height: 25%;\n	overflow: hidden;\n}\n\n/* navbar fix */\n* html .clearfix, * html .navbar, ul.linklist {\n	height: 4%;\n	overflow: hidden;\n}\n\n/* Simple fix so forum and topic lists always have a min-height set, even in IE6\n	From http://www.dustindiaz.com/min-height-fast-hack */\ndl.icon {\n	min-height: 35px;\n	height: auto !important;\n	height: 35px;\n}\n\n* html li.row dl.icon dt {\n	height: 35px;\n	overflow: visible;\n}\n\n* html #search-box {\n	width: 25%;\n}\n\n/* Correctly clear floating for details on profile view */\n*:first-child+html dl.details dd {\n	margin-left: 30%;\n	float: none;\n}\n\n* html dl.details dd {\n	margin-left: 30%;\n	float: none;\n}\n\n* html .forumbg table.table1 {\n	margin: 0 -2px 0px -1px;\n}\n\n/* Headerbar height fix for IE7 and below */\n* html #site-description p {\n	margin-bottom: 1.0em;\n}\n\n*:first-child+html #site-description p {\n	margin-bottom: 1.0em;\n}\n/*  	\n--------------------------------------------------------------\nColours and backgrounds for common.css\n-------------------------------------------------------------- */\n\nhtml, body {\n	color: #536482;\n	background-color: #FFFFFF;\n}\n\nh1 {\n	color: #FFFFFF;\n}\n\nh2 {\n	color: #28313F;\n}\n\nh3 {\n	border-bottom-color: #CCCCCC;\n	color: #115098;\n}\n\nhr {\n	border-color: #FFFFFF;\n	border-top-color: #CCCCCC;\n}\n\nhr.dashed {\n	border-top-color: #CCCCCC;\n}\n\n/* Search box\n--------------------------------------------- */\n\n#search-box {\n	color: #FFFFFF;\n}\n\n#search-box #keywords {\n	background-color: #FFF;\n}\n\n#search-box input {\n	border-color: #0075B0;\n}\n\n/* Round cornered boxes and backgrounds\n---------------------------------------- */\n.headerbar {\n	background-color: #12A3EB;\n	background-image: url(\"{T_THEME_PATH}/images/bg_header.gif\");\n	color: #FFFFFF;\n}\n\n.navbar {\n	background-color: #cadceb;\n}\n\n.forabg {\n	background-color: #0076b1;\n	background-image: url(\"{T_THEME_PATH}/images/bg_list.gif\");\n}\n\n.forumbg {\n	background-color: #12A3EB;\n	background-image: url(\"{T_THEME_PATH}/images/bg_header.gif\");\n}\n\n.panel {\n	background-color: #ECF1F3;\n	color: #28313F;\n}\n\n.post:target .content {\n	color: #000000;\n}\n\n.post:target h3 a {\n	color: #000000;\n}\n\n.bg1	{ background-color: #ECF3F7; }\n.bg2	{ background-color: #e1ebf2;  }\n.bg3	{ background-color: #cadceb; }\n\n.ucprowbg {\n	background-color: #DCDEE2;\n}\n\n.fieldsbg {\n	background-color: #E7E8EA;\n}\n\nspan.corners-top {\n	background-image: url(\"{T_THEME_PATH}/images/corners_left.png\");\n}\n\nspan.corners-top span {\n	background-image: url(\"{T_THEME_PATH}/images/corners_right.png\");\n}\n\nspan.corners-bottom {\n	background-image: url(\"{T_THEME_PATH}/images/corners_left.png\");\n}\n\nspan.corners-bottom span {\n	background-image: url(\"{T_THEME_PATH}/images/corners_right.png\");\n}\n\n/* Horizontal lists\n----------------------------------------*/\n\nul.navlinks {\n	border-bottom-color: #FFFFFF;\n}\n\n/* Table styles\n----------------------------------------*/\ntable.table1 thead th {\n	color: #FFFFFF;\n}\n\ntable.table1 tbody tr {\n	border-color: #BFC1CF;\n}\n\ntable.table1 tbody tr:hover, table.table1 tbody tr.hover {\n	background-color: #CFE1F6;\n	color: #000;\n}\n\ntable.table1 td {\n	color: #536482;\n}\n\ntable.table1 tbody td {\n	border-top-color: #FAFAFA;\n}\n\ntable.table1 tbody th {\n	border-bottom-color: #000000;\n	color: #333333;\n	background-color: #FFFFFF;\n}\n\ntable.info tbody th {\n	color: #000000;\n}\n\n/* Misc layout styles\n---------------------------------------- */\ndl.details dt {\n	color: #000000;\n}\n\ndl.details dd {\n	color: #536482;\n}\n\n.sep {\n	color: #1198D9;\n}\n\n/* Pagination\n---------------------------------------- */\n\n.pagination span strong {\n	color: #FFFFFF;\n	background-color: #4692BF;\n	border-color: #4692BF;\n}\n\n.pagination span a, .pagination span a:link, .pagination span a:visited {\n	color: #5C758C;\n	background-color: #ECEDEE;\n	border-color: #B4BAC0;\n}\n\n.pagination span a:hover {\n	border-color: #368AD2;\n	background-color: #368AD2;\n	color: #FFF;\n}\n\n.pagination span a:active {\n	color: #5C758C;\n	background-color: #ECEDEE;\n	border-color: #B4BAC0;\n}\n\n/* Pagination in viewforum for multipage topics */\n.row .pagination {\n	background-image: url(\"{T_THEME_PATH}/images/icon_pages.gif\");\n}\n\n.row .pagination span a, li.pagination span a {\n	background-color: #FFFFFF;\n}\n\n.row .pagination span a:hover, li.pagination span a:hover {\n	background-color: #368AD2;\n}\n\n/* Miscellaneous styles\n---------------------------------------- */\n\n.copyright {\n	color: #555555;\n}\n\n.error {\n	color: #BC2A4D;\n}\n\n.reported {\n	background-color: #F7ECEF;\n}\n\nli.reported:hover {\n	background-color: #ECD5D8 !important;\n}\n.sticky, .announce {\n	/* you can add a background for stickies and announcements*/\n}\n\ndiv.rules {\n	background-color: #ECD5D8;\n	color: #BC2A4D;\n}\n\np.rules {\n	background-color: #ECD5D8;\n	background-image: none;\n}\n\n/*  	\n--------------------------------------------------------------\nColours and backgrounds for links.css\n-------------------------------------------------------------- */\n\na:link	{ color: #105289; }\na:visited	{ color: #105289; }\na:hover	{ color: #D31141; }\na:active	{ color: #368AD2; }\n\n/* Links on gradient backgrounds */\n#search-box a:link, .navbg a:link, .forumbg .header a:link, .forabg .header a:link, th a:link {\n	color: #FFFFFF;\n}\n\n#search-box a:visited, .navbg a:visited, .forumbg .header a:visited, .forabg .header a:visited, th a:visited {\n	color: #FFFFFF;\n}\n\n#search-box a:hover, .navbg a:hover, .forumbg .header a:hover, .forabg .header a:hover, th a:hover {\n	color: #A8D8FF;\n}\n\n#search-box a:active, .navbg a:active, .forumbg .header a:active, .forabg .header a:active, th a:active {\n	color: #C8E6FF;\n}\n\n/* Links for forum/topic lists */\na.forumtitle {\n	color: #105289;\n}\n\n/* a.forumtitle:visited { color: #105289; } */\n\na.forumtitle:hover {\n	color: #BC2A4D;\n}\n\na.forumtitle:active {\n	color: #105289;\n}\n\na.topictitle {\n	color: #105289;\n}\n\n/* a.topictitle:visited { color: #368AD2; } */\n\na.topictitle:hover {\n	color: #BC2A4D;\n}\n\na.topictitle:active {\n	color: #105289;\n}\n\n/* Post body links */\n.postlink {\n	color: #368AD2;\n	border-bottom-color: #368AD2;\n}\n\n.postlink:visited {\n	color: #5D8FBD;\n	border-bottom-color: #5D8FBD;\n}\n\n.postlink:active {\n	color: #368AD2;\n}\n\n.postlink:hover {\n	background-color: #D0E4F6;\n	color: #0D4473;\n}\n\n.signature a, .signature a:visited, .signature a:hover, .signature a:active {\n	background-color: transparent;\n}\n\n/* Profile links */\n.postprofile a:link, .postprofile a:visited, .postprofile dt.author a {\n	color: #105289;\n}\n\n.postprofile a:hover, .postprofile dt.author a:hover {\n	color: #D31141;\n}\n\n.postprofile a:active {\n	color: #105289;\n}\n\n/* Profile searchresults */	\n.search .postprofile a {\n	color: #105289;\n}\n\n.search .postprofile a:hover {\n	color: #D31141;\n}\n\n/* Back to top of page */\na.top {\n	background-image: url(\"{IMG_ICON_BACK_TOP_SRC}\");\n}\n\na.top2 {\n	background-image: url(\"{IMG_ICON_BACK_TOP_SRC}\");\n}\n\n/* Arrow links  */\na.up		{ background-image: url(\"{T_THEME_PATH}/images/arrow_up.gif\") }\na.down		{ background-image: url(\"{T_THEME_PATH}/images/arrow_down.gif\") }\na.left		{ background-image: url(\"{T_THEME_PATH}/images/arrow_left.gif\") }\na.right		{ background-image: url(\"{T_THEME_PATH}/images/arrow_right.gif\") }\n\na.up:hover {\n	background-color: transparent;\n}\n\na.left:hover {\n	color: #368AD2;\n}\n\na.right:hover {\n	color: #368AD2;\n}\n\n\n/*  	\n--------------------------------------------------------------\nColours and backgrounds for content.css\n-------------------------------------------------------------- */\n\nul.forums {\n	background-color: #eef5f9;\n	background-image: url(\"{T_THEME_PATH}/images/gradient.gif\");\n}\n\nul.topiclist li {\n	color: #4C5D77;\n}\n\nul.topiclist dd {\n	border-left-color: #FFFFFF;\n}\n\n.rtl ul.topiclist dd {\n	border-right-color: #fff;\n	border-left-color: transparent;\n}\n\nul.topiclist li.row dt a.subforum.read {\n	background-image: url(\"{IMG_SUBFORUM_READ_SRC}\");\n}\n\nul.topiclist li.row dt a.subforum.unread {\n	background-image: url(\"{IMG_SUBFORUM_UNREAD_SRC}\");\n}\n\nli.row {\n	border-top-color:  #FFFFFF;\n	border-bottom-color: #00608F;\n}\n\nli.row strong {\n	color: #000000;\n}\n\nli.row:hover {\n	background-color: #F6F4D0;\n}\n\nli.row:hover dd {\n	border-left-color: #CCCCCC;\n}\n\n.rtl li.row:hover dd {\n	border-right-color: #CCCCCC;\n	border-left-color: transparent;\n}\n\nli.header dt, li.header dd {\n	color: #FFFFFF;\n}\n\n/* Forum list column styles */\nul.topiclist dd.searchextra {\n	color: #333333;\n}\n\n/* Post body styles\n----------------------------------------*/\n.postbody {\n	color: #333333;\n}\n\n/* Content container styles\n----------------------------------------*/\n.content {\n	color: #333333;\n}\n\n.content h2, .panel h2 {\n	color: #115098;\n	border-bottom-color:  #CCCCCC;\n}\n\ndl.faq dt {\n	color: #333333;\n}\n\n.posthilit {\n	background-color: #F3BFCC;\n	color: #BC2A4D;\n}\n\n/* Post signature */\n.signature {\n	border-top-color: #CCCCCC;\n}\n\n/* Post noticies */\n.notice {\n	border-top-color:  #CCCCCC;\n}\n\n/* BB Code styles\n----------------------------------------*/\n/* Quote block */\nblockquote {\n	background-color: #EBEADD;\n	background-image: url(\"{T_THEME_PATH}/images/quote.gif\");\n	border-color:#DBDBCE;\n}\n\n.rtl blockquote {\n	background-image: url(\"{T_THEME_PATH}/images/quote_rtl.gif\");\n}\n\nblockquote blockquote {\n	/* Nested quotes */\n	background-color:#EFEED9;\n}\n\nblockquote blockquote blockquote {\n	/* Nested quotes */\n	background-color: #EBEADD;\n}\n\n/* Code block */\ndl.codebox {\n	background-color: #FFFFFF;\n	border-color: #C9D2D8;\n}\n\ndl.codebox dt {\n	border-bottom-color:  #CCCCCC;\n}\n\ndl.codebox code {\n	color: #2E8B57;\n}\n\n.syntaxbg		{ color: #FFFFFF; }\n.syntaxcomment	{ color: #FF8000; }\n.syntaxdefault	{ color: #0000BB; }\n.syntaxhtml		{ color: #000000; }\n.syntaxkeyword	{ color: #007700; }\n.syntaxstring	{ color: #DD0000; }\n\n/* Attachments\n----------------------------------------*/\n.attachbox {\n	background-color: #FFFFFF;\n	border-color:  #C9D2D8;\n}\n\n.pm-message .attachbox {\n	background-color: #F2F3F3;\n}\n\n.attachbox dd {\n	border-top-color: #C9D2D8;\n}\n\n.attachbox p {\n	color: #666666;\n}\n\n.attachbox p.stats {\n	color: #666666;\n}\n\n.attach-image img {\n	border-color: #999999;\n}\n\n/* Inline image thumbnails */\n\ndl.file dd {\n	color: #666666;\n}\n\ndl.thumbnail img {\n	border-color: #666666;\n	background-color: #FFFFFF;\n}\n\ndl.thumbnail dd {\n	color: #666666;\n}\n\ndl.thumbnail dt a:hover {\n	background-color: #EEEEEE;\n}\n\ndl.thumbnail dt a:hover img {\n	border-color: #368AD2;\n}\n\n/* Post poll styles\n----------------------------------------*/\n\nfieldset.polls dl {\n	border-top-color: #DCDEE2;\n	color: #666666;\n}\n\nfieldset.polls dl.voted {\n	color: #000000;\n}\n\nfieldset.polls dd div {\n	color: #FFFFFF;\n}\n\n.rtl .pollbar1, .rtl .pollbar2, .rtl .pollbar3, .rtl .pollbar4, .rtl .pollbar5 {\n	border-right-color: transparent;\n}\n\n.pollbar1 {\n	background-color: #AA2346;\n	border-bottom-color: #74162C;\n	border-right-color: #74162C;\n}\n\n.rtl .pollbar1 {\n	border-left-color: #74162C;\n}\n\n.pollbar2 {\n	background-color: #BE1E4A;\n	border-bottom-color: #8C1C38;\n	border-right-color: #8C1C38;\n}\n\n.rtl .pollbar2 {\n	border-left-color: #8C1C38;\n}\n\n.pollbar3 {\n	background-color: #D11A4E;\n	border-bottom-color: #AA2346;\n	border-right-color: #AA2346;\n}\n\n.rtl .pollbar3 {\n	border-left-color: #AA2346;\n}\n\n.pollbar4 {\n	background-color: #E41653;\n	border-bottom-color: #BE1E4A;\n	border-right-color: #BE1E4A;\n}\n\n.rtl .pollbar4 {\n	border-left-color: #BE1E4A;\n}\n\n.pollbar5 {\n	background-color: #F81157;\n	border-bottom-color: #D11A4E;\n	border-right-color: #D11A4E;\n}\n\n.rtl .pollbar5 {\n	border-left-color: #D11A4E;\n}\n\n/* Poster profile block\n----------------------------------------*/\n.postprofile {\n	color: #666666;\n	border-left-color: #FFFFFF;\n}\n\n.rtl .postprofile {\n	border-right-color: #FFFFFF;\n	border-left-color: transparent;\n}\n\n.pm .postprofile {\n	border-left-color: #DDDDDD;\n}\n\n.rtl .pm .postprofile {\n	border-right-color: #DDDDDD;\n	border-left-color: transparent;\n}\n\n.postprofile strong {\n	color: #000000;\n}\n\n.online {\n	background-image: url(\"{IMG_ICON_USER_ONLINE_SRC}\");\n}\n\n/*  	\n--------------------------------------------------------------\nColours and backgrounds for buttons.css\n-------------------------------------------------------------- */\n\n/* Big button images */\n.reply-icon span	{ background-image: url(\"{IMG_BUTTON_TOPIC_REPLY_SRC}\"); }\n.post-icon span		{ background-image: url(\"{IMG_BUTTON_TOPIC_NEW_SRC}\"); }\n.locked-icon span	{ background-image: url(\"{IMG_BUTTON_TOPIC_LOCKED_SRC}\"); }\n.pmreply-icon span	{ background-image: url(\"{IMG_BUTTON_PM_REPLY_SRC}\") ;}\n.newpm-icon span 	{ background-image: url(\"{IMG_BUTTON_PM_NEW_SRC}\") ;}\n.forwardpm-icon span	{ background-image: url(\"{IMG_BUTTON_PM_FORWARD_SRC}\") ;}\n\na.print {\n	background-image: url(\"{T_THEME_PATH}/images/icon_print.gif\");\n}\n\na.sendemail {\n	background-image: url(\"{T_THEME_PATH}/images/icon_sendemail.gif\");\n}\n\na.fontsize {\n	background-image: url(\"{T_THEME_PATH}/images/icon_fontsize.gif\");\n}\n\n/* Icon images\n---------------------------------------- */\n.sitehome						{ background-image: url(\"{T_THEME_PATH}/images/icon_home.gif\"); }\n.icon-faq						{ background-image: url(\"{T_THEME_PATH}/images/icon_faq.gif\"); }\n.icon-members					{ background-image: url(\"{T_THEME_PATH}/images/icon_members.gif\"); }\n.icon-home						{ background-image: url(\"{T_THEME_PATH}/images/icon_home.gif\"); }\n.icon-ucp						{ background-image: url(\"{T_THEME_PATH}/images/icon_ucp.gif\"); }\n.icon-register					{ background-image: url(\"{T_THEME_PATH}/images/icon_register.gif\"); }\n.icon-logout					{ background-image: url(\"{T_THEME_PATH}/images/icon_logout.gif\"); }\n.icon-bookmark					{ background-image: url(\"{T_THEME_PATH}/images/icon_bookmark.gif\"); }\n.icon-bump						{ background-image: url(\"{T_THEME_PATH}/images/icon_bump.gif\"); }\n.icon-subscribe					{ background-image: url(\"{T_THEME_PATH}/images/icon_subscribe.gif\"); }\n.icon-unsubscribe				{ background-image: url(\"{T_THEME_PATH}/images/icon_unsubscribe.gif\"); }\n.icon-pages						{ background-image: url(\"{T_THEME_PATH}/images/icon_pages.gif\"); }\n.icon-search					{ background-image: url(\"{T_THEME_PATH}/images/icon_search.gif\"); }\n\n/* Profile & navigation icons */\n.email-icon, .email-icon a		{ background-image: url(\"{IMG_ICON_CONTACT_EMAIL_SRC}\"); }\n.aim-icon, .aim-icon a			{ background-image: url(\"{IMG_ICON_CONTACT_AIM_SRC}\"); }\n.yahoo-icon, .yahoo-icon a		{ background-image: url(\"{IMG_ICON_CONTACT_YAHOO_SRC}\"); }\n.web-icon, .web-icon a			{ background-image: url(\"{IMG_ICON_CONTACT_WWW_SRC}\"); }\n.msnm-icon, .msnm-icon a			{ background-image: url(\"{IMG_ICON_CONTACT_MSNM_SRC}\"); }\n.icq-icon, .icq-icon a			{ background-image: url(\"{IMG_ICON_CONTACT_ICQ_SRC}\"); }\n.jabber-icon, .jabber-icon a		{ background-image: url(\"{IMG_ICON_CONTACT_JABBER_SRC}\"); }\n.pm-icon, .pm-icon a				{ background-image: url(\"{IMG_ICON_CONTACT_PM_SRC}\"); }\n.quote-icon, .quote-icon a		{ background-image: url(\"{IMG_ICON_POST_QUOTE_SRC}\"); }\n\n/* Moderator icons */\n.report-icon, .report-icon a		{ background-image: url(\"{IMG_ICON_POST_REPORT_SRC}\"); }\n.edit-icon, .edit-icon a			{ background-image: url(\"{IMG_ICON_POST_EDIT_SRC}\"); }\n.delete-icon, .delete-icon a		{ background-image: url(\"{IMG_ICON_POST_DELETE_SRC}\"); }\n.info-icon, .info-icon a			{ background-image: url(\"{IMG_ICON_POST_INFO_SRC}\"); }\n.warn-icon, .warn-icon a			{ background-image: url(\"{IMG_ICON_USER_WARN_SRC}\"); } /* Need updated warn icon */\n\n/*  	\n--------------------------------------------------------------\nColours and backgrounds for cp.css\n-------------------------------------------------------------- */\n\n/* Main CP box\n----------------------------------------*/\n\n#cp-main h3, #cp-main hr, #cp-menu hr {\n	border-color: #A4B3BF;\n}\n\n#cp-main .panel li.row {\n	border-bottom-color: #B5C1CB;\n	border-top-color: #F9F9F9;\n}\n\nul.cplist {\n	border-top-color: #B5C1CB;\n}\n\n#cp-main .panel li.header dd, #cp-main .panel li.header dt {\n	color: #000000;\n}\n\n#cp-main table.table1 thead th {\n	color: #333333;\n	border-bottom-color: #333333;\n}\n\n#cp-main .pm-message {\n	border-color: #DBDEE2;\n	background-color: #FFFFFF;\n}\n\n/* CP tabbed menu\n----------------------------------------*/\n#tabs a {\n	background-image: url(\"{T_THEME_PATH}/images/bg_tabs1.gif\");\n}\n\n#tabs a span {\n	background-image: url(\"{T_THEME_PATH}/images/bg_tabs2.gif\");\n	color: #536482;\n}\n\n#tabs a:hover span {\n	color: #BC2A4D;\n}\n\n#tabs .activetab a {\n	border-bottom-color: #CADCEB;\n}\n\n#tabs .activetab a span {\n	color: #333333;\n}\n\n#tabs .activetab a:hover span {\n	color: #000000;\n}\n\n/* Mini tabbed menu used in MCP\n----------------------------------------*/\n#minitabs li {\n	background-color: #E1EBF2;\n}\n\n#minitabs li.activetab {\n	background-color: #F9F9F9;\n}\n\n#minitabs li.activetab a, #minitabs li.activetab a:hover {\n	color: #333333;\n}\n\n/* UCP navigation menu\n----------------------------------------*/\n\n/* Link styles for the sub-section links */\n#navigation a {\n	color: #333;\n	background-color: #B2C2CF;\n	background-image: url(\"{T_THEME_PATH}/images/bg_menu.gif\");\n}\n\n.rtl #navigation a {\n	background-image: url(\"{T_THEME_PATH}/images/bg_menu_rtl.gif\");\n	background-position: 0 100%;\n}\n\n#navigation a:hover {\n	background-image: none;\n	background-color: #aabac6;\n	color: #BC2A4D;\n}\n\n#navigation #active-subsection a {\n	color: #D31141;\n	background-color: #F9F9F9;\n	background-image: none;\n}\n\n#navigation #active-subsection a:hover {\n	color: #D31141;\n}\n\n/* Preferences pane layout\n----------------------------------------*/\n#cp-main h2 {\n	color: #333333;\n}\n\n#cp-main .panel {\n	background-color: #F9F9F9;\n}\n\n#cp-main .pm {\n	background-color: #FFFFFF;\n}\n\n#cp-main span.corners-top, #cp-menu span.corners-top {\n	background-image: url(\"{T_THEME_PATH}/images/corners_left2.gif\");\n}\n\n#cp-main span.corners-top span, #cp-menu span.corners-top span {\n	background-image: url(\"{T_THEME_PATH}/images/corners_right2.gif\");\n}\n\n#cp-main span.corners-bottom, #cp-menu span.corners-bottom {\n	background-image: url(\"{T_THEME_PATH}/images/corners_left2.gif\");\n}\n\n#cp-main span.corners-bottom span, #cp-menu span.corners-bottom span {\n	background-image: url(\"{T_THEME_PATH}/images/corners_right2.gif\");\n}\n\n/* Topicreview */\n#cp-main .panel #topicreview span.corners-top, #cp-menu .panel #topicreview span.corners-top {\n	background-image: url(\"{T_THEME_PATH}/images/corners_left.gif\");\n}\n\n#cp-main .panel #topicreview span.corners-top span, #cp-menu .panel #topicreview span.corners-top span {\n	background-image: url(\"{T_THEME_PATH}/images/corners_right.gif\");\n}\n\n#cp-main .panel #topicreview span.corners-bottom, #cp-menu .panel #topicreview span.corners-bottom {\n	background-image: url(\"{T_THEME_PATH}/images/corners_left.gif\");\n}\n\n#cp-main .panel #topicreview span.corners-bottom span, #cp-menu .panel #topicreview span.corners-bottom span {\n	background-image: url(\"{T_THEME_PATH}/images/corners_right.gif\");\n}\n\n/* Friends list */\n.cp-mini {\n	background-color: #eef5f9;\n}\n\ndl.mini dt {\n	color: #425067;\n}\n\n/* PM Styles\n----------------------------------------*/\n/* PM Message history */\n.current {\n	color: #000000 !important;\n}\n\n/* PM panel adjustments */\n.pm-panel-header,\n#cp-main .pm-message-nav {\n	border-bottom-color: #A4B3BF;\n}\n\n/* PM marking colours */\n.pmlist li.pm_message_reported_colour, .pm_message_reported_colour {\n	border-left-color: #BC2A4D;\n	border-right-color: #BC2A4D;\n}\n\n.pmlist li.pm_marked_colour, .pm_marked_colour {\n	border-color: #FF6600;\n}\n\n.pmlist li.pm_replied_colour, .pm_replied_colour {\n	border-color: #A9B8C2;\n}\n\n.pmlist li.pm_friend_colour, .pm_friend_colour {\n	border-color: #5D8FBD;\n}\n\n.pmlist li.pm_foe_colour, .pm_foe_colour {\n	border-color: #000000;\n}\n\n/* Avatar gallery */\n#gallery label {\n	background-color: #FFFFFF;\n	border-color: #CCC;\n}\n\n#gallery label:hover {\n	background-color: #EEE;\n}\n\n/*  	\n--------------------------------------------------------------\nColours and backgrounds for forms.css\n-------------------------------------------------------------- */\n\n/* General form styles\n----------------------------------------*/\nselect {\n	border-color: #666666;\n	background-color: #FAFAFA;\n	color: #000;\n}\n\nlabel {\n	color: #425067;\n}\n\noption.disabled-option {\n	color: graytext;\n}\n\n/* Definition list layout for forms\n---------------------------------------- */\ndd label {\n	color: #333;\n}\n\n/* Hover effects */\nfieldset dl:hover dt label {\n	color: #000000;\n}\n\nfieldset.fields2 dl:hover dt label {\n	color: inherit;\n}\n\n/* Quick-login on index page */\nfieldset.quick-login input.inputbox {\n	background-color: #F2F3F3;\n}\n\n/* Posting page styles\n----------------------------------------*/\n\n#message-box textarea {\n	color: #333333;\n}\n\n/* Input field styles\n---------------------------------------- */\n.inputbox {\n	background-color: #FFFFFF; \n	border-color: #B4BAC0;\n	color: #333333;\n}\n\n.inputbox:hover {\n	border-color: #11A3EA;\n}\n\n.inputbox:focus {\n	border-color: #11A3EA;\n	color: #0F4987;\n}\n\n/* Form button styles\n---------------------------------------- */\n\na.button1, input.button1, input.button3, a.button2, input.button2 {\n	color: #000;\n	background-color: #FAFAFA;\n	background-image: url(\"{T_THEME_PATH}/images/bg_button.gif\");\n}\n\na.button1, input.button1 {\n	border-color: #666666;\n}\n\ninput.button3 {\n	background-image: none;\n}\n\n/* Alternative button */\na.button2, input.button2, input.button3 {\n	border-color: #666666;\n}\n\n/* <a> button in the style of the form buttons */\na.button1, a.button1:link, a.button1:visited, a.button1:active, a.button2, a.button2:link, a.button2:visited, a.button2:active {\n	color: #000000;\n}\n\n/* Hover states */\na.button1:hover, input.button1:hover, a.button2:hover, input.button2:hover, input.button3:hover {\n	border-color: #BC2A4D;\n	color: #BC2A4D;\n}\n\ninput.search {\n	background-image: url(\"{T_THEME_PATH}/images/icon_textbox_search.gif\");\n}\n\ninput.disabled {\n	color: #666666;\n}\n');
/*!40000 ALTER TABLE `phpbb_styles_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_topics`
--

DROP TABLE IF EXISTS `phpbb_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_topics` (
  `topic_id` mediumint(8) unsigned NOT NULL auto_increment,
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `icon_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_attachment` tinyint(1) unsigned NOT NULL default '0',
  `topic_approved` tinyint(1) unsigned NOT NULL default '1',
  `topic_reported` tinyint(1) unsigned NOT NULL default '0',
  `topic_title` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL default '',
  `topic_poster` mediumint(8) unsigned NOT NULL default '0',
  `topic_time` int(11) unsigned NOT NULL default '0',
  `topic_time_limit` int(11) unsigned NOT NULL default '0',
  `topic_views` mediumint(8) unsigned NOT NULL default '0',
  `topic_replies` mediumint(8) unsigned NOT NULL default '0',
  `topic_replies_real` mediumint(8) unsigned NOT NULL default '0',
  `topic_status` tinyint(3) NOT NULL default '0',
  `topic_type` tinyint(3) NOT NULL default '0',
  `topic_first_post_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_first_poster_name` varchar(255) collate utf8_bin NOT NULL default '',
  `topic_first_poster_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `topic_last_post_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_last_poster_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_last_poster_name` varchar(255) collate utf8_bin NOT NULL default '',
  `topic_last_poster_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `topic_last_post_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `topic_last_post_time` int(11) unsigned NOT NULL default '0',
  `topic_last_view_time` int(11) unsigned NOT NULL default '0',
  `topic_moved_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_bumped` tinyint(1) unsigned NOT NULL default '0',
  `topic_bumper` mediumint(8) unsigned NOT NULL default '0',
  `poll_title` varchar(255) collate utf8_bin NOT NULL default '',
  `poll_start` int(11) unsigned NOT NULL default '0',
  `poll_length` int(11) unsigned NOT NULL default '0',
  `poll_max_options` tinyint(4) NOT NULL default '1',
  `poll_last_vote` int(11) unsigned NOT NULL default '0',
  `poll_vote_change` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`topic_id`),
  KEY `forum_id` (`forum_id`),
  KEY `forum_id_type` (`forum_id`,`topic_type`),
  KEY `last_post_time` (`topic_last_post_time`),
  KEY `topic_approved` (`topic_approved`),
  KEY `forum_appr_last` (`forum_id`,`topic_approved`,`topic_last_post_id`),
  KEY `fid_time_moved` (`forum_id`,`topic_last_post_time`,`topic_moved_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_topics`
--

LOCK TABLES `phpbb_topics` WRITE;
/*!40000 ALTER TABLE `phpbb_topics` DISABLE KEYS */;
INSERT INTO `phpbb_topics` VALUES (1,2,0,0,1,0,'Welcome to phpBB3',2,1326326102,0,0,0,0,0,0,1,'sergep','AA0000',1,2,'sergep','AA0000','Welcome to phpBB3',1326326102,972086460,0,0,0,'',0,0,1,0,0);
/*!40000 ALTER TABLE `phpbb_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_topics_posted`
--

DROP TABLE IF EXISTS `phpbb_topics_posted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_topics_posted` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_posted` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_topics_posted`
--

LOCK TABLES `phpbb_topics_posted` WRITE;
/*!40000 ALTER TABLE `phpbb_topics_posted` DISABLE KEYS */;
INSERT INTO `phpbb_topics_posted` VALUES (2,1,1);
/*!40000 ALTER TABLE `phpbb_topics_posted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_topics_track`
--

DROP TABLE IF EXISTS `phpbb_topics_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_topics_track` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `mark_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`topic_id`),
  KEY `topic_id` (`topic_id`),
  KEY `forum_id` (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_topics_track`
--

LOCK TABLES `phpbb_topics_track` WRITE;
/*!40000 ALTER TABLE `phpbb_topics_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_topics_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_topics_watch`
--

DROP TABLE IF EXISTS `phpbb_topics_watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_topics_watch` (
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `notify_status` tinyint(1) unsigned NOT NULL default '0',
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`),
  KEY `notify_stat` (`notify_status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_topics_watch`
--

LOCK TABLES `phpbb_topics_watch` WRITE;
/*!40000 ALTER TABLE `phpbb_topics_watch` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_topics_watch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_user_group`
--

DROP TABLE IF EXISTS `phpbb_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_user_group` (
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `group_leader` tinyint(1) unsigned NOT NULL default '0',
  `user_pending` tinyint(1) unsigned NOT NULL default '1',
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  KEY `group_leader` (`group_leader`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_user_group`
--

LOCK TABLES `phpbb_user_group` WRITE;
/*!40000 ALTER TABLE `phpbb_user_group` DISABLE KEYS */;
INSERT INTO `phpbb_user_group` VALUES (1,1,0,0),(2,2,0,0),(4,2,0,0),(5,2,1,0),(6,3,0,0),(6,4,0,0),(6,5,0,0),(6,6,0,0),(6,7,0,0),(6,8,0,0),(6,9,0,0),(6,10,0,0),(6,11,0,0),(6,12,0,0),(6,13,0,0),(6,14,0,0),(6,15,0,0),(6,16,0,0),(6,17,0,0),(6,18,0,0),(6,19,0,0),(6,20,0,0),(6,21,0,0),(6,22,0,0),(6,23,0,0),(6,24,0,0),(6,25,0,0),(6,26,0,0),(6,27,0,0),(6,28,0,0),(6,29,0,0),(6,30,0,0),(6,31,0,0),(6,32,0,0),(6,33,0,0),(6,34,0,0),(6,35,0,0),(6,36,0,0),(6,37,0,0),(6,38,0,0),(6,39,0,0),(6,40,0,0),(6,41,0,0),(6,42,0,0),(6,43,0,0),(6,44,0,0),(6,45,0,0),(6,46,0,0),(6,47,0,0),(6,48,0,0),(6,49,0,0),(6,50,0,0),(6,51,0,0),(6,52,0,0),(6,53,0,0);
/*!40000 ALTER TABLE `phpbb_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_users`
--

DROP TABLE IF EXISTS `phpbb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_users` (
  `user_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_type` tinyint(2) NOT NULL default '0',
  `group_id` mediumint(8) unsigned NOT NULL default '3',
  `user_permissions` mediumtext collate utf8_bin NOT NULL,
  `user_perm_from` mediumint(8) unsigned NOT NULL default '0',
  `user_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `user_regdate` int(11) unsigned NOT NULL default '0',
  `username` varchar(255) collate utf8_bin NOT NULL default '',
  `username_clean` varchar(255) collate utf8_bin NOT NULL default '',
  `user_password` varchar(40) collate utf8_bin NOT NULL default '',
  `user_passchg` int(11) unsigned NOT NULL default '0',
  `user_pass_convert` tinyint(1) unsigned NOT NULL default '0',
  `user_email` varchar(100) collate utf8_bin NOT NULL default '',
  `user_email_hash` bigint(20) NOT NULL default '0',
  `user_birthday` varchar(10) collate utf8_bin NOT NULL default '',
  `user_lastvisit` int(11) unsigned NOT NULL default '0',
  `user_lastmark` int(11) unsigned NOT NULL default '0',
  `user_lastpost_time` int(11) unsigned NOT NULL default '0',
  `user_lastpage` varchar(200) collate utf8_bin NOT NULL default '',
  `user_last_confirm_key` varchar(10) collate utf8_bin NOT NULL default '',
  `user_last_search` int(11) unsigned NOT NULL default '0',
  `user_warnings` tinyint(4) NOT NULL default '0',
  `user_last_warning` int(11) unsigned NOT NULL default '0',
  `user_login_attempts` tinyint(4) NOT NULL default '0',
  `user_inactive_reason` tinyint(2) NOT NULL default '0',
  `user_inactive_time` int(11) unsigned NOT NULL default '0',
  `user_posts` mediumint(8) unsigned NOT NULL default '0',
  `user_lang` varchar(30) collate utf8_bin NOT NULL default '',
  `user_timezone` decimal(5,2) NOT NULL default '0.00',
  `user_dst` tinyint(1) unsigned NOT NULL default '0',
  `user_dateformat` varchar(30) collate utf8_bin NOT NULL default 'd M Y H:i',
  `user_style` mediumint(8) unsigned NOT NULL default '0',
  `user_rank` mediumint(8) unsigned NOT NULL default '0',
  `user_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `user_new_privmsg` int(4) NOT NULL default '0',
  `user_unread_privmsg` int(4) NOT NULL default '0',
  `user_last_privmsg` int(11) unsigned NOT NULL default '0',
  `user_message_rules` tinyint(1) unsigned NOT NULL default '0',
  `user_full_folder` int(11) NOT NULL default '-3',
  `user_emailtime` int(11) unsigned NOT NULL default '0',
  `user_topic_show_days` smallint(4) unsigned NOT NULL default '0',
  `user_topic_sortby_type` varchar(1) collate utf8_bin NOT NULL default 't',
  `user_topic_sortby_dir` varchar(1) collate utf8_bin NOT NULL default 'd',
  `user_post_show_days` smallint(4) unsigned NOT NULL default '0',
  `user_post_sortby_type` varchar(1) collate utf8_bin NOT NULL default 't',
  `user_post_sortby_dir` varchar(1) collate utf8_bin NOT NULL default 'a',
  `user_notify` tinyint(1) unsigned NOT NULL default '0',
  `user_notify_pm` tinyint(1) unsigned NOT NULL default '1',
  `user_notify_type` tinyint(4) NOT NULL default '0',
  `user_allow_pm` tinyint(1) unsigned NOT NULL default '1',
  `user_allow_viewonline` tinyint(1) unsigned NOT NULL default '1',
  `user_allow_viewemail` tinyint(1) unsigned NOT NULL default '1',
  `user_allow_massemail` tinyint(1) unsigned NOT NULL default '1',
  `user_options` int(11) unsigned NOT NULL default '230271',
  `user_avatar` varchar(255) collate utf8_bin NOT NULL default '',
  `user_avatar_type` tinyint(2) NOT NULL default '0',
  `user_avatar_width` smallint(4) unsigned NOT NULL default '0',
  `user_avatar_height` smallint(4) unsigned NOT NULL default '0',
  `user_sig` mediumtext collate utf8_bin NOT NULL,
  `user_sig_bbcode_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `user_sig_bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `user_from` varchar(100) collate utf8_bin NOT NULL default '',
  `user_icq` varchar(15) collate utf8_bin NOT NULL default '',
  `user_aim` varchar(255) collate utf8_bin NOT NULL default '',
  `user_yim` varchar(255) collate utf8_bin NOT NULL default '',
  `user_msnm` varchar(255) collate utf8_bin NOT NULL default '',
  `user_jabber` varchar(255) collate utf8_bin NOT NULL default '',
  `user_website` varchar(200) collate utf8_bin NOT NULL default '',
  `user_occ` text collate utf8_bin NOT NULL,
  `user_interests` text collate utf8_bin NOT NULL,
  `user_actkey` varchar(32) collate utf8_bin NOT NULL default '',
  `user_newpasswd` varchar(40) collate utf8_bin NOT NULL default '',
  `user_form_salt` varchar(32) collate utf8_bin NOT NULL default '',
  `user_new` tinyint(1) unsigned NOT NULL default '1',
  `user_reminded` tinyint(4) NOT NULL default '0',
  `user_reminded_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `username_clean` (`username_clean`),
  KEY `user_birthday` (`user_birthday`),
  KEY `user_email_hash` (`user_email_hash`),
  KEY `user_type` (`user_type`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_users`
--

LOCK TABLES `phpbb_users` WRITE;
/*!40000 ALTER TABLE `phpbb_users` DISABLE KEYS */;
INSERT INTO `phpbb_users` VALUES (1,2,1,'00000000003khra3nk\ni1cjyo000000\ni1cjyo000000',0,'',1326326102,'Anonymous','anonymous','',0,0,'',0,'',0,0,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'d M Y H:i',1,0,'',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','a85aa000fbd4732f',1,0,0),(2,3,5,'zik0zjzik0zjzik0xs\ni1cjyo000000\nzik0zjzhb2tc',0,'89.252.56.204',1326326102,'sergep','sergep','$H$9V3883MEcpe4rHZNT47XX2Ij46igPs1',1326746771,0,'sergep@2kgroup.com',125837203618,'',1326746836,0,0,'ucp.php?i=profile&mode=reg_details','',0,0,0,0,0,0,1,'en','0.00',0,'D M d, Y g:i a',1,1,'AA0000',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,1,230271,'',0,0,0,'','','','','','','','','','','','','','','dbee88f26c6dbe3e',1,0,0),(3,2,6,'',0,'',1326326112,'AdsBot [Google]','adsbot [google]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','6481ba52d4708bb9',0,0,0),(4,2,6,'',0,'',1326326112,'Alexa [Bot]','alexa [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','6ad5b7ec640bebc9',0,0,0),(5,2,6,'',0,'',1326326112,'Alta Vista [Bot]','alta vista [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','0600d14791d72e32',0,0,0),(6,2,6,'',0,'',1326326112,'Ask Jeeves [Bot]','ask jeeves [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','6e3fffd8cbdf876b',0,0,0),(7,2,6,'',0,'',1326326112,'Baidu [Spider]','baidu [spider]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','9bd00ccea3b10be1',0,0,0),(8,2,6,'',0,'',1326326112,'Bing [Bot]','bing [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','44b12d1fa29dae35',0,0,0),(9,2,6,'',0,'',1326326112,'Exabot [Bot]','exabot [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','9867fb923e5d4284',0,0,0),(10,2,6,'',0,'',1326326112,'FAST Enterprise [Crawler]','fast enterprise [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','56d16660f3b79643',0,0,0),(11,2,6,'',0,'',1326326112,'FAST WebCrawler [Crawler]','fast webcrawler [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','25f8f4a9d958270f',0,0,0),(12,2,6,'',0,'',1326326112,'Francis [Bot]','francis [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','4dcb9e405b4b12ca',0,0,0),(13,2,6,'',0,'',1326326112,'Gigabot [Bot]','gigabot [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','bc583ba4abd371ee',0,0,0),(14,2,6,'',0,'',1326326112,'Google Adsense [Bot]','google adsense [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','c83ab025b6472eff',0,0,0),(15,2,6,'',0,'',1326326112,'Google Desktop','google desktop','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','aadae1cc5d103c4f',0,0,0),(16,2,6,'',0,'',1326326112,'Google Feedfetcher','google feedfetcher','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','1eed9ac3f45f6cec',0,0,0),(17,2,6,'',0,'',1326326112,'Google [Bot]','google [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','feac3e431b21e8f9',0,0,0),(18,2,6,'',0,'',1326326112,'Heise IT-Markt [Crawler]','heise it-markt [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','cac61e834745394c',0,0,0),(19,2,6,'',0,'',1326326112,'Heritrix [Crawler]','heritrix [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','2913243f124dd5fc',0,0,0),(20,2,6,'',0,'',1326326112,'IBM Research [Bot]','ibm research [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','5c01bee9e90a665b',0,0,0),(21,2,6,'',0,'',1326326112,'ICCrawler - ICjobs','iccrawler - icjobs','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','63dda194b7144038',0,0,0),(22,2,6,'',0,'',1326326112,'ichiro [Crawler]','ichiro [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','bc132183970ceab7',0,0,0),(23,2,6,'',0,'',1326326112,'Majestic-12 [Bot]','majestic-12 [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','9ab58d5ee79253d4',0,0,0),(24,2,6,'',0,'',1326326112,'Metager [Bot]','metager [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','433e767a8eddef86',0,0,0),(25,2,6,'',0,'',1326326112,'MSN NewsBlogs','msn newsblogs','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','c0d9a7cae0d85cfc',0,0,0),(26,2,6,'',0,'',1326326112,'MSN [Bot]','msn [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','e63137202058a407',0,0,0),(27,2,6,'',0,'',1326326112,'MSNbot Media','msnbot media','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','959135e1b248ceeb',0,0,0),(28,2,6,'',0,'',1326326112,'NG-Search [Bot]','ng-search [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','6e870fef7ba995e2',0,0,0),(29,2,6,'',0,'',1326326112,'Nutch [Bot]','nutch [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','ed8f039f25767f42',0,0,0),(30,2,6,'',0,'',1326326112,'Nutch/CVS [Bot]','nutch/cvs [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','a25284b20d4ac4c5',0,0,0),(31,2,6,'',0,'',1326326112,'OmniExplorer [Bot]','omniexplorer [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','d4f9bc7399f01bb3',0,0,0),(32,2,6,'',0,'',1326326112,'Online link [Validator]','online link [validator]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','ba47d4c2b16f3870',0,0,0),(33,2,6,'',0,'',1326326112,'psbot [Picsearch]','psbot [picsearch]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','70bd6ee6557add5a',0,0,0),(34,2,6,'',0,'',1326326112,'Seekport [Bot]','seekport [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','25177ae41e898566',0,0,0),(35,2,6,'',0,'',1326326112,'Sensis [Crawler]','sensis [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','de29a7c33286fa19',0,0,0),(36,2,6,'',0,'',1326326112,'SEO Crawler','seo crawler','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','76fded8b7018a4ff',0,0,0),(37,2,6,'',0,'',1326326112,'Seoma [Crawler]','seoma [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','8aa04c25955b5a45',0,0,0),(38,2,6,'',0,'',1326326112,'SEOSearch [Crawler]','seosearch [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','8a4115fd45d9577d',0,0,0),(39,2,6,'',0,'',1326326112,'Snappy [Bot]','snappy [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','e329c093e05e04e3',0,0,0),(40,2,6,'',0,'',1326326112,'Steeler [Crawler]','steeler [crawler]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','12ccfb4cc5e6f05d',0,0,0),(41,2,6,'',0,'',1326326112,'Synoo [Bot]','synoo [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','c9519ae33b905629',0,0,0),(42,2,6,'',0,'',1326326112,'Telekom [Bot]','telekom [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','1f1d9dde11910515',0,0,0),(43,2,6,'',0,'',1326326112,'TurnitinBot [Bot]','turnitinbot [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','99d743f250cb03ae',0,0,0),(44,2,6,'',0,'',1326326112,'Voyager [Bot]','voyager [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','e9058f321a193e02',0,0,0),(45,2,6,'',0,'',1326326112,'W3 [Sitesearch]','w3 [sitesearch]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','c980929170cb49b6',0,0,0),(46,2,6,'',0,'',1326326112,'W3C [Linkcheck]','w3c [linkcheck]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','bca51dd7a340985a',0,0,0),(47,2,6,'',0,'',1326326112,'W3C [Validator]','w3c [validator]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','d1d989951cd7d030',0,0,0),(48,2,6,'',0,'',1326326112,'WiseNut [Bot]','wisenut [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','a38f259fc2846456',0,0,0),(49,2,6,'',0,'',1326326112,'YaCy [Bot]','yacy [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','9829b74966a050df',0,0,0),(50,2,6,'',0,'',1326326112,'Yahoo MMCrawler [Bot]','yahoo mmcrawler [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','02a4d2800d5fbad8',0,0,0),(51,2,6,'',0,'',1326326112,'Yahoo Slurp [Bot]','yahoo slurp [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','278c7b5c19cc10cc',0,0,0),(52,2,6,'',0,'',1326326112,'Yahoo [Bot]','yahoo [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','cb6b9871c72edc5b',0,0,0),(53,2,6,'',0,'',1326326112,'YahooSeeker [Bot]','yahooseeker [bot]','',1326326112,0,'',0,'',0,1326326112,0,'','',0,0,0,0,0,0,0,'en','0.00',0,'D M d, Y g:i a',1,0,'9E8DA7',0,0,0,0,-3,0,0,'t','d',0,'t','a',0,1,0,1,1,1,0,230271,'',0,0,0,'','','','','','','','','','','','','','','684b089a224d9f3c',0,0,0);
/*!40000 ALTER TABLE `phpbb_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_warnings`
--

DROP TABLE IF EXISTS `phpbb_warnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_warnings` (
  `warning_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `post_id` mediumint(8) unsigned NOT NULL default '0',
  `log_id` mediumint(8) unsigned NOT NULL default '0',
  `warning_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`warning_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_warnings`
--

LOCK TABLES `phpbb_warnings` WRITE;
/*!40000 ALTER TABLE `phpbb_warnings` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_warnings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_words`
--

DROP TABLE IF EXISTS `phpbb_words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_words` (
  `word_id` mediumint(8) unsigned NOT NULL auto_increment,
  `word` varchar(255) collate utf8_bin NOT NULL default '',
  `replacement` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`word_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_words`
--

LOCK TABLES `phpbb_words` WRITE;
/*!40000 ALTER TABLE `phpbb_words` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_words` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpbb_zebra`
--

DROP TABLE IF EXISTS `phpbb_zebra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpbb_zebra` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `zebra_id` mediumint(8) unsigned NOT NULL default '0',
  `friend` tinyint(1) unsigned NOT NULL default '0',
  `foe` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`zebra_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpbb_zebra`
--

LOCK TABLES `phpbb_zebra` WRITE;
/*!40000 ALTER TABLE `phpbb_zebra` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpbb_zebra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (0,'None',0),(2,'Backoffice user (Restricted access)',2),(3,'Administrator (Full Access)',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `styles`
--

DROP TABLE IF EXISTS `styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `styles` (
  `id` int(11) NOT NULL auto_increment,
  `element` varchar(50) NOT NULL,
  `class` varchar(50) NOT NULL default '',
  `title` varchar(50) NOT NULL,
  `declaration` text,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`element`,`class`),
  UNIQUE KEY `title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `styles`
--

LOCK TABLES `styles` WRITE;
/*!40000 ALTER TABLE `styles` DISABLE KEYS */;
INSERT INTO `styles` VALUES (4,'a','small_pink_down_arrow_at_left','Pink down arrow at left','a:6:{s:5:\"color\";s:4:\"#f09\";s:10:\"background\";s:54:\"url(images/small_pink_down_arrow.gif) no-repeat 0% 4px\";s:9:\"font-size\";s:4:\"15px\";s:11:\"font-weight\";s:4:\"bold\";s:11:\"font-family\";s:5:\"Arial\";s:12:\"padding-left\";s:4:\"20px\";}'),(9,'a','system_button','System button','a:0:{}'),(3,'p','content_simple_text','13px simple text','a:3:{s:5:\"color\";s:4:\"#333\";s:9:\"font-size\";s:4:\"13px\";s:11:\"font-family\";s:5:\"Arial\";}'),(5,'a','pink_microbox_at_left','Pink micro-box at left','a:8:{s:5:\"float\";s:4:\"left\";s:5:\"color\";s:4:\"#036\";s:10:\"background\";s:47:\"url(images/pink_microbox.gif) no-repeat 0% 5px;\";s:9:\"font-size\";s:4:\"12px\";s:11:\"font-weight\";s:4:\"bold\";s:11:\"font-family\";s:5:\"Arial\";s:11:\"margin-left\";s:4:\"45px\";s:12:\"padding-left\";s:3:\"8px\";}'),(6,'a','system_button2','System button 2','a:6:{s:5:\"color\";s:4:\"#036\";s:10:\"background\";s:50:\"url(images/imgArrowPinkBig.gif) no-repeat 100% 1px\";s:9:\"font-size\";s:4:\"12px\";s:11:\"font-weight\";s:4:\"bold\";s:11:\"font-family\";s:5:\"Arial\";s:13:\"padding-right\";s:4:\"19px\";}'),(7,'p','content_simple_text_lm','13px simple text lm','a:4:{s:5:\"color\";s:4:\"#333\";s:9:\"font-size\";s:4:\"13px\";s:11:\"font-family\";s:5:\"Arial\";s:11:\"margin-left\";s:4:\"60px\";}'),(8,'p','pink_15_lm','Pink 15px lm','a:5:{s:5:\"color\";s:4:\"#f09\";s:9:\"font-size\";s:4:\"15px\";s:11:\"font-weight\";s:4:\"bold\";s:11:\"font-family\";s:5:\"Arial\";s:11:\"margin-left\";s:4:\"60px\";}'),(10,'a','faq_question','FAQ question','a:4:{s:5:\"color\";s:4:\"#036\";s:9:\"font-size\";s:4:\"13px\";s:11:\"font-weight\";s:4:\"bold\";s:11:\"font-family\";s:5:\"Arial\";}'),(11,'ol','content_simple_text','OL simple text','a:3:{s:5:\"color\";s:4:\"#333\";s:9:\"font-size\";s:4:\"13px\";s:11:\"font-family\";s:5:\"Arial\";}');
/*!40000 ALTER TABLE `styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpl_files`
--

DROP TABLE IF EXISTS `tpl_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpl_files` (
  `id` int(11) NOT NULL auto_increment,
  `file_name` varchar(100) NOT NULL default '',
  `type` int(11) NOT NULL default '0',
  `description` text,
  `cachable` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `file_name` (`file_name`),
  KEY `type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpl_files`
--

LOCK TABLES `tpl_files` WRITE;
/*!40000 ALTER TABLE `tpl_files` DISABLE KEYS */;
INSERT INTO `tpl_files` VALUES (1,'index',0,NULL,'1'),(2,'internal',0,NULL,'1'),(3,'login',0,NULL,'1'),(4,'filters',0,NULL,'1'),(5,'search',0,NULL,'1'),(6,'sitemap',0,NULL,'1'),(7,'rss_news',0,NULL,'1'),(8,'news_published',0,NULL,'1'),(9,'subscription_form',0,NULL,'1'),(10,'unsubscription_form',0,NULL,'1'),(11,'form_builder',0,NULL,'1'),(12,'media_doc',1,NULL,'1'),(13,'media_image',1,NULL,'1'),(14,'media_flash',1,NULL,'1'),(15,'subscribe_thanks',0,NULL,'1'),(16,'subscribe_confirm_thanks',0,NULL,'1'),(17,'unsubscribe_thanks',0,NULL,'1'),(18,'unsubscribe_confirm_thanks',0,NULL,'1'),(19,'subscribe_newsletter',0,NULL,'1'),(20,'unsubscribe_newsletter',0,NULL,'1'),(21,'subscribe_error',0,NULL,'1'),(22,'nl_notification',2,NULL,'1'),(24,'ap_respondent_edit_profile_form',0,'','1'),(25,'ap_respondent_register_form',0,'','1'),(27,'ap_password_reminder',0,'','1'),(28,'ap_respondent_reset_password_check_email',0,'','1'),(29,'ap_respondent_enter_password',0,'','1'),(31,'ap_sitemap',0,'','1'),(32,'error_404',0,'','1'),(33,'current_projects',0,'','1'),(34,'ap_respondent_enter_password_approv',0,'','1'),(35,'ap_respondent_enter_password_remind',0,'','1'),(36,'survey_history',0,'','1'),(37,'points_convertion',0,'','1'),(38,'ap_login_form',0,'','1'),(39,'int_why_register',0,'','1'),(40,'int_advantages',0,'','1'),(41,'faq',0,'','1'),(42,'int_simple',0,'','1'),(43,'int_project_complete',0,'','1'),(44,'int_news',0,'','1'),(45,'int_investigations',0,'Investigations','1'),(46,'ap_respondent_activate',0,'','0');
/*!40000 ALTER TABLE `tpl_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpl_folder`
--

DROP TABLE IF EXISTS `tpl_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpl_folder` (
  `id` int(11) NOT NULL auto_increment,
  `folder` varchar(50) NOT NULL default '',
  `create_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `edit_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `owner_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `folder` (`folder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpl_folder`
--

LOCK TABLES `tpl_folder` WRITE;
/*!40000 ALTER TABLE `tpl_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `tpl_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpl_pages`
--

DROP TABLE IF EXISTS `tpl_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpl_pages` (
  `id` int(11) NOT NULL auto_increment,
  `page_name` varchar(50) NOT NULL default '',
  `extension` enum('html','htm','xml') NOT NULL default 'html',
  `page_description` varchar(255) default NULL,
  `default_page` int(11) NOT NULL default '0',
  `create_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `edit_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `tpl_id` int(11) default NULL,
  `folder_id` int(11) default NULL,
  `for_search` int(11) default '1',
  `owner_name` varchar(45) default NULL,
  `is_locked` int(11) NOT NULL default '0',
  `group_access` int(11) NOT NULL default '1',
  `priority` varchar(4) default NULL,
  `cachable` enum('0','1') NOT NULL default '1',
  `change_freq` enum('always','hourly','daily','weekly','monthly','yearly','never') default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `page_name` (`page_name`,`folder_id`),
  KEY `for_search_idx` (`for_search`),
  KEY `is_locked_idx` (`is_locked`),
  KEY `folder_id` (`folder_id`),
  CONSTRAINT `tpl_pages_ibfk_1` FOREIGN KEY (`folder_id`) REFERENCES `tpl_pages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpl_pages`
--

LOCK TABLES `tpl_pages` WRITE;
/*!40000 ALTER TABLE `tpl_pages` DISABLE KEYS */;
INSERT INTO `tpl_pages` VALUES (1,'index','html','Перша сторінка',1,'2009-11-14 21:07:33','2010-04-20 14:33:47',1,NULL,1,NULL,0,1,NULL,'1',NULL),(2,'login','html','Description of login',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',3,NULL,1,NULL,0,1,NULL,'1',NULL),(9,'sitemap','html','Description of sitemap',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',6,NULL,0,NULL,0,1,NULL,'1',NULL),(10,'rss','html','News in RSS format',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',7,NULL,0,NULL,0,1,NULL,'1',NULL),(11,'news_rss','html','Description of News RSS',0,'2009-11-14 21:07:33','2010-01-21 16:11:06',7,NULL,1,NULL,0,1,NULL,'1',NULL),(12,'subscribe_newsletter','html','subscribe_newsletter',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',9,NULL,1,NULL,0,1,NULL,'1',NULL),(13,'unsubscribe_newsletter','html','unsubscribe_newsletter',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',10,NULL,1,NULL,0,1,NULL,'1',NULL),(14,'newsletter_subscribe_notification','html','newsletter_subscribe_notification',0,'2009-11-14 21:07:33','2010-01-18 18:05:18',14,NULL,1,NULL,0,1,NULL,'1',NULL),(15,'newsletter_unsubscribe_notification','html','newsletter_unsubscribe_notification',0,'2009-11-14 21:07:33','2010-01-18 18:05:18',14,NULL,1,NULL,0,1,NULL,'1',NULL),(16,'subscribe_newsletter','html','subscribe_newsletter',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',19,NULL,1,NULL,0,1,NULL,'1',NULL),(17,'unsubscribe_newsletter','html','unsubscribe_newsletter',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',20,NULL,1,NULL,0,1,NULL,'1',NULL),(18,'subscribe_thanks','html','subscribe_thanks',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',15,NULL,1,NULL,0,1,NULL,'1',NULL),(19,'newsletter_subscribe_notification','html','newsletter_subscribe_notification',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',22,NULL,1,NULL,0,1,NULL,'1',NULL),(20,'newsletter_unsubscribe_notification','html','newsletter_unsubscribe_notification',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',22,NULL,1,NULL,0,1,NULL,'1',NULL),(21,'subscribe_confirm_thanks','html','subscribe_confirm_thanks',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',16,NULL,1,NULL,0,1,NULL,'1',NULL),(22,'unsubscribe_thanks','html','unsubscribe_thanks',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',17,NULL,1,NULL,0,1,NULL,'1',NULL),(23,'unsubscribe_confirm_thanks','html','unsubscribe_confirm_thanks',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',18,NULL,1,NULL,0,1,NULL,'1',NULL),(24,'subscribe_error','html','subscribe_error',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',21,NULL,1,NULL,0,1,NULL,'1',NULL),(25,'subscribe_error','html','subscribe_error',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',21,NULL,1,NULL,0,1,NULL,'1',NULL),(26,'subscribe_newsletter','html','subscribe_newsletter',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',19,NULL,1,NULL,0,1,NULL,'1',NULL),(27,'unsubscribe_newsletter','html','unsubscribe_newsletter',0,'2009-11-14 21:07:33','2009-11-14 21:07:33',20,NULL,1,NULL,0,1,NULL,'1',NULL),(28,'TNS_v_Ukrajini','html','TNS в Україні',0,'2009-11-16 10:18:48','2009-12-25 14:41:51',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(29,'vidpividalnist','html','Відповідальність',0,'2009-11-16 10:19:42','2010-01-14 15:54:20',42,NULL,1,'Admin',0,1,NULL,'1',NULL),(30,'survey-history','html','Історія опитувань',0,'2009-11-16 10:20:14','2010-01-18 19:05:40',36,NULL,1,'Admin',0,1,NULL,'1',NULL),(31,'konvertacija_baliv','html','Конвертація балів',0,'2009-11-16 10:20:56','2010-04-14 17:58:55',37,NULL,1,'Admin',0,1,NULL,'0',NULL),(32,'Kontakty','html','Контакти',0,'2009-11-16 10:22:12','2010-01-13 14:34:32',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(33,'Konfedincijnist','html','Конфіденційність',0,'2009-11-16 10:22:42','2010-04-14 18:39:21',42,NULL,1,'Admin',0,1,NULL,'1',NULL),(34,'mapa_sajtu','html','Мапа сайту',0,'2009-11-16 10:23:17','2009-12-25 14:39:31',31,NULL,1,'Admin',0,1,NULL,'1',NULL),(35,'my_Opros','html','Ми Opros',0,'2009-11-16 10:23:47','2010-03-29 17:52:57',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(36,'moji_baly','html','Мої бали',0,'2009-11-16 10:42:00','2010-04-14 18:43:10',2,NULL,1,'Admin',0,1,NULL,'0',NULL),(37,'user-profile','html','Мої особисті дані',0,'2009-11-16 10:42:38','2010-01-18 19:07:30',24,NULL,1,'Admin',0,1,NULL,'1',NULL),(38,'Mij_Opros','html','Мій Opros',0,'2009-11-16 10:43:11','2010-04-14 18:44:48',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(39,'navishcho_reestruvatys','html','Навіщо реєструватись',0,'2009-11-16 10:43:43','2010-01-12 16:15:19',39,NULL,1,'Admin',0,1,NULL,'1',NULL),(40,'news','html','Новини',0,'2009-11-16 10:44:21','2010-04-14 18:49:04',44,NULL,1,'Admin',0,1,NULL,'0',NULL),(41,'ostanni_novyny','html','Останні новини',0,'2009-11-16 10:44:55','2010-04-14 18:50:17',2,NULL,1,'Admin',0,1,NULL,'0',NULL),(42,'perevagy_opros','html','Переваги TNS Opros',0,'2009-11-16 10:45:29','2010-04-13 13:06:31',40,NULL,1,'Admin',0,1,NULL,'1',NULL),(43,'pidsumky_doslidzhen','html','Підсумки досліджень',0,'2009-11-16 10:46:09','2009-12-25 14:40:09',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(44,'pozhiva_dlya_rozdumiv','html','Пожива для роздумів',0,'2009-11-16 10:46:48','2009-12-25 14:45:53',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(45,'potochni_proekty','html','Поточні проекти',0,'2009-11-16 10:47:18','2009-12-25 14:47:37',33,NULL,1,'Admin',0,1,NULL,'1',NULL),(46,'pravyla_uchasti','html','Правила участі',0,'2009-11-16 10:47:53','2010-01-14 15:55:32',42,NULL,1,'Admin',0,1,NULL,'1',NULL),(47,'forma_reestracii','html','Форма реєстрації',0,'2009-11-16 10:48:22','2010-03-20 06:28:04',25,NULL,1,'Admin',0,1,NULL,'0',NULL),(48,'pro_opros','html','Про TNS Opros',0,'2009-11-16 10:49:06','2010-04-13 13:07:10',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(49,'pro_TNS_ta_opros','html','Про TNS та Opros',0,'2009-11-16 10:49:37','2010-04-13 13:07:41',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(50,'50','html','Проекти',0,'2009-11-16 10:50:11','2010-04-14 19:06:32',2,NULL,1,'Admin',0,1,NULL,'0',NULL),(51,'rezultaty_doslidzhen','html','Результати досліджень',0,'2009-11-16 10:50:41','2010-01-29 14:37:14',45,NULL,1,'Admin',0,1,NULL,'1',NULL),(52,'systema_zaohochennya','html','Система заохочення',0,'2009-11-16 10:51:23','2009-12-25 14:51:02',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(53,'statystyka_vidviduvan','html','Статистика відвідувань',0,'2009-11-16 10:51:58','2009-12-25 14:51:33',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(55,'misija_opros','html','Місія TNS Opros',0,'2009-11-16 11:10:40','2010-04-13 13:08:24',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(57,'57','html','Відновлення паролю (форма вводу email)',0,'2009-11-26 11:44:00','2010-03-20 05:29:46',27,NULL,1,'Admin',0,1,NULL,'0',NULL),(59,'respondent-registration-approve','html','Форма підтвердження реєстрації',0,'2009-11-26 12:41:53','2010-03-20 06:16:50',34,NULL,1,'Admin',0,1,NULL,'0',NULL),(60,'respondent-password-update','html','Оновлення паролю (форма для вводу нового паролю)',0,'2009-11-26 12:44:05','2010-03-20 06:10:03',35,NULL,1,'Admin',0,1,NULL,'0',NULL),(61,'respondent-registered-success','html','Реєстрацію завершено успішно',0,'2009-12-10 16:01:56','2010-01-14 18:12:51',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(62,'respondent_registration_approved_success','html','Реєстрацію завершено остаточно, пароль збережено.',0,'2009-12-11 10:36:12','2009-12-11 10:36:12',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(63,'page_not_found','html','404',0,'2009-12-11 14:41:48','2009-12-13 12:03:25',32,NULL,1,'Admin',0,1,NULL,'1',NULL),(64,'password_reminde_sended','html','Надіслано інструкції що до відновлення паролю',0,'2009-12-25 10:16:13','2009-12-25 10:16:13',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(65,'password_update_success','html','Новий пароль збережено',0,'2009-12-25 12:06:37','2009-12-25 12:06:37',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(66,'respondent_updated','html','Персональні дані оновлено',0,'2009-12-25 13:38:56','2009-12-25 13:38:56',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(67,'ap_forbidden','html','Немає доступу',0,'2009-12-29 21:55:04','2009-12-29 21:55:04',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(68,'Authorization','html','Авторизація',0,'2010-01-05 23:45:01','2010-04-12 14:30:54',38,NULL,0,'Admin',0,1,NULL,'0',NULL),(69,'tns_new_year','html','Сніжинки',0,'2010-01-08 13:48:26','2010-03-04 16:25:51',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(70,'main_block_about_36_6_header','html','',0,'2010-01-08 13:54:20','2010-01-18 18:05:18',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(71,'main_block_about_36_6','html','',0,'2010-01-08 13:54:20','2010-01-29 12:11:41',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(72,'main_block_news_header','html','',0,'2010-01-08 13:54:20','2010-04-13 10:06:41',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(73,'main_block_news','html','',0,'2010-01-08 13:54:20','2010-01-29 12:11:59',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(74,'main_block_join_header','html','',0,'2010-01-08 13:54:20','2010-04-13 10:04:25',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(75,'main_block_pryednajtes','html','',0,'2010-01-08 13:54:21','2010-01-29 12:12:24',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(76,'main_block_about_tns_header','html','',0,'2010-01-08 13:54:21','2010-04-13 10:00:32',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(77,'my_36_6_header','html','',0,'2010-01-11 08:15:54','2010-01-18 18:05:18',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(78,'current_projects_header','html','',0,'2010-01-11 08:17:33','2010-01-18 18:05:18',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(79,'darts_arrow','html','',0,'2010-01-12 16:16:31','2010-01-29 12:02:42',13,NULL,0,'Admin',0,1,NULL,'1',NULL),(80,'uah_sign','html','',0,'2010-01-12 16:46:34','2010-01-29 12:03:49',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(81,'handshake','html','',0,'2010-01-12 18:24:59','2010-01-29 12:04:07',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(84,'quotes','html','',0,'2010-01-12 18:41:00','2010-04-22 13:40:08',14,NULL,0,'Admin',0,1,NULL,'0',NULL),(85,'quotes_with_text','html','',0,'2010-01-12 18:51:31','2010-04-13 12:52:39',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(86,'faq','html','Питання що часто задаються',0,'2010-01-13 11:37:30','2010-01-13 11:37:30',41,NULL,1,'Admin',0,1,NULL,'1',NULL),(88,'project_complete','html','Завершення проекту',0,'2010-01-18 18:14:11','2010-01-18 18:16:37',43,NULL,1,'Admin',0,1,NULL,'1',NULL),(89,'new','html','',0,'2010-01-19 08:28:41','2010-01-19 08:28:41',2,NULL,1,'viktor',0,1,NULL,'1',NULL),(90,'password_updated_success','html','Новий пароль збережено',0,'2010-01-19 11:56:40','2010-01-19 11:56:40',2,NULL,1,'Admin',0,1,NULL,'1',NULL),(91,'91','html','flash_el_advantages',0,'2010-01-30 13:30:09','2010-01-30 13:31:34',14,NULL,0,'Admin',0,1,NULL,'0',NULL),(92,'tns_March_8','html','Girl with flower and smile',0,'2010-03-04 15:13:43','2010-03-04 15:16:56',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(93,'respondent_activate','html','Активація',0,'2010-04-09 13:19:41','2010-04-09 14:07:12',46,NULL,0,'Admin',0,1,NULL,'0',NULL),(94,'shapka_surveys','html','',0,'2010-04-13 08:23:52','2010-04-13 10:03:17',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(95,'shapka_pro_opros','html','',0,'2010-04-13 08:25:55','2010-04-13 10:02:58',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(96,'shapka_miy_opros','html','',0,'2010-04-13 08:26:29','2010-04-13 10:00:53',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(97,'top_main','html','',0,'2010-04-19 07:57:21','2010-11-24 10:19:17',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(98,'gifts','html','',0,'2010-04-19 10:28:29','2010-04-19 10:28:39',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(99,'akciya','html','Умови акції',0,'2010-04-19 10:33:08','2010-04-19 10:33:38',42,NULL,1,'Admin',0,1,NULL,'1',NULL),(100,'100','html','',0,'2010-04-20 11:02:23','2010-04-20 12:37:02',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(101,'invitation_sent_success','html','Запрошення надіслано успішно',0,'2010-07-13 12:49:20','2010-07-13 12:49:20',42,NULL,0,'Admin',0,1,NULL,'0',NULL),(102,'top_discover','html','top_discover',0,'2011-01-11 16:15:19','2011-08-10 08:38:41',13,NULL,0,'Admin',0,1,NULL,'0',NULL),(103,'help_eachother','html','',0,'2011-02-18 14:55:12','2011-02-18 14:55:55',13,NULL,0,'Admin',0,1,NULL,'0',NULL);
/*!40000 ALTER TABLE `tpl_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpl_views`
--

DROP TABLE IF EXISTS `tpl_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpl_views` (
  `id` int(11) NOT NULL auto_increment,
  `view_name` varchar(100) default NULL,
  `view_folder` varchar(100) NOT NULL,
  `description` text,
  `icon` varchar(150) default NULL,
  `is_default` enum('1') default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `view_folder` (`view_folder`),
  UNIQUE KEY `view_name` (`view_name`),
  UNIQUE KEY `is_default` (`is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpl_views`
--

LOCK TABLES `tpl_views` WRITE;
/*!40000 ALTER TABLE `tpl_views` DISABLE KEYS */;
INSERT INTO `tpl_views` VALUES (1,'s','html','simple','doc.png','1');
/*!40000 ALTER TABLE `tpl_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_mapping_object`
--

DROP TABLE IF EXISTS `url_mapping_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_mapping_object` (
  `id` int(11) NOT NULL auto_increment,
  `target_url` varchar(255) NOT NULL,
  `language` char(2) NOT NULL,
  `tpl_view` int(11) default NULL,
  `object_record_id` int(11) NOT NULL,
  `object_view` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `url_mapping_object_target_url` (`target_url`),
  KEY `url_mapping_object_language_idx` (`language`),
  KEY `url_mapping_object_tpl_view_idx` (`tpl_view`),
  KEY `url_mapping_object_record_id` (`object_record_id`),
  KEY `url_mapping_object_object_view` (`object_view`),
  CONSTRAINT `url_mapping_object_ibfk_1` FOREIGN KEY (`language`) REFERENCES `language` (`language_code`),
  CONSTRAINT `url_mapping_object_ibfk_2` FOREIGN KEY (`tpl_view`) REFERENCES `tpl_views` (`id`),
  CONSTRAINT `url_mapping_object_ibfk_3` FOREIGN KEY (`object_record_id`) REFERENCES `object_record` (`id`),
  CONSTRAINT `url_mapping_object_ibfk_4` FOREIGN KEY (`object_view`) REFERENCES `tpl_files` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_mapping_object`
--

LOCK TABLES `url_mapping_object` WRITE;
/*!40000 ALTER TABLE `url_mapping_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `url_mapping_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `group_name` varchar(250) NOT NULL,
  `group_code` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_code` (`group_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(150) default NULL,
  `login` varchar(50) default NULL,
  `passw` varchar(50) default NULL,
  `email` varchar(150) default NULL,
  `status` int(11) default '1',
  `role` int(11) default '0',
  `content_access` int(11) default NULL,
  `comment` text,
  `icq` int(11) default NULL,
  `city` varchar(50) default NULL,
  `resetpassw` int(11) default '1',
  `ip` varchar(20) default NULL,
  `browser` varchar(50) default NULL,
  `login_datetime` datetime default NULL,
  `month_visits` int(11) default NULL,
  `passw_update_datetime` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `login_idx` (`login`),
  KEY `status_idx` (`status`),
  KEY `role_idx` (`role`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','root','64306313b693cdc49241199449a6a3f6','...@2kgroup.com',1,3,NULL,'Full access',NULL,'',0,'10.2.1.68','Internet Explorer 8.0','2011-09-19 13:43:59',4,'2010-01-21 19:54:57'),(2,'admin','admin','06ffd971cb908550d220791c56cc6240','kostyaz@2kgroup.com',1,3,4,'',NULL,'',0,'91.200.192.6','Firefox 3.5.5 (.NET CLR 3.5.30729)','2010-01-19 10:18:43',3,'2010-01-18 21:48:16'),(3,'viktor','viktor','b2e0775187b751e83d7b901c67310081','tortiki@ukr.net',1,3,4,'',NULL,'',0,'91.200.192.6','Firefox 3.5.5 (.NET CLR 3.5.30729)','2010-01-19 10:20:25',1,'2010-01-19 10:20:25');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_channel_db`
--

DROP TABLE IF EXISTS `v_channel_db`;
/*!50001 DROP VIEW IF EXISTS `v_channel_db`*/;
/*!50001 CREATE TABLE `v_channel_db` (
  `id` varchar(139),
  `language` char(2),
  `channel_id` longtext,
  `status` longtext,
  `author` longtext,
  `channel_type` longtext,
  `title` longtext,
  `description` longtext,
  `rss` longtext,
  `copyright` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_channel_edit`
--

DROP TABLE IF EXISTS `v_channel_edit`;
/*!50001 DROP VIEW IF EXISTS `v_channel_edit`*/;
/*!50001 CREATE TABLE `v_channel_edit` (
  `channel_id` longtext,
  `title` longtext,
  `description` longtext,
  `status` longtext,
  `author` longtext,
  `channel_type` longtext,
  `copyright` longtext,
  `rss` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_channel_grid`
--

DROP TABLE IF EXISTS `v_channel_grid`;
/*!50001 DROP VIEW IF EXISTS `v_channel_grid`*/;
/*!50001 CREATE TABLE `v_channel_grid` (
  `channel_id` longtext,
  `title` longtext,
  `status` varchar(8),
  `author` longtext,
  `channel_type` longtext,
  `rss` varchar(3)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_dns`
--

DROP TABLE IF EXISTS `v_dns`;
/*!50001 DROP VIEW IF EXISTS `v_dns`*/;
/*!50001 CREATE TABLE `v_dns` (
  `id` int(11),
  `dns` varchar(255),
  `comment` text,
  `status` int(11),
  `language_forwarding` char(2),
  `draft_mode` tinyint(1),
  `cdn_server` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_dns_edit`
--

DROP TABLE IF EXISTS `v_dns_edit`;
/*!50001 DROP VIEW IF EXISTS `v_dns_edit`*/;
/*!50001 CREATE TABLE `v_dns_edit` (
  `id` int(11),
  `dns` varchar(255),
  `comment` text,
  `status` int(11),
  `language_forwarding` char(2),
  `draft_mode` tinyint(1),
  `cdn_server` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_dns_grid`
--

DROP TABLE IF EXISTS `v_dns_grid`;
/*!50001 DROP VIEW IF EXISTS `v_dns_grid`*/;
/*!50001 CREATE TABLE `v_dns_grid` (
  `id` int(11),
  `dns` varchar(255),
  `comment` text,
  `status` varchar(8),
  `language_forwarding` char(2),
  `draft_mode` tinyint(1)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_events_db`
--

DROP TABLE IF EXISTS `v_events_db`;
/*!50001 DROP VIEW IF EXISTS `v_events_db`*/;
/*!50001 CREATE TABLE `v_events_db` (
  `id` varchar(140),
  `language` char(2),
  `news_id` longtext,
  `title` longtext,
  `description` longtext,
  `SystemDate` longtext,
  `SystemDate_d` varchar(10),
  `ExpiryDate` longtext,
  `ExpiryDate_d` varchar(10),
  `DisplayDate` longtext,
  `PublishedDate` longtext,
  `PublishedDate_d` varchar(10),
  `status` longtext,
  `channel_id` longtext,
  `show_on_home` longtext,
  `category` longtext,
  `status_text` varchar(9)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_lang_edit`
--

DROP TABLE IF EXISTS `v_lang_edit`;
/*!50001 DROP VIEW IF EXISTS `v_lang_edit`*/;
/*!50001 CREATE TABLE `v_lang_edit` (
  `id` char(2),
  `language_url` char(10),
  `language_name` varchar(30),
  `language_link_title` char(0),
  `l_encode` varchar(50),
  `paypal_lang` char(2),
  `status` int(11),
  `is_default` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_lang_grid`
--

DROP TABLE IF EXISTS `v_lang_grid`;
/*!50001 DROP VIEW IF EXISTS `v_lang_grid`*/;
/*!50001 CREATE TABLE `v_lang_grid` (
  `language_code` char(2),
  `language_url` char(10),
  `language_name` varchar(30),
  `language_link_title` longtext,
  `l_encode` varchar(50),
  `paypal_lang` char(2),
  `status` varchar(8),
  `default_language` varchar(3)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_language`
--

DROP TABLE IF EXISTS `v_language`;
/*!50001 DROP VIEW IF EXISTS `v_language`*/;
/*!50001 CREATE TABLE `v_language` (
  `language_code` char(2),
  `language_url` char(10),
  `language_name` varchar(30),
  `l_encode` varchar(50),
  `paypal_lang` char(2),
  `language_of_browser` char(50),
  `status` int(11),
  `default_language` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_mail_inbox_edit`
--

DROP TABLE IF EXISTS `v_mail_inbox_edit`;
/*!50001 DROP VIEW IF EXISTS `v_mail_inbox_edit`*/;
/*!50001 CREATE TABLE `v_mail_inbox_edit` (
  `id` int(11),
  `name` varchar(100),
  `email` varchar(50),
  `send_date` varchar(21),
  `add_info` text
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_mail_inbox_grid`
--

DROP TABLE IF EXISTS `v_mail_inbox_grid`;
/*!50001 DROP VIEW IF EXISTS `v_mail_inbox_grid`*/;
/*!50001 CREATE TABLE `v_mail_inbox_grid` (
  `id` int(11),
  `name` varchar(100),
  `email` varchar(50),
  `send_date` datetime,
  `message` text,
  `add_info` text,
  `viewed` varchar(3)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_mailing_edit`
--

DROP TABLE IF EXISTS `v_mailing_edit`;
/*!50001 DROP VIEW IF EXISTS `v_mailing_edit`*/;
/*!50001 CREATE TABLE `v_mailing_edit` (
  `id` int(11),
  `original_id` int(11),
  `subject` varchar(255),
  `date_reg` datetime,
  `from_` longtext,
  `status` varchar(255),
  `recipients_count` varchar(45)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_mailing_grid`
--

DROP TABLE IF EXISTS `v_mailing_grid`;
/*!50001 DROP VIEW IF EXISTS `v_mailing_grid`*/;
/*!50001 CREATE TABLE `v_mailing_grid` (
  `id` int(11),
  `original_id` int(11),
  `subject` varchar(255),
  `date_reg` datetime,
  `from_` longtext,
  `status` varchar(255),
  `recipients_count` varchar(45)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_media`
--

DROP TABLE IF EXISTS `v_media`;
/*!50001 DROP VIEW IF EXISTS `v_media`*/;
/*!50001 CREATE TABLE `v_media` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_media_content`
--

DROP TABLE IF EXISTS `v_media_content`;
/*!50001 DROP VIEW IF EXISTS `v_media_content`*/;
/*!50001 CREATE TABLE `v_media_content` (
  `id` int(11),
  `page_name` longtext,
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `cachable` enum('0','1'),
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_media_edit`
--

DROP TABLE IF EXISTS `v_media_edit`;
/*!50001 DROP VIEW IF EXISTS `v_media_edit`*/;
/*!50001 CREATE TABLE `v_media_edit` (
  `id` int(11),
  `page_name` varchar(50),
  `media_description` varchar(255),
  `template` int(11),
  `folder` int(11),
  `size` char(0),
  `alt_tag` char(0),
  `zip_file_name` char(0),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_media_file`
--

DROP TABLE IF EXISTS `v_media_file`;
/*!50001 DROP VIEW IF EXISTS `v_media_file`*/;
/*!50001 CREATE TABLE `v_media_file` (
  `id` int(11),
  `file_name` varchar(100),
  `type` int(11),
  `description` text,
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_media_grid`
--

DROP TABLE IF EXISTS `v_media_grid`;
/*!50001 DROP VIEW IF EXISTS `v_media_grid`*/;
/*!50001 CREATE TABLE `v_media_grid` (
  `id` int(11),
  `media_name` longtext,
  `media_description` varchar(255),
  `template` varchar(104),
  `folder` longtext,
  `edit_date` timestamp,
  `cachable` varchar(3),
  `in_draft_state` varchar(3),
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_ms_mail`
--

DROP TABLE IF EXISTS `v_ms_mail`;
/*!50001 DROP VIEW IF EXISTS `v_ms_mail`*/;
/*!50001 CREATE TABLE `v_ms_mail` (
  `id` int(11),
  `original_id` int(11),
  `subject` varchar(255),
  `date_reg` datetime,
  `body` longtext,
  `from_` longtext,
  `status` varchar(255),
  `recipients_count` varchar(45)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_ms_recipient`
--

DROP TABLE IF EXISTS `v_ms_recipient`;
/*!50001 DROP VIEW IF EXISTS `v_ms_recipient`*/;
/*!50001 CREATE TABLE `v_ms_recipient` (
  `id` int(11),
  `ms_mail_id` int(11),
  `recipient` varchar(255),
  `date_update` datetime,
  `status` varchar(255),
  `recipient_id` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_news_edit`
--

DROP TABLE IF EXISTS `v_news_edit`;
/*!50001 DROP VIEW IF EXISTS `v_news_edit`*/;
/*!50001 CREATE TABLE `v_news_edit` (
  `news_id` longtext,
  `title` longtext,
  `description` longtext,
  `status` longtext,
  `category` longtext,
  `show_on_home` longtext,
  `channel_id` longtext,
  `SystemDate` longtext,
  `ExpiryDate` longtext,
  `PublishedDate` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_news_grid`
--

DROP TABLE IF EXISTS `v_news_grid`;
/*!50001 DROP VIEW IF EXISTS `v_news_grid`*/;
/*!50001 CREATE TABLE `v_news_grid` (
  `news_id` longtext,
  `title` longtext,
  `status` varchar(9),
  `category` longtext,
  `channel_id` longtext,
  `SystemDate` longtext,
  `ExpiryDate` longtext,
  `PublishedDate` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_news_letters_edit`
--

DROP TABLE IF EXISTS `v_news_letters_edit`;
/*!50001 DROP VIEW IF EXISTS `v_news_letters_edit`*/;
/*!50001 CREATE TABLE `v_news_letters_edit` (
  `id` int(11),
  `email_from_name` varchar(255),
  `email_from_email` varchar(255),
  `email_subject` longtext,
  `email_tpl` varchar(255),
  `email_body` longtext,
  `email_header` longtext,
  `group_count` bigint(21),
  `subscr_count` bigint(21),
  `email_status` varchar(7),
  `email_transaction_id` int(11),
  `finish_date` varbinary(30),
  `ip_address` varchar(50),
  `create_date` timestamp
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_news_letters_grid`
--

DROP TABLE IF EXISTS `v_news_letters_grid`;
/*!50001 DROP VIEW IF EXISTS `v_news_letters_grid`*/;
/*!50001 CREATE TABLE `v_news_letters_grid` (
  `id` int(11),
  `from_name` varchar(255),
  `from_email` varchar(255),
  `subject` longtext,
  `status` varchar(7),
  `Finish Date` varchar(10),
  `ip_address` varchar(50),
  `create_date` timestamp
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_email`
--

DROP TABLE IF EXISTS `v_nl_email`;
/*!50001 DROP VIEW IF EXISTS `v_nl_email`*/;
/*!50001 CREATE TABLE `v_nl_email` (
  `email_id` int(11),
  `email_from_name` varchar(255),
  `email_from_email` varchar(255),
  `email_subject` varchar(255),
  `email_tpl` varchar(255),
  `email_body` longtext,
  `email_header` longtext,
  `group_count` bigint(21),
  `subscr_count` bigint(21),
  `email_status` varchar(6),
  `email_transaction_id` int(11),
  `finish_date` varbinary(30),
  `ip_address` varchar(50),
  `create_date` timestamp
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_email_edit`
--

DROP TABLE IF EXISTS `v_nl_email_edit`;
/*!50001 DROP VIEW IF EXISTS `v_nl_email_edit`*/;
/*!50001 CREATE TABLE `v_nl_email_edit` (
  `email_id` int(11),
  `email_from_name` varchar(255),
  `email_from_email` varchar(255),
  `email_subject` varchar(255),
  `email_tpl` varchar(255),
  `email_body` longtext,
  `email_header` longtext,
  `group_count` bigint(21),
  `subscr_count` bigint(21),
  `email_status` varchar(6),
  `email_transaction_id` int(11),
  `finish_date` varbinary(30),
  `ip_address` varchar(50),
  `create_date` timestamp
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_email_grid`
--

DROP TABLE IF EXISTS `v_nl_email_grid`;
/*!50001 DROP VIEW IF EXISTS `v_nl_email_grid`*/;
/*!50001 CREATE TABLE `v_nl_email_grid` (
  `email_id` int(11),
  `email_from_name` varchar(255),
  `email_from_email` varchar(255),
  `email_subject` varchar(255),
  `email_header` longtext,
  `email_status` varchar(6),
  `finish_date` varbinary(30),
  `ip_address` varchar(50),
  `create_date` timestamp
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_group`
--

DROP TABLE IF EXISTS `v_nl_group`;
/*!50001 DROP VIEW IF EXISTS `v_nl_group`*/;
/*!50001 CREATE TABLE `v_nl_group` (
  `id` int(11),
  `group_name` varchar(255),
  `show_on_front` int(11),
  `letters_count` bigint(21),
  `subscr_count` bigint(21)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_groups_edit`
--

DROP TABLE IF EXISTS `v_nl_groups_edit`;
/*!50001 DROP VIEW IF EXISTS `v_nl_groups_edit`*/;
/*!50001 CREATE TABLE `v_nl_groups_edit` (
  `id` int(11),
  `group_name` varchar(255),
  `show_on_front` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_groups_grid`
--

DROP TABLE IF EXISTS `v_nl_groups_grid`;
/*!50001 DROP VIEW IF EXISTS `v_nl_groups_grid`*/;
/*!50001 CREATE TABLE `v_nl_groups_grid` (
  `id` int(11),
  `group_name` varchar(255),
  `show_on_front` int(11),
  `letters_count` bigint(21),
  `subscr_count` bigint(21)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_notification`
--

DROP TABLE IF EXISTS `v_nl_notification`;
/*!50001 DROP VIEW IF EXISTS `v_nl_notification`*/;
/*!50001 CREATE TABLE `v_nl_notification` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1'),
  `change_freq` enum('always','hourly','daily','weekly','monthly','yearly','never'),
  `subject` longtext,
  `from_email` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_notification_edit`
--

DROP TABLE IF EXISTS `v_nl_notification_edit`;
/*!50001 DROP VIEW IF EXISTS `v_nl_notification_edit`*/;
/*!50001 CREATE TABLE `v_nl_notification_edit` (
  `id` int(11),
  `notification_type` varchar(50),
  `from_email` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_notification_grid`
--

DROP TABLE IF EXISTS `v_nl_notification_grid`;
/*!50001 DROP VIEW IF EXISTS `v_nl_notification_grid`*/;
/*!50001 CREATE TABLE `v_nl_notification_grid` (
  `id` int(11),
  `notification_type` varchar(50),
  `subject` longtext,
  `from_email` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_subscriber`
--

DROP TABLE IF EXISTS `v_nl_subscriber`;
/*!50001 DROP VIEW IF EXISTS `v_nl_subscriber`*/;
/*!50001 CREATE TABLE `v_nl_subscriber` (
  `id` int(11),
  `email` varchar(255),
  `nl_group_id` int(11),
  `reg_date` datetime,
  `last_send` datetime,
  `ip_address` varchar(50),
  `subscriber_status` varchar(50),
  `confirm_code` bigint(20),
  `status` int(2),
  `company` char(255),
  `first_name` varchar(50),
  `sur_name` varchar(50),
  `city` char(255),
  `group_name` varchar(255),
  `language` char(2),
  `letters_count` bigint(21)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_subscribers_edit`
--

DROP TABLE IF EXISTS `v_nl_subscribers_edit`;
/*!50001 DROP VIEW IF EXISTS `v_nl_subscribers_edit`*/;
/*!50001 CREATE TABLE `v_nl_subscribers_edit` (
  `id` int(11),
  `email` varchar(255),
  `group_name` varchar(255),
  `status` varchar(50),
  `company` char(255),
  `first_name` varchar(50),
  `sur_name` varchar(50),
  `city` char(255),
  `language` char(2),
  `ip_address` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_nl_subscribers_grid`
--

DROP TABLE IF EXISTS `v_nl_subscribers_grid`;
/*!50001 DROP VIEW IF EXISTS `v_nl_subscribers_grid`*/;
/*!50001 CREATE TABLE `v_nl_subscribers_grid` (
  `id` int(11),
  `email` varchar(255),
  `status` varchar(50),
  `company` char(255),
  `first_name` varchar(50),
  `sur_name` varchar(50),
  `city` char(255),
  `group_name` varchar(255),
  `language` char(2),
  `reg_date` datetime,
  `last_send` datetime,
  `ip_address` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object`
--

DROP TABLE IF EXISTS `v_object`;
/*!50001 DROP VIEW IF EXISTS `v_object`*/;
/*!50001 CREATE TABLE `v_object` (
  `id` int(11),
  `name` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_content`
--

DROP TABLE IF EXISTS `v_object_content`;
/*!50001 DROP VIEW IF EXISTS `v_object_content`*/;
/*!50001 CREATE TABLE `v_object_content` (
  `object_field_id` int(11),
  `object_record_id` int(11),
  `value` text,
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_content_edit`
--

DROP TABLE IF EXISTS `v_object_content_edit`;
/*!50001 DROP VIEW IF EXISTS `v_object_content_edit`*/;
/*!50001 CREATE TABLE `v_object_content_edit` (
  `object_field_id` int(11),
  `object_record_id` int(11),
  `value` text,
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_content_grid`
--

DROP TABLE IF EXISTS `v_object_content_grid`;
/*!50001 DROP VIEW IF EXISTS `v_object_content_grid`*/;
/*!50001 CREATE TABLE `v_object_content_grid` (
  `object_field_id` int(11),
  `object_record_id` int(11),
  `value` text,
  `language` char(2),
  `object_name` varchar(50),
  `object_field_name` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_edit`
--

DROP TABLE IF EXISTS `v_object_edit`;
/*!50001 DROP VIEW IF EXISTS `v_object_edit`*/;
/*!50001 CREATE TABLE `v_object_edit` (
  `id` int(11),
  `name` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_field`
--

DROP TABLE IF EXISTS `v_object_field`;
/*!50001 DROP VIEW IF EXISTS `v_object_field`*/;
/*!50001 CREATE TABLE `v_object_field` (
  `id` int(11),
  `object_id` int(11),
  `object_field_name` varchar(50),
  `object_field_type` varchar(20),
  `one_for_all_languages` int(1)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_field_edit`
--

DROP TABLE IF EXISTS `v_object_field_edit`;
/*!50001 DROP VIEW IF EXISTS `v_object_field_edit`*/;
/*!50001 CREATE TABLE `v_object_field_edit` (
  `id` int(11),
  `object_id` int(11),
  `object_field_name` varchar(50),
  `object_field_type` varchar(20),
  `one_for_all_languages` int(1)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_field_grid`
--

DROP TABLE IF EXISTS `v_object_field_grid`;
/*!50001 DROP VIEW IF EXISTS `v_object_field_grid`*/;
/*!50001 CREATE TABLE `v_object_field_grid` (
  `id` int(11),
  `object` varchar(50),
  `object_field_name` varchar(50),
  `object_field_type` varchar(20),
  `one_for_all_languages` int(1)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_field_type`
--

DROP TABLE IF EXISTS `v_object_field_type`;
/*!50001 DROP VIEW IF EXISTS `v_object_field_type`*/;
/*!50001 CREATE TABLE `v_object_field_type` (
  `id` int(11),
  `object_field_type` varchar(20),
  `one_for_all_languages` int(1)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_field_type_edit`
--

DROP TABLE IF EXISTS `v_object_field_type_edit`;
/*!50001 DROP VIEW IF EXISTS `v_object_field_type_edit`*/;
/*!50001 CREATE TABLE `v_object_field_type_edit` (
  `id` int(11),
  `object_field_type` varchar(20),
  `one_for_all_languages` int(1)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_field_type_grid`
--

DROP TABLE IF EXISTS `v_object_field_type_grid`;
/*!50001 DROP VIEW IF EXISTS `v_object_field_type_grid`*/;
/*!50001 CREATE TABLE `v_object_field_type_grid` (
  `id` int(11),
  `object_field_type` varchar(20),
  `one_for_all_languages` varchar(3)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_grid`
--

DROP TABLE IF EXISTS `v_object_grid`;
/*!50001 DROP VIEW IF EXISTS `v_object_grid`*/;
/*!50001 CREATE TABLE `v_object_grid` (
  `id` int(11),
  `name` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_record`
--

DROP TABLE IF EXISTS `v_object_record`;
/*!50001 DROP VIEW IF EXISTS `v_object_record`*/;
/*!50001 CREATE TABLE `v_object_record` (
  `id` int(11),
  `object_id` int(11),
  `last_update` timestamp,
  `user_name` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_record_edit`
--

DROP TABLE IF EXISTS `v_object_record_edit`;
/*!50001 DROP VIEW IF EXISTS `v_object_record_edit`*/;
/*!50001 CREATE TABLE `v_object_record_edit` (
  `id` int(11),
  `object_id` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_record_grid`
--

DROP TABLE IF EXISTS `v_object_record_grid`;
/*!50001 DROP VIEW IF EXISTS `v_object_record_grid`*/;
/*!50001 CREATE TABLE `v_object_record_grid` (
  `id` int(11),
  `object_id` int(11),
  `user_name` varchar(50),
  `last_update` timestamp,
  `name` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_template`
--

DROP TABLE IF EXISTS `v_object_template`;
/*!50001 DROP VIEW IF EXISTS `v_object_template`*/;
/*!50001 CREATE TABLE `v_object_template` (
  `id` int(11),
  `object_id` int(11),
  `template_id` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_template_edit`
--

DROP TABLE IF EXISTS `v_object_template_edit`;
/*!50001 DROP VIEW IF EXISTS `v_object_template_edit`*/;
/*!50001 CREATE TABLE `v_object_template_edit` (
  `id` int(11),
  `object_id` int(11),
  `template_id` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_object_template_grid`
--

DROP TABLE IF EXISTS `v_object_template_grid`;
/*!50001 DROP VIEW IF EXISTS `v_object_template_grid`*/;
/*!50001 CREATE TABLE `v_object_template_grid` (
  `id` int(11),
  `object_name` varchar(50),
  `template_name` varchar(100)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_permanent_redirect_edit`
--

DROP TABLE IF EXISTS `v_permanent_redirect_edit`;
/*!50001 DROP VIEW IF EXISTS `v_permanent_redirect_edit`*/;
/*!50001 CREATE TABLE `v_permanent_redirect_edit` (
  `id` int(11),
  `source_url` varchar(255),
  `target_url` varchar(255),
  `url` char(0),
  `page_id` int(11),
  `lang_code` char(2),
  `t_view` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_permanent_redirect_grid`
--

DROP TABLE IF EXISTS `v_permanent_redirect_grid`;
/*!50001 DROP VIEW IF EXISTS `v_permanent_redirect_grid`*/;
/*!50001 CREATE TABLE `v_permanent_redirect_grid` (
  `id` int(11),
  `source_url` varchar(255),
  `target_url` varchar(255),
  `page_id` int(11),
  `lang_code` char(2),
  `t_view` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_search_tpl_pages`
--

DROP TABLE IF EXISTS `v_search_tpl_pages`;
/*!50001 DROP VIEW IF EXISTS `v_search_tpl_pages`*/;
/*!50001 CREATE TABLE `v_search_tpl_pages` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1'),
  `change_freq` enum('always','hourly','daily','weekly','monthly','yearly','never'),
  `language_code` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_styles_edit`
--

DROP TABLE IF EXISTS `v_styles_edit`;
/*!50001 DROP VIEW IF EXISTS `v_styles_edit`*/;
/*!50001 CREATE TABLE `v_styles_edit` (
  `id` int(11),
  `element` varchar(50),
  `class` varchar(50),
  `title` varchar(50),
  `declaration` text
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_styles_grid`
--

DROP TABLE IF EXISTS `v_styles_grid`;
/*!50001 DROP VIEW IF EXISTS `v_styles_grid`*/;
/*!50001 CREATE TABLE `v_styles_grid` (
  `id` int(11),
  `element` varchar(50),
  `class` varchar(50),
  `title` varchar(50),
  `sample_text` text
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_file`
--

DROP TABLE IF EXISTS `v_tpl_file`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_file`*/;
/*!50001 CREATE TABLE `v_tpl_file` (
  `id` int(11),
  `file_name` varchar(100),
  `description` text,
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_file_edit`
--

DROP TABLE IF EXISTS `v_tpl_file_edit`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_file_edit`*/;
/*!50001 CREATE TABLE `v_tpl_file_edit` (
  `id` int(11),
  `file_name` varchar(100),
  `description` text,
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_file_grid`
--

DROP TABLE IF EXISTS `v_tpl_file_grid`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_file_grid`*/;
/*!50001 CREATE TABLE `v_tpl_file_grid` (
  `id` int(11),
  `file_name` varchar(100),
  `description` text,
  `cachable` varchar(3)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_folder`
--

DROP TABLE IF EXISTS `v_tpl_folder`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder`*/;
/*!50001 CREATE TABLE `v_tpl_folder` (
  `id` int(11),
  `page_name` varchar(50),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_folder_content`
--

DROP TABLE IF EXISTS `v_tpl_folder_content`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder_content`*/;
/*!50001 CREATE TABLE `v_tpl_folder_content` (
  `id` int(11),
  `page_name` longtext,
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_folder_edit`
--

DROP TABLE IF EXISTS `v_tpl_folder_edit`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder_edit`*/;
/*!50001 CREATE TABLE `v_tpl_folder_edit` (
  `id` int(11),
  `page_name` varchar(50),
  `page_description` varchar(255),
  `create_date` timestamp,
  `edit_date` timestamp,
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `group_access` int(11),
  `folder_groups` char(0)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_folder_grid`
--

DROP TABLE IF EXISTS `v_tpl_folder_grid`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder_grid`*/;
/*!50001 CREATE TABLE `v_tpl_folder_grid` (
  `id` int(11),
  `folder` longtext,
  `folder_description` varchar(255),
  `is_locked` int(11),
  `owner_name` varchar(45),
  `items_count` bigint(21),
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_non_folder`
--

DROP TABLE IF EXISTS `v_tpl_non_folder`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder`*/;
/*!50001 CREATE TABLE `v_tpl_non_folder` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_non_folder_content`
--

DROP TABLE IF EXISTS `v_tpl_non_folder_content`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder_content`*/;
/*!50001 CREATE TABLE `v_tpl_non_folder_content` (
  `id` int(11),
  `page_name` longtext,
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `language` char(2),
  `priority` varchar(4)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_non_folder_statistic`
--

DROP TABLE IF EXISTS `v_tpl_non_folder_statistic`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder_statistic`*/;
/*!50001 CREATE TABLE `v_tpl_non_folder_statistic` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1'),
  `in_draft_state` varchar(3),
  `is_draft_page` varchar(3),
  `publish_date` timestamp,
  `edit_date_draft` timestamp,
  `edit_user` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_non_folder_without_stat`
--

DROP TABLE IF EXISTS `v_tpl_non_folder_without_stat`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder_without_stat`*/;
/*!50001 CREATE TABLE `v_tpl_non_folder_without_stat` (
  `id` int(11),
  `type` int(11),
  `file_name` varchar(100),
  `page_description` varchar(255),
  `group_access` int(11),
  `var` varchar(50),
  `var_id` int(11) unsigned,
  `val` text,
  `language` char(2),
  `default_language` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_page`
--

DROP TABLE IF EXISTS `v_tpl_page`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page`*/;
/*!50001 CREATE TABLE `v_tpl_page` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_page_content`
--

DROP TABLE IF EXISTS `v_tpl_page_content`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_content`*/;
/*!50001 CREATE TABLE `v_tpl_page_content` (
  `id` int(11),
  `page_name` longtext,
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `language` char(2),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_page_detail`
--

DROP TABLE IF EXISTS `v_tpl_page_detail`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_detail`*/;
/*!50001 CREATE TABLE `v_tpl_page_detail` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_page_edit`
--

DROP TABLE IF EXISTS `v_tpl_page_edit`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_edit`*/;
/*!50001 CREATE TABLE `v_tpl_page_edit` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `is_default` int(11),
  `template` int(11),
  `folder` int(11),
  `search` int(11),
  `page_locked` int(11),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_page_folder`
--

DROP TABLE IF EXISTS `v_tpl_page_folder`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_folder`*/;
/*!50001 CREATE TABLE `v_tpl_page_folder` (
  `id` int(11),
  `page_name` varchar(103),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_page_grid`
--

DROP TABLE IF EXISTS `v_tpl_page_grid`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_grid`*/;
/*!50001 CREATE TABLE `v_tpl_page_grid` (
  `id` int(11),
  `page_name` longtext,
  `page_description` varchar(255),
  `template` varchar(104),
  `folder` longtext,
  `is_default` int(11),
  `default_page` varchar(3),
  `for_search` varchar(3),
  `locked` varchar(3),
  `cachable` varchar(3),
  `language` char(2),
  `in_draft_state` varchar(3),
  `edit_date` timestamp,
  `edit_date_draft` timestamp,
  `edit_user` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_page_not_locked`
--

DROP TABLE IF EXISTS `v_tpl_page_not_locked`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_not_locked`*/;
/*!50001 CREATE TABLE `v_tpl_page_not_locked` (
  `id` int(11),
  `page_name` varchar(50),
  `extension` enum('html','htm','xml'),
  `page_description` varchar(255),
  `default_page` int(11),
  `create_date` timestamp,
  `edit_date` timestamp,
  `tpl_id` int(11),
  `folder_id` int(11),
  `for_search` int(11),
  `owner_name` varchar(45),
  `is_locked` int(11),
  `type` bigint(11),
  `file_name` varchar(100),
  `group_access` int(11),
  `priority` varchar(4),
  `cachable` enum('0','1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_path_content`
--

DROP TABLE IF EXISTS `v_tpl_path_content`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_path_content`*/;
/*!50001 CREATE TABLE `v_tpl_path_content` (
  `id` int(11),
  `folder` longtext,
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_views`
--

DROP TABLE IF EXISTS `v_tpl_views`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_views`*/;
/*!50001 CREATE TABLE `v_tpl_views` (
  `id` int(11),
  `view_name` varchar(100),
  `view_folder` varchar(100),
  `description` text,
  `icon` varchar(150),
  `is_default` enum('1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_views_edit`
--

DROP TABLE IF EXISTS `v_tpl_views_edit`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_views_edit`*/;
/*!50001 CREATE TABLE `v_tpl_views_edit` (
  `id` int(11),
  `view_name` varchar(100),
  `view_folder` varchar(100),
  `description` text,
  `icon` varchar(150),
  `is_default` enum('1')
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_tpl_views_grid`
--

DROP TABLE IF EXISTS `v_tpl_views_grid`;
/*!50001 DROP VIEW IF EXISTS `v_tpl_views_grid`*/;
/*!50001 CREATE TABLE `v_tpl_views_grid` (
  `id` int(11),
  `view_name` varchar(100),
  `view_folder` varchar(100),
  `description` text,
  `icon` varchar(150),
  `is_default` enum('1'),
  `default_view` varchar(3)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_user`
--

DROP TABLE IF EXISTS `v_user`;
/*!50001 DROP VIEW IF EXISTS `v_user`*/;
/*!50001 CREATE TABLE `v_user` (
  `id` int(11),
  `name` varchar(150),
  `login` varchar(50),
  `passw` varchar(50),
  `email` varchar(150),
  `status` int(11),
  `role` int(11),
  `content_access` int(11),
  `comment` text,
  `icq` int(11),
  `city` varchar(50),
  `resetpassw` int(11),
  `ip` varchar(20),
  `browser` varchar(50),
  `login_datetime` datetime,
  `month_visits` int(11),
  `passw_update_datetime` datetime
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_user_edit`
--

DROP TABLE IF EXISTS `v_user_edit`;
/*!50001 DROP VIEW IF EXISTS `v_user_edit`*/;
/*!50001 CREATE TABLE `v_user_edit` (
  `id` int(11),
  `name` varchar(150),
  `login` varchar(50),
  `email` varchar(150),
  `status` int(11),
  `comment` text,
  `icq` int(11),
  `city` varchar(50),
  `change_password` char(0),
  `old_password` char(0),
  `new_password` char(0),
  `confirm_new_password` char(0),
  `currently` char(0),
  `ip` varchar(20),
  `browser` varchar(50),
  `last_login` varchar(21),
  `month_visits` int(11),
  `user_groups` char(0),
  `role` int(11),
  `content_access` int(11)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_user_grid`
--

DROP TABLE IF EXISTS `v_user_grid`;
/*!50001 DROP VIEW IF EXISTS `v_user_grid`*/;
/*!50001 CREATE TABLE `v_user_grid` (
  `id` int(11),
  `name` varchar(150),
  `login` varchar(50),
  `email` varchar(150),
  `status` varchar(8),
  `role` int(11),
  `role_name` varchar(50),
  `groups` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_user_groups`
--

DROP TABLE IF EXISTS `v_user_groups`;
/*!50001 DROP VIEW IF EXISTS `v_user_groups`*/;
/*!50001 CREATE TABLE `v_user_groups` (
  `id` int(11),
  `group_name` varchar(250),
  `group_code` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_user_groups_edit`
--

DROP TABLE IF EXISTS `v_user_groups_edit`;
/*!50001 DROP VIEW IF EXISTS `v_user_groups_edit`*/;
/*!50001 CREATE TABLE `v_user_groups_edit` (
  `id` int(11),
  `group_name` varchar(250),
  `group_code` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_user_groups_grid`
--

DROP TABLE IF EXISTS `v_user_groups_grid`;
/*!50001 DROP VIEW IF EXISTS `v_user_groups_grid`*/;
/*!50001 CREATE TABLE `v_user_groups_grid` (
  `id` int(11),
  `group_name` varchar(250),
  `group_code` varchar(50)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `v_user_profile`
--

DROP TABLE IF EXISTS `v_user_profile`;
/*!50001 DROP VIEW IF EXISTS `v_user_profile`*/;
/*!50001 CREATE TABLE `v_user_profile` (
  `id` int(11),
  `name` varchar(150),
  `email` varchar(150),
  `change_password` char(0),
  `old_password` char(0),
  `new_password` char(0),
  `confirm_new_password` char(0)
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `vbrowser_grid`
--

DROP TABLE IF EXISTS `vbrowser_grid`;
/*!50001 DROP VIEW IF EXISTS `vbrowser_grid`*/;
/*!50001 CREATE TABLE `vbrowser_grid` (
  `id` int(11),
  `page_name` longtext,
  `page_description` varchar(255),
  `template` varchar(104),
  `folder` longtext,
  `is_default` int(11),
  `default_page` varchar(3),
  `for_search` varchar(3),
  `locked` varchar(3),
  `cachable` varchar(3),
  `language` char(2),
  `in_draft_state` varchar(3),
  `edit_date` timestamp,
  `edit_date_draft` timestamp,
  `edit_user` longtext
) ENGINE=MyISAM */;

--
-- Temporary table structure for view `vmbrowser_grid`
--

DROP TABLE IF EXISTS `vmbrowser_grid`;
/*!50001 DROP VIEW IF EXISTS `vmbrowser_grid`*/;
/*!50001 CREATE TABLE `vmbrowser_grid` (
  `id` int(11),
  `media_name` longtext,
  `media_description` varchar(255),
  `template` varchar(104),
  `folder` longtext,
  `edit_date` timestamp,
  `cachable` varchar(3),
  `in_draft_state` varchar(3),
  `language` char(2)
) ENGINE=MyISAM */;

--
-- Final view structure for view `v_channel_db`
--

/*!50001 DROP TABLE `v_channel_db`*/;
/*!50001 DROP VIEW IF EXISTS `v_channel_db`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_channel_db` AS select distinct substr(`c1`.`var`,12,(locate(_utf8'_channel_id',`c1`.`var`) - 12)) AS `id`,`lan`.`language_code` AS `language`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_channel_id')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `channel_id`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_status')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `status`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_author')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `author`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_channel_type')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `channel_type`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_title')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `title`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_description')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `description`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_rss')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `rss`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'channel_db_',substr(`content`.`var`,12,(locate(_utf8'_channel_id',`content`.`var`) - 12)),_utf8'_copyright')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `copyright` from (`content` `c1` join `v_language` `lan`) where ((locate(_utf8'_channel_id',`c1`.`var`) > 0) and (locate(_utf8'channel_db_',`c1`.`var`) > 0) and (`lan`.`status` = 1)) */;

--
-- Final view structure for view `v_channel_edit`
--

/*!50001 DROP TABLE `v_channel_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_channel_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_channel_edit` AS select `v_channel_db`.`channel_id` AS `channel_id`,`v_channel_db`.`title` AS `title`,`v_channel_db`.`description` AS `description`,`v_channel_db`.`status` AS `status`,`v_channel_db`.`author` AS `author`,`v_channel_db`.`channel_type` AS `channel_type`,`v_channel_db`.`copyright` AS `copyright`,`v_channel_db`.`rss` AS `rss` from `v_channel_db` */;

--
-- Final view structure for view `v_channel_grid`
--

/*!50001 DROP TABLE `v_channel_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_channel_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_channel_grid` AS select `v_channel_db`.`channel_id` AS `channel_id`,`v_channel_db`.`title` AS `title`,(case `v_channel_db`.`status` when 0 then _latin1'inactive' when 1 then _latin1'active' end) AS `status`,`v_channel_db`.`author` AS `author`,`v_channel_db`.`channel_type` AS `channel_type`,(case `v_channel_db`.`rss` when 0 then _latin1'No' when 1 then _latin1'Yes' end) AS `rss` from `v_channel_db` where (`v_channel_db`.`language` = (select `v_language`.`language_code` AS `language_code` from `v_language` where (`v_language`.`default_language` = 1))) */;

--
-- Final view structure for view `v_dns`
--

/*!50001 DROP TABLE `v_dns`*/;
/*!50001 DROP VIEW IF EXISTS `v_dns`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_dns` AS select `dns`.`id` AS `id`,`dns`.`dns` AS `dns`,`dns`.`comment` AS `comment`,`dns`.`status` AS `status`,`dns`.`language_forwarding` AS `language_forwarding`,`dns`.`draft_mode` AS `draft_mode`,`dns`.`cdn_server` AS `cdn_server` from `dns` */;

--
-- Final view structure for view `v_dns_edit`
--

/*!50001 DROP TABLE `v_dns_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_dns_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_dns_edit` AS select `v_dns`.`id` AS `id`,`v_dns`.`dns` AS `dns`,`v_dns`.`comment` AS `comment`,`v_dns`.`status` AS `status`,`v_dns`.`language_forwarding` AS `language_forwarding`,`v_dns`.`draft_mode` AS `draft_mode`,`v_dns`.`cdn_server` AS `cdn_server` from `v_dns` */;

--
-- Final view structure for view `v_dns_grid`
--

/*!50001 DROP TABLE `v_dns_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_dns_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_dns_grid` AS select `v_dns`.`id` AS `id`,`v_dns`.`dns` AS `dns`,`v_dns`.`comment` AS `comment`,(case `v_dns`.`status` when 1 then _latin1'Enabled' else _latin1'Disabled' end) AS `status`,`v_dns`.`language_forwarding` AS `language_forwarding`,`v_dns`.`draft_mode` AS `draft_mode` from `v_dns` */;

--
-- Final view structure for view `v_events_db`
--

/*!50001 DROP TABLE `v_events_db`*/;
/*!50001 DROP VIEW IF EXISTS `v_events_db`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_events_db` AS select distinct substr(`c1`.`var`,11,(locate(_utf8'_news_id',`c1`.`var`) - 11)) AS `id`,`lan`.`language_code` AS `language`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_news_id')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `news_id`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_title')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `title`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_description')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `description`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_SystemDate')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `SystemDate`,(select if((`content`.`val` <> _utf8''),date_format(`content`.`val`,_latin1'%d.%m.%Y'),_utf8'') AS `IF(val<>'',date_format(val,'%d.%m.%Y'),'')` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_SystemDate')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `SystemDate_d`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_ExpiryDate')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `ExpiryDate`,(select if((`content`.`val` <> _utf8''),date_format(`content`.`val`,_latin1'%d.%m.%Y'),_utf8'') AS `IF(val<>'',date_format(val,'%d.%m.%Y'),'')` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_ExpiryDate')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `ExpiryDate_d`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_DisplayDate')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `DisplayDate`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_PublishedDate')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `PublishedDate`,(select if((`content`.`val` <> _utf8''),date_format(`content`.`val`,_latin1'%d.%m.%Y'),_utf8'') AS `IF(val<>'',date_format(val,'%d.%m.%Y'),'')` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_PublishedDate')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `PublishedDate_d`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_status')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `status`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_channel_id')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `channel_id`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_show_on_home')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `show_on_home`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_category')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `category`,(select (case trim(`content`.`val`) when _latin1'0' then _latin1'draft' when _latin1'1' then _latin1'published' when _latin1'2' then _latin1'archive' end) AS `val` from `content` where ((`content`.`var` = concat(_utf8'events_db_',substr(`content`.`var`,11,(locate(_utf8'_news_id',`content`.`var`) - 11)),_utf8'_status')) and (`content`.`language` in (`lan`.`language_code`,_utf8'EN'))) order by concat(convert((case `content`.`language` when `lan`.`language_code` then _latin1'0' else _latin1'1' end) using utf8),`content`.`language`) limit 1) AS `status_text` from (`content` `c1` join `v_language` `lan`) where ((locate(_utf8'_news_id',`c1`.`var`) > 0) and (locate(_utf8'events_db_',`c1`.`var`) > 0) and (`lan`.`status` = 1)) */;

--
-- Final view structure for view `v_lang_edit`
--

/*!50001 DROP TABLE `v_lang_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_lang_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_lang_edit` AS select `v_language`.`language_code` AS `id`,`v_language`.`language_url` AS `language_url`,`v_language`.`language_name` AS `language_name`,_latin1'' AS `language_link_title`,`v_language`.`l_encode` AS `l_encode`,`v_language`.`paypal_lang` AS `paypal_lang`,`v_language`.`status` AS `status`,`v_language`.`default_language` AS `is_default` from `v_language` */;

--
-- Final view structure for view `v_lang_grid`
--

/*!50001 DROP TABLE `v_lang_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_lang_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_lang_grid` AS select `v_language`.`language_code` AS `language_code`,`v_language`.`language_url` AS `language_url`,`v_language`.`language_name` AS `language_name`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = concat(_utf8'ee_lang_title_',`v_language`.`language_code`)) and (`content`.`language` = (select `v_language`.`language_code` AS `language_code` from `v_language` where (`v_language`.`default_language` = _latin1'1')))) limit 0,1) AS `language_link_title`,`v_language`.`l_encode` AS `l_encode`,`v_language`.`paypal_lang` AS `paypal_lang`,(case `v_language`.`status` when 1 then _latin1'Enabled' else _latin1'Disabled' end) AS `status`,(case `v_language`.`default_language` when 1 then _latin1'Yes' else _latin1'' end) AS `default_language` from `v_language` */;

--
-- Final view structure for view `v_language`
--

/*!50001 DROP TABLE `v_language`*/;
/*!50001 DROP VIEW IF EXISTS `v_language`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_language` AS select `language`.`language_code` AS `language_code`,`language`.`language_url` AS `language_url`,`language`.`language_name` AS `language_name`,`language`.`l_encode` AS `l_encode`,`language`.`paypal_lang` AS `paypal_lang`,`language`.`language_of_browser` AS `language_of_browser`,`language`.`status` AS `status`,`language`.`default_language` AS `default_language` from `language` where (`language`.`language_code` <> _utf8'') */;

--
-- Final view structure for view `v_mail_inbox_edit`
--

/*!50001 DROP TABLE `v_mail_inbox_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_mail_inbox_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_mail_inbox_edit` AS select `mail_inbox`.`id` AS `id`,`mail_inbox`.`name` AS `name`,`mail_inbox`.`email` AS `email`,date_format(`mail_inbox`.`send_date`,_latin1'%d.%m.%Y %H:%i') AS `send_date`,`mail_inbox`.`add_info` AS `add_info` from `mail_inbox` */;

--
-- Final view structure for view `v_mail_inbox_grid`
--

/*!50001 DROP TABLE `v_mail_inbox_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_mail_inbox_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_mail_inbox_grid` AS select `mail_inbox`.`id` AS `id`,`mail_inbox`.`name` AS `name`,`mail_inbox`.`email` AS `email`,`mail_inbox`.`send_date` AS `send_date`,`mail_inbox`.`message` AS `message`,`mail_inbox`.`add_info` AS `add_info`,(case `mail_inbox`.`viewed` when 1 then _latin1'Yes' else _latin1'No' end) AS `viewed` from `mail_inbox` */;

--
-- Final view structure for view `v_mailing_edit`
--

/*!50001 DROP TABLE `v_mailing_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_mailing_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_mailing_edit` AS select `v_ms_mail`.`id` AS `id`,`v_ms_mail`.`original_id` AS `original_id`,`v_ms_mail`.`subject` AS `subject`,`v_ms_mail`.`date_reg` AS `date_reg`,`v_ms_mail`.`from_` AS `from_`,`v_ms_mail`.`status` AS `status`,`v_ms_mail`.`recipients_count` AS `recipients_count` from `v_ms_mail` */;

--
-- Final view structure for view `v_mailing_grid`
--

/*!50001 DROP TABLE `v_mailing_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_mailing_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_mailing_grid` AS select `v_mailing_edit`.`id` AS `id`,`v_mailing_edit`.`original_id` AS `original_id`,`v_mailing_edit`.`subject` AS `subject`,`v_mailing_edit`.`date_reg` AS `date_reg`,`v_mailing_edit`.`from_` AS `from_`,`v_mailing_edit`.`status` AS `status`,`v_mailing_edit`.`recipients_count` AS `recipients_count` from `v_mailing_edit` */;

--
-- Final view structure for view `v_media`
--

/*!50001 DROP TABLE `v_media`*/;
/*!50001 DROP VIEW IF EXISTS `v_media`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_media` AS select `v_tpl_non_folder`.`id` AS `id`,`v_tpl_non_folder`.`page_name` AS `page_name`,`v_tpl_non_folder`.`extension` AS `extension`,`v_tpl_non_folder`.`page_description` AS `page_description`,`v_tpl_non_folder`.`default_page` AS `default_page`,`v_tpl_non_folder`.`create_date` AS `create_date`,`v_tpl_non_folder`.`edit_date` AS `edit_date`,`v_tpl_non_folder`.`tpl_id` AS `tpl_id`,`v_tpl_non_folder`.`folder_id` AS `folder_id`,`v_tpl_non_folder`.`for_search` AS `for_search`,`v_tpl_non_folder`.`owner_name` AS `owner_name`,`v_tpl_non_folder`.`is_locked` AS `is_locked`,`v_tpl_non_folder`.`type` AS `type`,`v_tpl_non_folder`.`file_name` AS `file_name`,`v_tpl_non_folder`.`group_access` AS `group_access`,`v_tpl_non_folder`.`priority` AS `priority`,`v_tpl_non_folder`.`cachable` AS `cachable` from `v_tpl_non_folder` where (`v_tpl_non_folder`.`type` = 1) */;

--
-- Final view structure for view `v_media_content`
--

/*!50001 DROP TABLE `v_media_content`*/;
/*!50001 DROP VIEW IF EXISTS `v_media_content`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_media_content` AS select `v_tpl_non_folder`.`id` AS `id`,if(isnull(`regular_content`.`val`),if(isnull(`default_content`.`val`),`v_tpl_non_folder`.`page_name`,`default_content`.`val`),`regular_content`.`val`) AS `page_name`,`v_tpl_non_folder`.`page_description` AS `page_description`,`v_tpl_non_folder`.`default_page` AS `default_page`,`v_tpl_non_folder`.`create_date` AS `create_date`,`v_tpl_non_folder`.`edit_date` AS `edit_date`,`v_tpl_non_folder`.`tpl_id` AS `tpl_id`,`v_tpl_non_folder`.`folder_id` AS `folder_id`,`v_tpl_non_folder`.`for_search` AS `for_search`,`v_tpl_non_folder`.`owner_name` AS `owner_name`,`v_tpl_non_folder`.`is_locked` AS `is_locked`,`v_tpl_non_folder`.`type` AS `type`,`v_tpl_non_folder`.`file_name` AS `file_name`,`v_tpl_non_folder`.`cachable` AS `cachable`,`language`.`language_code` AS `language` from (((`v_tpl_non_folder` join `v_language` `language`) left join `content` `regular_content` on(((`v_tpl_non_folder`.`id` = `regular_content`.`var_id`) and (`regular_content`.`var` = _utf8'page_name_') and (`regular_content`.`language` = `language`.`language_code`)))) left join `content` `default_content` on(((`v_tpl_non_folder`.`id` = `default_content`.`var_id`) and (`default_content`.`var` = _utf8'page_name_') and (`default_content`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1)))))) where (`v_tpl_non_folder`.`type` = 1) */;

--
-- Final view structure for view `v_media_edit`
--

/*!50001 DROP TABLE `v_media_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_media_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_media_edit` AS select `v_media`.`id` AS `id`,`v_media`.`page_name` AS `page_name`,`v_media`.`page_description` AS `media_description`,`v_media`.`tpl_id` AS `template`,`v_media`.`folder_id` AS `folder`,_latin1'' AS `size`,_latin1'' AS `alt_tag`,_latin1'' AS `zip_file_name`,`v_media`.`cachable` AS `cachable` from `v_media` */;

--
-- Final view structure for view `v_media_file`
--

/*!50001 DROP TABLE `v_media_file`*/;
/*!50001 DROP VIEW IF EXISTS `v_media_file`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_media_file` AS select `tpl_files`.`id` AS `id`,`tpl_files`.`file_name` AS `file_name`,`tpl_files`.`type` AS `type`,`tpl_files`.`description` AS `description`,`tpl_files`.`cachable` AS `cachable` from `tpl_files` where (`tpl_files`.`type` = _latin1'1') */;

--
-- Final view structure for view `v_media_grid`
--

/*!50001 DROP TABLE `v_media_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_media_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_media_grid` AS select `v_media_content`.`id` AS `id`,concat(`v_media_content`.`page_name`,convert((case when (`v_media_content`.`default_page` > 0) then _latin1' ( default )' else _latin1'' end) using utf8)) AS `media_name`,`v_media_content`.`page_description` AS `media_description`,concat(`v_media_content`.`file_name`,_latin1'.tpl') AS `template`,concat(_utf8'/',if(isnull(`v_tpl_path_content`.`folder`),_utf8'',`v_tpl_path_content`.`folder`)) AS `folder`,`v_media_content`.`edit_date` AS `edit_date`,(case `v_media_content`.`cachable` when _latin1'1' then _latin1'Yes' else _latin1'No' end) AS `cachable`,(case (select count(0) AS `COUNT(*)` from `content` where (((`content`.`val` <> (`content`.`val_draft` collate utf8_bin)) or isnull(`content`.`val`)) and (`content`.`val_draft` is not null) and (`content`.`var` = _utf8'media_') and (`content`.`var_id` = `v_media_content`.`id`))) when 0 then _latin1'No' else _latin1'Yes' end) AS `in_draft_state`,`v_media_content`.`language` AS `language` from (`v_media_content` left join `v_tpl_path_content` on((((`v_media_content`.`folder_id` = `v_tpl_path_content`.`id`) and (`v_media_content`.`language` = `v_tpl_path_content`.`language`)) or isnull(`v_tpl_path_content`.`id`)))) */;

--
-- Final view structure for view `v_ms_mail`
--

/*!50001 DROP TABLE `v_ms_mail`*/;
/*!50001 DROP VIEW IF EXISTS `v_ms_mail`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_ms_mail` AS select `ms_mail`.`id` AS `id`,`ms_mail`.`original_id` AS `original_id`,`ms_mail`.`subject` AS `subject`,`ms_mail`.`date_reg` AS `date_reg`,`ms_mail`.`body` AS `body`,concat(`ms_mail`.`from_name`,_latin1' (',`ms_mail`.`from_email`,_latin1')') AS `from_`,(select `ms_status`.`status` AS `status` from `ms_status` where (`ms_status`.`id` = `ms_mail`.`ms_status_id`)) AS `status`,concat((select rtrim(cast(count(0) as char charset latin1)) AS `rtrim(cast(COUNT(*) AS char))` from `ms_recipient` `recip1` where (`recip1`.`ms_mail_id` = `ms_mail`.`id`)),_latin1' / ',(select rtrim(cast(count(0) as char charset latin1)) AS `rtrim(cast(COUNT(*) AS char))` from `ms_recipient` `recip2` where ((`recip2`.`ms_mail_id` = `ms_mail`.`id`) and (`recip2`.`ms_status_id` = 3)))) AS `recipients_count` from `ms_mail` */;

--
-- Final view structure for view `v_ms_recipient`
--

/*!50001 DROP TABLE `v_ms_recipient`*/;
/*!50001 DROP VIEW IF EXISTS `v_ms_recipient`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_ms_recipient` AS select `ms_recipient`.`id` AS `id`,`ms_recipient`.`ms_mail_id` AS `ms_mail_id`,`ms_recipient`.`recipient` AS `recipient`,`ms_recipient`.`date_update` AS `date_update`,(select `ms_status`.`status` AS `status` from `ms_status` where (`ms_status`.`id` = `ms_recipient`.`ms_status_id`)) AS `status`,`ms_recipient`.`recipient_id` AS `recipient_id` from `ms_recipient` */;

--
-- Final view structure for view `v_news_edit`
--

/*!50001 DROP TABLE `v_news_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_news_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_news_edit` AS select `v_events_db`.`news_id` AS `news_id`,`v_events_db`.`title` AS `title`,`v_events_db`.`description` AS `description`,`v_events_db`.`status` AS `status`,`v_events_db`.`category` AS `category`,`v_events_db`.`show_on_home` AS `show_on_home`,`v_events_db`.`channel_id` AS `channel_id`,`v_events_db`.`SystemDate` AS `SystemDate`,`v_events_db`.`ExpiryDate` AS `ExpiryDate`,`v_events_db`.`PublishedDate` AS `PublishedDate` from `v_events_db` where (`v_events_db`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1))) */;

--
-- Final view structure for view `v_news_grid`
--

/*!50001 DROP TABLE `v_news_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_news_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_news_grid` AS select `v_events_db`.`news_id` AS `news_id`,`v_events_db`.`title` AS `title`,(case `v_events_db`.`status` when 0 then _latin1'draft' when 1 then _latin1'published' when 2 then _latin1'archive' end) AS `status`,`v_events_db`.`category` AS `category`,`v_events_db`.`channel_id` AS `channel_id`,`v_events_db`.`SystemDate` AS `SystemDate`,`v_events_db`.`ExpiryDate` AS `ExpiryDate`,`v_events_db`.`PublishedDate` AS `PublishedDate` from `v_events_db` where (`v_events_db`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1))) */;

--
-- Final view structure for view `v_news_letters_edit`
--

/*!50001 DROP TABLE `v_news_letters_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_news_letters_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_news_letters_edit` AS select `nl_email`.`id` AS `id`,`nl_email`.`from_name` AS `email_from_name`,`nl_email`.`from_email` AS `email_from_email`,ifnull(`content`.`val`,convert(`nl_email`.`subject` using utf8)) AS `email_subject`,`nl_email`.`tpl` AS `email_tpl`,`nl_email`.`body` AS `email_body`,`nl_email`.`header` AS `email_header`,(select count(0) AS `COUNT(*)` from `nl_email_group` where (`nl_email_group`.`nl_email_id` = `nl_email`.`id`)) AS `group_count`,(select count(0) AS `COUNT(*)` from `nl_subscriber` where `nl_subscriber`.`nl_group_id` in (select `nl_email_group`.`nl_group_id` AS `nl_group_id` from `nl_email_group` where (`nl_email_group`.`nl_email_id` = `nl_email`.`id`))) AS `subscr_count`,(case when ((select count(0) AS `COUNT(*)` from `nl_email_group` where (`nl_email_group`.`nl_email_id` = `nl_email`.`id`)) = 0) then _latin1'draft' else (case when ((select `ms_mail`.`ms_status_id` AS `ms_status_id` from `ms_mail` where (`ms_mail`.`id` = `nl_email`.`transaction_id`)) = 3) then _latin1'sent' else (case when ((select `ms_mail`.`ms_status_id` AS `ms_status_id` from `ms_mail` where (`ms_mail`.`id` = `nl_email`.`transaction_id`)) = 6) then _latin1'archive' else _latin1'outbox' end) end) end) AS `email_status`,`nl_email`.`transaction_id` AS `email_transaction_id`,(case when (`nl_email`.`finish_date` = NULL) then (select date_format((date_format(now(),_latin1'%Y-%m-%d') + interval (select `config`.`val` AS `val` from `config` where (`config`.`var` = _utf8'default_active_period')) day),_latin1'%d-%m-%Y') AS `date_format(DATE_ADD(date_format(now(), '%Y-%m-%d'),INTERVAL (select val from config where var = 'default_active_period') DAY), '%d-%m-%Y')`) else `nl_email`.`finish_date` end) AS `finish_date`,`nl_email`.`ip_address` AS `ip_address`,`nl_email`.`create_date` AS `create_date` from (`nl_email` left join (`content` join `language` on(((`content`.`language` = `language`.`language_code`) and (`language`.`default_language` = 1)))) on(((`nl_email`.`id` = `content`.`var_id`) and (`content`.`var` = _utf8'news_letter_subject_')))) */;

--
-- Final view structure for view `v_news_letters_grid`
--

/*!50001 DROP TABLE `v_news_letters_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_news_letters_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_news_letters_grid` AS select `v_news_letters_edit`.`id` AS `id`,`v_news_letters_edit`.`email_from_name` AS `from_name`,`v_news_letters_edit`.`email_from_email` AS `from_email`,`v_news_letters_edit`.`email_subject` AS `subject`,`v_news_letters_edit`.`email_status` AS `status`,date_format(`v_news_letters_edit`.`finish_date`,_latin1'%d-%m-%Y') AS `Finish Date`,`v_news_letters_edit`.`ip_address` AS `ip_address`,`v_news_letters_edit`.`create_date` AS `create_date` from `v_news_letters_edit` */;

--
-- Final view structure for view `v_nl_email`
--

/*!50001 DROP TABLE `v_nl_email`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_email`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_email` AS select `nl_email`.`id` AS `email_id`,`nl_email`.`from_name` AS `email_from_name`,`nl_email`.`from_email` AS `email_from_email`,`nl_email`.`subject` AS `email_subject`,`nl_email`.`tpl` AS `email_tpl`,`nl_email`.`body` AS `email_body`,`nl_email`.`header` AS `email_header`,(select count(0) AS `COUNT(*)` from `nl_email_group` where (`nl_email_group`.`nl_email_id` = `nl_email`.`id`)) AS `group_count`,(select count(0) AS `COUNT(*)` from `nl_subscriber` where `nl_subscriber`.`nl_group_id` in (select `nl_email_group`.`nl_group_id` AS `nl_group_id` from `nl_email_group` where (`nl_email_group`.`nl_email_id` = `nl_email`.`id`))) AS `subscr_count`,(case when ((select count(0) AS `COUNT(*)` from `nl_email_group` where (`nl_email_group`.`nl_email_id` = `nl_email`.`id`)) = 0) then _latin1'draft' else (case when ((select `ms_mail`.`ms_status_id` AS `ms_status_id` from `ms_mail` where (`ms_mail`.`id` = `nl_email`.`transaction_id`)) = 3) then _latin1'sent' else _latin1'outbox' end) end) AS `email_status`,`nl_email`.`transaction_id` AS `email_transaction_id`,(case when (`nl_email`.`finish_date` = NULL) then (select date_format((date_format(now(),_latin1'%Y-%m-%d') + interval (select `config`.`val` AS `val` from `config` where (`config`.`var` = _utf8'default_active_period')) day),_latin1'%d-%m-%Y') AS `date_format(DATE_ADD(date_format(now(), '%Y-%m-%d'),INTERVAL (select val from config where var = 'default_active_period') DAY), '%d-%m-%Y')`) else `nl_email`.`finish_date` end) AS `finish_date`,`nl_email`.`ip_address` AS `ip_address`,`nl_email`.`create_date` AS `create_date` from `nl_email` */;

--
-- Final view structure for view `v_nl_email_edit`
--

/*!50001 DROP TABLE `v_nl_email_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_email_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_email_edit` AS select `v_nl_email`.`email_id` AS `email_id`,`v_nl_email`.`email_from_name` AS `email_from_name`,`v_nl_email`.`email_from_email` AS `email_from_email`,`v_nl_email`.`email_subject` AS `email_subject`,`v_nl_email`.`email_tpl` AS `email_tpl`,`v_nl_email`.`email_body` AS `email_body`,`v_nl_email`.`email_header` AS `email_header`,`v_nl_email`.`group_count` AS `group_count`,`v_nl_email`.`subscr_count` AS `subscr_count`,`v_nl_email`.`email_status` AS `email_status`,`v_nl_email`.`email_transaction_id` AS `email_transaction_id`,`v_nl_email`.`finish_date` AS `finish_date`,`v_nl_email`.`ip_address` AS `ip_address`,`v_nl_email`.`create_date` AS `create_date` from `v_nl_email` */;

--
-- Final view structure for view `v_nl_email_grid`
--

/*!50001 DROP TABLE `v_nl_email_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_email_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_email_grid` AS select `v_nl_email`.`email_id` AS `email_id`,`v_nl_email`.`email_from_name` AS `email_from_name`,`v_nl_email`.`email_from_email` AS `email_from_email`,`v_nl_email`.`email_subject` AS `email_subject`,`v_nl_email`.`email_header` AS `email_header`,`v_nl_email`.`email_status` AS `email_status`,`v_nl_email`.`finish_date` AS `finish_date`,`v_nl_email`.`ip_address` AS `ip_address`,`v_nl_email`.`create_date` AS `create_date` from `v_nl_email` */;

--
-- Final view structure for view `v_nl_group`
--

/*!50001 DROP TABLE `v_nl_group`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_group`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_group` AS select `nl_group`.`id` AS `id`,`nl_group`.`group_name` AS `group_name`,`nl_group`.`show_on_front` AS `show_on_front`,(select count(0) AS `COUNT(*)` from `nl_email_group` where (`nl_email_group`.`nl_group_id` = `nl_group`.`id`)) AS `letters_count`,(select count(0) AS `COUNT(*)` from `nl_subscriber` where ((`nl_subscriber`.`nl_group_id` = `nl_group`.`id`) and (`nl_subscriber`.`status` in (1,3)))) AS `subscr_count` from `nl_group` */;

--
-- Final view structure for view `v_nl_groups_edit`
--

/*!50001 DROP TABLE `v_nl_groups_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_groups_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_groups_edit` AS select `nl_group`.`id` AS `id`,`nl_group`.`group_name` AS `group_name`,`nl_group`.`show_on_front` AS `show_on_front` from `nl_group` */;

--
-- Final view structure for view `v_nl_groups_grid`
--

/*!50001 DROP TABLE `v_nl_groups_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_groups_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_groups_grid` AS select `v_nl_group`.`id` AS `id`,`v_nl_group`.`group_name` AS `group_name`,`v_nl_group`.`show_on_front` AS `show_on_front`,`v_nl_group`.`letters_count` AS `letters_count`,`v_nl_group`.`subscr_count` AS `subscr_count` from `v_nl_group` */;

--
-- Final view structure for view `v_nl_notification`
--

/*!50001 DROP TABLE `v_nl_notification`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_notification`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_notification` AS select `p`.`id` AS `id`,`p`.`page_name` AS `page_name`,`p`.`extension` AS `extension`,`p`.`page_description` AS `page_description`,`p`.`default_page` AS `default_page`,`p`.`create_date` AS `create_date`,`p`.`edit_date` AS `edit_date`,`p`.`tpl_id` AS `tpl_id`,`p`.`folder_id` AS `folder_id`,`p`.`for_search` AS `for_search`,`p`.`owner_name` AS `owner_name`,`p`.`is_locked` AS `is_locked`,`p`.`group_access` AS `group_access`,`p`.`priority` AS `priority`,`p`.`cachable` AS `cachable`,`p`.`change_freq` AS `change_freq`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = _utf8'nl_notification_subject') and (`content`.`page_id` = `p`.`id`) and (`content`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1)))) limit 1) AS `subject`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = _utf8'nl_notification_from_email') and (`content`.`page_id` = `p`.`id`)) limit 1) AS `from_email` from (`tpl_pages` `p` left join `tpl_files` `f` on((`p`.`tpl_id` = `f`.`id`))) where (`f`.`type` = _latin1'2') */;

--
-- Final view structure for view `v_nl_notification_edit`
--

/*!50001 DROP TABLE `v_nl_notification_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_notification_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_notification_edit` AS select `v_nl_notification`.`id` AS `id`,`v_nl_notification`.`page_name` AS `notification_type`,`v_nl_notification`.`from_email` AS `from_email` from `v_nl_notification` */;

--
-- Final view structure for view `v_nl_notification_grid`
--

/*!50001 DROP TABLE `v_nl_notification_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_notification_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_notification_grid` AS select `v_nl_notification`.`id` AS `id`,`v_nl_notification`.`page_name` AS `notification_type`,`v_nl_notification`.`subject` AS `subject`,`v_nl_notification`.`from_email` AS `from_email` from `v_nl_notification` */;

--
-- Final view structure for view `v_nl_subscriber`
--

/*!50001 DROP TABLE `v_nl_subscriber`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_subscriber`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_subscriber` AS select `nl_subscriber`.`id` AS `id`,`nl_subscriber`.`email` AS `email`,`nl_subscriber`.`nl_group_id` AS `nl_group_id`,`nl_subscriber`.`reg_date` AS `reg_date`,(select max(`v`.`date_update`) AS `max(date_update)` from `v_ms_recipient` `v` where ((`v`.`status` = _latin1'sent') and (`v`.`recipient_id` = `nl_subscriber`.`id`))) AS `last_send`,`nl_subscriber`.`ip_address` AS `ip_address`,`nl_subscriber_status`.`status` AS `subscriber_status`,`nl_subscriber`.`confirm_code` AS `confirm_code`,`nl_subscriber`.`status` AS `status`,`nl_subscriber`.`company` AS `company`,`nl_subscriber`.`first_name` AS `first_name`,`nl_subscriber`.`sur_name` AS `sur_name`,`nl_subscriber`.`city` AS `city`,(select `nl_group`.`group_name` AS `group_name` from `nl_group` where (`nl_group`.`id` = `nl_subscriber`.`nl_group_id`)) AS `group_name`,`nl_subscriber`.`language` AS `language`,(select count(0) AS `COUNT(*)` from `nl_email_group` where (`nl_email_group`.`nl_group_id` = `nl_subscriber`.`nl_group_id`)) AS `letters_count` from (`nl_subscriber` left join `nl_subscriber_status` on((`nl_subscriber`.`status` = `nl_subscriber_status`.`id`))) */;

--
-- Final view structure for view `v_nl_subscribers_edit`
--

/*!50001 DROP TABLE `v_nl_subscribers_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_subscribers_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_subscribers_edit` AS select `v_nl_subscriber`.`id` AS `id`,`v_nl_subscriber`.`email` AS `email`,`v_nl_subscriber`.`group_name` AS `group_name`,`v_nl_subscriber`.`subscriber_status` AS `status`,`v_nl_subscriber`.`company` AS `company`,`v_nl_subscriber`.`first_name` AS `first_name`,`v_nl_subscriber`.`sur_name` AS `sur_name`,`v_nl_subscriber`.`city` AS `city`,`v_nl_subscriber`.`language` AS `language`,`v_nl_subscriber`.`ip_address` AS `ip_address` from `v_nl_subscriber` */;

--
-- Final view structure for view `v_nl_subscribers_grid`
--

/*!50001 DROP TABLE `v_nl_subscribers_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_nl_subscribers_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_nl_subscribers_grid` AS select `v_nl_subscriber`.`id` AS `id`,`v_nl_subscriber`.`email` AS `email`,`v_nl_subscriber`.`subscriber_status` AS `status`,`v_nl_subscriber`.`company` AS `company`,`v_nl_subscriber`.`first_name` AS `first_name`,`v_nl_subscriber`.`sur_name` AS `sur_name`,`v_nl_subscriber`.`city` AS `city`,`v_nl_subscriber`.`group_name` AS `group_name`,`v_nl_subscriber`.`language` AS `language`,`v_nl_subscriber`.`reg_date` AS `reg_date`,`v_nl_subscriber`.`last_send` AS `last_send`,`v_nl_subscriber`.`ip_address` AS `ip_address` from `v_nl_subscriber` */;

--
-- Final view structure for view `v_object`
--

/*!50001 DROP TABLE `v_object`*/;
/*!50001 DROP VIEW IF EXISTS `v_object`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object` AS select `object`.`id` AS `id`,`object`.`name` AS `name` from `object` */;

--
-- Final view structure for view `v_object_content`
--

/*!50001 DROP TABLE `v_object_content`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_content`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_content` AS select `object_content`.`object_field_id` AS `object_field_id`,`object_content`.`object_record_id` AS `object_record_id`,`object_content`.`value` AS `value`,`object_content`.`language` AS `language` from `object_content` */;

--
-- Final view structure for view `v_object_content_edit`
--

/*!50001 DROP TABLE `v_object_content_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_content_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_content_edit` AS select `object_content`.`object_field_id` AS `object_field_id`,`object_content`.`object_record_id` AS `object_record_id`,`object_content`.`value` AS `value`,`object_content`.`language` AS `language` from `object_content` */;

--
-- Final view structure for view `v_object_content_grid`
--

/*!50001 DROP TABLE `v_object_content_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_content_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_content_grid` AS select `object_content`.`object_field_id` AS `object_field_id`,`object_content`.`object_record_id` AS `object_record_id`,`object_content`.`value` AS `value`,`object_content`.`language` AS `language`,`object`.`name` AS `object_name`,`object_field`.`object_field_name` AS `object_field_name` from ((`object_content` join `object_field` on((`object_content`.`object_field_id` = `object_field`.`id`))) join `object` on((`object_field`.`object_id` = `object`.`id`))) order by `object_content`.`object_record_id` */;

--
-- Final view structure for view `v_object_edit`
--

/*!50001 DROP TABLE `v_object_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_edit` AS select `object`.`id` AS `id`,`object`.`name` AS `name` from `object` */;

--
-- Final view structure for view `v_object_field`
--

/*!50001 DROP TABLE `v_object_field`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_field`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_field` AS select `object_field`.`id` AS `id`,`object_field`.`object_id` AS `object_id`,`object_field`.`object_field_name` AS `object_field_name`,`object_field`.`object_field_type` AS `object_field_type`,`object_field`.`one_for_all_languages` AS `one_for_all_languages` from `object_field` */;

--
-- Final view structure for view `v_object_field_edit`
--

/*!50001 DROP TABLE `v_object_field_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_field_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_field_edit` AS select `object_field`.`id` AS `id`,`object_field`.`object_id` AS `object_id`,`object_field`.`object_field_name` AS `object_field_name`,`object_field`.`object_field_type` AS `object_field_type`,`object_field`.`one_for_all_languages` AS `one_for_all_languages` from `object_field` */;

--
-- Final view structure for view `v_object_field_grid`
--

/*!50001 DROP TABLE `v_object_field_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_field_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_field_grid` AS select `f`.`id` AS `id`,(select `o`.`name` AS `name` from `object` `o` where (`o`.`id` = `f`.`object_id`)) AS `object`,`f`.`object_field_name` AS `object_field_name`,`f`.`object_field_type` AS `object_field_type`,`f`.`one_for_all_languages` AS `one_for_all_languages` from `object_field` `f` */;

--
-- Final view structure for view `v_object_field_type`
--

/*!50001 DROP TABLE `v_object_field_type`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_field_type`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_field_type` AS select `object_field_type`.`id` AS `id`,`object_field_type`.`object_field_type` AS `object_field_type`,`object_field_type`.`one_for_all_languages` AS `one_for_all_languages` from `object_field_type` */;

--
-- Final view structure for view `v_object_field_type_edit`
--

/*!50001 DROP TABLE `v_object_field_type_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_field_type_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_field_type_edit` AS select `v_object_field_type`.`id` AS `id`,`v_object_field_type`.`object_field_type` AS `object_field_type`,`v_object_field_type`.`one_for_all_languages` AS `one_for_all_languages` from `v_object_field_type` */;

--
-- Final view structure for view `v_object_field_type_grid`
--

/*!50001 DROP TABLE `v_object_field_type_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_field_type_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_field_type_grid` AS select `v_object_field_type`.`id` AS `id`,`v_object_field_type`.`object_field_type` AS `object_field_type`,(case `v_object_field_type`.`one_for_all_languages` when 1 then _latin1'YES' else _latin1'' end) AS `one_for_all_languages` from `v_object_field_type` */;

--
-- Final view structure for view `v_object_grid`
--

/*!50001 DROP TABLE `v_object_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_grid` AS select `object`.`id` AS `id`,`object`.`name` AS `name` from `object` */;

--
-- Final view structure for view `v_object_record`
--

/*!50001 DROP TABLE `v_object_record`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_record`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_record` AS select `object_record`.`id` AS `id`,`object_record`.`object_id` AS `object_id`,`object_record`.`last_update` AS `last_update`,`object_record`.`user_name` AS `user_name` from `object_record` */;

--
-- Final view structure for view `v_object_record_edit`
--

/*!50001 DROP TABLE `v_object_record_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_record_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_record_edit` AS select `object_record`.`id` AS `id`,`object_record`.`object_id` AS `object_id` from `object_record` */;

--
-- Final view structure for view `v_object_record_grid`
--

/*!50001 DROP TABLE `v_object_record_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_record_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_record_grid` AS select `object_record`.`id` AS `id`,`object_record`.`object_id` AS `object_id`,`object_record`.`user_name` AS `user_name`,`object_record`.`last_update` AS `last_update`,`object`.`name` AS `name` from (`object_record` join `object` on((`object_record`.`object_id` = `object`.`id`))) order by `object_record`.`id` */;

--
-- Final view structure for view `v_object_template`
--

/*!50001 DROP TABLE `v_object_template`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_template`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_template` AS select `object_template`.`id` AS `id`,`object_template`.`object_id` AS `object_id`,`object_template`.`template_id` AS `template_id` from `object_template` */;

--
-- Final view structure for view `v_object_template_edit`
--

/*!50001 DROP TABLE `v_object_template_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_template_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_template_edit` AS select `v_object_template`.`id` AS `id`,`v_object_template`.`object_id` AS `object_id`,`v_object_template`.`template_id` AS `template_id` from `v_object_template` */;

--
-- Final view structure for view `v_object_template_grid`
--

/*!50001 DROP TABLE `v_object_template_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_object_template_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_object_template_grid` AS select `v_object_template`.`id` AS `id`,`v_object`.`name` AS `object_name`,`tpl_files`.`file_name` AS `template_name` from ((`v_object_template` join `v_object` on((`v_object`.`id` = `v_object_template`.`object_id`))) join `tpl_files` on((`tpl_files`.`id` = `v_object_template`.`template_id`))) */;

--
-- Final view structure for view `v_permanent_redirect_edit`
--

/*!50001 DROP TABLE `v_permanent_redirect_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_permanent_redirect_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_permanent_redirect_edit` AS select `permanent_redirect`.`id` AS `id`,`permanent_redirect`.`source_url` AS `source_url`,`permanent_redirect`.`target_url` AS `target_url`,_latin1'' AS `url`,`permanent_redirect`.`page_id` AS `page_id`,`permanent_redirect`.`lang_code` AS `lang_code`,`permanent_redirect`.`t_view` AS `t_view` from `permanent_redirect` */;

--
-- Final view structure for view `v_permanent_redirect_grid`
--

/*!50001 DROP TABLE `v_permanent_redirect_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_permanent_redirect_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_permanent_redirect_grid` AS select `permanent_redirect`.`id` AS `id`,`permanent_redirect`.`source_url` AS `source_url`,`permanent_redirect`.`target_url` AS `target_url`,`permanent_redirect`.`page_id` AS `page_id`,`permanent_redirect`.`lang_code` AS `lang_code`,`permanent_redirect`.`t_view` AS `t_view` from `permanent_redirect` */;

--
-- Final view structure for view `v_search_tpl_pages`
--

/*!50001 DROP TABLE `v_search_tpl_pages`*/;
/*!50001 DROP VIEW IF EXISTS `v_search_tpl_pages`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_search_tpl_pages` AS select `tpl_pages`.`id` AS `id`,`tpl_pages`.`page_name` AS `page_name`,`tpl_pages`.`extension` AS `extension`,`tpl_pages`.`page_description` AS `page_description`,`tpl_pages`.`default_page` AS `default_page`,`tpl_pages`.`create_date` AS `create_date`,`tpl_pages`.`edit_date` AS `edit_date`,`tpl_pages`.`tpl_id` AS `tpl_id`,`tpl_pages`.`folder_id` AS `folder_id`,`tpl_pages`.`for_search` AS `for_search`,`tpl_pages`.`owner_name` AS `owner_name`,`tpl_pages`.`is_locked` AS `is_locked`,`tpl_pages`.`group_access` AS `group_access`,`tpl_pages`.`priority` AS `priority`,`tpl_pages`.`cachable` AS `cachable`,`tpl_pages`.`change_freq` AS `change_freq`,`language`.`language_code` AS `language_code` from ((`tpl_pages` join `tpl_files` on((`tpl_pages`.`tpl_id` = `tpl_files`.`id`))) join `v_language` `language`) where ((`tpl_pages`.`for_search` = _latin1'1') and (`tpl_files`.`type` = 0)) */;

--
-- Final view structure for view `v_styles_edit`
--

/*!50001 DROP TABLE `v_styles_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_styles_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_styles_edit` AS select `styles`.`id` AS `id`,`styles`.`element` AS `element`,`styles`.`class` AS `class`,`styles`.`title` AS `title`,`styles`.`declaration` AS `declaration` from `styles` */;

--
-- Final view structure for view `v_styles_grid`
--

/*!50001 DROP TABLE `v_styles_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_styles_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_styles_grid` AS select `styles`.`id` AS `id`,`styles`.`element` AS `element`,`styles`.`class` AS `class`,`styles`.`title` AS `title`,`styles`.`declaration` AS `sample_text` from `styles` */;

--
-- Final view structure for view `v_tpl_file`
--

/*!50001 DROP TABLE `v_tpl_file`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_file`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_file` AS select `tpl_files`.`id` AS `id`,`tpl_files`.`file_name` AS `file_name`,`tpl_files`.`description` AS `description`,`tpl_files`.`cachable` AS `cachable` from `tpl_files` where (`tpl_files`.`type` = _latin1'0') */;

--
-- Final view structure for view `v_tpl_file_edit`
--

/*!50001 DROP TABLE `v_tpl_file_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_file_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_file_edit` AS select `v_tpl_file`.`id` AS `id`,`v_tpl_file`.`file_name` AS `file_name`,`v_tpl_file`.`description` AS `description`,`v_tpl_file`.`cachable` AS `cachable` from `v_tpl_file` */;

--
-- Final view structure for view `v_tpl_file_grid`
--

/*!50001 DROP TABLE `v_tpl_file_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_file_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_file_grid` AS select `v_tpl_file`.`id` AS `id`,`v_tpl_file`.`file_name` AS `file_name`,`v_tpl_file`.`description` AS `description`,(case `v_tpl_file`.`cachable` when _latin1'1' then _latin1'Yes' else _latin1'No' end) AS `cachable` from `v_tpl_file` */;

--
-- Final view structure for view `v_tpl_folder`
--

/*!50001 DROP TABLE `v_tpl_folder`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_folder` AS select `tpl_pages`.`id` AS `id`,`tpl_pages`.`page_name` AS `page_name`,`tpl_pages`.`page_description` AS `page_description`,`tpl_pages`.`default_page` AS `default_page`,`tpl_pages`.`create_date` AS `create_date`,`tpl_pages`.`edit_date` AS `edit_date`,`tpl_pages`.`folder_id` AS `folder_id`,`tpl_pages`.`for_search` AS `for_search`,`tpl_pages`.`owner_name` AS `owner_name`,`tpl_pages`.`is_locked` AS `is_locked` from `tpl_pages` where isnull(`tpl_pages`.`tpl_id`) */;

--
-- Final view structure for view `v_tpl_folder_content`
--

/*!50001 DROP TABLE `v_tpl_folder_content`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder_content`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_folder_content` AS select `v_tpl_folder`.`id` AS `id`,if(isnull(`regular_content`.`val`),if(isnull(`default_content`.`val`),`v_tpl_folder`.`page_name`,`default_content`.`val`),`regular_content`.`val`) AS `page_name`,`v_tpl_folder`.`page_description` AS `page_description`,`v_tpl_folder`.`default_page` AS `default_page`,`v_tpl_folder`.`create_date` AS `create_date`,`v_tpl_folder`.`edit_date` AS `edit_date`,`v_tpl_folder`.`folder_id` AS `folder_id`,`v_tpl_folder`.`for_search` AS `for_search`,`v_tpl_folder`.`owner_name` AS `owner_name`,`v_tpl_folder`.`is_locked` AS `is_locked`,`language`.`language_code` AS `language` from (((`v_tpl_folder` join `v_language` `language`) left join `content` `regular_content` on(((`v_tpl_folder`.`id` = `regular_content`.`var_id`) and (`regular_content`.`var` = _utf8'page_name_') and (`regular_content`.`language` = `language`.`language_code`)))) left join `content` `default_content` on(((`v_tpl_folder`.`id` = `default_content`.`var_id`) and (`default_content`.`var` = _utf8'page_name_') and (`default_content`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1)))))) */;

--
-- Final view structure for view `v_tpl_folder_edit`
--

/*!50001 DROP TABLE `v_tpl_folder_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_folder_edit` AS select `tpl_pages`.`id` AS `id`,`tpl_pages`.`page_name` AS `page_name`,`tpl_pages`.`page_description` AS `page_description`,`tpl_pages`.`create_date` AS `create_date`,`tpl_pages`.`edit_date` AS `edit_date`,`tpl_pages`.`folder_id` AS `folder_id`,`tpl_pages`.`for_search` AS `for_search`,`tpl_pages`.`owner_name` AS `owner_name`,`tpl_pages`.`is_locked` AS `is_locked`,`tpl_pages`.`group_access` AS `group_access`,_latin1'' AS `folder_groups` from `tpl_pages` where isnull(`tpl_pages`.`tpl_id`) */;

--
-- Final view structure for view `v_tpl_folder_grid`
--

/*!50001 DROP TABLE `v_tpl_folder_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_folder_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_folder_grid` AS select `v_tpl_folder`.`id` AS `id`,concat(_utf8'/',`v_tpl_path_content`.`folder`) AS `folder`,`v_tpl_folder`.`page_description` AS `folder_description`,`v_tpl_folder`.`is_locked` AS `is_locked`,`v_tpl_folder`.`owner_name` AS `owner_name`,(select count(`t`.`id`) AS `count(t.id)` from `tpl_pages` `t` where (`t`.`folder_id` = `v_tpl_folder`.`id`)) AS `items_count`,`v_tpl_path_content`.`language` AS `language` from (`v_tpl_folder` left join `v_tpl_path_content` on((`v_tpl_folder`.`id` = `v_tpl_path_content`.`id`))) */;

--
-- Final view structure for view `v_tpl_non_folder`
--

/*!50001 DROP TABLE `v_tpl_non_folder`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_non_folder` AS select `p`.`id` AS `id`,`p`.`page_name` AS `page_name`,`p`.`extension` AS `extension`,`p`.`page_description` AS `page_description`,`p`.`default_page` AS `default_page`,`p`.`create_date` AS `create_date`,`p`.`edit_date` AS `edit_date`,`p`.`tpl_id` AS `tpl_id`,`p`.`folder_id` AS `folder_id`,`p`.`for_search` AS `for_search`,`p`.`owner_name` AS `owner_name`,`p`.`is_locked` AS `is_locked`,if((`p`.`tpl_id` = 0),0,`tpl_files`.`type`) AS `type`,if((`p`.`tpl_id` = 0),_latin1'',`tpl_files`.`file_name`) AS `file_name`,`p`.`group_access` AS `group_access`,`p`.`priority` AS `priority`,`p`.`cachable` AS `cachable` from (`tpl_pages` `p` left join `tpl_files` on((`p`.`tpl_id` = `tpl_files`.`id`))) where (`p`.`tpl_id` is not null) */;

--
-- Final view structure for view `v_tpl_non_folder_content`
--

/*!50001 DROP TABLE `v_tpl_non_folder_content`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder_content`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_non_folder_content` AS select `v_tpl_non_folder`.`id` AS `id`,if(isnull(`regular_content`.`val`),if(isnull(`default_content`.`val`),`v_tpl_non_folder`.`page_name`,`default_content`.`val`),`regular_content`.`val`) AS `page_name`,`v_tpl_non_folder`.`page_description` AS `page_description`,`v_tpl_non_folder`.`default_page` AS `default_page`,`v_tpl_non_folder`.`create_date` AS `create_date`,`v_tpl_non_folder`.`edit_date` AS `edit_date`,`v_tpl_non_folder`.`tpl_id` AS `tpl_id`,`v_tpl_non_folder`.`folder_id` AS `folder_id`,`v_tpl_non_folder`.`for_search` AS `for_search`,`v_tpl_non_folder`.`owner_name` AS `owner_name`,`v_tpl_non_folder`.`is_locked` AS `is_locked`,`v_tpl_non_folder`.`type` AS `type`,`v_tpl_non_folder`.`file_name` AS `file_name`,`language`.`language_code` AS `language`,`v_tpl_non_folder`.`priority` AS `priority` from (((`v_tpl_non_folder` join `v_language` `language`) left join `content` `regular_content` on(((`v_tpl_non_folder`.`id` = `regular_content`.`var_id`) and (`regular_content`.`var` = _utf8'page_name_') and (`regular_content`.`language` = `language`.`language_code`)))) left join `content` `default_content` on(((`v_tpl_non_folder`.`id` = `default_content`.`var_id`) and (`default_content`.`var` = _utf8'page_name_') and (`default_content`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1)))))) */;

--
-- Final view structure for view `v_tpl_non_folder_statistic`
--

/*!50001 DROP TABLE `v_tpl_non_folder_statistic`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder_statistic`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_non_folder_statistic` AS select `p`.`id` AS `id`,`p`.`page_name` AS `page_name`,`p`.`extension` AS `extension`,`p`.`page_description` AS `page_description`,`p`.`default_page` AS `default_page`,`p`.`create_date` AS `create_date`,`p`.`edit_date` AS `edit_date`,`p`.`tpl_id` AS `tpl_id`,`p`.`folder_id` AS `folder_id`,`p`.`for_search` AS `for_search`,`p`.`owner_name` AS `owner_name`,`p`.`is_locked` AS `is_locked`,`p`.`type` AS `type`,`p`.`file_name` AS `file_name`,`p`.`group_access` AS `group_access`,`p`.`priority` AS `priority`,`p`.`cachable` AS `cachable`,(case (select count(`content`.`page_id`) AS `COUNT(page_id)` from `content` where (((`content`.`val` <> (`content`.`val_draft` collate utf8_bin)) or isnull(`content`.`val`)) and (`content`.`val_draft` is not null) and (`content`.`page_id` = `p`.`id`))) when 0 then _latin1'No' else _latin1'Yes' end) AS `in_draft_state`,(case (select count(`content`.`page_id`) AS `COUNT(page_id)` from `content` where (((`content`.`val` <> (`content`.`val_draft` collate utf8_bin)) or isnull(`content`.`val`)) and (`content`.`page_id` = _latin1'0') and (`content`.`var` = _utf8'page_name_') and (`content`.`var_id` = `p`.`id`) and (`content`.`val_draft` is not null))) when 0 then _latin1'No' else _latin1'Yes' end) AS `is_draft_page`,(select max(`content`.`edit_date`) AS `MAX(content.edit_date)` from `content` where (`content`.`page_id` = `p`.`id`)) AS `publish_date`,(select max(`content`.`edit_date_draft`) AS `MAX(content.edit_date_draft)` from `content` where (`content`.`page_id` = `p`.`id`)) AS `edit_date_draft`,(select `content`.`val` AS `val` from `content` where ((`content`.`var` = _utf8'edit_user') and (`content`.`page_id` = `p`.`id`))) AS `edit_user` from `v_tpl_non_folder` `p` */;

--
-- Final view structure for view `v_tpl_non_folder_without_stat`
--

/*!50001 DROP TABLE `v_tpl_non_folder_without_stat`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_non_folder_without_stat`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_non_folder_without_stat` AS select `tpl_pages`.`id` AS `id`,`tpl_files`.`type` AS `type`,`tpl_files`.`file_name` AS `file_name`,`tpl_pages`.`page_description` AS `page_description`,`tpl_pages`.`group_access` AS `group_access`,`content`.`var` AS `var`,`content`.`var_id` AS `var_id`,`content`.`val` AS `val`,`content`.`language` AS `language`,`language`.`default_language` AS `default_language` from (((`content` left join `tpl_pages` on((`content`.`var_id` = `tpl_pages`.`id`))) join `tpl_files` on((`tpl_pages`.`tpl_id` = `tpl_files`.`id`))) left join `v_language` `language` on((`content`.`language` = `language`.`language_code`))) where ((`content`.`var` = _utf8'folder_path_') or (`content`.`var` = _utf8'page_name_')) */;

--
-- Final view structure for view `v_tpl_page`
--

/*!50001 DROP TABLE `v_tpl_page`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_page` AS select `v_tpl_non_folder`.`id` AS `id`,`v_tpl_non_folder`.`page_name` AS `page_name`,`v_tpl_non_folder`.`extension` AS `extension`,`v_tpl_non_folder`.`page_description` AS `page_description`,`v_tpl_non_folder`.`default_page` AS `default_page`,`v_tpl_non_folder`.`create_date` AS `create_date`,`v_tpl_non_folder`.`edit_date` AS `edit_date`,`v_tpl_non_folder`.`tpl_id` AS `tpl_id`,`v_tpl_non_folder`.`folder_id` AS `folder_id`,`v_tpl_non_folder`.`for_search` AS `for_search`,`v_tpl_non_folder`.`owner_name` AS `owner_name`,`v_tpl_non_folder`.`is_locked` AS `is_locked`,`v_tpl_non_folder`.`type` AS `type`,`v_tpl_non_folder`.`file_name` AS `file_name`,`v_tpl_non_folder`.`group_access` AS `group_access`,`v_tpl_non_folder`.`priority` AS `priority`,`v_tpl_non_folder`.`cachable` AS `cachable` from `v_tpl_non_folder` where (`v_tpl_non_folder`.`type` = 0) */;

--
-- Final view structure for view `v_tpl_page_content`
--

/*!50001 DROP TABLE `v_tpl_page_content`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_content`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_page_content` AS select `v_tpl_non_folder`.`id` AS `id`,if(isnull(`regular_content`.`val`),if(isnull(`regular_content`.`val_draft`),if(isnull(`default_content`.`val`),`v_tpl_non_folder`.`page_name`,`default_content`.`val`),`regular_content`.`val_draft`),`regular_content`.`val`) AS `page_name`,`v_tpl_non_folder`.`page_description` AS `page_description`,`v_tpl_non_folder`.`default_page` AS `default_page`,`v_tpl_non_folder`.`create_date` AS `create_date`,`v_tpl_non_folder`.`edit_date` AS `edit_date`,`v_tpl_non_folder`.`tpl_id` AS `tpl_id`,`v_tpl_non_folder`.`folder_id` AS `folder_id`,`v_tpl_non_folder`.`for_search` AS `for_search`,`v_tpl_non_folder`.`owner_name` AS `owner_name`,`v_tpl_non_folder`.`is_locked` AS `is_locked`,`v_tpl_non_folder`.`type` AS `type`,`v_tpl_non_folder`.`file_name` AS `file_name`,`language`.`language_code` AS `language`,`v_tpl_non_folder`.`group_access` AS `group_access`,`v_tpl_non_folder`.`priority` AS `priority`,`v_tpl_non_folder`.`cachable` AS `cachable` from (((`v_tpl_non_folder` join `v_language` `language`) left join `content` `regular_content` on(((`v_tpl_non_folder`.`id` = `regular_content`.`var_id`) and (`regular_content`.`var` = _utf8'page_name_') and (`regular_content`.`language` = `language`.`language_code`)))) left join `content` `default_content` on(((`v_tpl_non_folder`.`id` = `default_content`.`var_id`) and (`default_content`.`var` = _utf8'page_name_') and (`default_content`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1) limit 0,1))))) where (`v_tpl_non_folder`.`type` = 0) */;

--
-- Final view structure for view `v_tpl_page_detail`
--

/*!50001 DROP TABLE `v_tpl_page_detail`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_detail`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_page_detail` AS select `v_tpl_page`.`id` AS `id`,`v_tpl_page`.`page_name` AS `page_name`,`v_tpl_page`.`extension` AS `extension`,`v_tpl_page`.`page_description` AS `page_description`,`v_tpl_page`.`default_page` AS `default_page`,`v_tpl_page`.`create_date` AS `create_date`,`v_tpl_page`.`edit_date` AS `edit_date`,`v_tpl_page`.`tpl_id` AS `tpl_id`,`v_tpl_page`.`folder_id` AS `folder_id`,`v_tpl_page`.`for_search` AS `for_search`,`v_tpl_page`.`owner_name` AS `owner_name`,`v_tpl_page`.`is_locked` AS `is_locked`,`v_tpl_page`.`type` AS `type`,`v_tpl_page`.`file_name` AS `file_name`,`v_tpl_page`.`group_access` AS `group_access`,`v_tpl_page`.`priority` AS `priority`,`v_tpl_page`.`cachable` AS `cachable` from `v_tpl_page` */;

--
-- Final view structure for view `v_tpl_page_edit`
--

/*!50001 DROP TABLE `v_tpl_page_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_page_edit` AS select `v_tpl_page`.`id` AS `id`,`v_tpl_page`.`page_name` AS `page_name`,`v_tpl_page`.`extension` AS `extension`,`v_tpl_page`.`page_description` AS `page_description`,`v_tpl_page`.`default_page` AS `is_default`,`v_tpl_page`.`tpl_id` AS `template`,`v_tpl_page`.`folder_id` AS `folder`,`v_tpl_page`.`for_search` AS `search`,`v_tpl_page`.`is_locked` AS `page_locked`,`v_tpl_page`.`cachable` AS `cachable` from `v_tpl_page` */;

--
-- Final view structure for view `v_tpl_page_folder`
--

/*!50001 DROP TABLE `v_tpl_page_folder`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_folder`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_page_folder` AS select `p`.`id` AS `id`,if(((`p`.`folder_id` is not null) and (`p`.`folder_id` <> 0)),concat(`f`.`page_name`,_utf8' / ',`p`.`page_name`),`p`.`page_name`) AS `page_name`,`p`.`page_description` AS `page_description`,`p`.`default_page` AS `default_page`,`p`.`create_date` AS `create_date`,`p`.`edit_date` AS `edit_date`,`p`.`tpl_id` AS `tpl_id`,`p`.`folder_id` AS `folder_id`,`p`.`for_search` AS `for_search` from (`v_tpl_page` `p` left join `v_tpl_folder` `f` on((`p`.`folder_id` = `f`.`id`))) */;

--
-- Final view structure for view `v_tpl_page_grid`
--

/*!50001 DROP TABLE `v_tpl_page_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_page_grid` AS select `v_tpl_page_content`.`id` AS `id`,`v_tpl_page_content`.`page_name` AS `page_name`,`v_tpl_page_content`.`page_description` AS `page_description`,concat(`v_tpl_page_content`.`file_name`,_latin1'.tpl') AS `template`,if(isnull(`v_tpl_path_content`.`folder`),_utf8'/',concat(_utf8'/',`v_tpl_path_content`.`folder`)) AS `folder`,`v_tpl_page_content`.`default_page` AS `is_default`,(case `v_tpl_page_content`.`default_page` when 1 then _latin1'Yes' else _latin1'' end) AS `default_page`,(case `v_tpl_page_content`.`for_search` when 1 then _latin1'Yes' else _latin1'' end) AS `for_search`,(case `v_tpl_page_content`.`is_locked` when 1 then _latin1'Yes' else _latin1'No' end) AS `locked`,(case `v_tpl_page_content`.`cachable` when _latin1'1' then _latin1'Yes' else _latin1'No' end) AS `cachable`,`v_tpl_page_content`.`language` AS `language`,`v_st`.`in_draft_state` AS `in_draft_state`,`v_st`.`publish_date` AS `edit_date`,`v_st`.`edit_date_draft` AS `edit_date_draft`,`v_st`.`edit_user` AS `edit_user` from ((`v_tpl_page_content` left join `v_tpl_path_content` on((((`v_tpl_page_content`.`folder_id` = `v_tpl_path_content`.`id`) and (`v_tpl_page_content`.`language` = `v_tpl_path_content`.`language`)) or isnull(`v_tpl_path_content`.`id`)))) join `v_tpl_non_folder_statistic` `v_st` on((`v_tpl_page_content`.`id` = `v_st`.`id`))) */;

--
-- Final view structure for view `v_tpl_page_not_locked`
--

/*!50001 DROP TABLE `v_tpl_page_not_locked`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_page_not_locked`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_page_not_locked` AS select `v_tpl_page`.`id` AS `id`,`v_tpl_page`.`page_name` AS `page_name`,`v_tpl_page`.`extension` AS `extension`,`v_tpl_page`.`page_description` AS `page_description`,`v_tpl_page`.`default_page` AS `default_page`,`v_tpl_page`.`create_date` AS `create_date`,`v_tpl_page`.`edit_date` AS `edit_date`,`v_tpl_page`.`tpl_id` AS `tpl_id`,`v_tpl_page`.`folder_id` AS `folder_id`,`v_tpl_page`.`for_search` AS `for_search`,`v_tpl_page`.`owner_name` AS `owner_name`,`v_tpl_page`.`is_locked` AS `is_locked`,`v_tpl_page`.`type` AS `type`,`v_tpl_page`.`file_name` AS `file_name`,`v_tpl_page`.`group_access` AS `group_access`,`v_tpl_page`.`priority` AS `priority`,`v_tpl_page`.`cachable` AS `cachable` from `v_tpl_page` where (`v_tpl_page`.`is_locked` = 0) */;

--
-- Final view structure for view `v_tpl_path_content`
--

/*!50001 DROP TABLE `v_tpl_path_content`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_path_content`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_path_content` AS select `v_tpl_folder`.`id` AS `id`,if(isnull(`regular_content`.`val`),if(isnull(`regular_content`.`val_draft`),if(isnull(`default_content`.`val`),if(isnull(`default_content`.`val_draft`),`v_tpl_folder`.`page_name`,`default_content`.`val_draft`),`default_content`.`val`),`regular_content`.`val_draft`),`regular_content`.`val`) AS `folder`,`language`.`language_code` AS `language` from (((`v_tpl_folder` join `v_language` `language`) left join `content` `regular_content` on(((`v_tpl_folder`.`id` = `regular_content`.`var_id`) and (`regular_content`.`var` = _utf8'folder_path_') and (`regular_content`.`language` = `language`.`language_code`)))) left join `content` `default_content` on(((`v_tpl_folder`.`id` = `default_content`.`var_id`) and (`default_content`.`var` = _utf8'folder_path_') and (`default_content`.`language` = (select `language`.`language_code` AS `language_code` from `language` where (`language`.`default_language` = 1)))))) */;

--
-- Final view structure for view `v_tpl_views`
--

/*!50001 DROP TABLE `v_tpl_views`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_views`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_views` AS select `tpl_views`.`id` AS `id`,`tpl_views`.`view_name` AS `view_name`,`tpl_views`.`view_folder` AS `view_folder`,`tpl_views`.`description` AS `description`,`tpl_views`.`icon` AS `icon`,`tpl_views`.`is_default` AS `is_default` from `tpl_views` */;

--
-- Final view structure for view `v_tpl_views_edit`
--

/*!50001 DROP TABLE `v_tpl_views_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_views_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_views_edit` AS select `tpl_views`.`id` AS `id`,`tpl_views`.`view_name` AS `view_name`,`tpl_views`.`view_folder` AS `view_folder`,`tpl_views`.`description` AS `description`,`tpl_views`.`icon` AS `icon`,`tpl_views`.`is_default` AS `is_default` from `tpl_views` */;

--
-- Final view structure for view `v_tpl_views_grid`
--

/*!50001 DROP TABLE `v_tpl_views_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_tpl_views_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tpl_views_grid` AS select `tpl_views`.`id` AS `id`,`tpl_views`.`view_name` AS `view_name`,`tpl_views`.`view_folder` AS `view_folder`,`tpl_views`.`description` AS `description`,`tpl_views`.`icon` AS `icon`,`tpl_views`.`is_default` AS `is_default`,(case `tpl_views`.`is_default` when 1 then _latin1'Yes' else _latin1'' end) AS `default_view` from `tpl_views` */;

--
-- Final view structure for view `v_user`
--

/*!50001 DROP TABLE `v_user`*/;
/*!50001 DROP VIEW IF EXISTS `v_user`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user` AS select `users`.`id` AS `id`,`users`.`name` AS `name`,`users`.`login` AS `login`,`users`.`passw` AS `passw`,`users`.`email` AS `email`,`users`.`status` AS `status`,`users`.`role` AS `role`,`users`.`content_access` AS `content_access`,`users`.`comment` AS `comment`,`users`.`icq` AS `icq`,`users`.`city` AS `city`,`users`.`resetpassw` AS `resetpassw`,`users`.`ip` AS `ip`,`users`.`browser` AS `browser`,`users`.`login_datetime` AS `login_datetime`,`users`.`month_visits` AS `month_visits`,`users`.`passw_update_datetime` AS `passw_update_datetime` from `users` */;

--
-- Final view structure for view `v_user_edit`
--

/*!50001 DROP TABLE `v_user_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_edit` AS select `users`.`id` AS `id`,`users`.`name` AS `name`,`users`.`login` AS `login`,`users`.`email` AS `email`,`users`.`status` AS `status`,`users`.`comment` AS `comment`,`users`.`icq` AS `icq`,`users`.`city` AS `city`,_latin1'' AS `change_password`,_latin1'' AS `old_password`,_latin1'' AS `new_password`,_latin1'' AS `confirm_new_password`,_latin1'' AS `currently`,`users`.`ip` AS `ip`,`users`.`browser` AS `browser`,date_format(`users`.`login_datetime`,_latin1'%d-%m-%Y %H:%i') AS `last_login`,`users`.`month_visits` AS `month_visits`,_latin1'' AS `user_groups`,`users`.`role` AS `role`,`users`.`content_access` AS `content_access` from `users` */;

--
-- Final view structure for view `v_user_grid`
--

/*!50001 DROP TABLE `v_user_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_grid` AS select `users`.`id` AS `id`,`users`.`name` AS `name`,`users`.`login` AS `login`,`users`.`email` AS `email`,(case `users`.`status` when 0 then _latin1'Disabled' when 1 then _latin1'Enabled' end) AS `status`,`users`.`role` AS `role`,(select `role`.`role_name` AS `role_name` from `role` where (`role`.`id` = `users`.`role`)) AS `role_name`,(select group_concat(`user_groups`.`group_name` separator ', ') AS `GROUP_CONCAT(user_groups.group_name SEPARATOR ', ')` from (`user_group` left join `user_groups` on((`user_groups`.`id` = `user_group`.`group_id`))) where (`user_group`.`user_id` = `users`.`id`) group by `user_group`.`user_id`) AS `groups` from `users` */;

--
-- Final view structure for view `v_user_groups`
--

/*!50001 DROP TABLE `v_user_groups`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_groups`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_groups` AS select `user_groups`.`id` AS `id`,`user_groups`.`group_name` AS `group_name`,`user_groups`.`group_code` AS `group_code` from `user_groups` */;

--
-- Final view structure for view `v_user_groups_edit`
--

/*!50001 DROP TABLE `v_user_groups_edit`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_groups_edit`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_groups_edit` AS select `user_groups`.`id` AS `id`,`user_groups`.`group_name` AS `group_name`,`user_groups`.`group_code` AS `group_code` from `user_groups` */;

--
-- Final view structure for view `v_user_groups_grid`
--

/*!50001 DROP TABLE `v_user_groups_grid`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_groups_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_groups_grid` AS select `user_groups`.`id` AS `id`,`user_groups`.`group_name` AS `group_name`,`user_groups`.`group_code` AS `group_code` from `user_groups` */;

--
-- Final view structure for view `v_user_profile`
--

/*!50001 DROP TABLE `v_user_profile`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_profile`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_profile` AS select `users`.`id` AS `id`,`users`.`name` AS `name`,`users`.`email` AS `email`,_latin1'' AS `change_password`,_latin1'' AS `old_password`,_latin1'' AS `new_password`,_latin1'' AS `confirm_new_password` from `users` */;

--
-- Final view structure for view `vbrowser_grid`
--

/*!50001 DROP TABLE `vbrowser_grid`*/;
/*!50001 DROP VIEW IF EXISTS `vbrowser_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vbrowser_grid` AS select `v_tpl_page_grid`.`id` AS `id`,`v_tpl_page_grid`.`page_name` AS `page_name`,`v_tpl_page_grid`.`page_description` AS `page_description`,`v_tpl_page_grid`.`template` AS `template`,`v_tpl_page_grid`.`folder` AS `folder`,`v_tpl_page_grid`.`is_default` AS `is_default`,`v_tpl_page_grid`.`default_page` AS `default_page`,`v_tpl_page_grid`.`for_search` AS `for_search`,`v_tpl_page_grid`.`locked` AS `locked`,`v_tpl_page_grid`.`cachable` AS `cachable`,`v_tpl_page_grid`.`language` AS `language`,`v_tpl_page_grid`.`in_draft_state` AS `in_draft_state`,`v_tpl_page_grid`.`edit_date` AS `edit_date`,`v_tpl_page_grid`.`edit_date_draft` AS `edit_date_draft`,`v_tpl_page_grid`.`edit_user` AS `edit_user` from `v_tpl_page_grid` */;

--
-- Final view structure for view `vmbrowser_grid`
--

/*!50001 DROP TABLE `vmbrowser_grid`*/;
/*!50001 DROP VIEW IF EXISTS `vmbrowser_grid`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`t1user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vmbrowser_grid` AS select `v_media_grid`.`id` AS `id`,`v_media_grid`.`media_name` AS `media_name`,`v_media_grid`.`media_description` AS `media_description`,`v_media_grid`.`template` AS `template`,`v_media_grid`.`folder` AS `folder`,`v_media_grid`.`edit_date` AS `edit_date`,`v_media_grid`.`cachable` AS `cachable`,`v_media_grid`.`in_draft_state` AS `in_draft_state`,`v_media_grid`.`language` AS `language` from `v_media_grid` */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-01-31 12:10:10
