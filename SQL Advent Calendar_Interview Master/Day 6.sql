/*Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. 
Can you help him bucket these ski resorts into quartiles?
Tables
resort_monthly_snowfall(resort_id, resort_name, snow_month, snowfall_inches)*/

SELECT
  resort_name,
  SUM(snowfall_inches) AS total_year_snowfall,
  NTILE(4) OVER (ORDER BY SUM(snowfall_inches)) AS quartile
FROM resort_monthly_snowfall
GROUP BY resort_name
