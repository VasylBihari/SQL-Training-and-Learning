/*As the New Year begins, the goals tracker team wants to understand how user types differ. 
How many completed goals does the average user have in each user_type?

Tables
user_goals(user_id, user_type, goal_id, goal_status)*/

WITH completed_goals_table AS (
    SELECT
        user_id,
        user_type,
        COUNT(goal_id) AS completed_goals
    FROM user_goals
    WHERE goal_status = 'completed'
    GROUP BY user_id, user_type
)
SELECT
    user_type,
    AVG(completed_goals) AS avg_completed_goals
FROM completed_goals_table
GROUP BY user_type;
