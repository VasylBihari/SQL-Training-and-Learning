/*What is the total sales volume for essential household items in July 2024? Provide the result with a column named 'Total_Sales_Volume'.

Tables
fct_sales(sale_id, product_id, quantity_sold, sale_date, unit_price)
dim_products(product_id, product_name, category)*/

SELECT
  SUM (quantity_sold) AS Total_Sales_Volume
FROM fct_sales f
LEFT JOIN dim_products d ON f.product_id = d.product_id
WHERE d.category = 'Essential Household'
AND (sale_date BETWEEN '2024-07-01' AND '2024-07-31')

/*For essential household items sold in July 2024, categorize the items into 'Low', 'Medium', and 'High' price ranges based on their average price. 
Use the following criteria: 'Low' for prices below $5, 'Medium' for prices between $5 and $15, and 'High' for prices above $15.
Tables
fct_sales(sale_id, product_id, quantity_sold, sale_date, unit_price)
dim_products(product_id, product_name, category)*/

SELECT
  f.product_id,
  CASE
    WHEN AVG (unit_price) < 5 THEN 'Low'
    WHEN AVG (unit_price) >= 5 AND AVG (unit_price) <= 15 THEN 'Medium'
    ELSE 'High'
  END AS price_level
FROM fct_sales f
LEFT JOIN dim_products d ON f.product_id=d.product_id
WHERE TO_CHAR(sale_date,'YYYY-MM') = '2024-07'
AND d.category = 'Essential Household'
GROUP BY f.product_id

/*Identify the price range with the highest total sales volume for essential household items in July 2024. 
Use the same criteria as the previous question: 'Low' for prices below $5, 'Medium' for prices between $5 and $15, and 'High' for prices above $15.
Provide the result with columns named 'Price_Range' and 'Total_Sales_Volume'.
Tables
fct_sales(sale_id, product_id, quantity_sold, sale_date, unit_price)
dim_products(product_id, product_name, category)*/

 WITH temp_table AS (SELECT
  f.product_id,
  CASE
    WHEN unit_price < 5 THEN 'Low'
    WHEN unit_price >= 5 AND unit_price <= 15 THEN 'Medium'
    ELSE 'High'
  END AS price_range
FROM fct_sales f
LEFT JOIN dim_products d ON f.product_id=d.product_id
WHERE TO_CHAR(sale_date,'YYYY-MM') = '2024-07'
AND d.category = 'Essential Household'
GROUP BY f.product_id, unit_price)
 SELECT
  SUM(quantity_sold) AS Total_Sales_Volume,
  price_range
FROM temp_table t
LEFT JOIN fct_sales f ON t.product_id=f.product_id
JOIN dim_products d ON t.product_id = d.product_id
WHERE TO_CHAR(sale_date,'YYYY-MM') = '2024-07'
AND category = 'Essential Household'
GROUP BY price_range
ORDER BY total_sales_volume DESC
LIMIT 1
