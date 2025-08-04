/* https://www.interviewmaster.ai/chat/228de54c-c8fa-4a13-9f4f-be749cf969b4

1. Can you find the average price of items listed in each category on Facebook Marketplace? We want to understand the pricing trends across different categories.
Tables
Listings(listing_id, category, price, city, user_id)  */

SELECT
  category,
  ROUND(AVG(price),2) AS avg_price
FROM Listings
GROUP BY category;

/* 2. Which city has the lowest average price? This will help us identify the most affordable cities for buyers.
Tables
Listings(listing_id, category, price, city, user_id) */

 SELECT
  city,
  ROUND(AVG(price),2) AS avg_price
FROM Listings
GROUP BY city 
ORDER BY avg_price
LIMIT 1;
