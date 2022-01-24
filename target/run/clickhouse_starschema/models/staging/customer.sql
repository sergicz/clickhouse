

  create view db.customer__dbt_tmp 
  
  as (
    

select
    C_CUSTKEY,
  C_NAME,
  C_ADDRESS,
  C_CITY,
  C_NATION,
  C_REGION,
  C_PHONE,
  C_MKTSEGMENT
from db.src_customer
  )