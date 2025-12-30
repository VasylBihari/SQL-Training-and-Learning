/*The team wants to identify the total usage duration of the services 
for each device type by extracting the primary device category from the device name for the period from July 1, 2024 to September 30, 2024. 
The primary device category is derived from the first word of the device name.

Tables
fct_device_usage(usage_id, device_id, service_id, usage_duration_minutes, usage_date)
dim_device(device_id, device_name)
dim_service(service_id, service_name)*/

WITH temp_table AS (SELECT
  SPLIT_PART(d.device_name, ' ', 1) AS primary_device_category,
  u.usage_duration_minutes AS durations
FROM dim_device d
INNER JOIN fct_device_usage u ON d.device_id=u.device_id
WHERE usage_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY SPLIT_PART(d.device_name, ' ', 1), u.usage_duration_minutes
  )
SELECT 
  primary_device_category,
  SUM (durations) AS total_time
FROM temp_table 
GROUP BY primary_device_category

/*The team also wants to label the usage of each device category into 'Low' or 'High' based on usage duration 
from July 1, 2024 to September 30, 2024. If the total usage time was less than 300 minutes, we'll category it as 'Low'. 
Otherwise, we'll categorize it as 'high'. Can you return a report with device ID, usage category and total usage time?

Tables
fct_device_usage(usage_id, device_id, service_id, usage_duration_minutes, usage_date)
dim_device(device_id, device_name)
dim_service(service_id, service_name)*/

SELECT
  device_id,
  SUM(usage_duration_minutes) AS total_usage_time,
  CASE
      WHEN SUM(usage_duration_minutes) < 300 THEN 'Low'
    ELSE 'High'
  END
FROM fct_device_usage
WHERE usage_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY device_id

/*The team is considering bundling the Prime Video and Amazon Music subscription. 
They want to understand what percentage of total usage time comes from Prime Video and Amazon Music services respectively. 
Please use data from July 1, 2024 to September 30, 2024.

Tables
fct_device_usage(usage_id, device_id, service_id, usage_duration_minutes, usage_date)
dim_device(device_id, device_name)
dim_service(service_id, service_name)*/

WITH temp_table AS (SELECT
  ds.service_id,
  ds.service_name AS service_name,
  SUM(du.usage_duration_minutes) AS time_services
FROM fct_device_usage du 
INNER JOIN dim_service ds ON ds.service_id=du.service_id
WHERE usage_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY ds.service_id, ds.service_name
)
SELECT 
  service_name,
  ROUND(time_services*100/SUM(time_services) OVER (),2) AS share_of_total
FROM temp_table
