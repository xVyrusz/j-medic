-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Turnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Turnos` (
  `idTurnos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombreTurno` VARCHAR(45) NOT NULL,
  `horarioEntrada` VARCHAR(45) NOT NULL,
  `horarioSalida` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTurnos`),
  UNIQUE INDEX `idTurnos_UNIQUE` (`idTurnos` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medicos` (
  `idMedicos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombreMedico` VARCHAR(45) NOT NULL,
  `apellidoPMedico` VARCHAR(45) NOT NULL,
  `apellidoMMedico` VARCHAR(45) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  `Cedula` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `idTurnos_F` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idMedicos`),
  UNIQUE INDEX `idMedicos_UNIQUE` (`idMedicos` ASC) VISIBLE,
  INDEX `idTurnos_F_idx` (`idTurnos_F` ASC) VISIBLE,
  CONSTRAINT `idTurnos_F`
    FOREIGN KEY (`idTurnos_F`)
    REFERENCES `mydb`.`Turnos` (`idTurnos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo_Sangre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo_Sangre` (
  `idTipo_Sangre` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombreSangre` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idTipo_Sangre`),
  UNIQUE INDEX `idTipo_Sangre_UNIQUE` (`idTipo_Sangre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pacientes` (
  `idPaciente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombrePaciente` VARCHAR(45) NOT NULL,
  `apellidoPPaciente` VARCHAR(45) NOT NULL,
  `apellidoMPaciente` VARCHAR(45) NOT NULL,
  `sexoPaciente` VARCHAR(45) NOT NULL,
  `pesoPaciente` FLOAT UNSIGNED NOT NULL,
  `estaturaPaciente` FLOAT UNSIGNED NOT NULL,
  `edadPaciente` TINYINT UNSIGNED NOT NULL,
  `telefonoPaciente` VARCHAR(45) NOT NULL,
  `alergiasPaciente` VARCHAR(250) NOT NULL,
  `idTipo_Sangre_F` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPaciente`),
  UNIQUE INDEX `idPacientes_UNIQUE` (`idPaciente` ASC) VISIBLE,
  UNIQUE INDEX `alergiasPaciente_UNIQUE` (`alergiasPaciente` ASC) VISIBLE,
  INDEX `idSangre_F_idx` (`idTipo_Sangre_F` ASC) VISIBLE,
  CONSTRAINT `idTipo_Sangre_F`
    FOREIGN KEY (`idTipo_Sangre_F`)
    REFERENCES `mydb`.`Tipo_Sangre` (`idTipo_Sangre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cita` (
  `idCita` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idPaciente_F` INT UNSIGNED NOT NULL,
  `fechaCita` DATETIME NOT NULL,
  PRIMARY KEY (`idCita`),
  UNIQUE INDEX `idCita_UNIQUE` (`idCita` ASC) VISIBLE,
  UNIQUE INDEX `fechaCita_UNIQUE` (`fechaCita` ASC) VISIBLE,
  INDEX `idPaciente_F_idx` (`idPaciente_F` ASC) VISIBLE,
  CONSTRAINT `idPaciente_F`
    FOREIGN KEY (`idPaciente_F`)
    REFERENCES `mydb`.`Pacientes` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Motivos_de_Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Motivos_de_Consulta` (
  `idMotivos_de_Consulta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombreMotivo` TEXT NOT NULL,
  PRIMARY KEY (`idMotivos_de_Consulta`),
  UNIQUE INDEX `idMotivos_de_Consulta_UNIQUE` (`idMotivos_de_Consulta` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Datos_de_Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Datos_de_Consulta` (
  `idMedicos_F` INT UNSIGNED NOT NULL,
  `idPaciente_F` INT UNSIGNED NOT NULL,
  `fechaVisita` DATETIME NOT NULL,
  `idMotivo_F` INT UNSIGNED NOT NULL,
  `idConsulta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  UNIQUE INDEX `idConsulta_F_UNIQUE` (`idConsulta` ASC) VISIBLE,
  PRIMARY KEY (`idConsulta`),
  INDEX `idMedicos_F_idx` (`idMedicos_F` ASC) VISIBLE,
  INDEX `idPacientes_F_idx` (`idPaciente_F` ASC) VISIBLE,
  INDEX `idMotivo_F_idx` (`idMotivo_F` ASC) VISIBLE,
  CONSTRAINT `idMedicos_F`
    FOREIGN KEY (`idMedicos_F`)
    REFERENCES `mydb`.`Medicos` (`idMedicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPacienteDatos_F`
    FOREIGN KEY (`idPaciente_F`)
    REFERENCES `mydb`.`Pacientes` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idMotivo_F`
    FOREIGN KEY (`idMotivo_F`)
    REFERENCES `mydb`.`Motivos_de_Consulta` (`idMotivos_de_Consulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consulta` (
  `idConsulta_F` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pruebasRealizadas` TEXT NOT NULL,
  `diagnostico` TEXT NOT NULL,
  `tratamiento` TEXT NOT NULL,
  UNIQUE INDEX `idConsulta_UNIQUE` (`idConsulta_F` ASC),
  CONSTRAINT `idConsulta_F`
    FOREIGN KEY (`idConsulta_F`)
    REFERENCES `mydb`.`Datos_de_Consulta` (`idConsulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;