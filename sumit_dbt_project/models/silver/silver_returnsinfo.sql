WITH returns_raw AS (
    SELECT sales_id, store_sk, product_sk, returned_qty, return_reason, refund_amount
    FROM {{ ref("bronze_returns") }}
), 

prod AS (SELECT product_sk, category FROM {{ ref("bronze_prod") }} ), 
store AS (SELECT store_sk, store_name FROM {{ ref("bronze_store") }} )

SELECT 
    returns_raw.sales_id, 
    returns_raw.returned_qty, 
    returns_raw.return_reason, 
    returns_raw.refund_amount, 
    prod.category,
    store.store_name 
FROM returns_raw JOIN prod ON returns_raw.product_sk = prod.product_sk
JOIN store ON returns_raw.store_sk = store.store_sk