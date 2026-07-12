WITH Spend AS (SELECT c.customer_name, SUM(p.price * o.quantity) AS LTV 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY c.customer_id) 
SELECT customer_name, LTV, DENSE_RANK() 
OVER (ORDER BY LTV DESC) AS Rank 
FROM Spend 
LIMIT 10;