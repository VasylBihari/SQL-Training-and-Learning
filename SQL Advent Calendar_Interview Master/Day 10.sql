/*In the holiday cookie factory, workers are measuring how efficient each oven is. 
Can you find the average baking time per oven rounded to one decimal place?
Tables
cookie_batches(batch_id, oven_id, baking_time_minutes)*/

SELECT
  oven_id,
  ROUND(AVG(baking_time_minutes),1) AS avg_time_per_oven
FROM cookie_batches
GROUP BY oven_id
ORDER BY avg_time_per_oven DESC
