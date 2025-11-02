-- PERFORMANCE ANALYSIS
WITH yearly_product_sales AS (
SELECT 
	YEAR(STR_TO_DATE(o.date, '%d/%m/%Y')) as order_year,
    p.ProdName, 
    SUM(o.Quantity * p.Price) AS current_sales
FROM orders o 
LEFT JOIN Products p ON o.ProdNumber = p.ProdNumber
WHERE o.date IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(o.date, '%d/%m/%Y')), 
	p.ProdName)
    SELECT
	order_year, 
    ProdName,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY ProdName) AS avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY ProdName) AS diff_avg,
    CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY ProdName) > 0 THEN 'Above Avg' 
		WHEN current_sales - AVG(current_sales) OVER (PARTITION BY ProdName) < 0 THEN 'Below Avg' 
        ELSE 'Avg'
	END avg_change,
    LAG (current_sales) OVER (PARTITION BY ProdName ORDER BY order_year) py_sales,
    current_sales - LAG (current_sales) OVER (PARTITION BY ProdName ORDER BY order_year) AS diff_py,
    CASE WHEN current_sales - LAG (current_sales) OVER (PARTITION BY ProdName ORDER BY order_year) > 0 THEN 'Increase'
		WHEN current_sales - LAG (current_sales) OVER (PARTITION BY ProdName ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
	END py_change
    FROM yearly_product_sales
    ORDER BY ProdName, order_year;