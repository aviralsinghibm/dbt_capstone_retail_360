select
    p.p_partkey,
    p.p_name,
    p.p_type,
    sum(ps.ps_availqty) as total_available_qty,
    count(distinct ps.ps_suppkey) as supplier_count,
    coalesce(pm.total_quantity_sold, 0) as total_quantity_sold,
    case
        when sum(ps.ps_availqty) = 0 then true
        when sum(ps.ps_availqty) <= 100 then true
        else false
    end as is_low_stock,
    case
        when coalesce(pm.total_quantity_sold, 0) >= 100 then true
        else false
    end as is_high_demand
from {{ ref('stg_part') }} p
left join {{ ref('stg_partsupp') }} ps
    on p.p_partkey = ps.ps_partkey
left join {{ ref('int_product_metrics') }} pm
    on p.p_partkey = pm.p_partkey
group by
    p.p_partkey,
    p.p_name,
    p.p_type,
    pm.total_quantity_sold