{{ config(schema='intermediate', materialized='ephemeral') }}

/*
I noticed that there are some "checks" or maybe test values that have the unit price 0. So, needed to remove them.

Also, for cancellations (C% in invoice number) I can't correlate how they cancel the order or where to subtract them. So, it's safe to just remove and focus on sales
*/

WITH import_data AS (
    SELECT * FROM {{ ref("s_kaggle_data") }}
),

final AS (
    SELECT
        *
    FROM
        import_data
    WHERE
        unit_price != 0
        AND invoice_number NOT LIKE 'C%'
)

SELECT * FROM final
