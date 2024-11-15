-- MySQL Script generated by MySQL Workbench
-- Thu Oct 24 13:07:38 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cul d'ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cul d'ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cul d'ampolla` DEFAULT CHARACTER SET utf8 ;
USE `Cul d'ampolla` ;

-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`providers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`providers` (
  `provider_id` INT NOT NULL AUTO_INCREMENT,
  `provider_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was created.',
  `provider_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
  `name` VARCHAR(45) NULL COMMENT 'Name of the provider.',
  `telephone` VARCHAR(45) NULL COMMENT 'Telephone of the provider.',
  `NIF` VARCHAR(45) NULL COMMENT 'NIF of the provider.',
  `fax` VARCHAR(45) NULL COMMENT 'Fax of the provider.',
  PRIMARY KEY (`provider_id`),
  INDEX `idx_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NULL COMMENT 'Street of the address.',
  `number` INT NULL COMMENT 'Number of the street.',
  `city` VARCHAR(45) NULL COMMENT 'City of the address.',
  `door` INT NULL COMMENT 'Door of the Street and number.',
  `zip` VARCHAR(5) NULL COMMENT 'Postal code of the address.',
  `country` VARCHAR(45) NULL COMMENT 'Country of the address.',
  PRIMARY KEY (`address_id`),
  INDEX `idx_zip` (`zip` ASC) VISIBLE,
  INDEX `idx_country` (`country` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`brands` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `brand_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the record was created.',
  `brand_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
  `name` VARCHAR(45) NOT NULL COMMENT 'Name of the brand.',
  `provider_id` INT NOT NULL,
  PRIMARY KEY (`brand_id`, `provider_id`),
  INDEX `idx_name` (`name` ASC) VISIBLE,
  INDEX `fk_brands_provider_idx` (`provider_id` ASC) VISIBLE,
  CONSTRAINT `fk_brands_providers1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `Cul d'ampolla`.`providers` (`provider_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`glasses` (
  `glasses_id` INT NOT NULL AUTO_INCREMENT,
  `glasses_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `glasses_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `glasses_montura` VARCHAR(1) NULL COMMENT 'F = flotant\nP = pasta\nM = metàl·lica',
  `glasses_graduation_OD` DECIMAL(4) NULL,
  `glasses_graduation_OS` DECIMAL(4) NULL,
  `glasses_glassColor` VARCHAR(20) NULL,
  `glasses_price` FLOAT NULL,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`glasses_id`, `brand_id`),
  INDEX `fk_glasses_brand_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_brands1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `Cul d'ampolla`.`brands` (`brand_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamps when this record was created.',
  `client_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
  `name` VARCHAR(45) NULL COMMENT 'Name of the client.',
  `telephone` VARCHAR(9) NULL,
  `email` VARCHAR(255) NULL,
  `recommender_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `idx_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `employee_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `idx_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`sales` (
  `sale_id` INT NOT NULL AUTO_INCREMENT,
  `sale_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `sales_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  PRIMARY KEY (`sale_id`, `client_id`, `employee_id`, `glasses_id`),
  INDEX `fk_sales_client_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_sales_employee_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_sales_glasses_idx` (`glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_Sales_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `Cul d'ampolla`.`clients` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sales_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Cul d'ampolla`.`employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sales_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `Cul d'ampolla`.`glasses` (`glasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`providers_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`providers_has_address` (
  `providers_provider_id` INT NOT NULL,
  `address_address_id` INT NOT NULL,
  PRIMARY KEY (`providers_provider_id`, `address_address_id`),
  INDEX `fk_providers_has_address_address1_idx` (`address_address_id` ASC) VISIBLE,
  INDEX `fk_providers_has_address_providers1_idx` (`providers_provider_id` ASC) VISIBLE,
  CONSTRAINT `fk_providers_has_address_providers1`
    FOREIGN KEY (`providers_provider_id`)
    REFERENCES `Cul d'ampolla`.`providers` (`provider_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_providers_has_address_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `Cul d'ampolla`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul d'ampolla`.`clients_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul d'ampolla`.`clients_has_address` (
  `clients_client_id` INT NOT NULL,
  `address_address_id` INT NOT NULL,
  PRIMARY KEY (`clients_client_id`, `address_address_id`),
  INDEX `fk_clients_has_address_address1_idx` (`address_address_id` ASC) VISIBLE,
  INDEX `fk_clients_has_address_clients1_idx` (`clients_client_id` ASC) VISIBLE,
  CONSTRAINT `fk_clients_has_address_clients1`
    FOREIGN KEY (`clients_client_id`)
    REFERENCES `Cul d'ampolla`.`clients` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clients_has_address_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `Cul d'ampolla`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
