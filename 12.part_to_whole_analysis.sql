-- Part to Whole Analysis
WITH category_sales AS(
SELECT
	CategoryName,
	SUM(o.Quantity * p.Price) AS total_sales
FROM orders o 
LEFT JOIN Products p ON o.ProdNumber = p.ProdNumber
LEFT JOIN productcategory pc ON p.Category = pc.CategoryID
GROUP BY CategoryName)
SELECT 
	CategoryName,
    total_sales,
    SUM(total_sales) OVER() overall_sales,
    CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales)OVER())*100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;