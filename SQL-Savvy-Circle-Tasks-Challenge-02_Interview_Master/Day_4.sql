/* https://www.interviewmaster.ai/chat/dfb05f84-b2f0-4a8b-be39-7ffb5f5368a5

1. How many search queries had either a link click or more than 30 second dwell time in October 2024?
Tables
search_queries(query_id, user_id, clicks, dwell_time_seconds, query_date)
users(user_id, user_name, signup_date) */

SELECT
  COUNT(CASE WHEN clicks=1 OR dwell_time_seconds>30 THEN 1 END)
FROM search_queries
WHERE TO_CHAR(query_date, 'YYYY-MM') = '2024-10';

/* 2. Can you find out how many search queries in October 2024 were made by users who clicked on a link and spent more than 30 seconds on the search results page?
Tables
search_queries(query_id, user_id, clicks, dwell_time_seconds, query_date)
users(user_id, user_name, signup_date) */

 SELECT
  COUNT(*) AS qualified_queries
FROM search_queries
WHERE 
   1=1
   AND TO_CHAR(query_date, 'YYYY-MM') = '2024-10'
   AND clicks = 1
   AND dwell_time_seconds > 30;

/* 3. For users who signed up in the first week of October 2024 (e.g. October 1 - 7), how many search queries did they make in total?
Tables
search_queries(query_id, user_id, clicks, dwell_time_seconds, query_date)
users(user_id, user_name, signup_date) */

SELECT 
  COUNT(*) AS qualified_queries
FROM search_queries s
JOIN users u ON s.user_id=u.user_id 
WHERE u.signup_date >= '2024-10-01' AND u.signup_date <= '2024-10-07'
