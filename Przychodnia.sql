DROP DATABASE IF EXISTS Clinik;
CREATE DATABASE Clinik;
USE Clinik;

CREATE TABLE `Patient`(
`idPatient` INT NOT NULL AUTO_INCREMENT,
`firstName` TEXT CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`lastName` TEXT CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`age` INT NOT NULL,
`phonNumber` INT NOT NULL,
PRIMARY KEY (`idPatient`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci 
AUTO_INCREMENT=1;

CREATE TABLE `Doctor` (
`idDoctor` INT NOT NULL AUTO_INCREMENT,
`firstName` TEXT CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`lastName` TEXT CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
PRIMARY KEY (`idDoctor`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci 
AUTO_INCREMENT=1;