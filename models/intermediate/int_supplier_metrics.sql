with supplier_inventory as (

    select
        ps_suppkey as supplier_key,
        count(distinct ps_partkey) as products_supplied,
        sum(ps_availqty) as total_available_qty
    from {{ ref('stg_partsupp') }}
    group by ps_suppkey

),

supplier_sales as (

    select
        l_suppkey as supplier_key,
        count(distinct l_orderkey) as total_orders,
        sum(l_quantity) as total_quantity_sold,
        sum(l_extendedprice * (1 - l_discount)) as total_revenue
    from {{ ref('stg_lineitem') }}
    group by l_suppkey

)

select
    s.s_suppkey as supplier_key,
    s.s_name as supplier_name,
    s.s_nationkey as nation_key,
    coalesce(i.products_supplied, 0) as products_supplied,
    coalesce(i.total_available_qty, 0) as total_available_qty,
    coalesce(sa.total_orders, 0) as total_orders,
    coalesce(sa.total_quantity_sold, 0) as total_quantity_sold,
    coalesce(sa.total_revenue, 0) as total_revenue
from {{ ref('stg_supplier') }} s
left join supplier_inventory i
    on s.s_suppkey = i.supplier_key
left join supplier_sales sa
    on s.s_suppkey = sa.supplier_key