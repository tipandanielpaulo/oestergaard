{{ config(schema='analytics', materialized='view') }}


WITH import_data AS (
	SELECT * FROM {{ ref("a_sales") }}
),

get_highest AS (
	SELECT 
		country,
		stock_code,
		MIN(item_desc) AS item_desc,
		SUM(quantity_sold) AS total_quantity_sold,
		SUM(unit_price * quantity_sold) AS total_price
	
	FROM import_data
	GROUP BY country,stock_code
	
	-- This gets the top sales per country
	QUALIFY row_number() OVER (PARTITION BY country ORDER BY total_quantity_sold DESC) = 1
	
)
SELECT * FROM get_highest

ORDER BY country