USE [Lotnisko_Berlin]
GO


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
BEGIN TRANSACTION
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
		             
PRINT 'Dodano nowy bilet '
COMMIT TRANSACTION
RETURN
END
GO


ALTER PROCEDURE Wyslij_bilety
AS
BEGIN
BEGIN TRANSACTION 
SELECT 
			[ID_Biletu]
			,[ID_Lotniska]
           ,[ID_Polaczenia]
           ,[data_wylotu]
           ,[data_zakupu]
           ,[cena_biletu]

INTO [DOM-HP\SQLEXPRESS1].Centrala_Lotnisko.Baza_biletow
FROM [Lotnisko_Berlin].Baza_biletow;
COMMIT TRAN
RETURN
END
GO

EXEC [Lotnisko_Berlin].Dodaj_bilet 1, 1, '2021-01-29', '2021-01-07', 2600, 2, 'Kasjer 1'

EXEC Wyslij_bilety

SELECT * FROM [DOM-HP\SQLEXPRESS1].Centrala_Lotnisko.Centrala_Lotnisko.Kraje



INSERT INTO [DOM-HP\SQLEXPRESS1].Centrala_Lotnisko.Centrala_Lotnisko.Kraje(nazwa_kraju)
VALUES ('Austria')
GO

ALTER PROC Dodaj_nowy_kraj @nazwa_kraju nvarchar(25)
AS
BEGIN

INSERT INTO [DOM-HP\SQLEXPRESS1].Centrala_Lotnisko.Centrala_Lotnisko.Kraje(nazwa_kraju)
VALUES (@nazwa_kraju)

RETURN
END
GO

EXEC dbo.Dodaj_nowy_kraj 'Cypr'

SELECT SUSER_NAME() AS LoginName, USER_NAME() AS UserName