SELECT *
FROM [Tutorial].[dbo].[Human_Resources];

-- Quering Dataset to confirm number of entries-- 
SELECT DISTINCT COUNT (id)AS TOTAL_NUMBER
FROM [Tutorial].[dbo].[Human_Resources];

-- Quering Dataset to confirm distinct number of employees--
SELECT DISTINCT *
FROM [Tutorial].[dbo].[Human_Resources]

-- Removing Duplicates (using UNION)
SELECT *
FROM [Tutorial].[dbo].[Human_Resources]
UNION
SELECT *
FROM [Tutorial].[dbo].[Human_Resources]
ORDER BY id;

-- Create Temp Table
CREATE TABLE #temp_table (
id nvarchar(255),
first_name nvarchar(255),
last_name nvarchar(255),
birthdate datetime,
gender nvarchar(255),
race nvarchar(255),
department nvarchar(255),
jobtitle nvarchar(255),
location nvarchar(255),
hire_date datetime,
termdate nvarchar(255),
location_city nvarchar(255),
location_state nvarchar(255),
);

-- Insert distinct rows from Human Resources$ the temporary table
INSERT INTO #temp_table
SELECT *
FROM (
SELECT *
FROM [Tutorial].[dbo].[Human_Resources]
UNION
SELECT *
FROM [Tutorial].[dbo].[Human_Resources]
)
AS unique_results;

-- temporary table after duplicate records have been removed
SELECT * FROM #temp_table;

-- Truncate or delete the original table
TRUNCATE TABLE [Tutorial].[dbo].[Human_Resources]

-- Insert distinct rows from the temp_table back into the original table
INSERT INTO [Tutorial].[dbo].[Human_Resources] 
SELECT * FROM #temp_table;

-- drop the temporary table after use
DROP TABLE #temp_table;

-- view the dataset after duplicates removed
SELECT *
FROM [Tutorial].[dbo].[Human_Resources]

-- Insert a new column for age
ALTER TABLE [Tutorial].[dbo].[Human_Resources]
ADD age INT

-- populate values for ages
UPDATE [Tutorial].[dbo].[Human_Resources]
SET age = DATEDIFF(YEAR, birthdate, GETDATE());

SELECT *
FROM [Tutorial].[dbo].[Human_Resources]


