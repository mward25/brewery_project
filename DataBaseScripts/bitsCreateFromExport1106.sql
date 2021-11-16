-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: bits
-- ------------------------------------------------------
-- Server version	8.0.21
DROP DATABASE IF EXISTS `bits`;
CREATE DATABASE `bits`;
USE `bits`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `sales_person_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `street_line_1` varchar(100) NOT NULL,
  `street_line_2` varchar(100) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zipcode` varchar(50) DEFAULT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `address_type`
--

DROP TABLE IF EXISTS `address_type`;
CREATE TABLE `address_type` (
  `address_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`address_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `adjunct`
--

DROP TABLE IF EXISTS `adjunct`;
CREATE TABLE `adjunct` (
  `ingredient_id` int NOT NULL,
  `adjunct_type_id` int NOT NULL,
  `use_for` varchar(200) DEFAULT NULL,
  `recommended_quantity` double DEFAULT '0',
  `batch_volume` double DEFAULT '0',
  `recommended_use_during_id` int DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `adjunct_adjunct_type_FK_idx` (`adjunct_type_id`),
  KEY `adjunct_use_during_FK_idx` (`recommended_use_during_id`),
  CONSTRAINT `adjunct_adjunct_type_FK` FOREIGN KEY (`adjunct_type_id`) REFERENCES `adjunct_type` (`adjunct_type_id`),
  CONSTRAINT `adjunct_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `adjunct_use_during_FK` FOREIGN KEY (`recommended_use_during_id`) REFERENCES `use_during` (`use_during_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `adjunct_type`
--

DROP TABLE IF EXISTS `adjunct_type`;
CREATE TABLE `adjunct_type` (
  `adjunct_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`adjunct_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `app_config`
--

DROP TABLE IF EXISTS `app_config`;
CREATE TABLE `app_config` (
  `brewery_id` int NOT NULL,
  `default_units` varchar(50) NOT NULL DEFAULT 'metric',
  `brewery_name` varchar(200) NOT NULL,
  `home_page_text` varchar(5000) DEFAULT NULL,
  `brewery_logo` varchar(50) DEFAULT NULL,
  `home_page_background_image` varchar(50) DEFAULT NULL,
  `color_1` varchar(10) DEFAULT NULL,
  `color_2` varchar(10) DEFAULT NULL,
  `color_3` varchar(10) DEFAULT NULL,
  `color_white` varchar(10) DEFAULT NULL,
  `color_black` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`brewery_id`)
) ENGINE=InnoDB;


--
-- Table structure for table `app_user`
--

DROP TABLE IF EXISTS `app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user` (
  `app_user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`app_user_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `barrel`
--

DROP TABLE IF EXISTS `barrel`;
CREATE TABLE `barrel` (
  `brew_container_id` int NOT NULL,
  `treatment` varchar(50) NOT NULL,
  PRIMARY KEY (`brew_container_id`),
  CONSTRAINT `barrel_brew_container_FK` FOREIGN KEY (`brew_container_id`) REFERENCES `brew_container` (`brew_container_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch` (
  `batch_id` int NOT NULL AUTO_INCREMENT,
  `recipe_id` int NOT NULL,
  `equipment_id` int NOT NULL,
  `volume` double NOT NULL,
  `scheduled_start_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `estimated_finish_date` datetime DEFAULT NULL,
  `finish_date` datetime DEFAULT NULL,
  `unit_cost` decimal(10,2) DEFAULT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `taste_notes` varchar(2000) DEFAULT NULL,
  `taste_rating` double DEFAULT NULL,
  `og` double DEFAULT NULL,
  `fg` double DEFAULT NULL,
  `carbonation` double DEFAULT NULL,
  `fermentation_stages` int DEFAULT NULL,
  `primary_age` double DEFAULT NULL,
  `primary_temp` double DEFAULT NULL,
  `secondary_age` double DEFAULT NULL,
  `secondary_temp` double DEFAULT NULL,
  `tertiary_age` double DEFAULT NULL,
  `age` double DEFAULT NULL,
  `temp` double DEFAULT NULL,
  `ibu` double DEFAULT NULL,
  `ibu_method` varchar(50) DEFAULT NULL,
  `abv` double DEFAULT NULL,
  `actual_efficiency` double DEFAULT NULL,
  `calories` double DEFAULT NULL,
  `carbonation_used` varchar(100) DEFAULT NULL,
  `forced_carbonation` tinyint DEFAULT NULL,
  `keg_priming_factor` double DEFAULT NULL,
  `carbonation_temp` double DEFAULT NULL,
  PRIMARY KEY (`batch_id`),
  KEY `batch_recipe_FK_idx` (`equipment_id`),
  KEY `batch_recipe_FK` (`recipe_id`),
  CONSTRAINT `batch_equipment_FK` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`),
  CONSTRAINT `batch_recipe_FK` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `batch_container`
--

DROP TABLE IF EXISTS `batch_container`;
CREATE TABLE `batch_container` (
  `batch_id` int NOT NULL,
  `brew_container_id` int NOT NULL,
  `date_in` datetime NOT NULL,
  `date_out` datetime DEFAULT NULL,
  `volume` double DEFAULT NULL,
  PRIMARY KEY (`batch_id`,`brew_container_id`),
  KEY `batch_container_brew_container_FK_idx` (`brew_container_id`),
  CONSTRAINT `batch_container_batch_FK` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`batch_id`),
  CONSTRAINT `batch_container_brew_container_FK` FOREIGN KEY (`brew_container_id`) REFERENCES `brew_container` (`brew_container_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `brew_container`
--

DROP TABLE IF EXISTS `brew_container`;
CREATE TABLE `brew_container` (
  `brew_container_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `container_status_id` int NOT NULL,
  `container_type_id` int NOT NULL,
  `container_size_id` int NOT NULL,
  PRIMARY KEY (`brew_container_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `brew_container_container_status_FK_idx` (`container_status_id`),
  KEY `brew_container_container_type_FK_idx` (`container_type_id`),
  KEY `brew_container_container_size_idx` (`container_size_id`),
  CONSTRAINT `brew_container_container_size` FOREIGN KEY (`container_size_id`) REFERENCES `container_size` (`container_size_id`),
  CONSTRAINT `brew_container_container_status_FK` FOREIGN KEY (`container_status_id`) REFERENCES `container_status` (`container_status_id`),
  CONSTRAINT `brew_container_container_type_FK` FOREIGN KEY (`container_type_id`) REFERENCES `container_type` (`container_type_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `container_size`
--

DROP TABLE IF EXISTS `container_size`;
CREATE TABLE `container_size` (
  `container_size_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `max_volume` double DEFAULT NULL,
  `working_volume` double DEFAULT NULL,
  PRIMARY KEY (`container_size_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB;

--
-- Table structure for table `container_status`
--

DROP TABLE IF EXISTS `container_status`;
CREATE TABLE `container_status` (
  `container_status_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`container_status_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB;

--
-- Table structure for table `container_type`
--

DROP TABLE IF EXISTS `container_type`;
CREATE TABLE `container_type` (
  `container_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`container_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `equipment_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` int DEFAULT NULL,
  `boil_size` double DEFAULT NULL,
  `batch_size` double DEFAULT NULL,
  `tun_volume` double DEFAULT NULL,
  `tun_weight` double DEFAULT NULL,
  `tun_specific_heat` double DEFAULT NULL,
  `top_up_water` double DEFAULT NULL,
  `trub_chiller_loss` double DEFAULT NULL,
  `evap_rate` double DEFAULT NULL,
  `boil_time` double DEFAULT NULL,
  `calc_boil_volume` tinyint DEFAULT NULL,
  `lauter_deadspace` double DEFAULT NULL,
  `top_up_kettle` double DEFAULT NULL,
  `hop_utilization` double DEFAULT NULL,
  `cooling_loss_pct` double DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`equipment_id`),
  UNIQUE KEY `equipment_name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `fermentable`
--

DROP TABLE IF EXISTS `fermentable`;
CREATE TABLE `fermentable` (
  `ingredient_id` int NOT NULL,
  `fermentable_type_id` int DEFAULT NULL,
  `color` double DEFAULT NULL,
  `yield` double DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `coarse_fine_diff` double DEFAULT NULL,
  `moisture` double DEFAULT NULL,
  `diastatic_power` double DEFAULT NULL,
  `protein` double DEFAULT NULL,
  `max_in_batch` double DEFAULT NULL,
  `recommend_mash` tinyint DEFAULT NULL,
  `add_after_boil` tinyint DEFAULT NULL,
  `ibu_gal_per_lb` double DEFAULT NULL,
  `potential` double DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `fermentable_fermentable_type_FK_idx` (`fermentable_type_id`),
  CONSTRAINT `fermentable_fermentable_type_FK` FOREIGN KEY (`fermentable_type_id`) REFERENCES `fermentable_type` (`fermentable_type_id`),
  CONSTRAINT `fermentable_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `fermentable_type`
--

DROP TABLE IF EXISTS `fermentable_type`;
CREATE TABLE `fermentable_type` (
  `fermentable_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`fermentable_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `hop`
--

DROP TABLE IF EXISTS `hop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hop` (
  `ingredient_id` int NOT NULL,
  `hop_type_id` int DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `alpha` double DEFAULT NULL,
  `beta` double DEFAULT NULL,
  `hsi` double DEFAULT NULL,
  `form` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `hop_hop_type_idx` (`hop_type_id`),
  CONSTRAINT `hop_hop_type` FOREIGN KEY (`hop_type_id`) REFERENCES `hop_type` (`hop_type_id`),
  CONSTRAINT `hop_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `hop_type`
--

DROP TABLE IF EXISTS `hop_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hop_type` (
  `hop_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hop_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE `ingredient` (
  `ingredient_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` int DEFAULT NULL,
  `ingredient_type_id` int NOT NULL,
  `on_hand_quantity` double NOT NULL DEFAULT '0',
  `unit_type_id` int NOT NULL DEFAULT '0',
  `unit_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `reorder_point` double NOT NULL DEFAULT '0',
  `notes` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `ingredient_ingredient_type_FK_idx` (`ingredient_type_id`),
  KEY `ingredient_unit_type_FK_idx` (`unit_type_id`),
  CONSTRAINT `ingredient_ingredient_type_FK` FOREIGN KEY (`ingredient_type_id`) REFERENCES `ingredient_type` (`ingredient_type_id`),
  CONSTRAINT `ingredient_unit_type_FK` FOREIGN KEY (`unit_type_id`) REFERENCES `unit_type` (`unit_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `ingredient_inventory_addition`
--

DROP TABLE IF EXISTS `ingredient_inventory_addition`;
CREATE TABLE `ingredient_inventory_addition` (
  `ingredient_inventory_addition_id` int NOT NULL AUTO_INCREMENT,
  `ingredient_id` int NOT NULL,
  `order_date` datetime DEFAULT NULL,
  `estimated_delivery_date` datetime DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `supplier_id` int NOT NULL,
  `quantity` double NOT NULL,
  `quantity_remaining` double DEFAULT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ingredient_inventory_addition_id`),
  KEY `ingredient_inventory_addition_ingredient_FK_idx` (`ingredient_id`),
  KEY `ingredient_invertory_addition_supplier_FK_idx` (`supplier_id`),
  CONSTRAINT `ingredient_inventory_addition_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `ingredient_invertory_addition_supplier_FK` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingredient_inventory_addition_AFTER_INSERT` AFTER INSERT ON `ingredient_inventory_addition` FOR EACH ROW BEGIN
    if new.transaction_date is not null then
		update ingredient set  on_hand_quantity = on_hand_quantity + new.quantity 
			where ingredient_id = new.ingredient_id;
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingredient_inventory_addition_AFTER_UPDATE` AFTER UPDATE ON `ingredient_inventory_addition` FOR EACH ROW BEGIN
	-- if old transaction_date was null this is a new addition to inventory
    -- otherwise it's an update
    if (old.transaction_date is null and new.transaction_date is not null) then
		update ingredient set  on_hand_quantity = on_hand_quantity + new.quantity 
			where ingredient_id = new.ingredient_id;
	elseif (old.transaction_date is not null and new.quantity <> old.quantity) then
		update ingredient set  on_hand_quantity = on_hand_quantity + (new.quantity - old.quantity)
			where ingredient_id = new.ingredient_id;
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingredient_inventory_addition_AFTER_DELETE` AFTER DELETE ON `ingredient_inventory_addition` FOR EACH ROW BEGIN
	if old.transaction_date is not null then
		update ingredient set  on_hand_quantity = on_hand_quantity - old.quantity    
			where ingredient_id = old.ingredient_id;
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ingredient_inventory_subtraction`
--

DROP TABLE IF EXISTS `ingredient_inventory_subtraction`;
CREATE TABLE `ingredient_inventory_subtraction` (
  `ingredient_inventory_subtraction_id` int NOT NULL AUTO_INCREMENT,
  `ingredient_id` int NOT NULL,
  `transaction_date` datetime NOT NULL,
  `reason` varchar(200) NOT NULL,
  `batch_id` int DEFAULT NULL,
  `quantity` double NOT NULL,
  PRIMARY KEY (`ingredient_inventory_subtraction_id`),
  KEY `ingredient_inventory_subtraction_ingredient_FK` (`ingredient_id`),
  KEY `ingredient_purchased_batch_FK` (`batch_id`),
  CONSTRAINT `ingredient_inventory_subtraction_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `ingredient_purchased_batch_FK` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingredient_inventory_subtraction_AFTER_INSERT` AFTER INSERT ON `ingredient_inventory_subtraction` FOR EACH ROW BEGIN
	update ingredient set  on_hand_quantity = on_hand_quantity - new.quantity 
    where ingredient_id = new.ingredient_id;
    set @quantity_remaining = new.quantity;
    while @quantity_remaining > 0
    do
		select quantity_remaining, transaction_date into @quantity_in_addition_record, @transaction_date   
			from ingredient_inventory_addition 
			where transaction_date = (select min(transaction_date) from ingredient_inventory_addition
				where ingredient_id = new.ingredient_id and quantity_remaining > 0) 
			and ingredient_id = new.ingredient_id;
        if (@quantity_in_addition_record >= @quantity_remaining) then
			update ingredient_inventory_addition set quantity_remaining = quantity_remaining - @quantity_remaining
				where transaction_date = @transaction_date 
				and ingredient_id = new.ingredient_id;
			set @quantity_remaining = 0;
		else
			update ingredient_inventory_addition set quantity_remaining = 0
				where transaction_date = @transaction_date 
				and ingredient_id = new.ingredient_id;
			set @quantity_remaining = @quantity_remaining - @quantity_in_addition_record;
		end if;
	end while;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingredient_inventory_subtraction_AFTER_UPDATE` AFTER UPDATE ON `ingredient_inventory_subtraction` FOR EACH ROW BEGIN
	if (new.quantity <> old.quantity) then
		update ingredient set  on_hand_quantity = on_hand_quantity - (new.quantity - old.quantity) 
			where ingredient_id = old.ingredient_id;
		set @quantity_remaining = new.quantity - old.quantity;
        if (@quantity_remaining < 0) then
			set @quantity_remaining = -1 * @quantity_remaining;
			while @quantity_remaining > 0
			do
				select (quantity - quantity_remaining), transaction_date into @quantity_in_addition_record, @transaction_date   
					from ingredient_inventory_addition 
					where transaction_date = (select max(transaction_date) from ingredient_inventory_addition
						where ingredient_id = old.ingredient_id and quantity - quantity_remaining > 0) 
					and ingredient_id = old.ingredient_id;
				if (@quantity_in_addition_record >= @quantity_remaining) then
					update ingredient_inventory_addition set quantity_remaining = quantity_remaining + @quantity_remaining
						where transaction_date = @transaction_date 
						and ingredient_id = old.ingredient_id;
					set @quantity_remaining = 0;
				else
					update ingredient_inventory_addition set quantity_remaining = quantity
						where transaction_date = @transaction_date 
						and ingredient_id = old.ingredient_id;
					set @quantity_remaining = @quantity_remaining - @quantity_in_addition_record;
				end if;
			end while;
        else
			while @quantity_remaining > 0
			do
				select quantity_remaining, transaction_date into @quantity_in_addition_record, @transaction_date   
					from ingredient_inventory_addition 
					where transaction_date = (select min(transaction_date) from ingredient_inventory_addition
						where ingredient_id = new.ingredient_id and quantity_remaining > 0) 
					and ingredient_id = new.ingredient_id;
				if (@quantity_in_addition_record >= @quantity_remaining) then
					update ingredient_inventory_addition set quantity_remaining = quantity_remaining - @quantity_remaining
						where transaction_date = @transaction_date 
						and ingredient_id = new.ingredient_id;
					set @quantity_remaining = 0;
				else
					update ingredient_inventory_addition set quantity_remaining = 0
						where transaction_date = @transaction_date 
						and ingredient_id = new.ingredient_id;
					set @quantity_remaining = @quantity_remaining - @quantity_in_addition_record;
				end if;
			end while;
        end if;
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingredient_inventory_subtraction_AFTER_DELETE` AFTER DELETE ON `ingredient_inventory_subtraction` FOR EACH ROW BEGIN
	update ingredient set  on_hand_quantity = on_hand_quantity + old.quantity 
    where ingredient_id = old.ingredient_id;
    set @quantity_remaining = old.quantity;
    while @quantity_remaining > 0
    do
		select (quantity - quantity_remaining), transaction_date into @quantity_in_addition_record, @transaction_date   
			from ingredient_inventory_addition 
			where transaction_date = (select max(transaction_date) from ingredient_inventory_addition
				where ingredient_id = old.ingredient_id and quantity - quantity_remaining > 0) 
			and ingredient_id = old.ingredient_id;
        if (@quantity_in_addition_record >= @quantity_remaining) then
			update ingredient_inventory_addition set quantity_remaining = quantity_remaining + @quantity_remaining
				where transaction_date = @transaction_date 
				and ingredient_id = old.ingredient_id;
			set @quantity_remaining = 0;
		else
			update ingredient_inventory_addition set quantity_remaining = quantity
				where transaction_date = @transaction_date 
				and ingredient_id = old.ingredient_id;
			set @quantity_remaining = @quantity_remaining - @quantity_in_addition_record;
		end if;
	end while;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ingredient_substitute`
--

DROP TABLE IF EXISTS `ingredient_substitute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_substitute` (
  `ingredient_id` int NOT NULL,
  `substitute_ingredient_id` int NOT NULL,
  PRIMARY KEY (`ingredient_id`,`substitute_ingredient_id`),
  KEY `ingredient_substitute_substitute_ingredient_FK_idx` (`substitute_ingredient_id`),
  CONSTRAINT `ingredient_substitute_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `ingredient_substitute_substitute_ingredient_FK` FOREIGN KEY (`substitute_ingredient_id`) REFERENCES `ingredient` (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredient_type`
--

DROP TABLE IF EXISTS `ingredient_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_type` (
  `ingredient_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`ingredient_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `ingredient_used_in`
--

DROP TABLE IF EXISTS `ingredient_used_in`;
CREATE TABLE `ingredient_used_in` (
  `ingredient_id` int NOT NULL,
  `style_id` int NOT NULL,
  PRIMARY KEY (`ingredient_id`,`style_id`),
  KEY `usedin_style_type_FK_idx` (`style_id`),
  CONSTRAINT `used_in_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `used_in_style_type_FK` FOREIGN KEY (`style_id`) REFERENCES `style` (`style_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `inventory_transaction`
--

DROP TABLE IF EXISTS `inventory_transaction`;
CREATE TABLE `inventory_transaction` (
  `inventory_transaction_id` int NOT NULL AUTO_INCREMENT,
  `product_container_size_id` int NOT NULL,
  `batch_id` int NOT NULL,
  `inventory_transaction_date` datetime NOT NULL,
  `inventory_transction_type_id` int NOT NULL,
  `quantity` int NOT NULL,
  `account_id` int NOT NULL,
  `app_user_id` int NOT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`inventory_transaction_id`),
  KEY `inventory_transaction_transaction_type_FK_idx` (`inventory_transction_type_id`),
  KEY `inventory_transaction_batch_FK_idx` (`batch_id`),
  KEY `inventory_transaction_product_container_size_FK_idx` (`product_container_size_id`),
  KEY `inventory_transaction_account_idx` (`account_id`),
  KEY `inventory_transaction_app_user_FK_idx` (`app_user_id`),
  CONSTRAINT `inventory_transaction_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `inventory_transaction_app_user_FK` FOREIGN KEY (`app_user_id`) REFERENCES `app_user` (`app_user_id`),
  CONSTRAINT `inventory_transaction_batch_FK` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`batch_id`),
  CONSTRAINT `inventory_transaction_product_container_size_FK` FOREIGN KEY (`product_container_size_id`) REFERENCES `product_container_size` (`container_size_id`),
  CONSTRAINT `inventory_transaction_transaction_type_FK` FOREIGN KEY (`inventory_transction_type_id`) REFERENCES `inventory_transaction_type` (`inventory_transaction_type_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `inventory_transaction_type`
--

DROP TABLE IF EXISTS `inventory_transaction_type`;
CREATE TABLE `inventory_transaction_type` (
  `inventory_transaction_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`inventory_transaction_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB;

--
-- Table structure for table `mash`
--

DROP TABLE IF EXISTS `mash`;
CREATE TABLE `mash` (
  `mash_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` int DEFAULT NULL,
  `grain_temp` double DEFAULT NULL,
  `tun_temp` double DEFAULT NULL,
  `sparge_temp` double DEFAULT NULL,
  `ph` double DEFAULT NULL,
  `tun_weight` double DEFAULT NULL,
  `tun_specific_heat` double DEFAULT NULL,
  `equipment_adjust` tinyint DEFAULT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`mash_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `mash_step`
--

DROP TABLE IF EXISTS `mash_step`;
CREATE TABLE `mash_step` (
  `mash_step_id` int NOT NULL AUTO_INCREMENT,
  `mash_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `version` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `infuse_amount` double DEFAULT NULL,
  `step_time` double DEFAULT NULL,
  `step_temp` double DEFAULT NULL,
  `ramp_time` double DEFAULT NULL,
  `end_temp` double DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `water_grain_ratio` varchar(45) DEFAULT NULL,
  `decoction_amount` varchar(100) DEFAULT NULL,
  `infuse_temp` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`mash_step_id`),
  KEY `mast_step_mash_FK_idx` (`mash_id`),
  CONSTRAINT `mast_step_mash_FK` FOREIGN KEY (`mash_id`) REFERENCES `mash` (`mash_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `batch_id` int NOT NULL,
  `product_container_size_id` int NOT NULL,
  `racked_date` datetime NOT NULL,
  `sell_by_date` datetime NOT NULL,
  `quantity_racked` int NOT NULL,
  `quantity_remaining` int NOT NULL,
  `ingredient_cost` decimal(10,4) DEFAULT NULL,
  `suggested_price` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`batch_id`,`product_container_size_id`),
  KEY `keg_batch_FK_idx` (`batch_id`),
  KEY `product_product_container_size_FK` (`product_container_size_id`),
  CONSTRAINT `product_batch_FK` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`batch_id`),
  CONSTRAINT `product_product_container_size_FK` FOREIGN KEY (`product_container_size_id`) REFERENCES `product_container_size` (`container_size_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `product_container_inventory`
--

DROP TABLE IF EXISTS `product_container_inventory`;
CREATE TABLE `product_container_inventory` (
  `container_size_id` int NOT NULL,
  `quantity_dirty` int NOT NULL DEFAULT '0',
  `quantity_clean` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`container_size_id`),
  CONSTRAINT `product_container_inventory_product_container_FK` FOREIGN KEY (`container_size_id`) REFERENCES `product_container_size` (`container_size_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `product_container_size`
--

DROP TABLE IF EXISTS `product_container_size`;
CREATE TABLE `product_container_size` (
  `container_size_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `volume` double NOT NULL,
  `item_quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`container_size_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
CREATE TABLE `recipe` (
  `recipe_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `style_id` int NOT NULL,
  `volume` double NOT NULL,
  `brewer` varchar(100) NOT NULL,
  `boil_time` double DEFAULT '0',
  `boil_volume` double DEFAULT '0',
  `efficiency` double DEFAULT '0',
  `fermentation_stages` int DEFAULT '1',
  `estimated_og` double DEFAULT '0',
  `estimated_fg` double DEFAULT '0',
  `estimated_color` double DEFAULT '0',
  `estimated_abv` double DEFAULT '0',
  `actual_efficiency` double DEFAULT '0',
  `equipment_id` int DEFAULT NULL,
  `carbonation_used` varchar(100) DEFAULT NULL,
  `forced_carbonation` tinyint DEFAULT NULL,
  `keg_priming_factor` double DEFAULT NULL,
  `carbonation_temp` double DEFAULT NULL,
  `mash_id` int DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `recipe_style_type_FK_idx` (`style_id`),
  KEY `recipe_equipment_FK_idx` (`equipment_id`),
  KEY `recipe_mash_FK_idx` (`mash_id`),
  CONSTRAINT `recipe_equipment_FK` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`),
  CONSTRAINT `recipe_mash_FK` FOREIGN KEY (`mash_id`) REFERENCES `mash` (`mash_id`),
  CONSTRAINT `recipe_style_FK` FOREIGN KEY (`style_id`) REFERENCES `style` (`style_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `recipe_ingredient`
--

DROP TABLE IF EXISTS `recipe_ingredient`;
CREATE TABLE `recipe_ingredient` (
  `recipe_ingredient_id` int NOT NULL AUTO_INCREMENT,
  `recipe_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `quantity` double NOT NULL DEFAULT '0',
  `time` double DEFAULT '0',
  `use_during_id` int DEFAULT NULL,
  PRIMARY KEY (`recipe_ingredient_id`),
  KEY `recipe_ingredient_ingredient_idx` (`ingredient_id`),
  KEY `recipe_ingredient_recipe_FK` (`recipe_id`),
  KEY `recipe_ingredient_use_during_FK_idx` (`use_during_id`),
  CONSTRAINT `recipe_ingredient_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `recipe_ingredient_recipe_FK` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`),
  CONSTRAINT `recipe_ingredient_use_during_FK` FOREIGN KEY (`use_during_id`) REFERENCES `use_during` (`use_during_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `style`
--

DROP TABLE IF EXISTS `style`;
CREATE TABLE `style` (
  `style_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `version` int DEFAULT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `category_number` varchar(50) DEFAULT NULL,
  `category_letter` varchar(50) DEFAULT NULL,
  `style_guide` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `og_min` double DEFAULT NULL,
  `og_max` double DEFAULT NULL,
  `fg_min` double DEFAULT NULL,
  `fg_max` double DEFAULT NULL,
  `ibu_min` double DEFAULT NULL,
  `ibu_max` double DEFAULT NULL,
  `color_min` double DEFAULT NULL,
  `color_max` double DEFAULT NULL,
  `carb_min` double DEFAULT NULL,
  `carb_max` double DEFAULT NULL,
  `abv_min` double DEFAULT NULL,
  `abv_max` double DEFAULT NULL,
  `notes` varchar(5000) DEFAULT NULL,
  `profile` varchar(5000) DEFAULT NULL,
  `ingredients` varchar(2000) DEFAULT NULL,
  `examples` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`style_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `website` VARCHAR(100) DEFAULT NULL,
  `contact_first_name` varchar(50) DEFAULT NULL,
  `contact_last_name` varchar(50) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `contact_email` varchar(50) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `supplier_address`
--

DROP TABLE IF EXISTS `supplier_address`;
CREATE TABLE `supplier_address` (
  `supplier_id` int NOT NULL,
  `address_id` int NOT NULL,
  `address_type_id` int NOT NULL,
  PRIMARY KEY (`supplier_id`,`address_id`,`address_type_id`),
  KEY `supplier_address_address_FK_idx` (`address_id`),
  KEY `supplier_address_address_type_FK_idx` (`address_type_id`),
  CONSTRAINT `supplier_address_address_FK` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  CONSTRAINT `supplier_address_address_type_FK` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`address_type_id`),
  CONSTRAINT `supplier_address_supplier_FK` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `unit_type`
--

DROP TABLE IF EXISTS `unit_type`;
CREATE TABLE `unit_type` (
  `unit_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`unit_type_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `use_during`
--

DROP TABLE IF EXISTS `use_during`;
CREATE TABLE `use_during` (
  `use_during_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`use_during_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

--
-- Table structure for table `yeast`
--

DROP TABLE IF EXISTS `yeast`;
CREATE TABLE `yeast` (
  `ingredient_id` int NOT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `min_temp` double DEFAULT NULL,
  `max_temp` double DEFAULT NULL,
  `form` varchar(50) DEFAULT NULL,
  `laboratory` varchar(50) DEFAULT NULL,
  `flocculation` varchar(50) DEFAULT NULL,
  `attenuation` double DEFAULT NULL,
  `max_reuse` int DEFAULT NULL,
  `add_to_secondary` tinyint DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `best_for` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`),
  CONSTRAINT `yeast_ingredient_FK` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`)
) ENGINE=InnoDB;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-06 12:40:17
