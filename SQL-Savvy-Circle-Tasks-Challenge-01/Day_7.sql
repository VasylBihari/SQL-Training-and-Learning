/*Day 7 https://www.namastesql.com/coding-problem/64-penultimate-order?page=1&pageSize=10&question_type=0

You are a data analyst working for an e-commerce company, responsible for analysing customer orders to gain insights into their purchasing behaviour.
Your task is to write a SQL query to retrieve the details of the penultimate order for each customer. 
However, if a customer has placed only one order, you need to retrieve the details of that order instead, display the output in ascending order of customer name.

Table: orders

| COLUMN_NAME   | DATA_TYPE   |
|---------------|-------------|
| order_id      | int         |
| order_date    | date        |
| customer_name | varchar(10) |
| product_name  | varchar(10) |
| sales         | int         |  */

WITH table_orders AS(
  SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY customer_name ORDER BY order_date DESC) AS rn,
        COUNT(*) OVER (PARTITION BY customer_name) AS order_count
FROM orders)
SELECT 
    order_id,
    order_date,
    customer_name,
    product_name,
    sales
FROM table_orders
WHERE rn = CASE 
              WHEN order_count = 1 THEN 1 
              ELSE 2 
           END
ORDER BY customer_name ASC;


