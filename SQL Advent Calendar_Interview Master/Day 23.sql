/*The Gingerbread House Competition wants to feature the builders who used at least 4 distinct candy types in their designs. How would you identify these builders?
Tables
gingerbread_designs(builder_id, builder_name, candy_type)*/

SELECT
  builder_name,
  COUNT(DISTINCT candy_type) AS count_types
FROM gingerbread_designs
GROUP BY builder_name
HAVING COUNT(DISTINCT candy_type) >= 4
