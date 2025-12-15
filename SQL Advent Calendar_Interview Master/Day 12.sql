/*The North Pole Network wants to see who's the most active in the holiday chat each day. 
Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
Tables
npn_users(user_id, user_name)
npn_messages(message_id, sender_id, sent_at)*/

WITH rank_table AS (SELECT
  u.user_id AS user_id,
  m.sent_at::DATE AS date_sent,
  COUNT(message_id),
  DENSE_RANK()OVER(PARTITION BY m.sent_at::DATE ORDER BY COUNT(message_id) DESC) AS rank_count
FROM npn_users u
INNER JOIN npn_messages m ON u.user_id=m.sender_id
GROUP BY u.user_id, date_sent)
SELECT 
  user_id,
  date_sent
FROM rank_table
WHERE rank_count = 1
