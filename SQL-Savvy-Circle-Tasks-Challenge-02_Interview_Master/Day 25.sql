/*For each seller, please identify their top sale transaction in April 2024 based on sale amount. 
If there are multiple transactions with the same sale amount, select the one with the most recent sale_date.
Tables
fct_seller_sales(sale_id, seller_id, sale_amount, fee_amount_percentage, sale_date)
dim_seller(seller_id, seller_name)*/

SELECT
    sale_date,
    seller_id,
    COUNT(sale_amount) OVER (PARTITION BY seller_id
        ORDER BY sale_date
    ) AS running_total
FROM fct_seller_sales
WHERE sale_date BETWEEN '2024-06-01' AND '2024-06-30'

/*Within May 2024, for each seller ID, please generate a weekly summary that reports the total number of sales transactions and shows the fee amount from the most recent sale in that week. 
This analysis will let us correlate fee changes with weekly seller performance trends.
Tables
fct_seller_sales(sale_id, seller_id, sale_amount, fee_amount_percentage, sale_date)
dim_seller(seller_id, seller_name)*/

WITH weekly_sales AS (
    SELECT
        date_trunc('week', sale_date)::date AS week_start,
        seller_id,
        sale_amount,
        fee_amount_percentage,
        sale_date,
        ROW_NUMBER() OVER (
            PARTITION BY date_trunc('week', sale_date), seller_id
            ORDER BY sale_date DESC
        ) AS rn
    FROM fct_seller_sales
    WHERE sale_date >= '2024-05-01'
      AND sale_date < '2024-06-01'
)
SELECT
    ws.week_start,
    ws.seller_id,
    COUNT(*) AS number_sales_transactions,
    MAX(CASE WHEN rn = 1 THEN fee_amount_percentage END) AS last_fee_percentage
FROM weekly_sales ws
GROUP BY ws.week_start, ws.seller_id
ORDER BY ws.week_start, ws.seller_id

/*Using June 2024, for each seller, create a daily report that computes a cumulative count of transactions up to that day.
Tables
fct_seller_sales(sale_id, seller_id, sale_amount, fee_amount_percentage, sale_date)
dim_seller(seller_id, seller_name)*/

SELECT
    sale_date,
    seller_id,
    COUNT(sale_amount) OVER (PARTITION BY seller_id
        ORDER BY sale_date
    ) AS running_total
FROM fct_seller_sales
WHERE sale_date BETWEEN '2024-06-01' AND '2024-06-30'
