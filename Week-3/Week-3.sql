-- Step - 1: Setup Data
-- 2.a Create Customers Dimension Table
CREATE TABLE customers AS 
SELECT DISTINCT 
    `Customer ID`, 
    `Customer Name`
FROM superstore_raw;

-- 2.b Create Orders Fact Table
CREATE TABLE orders AS 
SELECT 
    `Row ID`, 
    `Order ID`, 
    `Order Date`, 
    `Customer ID`, 
    `Product ID`, 
    CAST(Sales AS DECIMAL(10,2)) AS Sales, 
    Quantity
FROM superstore_raw;

-- 2.c Create Products Dimension Table
CREATE TABLE products AS 
SELECT DISTINCT 
    `Product ID`, 
    `Product Name`, 
    Category, 
    `Sub-Category`
FROM superstore_raw;

-- Step-2: Perform required queries

-- 2.1 Find all orders where sales are greater than the average sales (Subquery)
SELECT `Order ID`, Sales 
FROM orders 
WHERE Sales > (
    SELECT AVG(Sales) FROM orders
);

-- 2.2 Find the highest sales order for each customer (Subquery)
SELECT 
    o1.`Customer ID`, 
    o1.`Order ID`, 
    o1.Sales 
FROM orders o1
JOIN (
    -- Subquery
    SELECT `Customer ID`, MAX(Sales) AS MaxSales
    FROM orders
    GROUP BY `Customer ID`
) o2 
  ON o1.`Customer ID` = o2.`Customer ID` 
 AND o1.Sales = o2.MaxSales;

-- 2.3  Calculate total sales for each customer (CTE)
WITH CustomerTotals AS (
    SELECT `Customer ID`, SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
)
SELECT * FROM CustomerTotals;

-- 2.4 Find customers whose total sales are above average (CTE + Subquery)
WITH CustomerTotals AS (
    SELECT `Customer ID`, SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
)
SELECT `Customer ID`, Total_Sales 
FROM CustomerTotals
WHERE Total_Sales > (
    SELECT AVG(Total_Sales) FROM CustomerTotals
);

-- 2.5 Rank all customers based on total sales (Window Function)

SELECT 
    `Customer ID`, 
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM orders
GROUP BY `Customer ID`;

-- 2.6 Assign row numbers to each order within a customer (Window Function + PARTITION BY)
SELECT 
    `Customer ID`, 
    `Order ID`, 
    `Order Date`,
    ROW_NUMBER() OVER (PARTITION BY `Customer ID` ORDER BY `Order Date` ASC) AS Customer_Order_Sequence
FROM orders;

-- 2.7 Display top 3 customers based on total sales (Window Function)
WITH RankedCustomers AS (
    SELECT 
        `Customer ID`, 
        SUM(Sales) AS Total_Sales,
        DENSE_RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
    FROM orders
    GROUP BY `Customer ID`
)
SELECT * FROM RankedCustomers WHERE Sales_Rank <= 3;

-- Step-3 Final combined query
WITH CustomerSales AS (
    SELECT 
        `Customer ID`, 
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
)
SELECT 
    c.`Customer Name`, 
    cs.Total_Sales,
    RANK() OVER (ORDER BY cs.Total_Sales DESC) AS Customer_Rank
FROM CustomerSales cs
JOIN customers c ON cs.`Customer ID` = c.`Customer ID`;


-- Mini Project: Customer Sales Insights
-- 1. Top 5 customers
SELECT c.`Customer Name`, SUM(o.Sales) AS Total_Sales
FROM orders o
JOIN customers c ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer ID`, c.`Customer Name`
ORDER BY Total_Sales DESC 
LIMIT 5;

-- 2. Bottom 5 customers
SELECT c.`Customer Name`, SUM(o.Sales) AS Total_Sales
FROM orders o
JOIN customers c ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer ID`, c.`Customer Name`
ORDER BY Total_Sales ASC 
LIMIT 5;

-- 3. Customer with only one order
SELECT c.`Customer Name`, COUNT(DISTINCT o.`Order ID`) AS Total_Unique_Orders
FROM orders o
JOIN customers c ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer ID`, c.`Customer Name`
HAVING COUNT(DISTINCT o.`Order ID`) = 1;

-- 4. customer having above average sales
WITH CustomerSales AS (
    SELECT c.`Customer Name`, SUM(o.Sales) AS Total_Sales
    FROM orders o
    JOIN customers c ON o.`Customer ID` = c.`Customer ID`
    GROUP BY c.`Customer ID`, c.`Customer Name`
)
SELECT `Customer Name`, Total_Sales 
FROM CustomerSales
WHERE Total_Sales > (SELECT AVG(Total_Sales) FROM CustomerSales)
ORDER BY Total_Sales DESC;

-- 5. Highest order value per customer
SELECT 
    c.`Customer Name`, 
    MAX(o.Sales) AS Highest_Single_Order_Value
FROM orders o
JOIN customers c ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer ID`, c.`Customer Name`
ORDER BY Highest_Single_Order_Value DESC;
