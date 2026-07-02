WITH estornos AS (

    SELECT

        purchase_id,
        customer_id,
        product_id,
        refund_date,
        refund_reason,
        refund_amount

    FROM {{ ref('stg_estorno') }}

)

SELECT

    purchase_id,
    customer_id,
    product_id,
    refund_date,
    refund_reason,
    refund_amount

FROM estornos