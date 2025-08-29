/* Top N Records Per Group (e.g., Top 3 earners in each department). Used in: Performance reviews, department-level reports */
SELECT *
FROM (
  SELECT *,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
) ranked
WHERE rnk <= 3;

/*Find Gaps in Dates (Missing Days). Used in*: Shift tracking, employee attendance, logs*/
SELECT d.date
FROM calendar d
LEFT JOIN attendance a ON d.date = a.attendance_date
WHERE a.attendance_date IS NULL;

/* Percentage of Total. Used in*: Pie charts, resource distribution, dashboards*/
SELECT department,
       COUNT(*) AS total_employees,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM employees
GROUP BY department;

/* Find Consecutive Login Streaks. Used in*: Gamification, loyalty systems, user engagement*/
SELECT user_id, login_date,
       DENSE_RANK() OVER (PARTITION BY user_id ORDER BY login_date) -
       ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS streak_group
FROM logins;

/* First & Last Purchase Per Customer.Used in*: Retention analysis, marketing campaigns*/  
SELECT customer_id,
       MIN(order_date) AS first_purchase,
       MAX(order_date) AS last_purchase
FROM orders
GROUP BY customer_id;

 /*Finding Duplicates*/
SELECT name, COUNT(*) 
FROM employees
GROUP BY name
HAVING COUNT(*) > 1;

/* Get the Second Highest Salary*/
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (
  SELECT MAX(salary)
  FROM employees
);

/*Running Totals. Essential in dashboards and financial reports.*/
SELECT name, salary,
       SUM(salary) OVER (ORDER BY id) AS running_total
FROM employees;


/* Customers with No Orders. Very common in e-commerce or CRM platforms.*/
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

/*Monthly Aggregates.Great for trends and time-based reporting.*/
SELECT DATE_TRUNC('month', order_date) AS month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

/* Pivot-like Output (Using CASE).Super useful for dashboards and insights.*/
SELECT 
  department,
  COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS male_count,
  COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS female_count
FROM employees
GROUP BY department;

/* Recursive Queries (Org Hierarchy or Tree).Used in advanced data modeling and tree structures.*/

WITH RECURSIVE employee_tree AS (
  SELECT id, name, manager_id
  FROM employees
  WHERE manager_id IS NULL
  
  UNION ALL
  
  SELECT e.id, e.name, e.manager_id
  FROM employees e
  INNER JOIN employee_tree et ON e.manager_id = et.id
)
SELECT * FROM employee_tree;
--------------------------------------------------------------------------------------------------------------
*1️⃣ Retrieve Top N Records*  
*Q:* Get top 5 highest selling products.  
SQL

SELECT product_id, SUM(amount) AS total_sales  
FROM sales  
GROUP BY product_id  
ORDER BY total_sales DESC  
LIMIT 5;
*2️⃣ Find Duplicate Records*  
*Q:* Identify duplicate emails in the users table.  
SQL

SELECT email, COUNT(*)  
FROM users  
GROUP BY email  
HAVING COUNT(*) > 1;
*3️⃣ Use Window Functions*  
*Q:* Add a running total of sales by date.  
SQL

SELECT date, amount,  
  SUM(amount) OVER (ORDER BY date) AS running_total  
FROM sales;
*4️⃣ Join Multiple Tables*  
*Q:* List customer names and their total orders.  
SQL

SELECT c.name, COUNT(o.order_id) AS total_orders  
FROM customers c  
JOIN orders o ON c.customer_id = o.customer_id  
GROUP BY c.name;
*5️⃣ Filter with Subqueries*  
*Q:* Find products priced higher than the average.  
SQL

SELECT * FROM products  
WHERE price > (SELECT AVG(price) FROM products);
*6️⃣ Use CASE for Categorization*  
*Q:* Label customers as 'High', 'Medium', 'Low' spenders.  
SQL

SELECT name,  
  CASE  
    WHEN total_spent > 1000 THEN 'High'  
    WHEN total_spent > 500 THEN 'Medium'  
    ELSE 'Low'  
  END AS category  
FROM customers;
*7️⃣ Handle NULLs*  
*Q:* Replace NULL phone numbers with 'Not Provided'.  
SQL

SELECT name, COALESCE(phone, 'Not Provided') AS phone  
FROM users;
*8️⃣ Date Functions*  
*Q:* Count orders placed in the last 30 days.  
SQL

SELECT COUNT(*)  
FROM orders  
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';
*9️⃣ Group By with Multiple Columns*  
*Q:* Total revenue by region and product.  
SQL

SELECT region, product_id, SUM(amount)  
FROM sales  
GROUP BY region, product_id;
*🔟 CTEs & Temporary Tables*  
*Q:* Use a CTE to find top customers.  
SQL

WITH top_customers AS (
  SELECT customer_id, SUM(amount) AS total  
  FROM orders  
  GROUP BY customer_id  
)
SELECT * FROM top_customers WHERE total > 1000;




