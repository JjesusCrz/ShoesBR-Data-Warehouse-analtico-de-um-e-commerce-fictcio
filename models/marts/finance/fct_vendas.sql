WITH vendas AS (

    SELECT

        purchase_id,
        customer_id,
        product_id,
        purchase_date,
        quantity,
        total_price,
        payment_method,
        refund_amount,
        refund_reason

    FROM {{ ref('int_vendas') }}

),

clientes AS (

    SELECT

        customer_id,
        customer_name,
        customer_email

    FROM {{ ref('int_clientes') }}

),

produtos AS (

    SELECT

        product_id,
        product_name,
        product_price

    FROM {{ ref('int_produtos') }}

)

SELECT

    v.purchase_id,
    v.customer_id,
    c.customer_name,
    c.customer_email,

    v.product_id,
    p.product_name,
    p.product_price,

    v.purchase_date,
    v.quantity,
    v.total_price,
    v.payment_method,

    v.refund_amount,
    v.refund_reason,

    (v.total_price - v.refund_amount) AS net_revenue

FROM vendas v

LEFT JOIN clientes c
    ON v.customer_id = c.customer_id

LEFT JOIN produtos p
    ON v.product_id = p.product_id