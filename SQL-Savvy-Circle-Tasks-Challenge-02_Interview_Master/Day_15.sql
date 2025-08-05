/*How many total ad impressions did we receive from custom audience segments in October 2024?
Tables
ad_performance(ad_id, audience_segment_id, impressions, conversions, ad_spend, date)
audience_segments(audience_segment_id, segment_name)*/

SELECT
  SUM(impressions) AS total_ad_impressions 
FROM ad_performance p
INNER JOIN audience_segments s ON p.audience_segment_id=s.audience_segment_id
WHERE date BETWEEN '2024-10-01'AND '2024-10-31'

/*What is the total number of conversions we achieved from each custom audience segment in October 2024?
Tables
ad_performance(ad_id, audience_segment_id, impressions, conversions, ad_spend, date)
audience_segments(audience_segment_id, segment_name)*/

SELECT
  s.segment_name,
  SUM(conversions) AS total_conversions
FROM ad_performance p
INNER JOIN audience_segments s ON p.audience_segment_id=s.audience_segment_id
WHERE date BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY s.segment_name

/*For each custom audience or lookalike segment, calculate the cost per conversion. Only return this for segments that had non-zero spend and non-zero conversions.
Cost per conversion = Total ad spend / Total number of conversions
Tables
ad_performance(ad_id, audience_segment_id, impressions, conversions, ad_spend, date)
audience_segments(audience_segment_id, segment_name)*/

WITH ad_spend_table AS (
  SELECT
  audience_segment_id,
  SUM(ad_spend) AS sum_ad
  FROM ad_performance
  WHERE ad_spend IS NOT NULL
  GROUP BY audience_segment_id
),
  number_convers_table AS (
  SELECT 
  audience_segment_id,
  SUM(conversions) AS sum_convers
  FROM ad_performance
  WHERE conversions IS NOT NULL
  GROUP BY audience_segment_id
  )
SELECT 
  s.audience_segment_id,
  sum_ad/sum_convers AS Cost_per_conversion
FROM ad_spend_table s
INNER JOIN number_convers_table n ON s.audience_segment_id=n.audience_segment_id
WHERE sum_ad != 0 AND sum_convers != 0
GROUP BY s.audience_segment_id, s.sum_ad, n.sum_convers
