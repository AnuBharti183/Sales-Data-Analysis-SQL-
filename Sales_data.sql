
SELECT * 
FROM Sales_Data
-------------------------------------------------------------------------------
-- Checking data for the null values

SELECT
SUM(CASE WHEN [Order ID] IS NULL THEN 1 ELSE 0 END) AS Order_ID_null,
SUM(CASE WHEN [Order Date] IS NULL THEN 1 ELSE 0 END) AS Order_date_null,
SUM(CASE WHEN [Ship Date] IS NULL THEN 1 ELSE 0 END) AS Ship_date_null,
SUM(CASE WHEN EmailID IS NULL THEN 1 ELSE 0 END) AS Email_null,
SUM(CASE WHEN Geography IS NULL THEN 1 ELSE 0 END) AS Geaography_null,
SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Category_null,
SUM(CASE WHEN [Product Name] IS NULL THEN 1 ELSE 0 END) AS product_name_null,
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Sales_null,
SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_null,
SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS profit_null
FROM Sales_Data


------------------------------------------------------------------------------
-- CLeaning Data


ALTER TABLE Sales_Data
ADD  Order_date DATE

UPDATE Sales_Data
SET Order_date = CONVERT(DATE, [Order Date])

ALTER TABLE Sales_Data
ADD Ship_date DATE 

UPDATE Sales_Data
SET Ship_date = CONVERT(DATE, [Ship Date])



-------------------------------------------------------------------------------
-- DROP unnecessary COLUMNS


ALTER TABLE Sales_Data
DROP COLUMN [Order Date]





ALTER TABLE Sales_Data
ADD Country VARCHAR(20)

UPDATE Sales_Data
SET Country =
    CASE 
        WHEN CHARINDEX(',', Geography) > 0 
        THEN LTRIM(RTRIM(PARSENAME(REPLACE(Geography, ',', '.'), 3)))
        ELSE Geography 
    END FROM Sales_Data






ALTER TABLE Sales_Data
ADD State VARCHAR(20)

UPDATE Sales_Data
SET State = 
 CASE 
        WHEN LEN(Geography) - LEN(REPLACE(Geography, ',', '')) >= 2
        THEN LTRIM(RTRIM(PARSENAME(REPLACE(Geography, ',', '.'), 1)))
        ELSE NULL 
    END 
FROM Sales_Data;






ALTER TABLE Sales_Data
ADD City VARCHAR(20)
 
UPDATE Sales_Data
SET City =
 CASE 
        WHEN LEN(Geography) - LEN(REPLACE(Geography, ',', '')) >= 1
        THEN LTRIM(RTRIM(PARSENAME(REPLACE(Geography, ',', '.'), 2)))
        ELSE NULL 
    END FROM Sales_Data



-------------------------------------------------------------------------------   
-- STORED PROCEDURE to fetch top 3 profitable categories

  CREATE PROCEDURE SPCategory
  AS 
  BEGIN 
        SELECT TOP 3 Category, SUM(Profit)
        FROM Sales_Data
        GROUP BY Category
        ORDER BY SUM(Profit) DESC
       
  END

  EXEC SPCategory




  

  







 

