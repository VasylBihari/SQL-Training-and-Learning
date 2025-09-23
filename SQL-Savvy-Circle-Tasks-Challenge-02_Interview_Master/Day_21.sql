/*Retrieve the total marketing spend in each country for Q1 2024 to help inform budget distribution across regions.
Tables
fact_marketing_spend(spend_id, country_id, campaign_date, amount_spent)
fact_daily_subscriptions(subscription_id, country_id, signup_date, num_new_subscribers)
dimension_country(country_id, country_name)*/

SELECT
    d.country_name,
    SUM(f.amount_spent) AS total_sum
FROM dimension_country d 
LEFT JOIN fact_marketing_spend f ON d.country_id = f.country_id
WHERE f.campaign_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY d.country_name

/*List the number of new subscribers acquired in each country (with name) during January 2024, renaming the subscriber count column to 'new_subscribers' for clearer reporting purposes.
Tables
fact_marketing_spend(spend_id, country_id, campaign_date, amount_spent)
fact_daily_subscriptions(subscription_id, country_id, signup_date, num_new_subscribers)
dimension_country(country_id, country_name)*/

SELECT
  country_name,
  SUM(num_new_subscribers) AS new_subscribers
FROM dimension_country d
LEFT JOIN fact_daily_subscriptions f ON d.country_id=f.country_id
WHERE signup_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY country_name

/*Determine the average marketing spend per new subscriber for each country in Q1 2024 by rounding up to the nearest whole number to evaluate campaign efficiency.
Tables
fact_marketing_spend(spend_id, country_id, campaign_date, amount_spent)
fact_daily_subscriptions(subscription_id, country_id, signup_date, num_new_subscribers)
dimension_country(country_id, country_name)*/

WITH aggregated_data AS (
    SELECT 
        d.country_name AS country,
        SUM(s.amount_spent) AS total_spent,
        SUM(f.num_new_subscribers) AS total_num_subscr
    FROM dimension_country d
    LEFT JOIN fact_marketing_spend s 
        ON d.country_id = s.country_id 
        AND s.campaign_date BETWEEN '2024-01-01' AND '2024-03-31'
    LEFT JOIN fact_daily_subscriptions f 
        ON d.country_id = f.country_id 
        AND f.signup_date BETWEEN '2024-01-01' AND '2024-03-31'
    GROUP BY d.country_name
)
SELECT 
    country,
    CEIL(COALESCE(total_spent / NULLIF(total_num_subscr, 0), 0)) AS average_by_country
FROM aggregated_data
