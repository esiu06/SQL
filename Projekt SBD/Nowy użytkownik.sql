USE [master]

CREATE LOGIN Kasjerzy
WITH PASSWORD=N'esiuesiu1',
DEFAULT_DATABASE=master, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER LOGIN [Kasjerzy] DISABLE
GO

USE Lotnisko_Berlin
GO

CREATE ROLE Kasjer_1 AUTHORIZATION db_owner
GO

CREATE USER Kasjer_1 FOR LOGIN Kasjerzy
GO

EXEC sp_addrolemember 'Kasjer_1', 'sysadmin'
GO



CREATE ROLE Kasjer_sta¿ysta

GRANT SELECT TO Kasjer_sta¿ysta

ALTER ROLE db_owner ADD MEMBER Kasjer_1
GO

SELECT DATENAME(dw, GETDATE()) -- pobiera nazwe dnia tygodnia
SELECT DATENAME(m, GETDATE()) -- pobiera nazwe miesiaca

SELECT SUSER_NAME() AS LoginName, USER_NAME() AS UserName

