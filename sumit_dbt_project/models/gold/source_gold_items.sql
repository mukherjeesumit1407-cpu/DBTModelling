WITH dedup_query AS 
(SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY updatedate DESC) as rk 
FROM 
    {{ source('source','items') }}
)

SELECT 
    id, name, category, updatedate
FROM 
    dedup_query
WHERE rk = 1 