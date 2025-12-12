/*At the winter market, Cindy Lou is browsing the clothing inventory and wants to find all items with "sweater" in their name. 
But the challenge is the color and item columns have inconsistent capitalization. Can you write a query to return only the sweater names and their cleaned-up colors.
Tables
winter_clothing(item_id, item_name, color)*/

SELECT
    item_name,
    INITCAP(color) AS cleaned_color
FROM winter_clothing
WHERE item_name ILIKE '%sweater%'
