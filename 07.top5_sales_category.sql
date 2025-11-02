-- TOP 5 KATEGORI PRODUK DENGAN TOTAL SALES TERTINGGI
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
	ROUND(SUM(total_sales),2) as total_sales_per_category,
    category_name as kategori_produk
FROM master_table
GROUP BY category_name
ORDER BY total_sales_per_category DESC
LIMIT 5;