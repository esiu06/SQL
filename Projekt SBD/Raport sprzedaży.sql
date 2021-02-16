USE Centrala_Lotnisko

ALTER PROCEDURE Centrala_Lotnisko.Raport_sprzeda¿y @data date
AS
BEGIN
BEGIN TRAN
SELECT * FROM Centrala_Lotnisko.vBilety WHERE data_zakupu = @data ORDER BY data_wylotu ASC
SELECT COUNT(*) AS Ilosc_Biletow, sum(cena_biletu) AS Suma_sprzedazy FROM Centrala_Lotnisko.vBilety WHERE data_zakupu = @data
COMMIT TRAN
RETURN
END
GO

EXEC Centrala_Lotnisko.Raport_sprzeda¿y '2021-01-04'
GO



