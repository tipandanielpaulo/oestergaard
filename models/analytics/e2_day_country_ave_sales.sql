{{ config(schema='analytics', materialized='view') }}

WITH import_data AS (
	SELECT * FROM {{ ref("a_sales") }}
)

SELECT 
	country,
	invoice_day,
	AVG(quantity_sold) AS total_quantity_sold,
	SUM(unit_price * quantity_sold) AS total_price

FROM import_data
GROUP BY country,invoice_day

ORDER BY country, invoice_day

