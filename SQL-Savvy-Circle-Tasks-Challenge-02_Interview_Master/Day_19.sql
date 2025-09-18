/*How many unique users have streamed an artist on or after the date it was recommended to them?
Tables
user_streams(stream_id, user_id, artist_id, stream_date)
artist_recommendations(recommendation_id, user_id, artist_id, recommendation_date)*/

SELECT COUNT(DISTINCT u.user_id)
FROM user_streams u
INNER JOIN artist_recommendations a 
    ON u.user_id = a.user_id 
    AND u.artist_id = a.artist_id
WHERE u.stream_date >= a.recommendation_date;

/*What is the average number of times a recommended artist is streamed by users in May 2024? Similar to the previous question, only include streams on or after the date the artist was recommended to them.
Tables
user_streams(stream_id, user_id, artist_id, stream_date)
artist_recommendations(recommendation_id, user_id, artist_id, recommendation_date)*/

WITH count_table AS (SELECT
  u.user_id AS users,
  COUNT(stream_id) AS count_streams
FROM user_streams u
INNER JOIN artist_recommendations a 
    ON u.user_id=a.user_id
    AND u.artist_id = a.artist_id
WHERE stream_date BETWEEN '2024-05-01' and '2024-05-31'
  AND u.stream_date >= a.recommendation_date
GROUP BY u.user_id
)
SELECT
  ROUND(SUM(count_streams)/COUNT(DISTINCT(users)),2) AS avg_numbers
FROM count_table

/*Across users who listened to at least one recommended artist, what is the average number of distinct recommended artists they listened to? As in the previous question, only include streams that occurred on or after the date the artist was recommended to the user.
Tables
user_streams(stream_id, user_id, artist_id, stream_date)
artist_recommendations(recommendation_id, user_id, artist_id, recommendation_date)*/

WITH user_recommended_artists AS (
    SELECT 
        u.user_id,
        COUNT(DISTINCT u.artist_id) AS distinct_artists
    FROM user_streams u
    INNER JOIN artist_recommendations a
        ON u.user_id = a.user_id 
        AND u.artist_id = a.artist_id 
        AND u.stream_date >= a.recommendation_date
    GROUP BY u.user_id
    HAVING COUNT(DISTINCT u.artist_id) > 0
)
SELECT 
  ROUND(AVG(distinct_artists),2) AS avg_distinct_artists
FROM user_recommended_artists;
