-- 1.Load dataset into a SQL database. 
-- Uploaded on sql workbench where the results got by running below queries are updated in the query result folder
SELECT COUNT(*) FROM orders;

-- 2.Explore table (schema, sample data)
desc orders;
SELECT * FROM orders LIMIT 10;

--  3.Apply WHERE filters (region, category, date, sales).
SELECT * FROM orders 
WHERE Region = 'West' 
  AND Category = 'Technology'
  AND STR_TO_DATE(`Order Date`, '%m/%d/%Y') >= '2015-01-01'
  AND Sales > 500;


-- 4.Use GROUP BY for aggregations (sales, quantity, averages).
-- Calculate total quantity and average sales per Sub-Category
SELECT 
    `Sub-Category`, 
    SUM(Quantity) AS Total_Units, 
    AVG(Sales) AS Avg_Transaction_Value
FROM orders
GROUP BY `Sub-Category`;


-- 5.Sort and limit results (top products, top categories). 
SELECT 
    Category, 
    SUM(Sales) AS Total_Revenue
FROM orders
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- 6.Solve use cases (monthly trends, top customers, duplicates). 
-- A. Monthly Sales Trend
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS Order_Month,
    SUM(Sales) AS Monthly_Sales
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;

-- B. Top 10 Customers
SELECT 
    `Customer Name`,
    SUM(Sales) AS Total_Spent
FROM orders
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Spent DESC
LIMIT 10;

-- C. Check for duplicate rows based on Order ID
SELECT `Row ID`, COUNT(*) 
FROM orders 
GROUP BY `Row ID` 
HAVING COUNT(*) > 1;

-- 7.Validate results (row counts, data quality).
SELECT 
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS Missing_Order_IDs,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_IDs,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Missing_Sales_Data
FROM orders;