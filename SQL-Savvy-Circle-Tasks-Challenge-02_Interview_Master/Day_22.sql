/*What is the total watch time for content after it was recommended to users? To correctly attribute watch time to the recommendation, it is critical to only include watch time after the recommendation was made to the user. A content could get recommended to a user multiple times. If so, we want to use the first date that the content was recommended to a user.
Tables
fct_watch_history(watch_id, user_id, content_id, watch_time_minutes, watch_date)
dim_content(content_id, title, genre, release_date)
fct_recommendations(recommendation_id, user_id, content_id, recommended_date)*/

WITH aggregated_table AS (SELECT
  f.user_id,
  f.content_id,
  f.watch_date AS watch_date,
  min(r.recommended_date) AS min_date,
  SUM(watch_time_minutes) AS total_times
FROM fct_watch_history f 
LEFT JOIN fct_recommendations r ON f.user_id=r.user_id
  AND f.content_id=r.content_id
GROUP BY f.user_id,f.content_id,f.watch_date
)
SELECT 
  SUM(total_times)
FROM aggregated_table
WHERE watch_date > min_date 

/*The team wants to know the total watch time for each genre in first quarter of 2024, split by whether or not the content was recommended vs. non-recommended to a user.
Watch time should be bucketed into 'Recommended' by joining on both user and content, regardless of when they watched it vs. when they received the recommendation.
Tables
fct_watch_history(watch_id, user_id, content_id, watch_time_minutes, watch_date)
dim_content(content_id, title, genre, release_date)
fct_recommendations(recommendation_id, user_id, content_id, recommended_date)*/

SELECT
  d.genre,
  SUM(watch_time_minutes) AS total_time,
  CASE WHEN r.recommendation_id IS NOT NULL THEN 'Recommended' ELSE 'Non-Recommended' END AS recommendation_status
FROM dim_content d
LEFT JOIN fct_watch_history h ON d.content_id=h.content_id
LEFT JOIN fct_recommendations r ON d.content_id=r.content_id
                                AND h.user_id = r.user_id
WHERE h.watch_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY d.genre, recommendation_status

/*The team aims to categorize user watch sessions into 'Short', 'Medium', or 'Long' based on watch time for recommended content to identify engagement patterns.
'Short' for less than 60 minutes, 'Medium' for 60 to 120 minutes, and 'Long' for more than 120 minutes. Can you classify and count the sessions in Q1 2024 accordingly?
Tables
fct_watch_history(watch_id, user_id, content_id, watch_time_minutes, watch_date)
dim_content(content_id, title, genre, release_date)
fct_recommendations(recommendation_id, user_id, content_id, recommended_date)*/

WITH aggregated_table AS (SELECT 
  h.content_id,
  CASE
      WHEN watch_time_minutes < 60 THEN 'Short'
      WHEN watch_time_minutes >= 60 AND watch_time_minutes <= 120 THEN 'Medium'
      ELSE 'Long'
   END AS watching_time
FROM fct_watch_history h
LEFT JOIN fct_recommendations r ON h.content_id=r.content_id
WHERE watch_date BETWEEN '2024-01-01' AND '2024-03-31'
  AND r.recommendation_id IS NOT NULL
  ) 
SELECT 
  watching_time,
  COUNT (watching_time)
FROM aggregated_table
GROUP BY watching_time
