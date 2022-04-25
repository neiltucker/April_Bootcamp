USE master
GO
EXEC sp_configure 'show advanced', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'contained database authentication', 1
GO
RECONFIGURE
GO

ALTER DATABASE [Demo6] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO

SELECT containment,name FROM sys.databases
GO

USE [Demo6]
GO

CREATE USER User1 WITH PASSWORD = 'Pa$$w0rd'
GO

ALTER ROLE [db_datareader] ADD MEMBER [User1]
GO