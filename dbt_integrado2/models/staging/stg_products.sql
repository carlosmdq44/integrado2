with source as (
    select * from {{ source('raw', 'products') }}
)
select
    product_id,
    product_name,
    category_id,
    price
from source