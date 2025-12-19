/*Clara is reviewing holiday orders to uncover hidden patterns — can you return the total amount of wrapping paper used for orders 
that were both gift-wrapped and successfully delivered?
Tables
holiday_orders(order_id, customer_name, gift_wrap, paper_used_meters, delivery_status, order_date)*/

SELECT
  SUM(paper_used_meters) AS total_paper
FROM holiday_orders
WHERE gift_wrap = TRUE
  AND delivery_status = 'Delivered'
