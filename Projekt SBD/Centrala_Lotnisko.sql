IF (DB_ID('Centrala_Lotnisko') IS NULL)						
BEGIN
	CREATE DATABASE Centrala_Lotnisko							
	PRINT 'Utworzono bazê Centrala_Lotnisko'					
END ELSE
	PRINT 'Centrala_Lotnisko ju¿ istnieje'					
GO													

USE [Centrala_Lotnisko]										
GO

CREATE SCHEMA Centrala_Lotnisko 
GO


IF OBJECT_ID (N'Kraje', N'U') IS NULL				
BEGIN
	CREATE TABLE [Centrala_Lotnisko].[Kraje](
	
	[ID_Kraju] [int] IDENTITY(1,1),
	[nazwa_kraju] [nvarchar](15),
	CONSTRAINT [PK_Kraje] PRIMARY KEY CLUSTERED 
	(
		[ID_Kraju] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

		PRINT 'Utworzono tabelê Kraje'					
END ELSE											
    PRINT 'Tabela Kraje ju¿ istnieje'				
GO	


IF OBJECT_ID (N'Operator', N'U') IS NULL				
BEGIN
	CREATE TABLE [Centrala_Lotnisko].[Operator](
	
	[ID_Operatora] [int] IDENTITY(1,1),
	[nazwa_operatora] [nvarchar](15),
	[ID_Kraju] [int],
	CONSTRAINT [PK_Operator] PRIMARY KEY CLUSTERED 
	(
		[ID_Operatora] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Operator'					
END ELSE											
    PRINT 'Tabela Operator ju¿ istnieje'				
GO	

IF OBJECT_ID (N'Samolot', N'U') IS NULL				
BEGIN
	CREATE TABLE [Centrala_Lotnisko].[Samolot](
	
	[ID_Samolotu] [int] IDENTITY(1,1),
	[model_samolotu] [nvarchar](15),
	[liczba_miejsc] NUMERIC(3) CHECK (liczba_miejsc >0),
	CONSTRAINT [PK_Samolot] PRIMARY KEY CLUSTERED 
	(
		[ID_Samolotu] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Samolot'					
END ELSE											
    PRINT 'Tabela Samolot ju¿ istnieje'				
GO	

IF OBJECT_ID (N'Porty_lotnicze', N'U') IS NULL				
BEGIN
	CREATE TABLE [Centrala_Lotnisko].[Porty_lotnicze](
	
	[ID_Portu] [int] IDENTITY(1,1),
	[ID_Kraju] [int],
	[nazwa_portu] [nvarchar](15),
	CONSTRAINT [PK_Porty_lotnicze] PRIMARY KEY CLUSTERED 
	(
		[ID_Portu] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Porty_lotnicze'					
END ELSE											
    PRINT 'Tabela Porty lotnicze ju¿ istnieje'				
GO	

IF OBJECT_ID (N'Pasazer', N'U') IS NULL				
BEGIN
	CREATE TABLE [Centrala_Lotnisko].[Pasazer](
	
	[ID_Pasazera] [int]IDENTITY(1,1),
	[Nazwisko] [nvarchar](50),
	[Imie] [nvarchar](25),
	[pesel] NUMERIC(11),
	[miasto_zam] [nvarchar](25),
	[ID_Kraju] [int],
			
	 CONSTRAINT [PK_Pasazer] PRIMARY KEY CLUSTERED 
	(
		[ID_Pasazera] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	PRINT 'Utworzono tabelê Pasazer'					
END ELSE											
    PRINT 'Tabela Pasazer ju¿ istnieje'				
GO

IF OBJECT_ID (N'Polaczenia', N'U') IS NULL				
BEGIN
	CREATE TABLE [Centrala_Lotnisko].[Polaczenia](
	
	[ID_Polaczenia] [int] IDENTITY(1,1) NOT NULL,
	[ID_Operatora] [int],
	[ID_Samolotu] [int],
	[ID_Latnisko_wylot] [int],
	[ID_Lotnisko_przylot] [int],
	
	CONSTRAINT [PK_Polaczenia] PRIMARY KEY CLUSTERED 
	(
		[ID_Polaczenia] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Po³¹czenia'					
END ELSE											
    PRINT 'Tabela Po³¹czenia ju¿ istnieje'				
GO	

IF OBJECT_ID (N'Bilety', N'U') IS NULL				
BEGIN
	CREATE TABLE [Centrala_Lotnisko].[Baza_biletow](
	
	[ID_Biletu] [int] IDENTITY(1,1) ,
	[ID_Lotniska] [int],
	[ID_Polaczenia] [int],
	[data_wylotu] date,
	[data_zakupu] DATE,
	[cena] NUMERIC(7,2),
			
	 CONSTRAINT [PK_Baza_biletow] PRIMARY KEY CLUSTERED 
	(
		[ID_Biletu] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	PRINT 'Utworzono tabelê Bilety'					
END ELSE											
    PRINT 'Tabela Bilety ju¿ istnieje'				
GO

--Pod³¹czenie serwera zewnêtrznego

EXEC sp_addlinkedserver 'DOM-HP\SQL2'
GO 


--Procedura pobrania sprzedanych biletów z lotnisk

ALTER PROCEDURE Centrala_Lotnisko.Pobierz_bilety
AS
BEGIN
--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
DROP TABLE Centrala_Lotnisko.Centrala_Lotnisko.Baza_biletow
SELECT [ID_Biletu]
		,[ID_Lotniska]
        ,[ID_Polaczenia]
        ,[data_wylotu]
        ,[data_zakupu]
        ,[cena_biletu]
		,[Imie]
		,[Nazwisko]
INTO Centrala_Lotnisko.Centrala_Lotnisko.Baza_biletow

FROM [DOM-HP\SQL2].Lotnisko_Berlin.Lotnisko_Berlin.Baza_biletow

INSERT INTO Centrala_Lotnisko.Centrala_Lotnisko.Baza_biletow
			([ID_Biletu]
			,[ID_Lotniska]
           ,[ID_Polaczenia]
           ,[data_wylotu]
           ,[data_zakupu]
           ,[cena_biletu]
		   ,[Imie]
		   ,[Nazwisko])

SELECT ID_Biletu, ID_Lotniska, ID_Polaczenia, data_wylotu, data_zakupu,cena_biletu, Imie, Nazwisko

FROM [DOM-HP\SQL2].Lotnisko_Warszawa.Lotnisko_Warszawa.Baza_biletow

INSERT INTO Centrala_Lotnisko.Centrala_Lotnisko.Baza_biletow
			([ID_Biletu]
			,[ID_Lotniska]
           ,[ID_Polaczenia]
           ,[data_wylotu]
           ,[data_zakupu]
           ,[cena_biletu]
		   ,[Imie]
		   ,[Nazwisko])

SELECT ID_Biletu, ID_Lotniska, ID_Polaczenia, data_wylotu, data_zakupu,cena_biletu, Imie, Nazwisko

FROM [DOM-HP\SQL2].[Lotnisko_Londyn_Heathrow].Lotnisko_Londyn_Heathrow.Baza_biletow

COMMIT TRANSACTION
RETURN
END
GO

EXEC Centrala_Lotnisko.Pobierz_Bilety



SELECT * FROM Centrala_Lotnisko.Baza_biletow

--Procedura dodania nowego pasa¿era

ALTER PROCEDURE Centrala_Lotnisko.Dodaj_pasazera
@Nazwisko [nvarchar](50),
@Imie [nvarchar](50),
@pesel [nchar](11),
@miasto_zam [nvarchar](50),
@ID_Kraju [int]
AS
BEGIN
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
INSERT INTO Centrala_Lotnisko.Pasazer
	(
	 Nazwisko,
	 Imie,
	 pesel,
	 miasto_zam,
	 ID_Kraju)
VALUES
	(
	 @Nazwisko,
	 @Imie,
	 @pesel,
	 @miasto_zam,
	 @ID_Kraju)
PRINT 'Dodano pasa¿era ' + @Nazwisko
COMMIT TRANSACTION
RETURN
END
GO



EXEC Centrala_Lotnisko.Dodaj_pasazera
@Nazwisko = 'Messi',
@Imie = 'Leo',
@pesel = '12345678966',
@miasto_zam = 'Barcelona',
@ID_Kraju = 6
GO


SELECT * FROM Centrala_Lotnisko.Pasazer

--Procedura dodania nowego po³¹czenia

ALTER PROCEDURE Centrala_Lotnisko.Dodaj_polaczenie
@ID_Operatora int,
@ID_Lotniska_wylot int,
@ID_Lotniska_przylot int

AS
BEGIN
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
INSERT INTO Centrala_Lotnisko.Polaczenia
	(ID_Operatora,
	 ID_Lotnisko_wylot,
	 ID_Lotnisko_przylot
	 )
VALUES
	(@ID_Operatora,
	 @ID_Lotniska_wylot,
	 @ID_Lotniska_Przylot
	 )
PRINT 'Dodano nowe po³¹czenie' 
COMMIT TRANSACTION
RETURN
END
GO

ALTER VIEW [Centrala_Lotnisko].[vPo³¹czenia]
AS
SELECT n.ID_Polaczenia,
		o.nazwa_operatora,
		l.nazwa_portu wylot,
		(SELECT nazwa_portu FROM Centrala_Lotnisko.Porty_lotnicze WHERE ID_Portu = n.ID_Lotnisko_przylot )przylot
FROM
Centrala_Lotnisko.Operator o,
Centrala_Lotnisko.Polaczenia n,
Centrala_Lotnisko.Porty_lotnicze l
WHERE
o.ID_OPeratora = n.ID_Operatora AND
l.ID_Portu = n.ID_Lotnisko_wylot
GO


SELECT * FROM [Centrala_Lotnisko].Polaczenia


SELECT * FROM [Centrala_Lotnisko].vPo³¹czenia


ALTER VIEW [Centrala_Lotnisko].[vBilety]
AS
SELECT b.ID_Biletu,
		l.nazwa_portu,
		b.ID_Polaczenia,
		l.nazwa_portu wylot,
		(SELECT nazwa_portu FROM Centrala_Lotnisko.Porty_lotnicze WHERE ID_Portu = p.ID_Lotnisko_przylot )przylot,
		b.data_wylotu,
		b.data_zakupu,
		b.cena_biletu
		--b.Imie,
		--b.Nazwisko
FROM Centrala_Lotnisko.Baza_biletow b,
	Centrala_Lotnisko.Porty_lotnicze l,
	Centrala_Lotnisko.Polaczenia p
WHERE l.ID_Portu = b.ID_Lotniska AND
	
	p.ID_Polaczenia = b.ID_Polaczenia 
GO


SELECT * FROM [Centrala_Lotnisko].vBilety

EXEC Centrala_Lotnisko.Pobierz_bilety



