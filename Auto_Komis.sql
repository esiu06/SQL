/*
Baza danych jest przeznaczona do rejestrowania transakcji zakupu i sprzeda¿y pojazdów w komisie samochodowym. 
Umo¿liwia prowadzenie kartoteki klientów komisu, a tak¿e ewidencjonuje pojazdy, które przesz³y przez komis.
Dostarcza danych do wystawienia faktury kupna/sprzeda¿y, a tak¿e umo¿liwia okreœlenie które pojazdy s¹ na sprzeda¿.

Pojazd (marka, model, kolor, rok produkcji, nr VIN, przebieg, pojemnoœæ silnika, nr rejestracyjny, data rejstracji, data przyjêcia, cena)

Klient (Nazwisko, Imiê, pesel, NIP, kod pocztowy, miasto, ulica, nr domu, nr lokalu, telefon, e-mail, rodzaj dokumentu to¿samoœci, nr dokumentu)

Transakcje (rodzaj transakcji, data transakcji, kwota, nr faktury, rabat, sposób zap³aty, czy zap³acono)

*/




IF (DB_ID('Auto_komis') IS NULL)						
BEGIN
	CREATE DATABASE Auto_komis							
	PRINT 'Utworzono bazê Auto_komis'					
END ELSE
	PRINT 'Baza Auto_komis ju¿ istnieje'					
GO													

USE [Auto_komis]											
GO

CREATE SCHEMA Auto_komis 
GO



IF OBJECT_ID (N'Pojazdy', N'U') IS NULL				
BEGIN
	CREATE TABLE [Auto_komis].[Pojazdy](
	
	[ID_Pojazdu] [int] IDENTITY(1,1) NOT NULL,
	[ID_Marki] [int] NOT NULL,
	[ID_Modelu] [int] NOT NULL,
	[ID_Koloru] [int] NOT NULL,
	[rok_prod] DATE NOT NULL,
	[nr_vin] [nvarchar](25) NOT NULL,
	[przebieg] [nvarchar](20) NOT NULL,
	[poj_silnika] [int]  NOT NULL,
	[nr_rej] [nvarchar](7) NOT NULL,
	[data_rej] DATE NOT NULL,
	[data_przyjecia] DATE NOT NULL,
	[cena] NUMERIC(7,2) NOT NULL,
	CONSTRAINT [PK_Pojazdy] PRIMARY KEY CLUSTERED 
	(
		[ID_Pojazdu] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Pojazdy'					
END ELSE											
    PRINT 'Tabela Pojazdy ju¿ istnieje'				
GO	

INSERT INTO [Auto_komis].[Pojazdy] VALUES('1','1','1','2000','MWI0987N3344521','290000','1200','DWR2345','2000-10-02','2020-03-10','35500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('1','1','7','2010','PWI0987N3344521','390000','1200','DWR2375','2010-01-01','2020-05-10','45500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('1','3','6','2010','MKI0987N3984521','540000','3000','DWR2805','2010-10-10','2020-02-19','85500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('2','10','3','2011','MWI0987N3344871','45000','2200','DLW2345','2011-09-09','2020-01-12','95500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('2','7','5','2014','GTI0987N3344521','26000','2000','WWR2345','2014-01-10','2020-03-13','45500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('2','6','8','2000','MWI0987N0044521','210000','1200','DWR2125','2000-11-09','2020-05-11','15500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('3','12','2','2010','OWI0987N3344521','290000','1400','LWR2345','2010-08-12','2020-02-10','35500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('12','43','1','2011','MWI0987N2544451','23000','5000','DWL2345','2011-10-10','2020-04-13','35500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('12','44','9','2019','YWI0987N3344521','21000','4000','DWL9345','2019-01-08','2020-04-16','25500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('10','35','5','2000','MWI0217N3344521','290000','1600','CWR2345','2000-02-09','2020-05-14','75500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('10','35','2','2012','GWI0217N3344521','670000','1800','WWR2345','2012-04-09','2020-03-18','25500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('10','35','9','2011','RWI0217N3344521','210000','1700','YWR2345','2011-04-29','2020-05-19','5500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('10','35','5','2009','TWI0217N3344521','211000','1600','OWR2345','2009-09-10','2020-04-19','7500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('3','12','7','2010','IWI0987N3344521','190000','1400','GWR2345','2010-04-10','2020-05-19','15500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('20','57','4','2010','IER0987N3344521','196000','1800','DWR1110','2010-12-03','2020-05-30','35500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('20','57','7','2019','WQI0987N3344521','9200','1400','OWR2345','2019-10-29','2020-04-19','25500');
INSERT INTO [Auto_komis].[Pojazdy] VALUES('20','59','8','2004','IOL0987N3344521','123000','1400','ZWR2345','2004-04-30','2020-05-29','11500');
GO


IF OBJECT_ID (N'Marki', N'U') IS NULL				
BEGIN
	CREATE TABLE [Auto_komis].[Marki](
	[ID_Marki] [int] IDENTITY(1,1) NOT NULL,
	[nazwa_marki] [nvarchar](15) NOT NULL,
	CONSTRAINT [PK_Marki] PRIMARY KEY CLUSTERED 
	(
		[ID_Marki] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Marki'					
END ELSE											
    PRINT 'Tabela Marki ju¿ istnieje'				
GO	

INSERT INTO [Auto_komis].[Marki] VALUES('BMW');
INSERT INTO [Auto_komis].[Marki] VALUES('Audi');
INSERT INTO [Auto_komis].[Marki] VALUES('Hyundai');
INSERT INTO [Auto_komis].[Marki] VALUES('Fiat');
INSERT INTO [Auto_komis].[Marki] VALUES('Dacia');
INSERT INTO [Auto_komis].[Marki] VALUES('Mitsubishi');
INSERT INTO [Auto_komis].[Marki] VALUES('Citroen');
INSERT INTO [Auto_komis].[Marki] VALUES('Honda');
INSERT INTO [Auto_komis].[Marki] VALUES('Mazda');
INSERT INTO [Auto_komis].[Marki] VALUES('Opel');
INSERT INTO [Auto_komis].[Marki] VALUES('Ford');
INSERT INTO [Auto_komis].[Marki] VALUES('Mersedes');
INSERT INTO [Auto_komis].[Marki] VALUES('Renault');
INSERT INTO [Auto_komis].[Marki] VALUES('Kia');
INSERT INTO [Auto_komis].[Marki] VALUES('Aston Martin');
INSERT INTO [Auto_komis].[Marki] VALUES('Bentley');
INSERT INTO [Auto_komis].[Marki] VALUES('Alfa Romeo');
INSERT INTO [Auto_komis].[Marki] VALUES('Rover');
INSERT INTO [Auto_komis].[Marki] VALUES('Toyota');
INSERT INTO [Auto_komis].[Marki] VALUES('Volkswagen');
GO		


IF OBJECT_ID (N'Modele', N'U') IS NULL				
BEGIN
	CREATE TABLE [Auto_komis].[Modele](
	
	[ID_Modelu][int] IDENTITY(1,1) NOT NULL,
	[nazwa_modelu] [nvarchar](15) NOT NULL,
	[ID_Marki] [int] NOT NULL,
	CONSTRAINT [PK_Modele] PRIMARY KEY CLUSTERED 
	(
		[ID_Modelu] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Modele'					
END ELSE											
    PRINT 'Tabela Modele ju¿ istnieje'				
GO	


INSERT INTO [Auto_komis].[Modele] VALUES('X1','1');
INSERT INTO [Auto_komis].[Modele] VALUES('X2', '1');
INSERT INTO [Auto_komis].[Modele] VALUES('X3','1');
INSERT INTO [Auto_komis].[Modele] VALUES('X5','1');
INSERT INTO [Auto_komis].[Modele] VALUES('Z3','1');
INSERT INTO [Auto_komis].[Modele] VALUES('A1','2');
INSERT INTO [Auto_komis].[Modele] VALUES('A3','2');
INSERT INTO [Auto_komis].[Modele] VALUES('A4','2');
INSERT INTO [Auto_komis].[Modele] VALUES('A5','2');
INSERT INTO [Auto_komis].[Modele] VALUES('A6','2');
INSERT INTO [Auto_komis].[Modele] VALUES('A8','2');
INSERT INTO [Auto_komis].[Modele] VALUES('i20','3');
INSERT INTO [Auto_komis].[Modele] VALUES('i30','3');
INSERT INTO [Auto_komis].[Modele] VALUES('i40','3');
INSERT INTO [Auto_komis].[Modele] VALUES('Tipo','4');
INSERT INTO [Auto_komis].[Modele] VALUES('Panda','4');
INSERT INTO [Auto_komis].[Modele] VALUES('Bravo','4');
INSERT INTO [Auto_komis].[Modele] VALUES('125p','4');
INSERT INTO [Auto_komis].[Modele] VALUES('Dokker','5');
INSERT INTO [Auto_komis].[Modele] VALUES('Logan','5');
INSERT INTO [Auto_komis].[Modele] VALUES('ASX','6');
INSERT INTO [Auto_komis].[Modele] VALUES('Colt', '6');
INSERT INTO [Auto_komis].[Modele] VALUES('Lancer','6');
INSERT INTO [Auto_komis].[Modele] VALUES('Eclipse','6');
INSERT INTO [Auto_komis].[Modele] VALUES('C3','7');
INSERT INTO [Auto_komis].[Modele] VALUES('C1','7');
INSERT INTO [Auto_komis].[Modele] VALUES('C4','7');
INSERT INTO [Auto_komis].[Modele] VALUES('C5','7');
INSERT INTO [Auto_komis].[Modele] VALUES('Accord','8');
INSERT INTO [Auto_komis].[Modele] VALUES('Civic','8');
INSERT INTO [Auto_komis].[Modele] VALUES('HR-V','8');
INSERT INTO [Auto_komis].[Modele] VALUES('323','9');
INSERT INTO [Auto_komis].[Modele] VALUES('MX-3','9');
INSERT INTO [Auto_komis].[Modele] VALUES('CX-3','9');
INSERT INTO [Auto_komis].[Modele] VALUES('Corsa','10');
INSERT INTO [Auto_komis].[Modele] VALUES('Astra','10');
INSERT INTO [Auto_komis].[Modele] VALUES('Mokka','10');
INSERT INTO [Auto_komis].[Modele] VALUES('Tigra','10');
INSERT INTO [Auto_komis].[Modele] VALUES('Fiesta','11');
INSERT INTO [Auto_komis].[Modele] VALUES('S500','12');
INSERT INTO [Auto_komis].[Modele] VALUES('Klasa A','12');
INSERT INTO [Auto_komis].[Modele] VALUES('Klasa B', '12');
INSERT INTO [Auto_komis].[Modele] VALUES('CLK','12');
INSERT INTO [Auto_komis].[Modele] VALUES('SLK','12');
INSERT INTO [Auto_komis].[Modele] VALUES('Clio','13');
INSERT INTO [Auto_komis].[Modele] VALUES('Captur','13');
INSERT INTO [Auto_komis].[Modele] VALUES('Twingo','13');
INSERT INTO [Auto_komis].[Modele] VALUES('Rio','14');
INSERT INTO [Auto_komis].[Modele] VALUES('DB9','15');
INSERT INTO [Auto_komis].[Modele] VALUES('Bentayga','16');
INSERT INTO [Auto_komis].[Modele] VALUES('159','17');
INSERT INTO [Auto_komis].[Modele] VALUES('Brera','17');
INSERT INTO [Auto_komis].[Modele] VALUES('Spider','17');
INSERT INTO [Auto_komis].[Modele] VALUES('200','18');
INSERT INTO [Auto_komis].[Modele] VALUES('Auris','19');
INSERT INTO [Auto_komis].[Modele] VALUES('Aygo','19');
INSERT INTO [Auto_komis].[Modele] VALUES('Golf','20');
INSERT INTO [Auto_komis].[Modele] VALUES('Passat','20');
INSERT INTO [Auto_komis].[Modele] VALUES('Lupo','20');
INSERT INTO [Auto_komis].[Modele] VALUES('Garbus','20');
GO

			
IF OBJECT_ID (N'Kolory', N'U') IS NULL				
BEGIN
	CREATE TABLE [Auto_komis].[Kolory](
	
	[ID_Koloru] [int] IDENTITY(1,1) NOT NULL,
	[nazwa_koloru] [nvarchar](15) NOT NULL,
	CONSTRAINT [PK_Kolory] PRIMARY KEY CLUSTERED 
	(
		[ID_Koloru] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Kolory'					
END ELSE											
    PRINT 'Tabela Kolory ju¿ istnieje'				
GO	


INSERT INTO [Auto_komis].[Kolory] VALUES('White');
INSERT INTO [Auto_komis].[Kolory] VALUES('Azure');
INSERT INTO [Auto_komis].[Kolory] VALUES('Peach');
INSERT INTO [Auto_komis].[Kolory] VALUES('Cerise');
INSERT INTO [Auto_komis].[Kolory] VALUES('Black');
INSERT INTO [Auto_komis].[Kolory] VALUES('Aquamarine');
INSERT INTO [Auto_komis].[Kolory] VALUES('Camel');
INSERT INTO [Auto_komis].[Kolory] VALUES('Red');
INSERT INTO [Auto_komis].[Kolory] VALUES('Dark red');
INSERT INTO [Auto_komis].[Kolory] VALUES('Sky blue');
INSERT INTO [Auto_komis].[Kolory] VALUES('Ultramarine');
INSERT INTO [Auto_komis].[Kolory] VALUES('Cerise');
INSERT INTO [Auto_komis].[Kolory] VALUES('Beige');
INSERT INTO [Auto_komis].[Kolory] VALUES('Cerise');
INSERT INTO [Auto_komis].[Kolory] VALUES('Magenta');	
GO


IF OBJECT_ID (N'Klienci', N'U') IS NULL				
BEGIN
	CREATE TABLE [Auto_komis].[Klienci](
	
	[ID_Klienta] [int]IDENTITY(1,1) NOT NULL,
	[Nazwisko] [nvarchar](50) NOT NULL,
	[Imie] [nvarchar](25) NOT NULL,
	[pesel] [nchar](11) NOT NULL,
	[nip] [nchar](10) NOT NULL,
	[kod_poczt] [nchar](5) NOT NULL,
	[miasto] [nvarchar](25) NOT NULL,
	[ulica] [nvarchar](35) NOT NULL,
	[nr_domu] [nchar](7) NOT NULL,
	[nr_lok] [nchar](5) NOT NULL,
	[telefon] [nchar](15) NOT NULL,
	[mail] [nchar](30) NOT NULL,
	[rodzaj_dok] [nchar](25) NOT NULL,
	[nr_dok] [nchar](20) NOT NULL,

	
	 CONSTRAINT [PK_Klienci] PRIMARY KEY CLUSTERED 
	(
		[ID_Klienta] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	PRINT 'Utworzono tabelê Klienci'					
END ELSE											
    PRINT 'Tabela Klienci ju¿ istnieje'				
GO	

INSERT INTO [Auto_komis].[Klienci] VALUES('Kowalski','Jan','78121212123','9980990123','56100','Wo³ów','Rynek','19','2','666900900', 'jankowalski@wp.pl','DO','abc121212');
INSERT INTO [Auto_komis].[Klienci] VALUES('Nowak','Jan','78121212156','8880990123','56130','Wo³ów','D³uga','1','2','666900345', 'jannowak@wp.pl','DO','abc121213');
INSERT INTO [Auto_komis].[Klienci] VALUES('Pluta','Tomasz','75121212123','7880990123','56140','Wo³ów','Rawicka','7','9','607900900', 'tomszpluta@wp.pl','DO','abc129812');
INSERT INTO [Auto_komis].[Klienci] VALUES('Buda','Ewa','87121212123','9680990123','56120','Brzeg dolny','Nowa','12','2','886900900', 'ebuda@wp.pl','DO','abc761212');
INSERT INTO [Auto_komis].[Klienci] VALUES('Zieliñski','Piotr','80121212123','5680990123','56100','Wo³ów','Parkowa','36','2','506900900', 'pzielinski@wp.pl','DO','gtc121212');
INSERT INTO [Auto_komis].[Klienci] VALUES('Lewandowski','Robert','85121212123','1280990123','56160','Wroc³aw','Z³ota','1','9','666900900', 'rl09@wp.pl','DO','cfr121212');
INSERT INTO [Auto_komis].[Klienci] VALUES('Rudy','Bo¿ena','81121212123','9080990123','56223','Rudawa','Rynek','23','2','666000900', 'ruda@wp.pl','DO','abnm121212');
INSERT INTO [Auto_komis].[Klienci] VALUES('Bielik','Sabina','90121212123','3980990123','56190','Tarnów','Zielona','22','13','660900900', 'sbielik@wp.pl','DO','abc222212');
INSERT INTO [Auto_komis].[Klienci] VALUES('Boski','Olaf','54121212123','9120990123','56234','Hel','Jasna','1234','2','456900900', 'boski@wp.pl','DO','abc121999');
INSERT INTO [Auto_komis].[Klienci] VALUES('Kozio³','Jan','78155212123','9980923123','56100','Wo³ów','Koœciuszki','29','2','666900410', 'kozioljan@wp.pl','DO','abc121011');
GO

IF OBJECT_ID (N'Transakcje', N'U') IS NULL				
BEGIN
	CREATE TABLE [Auto_komis].[Transakcje](
	
	[ID_Transakcji] [int] IDENTITY(1,1) NOT NULL,
	[ID_Klienta] [int] NOT NULL,
	[ID_Pojazdu] [int] NOT NULL,
	[rodzaj_tran] [nchar](1) NOT NULL,
	[kwota] NUMERIC(7,2) NOT NULL,
	[nr_faktury] [nchar](20) NOT NULL,
	[sp_zaplaty] [nchar](1) NOT NULL,
	[rabat] [int] NOT NULL,
	[data_tran] DATE NOT NULL,
	[zaplacono] [nchar](3) NOT NULL,
	
	 CONSTRAINT [PK_Transakcje] PRIMARY KEY CLUSTERED 
	(
		[ID_Transakcji] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	PRINT 'Utworzono tabelê Transakcje'					
END ELSE											
    PRINT 'Tabela Transakcje ju¿ istnieje'				
GO	
		
					
INSERT INTO [Auto_komis].[Transakcje] VALUES('1','1','s','45000','001','p','10','2020-05-23','T');
INSERT INTO [Auto_komis].[Transakcje] VALUES('2','12','k','23000','002','g','00','2020-05-12','T');
INSERT INTO [Auto_komis].[Transakcje] VALUES('3','11','s','45000','003','p','10','2020-03-23','T');
INSERT INTO [Auto_komis].[Transakcje] VALUES('4','9','s','55000','004','p','10','2020-02-23','T');
INSERT INTO [Auto_komis].[Transakcje] VALUES('5','5','s','25000','005','p','20','2020-04-23','T');
INSERT INTO [Auto_komis].[Transakcje] VALUES('6','6','k','42300','006','p','10','2020-01-19','T');
GO


-- relacja Pojazdy z Modele

ALTER TABLE [Auto_komis].[Pojazdy]  WITH CHECK ADD  CONSTRAINT [FK_Pojazdy_Modele] FOREIGN KEY([ID_Modelu])  
REFERENCES [Auto_komis].[Modele] ([ID_Modelu])
GO

ALTER TABLE [Auto_komis].[Pojazdy] CHECK CONSTRAINT [FK_Pojazdy_Modele]
GO

-- relacja Modele z Marki

ALTER TABLE [Auto_komis].[Modele]  WITH CHECK ADD  CONSTRAINT [FK_Modele_Marki] FOREIGN KEY([ID_Marki])  
REFERENCES [Auto_komis].[Marki] ([ID_Marki])
GO

ALTER TABLE [Auto_komis].[Modele] CHECK CONSTRAINT [FK_Modele_Marki]
GO

-- relacja Pojazdy z Kolory

ALTER TABLE [Auto_komis].[Pojazdy]  WITH CHECK ADD  CONSTRAINT [FK_Pojazdy_Kolory] FOREIGN KEY([ID_Koloru])  
REFERENCES [Auto_komis].[Kolory] ([ID_Koloru])
GO

ALTER TABLE [Auto_komis].[Pojazdy] CHECK CONSTRAINT [FK_Pojazdy_Kolory]
GO

-- relacja Transakcje z Pojazdy

ALTER TABLE [Auto_komis].[Transakcje]  WITH CHECK ADD  CONSTRAINT [FK_Transakcje_Pojazdy] FOREIGN KEY([ID_Pojazdu])  
REFERENCES [Auto_komis].[Pojazdy] ([ID_Pojazdu])
GO

ALTER TABLE [Auto_komis].[Transakcje] CHECK CONSTRAINT [FK_Transakcje_Pojazdy]
GO

-- relacja Transakcje z Klienci

ALTER TABLE [Auto_komis].[Transakcje]  WITH CHECK ADD  CONSTRAINT [FK_Transakcje_Klienci] FOREIGN KEY([ID_Klienta])  
REFERENCES [Auto_komis].[Klienci] ([ID_Klienta])
GO

ALTER TABLE [Auto_komis].[Transakcje] CHECK CONSTRAINT [FK_Transakcje_Klienci]
GO



SELECT * From [Auto_komis].[Pojazdy];
SELECT * From [Auto_komis].Marki;
SELECT * From [Auto_komis].Modele;
SELECT * From [Auto_komis].Kolory;
SELECT * From [Auto_komis].Klienci;
SELECT * From [Auto_komis].Transakcje;

--w³¹czenie statystyk

SET STATISTICS  IO ON

--porz¹dkowanie po dacie malej¹co

SELECT ID_Pojazdu, rok_prod
FROM  [Auto_komis].Pojazdy ORDER BY rok_prod DESC

--porz¹dkowanie data malej¹co i data przyjecia rosn¹co

SELECT ID_Pojazdu, rok_prod, data_przyjecia
FROM  [Auto_komis].Pojazdy ORDER BY rok_prod DESC, data_przyjecia ASC

-- poka¿, które auta s¹ na sprzeda¿

SELECT ID_Pojazdu FROM [Auto_komis].Transakcje WHERE rodzaj_tran = 'k'

--poka¿ transakcje z przedzia³u od 20000 do 40000

SELECT ID_Transakcji, ID_Klienta, kwota
FROM  [Auto_komis].Transakcje WHERE kwota BETWEEN 20000 AND 40000

SELECT ID_Transakcji, ID_Klienta, kwota
FROM  [Auto_komis].Transakcje WHERE (kwota >= 20000) AND (kwota <= 40000)

--pierwsze 5 rekordów z tabeli Pojazdy

SELECT TOP 5 * FROM [Auto_komis].Pojazdy

--£¥CZENIA

--³¹czenie tabel wewnêtrzne: wypisanie klienta (nazwisko i imiê) oraz daty transakcji i rodzaju transakcji

SELECT Klienci.nazwisko, Klienci.imie, Transakcje.data_tran, Transakcje.rodzaj_tran
FROM  [Auto_komis].Klienci INNER JOIN  [Auto_komis].Transakcje
ON  [Auto_komis].Klienci.ID_Klienta= [Auto_komis].Transakcje.ID_Klienta

--³¹czenie tabel wewnêtrzne: wypisanie pojazdu jego marki, modelu, nr rejestracyjnego, koloru, rocznika, przebiegu i ceny

SELECT  [Auto_komis].Marki.nazwa_marki,  [Auto_komis].Modele.nazwa_modelu,  [Auto_komis].Pojazdy.nr_rej,  [Auto_komis].Kolory.nazwa_koloru,  [Auto_komis].Pojazdy.rok_prod, Pojazdy.przebieg, Pojazdy.cena
FROM  [Auto_komis].Marki INNER JOIN  [Auto_komis].Modele
ON  [Auto_komis].Marki.ID_Marki= [Auto_komis].Modele.ID_Marki
INNER JOIN  [Auto_komis].Pojazdy
ON  [Auto_komis].Marki.ID_Marki= [Auto_komis].Pojazdy.ID_Marki
INNER JOIN  [Auto_komis].Kolory
ON  [Auto_komis].Pojazdy.ID_Koloru= [Auto_komis].Kolory.ID_Koloru

--³¹czenie tabel krzy¿owe: wypisanie klientaj jego nazwiska i imienia, kiedy odby³a siê transakcja na jaka kwotê i jakiego rodzaju by³a to transakcja
 
SELECT Klienci.Nazwisko, Klienci.Imie, Transakcje.data_tran, Transakcje.kwota, Transakcje.rodzaj_tran
FROM  [Auto_komis].Klienci CROSS JOIN  [Auto_komis].Transakcje

SELECT DISTINCT Marki.nazwa_marki, Modele.nazwa_modelu, Pojazdy.nr_rej, Kolory.nazwa_koloru, Pojazdy.rok_prod, Pojazdy.przebieg, Pojazdy.cena
FROM  [Auto_komis].Marki INNER JOIN [Auto_komis].Modele
ON Marki.ID_Marki=Modele.ID_Marki
INNER JOIN  [Auto_komis].Pojazdy
ON Marki.ID_Marki=Pojazdy.ID_Marki
INNER JOIN  [Auto_komis].Kolory
ON Pojazdy.ID_Koloru=Kolory.ID_Koloru
WHERE ID_Pojazdu<16


--PROCEDURY

CREATE PROCEDURE  [Auto_komis].Info_o_pojazdach
AS
SELECT Marki.nazwa_marki, Modele.nazwa_modelu, Pojazdy.nr_rej, Kolory.nazwa_koloru, Pojazdy.rok_prod, Pojazdy.przebieg, Pojazdy.cena
FROM Marki INNER JOIN Modele
ON Marki.ID_Marki=Modele.ID_Marki
INNER JOIN Pojazdy
ON Marki.ID_Marki=Pojazdy.ID_Marki
INNER JOIN Kolory
ON Pojazdy.ID_Koloru=Kolory.ID_Koloru
GO

EXEC Auto_komis.Info_o_pojazdach

CREATE PROCEDURE  [Auto_komis].Info_o_klientach
AS
SELECT Klienci.Nazwisko, Klienci.Imie, Transakcje.data_tran, Transakcje.kwota, Transakcje.rodzaj_tran
FROM  [Auto_komis].Klienci CROSS JOIN  [Auto_komis].Transakcje
GO

EXEC [Auto_komis].Info_o_klientach

-- procedura wstawiaj¹ca nowy pojazd

CREATE PROCEDURE Dodaj_Nowy_Pojazd
@idMarki int,
@idModelu int,
@idKoloru int,
@nr_rej nvarchar,
@nr_vin varchar,
@rok_prod DATE,
@przebieg int,
@poj_silnika int,
@data_rej DATE,
@cena int
AS
INSERT INTO [Auto_komis].[Pojazdy] (ID_Marki, ID_Modelu, ID_Koloru, nr_rej, nr_vin, rok_prod, przebieg, poj_silnika, data_rej, cena, data_przyjecia)
VALUES (@idMarki, @idModelu, @idKoloru, @nr_rej, @nr_vin, @rok_prod, @przebieg, @poj_silnika,@data_rej, @cena, GETDATE())
PRINT 'Dodano nowy pojazd'
GO

-- dodanie nowego pojazdu

EXEC Dodaj_Nowy_Pojazd 
@idMarki = 8,
@idModelu = 12,
@idKoloru = 6,
@nr_rej = 'DWR10RW',
@nr_vin = 'WQI0987N3344534',
@rok_prod = '2012-01-01',
@przebieg = 125008,
@poj_silnika = 1200,
@data_rej = '2012-01-30',
@cena = 46500

SELECT * FROM [Auto_komis].Pojazdy

-- WIDOKI

-- widok Auto nazwa marki i nazwa modelu

CREATE VIEW vMarka_Model AS
SELECT m.nazwa_marki, n.nazwa_modelu
FROM [Auto_komis].Marki AS m
LEFT OUTER JOIN [Auto_komis].Modele AS n
ON m.ID_Marki=n.ID_Marki

-- widok Klienci i redzaj transakcji

CREATE View vKlienci AS
SELECT k.Nazwisko, k.Imie, t.rodzaj_tran
FROM [Auto_komis].Klienci AS k
RIGHT OUTER JOIN [Auto_komis].Transakcje AS t
ON k.ID_Klienta=t.ID_Klienta

-- TRIGER

-- blokada kasowania transakcji

CREATE TRIGGER TR_Transakcje_kasowanie
ON [Auto_komis].Transakcje
INSTEAD OF DELETE
AS
PRINT 'Nie mo¿na kasowaæ transakcji !!!'

--test

DELETE FROM [Auto_komis].Transakcje WHERE ID_Transakcji = 1

-- rozmiar tabeli Pojazdy

EXEC sp_spaceused '[Auto_komis].[Pojazdy]'


-- statystyka

DBCC SHOW_STATISTICS('[Auto_komis].[Pojazdy]', [_WA_Sys_00000002_0EA330E9])

DBCC SHOW_STATISTICS('[Auto_komis].[Transakcje]', [_WA_Sys_00000005_182C9B23])


-- Transakcja

BEGIN TRANSACTION

SELECT @@TRANCOUNT

SELECT * FROM sys.dm_tran_locks
WHERE request_session_id = @@SPID


EXEC Dodaj_Nowy_Pojazd 
@idMarki = 5,
@idModelu = 10,
@idKoloru = 8,
@nr_rej = 'WWR10RW',
@nr_vin = 'WQI0987N3344534',
@rok_prod = '2013-06-01',
@przebieg = 25008,
@poj_silnika = 1600,
@data_rej = '2013-09-30',
@cena = 86500

COMMIT 

SELECT * FROM [Auto_komis].Pojazdy

-- tabela tymczasowa globalna

CREATE TABLE ##Tabela_Pojazdow
(
	 Model nvarchar(25),
	 Marka nvarchar(25),
	 Rok_produkcji DATE
)
INSERT INTO ##Tabela_Pojazdow (Model, Marka, Rok_produkcji) VALUES ('Ford', 'Sierra', '2000-09-01')
INSERT INTO ##Tabela_Pojazdow (Model, Marka, Rok_produkcji) VALUES ('Ford', 'Escort', '1991-03-01')
INSERT INTO ##Tabela_Pojazdow (Model, Marka, Rok_produkcji) VALUES ('Fiat', '125p', '1987-02-01')
INSERT INTO ##Tabela_Pojazdow (Model, Marka, Rok_produkcji) VALUES ('Mazda', '323', '1999-09-01')
INSERT INTO ##Tabela_Pojazdow (Model, Marka, Rok_produkcji) VALUES ('Toyota', 'Corolla', '2000-06-01')

SELECT * FROM ##Tabela_Pojazdow

-- Œrednia

SELECT AVG(kwota) FROM [Auto_komis].Transakcje

SELECT AVG(cena) FROM [Auto_komis].Pojazdy

SELECT 
	kwota,	
	COUNT(kwota) as Transakcje
FROM [Auto_komis].Transakcje
GROUP BY kwota 
ORDER BY kwota 

-- najdro¿szy pojazd

SELECT TOP 1 ID_Pojazdu, cena FROM [Auto_komis].Pojazdy
	WHERE ID_Pojazdu IN  (SELECT TOP 1 ID_Pojazdu  FROM [Auto_komis].Pojazdy ORDER BY cena DESC) ORDER BY cena ASC


SELECT cena,
CASE
    WHEN cena > 20000 THEN 'Cena powy¿ej 20000 z³'
    WHEN cena > 20000  THEN 'Cena powy¿ej 40000 z³'
    ELSE 'Cena do 10000 z³'
END AS Cena_Opis
FROM [Auto_komis].Pojazdy; 
