{{ config(materialized='view') }}
{{ config(schema='bronze_view') }}

SELECT 
* 
FROM 
    {{ source('source','fact_sales')}}