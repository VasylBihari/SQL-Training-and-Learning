/*The Amazon Music Recommendation Team wants to know which playlists have the least number of tracks. Can you find out the playlist with the minimum number of tracks?
Tables
playlists(playlist_id, playlist_name, number_of_tracks)
playlist_engagement(playlist_id, user_id, listening_time_minutes, engagement_date)*/

SELECT
  playlist_name,
  SUM(number_of_tracks) AS min_tracks
FROM playlists
GROUP BY playlist_name
ORDER BY min_tracks
LIMIT 1

/*We are interested in understanding the engagement level of playlists. Specifically, we want to identify which playlist has the lowest average listening time per track. 
This means calculating the total listening time for each playlist in October 2024 and then normalizing it by the number of tracks in that playlist. 
Can you provide the name of the playlist with the lowest value based on this calculation?
Tables
playlists(playlist_id, playlist_name, number_of_tracks)
playlist_engagement(playlist_id, user_id, listening_time_minutes, engagement_date)*/

WITH temp_table AS (SELECT
  p.playlist_name AS playlist_name,
  p.playlist_id AS p_id,
  p.number_of_tracks AS num,
  SUM(e.listening_time_minutes) AS total_time
FROM playlists p
LEFT JOIN playlist_engagement e ON e.playlist_id=p.playlist_id
WHERE e.engagement_date BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY p.playlist_id, playlist_name, p.number_of_tracks
)
SELECT 
  p_id,
  playlist_name,
  total_time/num AS avg_time
FROM temp_table
ORDER BY avg_time
LIMIT 1

/*To optimize our recommendations, we need the average monthly listening time per listener for each playlist in October 2024. 
For readibility, please round down to the average listening time to the nearest whole number.
Tables
playlists(playlist_id, playlist_name, number_of_tracks)
playlist_engagement(playlist_id, user_id, listening_time_minutes, engagement_date)*/

WITH count_table AS (SELECT
  playlist_id,
  COUNT (DISTINCT(user_id)) AS count_users,
  SUM (listening_time_minutes) AS total_minutes
FROM playlist_engagement
  WHERE engagement_date BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY playlist_id
)
SELECT
  playlist_id,
  FLOOR(total_minutes/count_users) AS avg_time
FROM count_table
