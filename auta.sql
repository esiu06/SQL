DROP TABLE IF EXISTS Activity;
CREATE TABLE `Activity`
(
`Idactivity` int NOT NULL AUTO_INCREMENT,
`Message` TEXT CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`Query` TEXT CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
PRIMArY KEY (`Idactivity`))
DEFAULT CHARSET =utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;

DROP TRIGGER wypozyczSamochod;

delimiter |
CREATE TRIGGER wypozyczSamochod 
AFTER INSERT ON wypozyczenia 
FOR EACH ROW 
BEGIN 
INSERT INTO Activity
SET Message=
(SELECT(CONCAT("Wypożyczono auto: ", marka,model)) 
FROM auta WHERE idAuta=NEW.idAuta);
END
|

INSERT INTO wypozyczenia
SET idklienta=1,
idauta=1,
datawyp="2017-09-14",
datazwrotu="2017-09-15",
naleznosc=111;
|
CREATE TRIGGER dodajAuto
AFTER INSERT ON auta
FOR EACH ROW
BEGIN
INSERT INTO Activity
SET Message=
(SELECT(CONCAT("Dodano nowe auto:", NEW.marka, NEW.model, NEW.przebieg)));
END
|
INSERT INTO auta
SET
marka="VW ",
model="Passat ",
przebieg=200000,
rocznik=2015,
kolor="srebrny metalik",
ubezpieczenie=1;



