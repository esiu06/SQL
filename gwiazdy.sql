
drop database if exists gwiazdy;

CREATE DATABASE `gwiazdy` ;
use gwiazdy;

delimiter $$
CREATE TABLE `aktor` (
  `Imie` varchar(45) collate utf8_polish_ci default NULL,
  `Nazwisko` varchar(45) collate utf8_polish_ci NOT NULL,
  `DataUrodzenia` date default NULL,
  `Plec` varchar(45) collate utf8_polish_ci default NULL,
  `ZagranychRol` int(11) default NULL,
  `czyStatystowal` bit(1) default NULL,
  `Nagrody` int(11) default NULL,
  `Adres` varchar(45) collate utf8_polish_ci default NULL,
  PRIMARY KEY  (`Nazwisko`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci$$


delimiter $$

CREATE TABLE `film` (
  `Tytul` varchar(45) collate utf8_polish_ci NOT NULL,
  `Premiera` date default NULL,
  `Gatunek` varchar(45) collate utf8_polish_ci default NULL,
  `Czas` int(11) default NULL,
  `czyKolor` bit(1) default NULL,
  `wyprodukowano` date default NULL,
  `nazwaStudia` varchar(45) collate utf8_polish_ci default NULL,
  `liczbaAktorow` int(11) default NULL,
  PRIMARY KEY  (`Tytul`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci$$


delimiter $$

CREATE TABLE `dyrektorprodukcji` (
  `Nazwisko` varchar(45) collate utf8_polish_ci NOT NULL,
  `Imie` varchar(45) collate utf8_polish_ci default NULL,
  `DataUr` date default NULL,
  `Plec` varchar(45) collate utf8_polish_ci default NULL,
  `WyprodukowalFilmow` int(11) default NULL,
  `WartoscKonta` int(11) default NULL,
  `Adres` varchar(45) collate utf8_polish_ci default NULL,
  PRIMARY KEY  (`Nazwisko`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci$$

delimiter $$

CREATE TABLE `gwiazdyw` (
  `TytulFilmu` varchar(45) collate utf8_polish_ci NOT NULL default '',
  `Premiera` date default NULL,
  `ImieGwiazdy` varchar(45) collate utf8_polish_ci default NULL,
  `NazwiskoGwiazdy` varchar(45) collate utf8_polish_ci default NULL,
  `ImieDyrektora` varchar(45) collate utf8_polish_ci default NULL,
  `NazwiskoDyrektora` varchar(45) collate utf8_polish_ci default NULL,
  `Id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`Id`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

insert into gwiazdyw (TytulFilmu, Premiera, ImieGwiazdy, NazwiskoGwiazdy, ImieDyrektora, NazwiskoDyrektora) values ('Przeminelo z wiatrem','1990-03-14', 'Vivien', 'Leigh','George','Cukor');
insert into gwiazdyw (TytulFilmu, Premiera, ImieGwiazdy, NazwiskoGwiazdy, ImieDyrektora, NazwiskoDyrektora)values ('Przeminelo z wiatrem','1990-03-14', 'Clark', 'Gables','George','Cukor');
insert into gwiazdyw (TytulFilmu, Premiera, ImieGwiazdy, NazwiskoGwiazdy, ImieDyrektora, NazwiskoDyrektora)values ('Harry Potter i Insygnia śmierci','2010-11-14', 'Daniel', 'Radcliffe','David','Yates');

insert into aktor values ('Sharon', 'Stone', '1956-06-15', 'k', 20, 1, 5, 'New York');
insert into aktor values ('Vivien', 'Leigh', '1958-01-12', 'k', 3, 1, 5, 'Los Angeles');
insert into aktor values ('Clark', 'Gables', '1957-03-12', 'm', 14, 1, 5, 'Los Angeles');
insert into aktor values ('Daniel', 'Radcliffe', '1957-03-12', 'm', 14, 1, 5, 'Los Angeles');

insert into film values ('Przeminelo z wiatrem', '1990-03-14', 'romans', 120, 1, '1989-03-14', 'Hollywood', 20);
insert into film values ('Harry Potter i Insygnia śmierci', '2010-11-14', 'fantastyczny', 146, 1, '2010-06-14', 'Hollywood', 20);
insert into film values ('Śluby panieńskie', '2010-10-14', 'komedia', 100, 1, '2010-06-14', 'Łódź', 30);

INSERT INTO dyrektorprodukcji VALUES('Cukor','George','1966-08-08','m',5,230000,'New Orlean');
INSERT INTO dyrektorprodukcji VALUES('Yates','David','1966-08-08','m',5,230000,'New Orlean');

SELECT * FROM gwiazdyw;
SELECT Imie, Nazwisko FROM aktor;
SELECT Tytul FROM film WHERE liczbaAktorow >10;
SELECT Tytul, Czas, wyprodukowano FROM film WHERE wyprodukowano LIKE '2010%';
SELECT Tytul, Czas, wyprodukowano FROM film WHERE wyprodukowano LIKE '2010%' AND Gatunek LIKE 'sensacyjny%';
SELECT a.Imie, a.Nazwisko FROM aktor AS a WHERE Plec LIKE 'm';
SELECT Tytul FROM film WHERE Czas>120;
SELECT Tytul FROM film order by liczbaAktorow DESC LIMIT 1;
SELECT AVG(Czas) FROM film ;
SELECT Tytul FROM film order by Czas DESC;

