IF (DB_ID('Lotnisko_Londyn_Heathrow') IS NULL)						
BEGIN
	CREATE DATABASE [Lotnisko_Londyn_Heathrow]							
	PRINT 'Utworzono bazê Lotnisko_Londyn_Heathrow'					
END ELSE
	PRINT 'Lotnisko_Londyn_Heathrow ju¿ istnieje'					
GO													

USE [Lotnisko_Londyn_Heathrow]										
GO

CREATE SCHEMA Lotnisko_Londyn_Heathrow
GO

IF OBJECT_ID (N'Bilety', N'U') IS NULL				
BEGIN
	CREATE TABLE [Lotnisko_Londyn_Heathrow].[Baza_biletow](
	
	[ID_Biletu] [int] IDENTITY(1,1) ,
	[ID_Lotniska] [int],
	[ID_Polaczenia] [int],
	[data_wylotu] date,
	[data_zakupu] DATE,
	[nr_miejsca] NUMERIC(3) CONSTRAINT MAX_nr_miejsca CHECK(nr_miejsca<=300),
	[cena] NUMERIC(7,2),
	[ID_Promocji] [int],
	[cena_biletu] NUMERIC(7,2),
	[Kasjer] [nvarchar](15),
			
	 CONSTRAINT [PK_Baza_biletow] PRIMARY KEY CLUSTERED 
	(
		[ID_Biletu] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	PRINT 'Utworzono tabelê Bilety'					
END ELSE											
    PRINT 'Tabela Bilety ju¿ istnieje'				
GO


IF OBJECT_ID (N'Promocja', N'U') IS NULL				
BEGIN
	CREATE TABLE [Lotnisko_Londyn_Heathrow].[Promocja](
	
	[ID_Promocji] [int] IDENTITY(1,1),
	[nazwa_promocji] [nvarchar](15),
	[wartosc_promocji] int,
	CONSTRAINT [PK_Promocja] PRIMARY KEY CLUSTERED 
	(
		[ID_Promocji] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Utworzono tabelê Promocja'					
END ELSE											
    PRINT 'Tabela Promocja ju¿ istnieje'				
GO	

----------------- Procedura Dodania promocji ----------------------------------------

CREATE PROCEDURE [Lotnisko_Londyn_Heathrow].Dodaj_promocje
@nazwa_promocji nvarchar(15),
@wartosc_promocji int
AS
BEGIN
BEGIN TRAN
INSERT INTO [Lotnisko_Londyn_Heathrow].[Promocja](nazwa_promocji, wartosc_promocji)
VALUES (@nazwa_promocji, @wartosc_promocji)
COMMIT TRAN
RETURN
END
GO


EXEC [Lotnisko_Londyn_Heathrow].Dodaj_promocje 'Senior', 30

------------------ Procedura zmiany wartoœci dla wybranej promocji ------------------

CREATE PROCEDURE [Lotnisko_Londyn_Heathrow].Zmien_promocje 
@nazwa_promocji nvarchar(15),
@wartosc_promocji int

AS
BEGIN
BEGIN TRAN
UPDATE [Lotnisko_Londyn_Heathrow].[Promocja]
SET wartosc_promocji = @wartosc_promocji
WHERE nazwa_promocji = @nazwa_promocji
COMMIT TRAN
RETURN
END
GO

EXEC [Lotnisko_Londyn_Heathrow].Zmien_promocje 'Junior', 20

--------------------- Procedura dodania nowego biletu --------------------

ALTER PROCEDURE [Lotnisko_Londyn_Heathrow].Dodaj_bilet
@ID_Lotniska int,
@ID_Polaczenia int,
@data_wylotu date,
@data_zakupu date,
@nr_miejsca NUMERIC(3),
@cena float,
@ID_Promocji int,
@kasjer [nvarchar](50),
@Nazwisko [nvarchar](50),
@Imie [nvarchar](50),
@pesel NUMERIC(11),
@miasto_zam [nvarchar](50),
@ID_Kraju int
AS
DECLARE 
@cena_biletu float,
@promocja int
BEGIN
--BEGIN TRAN
SELECT 
@promocja = wartosc_promocji FROM Lotnisko_Londyn_Heathrow.promocja 
WHERE ID_Promocji = @ID_Promocji
SET @cena_biletu = @cena - (@cena * @promocja * 0.01)
INSERT INTO [Lotnisko_Londyn_Heathrow].[Baza_biletow]
   ([ID_Lotniska]
           ,[ID_Polaczenia]
           ,[data_wylotu]
           ,[data_zakupu]
		   ,[nr_miejsca]
           ,[cena]
           ,[ID_Promocji]
           ,[cena_biletu]
           ,[Kasjer]
		   ,[Nazwisko]
		   ,[Imie]
		   ,[pesel]
		   ,[miasto_zam]
		   ,[ID_Kraju])
 VALUES
           (@ID_Lotniska,
		   @ID_Polaczenia,
		   @data_wylotu,
		   @data_zakupu,
		   @nr_miejsca,
		   @cena,
		   @ID_Promocji,
		   @cena_biletu,
		   @kasjer,
		   @Nazwisko,
		   @Imie,
		   @pesel,
		   @miasto_zam,
		   @ID_Kraju)

INSERT INTO [DOM-HP\SQLEXPRESS1].Centrala_Lotnisko.Centrala_Lotnisko.Pasazer
	(Nazwisko, Imie, pesel, miasto_zam, ID_Kraju)
	VALUES (@Nazwisko, @Imie, @pesel, @miasto_zam, @ID_Kraju)	

IF (@nr_miejsca<300)             
PRINT 'Dodano nowy bilet ' + 'Dodano nowego pasa¿era'
ELSE
PRINT 'BRAK miejsc w samolocie'
--COMMIT TRAN
RETURN
END
GO


EXEC [Lotnisko_Londyn_Heathrow].Dodaj_bilet 1, 7, '2021-01-11', '2021-01-19', 005, 6900, 2, 'Kasjer 1', 'B³aszczykowski', 'Kuba', '90876543215', 'Kraków', 1


SELECT * FROM [DOM-HP\SQLEXPRESS1].Centrala_Lotnisko.Centrala_Lotnisko.Pasazer

SELECT * FROM [Lotnisko_Londyn_Heathrow].[Promocja]

SELECT * FROM [Lotnisko_Londyn_Heathrow].[Baza_biletow]

SELECT * FROM [DOM-HP\SQLEXPRESS1].[Centrala_Lotnisko].[Centrala_Lotnisko].[Polaczenia]

SELECT * FROM [DOM-HP\SQLEXPRESS1].[Centrala_Lotnisko].[Centrala_Lotnisko].[vPo³¹czenia]

