/*Santa wants to analyze which toys that were produced in his workshop have already been delivered to children. You are given two tables on toy production and toy delivery — can you return the toy ID and toy name of the toys that have been delivered?
Tables
toy_production(toy_id, toy_name, production_date)
toy_delivery(toy_id, child_name, delivery_date)*/

SELECT
  d.toy_id,
  p.toy_name,
  d.delivery_date
FROM toy_delivery d
INNER JOIN toy_production p ON p.toy_id=d.toy_id
  WHERE d.delivery_date < CURRENT_DATE
