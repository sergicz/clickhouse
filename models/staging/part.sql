{{
    config (
	engine='MergeTree()',
	order_by='P_PARTKEY'
    )
}}

select
    {{ dbt_utils.star(source('dbgen','part')) }}
from {{ source('dbgen','part') }}