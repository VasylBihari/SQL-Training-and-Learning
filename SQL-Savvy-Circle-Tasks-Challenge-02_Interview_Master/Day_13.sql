/*What percentage of users have at least one skill endorsed by others during July 2024?
Tables
fct_skill_endorsements(endorsement_id, user_id, skill_id, endorsement_date)
dim_skills(skill_id, skill_name, skill_category)
dim_users(user_id, user_name, profile_creation_date)*/

WITH users_july AS (
  SELECT
    COUNT(DISTINCT(user_id)) AS count_july
  FROM fct_skill_endorsements f
  WHERE endorsement_date BETWEEN '2024-07-01' AND '2024-07-31'
  ),
  total_users AS (
  SELECT
    COUNT(DISTINCT(user_id)) AS total_count
  FROM dim_users d
  )
  SELECT
    ROUND(u.count_july * 100.0 / t.total_count, 2) AS percentage_july
  FROM users_july u
 CROSS JOIN total_users t

/*What is the average number of endorsements received per user for skills categorized as 'TECHNICAL' during August 2024?
Tables
fct_skill_endorsements(endorsement_id, user_id, skill_id, endorsement_date)
dim_skills(skill_id, skill_name, skill_category)
dim_users(user_id, user_name, profile_creation_date)*/

WITH table_count_endorsement AS(
  SELECT
  COUNT(*) AS count_end
  FROM fct_skill_endorsements f
  LEFT JOIN dim_skills d ON f.skill_id=d.skill_id
  WHERE endorsement_date BETWEEN '2024-08-01' AND '2024-08-31'
  AND skill_category = 'TECHNICAL'
)
  SELECT
  t.count_end/(SELECT DISTINCT(COUNT(*)) FROM dim_users)::FLOAT AS user_to_endorsement_ratio
FROM table_count_endorsement t

/*For the MANAGEMENT skill category, what percentage of users who have ever received an endorsement for that skill received at least one endorsement in September 2024?
Tables
fct_skill_endorsements(endorsement_id, user_id, skill_id, endorsement_date)
dim_skills(skill_id, skill_name, skill_category)
dim_users(user_id, user_name, profile_creation_date)*/

WITH total_users AS (
  SELECT
    COUNT(DISTINCT(user_id)) AS total_count
  FROM fct_skill_endorsements f
  LEFT JOIN dim_skills d ON f.skill_id=d.skill_id
  WHERE skill_category = 'MANAGEMENT'
),
  sept_users AS (
  SELECT
    COUNT(DISTINCT (user_id)) AS count_september
  FROM fct_skill_endorsements f
  LEFT JOIN dim_skills d ON f.skill_id=d.skill_id
  WHERE endorsement_date BETWEEN '2024-09-01' AND '2024-09-30'
  AND skill_category = 'MANAGEMENT'
)
  SELECT
    ROUND(s.count_september * 100.0 / t.total_count, 2) AS percentage_july
  FROM total_users t 
  CROSS JOIN sept_users s
