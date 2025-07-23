with orders as (
    select * from {{ ref('stg_orders') }}
),
items as (
    select * from {{ ref('stg_order_items') }}
)
select
    o.order_id,
    o.order_date,
    i.product_id,
    i.quantity,
    i.item_price,
    i.quantity * i.item_price as total_price
from orders o
join items i on o.order_id = i.order_id