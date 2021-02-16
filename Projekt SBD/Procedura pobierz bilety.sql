USE Centrala_Lotnisko

ALTER PROCEDURE Pobierz_bilety
AS

BEGIN
DROP TABLE Centrala_Lotnisko.Centrala_Lotnisko.Baza_biletow
SELECT 
			[ID_Biletu]
			,[ID_Lotniska]
           ,[ID_Polaczenia]
           ,[data_wylotu]
           ,[data_zakupu]
           ,[cena_biletu]
INTO Centrala_Lotnisko.Centrala_Lotnisko.Baza_biletow

FROM [DOM-HP\SQL2].Lotnisko_Berlin.Lotnisko_Berlin.Baza_biletow

INSERT INTO Centrala_Lotnisko.Centrala_Lotnisko.Baza_biletow
			([ID_Biletu]
			,[ID_Lotniska]
           ,[ID_Polaczenia]
           ,[data_wylotu]
           ,[data_zakupu]
           ,[cena_biletu])

SELECT ID_Biletu, ID_Lotniska, ID_Polaczenia, data_wylotu, data_zakupu,cena_biletu

FROM [DOM-HP\SQL2].Lotnisko_Warszawa.Lotnisko_Warszawa.Baza_biletow

END
GO

BEGIN TRANSACTION

EXEC Pobierz_Bilety

COMMIT

SELECT * FROM Centrala_Lotnisko.Baza_biletow