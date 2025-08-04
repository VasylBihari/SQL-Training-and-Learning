/*https://www.interviewmaster.ai/chat/da4aabfb-e9b0-4d66-a0a8-2e773203b446

1. Identify the first 3 subscription tiers in alphabetical order. Don't forget to remove duplicate values. This query will help us understand what values are in the tier_name column.
Tables
fct_subscriptions(subscription_id, customer_id, tier_name, start_date, end_date)*/

SELECT 
  DISTINCT(tier_name)
FROM fct_subscriptions
ORDER BY tier_name 
LIMIT 3;

/* 2.Determine how many customers canceled their subscriptions in August 2024 for tiers labeled ''Basic'' or ''Premium''. This query is used to evaluate cancellation trends for these specific subscription levels.
Tables
fct_subscriptions(subscription_id, customer_id, tier_name, start_date, end_date)*/

SELECT
  COUNT(DISTINCT(customer_id))
FROM fct_subscriptions
WHERE end_date BETWEEN '2024-08-01' AND '2024-08-31'
AND (tier_name = 'Basic' OR tier_name = 'Premium');

/* 3.Find the subscription tier with the highest number of cancellations during Quarter 3 2024 (July 2024 through September 2024). This query will guide retention strategies by identifying the tier with the most significant dropout case.
Tables
fct_subscriptions(subscription_id, customer_id, tier_name, start_date, end_date)*/

SELECT
  tier_name,
  COUNT(customer_id)
FROM fct_subscriptions
WHERE end_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY tier_name
ORDER BY COUNT(customer_id) DESC
LIMIT 1;
