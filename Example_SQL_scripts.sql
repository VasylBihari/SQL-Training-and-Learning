/* Top N Records Per Group (e.g., Top 3 earners in each department). Used in*: Performance reviews, department-level reports */
SELECT *
FROM (
  SELECT *,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
) ranked
WHERE rnk <= 3;

/*Find Gaps in Dates (Missing Days). Used in*: Shift tracking, employee attendance, logs*/
``` 
SELECT d.date
FROM calendar d
LEFT JOIN attendance a ON d.date = a.attendance_date
WHERE a.attendance_date IS NULL;

/* Percentage of Total. Used in*: Pie charts, resource distribution, dashboards*/
``` 
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

 /*1. Finding Duplicates*/
SELECT name, COUNT(*) 
FROM employees
GROUP BY name
HAVING COUNT(*) > 1;

/*2. Get the Second Highest Salary*/
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (
  SELECT MAX(salary)
  FROM employees
);

/*Running Totals*/
SELECT name, salary,
       SUM(salary) OVER (ORDER BY id) AS running_total
FROM employees;

Essential in dashboards and financial reports.

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





