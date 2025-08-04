/*Which AR filters have generated user interactions in July 2024? List the filters by name.
Tables
ar_filter_engagements(engagement_id, filter_id, interaction_count, engagement_date)
ar_filters(filter_id, filter_name)*/

SELECT
  DISTINCT(filter_name)
FROM ar_filters a
INNER JOIN ar_filter_engagements e ON a.filter_id=e.filter_id
WHERE e.engagement_date >= '2024-07-01' AND e.engagement_date <= '2024-07-31'

/*How many total interactions did each AR filter receive in August 2024? 
Return only filter names that received over 1000 interactions, and their respective interaction counts.
Tables
ar_filter_engagements(engagement_id, filter_id, interaction_count, engagement_date)
ar_filters(filter_id, filter_name)*/

SELECT
  f.filter_name,
  SUM(e.interaction_count) AS total_interaction
FROM ar_filters f
INNER JOIN ar_filter_engagements e ON f.filter_id=e.filter_id
WHERE engagement_date BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY f.filter_name
HAVING SUM(interaction_count) > 1000;

/*What are the top 3 AR filters with the highest number of interactions in September 2024, and how many interactions did each receive?
Tables
ar_filter_engagements(engagement_id, filter_id, interaction_count, engagement_date)
ar_filters(filter_id, filter_name)*/

SELECT
  f.filter_name,
  SUM(e.interaction_count) AS total_interactions
FROM ar_filters f
INNER JOIN ar_filter_engagements e ON f.filter_id=e.filter_id
WHERE engagement_date BETWEEN '2024-09-01' AND '2024-09-30'
GROUP BY f.filter_name
ORDER BY SUM(e.interaction_count) DESC
LIMIT 3;
