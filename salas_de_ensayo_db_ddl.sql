-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema salas_de_ensayo_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salas_de_ensayo_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salas_de_ensayo_db` DEFAULT CHARACTER SET utf8 ;
USE `salas_de_ensayo_db` ;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`persona`(
  `dni` VARCHAR(10) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`sala`(
  `nro` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `capacidad` INT NOT NULL,
  `habilitada` TINYINT NOT NULL DEFAULT 1,
  `precio_x_hora` DECIMAL(10,2) NOT NULL,

  PRIMARY KEY (`nro`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),

  CONSTRAINT `chk_sala_capacidad` CHECK (`capacidad` > 0),
  CONSTRAINT `chk_sala_precio` CHECK (`precio_x_hora` >= 0),
  CONSTRAINT `chk_sala_habilitada` CHECK (`habilitada` IN (0, 1))
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`reserva`(
  `nro` BIGINT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `confirmada` TINYINT NOT NULL DEFAULT 1,
  `sala_precio_x_hora` DECIMAL(10,2) NOT NULL,
  `dni_persona` VARCHAR(10) NOT NULL,
  `nro_sala` BIGINT NOT NULL,

  PRIMARY KEY (`nro`),
  INDEX `fk_reserva_persona1_idx` (`dni_persona` ASC),
  INDEX `fk_reserva_sala1_idx` (`nro_sala` ASC),

  CONSTRAINT `chk_reserva_horarios` CHECK (`hora_fin` > `hora_inicio`),
  CONSTRAINT `chk_reserva_confirmacion` CHECK (`confirmada` IN (0, 1)),

  CONSTRAINT `fk_dni_persona` FOREIGN KEY (`dni_persona`)
    REFERENCES `salas_de_ensayo_db`.`persona` (`dni`)
    ON DELETE NO ACTION ON UPDATE CASCADE,

  CONSTRAINT `fk_nro_sala` FOREIGN KEY (`nro_sala`)
    REFERENCES `salas_de_ensayo_db`.`sala` (`nro`)
    ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`categoria`(
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NOT NULL,
  `id_categoria_padre` BIGINT NULL,

  PRIMARY KEY (`id`),
  INDEX `fk_categoria_categoria1_idx` (`id_categoria_padre` ASC),

  CONSTRAINT `fk_categoria_categoria1` FOREIGN KEY (`id_categoria_padre`)
    REFERENCES `salas_de_ensayo_db`.`categoria` (`id`)
    ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`fabricante`(
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`item_inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`item_inventario`(
  `id` VARCHAR(10) NOT NULL,
  `stock` INT NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `costo_alquiler` DECIMAL(10,2) NOT NULL,
  `id_categoria` BIGINT NOT NULL,
  `id_fabricante` BIGINT NOT NULL,

  PRIMARY KEY (`id`),
  INDEX `fk_item_inventario_categoria1_idx` (`id_categoria` ASC),
  INDEX `fk_item_inventario_fabricante1_idx` (`id_fabricante` ASC),
  
  CONSTRAINT `chk_inventario_stock` CHECK (`stock` >= 0),
  CONSTRAINT `chk_inventario_costo` CHECK (`costo_alquiler` >= 0),

  CONSTRAINT `fk_id_categoria` FOREIGN KEY (`id_categoria`)
    REFERENCES `salas_de_ensayo_db`.`categoria` (`id`)
    ON DELETE NO ACTION ON UPDATE CASCADE,

  CONSTRAINT `fk_id_fabricante` FOREIGN KEY (`id_fabricante`)
    REFERENCES `salas_de_ensayo_db`.`fabricante` (`id`)
    ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`empleado`(
  `dni_persona` VARCHAR(10) NOT NULL,
  `legajo` INT NOT NULL AUTO_INCREMENT,
  `contraseña` VARCHAR(45) NOT NULL DEFAULT 'ar-09/',

  UNIQUE INDEX `legajo_UNIQUE` (`legajo` ASC),
  PRIMARY KEY (`dni_persona`),
  INDEX `fk_empleado_persona1_idx` (`dni_persona` ASC),
  UNIQUE INDEX `dni_persona_UNIQUE` (`dni_persona` ASC),

  CONSTRAINT `fk_dni_persona_empleado` FOREIGN KEY (`dni_persona`)
    REFERENCES `salas_de_ensayo_db`.`persona` (`dni`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`pago`(
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL DEFAULT (CURRENT_DATE()),
  `monto` DECIMAL(10,2) NOT NULL,
  `medio_de_pago` VARCHAR(45) NOT NULL DEFAULT 'Efectivo',
  `nro_reserva` BIGINT NOT NULL,

  PRIMARY KEY (`id`),
  INDEX `fk_pago_reserva1_idx` (`nro_reserva` ASC),
  UNIQUE INDEX `reserva_nro_UNIQUE` (`nro_reserva` ASC),

  CONSTRAINT `chk_pago_monto` CHECK (`monto` >= 0),
  CONSTRAINT `chk_pago_medio` CHECK (`medio_de_pago` IN
	('Efectivo', 'Transferencia', 'Credito', 'Débito')),

  CONSTRAINT `fk_nro_reserva_pago` FOREIGN KEY (`nro_reserva`)
    REFERENCES `salas_de_ensayo_db`.`reserva` (`nro`)
    ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`reserva_inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`reserva_inventario`(
  `nro` BIGINT NOT NULL AUTO_INCREMENT,
  `nro_reserva` BIGINT NOT NULL,
  `id_item_inventario` VARCHAR(10) NOT NULL,
  `precio_unit` DECIMAL(10,2) NOT NULL,
  `cantidad` INT NOT NULL,

  PRIMARY KEY (`nro`, `nro_reserva`, `id_item_inventario`),
  INDEX `fk_reserva_has_item_inventario_item_inventario1_idx` (`id_item_inventario` ASC),
  INDEX `fk_reserva_has_item_inventario_reserva1_idx` (`nro_reserva` ASC),

  CONSTRAINT `chk_aparta_cantidad` CHECK (`cantidad` > 0),
  CONSTRAINT `chk_aparta_precio` CHECK (`precio_unit` >= 0),

  CONSTRAINT `fk_nro_reserva` FOREIGN KEY (`nro_reserva`)
    REFERENCES `salas_de_ensayo_db`.`reserva` (`nro`)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT `fk_id_item_inventario` FOREIGN KEY (`id_item_inventario`)
    REFERENCES `salas_de_ensayo_db`.`item_inventario` (`id`)
    ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salas_de_ensayo_db`.`control_inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salas_de_ensayo_db`.`control_inventario`(
  `nro` INT NOT NULL AUTO_INCREMENT,
  `dni_empleado` VARCHAR(10) NOT NULL,
  `id_item_inventario` VARCHAR(10) NOT NULL,
  `fecha` DATE NULL DEFAULT (CURRENT_DATE()),
  `observacion` VARCHAR(100) NULL,

  PRIMARY KEY (`nro`, `id_item_inventario`, `dni_empleado`),
  INDEX `fk_empleado_has_item_inventario_item_inventario1_idx` (`id_item_inventario` ASC),
  INDEX `fk_empleado_idx` (`dni_empleado` ASC),

  CONSTRAINT `fk_id_item_inventario_control` FOREIGN KEY (`id_item_inventario`)
    REFERENCES `salas_de_ensayo_db`.`item_inventario` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT `fk_dni_empleado` FOREIGN KEY (`dni_empleado`)
    REFERENCES `salas_de_ensayo_db`.`empleado` (`dni_persona`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;