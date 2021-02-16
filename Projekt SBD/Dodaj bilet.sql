CREATE PROCEDURE [Lotnisko_Londyn_Heathrow].Dodaj_bilet
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
