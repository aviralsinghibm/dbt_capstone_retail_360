select
    o.o_orderkey as order_key,
    o.o_custkey as customer_key,
    o.o_orderstatus as order_status,
    o.o_totalprice as total_price,
    o.o_orderdate as order_date,
    o.o_orderpriority as order_priority,
    o.o_clerk as clerk,
    o.o_shippriority as ship_priority,
    o.o_comment as comment,
    count(li.l_linenumber) as total_line_items,
    coalesce(sum(li.l_quantity), 0) as total_quantity
from {{ ref('stg_orders') }} o
left join {{ ref('stg_lineitem') }} li
    on o.o_orderkey = li.l_orderkey
group by
    o.o_orderkey,
    o.o_custkey,
    o.o_orderstatus,
    o.o_totalprice,
    o.o_orderdate,
    o.o_orderpriority,
    o.o_clerk,
    o.o_shippriority,
    o.o_comment