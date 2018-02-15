-- MySQL dump 10.13  Distrib 5.7.21, for Win64 (x86_64)
--
-- Host: localhost    Database: oucit
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'文章'),(1,'普通用户');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,17),(9,1,32),(2,1,41),(3,1,46),(4,1,47),(5,1,49),(6,1,50),(7,1,51),(8,1,53),(10,2,25),(11,2,26),(12,2,27),(13,2,37),(14,2,38),(15,2,39),(16,2,55),(17,2,56),(18,2,57),(19,2,58),(20,2,59),(21,2,60);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add 用户',6,'add_myuser'),(17,'Can change 用户',6,'change_myuser'),(18,'Can delete 用户',6,'delete_myuser'),(19,'Can add 栏目二级分类',7,'add_articlecategory'),(20,'Can change 栏目二级分类',7,'change_articlecategory'),(21,'Can delete 栏目二级分类',7,'delete_articlecategory'),(22,'Can add 文章栏目',8,'add_articlecolumn'),(23,'Can change 文章栏目',8,'change_articlecolumn'),(24,'Can delete 文章栏目',8,'delete_articlecolumn'),(25,'Can add 文章',9,'add_basearticle'),(26,'Can change 文章',9,'change_basearticle'),(27,'Can delete 文章',9,'delete_basearticle'),(28,'Can add 首页轮播图',10,'add_carousel'),(29,'Can change 首页轮播图',10,'change_carousel'),(30,'Can delete 首页轮播图',10,'delete_carousel'),(31,'Can add 职责关系',11,'add_connection'),(32,'Can change 职责关系',11,'change_connection'),(33,'Can delete 职责关系',11,'delete_connection'),(34,'Can add 组织',12,'add_group'),(35,'Can change 组织',12,'change_group'),(36,'Can delete 组织',12,'delete_group'),(37,'Can add 合作办学',13,'add_hzbx'),(38,'Can change 合作办学',13,'change_hzbx'),(39,'Can delete 合作办学',13,'delete_hzbx'),(40,'Can add 院系、专业介绍',14,'add_introduce'),(41,'Can change 院系、专业介绍',14,'change_introduce'),(42,'Can delete 院系、专业介绍',14,'delete_introduce'),(43,'Can add 登录记录',15,'add_iprecord'),(44,'Can change 登录记录',15,'change_iprecord'),(45,'Can delete 登录记录',15,'delete_iprecord'),(46,'Can add 用户详细信息',16,'add_profile'),(47,'Can change 用户详细信息',16,'change_profile'),(48,'Can delete 用户详细信息',16,'delete_profile'),(49,'Can add 课程列表',17,'add_teach_course'),(50,'Can change 课程列表',17,'change_teach_course'),(51,'Can delete 课程列表',17,'delete_teach_course'),(52,'Can add 培养计划',18,'add_teach_plan'),(53,'Can change 培养计划',18,'change_teach_plan'),(54,'Can delete 培养计划',18,'delete_teach_plan'),(55,'Can add 学院新闻',19,'add_news'),(56,'Can change 学院新闻',19,'change_news'),(57,'Can delete 学院新闻',19,'delete_news'),(58,'Can add 学术报告',20,'add_xsbg'),(59,'Can change 学术报告',20,'change_xsbg'),(60,'Can delete 学术报告',20,'delete_xsbg'),(61,'Can add captcha store',21,'add_captchastore'),(62,'Can change captcha store',21,'change_captchastore'),(63,'Can delete captcha store',21,'delete_captchastore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_it_myuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_it_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(21,'captcha','captchastore'),(4,'contenttypes','contenttype'),(7,'it','articlecategory'),(8,'it','articlecolumn'),(9,'it','basearticle'),(10,'it','carousel'),(11,'it','connection'),(12,'it','group'),(13,'it','hzbx'),(14,'it','introduce'),(15,'it','iprecord'),(6,'it','myuser'),(19,'it','news'),(16,'it','profile'),(17,'it','teach_course'),(18,'it','teach_plan'),(20,'it','xsbg'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_articlecategory`
--

DROP TABLE IF EXISTS `it_articlecategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_articlecategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `belong_column_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `it_articlecategory_belong_column_id_afc96ac5_fk_it_articl` (`belong_column_id`),
  CONSTRAINT `it_articlecategory_belong_column_id_afc96ac5_fk_it_articl` FOREIGN KEY (`belong_column_id`) REFERENCES `it_articlecolumn` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_articlecategory`
--

LOCK TABLES `it_articlecategory` WRITE;
/*!40000 ALTER TABLE `it_articlecategory` DISABLE KEYS */;
INSERT INTO `it_articlecategory` VALUES (1,'规章制度',1),(2,'党员发展',1),(3,'党支部建设',1),(4,'规章制度',2),(5,'团支部',2),(6,'社会实践',2),(7,'志愿服务',2),(8,'通知公告',3),(9,'获奖情况',3),(10,'通知公告',4),(11,'就业政策',4),(12,'招聘信息',4),(13,'实习招聘',4),(14,'场地申请',5),(15,'出国相关',5),(16,'处分相关',5),(17,'就业相关',5),(18,'请假相关',5),(19,'宿舍相关',5),(20,'学业学籍',5),(21,'创新创业',5),(22,'资助相关',5),(23,'医保相关',5),(24,'其他',5),(25,'通知公告',6),(26,'获奖情况',6),(27,'学生风采',7),(28,'管理规定',8),(29,'学生组织',9),(30,'规章制度',10),(31,'计算机科学与技术系',11),(32,'海洋技术系',11),(33,'电子工程系',11),(34,'物理系',11),(35,'奖励实施细则',11),(36,'学院新闻',12),(37,'通知公告',12),(38,'学术报告',13);
/*!40000 ALTER TABLE `it_articlecategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_articlecolumn`
--

DROP TABLE IF EXISTS `it_articlecolumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_articlecolumn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `column_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_articlecolumn`
--

LOCK TABLES `it_articlecolumn` WRITE;
/*!40000 ALTER TABLE `it_articlecolumn` DISABLE KEYS */;
INSERT INTO `it_articlecolumn` VALUES (1,'党建工作'),(2,'团建工作'),(3,'奖助工作'),(4,'就业工作'),(5,'办事指南'),(6,'科技创新'),(7,'学生风采'),(8,'管理规定'),(9,'学生组织'),(10,'本科生教育'),(11,'研究生教育'),(12,'学院新闻'),(13,'学术报告');
/*!40000 ALTER TABLE `it_articlecolumn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_basearticle`
--

DROP TABLE IF EXISTS `it_basearticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_basearticle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `heading` varchar(50) NOT NULL,
  `subheading` varchar(50) NOT NULL,
  `author` varchar(15) NOT NULL,
  `source` varchar(15) NOT NULL,
  `open_jmp_url` tinyint(1) NOT NULL,
  `jmp_url` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `index_img` tinyint(1) NOT NULL,
  `index_img_url` varchar(200) NOT NULL,
  `article_top` tinyint(1) NOT NULL,
  `article_hot` tinyint(1) NOT NULL,
  `c_time` date NOT NULL,
  `category_id` int(11) NOT NULL,
  `column_id` int(11) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `it_basearticle_category_id_94426d7e_fk_it_articlecategory_id` (`category_id`),
  KEY `it_basearticle_column_id_ea8960b0_fk_it_articlecolumn_id` (`column_id`),
  KEY `it_basearticle_publisher_id_1405744c_fk_it_myuser_id` (`publisher_id`),
  CONSTRAINT `it_basearticle_category_id_94426d7e_fk_it_articlecategory_id` FOREIGN KEY (`category_id`) REFERENCES `it_articlecategory` (`id`),
  CONSTRAINT `it_basearticle_column_id_ea8960b0_fk_it_articlecolumn_id` FOREIGN KEY (`column_id`) REFERENCES `it_articlecolumn` (`id`),
  CONSTRAINT `it_basearticle_publisher_id_1405744c_fk_it_myuser_id` FOREIGN KEY (`publisher_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_basearticle`
--

LOCK TABLES `it_basearticle` WRITE;
/*!40000 ALTER TABLE `it_basearticle` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_basearticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_carousel`
--

DROP TABLE IF EXISTS `it_carousel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_carousel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic` varchar(100) NOT NULL,
  `headline` varchar(80) NOT NULL,
  `display_level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_carousel`
--

LOCK TABLES `it_carousel` WRITE;
/*!40000 ALTER TABLE `it_carousel` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_carousel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_connection`
--

DROP TABLE IF EXISTS `it_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_connection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_level` int(11) NOT NULL,
  `job_tile` varchar(100) NOT NULL,
  `job` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `group_fk_id` int(11) NOT NULL,
  `users_fk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `it_connection_group_fk_id_users_fk_id_05cb0010_uniq` (`group_fk_id`,`users_fk_id`),
  KEY `it_connection_users_fk_id_559697f0_fk_it_myuser_id` (`users_fk_id`),
  CONSTRAINT `it_connection_group_fk_id_32ac89a8_fk_it_group_id` FOREIGN KEY (`group_fk_id`) REFERENCES `it_group` (`id`),
  CONSTRAINT `it_connection_users_fk_id_559697f0_fk_it_myuser_id` FOREIGN KEY (`users_fk_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_connection`
--

LOCK TABLES `it_connection` WRITE;
/*!40000 ALTER TABLE `it_connection` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_connection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_group`
--

DROP TABLE IF EXISTS `it_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `type` varchar(10) NOT NULL,
  `pic` varchar(100) NOT NULL,
  `link_url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_group`
--

LOCK TABLES `it_group` WRITE;
/*!40000 ALTER TABLE `it_group` DISABLE KEYS */;
INSERT INTO `it_group` VALUES (1,'学院党委','0','',''),(2,'学院团委','0','','');
/*!40000 ALTER TABLE `it_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_hzbx`
--

DROP TABLE IF EXISTS `it_hzbx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_hzbx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `heading` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `c_time` datetime(6) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `it_hzbx_publisher_id_773186c6_fk_it_myuser_id` (`publisher_id`),
  CONSTRAINT `it_hzbx_publisher_id_773186c6_fk_it_myuser_id` FOREIGN KEY (`publisher_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_hzbx`
--

LOCK TABLES `it_hzbx` WRITE;
/*!40000 ALTER TABLE `it_hzbx` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_hzbx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_introduce`
--

DROP TABLE IF EXISTS `it_introduce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_introduce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department` varchar(20) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_introduce`
--

LOCK TABLES `it_introduce` WRITE;
/*!40000 ALTER TABLE `it_introduce` DISABLE KEYS */;
INSERT INTO `it_introduce` VALUES (1,'0',''),(2,'1',''),(3,'2',''),(4,'3',''),(5,'4',''),(6,'5',''),(7,'6',''),(8,'7',''),(9,'8',''),(10,'9',''),(11,'10',''),(12,'11',''),(13,'12','');
/*!40000 ALTER TABLE `it_introduce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_iprecord`
--

DROP TABLE IF EXISTS `it_iprecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_iprecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_addr` char(39) NOT NULL,
  `time` datetime(6) NOT NULL,
  `user_fk_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `it_iprecord_user_fk_id_fb237f73_fk_it_myuser_id` (`user_fk_id`),
  CONSTRAINT `it_iprecord_user_fk_id_fb237f73_fk_it_myuser_id` FOREIGN KEY (`user_fk_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_iprecord`
--

LOCK TABLES `it_iprecord` WRITE;
/*!40000 ALTER TABLE `it_iprecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_iprecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_myuser`
--

DROP TABLE IF EXISTS `it_myuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_myuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `number_id` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_id` (`number_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_myuser`
--

LOCK TABLES `it_myuser` WRITE;
/*!40000 ALTER TABLE `it_myuser` DISABLE KEYS */;
INSERT INTO `it_myuser` VALUES (1,'pbkdf2_sha256$36000$VGn0yeIjgtht$v+H/h1l/z5eYqE2W1H3MwRUKtSsImrA3yoQkn8f8adA=','2018-02-15 08:35:40.934588',1,'it','爱特工作室');
/*!40000 ALTER TABLE `it_myuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_myuser_groups`
--

DROP TABLE IF EXISTS `it_myuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_myuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `it_myuser_groups_myuser_id_group_id_6db8284d_uniq` (`myuser_id`,`group_id`),
  KEY `it_myuser_groups_group_id_5129496f_fk_auth_group_id` (`group_id`),
  CONSTRAINT `it_myuser_groups_group_id_5129496f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `it_myuser_groups_myuser_id_ef68569e_fk_it_myuser_id` FOREIGN KEY (`myuser_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_myuser_groups`
--

LOCK TABLES `it_myuser_groups` WRITE;
/*!40000 ALTER TABLE `it_myuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_myuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_myuser_user_permissions`
--

DROP TABLE IF EXISTS `it_myuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_myuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `it_myuser_user_permissions_myuser_id_permission_id_c3a973e7_uniq` (`myuser_id`,`permission_id`),
  KEY `it_myuser_user_permi_permission_id_8d6d0e60_fk_auth_perm` (`permission_id`),
  CONSTRAINT `it_myuser_user_permi_permission_id_8d6d0e60_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `it_myuser_user_permissions_myuser_id_8065afe2_fk_it_myuser_id` FOREIGN KEY (`myuser_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_myuser_user_permissions`
--

LOCK TABLES `it_myuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `it_myuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_myuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_news`
--

DROP TABLE IF EXISTS `it_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_news` (
  `basearticle_ptr_id` int(11) NOT NULL,
  `is_official` tinyint(1) NOT NULL,
  PRIMARY KEY (`basearticle_ptr_id`),
  CONSTRAINT `it_news_basearticle_ptr_id_9000fb43_fk_it_basearticle_id` FOREIGN KEY (`basearticle_ptr_id`) REFERENCES `it_basearticle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_news`
--

LOCK TABLES `it_news` WRITE;
/*!40000 ALTER TABLE `it_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_profile`
--

DROP TABLE IF EXISTS `it_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic` varchar(100) NOT NULL,
  `birthday` date NOT NULL,
  `politics_status` varchar(20) NOT NULL,
  `education` varchar(50) NOT NULL,
  `mobile_phone` varchar(15) NOT NULL,
  `office_phone` varchar(15) NOT NULL,
  `email` varchar(254) NOT NULL,
  `workplace` varchar(50) NOT NULL,
  `address` varchar(80) NOT NULL,
  `job_title` varchar(10) NOT NULL,
  `job` varchar(10) NOT NULL,
  `tutor` varchar(10) NOT NULL,
  `department` varchar(15) NOT NULL,
  `course` text NOT NULL,
  `experience` text NOT NULL,
  `research_direction` text NOT NULL,
  `research_project` text NOT NULL,
  `achievements` text NOT NULL,
  `paper` text NOT NULL,
  `enrolment` text NOT NULL,
  `remark` text NOT NULL,
  `user_fk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_fk_id` (`user_fk_id`),
  CONSTRAINT `it_profile_user_fk_id_6920bafd_fk_it_myuser_id` FOREIGN KEY (`user_fk_id`) REFERENCES `it_myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_profile`
--

LOCK TABLES `it_profile` WRITE;
/*!40000 ALTER TABLE `it_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_teach_course`
--

DROP TABLE IF EXISTS `it_teach_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_teach_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(50) NOT NULL,
  `department` varchar(20) NOT NULL,
  `major` varchar(20) NOT NULL,
  `course_type` varchar(30) NOT NULL,
  `course_id` varchar(30) NOT NULL,
  `course_name_english` varchar(100) NOT NULL,
  `course_hours` smallint(6) NOT NULL,
  `course_credit` double NOT NULL,
  `experiment_hours` smallint(6) NOT NULL,
  `experiment_credit` double NOT NULL,
  `recommend_book` varchar(200) NOT NULL,
  `recommend_book_author` varchar(200) NOT NULL,
  `recommend_book_publisher` varchar(200) NOT NULL,
  `recommend_book_time_version` varchar(200) NOT NULL,
  `course_object` text NOT NULL,
  `quiz_type` varchar(20) NOT NULL,
  `referance_book` text NOT NULL,
  `additional_file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_teach_course`
--

LOCK TABLES `it_teach_course` WRITE;
/*!40000 ALTER TABLE `it_teach_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_teach_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_teach_plan`
--

DROP TABLE IF EXISTS `it_teach_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_teach_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `major` varchar(20) NOT NULL,
  `u_time` date NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_teach_plan`
--

LOCK TABLES `it_teach_plan` WRITE;
/*!40000 ALTER TABLE `it_teach_plan` DISABLE KEYS */;
INSERT INTO `it_teach_plan` VALUES (1,'0','2018-02-15',''),(2,'1','2018-02-15',''),(3,'2','2018-02-15',''),(4,'3','2018-02-15',''),(5,'4','2018-02-15',''),(6,'5','2018-02-15',''),(7,'6','2018-02-15',''),(8,'7','2018-02-15','');
/*!40000 ALTER TABLE `it_teach_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `it_xsbg`
--

DROP TABLE IF EXISTS `it_xsbg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `it_xsbg` (
  `basearticle_ptr_id` int(11) NOT NULL,
  `meeting_place` varchar(100) NOT NULL,
  `meeting_time` datetime(6) NOT NULL,
  PRIMARY KEY (`basearticle_ptr_id`),
  CONSTRAINT `it_xsbg_basearticle_ptr_id_84b6608c_fk_it_basearticle_id` FOREIGN KEY (`basearticle_ptr_id`) REFERENCES `it_basearticle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_xsbg`
--

LOCK TABLES `it_xsbg` WRITE;
/*!40000 ALTER TABLE `it_xsbg` DISABLE KEYS */;
/*!40000 ALTER TABLE `it_xsbg` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-15 16:50:33
