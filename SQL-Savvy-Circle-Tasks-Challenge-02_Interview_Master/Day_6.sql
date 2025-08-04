/*https://www.interviewmaster.ai/question/game-library-health-for-user-retention

1. How many users have no games installed in their library during the third quarter of 2024? Use the dim_users table and filter for users where has_game_installed is 0 and the library_last_updated date is between July and September 2024. This helps identify users that can be targeted for increased engagement.
Tables
dim_users(user_id, has_game_installed, library_last_updated, installed_games_count)
fct_user_game_activity(user_id, game_id, install_date, last_played_date) */

SELECT 
  COUNT(*) AS count_users
FROM dim_users
WHERE has_game_installed = '0'
AND library_last_updated >= '2024-07-01' 
AND library_last_updated <='2024-09-30';

/*2. Which 5 games had the highest number of installs during the third quarter of 2024? This helps reveal the most popular games among users.
Tables
dim_users(user_id, has_game_installed, library_last_updated, installed_games_count)
fct_user_game_activity(user_id, game_id, install_date, last_played_date)*/

SELECT
  COUNT(install_date) AS count_install,
  game_id
FROM fct_user_game_activity
WHERE install_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY game_id
ORDER BY count_install DESC
LIMIT 5;

/* 3. How many users, whose libraries were last updated between July and September 2024, have 3 or more games installed in their library?
Tables
dim_users(user_id, has_game_installed, library_last_updated, installed_games_count)
fct_user_game_activity(user_id, game_id, install_date, last_played_date)*/

SELECT
  COUNT(user_id) AS count_users
FROM dim_users
WHERE library_last_updated >= '2024-07-01' AND library_last_updated < '2024-10-01'
AND installed_games_count >= 3;
