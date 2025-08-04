/*The marketplace team wants to identify high and low performing app categories. Provide the total downloads for the app categories for November 2024. 
If there were no downloads for that category, return the value as 0.
Tables
dim_app(app_id, app_name, category, app_type)
fct_app_browsing(app_id, browse_date, browse_count)
fct_app_downloads(app_id, download_date, download_count)*/

SELECT
  d.category,
  COALESCE(SUM(download_count),0) AS total_downloads
FROM dim_app d
LEFT JOIN fct_app_downloads f ON d.app_id=f.app_id 
AND f.download_date BETWEEN '2024-11-01' AND '2024-11-30'
GROUP BY d.category
ORDER BY total_downloads DESC;

/*Our team's goal is download conversion rate -- defined as downloads per browse event. 
For each app category, calculate the download conversion rate in December, removing categories where browsing counts are be zero.
Tables
dim_app(app_id, app_name, category, app_type)
fct_app_browsing(app_id, browse_date, browse_count)
fct_app_downloads(app_id, download_date, download_count)*/

WITH browsing_agg AS (
    SELECT
        app_id,
        SUM(browse_count) AS total_browse_count
    FROM fct_app_browsing
    WHERE browse_date BETWEEN '2024-12-01' AND '2024-12-31'
    GROUP BY app_id
),
downloads_agg AS (
    SELECT
        app_id,
        SUM(download_count) AS total_download_count
    FROM fct_app_downloads
    WHERE download_date BETWEEN '2024-12-01' AND '2024-12-31'
    GROUP BY app_id
)
SELECT
    da.category,
    ROUND(COALESCE(SUM(da_agg.total_download_count), 0)::NUMERIC / SUM(ba.total_browse_count), 2) AS download_conversion_rate
FROM dim_app da
LEFT JOIN browsing_agg ba ON da.app_id = ba.app_id
LEFT JOIN downloads_agg da_agg ON da.app_id = da_agg.app_id
GROUP BY da.category
HAVING SUM(ba.total_browse_count) > 0
ORDER BY download_conversion_rate DESC;

/*The team wants to compare conversion rates between free and premium apps across all categories. 
Combine the conversion data for both app types to present a unified view for Q4 2024.
Tables
dim_app(app_id, app_name, category, app_type)
fct_app_browsing(app_id, browse_date, browse_count)
fct_app_downloads(app_id, download_date, download_count)*/

WITH browsing_agg AS (
    SELECT
        app_id,
        SUM(browse_count) AS total_browse_count
    FROM fct_app_browsing
    WHERE browse_date BETWEEN '2024-10-01' AND '2024-12-31'
    GROUP BY app_id
),
downloads_agg AS (
    SELECT
        app_id,
        SUM(download_count) AS total_download_count
    FROM fct_app_downloads
    WHERE download_date BETWEEN '2024-10-01' AND '2024-12-31'
    GROUP BY app_id
)
SELECT
    da.category,
    da.app_type,
    ROUND(COALESCE(SUM(da_agg.total_download_count), 0)::NUMERIC / SUM(ba.total_browse_count), 2) AS download_conversion_rate
FROM dim_app da
LEFT JOIN browsing_agg ba ON da.app_id = ba.app_id
LEFT JOIN downloads_agg da_agg ON da.app_id = da_agg.app_id
GROUP BY da.category, da.app_type
HAVING SUM(ba.total_browse_count) > 0
ORDER BY da.category, da.app_type;
