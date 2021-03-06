CREATE PROCEDURE [Lotnisko_Warszawa].Dodaj_bilet
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
@promocja = wartosc_promocji FROM Lotnisko_Warszawa.promocja 
WHERE ID_Promocji = @ID_Promocji
SET @cena_biletu = @cena - (@cena * @promocja * 0.01)
INSERT INTO [Lotnisko_Warszawa].[Baza_biletow]
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
COMMIT TRAN
RETURN
END
GO