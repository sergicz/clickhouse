

  create view db.part__dbt_tmp 
  
  as (
    

select
    P_PARTKEY,
  P_NAME,
  P_MFGR,
  P_CATEGORY,
  P_BRAND,
  P_COLOR,
  P_TYPE,
  P_SIZE,
  P_CONTAINER
from db.src_part
  )