{% snapshot customer_snapshot %}

{{
    config(
        target_schema='intermediate',
        unique_key='c_custkey',
        strategy='timestamp',
        updated_at='c_updated'
    )
}}

select
    c_custkey,
    c_name,
    c_address,
    c_nationkey,
    c_phone,
    c_acctbal,
    c_mktsegment,
    c_comment,
    c_updated
from {{ source('retail_raw', 'customer') }}

{% endsnapshot %}