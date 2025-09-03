with source as (
    select * from "ecommerce"."raw"."customers"
)
select
    customer_id,
    customer_name,
    email,
    created_at
from source