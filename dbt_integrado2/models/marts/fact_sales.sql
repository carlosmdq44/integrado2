select
    i.order_id,
    i.product_id,
    p.product_name,
    o.customer_id,
    c.customer_name,
    o.order_date,
    i.quantity,
    i.item_price,
    i.total_price
from {{ ref('int_sales') }} i
join {{ ref('dim_products') }} p on i.product_id = p.product_id
join {{ ref('dim_customers') }} c on c.customer_id = o.customer_id
join {{ ref('stg_orders') }} o on i.order_id = o.order_id