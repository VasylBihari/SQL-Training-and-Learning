/* https://www.interviewmaster.ai/chat/45454386-6646-4051-bf7f-d439a6a09a83

1. What is the percentage of orders delivered on time in January 2024? 
Consider an order on time if its actual_delivery_time is less than or equal to its expected_delivery_time. This will help us assess overall tracking precision.
Tables
fct_orders(order_id, delivery_partner_id, delivery_partner_name, expected_delivery_time, actual_delivery_time, order_date) */

SELECT
    ROUND((on_time_count/total_orders*100),2)  AS on_time_delivery_percentage
FROM (SELECT
  COUNT(order_id) AS total_orders,
  COUNT(CASE WHEN actual_delivery_time<=expected_delivery_time THEN 1 END) AS on_time_count
FROM fct_orders
  WHERE TO_CHAR(actual_delivery_time, 'YYYY-MM') = '2024-01')

/* 2.List the top 5 delivery partners in January 2024 ranked by the highest percentage of on-time deliveries. 
Use the delivery_partner_name field from the records. This will help us identify which partners perform best.
Tables
fct_orders(order_id, delivery_partner_id, delivery_partner_name, expected_delivery_time, actual_delivery_time, order_date)*/

SELECT
   delivery_partner_name,
   ROUND ((on_time_count/total_orders*100),2)  AS on_time_delivery_percentage
FROM (
  SELECT
  delivery_partner_name,
  COUNT(CASE WHEN actual_delivery_time<=expected_delivery_time THEN 1 END) AS on_time_count,
  COUNT(order_id) AS total_orders
FROM fct_orders
WHERE TO_CHAR(actual_delivery_time,'YYYY-MM') = '2024-01'
GROUP BY delivery_partner_name) subqerry
ORDER BY on_time_delivery_percentage DESC
LIMIT 5;

/* 3. Identify the delivery partner(s) in January 2024 whose on-time delivery percentage is below 50%. 
Return their partner names in uppercase. We need to work with these delivery partners to improve their on-time delivery rates.
Tables
fct_orders(order_id, delivery_partner_id, delivery_partner_name, expected_delivery_time, actual_delivery_time, order_date)*/

SELECT
   UPPER(delivery_partner_name),
   ROUND ((on_time_count/total_orders*100),2)  AS on_time_delivery_percentage
FROM (
  SELECT
  delivery_partner_name,
  COUNT(CASE WHEN actual_delivery_time<=expected_delivery_time THEN 1 END) AS on_time_count,
  COUNT(order_id) AS total_orders
FROM fct_orders
WHERE TO_CHAR(actual_delivery_time,'YYYY-MM') = '2024-01'
GROUP BY delivery_partner_name) subqerry
WHERE ROUND ((on_time_count/total_orders*100),2) < 50;

