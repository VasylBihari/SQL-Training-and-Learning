/*Day 2
https://www.namastesql.com/coding-problem/2-product-category?page=1&pageSize=10
You are provided with a table named Products containing information about various products, including their names and prices. Write a SQL query to count number of products in each category based on its price into three categories below. Display the output in descending order of no of products.

1- "Low Price" for products with a price less than 100
2- "Medium Price" for products with a price between 100 and 500 (inclusive)
3- "High Price" for products with a price greater than 500.

**Products**
| Column_name  | Data_type   |
|--------------|-------------|
| product_id   | int         |
| product_name | varchar(20) |
| price        | int         | */



WITH price_table AS (SELECT
	CASE
    	WHEN price < 100 THEN 'Low Price'
        WHEN price >=100 AND PRICE <=500 THEN 'Medium Price'
        WHEN price > 500 THEN 'High Price'
    END AS price_product
FROM products)
SELECT 
	price_product,
	COUNT(price_product)
FROM price_table
GROUP BY price_product
ORDER BY COUNT(price_product) DESC;
