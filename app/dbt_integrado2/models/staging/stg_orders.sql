with source as (
    select * from {{ source('raw', 'orders') }}
)
select
    order_id,
    customer_id,
    order_date,
    status
from source