WITH source AS (

    SELECT *
    FROM {{ source('landing', 'estorno') }}

),

renamed AS (

    SELECT

        CAST(purchase_id AS INT) AS purchase_id,
        CAST(customer_id AS INT) AS customer_id,
        CAST(product_id AS INT) AS product_id,
        CAST(refund_date AS DATE) AS refund_date,
        refund_reason,
        CAST(refund_amount AS NUMERIC(10,2)) AS refund_amount

    FROM source

)

SELECT

    purchase_id,
    customer_id,
    product_id,
    refund_date,
    refund_reason,
    refund_amount

FROM renamed