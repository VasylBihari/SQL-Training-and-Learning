/* We need to know who our most active suppliers are. Identify the top 5 suppliers based on the total volume of components delivered in October 2024.
Tables
supplier_deliveries(supplier_id, delivery_date, component_count, manufacturing_region)
suppliers(supplier_id, supplier_name)*/

SELECT 
  DISTINCT(p.supplier_name)
FROM suppliers p
LEFT JOIN supplier_deliveries s ON s.supplier_id=p.supplier_id
WHERE p.supplier_id NOT IN (SELECT
  supplier_id
FROM supplier_deliveries s
WHERE delivery_date BETWEEN '2024-12-01' AND '2024-12-31'
      AND manufacturing_region = 'Asia'
GROUP BY supplier_id)

/*For each region, find the supplier ID that delivered the highest number of components in November 2024. This will help us understand which supplier is handling the most volume per market.
Tables
supplier_deliveries(supplier_id, delivery_date, component_count, manufacturing_region)
suppliers(supplier_id, supplier_name)*/

SELECT 
  manufacturing_region,
  supplier_id, 
  SUM(component_count) as total_sales
FROM supplier_deliveries
  WHERE delivery_date BETWEEN '2024-11-01' AND '2024-11-30'
GROUP BY manufacturing_region, supplier_id
HAVING SUM(component_count) = (
    SELECT MAX(total_sales)
    FROM (
        SELECT manufacturing_region, 
        SUM(component_count) as total_sales
        FROM supplier_deliveries
        WHERE delivery_date BETWEEN '2024-11-01' AND '2024-11-30'
        GROUP BY manufacturing_region, supplier_id
    ) sub
    WHERE sub.manufacturing_region = supplier_deliveries.manufacturing_region
);

/*We need to identify potential gaps in our supply chain for Asia. List all suppliers by name who have not delivered any components to the 'Asia' manufacturing region in December 2024.
Tables
supplier_deliveries(supplier_id, delivery_date, component_count, manufacturing_region)
suppliers(supplier_id, supplier_name)*/

SELECT 
  DISTINCT(p.supplier_name)
FROM suppliers p
LEFT JOIN supplier_deliveries s ON s.supplier_id=p.supplier_id
WHERE p.supplier_id NOT IN (SELECT
  supplier_id
FROM supplier_deliveries s
WHERE delivery_date BETWEEN '2024-12-01' AND '2024-12-31'
      AND manufacturing_region = 'Asia'
GROUP BY supplier_id)
