WITH FirstBuy AS (SELECT customer_id, MIN(strftime('%Y-%m', order_date)) AS Cohort 
FROM orders 
GROUP BY customer_id), Activity AS (SELECT o.customer_id, fp.Cohort, strftime('%Y-%m', o.order_date) AS Active_Month 
FROM orders o 
JOIN FirstBuy fp 
ON o.customer_id = fp.customer_id) 
SELECT Cohort, Active_Month, COUNT(DISTINCT customer_id) AS Users 
FROM Activity 
GROUP BY Cohort, Active_Month;