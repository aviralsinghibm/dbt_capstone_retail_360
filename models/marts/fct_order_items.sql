select
    li.l_orderkey as order_key,
    li.l_linenumber as line_number,
    li.l_partkey as product_key,
    li.l_suppkey as supplier_key,
    li.l_quantity as quantity,
    li.l_extendedprice as extended_price,
    li.l_discount as discount,
    li.l_tax as tax,
    li.l_returnflag as return_flag,
    li.l_linestatus as line_status,
    li.l_shipdate as ship_date,
    li.l_commitdate as commit_date,
    li.l_receiptdate as receipt_date,
    li.l_shipinstruct as ship_instructions,
    li.l_shipmode as ship_mode,
    li.l_extendedprice * (1 - li.l_discount) as net_revenue
from {{ ref('stg_lineitem') }} li