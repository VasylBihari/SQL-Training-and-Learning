/*Day 6
https://www.namastesql.com/coding-problem/55-lowest-price?question_type=0&page=1&pageSize=10

You own a small online store, and want to analyze customer ratings for the products that you're selling. 
After doing a data pull, you have a list of products and a log of purchases. 
Within the purchase log, each record includes the number of stars (from 1 to 5) as a customer rating for the product.
For each category, find the lowest price among all products that received at least one 4-star or above rating from customers.
If a product category did not have any products that received at least one 4-star or above rating, the lowest price is considered to be 0. 
The final output should be sorted by product category in alphabetical order.

Table: products

| COLUMN_NAME | DATA_TYPE   |
|-------------|-------------|
| category    | varchar(10) |
| id          | int         |
| name        | varchar(20) |
| price       | int         |

Table: purchases

| COLUMN_NAME | DATA_TYPE |
|-------------|-----------|
| id          | int       |
| product_id  | int       |
| stars       | int       |
*/


SELECT 
	category,
  COALESCE(MIN(CASE WHEN ps.stars >= 4 THEN pr.price END), 0) as price
FROM products pr
LEFT JOIN purchases ps ON pr.id=ps.product_id
GROUP BY category
ORDER BY category; 
