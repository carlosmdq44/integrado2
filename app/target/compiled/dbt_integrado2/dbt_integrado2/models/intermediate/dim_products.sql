
  
  
  
  
    
  
    
      
    
  
    
      
    
  
    
      
    
  

  with source as (
      select * from "ecommerce"."raw"."stg_products"
  ),
  latest as (
      select
          *,
          row_number() over (partition by product_id order by created_at desc) as rn
      from source
  )
  select
      product_id,
      created_at,
      product_name,
      category_id,
      price,
      'Y' as current_flag
  from latest
  where rn = 1
