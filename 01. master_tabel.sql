-- Membuat Master Tabel
SELECT 
    o.Date AS order_date,
	pc.CategoryName AS category_name,
	p.ProdName AS product_name,
	p.Price AS product_price,
	o.Quantity AS order_qty,
	ROUND((o.Quantity * p.Price),2) AS total_sales,
	c.CustomerEmail AS cust_email,
    c.CustomerCity AS cust_city
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProdNumber = p.ProdNumber
JOIN ProductCategory pc ON p.Category = pc.CategoryID
ORDER BY o.Date ASC;