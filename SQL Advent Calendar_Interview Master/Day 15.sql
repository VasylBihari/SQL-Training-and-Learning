/*The Grinch is tracking his daily mischief scores to see how his behavior changes over time. 
Can you find how many points his score increased or decreased each day compared to the previous day?
Tables
grinch_mischief_log(log_date, mischief_score)*/

SELECT
    log_date,
    mischief_score,
    LAG(mischief_score) OVER (ORDER BY log_date) AS prev_revenue,
    mischief_score - LAG(mischief_score) OVER (ORDER BY log_date) AS diff
FROM grinch_mischief_log
