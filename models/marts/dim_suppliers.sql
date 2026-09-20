select
    m.supplier_key,
    m.supplier_name,
    m.nation_key,
    n.nation_name,
    n.region_key,
    n.region_name,
    s.s_address as address,
    s.s_phone as phone,
    s.s_acctbal as account_balance,
    m.products_supplied,
    m.total_available_qty,
    m.total_orders,
    m.total_quantity_sold,
    m.total_revenue,
    s.s_comment as comment
from {{ ref('int_supplier_metrics') }} m
left join {{ ref('stg_supplier') }} s
    on m.supplier_key = s.s_suppkey
left join {{ ref('dim_nation') }} n
    on m.nation_key = n.nation_key