-- MySQL Script generated by MySQL Workbench
-- Thu Oct 24 10:24:02 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema teamtasker
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `teamtasker` ;

-- -----------------------------------------------------
-- Schema teamtasker
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `teamtasker` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `teamtasker` ;

-- -----------------------------------------------------
-- Table `teamtasker`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(70) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `mail` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`Etiqueta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`Etiqueta` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`Etiqueta` (
  `idEtiqueta` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idEtiqueta`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `teamtasker`.`TareaGlobal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`TareaGlobal` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`TareaGlobal` (
  `idProyecto` INT NOT NULL AUTO_INCREMENT,
  `nombre_proyecto` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `dateIn` DATETIME NOT NULL,
  `dateEnd` DATETIME NOT NULL,
  `progreso` DOUBLE NULL,
  `duracion` INT NULL,
  `admin_id` INT NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idProyecto`),
  UNIQUE INDEX `idProyecto_UNIQUE` (`idProyecto` ASC),
  INDEX `fk_Proyecto_Usuario1_idx` (`admin_id` ASC),
  INDEX `fk_TareaGlobal_Etiqueta1_idx` (`estado` ASC),
  CONSTRAINT `fk_Proyecto_Usuario1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `teamtasker`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_TareaGlobal_Etiqueta1`
    FOREIGN KEY (`estado`)
    REFERENCES `teamtasker`.`Etiqueta` (`idEtiqueta`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`Prioridad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`Prioridad` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`Prioridad` (
  `idPrioridad` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idPrioridad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`TareaGrupal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`TareaGrupal` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`TareaGrupal` (
  `idGrupo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `idProyecto` INT NOT NULL,
  `admin` INT NOT NULL,
  `completada` TINYINT NOT NULL,
  `dateIn` DATETIME NOT NULL,
  `dateEnd` DATETIME NOT NULL,
  `progreso` DOUBLE NULL,
  `duracion` INT NULL,
  `estado` VARCHAR(70) NOT NULL,
  `etiqueta` INT NOT NULL,
  `prioridad` INT NOT NULL,
  PRIMARY KEY (`idGrupo`),
  INDEX `fk_Grupo_Proyecto_idx` (`idProyecto` ASC),
  INDEX `fk_Grupo_Usuario1_idx` (`admin` ASC),
  INDEX `fk_Grupo_Etiqueta1_idx` (`etiqueta` ASC),
  INDEX `fk_Grupo_Prioridad1_idx` (`prioridad` ASC),
  CONSTRAINT `fk_Grupo_Proyecto`
    FOREIGN KEY (`idProyecto`)
    REFERENCES `teamtasker`.`TareaGlobal` (`idProyecto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Grupo_Usuario1`
    FOREIGN KEY (`admin`)
    REFERENCES `teamtasker`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Grupo_Etiqueta1`
    FOREIGN KEY (`etiqueta`)
    REFERENCES `teamtasker`.`Etiqueta` (`idEtiqueta`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Grupo_Prioridad1`
    FOREIGN KEY (`prioridad`)
    REFERENCES `teamtasker`.`Prioridad` (`idPrioridad`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`TareaUnitaria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`TareaUnitaria` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`TareaUnitaria` (
  `idTareaUnitaria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `grupo` INT NOT NULL,
  `usuario` INT NOT NULL,
  `dateIn` DATETIME NULL,
  `dateEnd` DATETIME NULL,
  `progreso` DOUBLE NULL,
  `duracion` INT NULL,
  `hito` TINYINT NULL,
  `etiqueta` INT NOT NULL,
  `prioridad` INT NOT NULL,
  PRIMARY KEY (`idTareaUnitaria`),
  INDEX `fk_TareaUnitaria_Grupo1_idx` (`grupo` ASC),
  INDEX `fk_TareaUnitaria_Usuario1_idx` (`usuario` ASC),
  INDEX `fk_TareaUnitaria_Etiqueta1_idx` (`etiqueta` ASC),
  INDEX `fk_TareaUnitaria_Prioridad1_idx` (`prioridad` ASC),
  CONSTRAINT `fk_TareaUnitaria_Grupo1`
    FOREIGN KEY (`grupo`)
    REFERENCES `teamtasker`.`TareaGrupal` (`idGrupo`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_TareaUnitaria_Usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `teamtasker`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_TareaUnitaria_Etiqueta1`
    FOREIGN KEY (`etiqueta`)
    REFERENCES `teamtasker`.`Etiqueta` (`idEtiqueta`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_TareaUnitaria_Prioridad1`
    FOREIGN KEY (`prioridad`)
    REFERENCES `teamtasker`.`Prioridad` (`idPrioridad`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`Perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`Perfil` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`Perfil` (
  `idPerfil` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idPerfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`TareaGrupal_has_Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`TareaGrupal_has_Usuario` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`TareaGrupal_has_Usuario` (
  `idUsuario` INT NOT NULL,
  `idGrupo` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `idGrupo`),
  INDEX `fk_Grupo_has_Usuario_Usuario1_idx` (`idUsuario` ASC),
  INDEX `fk_Grupo_has_Usuario_Grupo1_idx` (`idGrupo` ASC),
  CONSTRAINT `fk_Grupo_has_Usuario_Grupo1`
    FOREIGN KEY (`idGrupo`)
    REFERENCES `teamtasker`.`TareaGrupal` (`idGrupo`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Grupo_has_Usuario_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `teamtasker`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`Usuario_has_Perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`Usuario_has_Perfil` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`Usuario_has_Perfil` (
  `idUsuario` INT NOT NULL,
  `idPerfil` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `idPerfil`),
  INDEX `fk_Usuario_has_Perfil_Perfil1_idx` (`idPerfil` ASC),
  INDEX `fk_Usuario_has_Perfil_Usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Usuario_has_Perfil_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `teamtasker`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Usuario_has_Perfil_Perfil1`
    FOREIGN KEY (`idPerfil`)
    REFERENCES `teamtasker`.`Perfil` (`idPerfil`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teamtasker`.`Usuario_has_TareaGlobal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teamtasker`.`Usuario_has_TareaGlobal` ;

CREATE TABLE IF NOT EXISTS `teamtasker`.`Usuario_has_TareaGlobal` (
  `idUsuario` INT NOT NULL,
  `idProyecto` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `idProyecto`),
  INDEX `fk_Usuario_has_TareaGlobal_TareaGlobal1_idx` (`idProyecto` ASC),
  INDEX `fk_Usuario_has_TareaGlobal_Usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Usuario_has_TareaGlobal_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `teamtasker`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Usuario_has_TareaGlobal_TareaGlobal1`
    FOREIGN KEY (`idProyecto`)
    REFERENCES `teamtasker`.`TareaGlobal` (`idProyecto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
