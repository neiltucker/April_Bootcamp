IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name LIKE '%DatabaseMasterKey%') CREATE MASTER KEY ENCRYPTION BY PASSWORD='Pa$w0rdPa$w0rdPa$w0rdPa$w0rd' 
GO
IF NOT EXISTS (SELECT * FROM sys.database_credentials WHERE name LIKE '%CRD_BLOB%') CREATE DATABASE SCOPED CREDENTIAL CRD_BLOB WITH IDENTITY = 'SHARED ACCESS SIGNATURE',SECRET = 'CaHny4MhJ6qB0EKU4n4+JibWj7vPPiM+/aRpFsbuM4AF10kokPOGwBHvrBwtF7kmP56BxUuTrsT++ASt7M8UXg=='
GO
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name LIKE '%EDS_BLOB%') CREATE EXTERNAL DATA SOURCE EDS_BLOB WITH (TYPE = BLOB_STORAGE,LOCATION = 'https://in050007sa.blob.core.windows.net/55315',CREDENTIAL = CRD_BLOB)
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Employees') DROP TABLE Employees
GO 
CREATE TABLE [dbo].[Employees] (
[ID] INT CONSTRAINT [PK_InvoiceID] PRIMARY KEY,
[LastName] [nvarchar](50) NULL,
[FirstName] [nvarchar](50) NULL,
[HireDate] [nvarchar](50) NULL,
[HireTime] [nvarchar](50) NULL)

GO
BULK INSERT dbo.Employees 
FROM 'employees.csv' 
WITH 
(  
    DATA_SOURCE = 'EDS_BLOB', 
    FORMAT = 'CSV', 
    CODEPAGE = 65001, 
    FIRSTROW = 2, 
    TABLOCK 
)

