{{ config(schema='analytics', materialized='view') }}

WITH import_data AS (
	SELECT * FROM {{ ref("a_sales") }}
)

SELECT 
	stock_code,
	MIN(item_desc) AS item_desc,
	SUM(quantity_sold) AS total_quantity_sold,
	SUM(unit_price * quantity_sold) AS total_price

FROM import_data
GROUP BY stock_code

ORDER BY total_quantity_sold DESC

