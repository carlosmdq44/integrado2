with source as (
    select * from {{ source('raw', 'categories') }}
)
select
    category_id,
    category_name
from source