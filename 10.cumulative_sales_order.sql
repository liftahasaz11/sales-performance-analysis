-- CUMULATIVE ANALYSIS
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    total_order,
    SUM(total_order) OVER (ORDER BY order_date) AS running_total_order
FROM (
    SELECT
        STR_TO_DATE(o.date, '%d/%m/%Y') AS order_date,
        SUM(o.quantity * p.price) AS total_sales,
        SUM(quantity) as total_order
    FROM orders o
    LEFT JOIN customers c ON o.CustomerID = c.CustomerID
    LEFT JOIN products p ON o.ProdNumber = p.ProdNumber
    WHERE o.date IS NOT NULL
    GROUP BY order_date
) AS yearly_sales
ORDER BY order_date ASC;