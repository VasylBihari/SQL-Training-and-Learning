/*What is the average booking cost for corporate travelers? For this question, let's look only at trips which were booked in January 2024
Tables
fct_corporate_bookings(booking_id, company_id, employee_id, booking_cost, booking_date, travel_date)
dim_companies(company_id, company_name)*/

SELECT
  AVG(booking_cost) AS avg_booking
FROM fct_corporate_bookings
WHERE booking_date BETWEEN '2024-01-01' AND '2024-01-31'

/*Identify the top 5 companies with the highest average booking cost per employee for trips taken during the first quarter of 2024.
Note that if an employee takes multiple trips, each booking will show up as a separate row in fct_corporate_bookings.
Tables
fct_corporate_bookings(booking_id, company_id, employee_id, booking_cost, booking_date, travel_date)
dim_companies(company_id, company_name)*/

SELECT
  company_id,
  SUM(booking_cost)/COUNT(DISTINCT(employee_id)) AS avg_booking
FROM fct_corporate_bookings
  WHERE travel_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY company_id
ORDER BY avg_booking DESC
LIMIT 5

/*For bookings made in February 2024, what percentage of bookings were made more than 30 days in advance? Use this to recommend strategies for reducing booking costs.
Tables
fct_corporate_bookings(booking_id, company_id, employee_id, booking_cost, booking_date, travel_date)
dim_companies(company_id, company_name)*/

WITH count_booking_table AS (
  SELECT
    COUNT(booking_date) AS count_booking
  FROM fct_corporate_bookings
  WHERE booking_date BETWEEN '2024-02-01' AND '2024-02-29'
),
  count_booking_more_30 AS (
  SELECT
    COUNT (booking_date) AS count_booking_more_30_days
  FROM fct_corporate_bookings
  WHERE (travel_date - booking_date) > 30
  AND booking_date BETWEEN '2024-02-01' AND '2024-02-29'
  )
   SELECT
      ROUND(m.count_booking_more_30_days * 100.0 / t.count_booking, 2) AS percentage_booking
    FROM count_booking_table t
    CROSS JOIN count_booking_more_30 m
