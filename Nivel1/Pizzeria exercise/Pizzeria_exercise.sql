-- MySQL Script generated by MySQL Workbench
-- Wed Oct 30 13:04:28 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria exercise
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria exercise
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria exercise` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria exercise` ;

-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`provincias` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`provincia_id`),
  INDEX `idx_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`localidades` (
  `localidad_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `provincias_provincia_id` INT NOT NULL,
  PRIMARY KEY (`localidad_id`),
  INDEX `idx_name` (`name` ASC) VISIBLE,
  INDEX `fk_localidades_provincias1_idx` (`provincias_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidades_provincias1`
    FOREIGN KEY (`provincias_provincia_id`)
    REFERENCES `Pizzeria exercise`.`provincias` (`provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `first` VARCHAR(45) NULL COMMENT 'First name of the client\n',
  `last` VARCHAR(45) NULL COMMENT 'Last name of the client\n',
  `address` VARCHAR(150) NULL COMMENT 'Address (street, number, door) of the client\n',
  `zip` VARCHAR(5) NULL COMMENT 'Zip code of the address of the client',
  `phone` VARCHAR(9) NULL COMMENT 'Phone of the client',
  `localidades_localidad_id` INT NOT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `idx_first` (`first` ASC) VISIBLE,
  INDEX `idx_last` (`last` ASC) VISIBLE,
  INDEX `fk_clients_localidades1_idx` (`localidades_localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_clients_localidades1`
    FOREIGN KEY (`localidades_localidad_id`)
    REFERENCES `Pizzeria exercise`.`localidades` (`localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`stores` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `address` VARCHAR(150) NULL COMMENT 'Address (street, number, door) of the store.',
  `zip` VARCHAR(5) NULL COMMENT 'Zip code of the address of the store.',
  `localidades_localidad_id` INT NOT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `fk_stores_localidades1_idx` (`localidades_localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_stores_localidades1`
    FOREIGN KEY (`localidades_localidad_id`)
    REFERENCES `Pizzeria exercise`.`localidades` (`localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`workers` (
  `worker_id` INT NOT NULL AUTO_INCREMENT,
  `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `first` VARCHAR(45) NULL COMMENT 'First name of the worker\n',
  `last` VARCHAR(45) NULL COMMENT 'Last name of the worker',
  `NIF` VARCHAR(9) NULL COMMENT 'NIF of the worker\n',
  `phone` VARCHAR(9) NULL COMMENT 'Phone of the worker\n',
  `category` VARCHAR(45) NULL COMMENT 'K: Kitchen\nD: Delivery',
  `stores_store_id` INT NOT NULL,
  PRIMARY KEY (`worker_id`, `stores_store_id`),
  INDEX `fk_workers_stores1_idx` (`stores_store_id` ASC) VISIBLE,
  CONSTRAINT `fk_workers_stores1`
    FOREIGN KEY (`stores_store_id`)
    REFERENCES `Pizzeria exercise`.`stores` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delivery` VARCHAR(1) NULL COMMENT 'H: Home\nS: Store',
  `number_burgers` INT NULL DEFAULT 0,
  `number_pizzas` INT NULL DEFAULT 0,
  `number_drinks` INT NULL DEFAULT 0,
  `total_price` DECIMAL(4,2) NULL,
  `clients_client_id` INT NOT NULL,
  `workers_worker_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_workers1_idx` (`workers_worker_id` ASC) VISIBLE,
  INDEX `fk_orders_clients1_idx` (`clients_client_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`clients_client_id`)
    REFERENCES `Pizzeria exercise`.`clients` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_workers1`
    FOREIGN KEY (`workers_worker_id`)
    REFERENCES `Pizzeria exercise`.`workers` (`worker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`pizzas` (
  `pizza_id` INT NOT NULL AUTO_INCREMENT,
  `categories_category_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `imageURL` VARCHAR(150) NULL,
  `price` DECIMAL(4,2) NULL,
  PRIMARY KEY (`pizza_id`, `categories_category_id`),
  INDEX `fk_pizzas_categories1_idx` (`categories_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizzas_categories1`
    FOREIGN KEY (`categories_category_id`)
    REFERENCES `Pizzeria exercise`.`categories` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`burgers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`burgers` (
  `burger_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `imageURL` VARCHAR(150) NULL,
  `price` DECIMAL(4,2) NULL,
  PRIMARY KEY (`burger_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`drinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`drinks` (
  `drink_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `imageURL` VARCHAR(150) NULL,
  `price` DECIMAL(4,2) NULL,
  PRIMARY KEY (`drink_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`orders_has_drinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`orders_has_drinks` (
  `orders_order_id` INT NOT NULL,
  `drinks_drink_id` INT NOT NULL,
  PRIMARY KEY (`orders_order_id`, `drinks_drink_id`),
  INDEX `fk_orders_has_drinks_drinks1_idx` (`drinks_drink_id` ASC) VISIBLE,
  INDEX `fk_orders_has_drinks_orders1_idx` (`orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_drinks_orders1`
    FOREIGN KEY (`orders_order_id`)
    REFERENCES `Pizzeria exercise`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_has_drinks_drinks1`
    FOREIGN KEY (`drinks_drink_id`)
    REFERENCES `Pizzeria exercise`.`drinks` (`drink_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`orders_has_pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`orders_has_pizzas` (
  `orders_order_id` INT NOT NULL,
  `pizzas_pizza_id` INT NOT NULL,
  `pizzas_categories_category_id` INT NOT NULL,
  PRIMARY KEY (`orders_order_id`, `pizzas_pizza_id`, `pizzas_categories_category_id`),
  INDEX `fk_orders_has_pizzas_pizzas1_idx` (`pizzas_pizza_id` ASC, `pizzas_categories_category_id` ASC) VISIBLE,
  INDEX `fk_orders_has_pizzas_orders1_idx` (`orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_pizzas_orders1`
    FOREIGN KEY (`orders_order_id`)
    REFERENCES `Pizzeria exercise`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_has_pizzas_pizzas1`
    FOREIGN KEY (`pizzas_pizza_id` , `pizzas_categories_category_id`)
    REFERENCES `Pizzeria exercise`.`pizzas` (`pizza_id` , `categories_category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria exercise`.`orders_has_burgers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria exercise`.`orders_has_burgers` (
  `orders_order_id` INT NOT NULL,
  `burgers_burger_id` INT NOT NULL,
  PRIMARY KEY (`orders_order_id`, `burgers_burger_id`),
  INDEX `fk_orders_has_burgers_burgers1_idx` (`burgers_burger_id` ASC) VISIBLE,
  INDEX `fk_orders_has_burgers_orders1_idx` (`orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_burgers_orders1`
    FOREIGN KEY (`orders_order_id`)
    REFERENCES `Pizzeria exercise`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_has_burgers_burgers1`
    FOREIGN KEY (`burgers_burger_id`)
    REFERENCES `Pizzeria exercise`.`burgers` (`burger_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
