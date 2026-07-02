WITH source AS (

    SELECT *
    FROM {{ source('landing', 'produtos') }}

),

renamed AS (

    SELECT

        CAST(product_id AS INT) AS product_id,
        name AS product_name,
        CAST(price AS NUMERIC(10,2)) AS product_price

    FROM source

)

SELECT

    product_id,
    product_name,
    product_price

FROM renamed