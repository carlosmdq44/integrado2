with source as (
    select * from "ecommerce"."raw"."order_items"
)
select
    order_item_id,
    order_id,
    product_id,
    quantity,
    item_price
from source