

  create view db.supplier__dbt_tmp 
  
  as (
    

select
    S_SUPPKEY,
  S_NAME,
  S_ADDRESS,
  S_CITY,
  S_NATION,
  S_REGION,
  S_PHONE
from db.src_supplier
  )