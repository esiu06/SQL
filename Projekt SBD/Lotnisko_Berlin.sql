IF (DB_ID('Lotnisko_Berlin') IS NULL)						
BEGIN
	CREATE DATABASE Lotnisko_Berlin							
	PRINT 'Utworzono bazê Lotnisko_Berlin'					
END ELSE
	PRINT 'Lotnisko_Berlin ju¿ istnieje'					
GO													

USE [Lotnisko_Berlin]										
GO

CREATE SCHEMA Lotnisko_Berlin 
GO

IF OBJECT_ID (N'Bilety', N'U') IS NULL				
BEGIN
	CREATE TABLE [Lotnisko_Berlin].[Baza_biletow](
	
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
	CREATE TABLE [Lotnisko_Berlin].[Promocja](
	
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

CREATE PROCEDURE [Lotnisko_Berlin].Dodaj_promocje
@nazwa_promocji nvarchar(15),
@wartosc_promocji int
AS
BEGIN
BEGIN TRAN
INSERT INTO [Lotnisko_Berlin].[Promocja](nazwa_promocji, wartosc_promocji)
VALUES (@nazwa_promocji, @wartosc_promocji)
COMMIT TRAN
RETURN
END
GO


EXEC [Lotnisko_Berlin].Dodaj_promocje 'Loty', 10

------------------ Procedura zmiany wartoœci dla wybranej promocji ------------------

CREATE PROCEDURE [Lotnisko_Berlin].Zmien_promocje 
@nazwa_promocji nvarchar(15),
@wartosc_promocji int

AS
BEGIN
BEGIN TRAN
UPDATE [Lotnisko_Berlin].[Promocja]
SET wartosc_promocji = @wartosc_promocji
WHERE nazwa_promocji = @nazwa_promocji
COMMIT TRAN
RETURN
END
GO

EXEC [Lotnisko_Berlin].Zmien_promocje 'Junior', 20
GO

--------------------- Procedura dodania nowego biletu --------------------

ALTER PROCEDURE [Lotnisko_Berlin].Dodaj_bilet
@ID_Lotniska int,
@ID_Polaczenia int,
@data_wylotu date,
@data_zakupu date,
@cena float,
@ID_Promocji int,
@kasjer [nvarchar](50)
AS
DECLARE 
@cena_biletu float,
@promocja int
BEGIN
BEGIN TRAN
SELECT 
@promocja = wartosc_promocji FROM Lotnisko_Berlin.promocja 
WHERE ID_Promocji = @ID_Promocji
SET @cena_biletu = @cena - (@cena * @promocja * 0.01)
INSERT INTO [Lotnisko_Berlin].[Baza_biletow]
   ([ID_Lotniska]
           ,[ID_Polaczenia]
           ,[data_wylotu]
           ,[data_zakupu]
           ,[cena]
           ,[ID_Promocji]
           ,[cena_biletu]
           ,[Kasjer])
 VALUES
           (@ID_Lotniska,
		   @ID_Polaczenia,
		   @data_wylotu,
		   @data_zakupu,
		   @cena,
		   @ID_Promocji,
		   @cena_biletu,
		   @kasjer)
UPDATE [Lotnisko_Berlin].[Baza_biletow]
SET nr_miejsca = nr_miejsca + 1           
PRINT 'Dodano nowy bilet '
COMMIT TRAN
RETURN
END
GO

EXEC [Lotnisko_Berlin].Dodaj_bilet 1, 1, '2021-01-19', '2021-01-09', 7600, 3, 'Kasjer 2'


SELECT * FROM [Lotnisko_Berlin].[Promocja]


SELECT * FROM [Lotnisko_Berlin].[Baza_biletow]

SELECT SUSER_NAME() AS LoginName, USER_NAME() AS UserName