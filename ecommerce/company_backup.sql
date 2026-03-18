-- MySQL dump 10.13  Distrib 9.6.0, for Win64 (x86_64)
--
-- Host: localhost    Database: company
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'a21f58ba-0391-11f1-a46d-706979a14731:1-203';

--
-- Table structure for table `departament`
--

DROP TABLE IF EXISTS `departament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departament` (
  `Dname` varchar(15) NOT NULL,
  `Dnumber` int NOT NULL,
  `Mgr_ssn` char(9) DEFAULT NULL,
  `Mgr_start_date` date DEFAULT NULL,
  `Dept_create_date` date DEFAULT NULL,
  PRIMARY KEY (`Dnumber`),
  UNIQUE KEY `unique_name_dept` (`Dname`),
  KEY `fk_dept_manager` (`Mgr_ssn`),
  CONSTRAINT `fk_dept_manager` FOREIGN KEY (`Mgr_ssn`) REFERENCES `employee` (`Ssn`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_date_dept` CHECK (((`Dept_create_date` is null) or (`Mgr_start_date` is null) or (`Dept_create_date` < `Mgr_start_date`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departament`
--

LOCK TABLES `departament` WRITE;
/*!40000 ALTER TABLE `departament` DISABLE KEYS */;
/*!40000 ALTER TABLE `departament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependent` (
  `Essn` char(9) NOT NULL,
  `Dependent_name` varchar(15) NOT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Bdate` date DEFAULT NULL,
  `Relationship` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`Essn`,`Dependent_name`),
  CONSTRAINT `fk_dependent_employee` FOREIGN KEY (`Essn`) REFERENCES `employee` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('123456789','Alice','F','1986-04-05','Daughter'),('123456789','M','M','1986-04-05','Son'),('124456789','Q','F','1986-04-05','Spouse'),('125456789','E','F','1986-04-05','Spouse'),('126656789','Y','F','1986-04-05','Daughter');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_locations`
--

DROP TABLE IF EXISTS `dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dept_locations` (
  `Dnumber` int NOT NULL,
  `Dlocation` varchar(15) NOT NULL,
  PRIMARY KEY (`Dnumber`,`Dlocation`),
  CONSTRAINT `fk_dept_locations_dept` FOREIGN KEY (`Dnumber`) REFERENCES `departament` (`Dnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_locations`
--

LOCK TABLES `dept_locations` WRITE;
/*!40000 ALTER TABLE `dept_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Fname` varchar(15) NOT NULL,
  `Minit` char(1) DEFAULT NULL,
  `Lname` varchar(15) NOT NULL,
  `Ssn` char(9) NOT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Super_ssn` char(9) DEFAULT NULL,
  `Dno` int NOT NULL,
  PRIMARY KEY (`Ssn`),
  KEY `fk_employee_supervisor` (`Super_ssn`),
  CONSTRAINT `fk_employee_supervisor` FOREIGN KEY (`Super_ssn`) REFERENCES `employee` (`Ssn`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_salary_employee` CHECK ((`Salary` > 2000.00))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('John','B','Smith','123456789','1965-01-09','731-Fondern-Houston-TX','M',30000.00,NULL,5),('Marcia','B','Smith','124456789','1965-01-09','731-Fondern-Houston-TX','F',32200.00,'123456789',5),('Reginaldo','B','Smith','125456789','1965-01-09','731-Fondern-Houston-TX','M',21000.00,'123456789',5),('V','B','S','126656789','1965-01-09','731-Fondern-Houston-TX','M',22000.00,NULL,5);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_update_salary` BEFORE UPDATE ON `employee` FOR EACH ROW begin

if old.Salary <> new.Salary then

insert into salary_history(employee_id, old_salary, new_salary)
values (OLD.Ssn, OLD.Salary, NEW.Salary);
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `Pname` varchar(15) NOT NULL,
  `Pnumber` int NOT NULL,
  `Plocation` varchar(15) DEFAULT NULL,
  `Dnum` int NOT NULL,
  PRIMARY KEY (`Pnumber`),
  UNIQUE KEY `unique_project_name` (`Pname`),
  KEY `fk_project_dept` (`Dnum`),
  CONSTRAINT `fk_project_dept` FOREIGN KEY (`Dnum`) REFERENCES `departament` (`Dnumber`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_departamentos_gerentes`
--

DROP TABLE IF EXISTS `vw_departamentos_gerentes`;
/*!50001 DROP VIEW IF EXISTS `vw_departamentos_gerentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_departamentos_gerentes` AS SELECT 
 1 AS `departamento`,
 1 AS `gerente`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_empregados_departamento_local`
--

DROP TABLE IF EXISTS `vw_empregados_departamento_local`;
/*!50001 DROP VIEW IF EXISTS `vw_empregados_departamento_local`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_empregados_departamento_local` AS SELECT 
 1 AS `departamento`,
 1 AS `localidade`,
 1 AS `total_empregados`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_empregados_dependentes_gerentes`
--

DROP TABLE IF EXISTS `vw_empregados_dependentes_gerentes`;
/*!50001 DROP VIEW IF EXISTS `vw_empregados_dependentes_gerentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_empregados_dependentes_gerentes` AS SELECT 
 1 AS `empregado`,
 1 AS `total_dependentes`,
 1 AS `gerente`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_projetos_departamentos_gerentes`
--

DROP TABLE IF EXISTS `vw_projetos_departamentos_gerentes`;
/*!50001 DROP VIEW IF EXISTS `vw_projetos_departamentos_gerentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_projetos_departamentos_gerentes` AS SELECT 
 1 AS `projeto`,
 1 AS `departamento`,
 1 AS `gerente`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_projetos_maior_numero_empregados`
--

DROP TABLE IF EXISTS `vw_projetos_maior_numero_empregados`;
/*!50001 DROP VIEW IF EXISTS `vw_projetos_maior_numero_empregados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_projetos_maior_numero_empregados` AS SELECT 
 1 AS `projeto`,
 1 AS `total_empregados`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `wind_report`
--

DROP TABLE IF EXISTS `wind_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wind_report` (
  `report_code` varchar(10) NOT NULL,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `day` int DEFAULT NULL,
  `wind_speed` decimal(5,1) DEFAULT NULL,
  `wind_severity` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`report_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wind_report`
--

LOCK TABLES `wind_report` WRITE;
/*!40000 ALTER TABLE `wind_report` DISABLE KEYS */;
INSERT INTO `wind_report` VALUES ('145150',2007,10,14,2.5,'LOW'),('1C8A2A',1998,11,21,50.0,'HIGH'),('34DDA7',2002,12,21,0.2,'LOW'),('39537B',1998,10,1,6.7,'LOW'),('6757E5',1992,10,9,43.9,'HIGH'),('B6A78C',1973,7,17,42.3,'HIGH'),('C3C6D5',2001,5,18,4.3,'LOW'),('E681EA',1984,2,10,44.9,'HIGH'),('EF616A',1967,7,29,1.2,'LOW'),('F7D723',2003,5,23,45.3,'HIGH');
/*!40000 ALTER TABLE `wind_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `works_on` (
  `Essn` char(9) NOT NULL,
  `Pno` int NOT NULL,
  `Hours` decimal(3,1) NOT NULL,
  PRIMARY KEY (`Essn`,`Pno`),
  KEY `fk_works_on_project` (`Pno`),
  CONSTRAINT `fk_works_on_employee` FOREIGN KEY (`Essn`) REFERENCES `employee` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_works_on_project` FOREIGN KEY (`Pno`) REFERENCES `project` (`Pnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `vw_departamentos_gerentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_departamentos_gerentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_departamentos_gerentes` AS select `d`.`Dname` AS `departamento`,concat(`e`.`Fname`,' ',`e`.`Lname`) AS `gerente` from (`departament` `d` left join `employee` `e` on((`d`.`Mgr_ssn` = `e`.`Ssn`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_empregados_departamento_local`
--

/*!50001 DROP VIEW IF EXISTS `vw_empregados_departamento_local`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_empregados_departamento_local` AS select `d`.`Dname` AS `departamento`,`dl`.`Dlocation` AS `localidade`,count(`e`.`Ssn`) AS `total_empregados` from ((`departament` `d` join `dept_locations` `dl` on((`d`.`Dnumber` = `dl`.`Dnumber`))) left join `employee` `e` on((`d`.`Dnumber` = `e`.`Dno`))) group by `d`.`Dname`,`dl`.`Dlocation` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_empregados_dependentes_gerentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_empregados_dependentes_gerentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_empregados_dependentes_gerentes` AS select concat(`e`.`Fname`,' ',`e`.`Lname`) AS `empregado`,count(`dep`.`Dependent_name`) AS `total_dependentes`,(case when `e`.`Ssn` in (select `departament`.`Mgr_ssn` from `departament`) then 'Sim' else 'Não' end) AS `gerente` from (`employee` `e` left join `dependent` `dep` on((`e`.`Ssn` = `dep`.`Essn`))) group by `e`.`Ssn` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_projetos_departamentos_gerentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_projetos_departamentos_gerentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_projetos_departamentos_gerentes` AS select `p`.`Pname` AS `projeto`,`d`.`Dname` AS `departamento`,concat(`e`.`Fname`,' ',`e`.`Lname`) AS `gerente` from ((`project` `p` join `departament` `d` on((`p`.`Dnum` = `d`.`Dnumber`))) left join `employee` `e` on((`d`.`Mgr_ssn` = `e`.`Ssn`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_projetos_maior_numero_empregados`
--

/*!50001 DROP VIEW IF EXISTS `vw_projetos_maior_numero_empregados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_projetos_maior_numero_empregados` AS select `p`.`Pname` AS `projeto`,count(`w`.`Essn`) AS `total_empregados` from (`project` `p` join `works_on` `w` on((`p`.`Pnumber` = `w`.`Pno`))) group by `p`.`Pname` order by `total_empregados` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-18 17:01:12
