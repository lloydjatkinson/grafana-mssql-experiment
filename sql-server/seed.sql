-- Check if the 'Finance' database exists and create it if it does not
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Finance')
BEGIN
    CREATE DATABASE Finance;
    PRINT 'Database created: Finance';
END
GO

-- Switch to the 'Finance' database
USE Finance;
GO

-- Check if the 'Sales' table exists and create it if it does not
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Sales')
BEGIN
    CREATE TABLE Sales (
        ID INT PRIMARY KEY IDENTITY(1,1),
        Price DECIMAL(10, 2),
        Quantity INT,
        StoreLocation VARCHAR(100),
        PurchaseDateTime DATETIME
    );
    PRINT 'Table created: Sales';
END
GO

-- Declare variables to hold dynamic data for insertion
DECLARE @Count INT = 1;
DECLARE @MaxCount INT = 100;
DECLARE @RandomPrice DECIMAL(10, 2);
DECLARE @RandomQuantity INT;
DECLARE @RandomLocation VARCHAR(100);
DECLARE @RandomDate DATETIME;

-- Define a list of store locations
DECLARE @Locations TABLE (Location VARCHAR(100));
INSERT INTO @Locations VALUES ('London'), ('Manchester'), ('Birmingham'), ('Liverpool'), ('Bristol'), ('Newcastle'), ('Leeds'), ('Sheffield'), ('Norwich'), ('Oxford');

-- Insert data in a loop
WHILE @Count <= @MaxCount
BEGIN
    -- Generate random data
    SET @RandomPrice = ROUND((RAND() * 100) + 0.99, 2); -- Prices from £0.99 to £100.99
    SET @RandomQuantity = ROUND((RAND() * 10) + 1, 0); -- Quantities from 1 to 10
    SET @RandomDate = DATEADD(DAY, ROUND((RAND() * DATEDIFF(DAY, '2023-01-01', GETDATE())), 0), '2023-01-01'); -- Random date from Jan 1, 2023 to now
    
    -- Select a random location from the table of locations
    SELECT TOP 1 @RandomLocation = Location FROM @Locations ORDER BY NEWID(); -- Randomly order the locations and pick the top one

    -- Insert the generated data into the Sales table
    INSERT INTO Sales (Price, Quantity, StoreLocation, PurchaseDateTime)
    VALUES (@RandomPrice, @RandomQuantity, @RandomLocation, @RandomDate);

    -- Increment the counter
    SET @Count = @Count + 1;
END
PRINT '100 rows inserted into Sales table';
GO
