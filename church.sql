-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`unit_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`unit_type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`unit_type` (
  `unit_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unit_type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`unit_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`unit` ;

CREATE TABLE IF NOT EXISTS `mydb`.`unit` (
  `unit_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unit_name` VARCHAR(45) NULL,
  `unit_type_id` INT NOT NULL,
  `unit_unit_id` INT UNSIGNED NOT NULL,
  `unit_type_unit_type_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`unit_id`),
  INDEX `fk_unit_unit1_idx` (`unit_unit_id` ASC) VISIBLE,
  INDEX `fk_unit_unit_type1_idx` (`unit_type_unit_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_unit_unit1`
    FOREIGN KEY (`unit_unit_id`)
    REFERENCES `mydb`.`unit` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_unit_unit_type1`
    FOREIGN KEY (`unit_type_unit_type_id`)
    REFERENCES `mydb`.`unit_type` (`unit_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`member` ;

CREATE TABLE IF NOT EXISTS `mydb`.`member` (
  `member_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `unit_unit_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_member_unit1_idx` (`unit_unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_member_unit1`
    FOREIGN KEY (`unit_unit_id`)
    REFERENCES `mydb`.`unit` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`position` ;

CREATE TABLE IF NOT EXISTS `mydb`.`position` (
  `position_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`calling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`calling` ;

CREATE TABLE IF NOT EXISTS `mydb`.`calling` (
  `position_position_id` INT UNSIGNED NOT NULL,
  `member_member_id` INT UNSIGNED NOT NULL,
  INDEX `fk_calling_position1_idx` (`position_position_id` ASC) VISIBLE,
  INDEX `fk_calling_member1_idx` (`member_member_id` ASC) VISIBLE,
  CONSTRAINT `fk_calling_position1`
    FOREIGN KEY (`position_position_id`)
    REFERENCES `mydb`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calling_member1`
    FOREIGN KEY (`member_member_id`)
    REFERENCES `mydb`.`member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`organization` ;

CREATE TABLE IF NOT EXISTS `mydb`.`organization` (
  `organization_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_name` VARCHAR(45) NULL,
  `unit_unit_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`organization_id`),
  INDEX `fk_organization_unit1_idx` (`unit_unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_organization_unit1`
    FOREIGN KEY (`unit_unit_id`)
    REFERENCES `mydb`.`unit` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`organization_position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`organization_position` ;

CREATE TABLE IF NOT EXISTS `mydb`.`organization_position` (
  `organization_position_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id_organization_id` INT UNSIGNED NOT NULL,
  `position_position_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`organization_position_id`),
  INDEX `fk_organization_position_organization_id1_idx` (`organization_id_organization_id` ASC) VISIBLE,
  INDEX `fk_organization_position_position1_idx` (`position_position_id` ASC) VISIBLE,
  CONSTRAINT `fk_organization_position_organization_id1`
    FOREIGN KEY (`organization_id_organization_id`)
    REFERENCES `mydb`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_position_position1`
    FOREIGN KEY (`position_position_id`)
    REFERENCES `mydb`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`unit_organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`unit_organization` ;

CREATE TABLE IF NOT EXISTS `mydb`.`unit_organization` (
  `unit_organization_id` INT UNSIGNED NOT NULL,
  `organization_organization_id` INT UNSIGNED NOT NULL,
  `unit_unit_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`unit_organization_id`),
  INDEX `fk_unit_organization_organization1_idx` (`organization_organization_id` ASC) VISIBLE,
  INDEX `fk_unit_organization_unit1_idx` (`unit_unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_unit_organization_organization1`
    FOREIGN KEY (`organization_organization_id`)
    REFERENCES `mydb`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_unit_organization_unit1`
    FOREIGN KEY (`unit_unit_id`)
    REFERENCES `mydb`.`unit` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
