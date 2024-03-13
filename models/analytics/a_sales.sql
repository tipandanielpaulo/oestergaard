{{ config(schema='analytics', materialized='table') }}

WITH import_data AS (
    SELECT * FROM {{ ref("i_sales__dedup") }}
),

final AS (
    SELECT
        invoice_date,
        strftime(invoice_date, '%Y-%m-%d') AS invoice_day,
        strftime(invoice_date, '%Y') AS invoice_year,
        country,
        invoice_number,
        stock_code,
        item_desc,
        customer_id,
        unit_price,
        quantity_sold,
        unit_price * quantity_sold AS total_quantity_price
    FROM
        import_data
)

SELECT * FROM final
