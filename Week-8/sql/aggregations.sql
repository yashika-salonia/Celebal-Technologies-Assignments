SELECT strftime('%Y-%m', o.order_date) AS Month, 
p.category, 
SUM(p.price * o.quantity) AS Revenue 
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY Month, p.category;