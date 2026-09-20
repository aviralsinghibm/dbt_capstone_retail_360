select
    p.p_partkey,
    p.p_name,
    p.p_type,
    p.p_retailprice,
    count(li.l_orderkey) as total_order_lines,
    coalesce(sum(li.l_quantity), 0) as total_quantity_sold,
    coalesce(sum(li.l_extendedprice), 0) as gross_revenue,
    coalesce(sum(li.l_extendedprice * (1 - li.l_discount)), 0) as net_revenue,
    avg(li.l_discount) as avg_discount,
    max(li.l_shipdate) as last_ship_date
from {{ ref('stg_part') }} p
left join {{ ref('stg_lineitem') }} li
    on p.p_partkey = li.l_partkey
group by
    p.p_partkey,
    p.p_name,
    p.p_type,
    p.p_retailprice