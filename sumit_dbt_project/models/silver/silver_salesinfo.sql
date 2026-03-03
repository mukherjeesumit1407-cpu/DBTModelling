WITH sales AS 
(SELECT sales_id, product_sk, customer_sk, gross_amount, payment_method, 
quantity, unit_price
 FROM {{ ref("bronze_sales") }} ),

 bronze_products AS 
 (SELECT product_sk, category
 FROM {{ ref("bronze_prod") }} ), 

customer AS 
( SELECT customer_sk, gender FROM {{ ref("bronze_cust") }}), 

final_agg AS 
( SELECT 
    sales.sales_id, 
    sales.gross_amount, 
    sales.payment_method, 
    {{ multiply('sales.unit_price','sales.quantity') }} as total_price,
    bronze_products.category, 
    customer.gender
FROM sales 
JOIN bronze_products ON sales.product_sk = bronze_products.product_sk
JOIN customer ON sales.customer_sk = customer.customer_sk ) 

SELECT 
    category, gender, sum(total_price) AS total_sales
FROM final_agg GROUP BY 1,2 ORDER BY total_sales DESC 