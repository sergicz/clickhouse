{{
    config (
	engine='MergeTree()',
	order_by='C_CUSTKEY'
    )
}}

select
    {{ dbt_utils.star(source('dbgen','customer')) }}
from {{ source('dbgen','customer') }}