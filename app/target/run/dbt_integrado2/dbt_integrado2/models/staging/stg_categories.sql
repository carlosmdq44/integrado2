
  create view "ecommerce"."raw"."stg_categories__dbt_tmp"
    
    
  as (
    with source as (
    select * from "ecommerce"."raw"."categories"
)
select
    category_id,
    category_name
from source
  );