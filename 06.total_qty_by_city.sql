-- TOTAL KESELURUHAN QUANTITY BERDASARKAN KOTA
WITH master_table as(
SELECT 
    o.Date AS order_date,
	pc.CategoryName AS category_name,
	p.ProdName AS product_name,
	p.Price AS product_price,
	o.Quantity AS order_qty,
	(o.Quantity * p.Price) AS total_sales,
	c.CustomerEmail AS cust_email,
    c.CustomerCity AS cust_city
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProdNumber = p.ProdNumber
JOIN ProductCategory pc ON p.Category = pc.CategoryID
ORDER BY o.Date ASC)
SELECT 
	SUM(order_qty) as total_qty_per_kota,
    cust_city
FROM master_table
GROUP BY cust_city
ORDER BY total_qty_per_kota DESC;