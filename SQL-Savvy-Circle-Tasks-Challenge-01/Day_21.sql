/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.
*/
WITH first_logins AS (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),
next_day_logins AS (
    SELECT f.player_id
    FROM first_logins f
    JOIN Activity a
    ON a.player_id = f.player_id
    AND a.event_date = f.first_login + INTERVAL '1 day'
),
total_players AS (
    SELECT COUNT(DISTINCT player_id)::NUMERIC AS total_count
    FROM Activity
),
next_day_count AS (
    SELECT COUNT(DISTINCT player_id)::NUMERIC AS next_day_count
    FROM next_day_logins
)
SELECT ROUND(
    COALESCE(next_day_count.next_day_count / total_players.total_count, 0)::NUMERIC,
    2
) AS fraction
FROM total_players, next_day_count;
