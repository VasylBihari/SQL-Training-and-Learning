/*Which users shared creative photos or videos (i.e. total sum of shares) more than 10 times in April 2024? 
This analysis will help determine which users are highly engaged in content sharing.
Tables
agg_daily_creative_shares(user_id, content_type, share_count, share_date)*/

SELECT
  user_id,
  SUM (share_count) AS total_shares
FROM agg_daily_creative_shares
WHERE 1=1
AND share_date >= '2024-04-01' AND share_date <= '2024-04-30'
GROUP BY user_id
HAVING SUM (share_count) > 10

/*What is the average number of shares for creative content by users in May 2024, among users who shared at least once? 
We want to first get the aggregated shares per user in May 2024, and then calculate the average over all the users.
Tables
agg_daily_creative_shares(user_id, content_type, share_count, share_date)*/

SELECT
  AVG(sum_shares) AS avg_shares
FROM (SELECT
  SUM(share_count) AS sum_shares
FROM agg_daily_creative_shares
WHERE share_count > 0
AND TO_CHAR(share_date,'YYYY-MM') = '2024-05'
GROUP BY user_id) AS subquery;

/*For each Instagram user who shared creative content, what is the floor value of their average daily shares during the second quarter of 2024? 
Only include users with an average of at least 5 shares per day.
Note: the agg_daily_creatives_share table is on the agg_daily_creative_shares table is at the grain of content type, user, and day. 
So make sure you're aggregating to the user-day level, before calculating the average.
Tables
agg_daily_creative_shares(user_id, content_type, share_count, share_date)*/

WITH daily_shares AS (
    SELECT user_id,
           share_date,
           SUM(share_count) AS total_daily_shares
    FROM agg_daily_creative_shares
    WHERE share_date BETWEEN '2024-04-01' AND '2024-06-30'
    GROUP BY user_id,
             share_date
)
SELECT 
    user_id,
    FLOOR(AVG(total_daily_shares)) AS floor_avg_daily_shares
FROM daily_shares
GROUP BY user_id
HAVING AVG(total_daily_shares) >= 5;
