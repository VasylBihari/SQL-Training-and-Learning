/*How many unique artists were recommended to users in April 2024? 
This analysis will help determine the diversity of recommendations during that month.
Tables
fct_artist_recommendations(recommendation_id, user_id, artist_id, recommendation_date, is_new_artist)*/

SELECT
  COUNT(DISTINCT(artist_id)) AS count_unique_artist
FROM fct_artist_recommendations
WHERE TO_CHAR (recommendation_date, 'YYYY-MM') = '2024-04'

/*What is the total number of recommendations for new artists in May 2024? 
This insight will help assess if our focus on emerging talent is working effectively.
Tables
fct_artist_recommendations(recommendation_id, user_id, artist_id, recommendation_date, is_new_artist)*/

SELECT
  COUNT(recommendation_id) AS count_recommendation
FROM fct_artist_recommendations
WHERE is_new_artist = 'TRUE'
AND (recommendation_date >='2024-05-01' AND recommendation_date <= '2024-05-31')

/*For each month in Quarter 2 2024 (April through June 2024), how many distinct new artists were recommended to users? 
This breakdown will help identify trends in new artist recommendations over the quarter.
Tables
fct_artist_recommendations(recommendation_id, user_id, artist_id, recommendation_date, is_new_artist)*/

SELECT
  COUNT(DISTINCT(artist_id)) AS count_new_artists,
  TO_CHAR(recommendation_date, 'YYYY-MM') AS months
FROM fct_artist_recommendations
WHERE is_new_artist = 'TRUE'
AND (recommendation_date >= '2024-04-01' AND recommendation_date <= '2024-06-30')
GROUP BY TO_CHAR(recommendation_date, 'YYYY-MM')
