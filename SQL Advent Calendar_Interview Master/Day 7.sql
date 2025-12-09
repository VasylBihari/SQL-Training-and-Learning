/*Frosty wants to know how many unique snowflake types were recorded on the December 24th, 2025 storm. Can you help him?
Tables
snowfall_log(flake_id, flake_type, fall_time)*/

SELECT
  COUNT(DISTINCT(flake_type)) AS count_flake_type
FROM snowfall_log
WHERE fall_time >='2025-12-24' AND fall_time <'2025-12-25'
