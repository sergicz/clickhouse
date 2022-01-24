{{
    config (
	engine='MergeTree()',
	order_by='S_SUPPKEY'
    )
}}

select
    {{ dbt_utils.star(source('dbgen','supplier')) }}
from {{ source('dbgen','supplier') }}