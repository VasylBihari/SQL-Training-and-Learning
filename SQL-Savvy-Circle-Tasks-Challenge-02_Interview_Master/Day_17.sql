/*How many unique users have added at least one recommended track to their playlists in October 2024?
Tables
tracks_added(interaction_id, user_id, track_id, added_date, is_recommended)
users(user_id, user_name)*/
SELECT
  COUNT(DISTINCT(user_id)) AS count_users
FROM tracks_added
WHERE added_date BETWEEN '2024-10-01' and '2024-10-31'
  AND is_recommended = TRUE

/*Among the users who added recommended tracks in October 2024, what is the average number of recommended tracks added to their playlists? Please round this to 1 decimal place for better readability.
Tables
tracks_added(interaction_id, user_id, track_id, added_date, is_recommended)
users(user_id, user_name)*/
WITH table_tracks AS (SELECT
  user_id,
  COUNT(track_id) AS count_tracks
FROM tracks_added
WHERE added_date BETWEEN '2024-10-01' AND '2024-10-31'
  AND is_recommended = TRUE
GROUP BY user_id
)
SELECT 
  ROUND(SUM(count_tracks)/COUNT(user_id),1) AS avg_numbers
FROM table_tracks

/*Can you give us the name(s) of users who added a non-recommended track to their playlist on October 2nd, 2024?
Tables
tracks_added(interaction_id, user_id, track_id, added_date, is_recommended)
users(user_id, user_name)*/
SELECT
  u.user_name
FROM users u
LEFT JOIN tracks_added t ON u.user_id=t.user_id
WHERE added_date = '2024-10-02'
AND is_recommended = FALSE
