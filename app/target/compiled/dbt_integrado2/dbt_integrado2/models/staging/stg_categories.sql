with source as (
    select * from "ecommerce"."raw"."categories"
)
select
    category_id,
    category_name
from source