{{ config(schema='staging', materialized='view') }}

WITH import_data AS (
    SELECT * FROM {{ source("kaggle_data", "l_ecommerce_data") }}
),

type_casting AS (
    SELECT
        InvoiceNo :: VARCHAR AS invoice_number,  -- contains C% for discount | not a primary key (multiple items)
		StockCode :: VARCHAR AS stock_code, 
		Description :: VARCHAR AS item_desc, 
		Quantity :: BIGINT AS quantity_sold, 
		InvoiceDate :: DATETIME AS invoice_date, 
		UnitPrice :: FLOAT AS unit_price, 
		CustomerID :: INT AS customer_id,  -- can be null
		Country :: VARCHAR AS country
    FROM
        import_data
)

SELECT * FROM type_casting
