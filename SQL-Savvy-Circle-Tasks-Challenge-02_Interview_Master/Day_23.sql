/*How many times did users click on event recommendations for each event category in March 2024? Show the category name and the total clicks.
Tables
fct_event_clicks(click_id, user_id, event_id, click_date)
dim_events(event_id, category_name)
dim_users(user_id, first_name, last_name, preferred_category)*/

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    COUNT(f.click_id) AS total_clicks
FROM fct_event_clicks AS f
JOIN dim_users AS u 
    ON f.user_id = u.user_id
WHERE f.click_date >= '2024-03-01'
  AND f.click_date < '2024-04-01'
GROUP BY 
    u.user_id, 
    u.first_name, 
    u.last_name
ORDER BY 
    u.user_id ASC;

/*For event clicks in March 2024, identify whether each user clicked on an event in their preferred category. 
Return the user ID, event category, and a label indicating if it was a preferred category ('Yes' or 'No').
Tables
fct_event_clicks(click_id, user_id, event_id, click_date)
dim_events(event_id, category_name)
dim_users(user_id, first_name, last_name, preferred_category)*/

SELECT 
    f.user_id,
    e.category_name AS event_category,
    CASE 
        WHEN e.category_name = u.preferred_category THEN 'Yes'
        ELSE 'No'
    END AS is_preferred_category
FROM fct_event_clicks AS f
JOIN dim_events AS e 
    ON f.event_id = e.event_id
JOIN dim_users AS u 
    ON f.user_id = u.user_id
WHERE f.click_date >= '2024-03-01'
  AND f.click_date < '2024-04-01';

/*Generate a report that combines the user ID, their full name (first and last name), and the total clicks for events they interacted with in March 2024. 
Sort the report by user ID in ascending order.
Tables
fct_event_clicks(click_id, user_id, event_id, click_date)
dim_events(event_id, category_name)
dim_users(user_id, first_name, last_name, preferred_category)*/

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    COUNT(f.click_id) AS total_clicks
FROM fct_event_clicks AS f
JOIN dim_users AS u 
    ON f.user_id = u.user_id
WHERE f.click_date >= '2024-03-01'
  AND f.click_date < '2024-04-01'
GROUP BY 
    u.user_id, 
    u.first_name, 
    u.last_name
ORDER BY 
    u.user_id ASC;
