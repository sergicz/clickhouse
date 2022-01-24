select
      count(*) as failures,
      case when count(*) != 0
        then 'true' else 'false' end as should_warn,
      case when count(*) != 0
        then 'true' else 'false' end as should_error
    from (
      
    
    

select
    C_CUSTKEY,
    count(*) as n_records

from db.customer
where C_CUSTKEY is not null
group by C_CUSTKEY
having count(*) > 1



      
    ) dbt_internal_test