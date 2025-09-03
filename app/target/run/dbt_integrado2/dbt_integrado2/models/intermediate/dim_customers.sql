
  
    

  create  table "ecommerce"."raw"."dim_customers__dbt_tmp"
  
  
    as
  
  (
    
  
  
  
  
    
  
    
      
    
  
    
      
    
  
    
  

  with source as (
      select * from "ecommerce"."raw"."stg_customers"
  ),
  latest as (
      select
          *,
          row_number() over (partition by customer_id order by created_at desc) as rn
      from source
  )
  select
      customer_id,
      created_at,
      customer_name,
      email,
      'Y' as current_flag
  from latest
  where rn = 1

  );
  