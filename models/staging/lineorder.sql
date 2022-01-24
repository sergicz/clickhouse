{{
    config (
	engine='MergeTree()',
	order_by='LO_ORDERKEY'
    )
}}

select
    {{ dbt_utils.star(source('dbgen','lineorder')) }}
from {{ source('dbgen','lineorder') }}