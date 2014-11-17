-- MySQL dump 10.13  Distrib 5.6.13, for osx10.7 (x86_64)
--
-- Host: localhost    Database: furger_strategy2
-- ------------------------------------------------------
-- Server version	5.6.13

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
-- Table structure for table `analysis_competitor`
--

DROP TABLE IF EXISTS `analysis_competitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_competitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `evaluation` bit(1) NOT NULL DEFAULT b'0',
  `overview` bit(1) NOT NULL DEFAULT b'0',
  `detail` bit(1) NOT NULL DEFAULT b'0',
  `sales` int(11) DEFAULT NULL,
  `db` int(11) DEFAULT NULL,
  `ebit` int(11) DEFAULT NULL,
  `market_share` double DEFAULT NULL,
  `remark_evaluation` varchar(256) DEFAULT NULL,
  `type_overview` int(11) DEFAULT NULL,
  `attribute1` varchar(45) DEFAULT NULL,
  `attribute2` varchar(45) DEFAULT NULL,
  `head_office` varchar(256) DEFAULT NULL,
  `founded` varchar(256) DEFAULT NULL,
  `revenue` varchar(256) DEFAULT NULL,
  `employee` varchar(256) DEFAULT NULL,
  `employees` varchar(256) DEFAULT NULL,
  `production` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `competitor_tool_fk_id_idx` (`version_id`),
  CONSTRAINT `competitor_version_fk_id` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_competitor`
--

LOCK TABLES `analysis_competitor` WRITE;
/*!40000 ALTER TABLE `analysis_competitor` DISABLE KEYS */;
INSERT INTO `analysis_competitor` VALUES (6,1,'kevin','\0','\0','\0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'fghjghj','jkl','ghjk',NULL,NULL,NULL),(7,1,'johan','\0','\0','\0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,1,'fgh','\0','\0','\0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,1,'Mei','\0','\0','\0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,1,'mich','\0','\0','\0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `analysis_competitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_competitor_input`
--

DROP TABLE IF EXISTS `analysis_competitor_input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_competitor_input` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `competitor_id` int(11) NOT NULL,
  `name` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `analysis_competitors_competitor_type_fk` (`type_id`),
  KEY `analysis_competitors_competitor_input_fk` (`competitor_id`),
  CONSTRAINT `analysis_competitors_competitor_input` FOREIGN KEY (`competitor_id`) REFERENCES `analysis_competitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `analysis_competitors_competitor_type` FOREIGN KEY (`type_id`) REFERENCES `analysis_competitor_input_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_competitor_input`
--

LOCK TABLES `analysis_competitor_input` WRITE;
/*!40000 ALTER TABLE `analysis_competitor_input` DISABLE KEYS */;
INSERT INTO `analysis_competitor_input` VALUES (1,1,6,'ghjk'),(2,2,6,'gfd'),(3,2,6,'gfd'),(4,3,6,'fbfd'),(5,3,6,'bbdfb'),(6,3,6,'dfbd'),(7,4,6,'gfbdfb'),(8,3,7,'vd'),(9,3,7,'vdv'),(10,3,7,'ds'),(11,11,7,'bfdbd'),(12,11,7,'db'),(13,11,7,'d');
/*!40000 ALTER TABLE `analysis_competitor_input` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_competitor_input_type`
--

DROP TABLE IF EXISTS `analysis_competitor_input_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_competitor_input_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_competitor_input_type`
--

LOCK TABLES `analysis_competitor_input_type` WRITE;
/*!40000 ALTER TABLE `analysis_competitor_input_type` DISABLE KEYS */;
INSERT INTO `analysis_competitor_input_type` VALUES (1,'ownership'),(2,'finance'),(3,'strategy'),(4,'client'),(5,'marketing'),(6,'products'),(7,'competence'),(8,'production'),(9,'cost'),(10,'technology'),(11,'competitor_strength'),(12,'competitor_weakness'),(13,'own_strength'),(14,'own_weakness');
/*!40000 ALTER TABLE `analysis_competitor_input_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_competitor_overview`
--

DROP TABLE IF EXISTS `analysis_competitor_overview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_competitor_overview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `competitor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_competitor_overview`
--

LOCK TABLES `analysis_competitor_overview` WRITE;
/*!40000 ALTER TABLE `analysis_competitor_overview` DISABLE KEYS */;
INSERT INTO `analysis_competitor_overview` VALUES (8,4,6),(19,2,9),(20,2,6),(21,4,10);
/*!40000 ALTER TABLE `analysis_competitor_overview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_market`
--

DROP TABLE IF EXISTS `analysis_market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_market` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competitor_id` int(11) NOT NULL,
  `market_share` double NOT NULL,
  `remark` varchar(256) DEFAULT NULL,
  `master_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `market_tool_fk_id_idx` (`master_id`),
  KEY `market_comp_fk_id` (`competitor_id`),
  CONSTRAINT `market_comp_fk_id` FOREIGN KEY (`competitor_id`) REFERENCES `analysis_competitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `market_tool_fk_id` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_market`
--

LOCK TABLES `analysis_market` WRITE;
/*!40000 ALTER TABLE `analysis_market` DISABLE KEYS */;
INSERT INTO `analysis_market` VALUES (1,6,42,'Aber hallo',172),(2,7,68,'gfds',172),(5,6,21,'gfds',172);
/*!40000 ALTER TABLE `analysis_market` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_trend`
--

DROP TABLE IF EXISTS `analysis_trend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_trend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL DEFAULT '1',
  `trend` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `effect` varchar(45) DEFAULT NULL,
  `relevance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trend_tool_fk_id_idx` (`master_id`),
  CONSTRAINT `trend_tool_fk_id` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_trend`
--

LOCK TABLES `analysis_trend` WRITE;
/*!40000 ALTER TABLE `analysis_trend` DISABLE KEYS */;
/*!40000 ALTER TABLE `analysis_trend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_usp_corecomp`
--

DROP TABLE IF EXISTS `analysis_usp_corecomp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_usp_corecomp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `us` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usp_process_id_fk_idx` (`master_id`),
  CONSTRAINT `usp_process_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_usp_corecomp`
--

LOCK TABLES `analysis_usp_corecomp` WRITE;
/*!40000 ALTER TABLE `analysis_usp_corecomp` DISABLE KEYS */;
INSERT INTO `analysis_usp_corecomp` VALUES (7,159,'KK1',10),(10,165,'KK1',0);
/*!40000 ALTER TABLE `analysis_usp_corecomp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_usp_corecompbuyc`
--

DROP TABLE IF EXISTS `analysis_usp_corecompbuyc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_usp_corecompbuyc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checked` tinyint(1) NOT NULL,
  `master_id` int(11) NOT NULL,
  `buyC_id` int(11) NOT NULL,
  `corecomp_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usp_corecompbiuc_corecomp_id_fk` (`corecomp_id`),
  KEY `usp_corecompbuyc_buyc_id_fk` (`buyC_id`),
  KEY `usp_corecompbuyc_object_id_fk_idx` (`master_id`),
  CONSTRAINT `usp_corecompbiuc_corecomp_id_fk` FOREIGN KEY (`corecomp_id`) REFERENCES `analysis_usp_corecomp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usp_corecompbuyc_buyc_id_fk` FOREIGN KEY (`buyC_id`) REFERENCES `analysis_value_buycriteria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usp_corecompbuyc_object_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_usp_corecompbuyc`
--

LOCK TABLES `analysis_usp_corecompbuyc` WRITE;
/*!40000 ALTER TABLE `analysis_usp_corecompbuyc` DISABLE KEYS */;
INSERT INTO `analysis_usp_corecompbuyc` VALUES (10,1,159,18,7),(11,1,159,20,7),(12,1,159,21,7),(14,1,165,22,10);
/*!40000 ALTER TABLE `analysis_usp_corecompbuyc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_usp_corecompcompetitors`
--

DROP TABLE IF EXISTS `analysis_usp_corecompcompetitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_usp_corecompcompetitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) NOT NULL,
  `competitor_id` int(11) NOT NULL,
  `usp` int(11) NOT NULL,
  `corecomp_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usp_comp_id_fk` (`competitor_id`),
  KEY `usp_corecomp_id_fk` (`corecomp_id`),
  KEY `usp_master_id_fk_idx` (`master_id`),
  CONSTRAINT `usp_comp_id_fk` FOREIGN KEY (`competitor_id`) REFERENCES `analysis_value_competitors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usp_corecomp_id_fk` FOREIGN KEY (`corecomp_id`) REFERENCES `analysis_usp_corecomp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usp_master_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_usp_corecompcompetitors`
--

LOCK TABLES `analysis_usp_corecompcompetitors` WRITE;
/*!40000 ALTER TABLE `analysis_usp_corecompcompetitors` DISABLE KEYS */;
INSERT INTO `analysis_usp_corecompcompetitors` VALUES (12,159,10,9,7),(15,159,11,7,7);
/*!40000 ALTER TABLE `analysis_usp_corecompcompetitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_value_buycriteria`
--

DROP TABLE IF EXISTS `analysis_value_buycriteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_value_buycriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `us` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `master_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `buycriteria_process_id_fk_idx` (`master_id`),
  CONSTRAINT `buycriteria_process_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_value_buycriteria`
--

LOCK TABLES `analysis_value_buycriteria` WRITE;
/*!40000 ALTER TABLE `analysis_value_buycriteria` DISABLE KEYS */;
INSERT INTO `analysis_value_buycriteria` VALUES (18,'Kaufkriterium1',9,10,156),(19,'Kaufkriterium2',9,7,156),(20,'Kaufkriterium3',8,7,156),(21,'Kaufkrit34',6,7,156),(22,'Kaufkriterium1',10,10,162);
/*!40000 ALTER TABLE `analysis_value_buycriteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_value_comp_buyc`
--

DROP TABLE IF EXISTS `analysis_value_comp_buyc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_value_comp_buyc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valuey` double DEFAULT NULL,
  `competitor_id` int(11) NOT NULL,
  `buyC_id` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `buyc_comp_id_fk` (`competitor_id`),
  KEY `buyc_buyc_id_fk` (`buyC_id`),
  KEY `buyc_master_id_fk_idx` (`master_id`),
  CONSTRAINT `buyc_buyc_id_fk` FOREIGN KEY (`buyC_id`) REFERENCES `analysis_value_buycriteria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `buyc_comp_id_fk` FOREIGN KEY (`competitor_id`) REFERENCES `analysis_value_competitors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `buyc_master_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_value_comp_buyc`
--

LOCK TABLES `analysis_value_comp_buyc` WRITE;
/*!40000 ALTER TABLE `analysis_value_comp_buyc` DISABLE KEYS */;
INSERT INTO `analysis_value_comp_buyc` VALUES (24,9,10,18,156),(25,8,11,18,156),(29,8,10,19,156),(30,7,11,19,156),(34,7,10,20,156),(35,9,11,20,156),(39,9,10,21,156),(40,8,11,21,156),(44,4,15,22,162),(45,3,16,22,162);
/*!40000 ALTER TABLE `analysis_value_comp_buyc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_value_competitors`
--

DROP TABLE IF EXISTS `analysis_value_competitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analysis_value_competitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competitor_id` int(11) NOT NULL,
  `relative_price` double DEFAULT NULL,
  `master_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `competitors_process_id_fk_idx` (`master_id`),
  KEY `valueprop_competitor_id_fk_idx` (`competitor_id`),
  CONSTRAINT `competitors_process_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `valueprop_competitor_id_fk` FOREIGN KEY (`competitor_id`) REFERENCES `analysis_competitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_value_competitors`
--

LOCK TABLES `analysis_value_competitors` WRITE;
/*!40000 ALTER TABLE `analysis_value_competitors` DISABLE KEYS */;
INSERT INTO `analysis_value_competitors` VALUES (10,6,100,156),(11,7,98,156),(15,7,2,162),(16,6,2,162),(18,7,0,156);
/*!40000 ALTER TABLE `analysis_value_competitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_unit`
--

DROP TABLE IF EXISTS `business_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_business_unit_id_fk` (`user_id`),
  CONSTRAINT `user_business_unit_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_unit`
--

LOCK TABLES `business_unit` WRITE;
/*!40000 ALTER TABLE `business_unit` DISABLE KEYS */;
INSERT INTO `business_unit` VALUES (1,1);
/*!40000 ALTER TABLE `business_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conclusionsandmeasures`
--

DROP TABLE IF EXISTS `conclusionsandmeasures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conclusionsandmeasures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `report` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `conclusions_master_id_fk_idx` (`master_id`),
  CONSTRAINT `conclusions_master_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conclusionsandmeasures`
--

LOCK TABLES `conclusionsandmeasures` WRITE;
/*!40000 ALTER TABLE `conclusionsandmeasures` DISABLE KEYS */;
INSERT INTO `conclusionsandmeasures` VALUES (23,172,1,'Schlussfolg','\0'),(24,174,1,'blaaa','\0');
/*!40000 ALTER TABLE `conclusionsandmeasures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'admin'),(2,'basic'),(3,'professional'),(4,'expert');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `play_evolutions`
--

DROP TABLE IF EXISTS `play_evolutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `play_evolutions` (
  `id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `applied_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `apply_script` text,
  `revert_script` text,
  `state` varchar(255) DEFAULT NULL,
  `last_problem` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `play_evolutions`
--

LOCK TABLES `play_evolutions` WRITE;
/*!40000 ALTER TABLE `play_evolutions` DISABLE KEYS */;
/*!40000 ALTER TABLE `play_evolutions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roadmap`
--

DROP TABLE IF EXISTS `roadmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roadmap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `main_id` int(11) NOT NULL,
  `domain` varchar(128) DEFAULT NULL,
  `st` varchar(128) DEFAULT NULL,
  `impact_direction` varchar(128) DEFAULT NULL,
  `unit` varchar(128) DEFAULT NULL,
  `n` varchar(128) DEFAULT NULL,
  `actions` varchar(128) DEFAULT NULL,
  `goal` varchar(128) DEFAULT NULL,
  `ownership` varchar(128) DEFAULT NULL,
  `with_whom` varchar(128) DEFAULT NULL,
  `report_until` varchar(128) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `traffic_light` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roadmap_id_main_fk` (`main_id`),
  CONSTRAINT `roadmap_id_main_fk` FOREIGN KEY (`main_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roadmap`
--

LOCK TABLES `roadmap` WRITE;
/*!40000 ALTER TABLE `roadmap` DISABLE KEYS */;
INSERT INTO `roadmap` VALUES (1,156,'ei','fd','gfgfd','organ','3','massnahme 1','fds','fds','Jean-Pierre','ff','2014-11-11 00:00:00','2014-11-10 00:00:00',3,2),(2,156,'Es','gf','joha','jka','1','massnahme 2',NULL,NULL,NULL,'d','2014-11-26 00:00:00','2014-11-12 00:00:00',4,2),(3,156,'bcfd','hgfd',NULL,'jhgf','54','massnahme 3',NULL,NULL,NULL,NULL,'2014-11-12 00:00:00','2014-11-12 00:00:00',1,1),(4,156,'fd','fd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-11-12 00:00:00','2014-11-12 00:00:00',1,1);
/*!40000 ALTER TABLE `roadmap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `segment`
--

DROP TABLE IF EXISTS `segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `quality_price` int(11) NOT NULL DEFAULT '50',
  `description` varchar(256) DEFAULT NULL,
  `unit` varchar(45) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `growth_rate` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `version_segment_fk_id_idx` (`version_id`),
  CONSTRAINT `version_segment_fk` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segment`
--

LOCK TABLES `segment` WRITE;
/*!40000 ALTER TABLE `segment` DISABLE KEYS */;
INSERT INTO `segment` VALUES (8,1,'Schweiz','2014-11-13',88,'und hier ist die Beschriebung','Ma',99,12,-1.5),(9,1,'Deutschland','2014-11-06',50,NULL,NULL,NULL,NULL,NULL),(10,1,'Segment','2014-11-06',15,'(Description)','(Unit)',0,0,0),(11,1,'Italien','2014-11-06',73,'(Description)','(Unit)',0,0,0),(12,1,'Beschaffung','2014-11-14',50,NULL,NULL,NULL,NULL,NULL),(13,1,'Produktion','2014-11-14',50,NULL,NULL,NULL,NULL,NULL),(14,1,'R&D','2014-11-14',50,NULL,NULL,NULL,NULL,NULL),(15,1,'Vertrieb','2014-11-14',50,NULL,NULL,NULL,NULL,NULL),(16,1,'Systeme','2014-11-14',50,NULL,NULL,NULL,NULL,NULL),(17,1,'Organisation','2014-11-14',50,NULL,NULL,NULL,NULL,NULL),(18,1,'Führung','2014-11-14',50,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `swot_clusters`
--

DROP TABLE IF EXISTS `swot_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `swot_clusters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `quadrant` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `swot_cluster_tool_fk_id_idx` (`master_id`),
  CONSTRAINT `swot_cluster_tool_fk_id` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `swot_clusters`
--

LOCK TABLES `swot_clusters` WRITE;
/*!40000 ALTER TABLE `swot_clusters` DISABLE KEYS */;
INSERT INTO `swot_clusters` VALUES (2,'Gruppe1','asdwe',2,168),(3,'Gruppe2','asdfasfd',1,168);
/*!40000 ALTER TABLE `swot_clusters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `swot_inputs`
--

DROP TABLE IF EXISTS `swot_inputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `swot_inputs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` text,
  `position_x` double DEFAULT NULL,
  `position_y` double DEFAULT NULL,
  `cluster_id` int(11) DEFAULT NULL,
  `selected` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `swotinputs_type_id_fk` (`type_id`),
  KEY `swotinputs_cluster_id_fk` (`cluster_id`),
  KEY `swotinputs_object_id_fk_idx` (`master_id`),
  CONSTRAINT `swotinputs_cluster_id_fk` FOREIGN KEY (`cluster_id`) REFERENCES `swot_clusters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `swotinputs_object_id_fk` FOREIGN KEY (`master_id`) REFERENCES `tool_master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `swot_inputs`
--

LOCK TABLES `swot_inputs` WRITE;
/*!40000 ALTER TABLE `swot_inputs` DISABLE KEYS */;
INSERT INTO `swot_inputs` VALUES (1,2,172,'hgfd',NULL,0.3848940189068134,0.1235467764047476,NULL,'');
/*!40000 ALTER TABLE `swot_inputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tool_master`
--

DROP TABLE IF EXISTS `tool_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) NOT NULL,
  `instrument_id` int(11) NOT NULL,
  `segment_id` int(11) DEFAULT NULL,
  `competitor_id` int(11) DEFAULT NULL,
  `view_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `type_instrument_id_fk` (`instrument_id`),
  KEY `process_instrument_id_fk` (`version_id`),
  KEY `segment_instrument_id_fk_idx` (`segment_id`),
  KEY `competitor_too_id_fk_idx` (`competitor_id`),
  CONSTRAINT `competitor_tool_id_fk` FOREIGN KEY (`competitor_id`) REFERENCES `furger_strategy_vtwo`.`analysis_competitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `segment_tool_id_fk` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tool_version_id_fk` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tool_master`
--

LOCK TABLES `tool_master` WRITE;
/*!40000 ALTER TABLE `tool_master` DISABLE KEYS */;
INSERT INTO `tool_master` VALUES (156,1,1,8,NULL,1),(157,1,1,8,NULL,2),(158,1,1,8,NULL,3),(159,1,2,8,NULL,1),(160,1,2,8,NULL,2),(161,1,2,8,NULL,3),(162,1,1,9,NULL,1),(163,1,1,9,NULL,2),(164,1,1,9,NULL,3),(165,1,2,9,NULL,1),(166,1,2,9,NULL,2),(167,1,2,9,NULL,3),(168,1,3,NULL,NULL,1),(169,1,3,NULL,NULL,2),(170,1,3,NULL,NULL,3),(171,1,3,NULL,NULL,4),(172,1,7,8,NULL,1),(173,1,8,8,NULL,1),(174,1,7,9,NULL,1),(175,1,7,10,NULL,1),(176,1,1,10,NULL,1),(177,1,1,10,NULL,2),(178,1,1,10,NULL,3),(179,1,2,10,NULL,1),(180,1,2,10,NULL,2),(181,1,2,10,NULL,3),(182,1,7,11,NULL,1),(183,1,1,11,NULL,1),(184,1,1,11,NULL,2),(185,1,1,11,NULL,3),(186,1,6,NULL,NULL,1),(187,1,9,12,NULL,1),(188,1,9,13,NULL,1),(189,1,9,14,NULL,1),(190,1,9,15,NULL,1),(191,1,9,16,NULL,1),(192,1,9,17,NULL,1),(193,1,9,18,NULL,1);
/*!40000 ALTER TABLE `tool_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(1024) NOT NULL,
  `company` varchar(128) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Ignaz','Furger','test@furger.ch','$2a$10$oZkCoTAEwUCgeNQ5rvcuYeRyfTqsiqPqVj407poaeryOQUeOO43zO','Furger',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission`
--

DROP TABLE IF EXISTS `user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_user_permission_fk` (`user_id`),
  KEY `permission_user_permission_fk` (`permission_id`),
  CONSTRAINT `permission_user_permission_fk` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_user_permission_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `business_unit_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `business_process_id_fk` (`business_unit_id`),
  CONSTRAINT `business_process_id_fk` FOREIGN KEY (`business_unit_id`) REFERENCES `business_unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,1,'1');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-15  2:35:18
