WITH produtos AS (

    SELECT

        product_id,
        product_name,
        product_price

    FROM {{ ref('int_produtos') }}

),

vendas AS (

    SELECT

        purchase_id,
        product_id,
        quantity,
        total_price,
        refund_amount

    FROM {{ ref('int_vendas') }}

)

SELECT

    p.product_id,
    p.product_name,
    p.product_price,

    COALESCE(SUM(v.quantity),0) AS total_vendido,

    COALESCE(SUM(v.total_price),0) AS total_faturado,

    COALESCE(SUM(v.refund_amount),0) AS total_estornado,

    COUNT(
        CASE
            WHEN v.refund_amount > 0 THEN 1
        END
    ) AS total_estornos

FROM produtos p

LEFT JOIN vendas v
    ON p.product_id = v.product_id

GROUP BY

    p.product_id,
    p.product_name,
    p.product_price