select
    c.c_custkey,
    c.c_name,
    c.c_mktsegment,
    count(o.o_orderkey) as total_orders,
    coalesce(sum(o.o_totalprice), 0) as total_spend,
    max(o.o_orderdate) as last_order_date,
    min(o.o_orderdate) as first_order_date,
    count_if(o.o_orderstatus = 'F') as completed_orders,
    count_if(o.o_orderstatus = 'O') as open_orders,
    count_if(o.o_orderstatus = 'P') as pending_orders
from {{ ref('stg_customer') }} c
left join {{ ref('stg_orders') }} o
    on c.c_custkey = o.o_custkey
group by
    c.c_custkey,
    c.c_name,
    c.c_mktsegment