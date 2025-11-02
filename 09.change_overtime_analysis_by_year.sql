-- Create Change Over Time Analysis (Total Sales and Customer by YEAR)
SELECT
	YEAR(STR_TO_DATE(o.date, '%d/%m/%Y')) as order_year,
    SUM(o.quantity) AS total_quantity,
    COUNT(c.customerid) as total_customer,
    SUM(o.Quantity * p.Price) AS total_sales 
FROM orders o
LEFT JOIN customers c ON o.CustomerID = c.CustomerID
LEFT JOIN Products p ON o.ProdNumber = p.ProdNumber
WHERE o.date IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(o.date, '%d/%m/%Y')) 
ORDER BY YEAR(STR_TO_DATE(o.date, '%d/%m/%Y')) ASC;