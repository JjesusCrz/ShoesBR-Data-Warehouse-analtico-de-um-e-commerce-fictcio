WITH clientes AS (

    SELECT

        customer_id,
        customer_name,
        customer_email,
        customer_phone,
        customer_address

    FROM {{ ref('int_clientes') }}

),

vendas AS (

    SELECT

        purchase_id,
        customer_id,
        product_id,
        total_price,
        refund_amount

    FROM {{ ref('int_vendas') }}

)

SELECT

    c.customer_id,
    c.customer_name,
    c.customer_email,
    c.customer_phone,
    c.customer_address,

    COALESCE(SUM(v.total_price),0) AS total_gasto,

    COUNT(v.purchase_id) AS total_compras,

    COUNT(DISTINCT v.product_id) AS diversidade_produtos,

    COUNT(
        CASE
            WHEN v.refund_amount > 0 THEN 1
        END
    ) AS total_estornos

FROM clientes c

LEFT JOIN vendas v
    ON c.customer_id = v.customer_id

GROUP BY

    c.customer_id,
    c.customer_name,
    c.customer_email,
    c.customer_phone,
    c.customer_address