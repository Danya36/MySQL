-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_23
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_status`
--

DROP TABLE IF EXISTS `activity_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_status` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `active_user_id` bigint(20) unsigned NOT NULL,
  `activity status` enum('Online','Offline') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  KEY `active_user_id` (`active_user_id`),
  CONSTRAINT `activity_status_ibfk_1` FOREIGN KEY (`active_user_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_status`
--

LOCK TABLES `activity_status` WRITE;
/*!40000 ALTER TABLE `activity_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_status` ENABLE KEYS */;
UNLOCK TABLES;


INSERT INTO `apps` 
VALUES (1,'similique','paid',1),(2,'ut','free',12),(3,'et','free',12),(4,'cumque','paid',20),(5,'ea','paid',17),(6,'eaque','free',12),(7,'tempore','free',9),(8,'tempore','paid',17),(9,'placeat','paid',15),(10,'amet','free',3),(11,'illo','free',18),(12,'omnis','paid',17),(13,'ea','free',2),(14,'impedit','free',2),(15,'perferendis','free',9),(16,'accusantium','free',6),(17,'nostrum','paid',18),(18,'voluptate','paid',3),(19,'doloremque','free',16),(20,'et','paid',6);
/*!40000 ALTER TABLE `apps` ENABLE KEYS */;
UNLOCK TABLES;


/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` 
VALUES (6,'architecto'),(14,'architecto'),(4,'dolorum'),(3,'enim'),(9,'error'),(7,'eveniet'),(12,'fugit'),(15,'id'),(13,'in'),(20,'nemo'),(2,'non'),(10,'officia'),(8,'quidem'),(5,'soluta'),(16,'sunt'),(17,'sunt'),(1,'tenetur'),(18,'ut'),(19,'ut'),(11,'veniam');
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends_requests`
--

DROP TABLE IF EXISTS `friends_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friends_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friends_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends_requests`
--

LOCK TABLES `friends_requests` WRITE;
/*!40000 ALTER TABLE `friends_requests` DISABLE KEYS */;
INSERT INTO `friends_requests` 
VALUES (1,3,'approved','1980-12-13 13:59:14','1982-04-21 03:02:39'),(1,14,'requested','1983-09-10 07:33:57','1971-09-15 11:40:49'),(2,12,'declined','1992-07-03 07:39:49','2014-02-23 14:38:36'),(7,11,'approved','2006-12-12 09:05:41','2013-01-12 15:23:49'),(7,20,'approved','2004-04-19 10:50:56','1995-09-03 02:18:04'),(8,6,'approved','2010-03-25 10:00:14','1988-04-13 08:12:06'),(9,3,'declined','1970-01-11 21:56:28','1974-06-15 14:53:11'),(9,7,'unfriended','1970-11-25 19:44:39','1980-12-26 15:26:32'),(9,19,'declined','2017-09-15 19:34:50','2013-04-16 15:30:57'),(11,3,'unfriended','1991-09-17 21:38:01','1980-10-19 12:53:47'),(11,8,'unfriended','2009-12-28 06:35:16','1998-12-04 09:51:15'),(12,14,'declined','2000-07-21 22:12:04','1973-06-03 06:04:27'),(12,15,'unfriended','1996-02-05 14:28:56','2017-04-27 13:32:58'),(13,6,'unfriended','2003-04-29 14:48:24','1996-07-06 17:07:43'),(14,17,'approved','1999-06-02 04:10:48','2001-11-01 01:22:38'),(15,1,'requested','1997-12-29 14:42:15','1993-02-11 05:27:01'),(17,10,'unfriended','2003-03-18 13:46:09','2008-12-19 13:44:17'),(18,17,'declined','1975-05-25 01:06:04','2002-01-18 10:43:36'),(19,3,'declined','2021-02-26 08:32:48','1980-06-13 20:32:48'),(19,16,'declined','1985-07-11 09:57:37','1974-08-02 01:58:27');
/*!40000 ALTER TABLE `friends_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` 
VALUES (1,18,15,'1978-02-07 00:02:05'),(2,2,3,'2021-09-17 20:31:10'),(3,11,9,'1973-04-10 18:08:19'),(4,8,11,'2014-09-02 12:29:25'),(5,14,6,'1991-10-02 19:49:48'),(6,13,14,'2014-04-10 07:32:20'),(7,17,5,'2008-12-09 00:00:45'),(8,13,14,'2004-11-20 05:32:57'),(9,17,2,'2000-03-15 04:09:49'),(10,10,11,'1977-11-19 00:20:51'),(11,5,8,'1974-07-31 04:01:48'),(12,7,6,'1986-02-24 09:26:03'),(13,9,15,'1978-03-05 04:00:54'),(14,12,7,'1994-11-27 02:38:56'),(15,17,8,'1993-08-09 05:09:20'),(16,13,15,'1984-01-30 17:24:45'),(17,2,14,'1988-06-02 03:36:20'),(18,17,13,'2015-09-12 05:43:19'),(19,3,5,'2018-03-31 15:53:40'),(20,4,17,'1996-08-15 09:11:09');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` 
VALUES 
(1,8,'Suscipit repellat dolorem corrupti facilis et. Qui rem libero alias et aperiam facere. Dignissimos saepe reprehenderit tenetur necessitatibus harum. Molestiae perferendis ut maiores tempore dolore iste. Incidunt voluptates et eum qui nihil.',11,'consequatur',19,'2021-02-26 20:10:34','2020-04-06 22:20:24'),
(2,18,'Nostrum ut veritatis sapiente molestias. Non magnam sit sed quam. Vitae ab molestias eius aliquid dolores molestias.',12,'totam',795692,'1976-12-26 00:55:21','2002-09-23 10:57:16'),
(3,19,'Quis magnam veritatis omnis perspiciatis quidem eligendi inventore commodi. Atque non eum est qui ducimus inventore ut similique. Error est distinctio placeat ut aut provident est ut. Nulla aut esse exercitationem est consequatur.',5,'non',3459065,'1997-01-14 04:54:40','1993-03-04 14:47:07'),
(4,18,'Iure ut qui voluptatibus quibusdam harum reprehenderit. Ea provident provident corporis nostrum quia quae quisquam. Amet atque tempore et et optio explicabo veniam sapiente. Asperiores unde doloribus excepturi.',14,'et',46961165,'2019-07-12 22:26:14','2021-04-07 01:50:02'),
(5,2,'Nemo exercitationem consequatur aliquam quia sequi eligendi modi. Rerum quo sint nobis eos. Accusamus nihil perspiciatis inventore omnis voluptatem deleniti. Et harum omnis aut vitae non maiores.',16,'facilis',892425106,'1986-09-11 05:10:25','2006-06-03 05:09:14'),
(6,14,'Rerum harum debitis et repellendus rerum eveniet. Consequatur rerum voluptates eius ratione. Nam repellat amet nemo nihil inventore dolore.',10,'nisi',84129,'2012-10-05 21:17:08','1980-09-09 10:32:06'),
(7,20,'In ratione iste veniam consequatur est. Necessitatibus nisi vel nesciunt suscipit. Sit commodi tempora maiores quae est. Velit dolorem quas quod minus repellat.',5,'non',9357,'1972-10-22 23:34:43','1973-07-27 22:12:10'),
(8,20,'Voluptatum ratione quo aut aliquid. Tenetur nihil qui iste. Iste enim distinctio perferendis corrupti voluptas itaque. Expedita eaque ratione debitis dignissimos unde nostrum facere.',10,'quas',25,'2013-06-16 20:50:40','1995-07-07 11:42:56'),
(9,1,'Qui eum nihil dignissimos reprehenderit. Et velit rerum est aut praesentium sequi placeat qui. A dolorem odit et sunt.',3,'et',98,'2007-11-02 05:47:19','1981-06-03 14:28:25'),
(10,15,'Rerum repellendus dicta impedit fuga est esse. Laboriosam et quaerat aliquid. Reiciendis dolore blanditiis quo tenetur qui molestiae reprehenderit similique. Cumque aliquid et voluptas.',1,'officia',346,'2000-10-15 05:12:43','2004-05-28 04:21:13'),
(11,2,'Recusandae ut amet reprehenderit vero sunt. Et nam ipsum veritatis voluptas in sed. Esse quo architecto qui blanditiis vitae quisquam repudiandae.',19,'eaque',1,'1985-04-14 22:50:12','2012-03-09 14:57:13'),
(12,5,'Tempora harum praesentium qui quis et rem quia. Explicabo unde occaecati molestias omnis suscipit voluptate error.',12,'eos',0,'1974-11-24 22:40:26','2008-09-29 09:27:45'),
(13,4,'Architecto qui perferendis assumenda ducimus. Repudiandae dolor sequi facilis explicabo eum vel totam non. Qui perspiciatis eaque optio id vel.',16,'quia',2,'2015-01-23 20:56:54','1989-08-21 18:57:20'),
(14,14,'Culpa perferendis nulla vitae quae. Error veniam nam omnis quia dignissimos sed. Eius in a corrupti animi et. Ut provident est veritatis voluptatem voluptatem temporibus omnis.',10,'sit',84846537,'2003-12-21 03:38:22','2006-02-10 10:32:53'),
(15,9,'Vel qui et et illum officia. Quas explicabo rerum reiciendis rerum id quidem qui. Et et cum debitis. Quasi autem autem perferendis eum.',16,'exercitationem',1941,'1977-04-20 06:31:11','1981-06-22 02:15:28'),
(16,20,'Aliquam officiis incidunt rerum totam neque corrupti impedit. Ratione itaque accusantium ut id a non natus quaerat. Dolores praesentium quasi odio ad consequatur omnis harum.',16,'incidunt',7074,'1979-01-17 17:24:22','1978-12-14 00:38:42'),
(17,6,'Optio perspiciatis placeat cum et mollitia dolore numquam adipisci. Voluptatem sit dolorem nihil nulla ad excepturi velit. Quibusdam est veniam necessitatibus in ut omnis dolores. Molestiae dolor hic praesentium in.',17,'nihil',172748276,'1976-09-27 00:54:52','2002-06-13 05:53:50'),
(18,8,'Et eaque nemo aut. Quas dignissimos officiis vel expedita aspernatur qui. Est ratione provident illum fugit facilis. Et non voluptas ullam dolores ipsam rem ex.',5,'quis',86722454,'2013-09-03 17:16:48','1997-06-28 19:24:14'),
(19,1,'Reiciendis perferendis quidem rerum. Voluptas eum inventore non fugiat molestias. Quia exercitationem veritatis iste deserunt et dolor maxime. In et nisi nihil eos.',5,'recusandae',2,'2003-09-30 21:59:14','2003-01-03 02:25:35'),
(20,18,'Sint molestiae at cumque. Dolorum temporibus dolore consequatur atque. Quae omnis alias beatae occaecati quaerat consequuntur. Eligendi praesentium fuga omnis quas sit.',3,'sed',2667488,'2000-09-24 01:41:15','1988-07-27 04:21:10');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` 
VALUES (1,'qui','2004-03-18 11:37:19','1992-12-02 16:54:56'),(2,'quidem','1993-08-04 05:57:02','1980-03-16 13:06:37'),(3,'impedit','1986-07-19 11:15:44','1991-09-05 15:06:44'),(4,'qui','2017-04-17 19:44:10','2003-11-02 22:38:39'),(5,'hic','2020-10-21 16:57:42','2012-07-18 00:14:17'),(6,'nisi','1999-05-18 06:59:53','1986-08-25 13:32:52'),(7,'quidem','2001-02-01 10:33:18','2000-10-05 04:41:57'),(8,'nihil','2004-08-27 02:44:00','1984-08-07 09:20:25'),(9,'doloribus','2005-06-14 23:14:14','1989-01-05 11:56:00'),(10,'delectus','1995-05-16 19:49:37','2012-07-16 16:29:59'),(11,'cumque','2007-10-24 18:49:24','1994-11-21 10:27:55'),(12,'dolor','2009-09-20 04:01:10','2022-06-21 09:30:54'),(13,'ut','1989-09-09 18:43:34','2009-02-14 03:18:48'),(14,'doloremque','2003-01-28 03:35:30','2017-09-24 16:47:03'),(15,'illum','1982-02-24 01:20:41','1993-11-09 07:41:05'),(16,'assumenda','1979-01-11 12:43:53','2009-07-13 01:37:45'),(17,'necessitatibus','2016-03-05 17:15:52','2017-07-05 19:27:37'),(18,'quam','1971-04-21 20:56:57','2018-10-25 07:49:31'),(19,'rerum','1979-07-30 21:46:14','1979-09-08 14:55:50'),(20,'rerum','2005-01-11 08:39:14','2020-07-14 20:55:43');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` 
VALUES (1,13,18,'Culpa ducimus dolorem est maiores voluptate. Eius quis voluptas expedita sit voluptatem. Repellendus error voluptatem hic ipsum odio optio. Eos optio ut cupiditate voluptatem officia repudiandae expedita.','1988-10-26 15:29:01'),(2,1,12,'Occaecati dicta sit velit porro amet. Velit dolorem est et ipsa ad voluptatem. Et et recusandae fugiat officia. Omnis rerum ea facere molestias fugiat sed aut quibusdam.','1989-06-18 03:47:05'),(3,15,3,'Molestias veniam libero non ut repellat aut. Quae dolorem omnis labore illum architecto. Tempore et iste omnis accusamus temporibus illo. Expedita saepe exercitationem neque ut.','1983-11-12 19:43:24'),(4,2,19,'Unde laboriosam non unde illo. Veritatis voluptatibus aut ut alias architecto dolorum. Impedit consequatur et esse quibusdam consequatur quidem. Temporibus et sunt est minus fuga.','1970-02-14 16:56:14'),(5,3,17,'Molestias similique sit fugit. Aperiam optio aut qui architecto voluptate. Est qui enim rem enim hic sed. Rerum et a libero eos. Esse molestias quo veritatis.','2020-06-21 13:24:12'),(6,11,7,'Impedit possimus minus sit error odio. Sint fugit voluptates amet. Quos natus consequuntur tempora impedit.','2016-08-31 14:33:43'),(7,7,10,'Quo qui sint expedita iusto qui. Et quibusdam dolorum modi voluptas voluptas. Nisi voluptates ex at aut. Consequatur qui accusamus est praesentium.','1971-04-27 09:16:28'),(8,5,19,'Soluta tempore quia fugit nulla. Labore qui excepturi optio quo. Ut accusantium corporis quos impedit et non mollitia. Eum minus magnam repellat veritatis.','1995-01-03 11:11:32'),(9,12,1,'Qui vero ut eveniet ducimus magni sequi ut id. Autem voluptatem fugit sint. Cumque consequatur quia et aut similique est voluptatem. Minima et amet voluptas rerum similique.','1997-08-28 05:15:03'),(10,1,17,'Ipsa quaerat quam quia ex. Ex sit repudiandae vel doloremque sequi enim et. Necessitatibus eos illo assumenda ab eligendi beatae.','1993-12-07 07:45:59'),(11,3,17,'Mollitia nihil quo in repellendus. Ad sequi adipisci sunt sint.','2012-11-12 14:41:32'),(12,10,13,'Error deleniti alias repellendus minima voluptas sapiente voluptas est. Sit ut impedit eos sunt suscipit veritatis. Assumenda magni quisquam facere dolor aut aliquam vitae.','1981-02-06 06:18:57'),(13,2,16,'Et ut nemo vero aut vel quia sit. Rerum perferendis aspernatur porro quae ut nihil quia. Dolorem praesentium delectus ut sunt libero.','1989-08-07 14:02:20'),(14,1,20,'Et illum quidem natus et non ut eaque. Facere dolorum qui exercitationem. Dolore molestiae ea placeat voluptatem vel nobis aut.','2002-06-30 16:28:50'),(15,13,3,'Et sit sit nam sed et quis. Quia voluptatibus autem consectetur animi. Aut perferendis voluptatem tempore ipsum odio est.','1993-09-11 11:06:36'),(16,16,6,'Quo et occaecati mollitia itaque vitae. Blanditiis explicabo ut qui. Porro tenetur fugit tempora iusto odio minima dolores animi. Est veritatis sed nam provident quis.','1977-01-05 19:10:43'),(17,1,17,'Beatae est aut atque cupiditate. Atque consectetur similique aperiam nemo consequatur ut. Porro accusamus dolore dolorem omnis excepturi.','2017-10-01 07:53:49'),(18,18,16,'Cum maxime tenetur impedit aut. Ullam voluptatibus blanditiis eveniet laboriosam laudantium adipisci maxime. Neque possimus quod culpa. Velit sed sit ratione qui. Vero sit rerum aut aliquam tempore ab natus.','1973-01-13 15:30:09'),(19,19,19,'Ducimus odio ut eveniet aspernatur vel nihil. Occaecati qui ea est quam.','2013-12-12 10:45:15'),(20,14,2,'Deleniti aperiam maxime sit quibusdam nulla nesciunt quas excepturi. Pariatur voluptas non inventore et error quibusdam modi voluptatem. Sit eveniet recusandae ratione ea. Provident consequuntur et est beatae quod eos aut.','1997-10-17 08:21:56');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` 
VALUES (1,'quos',16),(2,'eos',4),(3,'quis',8),(4,'repellat',2),(5,'quia',13),(6,'et',13),(7,'animi',1),(8,'rem',5),(9,'corrupti',13),(10,'et',1),(11,'illum',1),(12,'in',15),(13,'dolores',17),(14,'eius',10),(15,'assumenda',8),(16,'explicabo',19),(17,'sit',6),(18,'eius',8),(19,'placeat',18),(20,'qui',19);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` 
VALUES (1,14,4),(2,14,1),(3,6,15),(4,10,9),(5,5,20),(6,17,17),(7,5,16),(8,3,19),(9,2,15),(10,2,20),(11,6,3),(12,5,10),(13,1,15),(14,16,8),(15,9,13),(16,14,3),(17,17,7),(18,4,2),(19,2,14),(20,11,6);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `video_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  KEY `fk_photo_id` (`photo_id`),
  KEY `fk_video_id` (`video_id`),
  CONSTRAINT `fk_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_video_id` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` 
VALUES (1,'f','1970-08-07',13,7,'2017-08-18 12:03:12'),(2,'m','1974-12-27',3,18,'1990-10-04 07:58:45'),(3,'m','2022-06-08',3,6,'1994-03-24 19:34:48'),(4,'f','1983-09-14',16,5,'2020-08-06 09:02:41'),(5,'m','2004-07-22',20,18,'2002-05-11 19:13:24'),(6,'f','2018-10-15',5,6,'2017-03-14 15:57:49'),(7,'m','1988-11-04',20,9,'1971-05-13 19:52:45'),(8,'m','1990-02-19',15,20,'2011-01-29 21:56:15'),(9,'f','2002-12-01',3,11,'1986-07-22 16:46:52'),(10,'m','2016-12-07',7,12,'1974-12-17 17:34:07'),(11,'f','2020-12-03',3,20,'1996-09-04 08:38:43'),(12,'f','1970-07-11',15,19,'2009-08-09 09:59:57'),(13,'f','1986-05-04',7,18,'1977-02-19 03:42:02'),(14,'f','1975-09-12',1,8,'2017-09-29 14:28:55'),(15,'m','2001-08-02',11,11,'2001-05-30 02:01:39'),(16,'f','1981-08-22',14,4,'1997-10-07 09:36:25'),(17,'m','2005-08-08',18,17,'2022-05-07 05:03:30'),(18,'m','2014-09-16',1,20,'1984-09-29 15:29:38'),(19,'f','1993-05-23',2,17,'1997-09-26 22:03:33'),(20,'f','2003-10-19',5,2,'1978-12-30 00:41:20');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Фамилия',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_lastname_firstname_idx` (`lastname`,`firstname`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` 
VALUES (1,'Maximilian','Yost','lpaucek@example.org','76a5e2b5e3708f7bf344d8417a40a8896bffc9aa',9131234567,''),(2,'Aurelie','Kirlin','mcummings@example.net','d7877903adfec0dcf91971ab90300dbc2467ff73',9131234567,'\0'),(3,'Laurine','Erdman','jacquelyn74@example.net','616a9b44b7e5f3cd19e97ba535671a0700e3abf8',9131234567,''),(4,'Braeden','Feest','bogan.abigale@example.com','44bb25f912a3c4e447fd054f77073597cff0e926',9131234567,''),(5,'Carmen','Zulauf','oemard@example.org','35bdab66198f6982a051a2592f40c5aa4f0ce285',9131234567,'\0'),(6,'Brock','Miller','trace.block@example.com','8e3d1e84d35d54e4642a4893b5e3ae9f4346ccc1',9131234567,'\0'),(7,'Barney','Labadie','ernesto.wiegand@example.net','1bc379121b6f86dec374bc30af4e1addd745c208',9131234567,'\0'),(8,'Lyla','Wilkinson','johns.jeffrey@example.com','063e72d64e35817ff5c5d667ead973a14b19c453',9131234567,''),(9,'Charlie','Schaefer','preichert@example.org','88a7dfdb058b08c2d8e13d905c8c56e9d15dd00d',9131234567,''),(10,'Tyrique','Altenwerth','keanu.schaefer@example.net','5153d008bb7e2e4fbfa8da5f973187fdd5ae40af',9131234567,'\0'),(11,'Lilly','Lesch','vd\'amore@example.com','ef206d5025f7b6ab33f349004c730546d3f9bb21',9131234567,''),(12,'Ross','DuBuque','palma46@example.org','7e8833d791866a441686272b34b26456c68fa220',9131234567,''),(13,'Branson','Schuppe','xschaefer@example.net','d70936a859aea05b38edc787c9fcde6f33c1c1e8',9131234567,''),(14,'Robert','Waelchi','mstracke@example.com','6a17b75106c43f883d7dbcd621d86f1199ac9371',9131234567,''),(15,'Major','Kessler','esperanza46@example.com','0acfb2ddf63be84c106b477173af34ef6fec8bd8',9131234567,'\0'),(16,'Abagail','Barton','adolphus25@example.com','7a6edc218e1f15199679f17bd5f18fd4aca0fa25',9131234567,''),(17,'Veronica','Koelpin','jovan.goldner@example.com','eb1afcc31e022f0b984e52033fd5f3382e5504ad',9131234567,''),(18,'Miguel','Muller','ycormier@example.net','8892f801fe8285941cdd77676bccec3ea04fb3e1',9131234567,''),(19,'Casper','Runolfsson','stephon.goldner@example.net','90d92b807b11225dbca2b204d2275fba4ff82edb',9131234567,''),(20,'Anabel','Bahringer','kacie.fisher@example.com','558c4b0c44aaca677f54d5adb672daea5d41b252',9131234567,'');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_apps`
--

DROP TABLE IF EXISTS `users_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_apps` (
  `user_id` bigint(20) unsigned NOT NULL,
  `apps_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`apps_id`),
  KEY `apps_id` (`apps_id`),
  CONSTRAINT `users_apps_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_apps_ibfk_2` FOREIGN KEY (`apps_id`) REFERENCES `apps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_apps`
--

LOCK TABLES `users_apps` WRITE;
/*!40000 ALTER TABLE `users_apps` DISABLE KEYS */;
INSERT INTO `users_apps` 
VALUES (1,7),(2,9),(4,14),(6,13),(6,17),(7,2),(7,3),(7,16),(7,19),(9,4),(9,7),(9,14),(13,4),(13,14),(14,6),(14,19),(15,2),(18,16),(20,15);
/*!40000 ALTER TABLE `users_apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (1,8),(1,20),(2,10),(3,5),(3,20),(4,12),(4,15),(5,4),(5,9),(7,7),(7,14),(8,4),(10,8),(11,2),(11,6),(11,16),(12,1),(12,11),(15,18),(18,1);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_albums`
--

DROP TABLE IF EXISTS `video_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `video_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_albums`
--

LOCK TABLES `video_albums` WRITE;
/*!40000 ALTER TABLE `video_albums` DISABLE KEYS */;
INSERT INTO `video_albums` 
VALUES (1,'consequatur',13),(2,'quo',7),(3,'voluptatibus',10),(4,'enim',4),(5,'ducimus',8),(6,'est',3),(7,'porro',7),(8,'eveniet',7),(9,'voluptas',18),(10,'tenetur',5),(11,'placeat',13),(12,'vero',19),(13,'quae',11),(14,'tenetur',19),(15,'fuga',15),(16,'quia',19),(17,'consequatur',10),(18,'at',13),(19,'id',7),(20,'dolores',5);
/*!40000 ALTER TABLE `video_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `video_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `videos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` 
VALUES (1,10,17),(2,10,7),(3,1,3),(4,20,18),(5,5,10),(6,8,9),(7,17,15),(8,15,6),(9,10,6),(10,12,7),(11,14,4),(12,1,15),(13,18,18),(14,7,1),(15,2,10),(16,17,12),(17,7,7),(18,18,7),(19,10,17),(20,5,14);
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-19 21:51:32
